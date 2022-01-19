local min = math.min
local abs = math.abs

function automobiles_lib.physics(self)
    local friction = 0.99
	local vel=self.object:get_velocity()
		-- dumb friction
	if self.isonground and not self.isinliquid then
        --minetest.chat_send_all('okay')
		self.object:set_velocity({x=vel.x*friction,
								y=vel.y,
								z=vel.z*friction})
	end
	
	-- bounciness
	if self.springiness and self.springiness > 0 then
		local vnew = vector.new(vel)
		
		if not self.collided then						-- ugly workaround for inconsistent collisions
			for _,k in ipairs({'y','z','x'}) do
				if vel[k]==0 and abs(self.lastvelocity[k])> 0.1 then
					vnew[k]=-self.lastvelocity[k]*self.springiness
				end
			end
		end
		
		if not vector.equals(vel,vnew) then
			self.collided = true
		else
			if self.collided then
				vnew = vector.new(self.lastvelocity)
			end
			self.collided = false
		end
		
		self.object:set_velocity(vnew)
	end
	
	-- buoyancy
	local surface = nil
	local surfnodename = nil
	local spos = mobkit.get_stand_pos(self)
	spos.y = spos.y+0.01
	-- get surface height
	local snodepos = mobkit.get_node_pos(spos)
	local surfnode = mobkit.nodeatpos(spos)
	while surfnode and (surfnode.drawtype == 'liquid' or surfnode.drawtype == 'flowingliquid') do
		surfnodename = surfnode.name
		surface = snodepos.y +0.5
		if surface > spos.y+self.height then break end
		snodepos.y = snodepos.y+1
		surfnode = mobkit.nodeatpos(snodepos)
	end
	self.isinliquid = surfnodename
	if surface then				-- standing in liquid
--		self.isinliquid = true
		local submergence = min(surface-spos.y,self.height)/self.height
--		local balance = self.buoyancy*self.height
		local buoyacc = mobkit.gravity*(self.buoyancy-submergence)
		mobkit.set_acceleration(self.object,
			{x=-vel.x*self.water_drag,y=buoyacc-vel.y*abs(vel.y)*0.4,z=-vel.z*self.water_drag})
	else
	    self.object:set_acceleration({x=0,y=mobkit.gravity,z=0})
	end

end
