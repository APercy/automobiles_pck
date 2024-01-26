--
-- entity
--
local S = trans_am.S

minetest.register_entity('automobiles_trans_am:wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_trans_am_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "automobiles_trans_am_wheel.png"},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,

    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,

})

minetest.register_entity('automobiles_trans_am:front_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pivot_mesh.b3d",
    textures = {"automobiles_black.png",},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,

    --[[on_step = function(self, dtime, moveresult)
        minetest.chat_send_all(dump(moveresult))
    end,]]--
	
})

minetest.register_entity('automobiles_trans_am:rear_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pivot_mesh.b3d",
    textures = {"automobiles_black.png",},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

minetest.register_entity('automobiles_trans_am:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_f_lights.b3d",
    textures = {"automobiles_grey.png"},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

minetest.register_entity('automobiles_trans_am:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_r_lights.b3d",
    textures = {"automobiles_rear_lights_off.png"},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

minetest.register_entity('automobiles_trans_am:reverse_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_rear_lights.b3d",
    textures = {"automobiles_grey.png",},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

minetest.register_entity('automobiles_trans_am:turn_left_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_l_turn_light.b3d",
    textures = {"automobiles_rear_lights_off.png",},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

minetest.register_entity('automobiles_trans_am:turn_right_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_r_turn_light.b3d",
    textures = {"automobiles_rear_lights_off.png",},
	},

    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

function trans_am.paint(self, colstr)
    automobiles_lib.paint_with_mask(self, colstr, self._det_color, "automobiles_trans_am_painting.png", "automobiles_trans_am_marks.png")
    local l_textures = self.initial_properties.textures

    --paint details
    local target_texture = "automobiles_painting.png"
    local accessorie_texture = "automobiles_painting2.png"
    for _, texture in ipairs(l_textures) do
        local indx = texture:find(target_texture)
        if indx then
            l_textures[_] = target_texture.."^[multiply:".. self._det_color --apply the deatil color color
        end
        local indx = texture:find(accessorie_texture)
        if indx then
            l_textures[_] = accessorie_texture.."^[multiply:".. colstr --here changes the main color
        end
    end
    self.object:set_properties({textures=l_textures})
end

function trans_am.set_paint(self, puncher, itmstck)
    local is_admin = false
    is_admin = minetest.check_player_privs(puncher, {server=true})
    if not (self.owner == puncher:get_player_name() or is_admin == true) then
        return
    end

    local item_name = ""
    if itmstck then item_name = itmstck:get_name() end

    if item_name == "bike:painter" then
        --painting with bike painter
        local meta = itmstck:get_meta()
	    local colstr = meta:get_string("paint_color")
        self._det_color = colstr
        trans_am.paint(self, self._color)
        return true
    else
        --painting with dyes
        local split = string.split(item_name, ":")
        local color, indx, _
        if split[1] then _,indx = split[1]:find('dye') end
        if indx then
            for clr,_ in pairs(automobiles_lib.colors) do
                local _,x = split[2]:find(clr)
                if x then color = clr end
            end
            --lets paint!!!!
	        --local color = item_name:sub(indx+1)
	        local colstr = automobiles_lib.colors[color]
            --minetest.chat_send_all(color ..' '.. dump(colstr))
	        if colstr then
                self._det_color = colstr
                trans_am.paint(self, self._color)
		        itmstck:set_count(itmstck:get_count()-1)
		        puncher:set_wielded_item(itmstck)
                return true
	        end
            -- end painting
        end
    end
    return false
end

minetest.register_entity("automobiles_trans_am:trans_am", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.2, -0.1, 0.1, 1.8, 0.1},
	    selectionbox = {-2.0, 0.0, -2.0, 2.0, 2, 2.0},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_trans_am_body.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_black.png", --bancos
            "automobiles_painting2.png", -- scoop
            "automobiles_black.png", --lights
            "automobiles_trans_am_glasses.png", --vidros
            "automobiles_trans_am_painting.png", --pintura grade frontal
            "automobiles_black.png", --detalhe grade frontal
            "automobiles_painting.png", --detalhe grade frontal
            "automobiles_black.png", --interior
            "automobiles_black.png", --painel
            "automobiles_painting.png", --fundo painel
            "automobiles_trans_am_fuel.png", --combustivel
            "automobiles_trans_am_painting.png", --pintura do carro
            "automobiles_trans_am_painting.png", --pintura das portas
            "automobiles_black.png", --forração portas e volante
            "automobiles_metal.png", --espelhos
            "automobiles_trans_am_painting.png", --spoilers
            "automobiles_painting2.png", --tomadas de ar laterais
            "automobiles_black.png", --assoalho
            "automobiles_red.png", --bancos
            "automobiles_trans_am_painting.png", --pintura
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = S("A very nice Trans Am!"),
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#222222",
    _det_color = "#BDA050",
    _steering_angle = 0,
    _engine_running = false,
    _last_checkpoint = "",
    _total_laps = -1,
    _race_id = "",
    _energy = 1,
    _last_time_collision_snd = 0,
    _last_time_drift_snd = 0,
    _last_time_command = 0,
    _roll = math.rad(0),
    _pitch = 0,
    _longit_speed = 0,
    _show_rag = true,
    _show_lights = false,
    _light_old_pos = nil,
    _last_ground_check = 0,
    _last_light_move = 0,
    _last_engine_sound_update = 0,
    _turn_light_timer = 0,
    _inv = nil,
    _inv_id = "",
    _change_color = trans_am.paint,
    _intensity = 4,
    _car_gravity = -automobiles_lib.gravity,
    --acc control
    _transmission_state = 1,
    _painting_function = trans_am.set_paint,
    _trunk_slots = 12,
    _engine_sound = "trans_am_engine",
    _max_fuel = 10,

    _vehicle_name = "Trans Am",
    _painting_load = trans_am.paint,
    _drive_wheel_pos = {x=-4.0, y=6.50, z=15.06},
    _drive_wheel_angle = 15,
    _seat_pos = {{x=-4.0,y=0.8,z=9},{x=4.0,y=0.8,z=9}},

    _front_suspension_ent = 'automobiles_trans_am:front_suspension',
    _front_suspension_pos = {x=0,y=1.5,z=27.0},
    _front_wheel_ent = 'automobiles_trans_am:wheel',
    _front_wheel_xpos = 9.5,
    _front_wheel_frames = {x = 1, y = 49},
    _rear_suspension_ent = 'automobiles_trans_am:rear_suspension',
    _rear_suspension_pos = {x=0,y=1.5,z=0},
    _rear_wheel_ent = 'automobiles_trans_am:wheel',
    _rear_wheel_xpos = 9.5,
    _rear_wheel_frames = {x = 1, y = 49},

    _fuel_gauge_pos = {x=-4,y=6.8,z=16.6},
    _front_lights = 'automobiles_trans_am:f_lights',
    _rear_lights = 'automobiles_trans_am:r_lights',
    _reverse_lights = 'automobiles_trans_am:reverse_lights',
    _turn_left_lights = 'automobiles_trans_am:turn_left_light',
    _turn_right_lights = 'automobiles_trans_am:turn_right_light',

    _LONGIT_DRAG_FACTOR = 0.12*0.12,
    _LATER_DRAG_FACTOR = 6.0,
    _max_acc_factor = 12,
    _max_speed = 40,
    _min_later_speed = 4.5,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


