--
-- entity
--

minetest.register_entity('automobiles_buggy:front_suspension',{
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

minetest.register_entity('automobiles_buggy:rear_suspension',{
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

minetest.register_entity('automobiles_buggy:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_buggy_f_lights.b3d",
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

minetest.register_entity('automobiles_buggy:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_buggy_r_lights.b3d",
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

minetest.register_entity('automobiles_buggy:f_wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_buggy_f_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "automobiles_buggy_wheel.png"},
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

minetest.register_entity('automobiles_buggy:r_wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_buggy_r_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "automobiles_buggy_wheel.png"},
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

minetest.register_entity('automobiles_buggy:rag',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_buggy_rag.b3d",
    --use_texture_alpha = true,
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_buggy_rag_window.png"},
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

minetest.register_entity("automobiles_buggy:buggy", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.45, -0.1, 0.1, 1, 0.1},
	    selectionbox = {-1.5, 0.0, -1.5, 1.5, 2, 1.5},
        stepheight = 0.7 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_buggy_body.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_black.png", --bancos
            "automobiles_painting.png", --carroceria
            "automobiles_black.png", --banco traseiro
            "automobiles_black.png", --chssis
            "automobiles_metal.png", --frontlights
            "automobiles_black.png", --interior
            "automobiles_metal.png", --engine
            "automobiles_buggy_fuel.png", --panel
            "automobiles_metal.png", --windshield
            "automobiles_buggy_windshield.png", --windshield
            "automobiles_metal.png", --engine protection
            "automobiles_metal.png", --front protection
            "automobiles_metal.png", --driver protection
            "automobiles_black.png", -- engine details
            "automobiles_metal.png", "automobiles_black.png", --volante
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice buggy!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#ff8b0e",
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
    _inv = nil,
    _inv_id = "",
    _change_color = automobiles_lib.paint,
    _intensity = 4,
    _trunk_slots = 8,
    _engine_sound = "buggy_engine",
    _max_fuel = 10,
    _formspec_function = buggy.driver_formspec,
    _destroy_function = buggy.destroy,

    _vehicle_name = "Buggy",
    _drive_wheel_pos = {x=-4.26,y=6.01,z=16},
    _drive_wheel_angle = 15,
    _rag_extended_ent = 'automobiles_buggy:rag',
    _seat_pos = {{x=-4.25,y=0.48,z=9.5},{x=4.25,y=0.48,z=9.5}},

    _front_suspension_ent = 'automobiles_buggy:front_suspension',
    _front_suspension_pos = {x=0,y=-0.7,z=23},
    _front_wheel_ent = 'automobiles_buggy:f_wheel',
    _front_wheel_xpos = 8,
    _front_wheel_frames = {x = 1, y = 13},
    _rear_suspension_ent = 'automobiles_buggy:rear_suspension',
    _rear_suspension_pos = {x=0,y=0,z=0},
    _rear_wheel_ent = 'automobiles_buggy:r_wheel',
    _rear_wheel_xpos = 8,
    _rear_wheel_frames = {x = 1, y = 13},

    _fuel_gauge_pos = {x=0,y=4.65,z=15.17},
    _front_lights = 'automobiles_buggy:f_lights',
    _rear_lights = 'automobiles_buggy:r_lights',

    _LONGIT_DRAG_FACTOR = 0.12*0.12,
    _LATER_DRAG_FACTOR = 6.0,
    _max_acc_factor = 5,
    _max_speed = 15,
    _min_later_speed = 4.0,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


