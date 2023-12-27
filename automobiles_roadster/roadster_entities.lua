--
-- entity
--

minetest.register_entity('automobiles_roadster:front_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_roadster_front_suspension.b3d",
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

minetest.register_entity('automobiles_roadster:rear_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_roadster_rear_suspension.b3d",
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

minetest.register_entity('automobiles_roadster:lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 15,
	visual = "mesh",
	mesh = "automobiles_roadster_lights.b3d",
    textures = {"automobiles_roadster_lights.png",},
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

minetest.register_entity('automobiles_roadster:wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_roadster_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_wood2.png", "automobiles_roadster_wheel.png"},
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

minetest.register_entity('automobiles_roadster:top1',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_roadster_top1.b3d",
    backface_culling = false,
	textures = {"automobiles_metal.png", "automobiles_black.png", "automobiles_alpha.png"},
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

minetest.register_entity('automobiles_roadster:top2',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_roadster_top2.b3d",
    backface_culling = false,
	textures = {"automobiles_metal.png", "automobiles_black.png", "automobiles_alpha.png"},
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

minetest.register_entity('automobiles_roadster:steering',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_roadster_steering.b3d",
    textures = {"automobiles_metal.png", "automobiles_wood2.png", "automobiles_metal.png"},
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

minetest.register_entity('automobiles_roadster:pointer',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pointer.b3d",
    visual_size = {x = 1, y = 1, z = 1},
	textures = {"automobiles_white.png"},
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

minetest.register_entity("automobiles_roadster:roadster", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.5, -0.1, 0.1, 1, 0.1},
	    selectionbox = {-1.5, 0.0, -1.5, 1.5, 2, 1.5},
        stepheight = 0.6 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_roadster.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_metal2.png", --parabrisa movel
            "automobiles_glass.png", --vidro do parabrisa movel
            "automobiles_painting.png", --portas
            "automobiles_black.png", --portas interno
            "automobiles_wood.png", --assoalho
            "automobiles_black.png", --bancos
            "automobiles_painting.png", --pintura
            "automobiles_black.png", --chassis
            "automobiles_metal2.png", --carcaça farol
            "automobiles_black.png", --grade do radiador
            "automobiles_black.png", --forração interna
            "automobiles_metal.png", --lente do farol
            "automobiles_wood.png", --parede de fogo
            "automobiles_roadster_fuel.png", --combustivel
            "automobiles_metal2.png", --parabrisa fixo
            "automobiles_glass.png", --vidro do parabrisa fixo
            "automobiles_black.png", --paralamas
            "automobiles_metal2.png", --carenagem do radiador
            "automobiles_painting.png", --tanque de combustivel
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice roadster!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#0063b0",
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
    _engine_sound = "roadster_engine",
    _max_fuel = 10,
    _formspec_function = roadster.driver_formspec,
    _destroy_function = roadster.destroy,

    _vehicle_name = "Roadster",
    _drive_wheel_pos = {x=-4.25,y=12,z=14},
    _drive_wheel_angle = 70,
    _steering_ent = 'automobiles_roadster:steering',
    _rag_extended_ent = 'automobiles_roadster:top1',
    _rag_retracted_ent = 'automobiles_roadster:top2',
    _windshield_pos = {x=0, z=15.8317, y=15.0394},
    _windshield_ext_rotation = {x=145, y=0, z=0},
    _seat_pos = {{x=-4.25,y=7.12,z=9.5},{x=4.25,y=7.12,z=9.5}},

    _front_suspension_ent = 'automobiles_roadster:front_suspension',
    _front_suspension_pos = {x=0,y=0,z=24.22},
    _front_wheel_ent = 'automobiles_roadster:wheel',
    _front_wheel_xpos = 10.26,
    _front_wheel_frames = {x = 1, y = 24},
    _rear_suspension_ent = 'automobiles_roadster:rear_suspension',
    _rear_suspension_pos = {x=0,y=0,z=0},
    _rear_wheel_ent = 'automobiles_roadster:wheel',
    _rear_wheel_xpos = 10.26,
    _rear_wheel_frames = {x = 1, y = 24},
    _wheel_compensation = 0.5,

    _fuel_gauge_pos = {x=0,y=8.04,z=17.84},
    _gauge_pointer_ent = 'automobiles_roadster:pointer',
    _front_lights = 'automobiles_roadster:lights',

    _horn_sound = 'roadster_horn',

    _LONGIT_DRAG_FACTOR = 0.16*0.16,
    _LATER_DRAG_FACTOR = 20.0,
    _max_acc_factor = 5,
    _max_speed = 12,
    _min_later_speed = 2,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


