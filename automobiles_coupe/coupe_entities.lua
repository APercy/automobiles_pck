--
-- entity
--
local old_entities = {"automobiles_coupe:time_machine_kit", "automobiles_coupe:wheel","automobiles_coupe:normal_kit"}
for _,entity_name in ipairs(old_entities) do
    minetest.register_entity(":"..entity_name, {
        on_activate = function(self, staticdata)
            self.object:remove()
        end,
    })
end


minetest.register_entity('automobiles_coupe:front_suspension',{
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

minetest.register_entity('automobiles_coupe:rear_suspension',{
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

minetest.register_entity('automobiles_coupe:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_coupe_f_lights.b3d",
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

minetest.register_entity('automobiles_coupe:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_coupe_rear_pos_lights.b3d",
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

minetest.register_entity('automobiles_coupe:reverse_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_coupe_reverse_lights.b3d",
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

minetest.register_entity('automobiles_coupe:turn_left_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_coupe_turn_l_light.b3d",
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

minetest.register_entity('automobiles_coupe:turn_right_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_coupe_turn_r_light.b3d",
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

minetest.register_entity('automobiles_coupe:steering',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_coupe_drive_wheel.b3d",
    textures = {"automobiles_black.png", "automobiles_black.png", "automobiles_black.png"},
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

minetest.register_entity("automobiles_coupe:coupe", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.2, -0.1, 0.1, 1, 0.1},
	    selectionbox = {-1.5, 0.0, -1.5, 1.5, 2, 1.5},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_coupe_body.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_black.png", --bancos
            "automobiles_painting.png", --carroceria
            "automobiles_black.png", --paralamas
            "automobiles_black.png", --saia
            "automobiles_black.png", --banco
            "automobiles_coupe_glasses.png", --vidros
            "automobiles_black.png", --aletas vidro traseiro
            "automobiles_grey.png", --interior
            "automobiles_black.png", --panel
            "automobiles_coupe_fuel.png",
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice coupe!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#6d6d6d",
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
    _trunk_slots = 8,
    _engine_sound = "coupe_engine",
    _max_fuel = 10,

    _vehicle_name = "Coupe",
    _drive_wheel_pos = {x=-4.26,y=6.01,z=14.18},
    _drive_wheel_angle = 15,
    _steering_ent = 'automobiles_coupe:steering',
    _seat_pos = {{x=-4.25,y=0.48,z=9.5},{x=4.25,y=0.48,z=9.5}},

    _front_suspension_ent = 'automobiles_coupe:front_suspension',
    _front_suspension_pos = {x=0,y=1.5,z=24.5},
    _front_wheel_ent = 'automobiles_lib:wheel',
    _front_wheel_xpos = 9.5,
    _front_wheel_frames = {x = 1, y = 49},
    _rear_suspension_ent = 'automobiles_coupe:rear_suspension',
    _rear_suspension_pos = {x=0,y=1.5,z=0},
    _rear_wheel_ent = 'automobiles_lib:wheel',
    _rear_wheel_xpos = 9.5,
    _rear_wheel_frames = {x = 1, y = 49},

    _fuel_gauge_pos = {x=0,y=6.2,z=15.8},
    _front_lights = 'automobiles_coupe:f_lights',
    _rear_lights = 'automobiles_coupe:r_lights',
    _reverse_lights = 'automobiles_coupe:reverse_lights',
    _turn_left_lights = 'automobiles_coupe:turn_left_light',
    _turn_right_lights = 'automobiles_coupe:turn_right_light',
    _textures_turn_lights_off = {"automobiles_turn.png", },
    _textures_turn_lights_on = { "automobiles_turn_on.png", },

    _LONGIT_DRAG_FACTOR = 0.12*0.12,
    _LATER_DRAG_FACTOR = 18.0,
    _max_acc_factor = 8,
    _max_speed = 22,
    _min_later_speed = 2,
    _consumption_divisor = 50000,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


