function catrelle.extra_parts(self)
    local pos = self.object:get_pos()
    local back_seat = minetest.add_entity(pos,'automobiles_catrelle:back_seat')
    back_seat:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
    self.back_seat = back_seat
end

--
-- entity
--

minetest.register_entity('automobiles_catrelle:wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_catrelle_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "automobiles_catrelle_wheel.png"},
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

minetest.register_entity('automobiles_catrelle:front_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "sprite",
    textures = {"automobiles_alpha.png",},
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

minetest.register_entity('automobiles_catrelle:rear_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
	pointable=false,
	visual = "sprite",
    textures = {"automobiles_alpha.png",},
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

minetest.register_entity('automobiles_catrelle:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_catrelle_f_lights.b3d",
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

minetest.register_entity('automobiles_catrelle:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_catrelle_pos_lights.b3d",
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

minetest.register_entity('automobiles_catrelle:turn_left_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_catrelle_turn_l_light.b3d",
    textures = {"automobiles_turn.png",},
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

minetest.register_entity('automobiles_catrelle:turn_right_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_catrelle_turn_r_light.b3d",
    textures = {"automobiles_turn.png",},
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

minetest.register_entity('automobiles_catrelle:back_seat',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_catrelle_seat.b3d",
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

catrelle.car_properties1 = {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.4, -0.1, 0.1, 1.8, 0.1},
	    selectionbox = {-2.0, 0.0, -2.0, 2.0, 2, 2.0},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_catrelle_body.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_black.png", --bancos
            "automobiles_painting.png", --pintura
            "automobiles_black.png", --paralamas
            "automobiles_black.png", --grade_motor
            "automobiles_catrelle_bars.png", --grade_motor
            "automobiles_painting.png", --interior 1
            "automobiles_dark_grey.png", --interior 2
            "automobiles_black.png", --painel1
            "automobiles_painting.png", --lat glass interno
            "automobiles_painting.png", --lat glass externo
            "automobiles_catrelle_fuel.png", --combustivel
            "automobiles_catrelle_glass.png", --parabrisa
            "automobiles_metal.png", --para choques
            "automobiles_painting.png", --pintura portas
            "automobiles_dark_grey.png", --forracao portas
            "automobiles_catrelle_glass.png", --vidros
            "automobiles_black.png", --volante
            "automobiles_black.png", --ventilação
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice Catrelle!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#07B6BC",
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
    _trunk_slots = 32,
    _engine_sound = "automobiles_engine",
    _max_fuel = 10,

    _vehicle_name = "Catrelle",
    _drive_wheel_pos = {x=-4.0, y=8.00, z=21},
    _drive_wheel_angle = 15,
    _seat_pos = {{x=-4.0,y=3,z=15},{x=4.0,y=3,z=15}},

    _front_suspension_ent = 'automobiles_catrelle:front_suspension',
    _front_suspension_pos = {x=0,y=-0.2,z=29},
    _front_wheel_ent = 'automobiles_catrelle:wheel',
    _front_wheel_xpos = 7.5,
    _front_wheel_frames = {x = 1, y = 49},
    _rear_suspension_ent = 'automobiles_catrelle:rear_suspension',
    _rear_suspension_pos = {x=0,y=-0.2,z=0},
    _rear_wheel_ent = 'automobiles_catrelle:wheel',
    _rear_wheel_xpos = 7.5,
    _rear_wheel_frames = {x = 1, y = 49},

    _fuel_gauge_pos = {x=-4.47,y=8.50,z=20.5},
    _front_lights = 'automobiles_catrelle:f_lights',
    _rear_lights = 'automobiles_catrelle:r_lights',
    _turn_left_lights = 'automobiles_catrelle:turn_left_light',
    _turn_right_lights = 'automobiles_catrelle:turn_right_light',
    _textures_turn_lights_off = {"automobiles_turn.png", },
    _textures_turn_lights_on = { "automobiles_turn_on.png", },

    _LONGIT_DRAG_FACTOR = 0.12*0.12,
    _LATER_DRAG_FACTOR = 10.0,
    _max_acc_factor = 5,
    _max_speed = 14,
    _min_later_speed = 3,
    _consumption_divisor = 50000,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
}

minetest.register_entity("automobiles_catrelle:catrelle", catrelle.car_properties1)

catrelle.car_properties2 = automobiles_lib.properties_copy(catrelle.car_properties1)
catrelle.car_properties2._vehicle_name = "Catrelle 4F"
catrelle.car_properties2.initial_properties = automobiles_lib.properties_copy(catrelle.car_properties1.initial_properties)
catrelle.car_properties2.initial_properties.textures = automobiles_lib.properties_copy(catrelle.car_properties1.initial_properties.textures)
catrelle.car_properties2.initial_properties.textures[9] = "automobiles_alpha.png"
catrelle.car_properties2.initial_properties.textures[10] = "automobiles_catrelle_lat_glass.png"
catrelle.car_properties2._seat_pos = {{x=-4.0,y=3,z=15},{x=4.0,y=3,z=15}, {x=-4.0,y=3,z=7},{x=4.0,y=3,z=7}}
catrelle.car_properties2._color = "#0063b0"
catrelle.car_properties2._trunk_slots = 16
catrelle.car_properties2._extra_items_function = catrelle.extra_parts

minetest.register_entity("automobiles_catrelle:catrelle_4f", catrelle.car_properties2)

