local S = delorean.S

function delorean.set_kit(self)
    local normal_kit = nil
    if self.normal_kit then self.normal_kit:remove() end
    local pos = self.object:get_pos()
    if self._car_type == 0 or self._car_type == nil then
        normal_kit = minetest.add_entity(pos,'automobiles_delorean:normal_kit')
        normal_kit:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.normal_kit = normal_kit
        self.normal_kit:set_properties({is_visible=true})
    elseif self._car_type == 1 then
        --time machine
        normal_kit = minetest.add_entity(pos,'automobiles_delorean:time_machine_kit')
        normal_kit:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.normal_kit = normal_kit
        self.normal_kit:set_properties({is_visible=true})

        local instruments = minetest.add_entity(pos,'automobiles_delorean:time_machine_kit_instruments')
        instruments:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.instruments = instruments
        self.instruments:set_properties({is_visible=true})
    end
end

--
-- entity
--

minetest.register_entity('automobiles_delorean:wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_delorean_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "automobiles_delorean_wheel.png"},
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

minetest.register_entity('automobiles_delorean:normal_kit',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_delorean_normal_kit.b3d",
    textures = {"automobiles_black.png","automobiles_delorean_glasses.png"},
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

minetest.register_entity('automobiles_delorean:time_machine_kit',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_delorean_time_machine_accessories.b3d",
    textures = {
        "automobiles_metal.png", --ok
        "automobiles_black.png", --ok
        "automobiles_dark_grey.png", --exausts
        "automobiles_black.png", --exausts
        "automobiles_metal.png", --energy base collector
        "automobiles_painting.png^[multiply:#0063b0", --capacitors
        "automobiles_black.png", --arc
        "automobiles_painting.png^[multiply:#07B6BC", --capacitors
        "automobiles_black.png", --base mr fusion
        "automobiles_painting.png", --mr fusion
        "automobiles_metal.png", --ok
        "automobiles_painting.png", --ok
        "automobiles_black.png", --ok
        "automobiles_metal.png", --lateral tubes
        "automobiles_black.png", --conductors
        "automobiles_black.png", --ok
        "automobiles_delorean_brass.png", --ok
        "automobiles_metal.png", --base circuit switch
        "automobiles_red.png", --red button
        "automobiles_dark_grey.png", --ok
        "automobiles_delorean_brass.png", --ok
        "automobiles_black.png", --electric switch
        "automobiles_dark_grey.png", --base
        "automobiles_metal.png", --f bump
        "automobiles_dark_grey.png", --f bump
        "automobiles_metal.png"},
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

minetest.register_entity('automobiles_delorean:time_machine_kit_instruments',{
    initial_properties = {
	    physical = true,
	    collide_with_objects=true,
        collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	    pointable=false,
	    visual = "mesh",
	    mesh = "automobiles_delorean_time_machine_instruments.b3d",
        textures = {
            "automobiles_metal.png", --time panel
            "automobiles_delorean_time.png", --time panel
            "automobiles_metal.png", -- flux capacitor
            "automobiles_delorean_flux.png", --flux capacitor
            "automobiles_black.png", --flux capacitor
            "automobiles_dark_grey.png", --roof panel
            "automobiles_delorean_roof_1.png", --root panel
            "automobiles_delorean_roof_2.png", --roof panel
        },
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


minetest.register_entity('automobiles_delorean:front_suspension',{
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

minetest.register_entity('automobiles_delorean:rear_suspension',{
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

minetest.register_entity('automobiles_delorean:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_delorean_f_lights.b3d",
    textures = {"automobiles_grey.png", "automobiles_black.png"},
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

minetest.register_entity('automobiles_delorean:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_delorean_rear_pos_lights.b3d",
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

minetest.register_entity('automobiles_delorean:reverse_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_delorean_reverse_lights.b3d",
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

minetest.register_entity('automobiles_delorean:turn_left_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_delorean_turn_l_light.b3d",
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

minetest.register_entity('automobiles_delorean:turn_right_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_delorean_turn_r_light.b3d",
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

minetest.register_entity("automobiles_delorean:delorean", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.2, -0.1, 0.1, 1, 0.1},
	    selectionbox = {-1.5, 0.0, -1.5, 1.5, 2, 1.5},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_delorean_body.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_dark_grey.png", --bancos
            "automobiles_painting.png", --pintura portas
            "automobiles_black.png", --retrovisores
            "automobiles_dark_grey.png", --forro da porta
            "automobiles_delorean_glasses.png", --vidros das portas
            "automobiles_metal.png", --espelhos
            "automobiles_black.png", --volante
            "automobiles_painting2.png", --face
            "automobiles_black.png", --moldura parabrisa
            "automobiles_delorean_glasses.png", --parabrisa
            "automobiles_black.png", --grade_motor
            "automobiles_dark_grey.png", --revestimento interno
            "automobiles_delorean_fuel.png", --combustivel
            "automobiles_painting.png", --pintura
            "automobiles_black.png", --frisos
            "automobiles_black.png", --paralamas
            "automobiles_black.png", --assoalho
            "automobiles_painting2.png", --traseira
            "automobiles_black.png", --traseira placa
            "automobiles_black.png", --ventilação vidro traseiro
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = S("A very nice delorean!"),
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#9f9f9f",
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
    _car_type = nil,
    _car_gravity = -automobiles_lib.gravity,
    _is_flying = 0,
    _trunk_slots = 8,
    _engine_sound = "delorean_engine",
    _max_fuel = 10,
    _formspec_function = delorean.driver_formspec,

    _vehicle_name = S("Delorean"),
    _drive_wheel_pos = {x=-4.66, y=6.31, z=15.69},
    _drive_wheel_angle = 15,
    _seat_pos = {{x=-4.65,y=0.48,z=9.5},{x=4.65,y=0.48,z=9.5}},

    _front_suspension_ent = 'automobiles_delorean:front_suspension',
    _front_suspension_pos = {x=0,y=1.5,z=27.7057},
    _front_wheel_ent = 'automobiles_delorean:wheel',
    _front_wheel_xpos = 9.5,
    _front_wheel_frames = {x = 1, y = 49},
    _rear_suspension_ent = 'automobiles_delorean:rear_suspension',
    _rear_suspension_pos = {x=0,y=1.5,z=0},
    _rear_wheel_ent = 'automobiles_delorean:wheel',
    _rear_wheel_xpos = 9.5,
    _rear_wheel_frames = {x = 1, y = 49},

    _fuel_gauge_pos = {x=-4.66,y=6.2,z=17.9},
    _front_lights = 'automobiles_delorean:f_lights',
    _rear_lights = 'automobiles_delorean:r_lights',
    _reverse_lights = 'automobiles_delorean:reverse_lights',
    _turn_left_lights = 'automobiles_delorean:turn_left_light',
    _turn_right_lights = 'automobiles_delorean:turn_right_light',
    _textures_turn_lights_off = {"automobiles_turn.png", },
    _textures_turn_lights_on = { "automobiles_turn_on.png", },
    _extra_items_function = delorean.set_kit, --uses _car_type do change "skin"

    _setmode = delorean.set_mode,
    _control_function = delorean.control,

    _LONGIT_DRAG_FACTOR = 0.12*0.12,
    _LATER_DRAG_FACTOR = 8.0,
    _max_acc_factor = 8.0,
    _max_speed = 30,
    _min_later_speed = 4.5,
    _consumption_divisor = 40000,

    _wheel_compensation = 0.8,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

    on_step = automobiles_lib.on_step,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


