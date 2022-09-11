local abs = math.abs
local pi = math.pi
local floor = math.floor
local ceil = math.ceil
local random = math.random
local sqrt = math.sqrt
local max = math.max
local min = math.min
local tan = math.tan
local pow = math.pow

local sign = function(x)
	return (x<0) and -1 or 1
end

function automobiles_lib.rot_to_dir(rot) -- keep rot within <-pi/2,pi/2>
	local dir = minetest.yaw_to_dir(rot.y)
	dir.y = dir.y+tan(rot.x)*vector.length(dir)
	return vector.normalize(dir)
end

function automobiles_lib.dir_to_rot(v,rot)
	rot = rot or {x=0,y=0,z=0}
	return {x = (v.x==0 and v.y==0 and v.z==0) and rot.x or math.atan2(v.y,vector.length({x=v.x,y=0,z=v.z})),
			y = (v.x==0 and v.z==0) and rot.y or minetest.dir_to_yaw(v),
			z=rot.z}
end

function automobiles_lib.pos_shift(pos,vec) -- vec components can be omitted e.g. vec={y=1}
	vec.x=vec.x or 0
	vec.y=vec.y or 0
	vec.z=vec.z or 0
	return {x=pos.x+vec.x,
			y=pos.y+vec.y,
			z=pos.z+vec.z}
end

function automobiles_lib.get_stand_pos(thing)	-- thing can be luaentity or objectref.
	local pos = {}
	local colbox = {}
	if type(thing) == 'table' then
		pos = thing.object:get_pos()
		colbox = thing.object:get_properties().collisionbox
	elseif type(thing) == 'userdata' then
		pos = thing:get_pos()
		colbox = thing:get_properties().collisionbox
	else 
		return false
	end
	return automobiles_lib.pos_shift(pos,{y=colbox[2]+0.01}), pos
end

function automobiles_lib.get_node_pos(pos)
	return  {
			x=floor(pos.x+0.5),
			y=floor(pos.y+0.5),
			z=floor(pos.z+0.5),
			}
end

function automobiles_lib.nodeatpos(pos)
	local node = minetest.get_node_or_nil(pos)
	if node then return minetest.registered_nodes[node.name] end
end

function automobiles_lib.minmax(v,m)
	return min(abs(v),m)*sign(v)
end

function automobiles_lib.set_acceleration(thing,vec,limit)
	limit = limit or 100
	if type(thing) == 'table' then thing=thing.object end
	vec.x=automobiles_lib.minmax(vec.x,limit)
	vec.y=automobiles_lib.minmax(vec.y,limit)
	vec.z=automobiles_lib.minmax(vec.z,limit)
	
	thing:set_acceleration(vec)
end

function automobiles_lib.actfunc(self, staticdata, dtime_s)

	self.logic = self.logic or self.brainfunc
	self.physics = self.physics or automobiles_lib.physics
	
	self.lqueue = {}
	self.hqueue = {}
	self.nearby_objects = {}
	self.nearby_players = {}
	self.pos_history = {}
	self.path_dir = 1
	self.time_total = 0
	self.water_drag = self.water_drag or 1

	local sdata = minetest.deserialize(staticdata)
	if sdata then 
		for k,v in pairs(sdata) do
			self[k] = v
		end
	end
	
	if self.textures==nil then
		local prop_tex = self.object:get_properties().textures
		if prop_tex then self.textures=prop_tex end
	end
	
	if not self.memory then 		-- this is the initial activation
		self.memory = {} 
		
		-- texture variation
		if #self.textures > 1 then self.texture_no = random(#self.textures) end
	end
	
	if self.timeout and ((self.timeout>0 and dtime_s > self.timeout and next(self.memory)==nil) or
	                     (self.timeout<0 and dtime_s > abs(self.timeout))) then
		self.object:remove()
	end
	
	-- apply texture
	if self.textures and self.texture_no then
		local props = {}
		props.textures = {self.textures[self.texture_no]}
		self.object:set_properties(props)
	end

--hp
	self.max_hp = self.max_hp or 10
	self.hp = self.hp or self.max_hp
--armor
	if type(self.armor_groups) ~= 'table' then
		self.armor_groups={}
	end
	self.armor_groups.immortal = 1
	self.object:set_armor_groups(self.armor_groups)
	
	self.buoyancy = self.buoyancy or 0
	self.oxygen = self.oxygen or self.lung_capacity
	self.lastvelocity = {x=0,y=0,z=0}
end

function automobiles_lib.get_box_height(self)
	if type(self) == 'table' then self = self.object end
	local colbox = self:get_properties().collisionbox
	local height = 0.1
	if colbox then height = colbox[5]-colbox[2] end
	
	return height > 0 and height or 0.1
end

function automobiles_lib.stepfunc(self,dtime,colinfo)
	self.dtime = min(dtime,0.2)
	self.colinfo = colinfo
	self.height = automobiles_lib.get_box_height(self)
	
--  physics comes first
	local vel = self.object:get_velocity()
	
	if colinfo then 
		self.isonground = colinfo.touching_ground
	else
		if self.lastvelocity.y==0 and vel.y==0 then
			self.isonground = true
		else
			self.isonground = false
		end
	end
	
	self:physics()

	if self.logic then
		if self.view_range then self:sensefunc() end
		self:logic()
		execute_queues(self)
	end
	
	self.lastvelocity = self.object:get_velocity()
	self.time_total=self.time_total+self.dtime
end
