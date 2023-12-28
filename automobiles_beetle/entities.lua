-- destroy the beetle
function auto_beetle.destroy(self, puncher)
    automobiles_lib.remove_light(self)
    if self.sound_handle then
        minetest.sound_stop(self.sound_handle)
        self.sound_handle = nil
    end

    if self.driver_name then
        -- detach the driver first (puncher must be driver)
        if puncher then
            puncher:set_detach()
            puncher:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
            if minetest.global_exists("player_api") then
                player_api.player_attached[self.driver_name] = nil
                -- player should stand again
                player_api.set_animation(puncher, "stand")
            end
        end
        self.driver_name = nil
    end

    local pos = self.object:get_pos()

    if self.front_suspension then self.front_suspension:remove() end
    if self.lf_wheel then self.lf_wheel:remove() end
    if self.rf_wheel then self.rf_wheel:remove() end
    if self.rear_suspension then self.rear_suspension:remove() end
    if self.lr_wheel then self.lr_wheel:remove() end
    if self.rr_wheel then self.rr_wheel:remove() end
    if self.fuel_gauge then self.fuel_gauge:remove() end
    if self.lights then self.lights:remove() end
    if self.r_lights then self.r_lights:remove() end
    if self.reverse_lights then self.reverse_lights:remove() end
    if self.turn_l_light then self.turn_l_light:remove() end
    if self.turn_r_light then self.turn_r_light:remove() end
    if self.back_seat then self.back_seat:remove() end

    automobiles_lib.seats_destroy(self)

    automobiles_lib.destroy_inventory(self)
    self.object:remove()

    pos.y=pos.y+2

    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:engine')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:wheel')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:wheel')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:wheel')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:wheel')
end
--
-- entity
--

minetest.register_entity('automobiles_beetle:wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "beetle_anim_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "beetle_wheel.png"},
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

minetest.register_entity('automobiles_beetle:front_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_buggy_f_suspension.b3d",
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

minetest.register_entity('automobiles_beetle:rear_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_buggy_r_suspension.b3d",
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

minetest.register_entity('automobiles_beetle:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "beetle_f_lights.b3d",
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

minetest.register_entity('automobiles_beetle:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "beetle_pos_lights.b3d",
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

minetest.register_entity('automobiles_beetle:turn_left_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "beetle_turn_l_light.b3d",
    textures = {"automobiles_rear_lights.png", "automobiles_turn.png", },
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

minetest.register_entity('automobiles_beetle:turn_right_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "beetle_turn_r_light.b3d",
    textures = {"automobiles_rear_lights.png", "automobiles_turn.png", },
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

minetest.register_entity('automobiles_beetle:reverse_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "beetle_reverse_lights.b3d",
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

function auto_beetle.paint(self, colstr)
    local l_textures = self.initial_properties.textures
    self._color = colstr

    --paint details
    local target_texture = "beetle_painting.png"
    local accessorie_texture = "beetle_paint_interior.png"
    for _, texture in ipairs(l_textures) do
        local indx = texture:find(target_texture)
        if indx then
            l_textures[_] = "("..target_texture.."^[multiply:"..colstr..")^("..target_texture.."^[multiply:#BBBBBB^[mask:beetle_details.png)" --here changes the main color
        end
        local indx = texture:find(accessorie_texture)
        if indx then
            l_textures[_] = accessorie_texture.."^[multiply:".. colstr --here changes the main color
        end
    end
    self.object:set_properties({textures=l_textures})
end

function auto_beetle.set_paint(self, puncher, itmstck)
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
        auto_beetle.paint(self, colstr)
        return true
    else
        --painting with dyes
        local split = string.split(item_name, ":")
        local color, indx, _
        if split[1] then _,indx = split[1]:find('dye') end
        if indx then
            --[[for clr,_ in pairs(automobiles_lib.colors) do
                local _,x = split[2]:find(clr)
                if x then color = clr end
            end]]--
            --lets paint!!!!
	        local color = (item_name:sub(indx+1)):gsub(":", "")
	        local colstr = automobiles_lib.colors[color]
            --minetest.chat_send_all(color ..' '.. dump(colstr))
	        if colstr then
                auto_beetle.paint(self, colstr)
		        itmstck:set_count(itmstck:get_count()-1)
		        puncher:set_wielded_item(itmstck)
                return true
	        end
            -- end painting
        end
    end
    return false
end

auto_beetle.car_properties1 = {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.2, -0.1, 0.1, 1.8, 0.1},
	    selectionbox = {-2.0, 0.0, -2.0, 2.0, 2, 2.0},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "beetle_body.b3d",
        --use_texture_alpha = true,
        backface_culling = false,
        textures = {
            "automobiles_black.png", --bancos
            "automobiles_black.png", --banco traseiro
            "beetle_painting.png", --pintura carroceria
            "automobiles_black.png", --chassis
            "automobiles_metal.png", "automobiles_black.png", --escapamento
            "automobiles_metal.png", --detalhes metal
            "automobiles_black.png", "automobiles_metal.png", --estribos
            "beetle_glasses.png", --vidros
            "beetle_interior.png", --assoalho e forros
            "beetle_paint_interior.png", --painel
            "automobiles_metal.png", --para-choques
            "beetle_painting.png", --para-lamas
            "automobiles_metal.png", "automobiles_black.png", --volante
            "beetle_painting.png", --portas
            "automobiles_black.png", --forro portas
            "automobiles_metal.png", --metais portas
            "beetle_glasses.png", --vidros portas
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice Beetle!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#FFFFFF",
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
    _change_color = automobiles_lib.paint,
    _intensity = 4,
    _car_gravity = -automobiles_lib.gravity,
    _is_flying = 0,
    _trunk_slots = 12,
    _engine_sound = "beetle_engine",
    _max_fuel = 10,

    _vehicle_name = "Beetle",
    _drive_wheel_pos = {x=-4.42, y=7.00, z=21},
    _drive_wheel_angle = 12,
    _seat_pos = {{x=-4.0,y=2,z=13.8},{x=4.0,y=2,z=13.8}, {x=-3.5,y=2,z=5},{x=3.5,y=2,z=5}},

    _front_suspension_ent = 'automobiles_beetle:front_suspension',
    _front_suspension_pos = {x=0,y=1.8,z=27.6},
    _front_wheel_ent = 'automobiles_beetle:wheel',
    _front_wheel_xpos = 8.5,
    _front_wheel_frames = {x = 1, y = 24},
    _rear_suspension_ent = 'automobiles_beetle:rear_suspension',
    _rear_suspension_pos = {x=0,y=1.8,z=0},
    _rear_wheel_ent = 'automobiles_beetle:wheel',
    _rear_wheel_xpos = 8.5,
    _rear_wheel_frames = {x = 1, y = 24},
    _wheel_compensation = 0.9,

    _fuel_gauge_pos = {x=-4.42,y=8.70,z=20.2},
    _front_lights = 'automobiles_beetle:f_lights',
    _rear_lights = 'automobiles_beetle:r_lights',
    _reverse_lights = 'automobiles_beetle:reverse_lights',
    _turn_left_lights = 'automobiles_beetle:turn_left_light',
    _turn_right_lights = 'automobiles_beetle:turn_right_light',
    _textures_turn_lights_off = {"automobiles_rear_lights.png", "automobiles_turn.png", },
    _textures_turn_lights_on = {"automobiles_rear_lights_full.png", "automobiles_turn_on.png", },

    _change_color = auto_beetle.paint,
    _painting_function = auto_beetle.set_paint,
    _painting_load = auto_beetle.paint,
    _transmission_state = 1,

    _horn_sound = 'beetle_horn',

    _LONGIT_DRAG_FACTOR = 0.12*0.12,
    _LATER_DRAG_FACTOR = 6.0,
    _max_acc_factor = 5,
    _max_speed = 14,
    _min_later_speed = 3,
    

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
}

minetest.register_entity("automobiles_beetle:beetle", auto_beetle.car_properties1)
