--
-- entity
--


minetest.register_entity('automobiles_vespa:front_suspension',{
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

minetest.register_entity('automobiles_vespa:rear_suspension',{
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

minetest.register_entity('automobiles_vespa:lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_vespa_lights.b3d",
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

minetest.register_entity('automobiles_vespa:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_vespa_r_lights.b3d",
    textures = {"automobiles_red.png",},
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

minetest.register_entity("automobiles_vespa:vespa", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.24, -0.1, 0.1, 1, 0.1},
	    selectionbox = {-1.0, 0.0, -1.0, 1.0, 1, 1.0},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_vespa_body.b3d",
        --use_texture_alpha = true,
        backface_culling = false,
        textures = {
                "automobiles_black.png", --bancos
                "automobiles_black.png", --escapamento
                "automobiles_metal.png", --eixo motor
                "automobiles_black.png", --motor
                "automobiles_painting.png", --pintura guidão e paralama
                "automobiles_black.png", --pneus
                "automobiles_metal.png", --rodas e aros
                "automobiles_painting.png", --pintura
                "automobiles_metal.png", --cromo
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice vespa!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#dc1818",
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
    _show_rag = false,
    _show_lights = false,
    _light_old_pos = nil,
    _last_ground_check = 0,
    _last_light_move = 0,
    _last_engine_sound_update = 0,
    _turn_light_timer = 0,
    _inv = nil,
    _inv_id = "",
    _change_color = automobiles_lib.paint,
    _intensity = 2,
    _trunk_slots = 0,
    _engine_sound = "vespa_engine",
    _max_fuel = 3,
    _base_pitch = 0.7,

    _vehicle_name = "Vespa",
    _drive_wheel_pos = {x=-4.26,y=6.01,z=14.18},
    _drive_wheel_angle = 0,
    _seat_pos = {{x=0.0,y=-1.1,z=5.5},{x=0.0,y=1,z=0.09}},

    _front_suspension_ent = 'automobiles_vespa:front_suspension',
    _front_suspension_pos = {x=0,y=1.5,z=14.5},
    --_front_wheel_ent = 'automobiles_lib:wheel',
    _front_wheel_xpos = 0,
    _front_wheel_frames = {x = 1, y = 49},
    _rear_suspension_ent = 'automobiles_vespa:rear_suspension',
    _rear_suspension_pos = {x=0,y=1.5,z=0},
    --_rear_wheel_ent = 'automobiles_lib:wheel',
    _rear_wheel_xpos = 0,
    _rear_wheel_frames = {x = 1, y = 49},

    _front_lights = 'automobiles_vespa:lights',
    _rear_lights = 'automobiles_vespa:r_lights',

    _LONGIT_DRAG_FACTOR = 0.15*0.15,
    _LATER_DRAG_FACTOR = 25.0,
    _max_acc_factor = 6,
    _max_speed = 14,
    _min_later_speed = 5,
    _have_transmission = false,
    _is_motorcycle = true,
    _consumption_divisor = 150000,

    _attach = vespa.attach_driver_stand,
    _dettach = vespa.dettach_driver_stand,
    _attach_pax = vespa.attach_pax_stand,
    _dettach_pax = vespa.dettach_pax_stand,

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = function(self, staticdata, dtime_s)
        automobiles_lib.on_activate(self, staticdata, dtime_s)

        self.object:set_bone_position("guidao", {x=0, y=0, z=14}, {x=22, y=180, z=0})
        self.lights:set_bone_position("guidao", {x=0, y=0, z=14}, {x=22, y=180, z=0})

        self.object:set_animation(self._rear_wheel_frames, 0, 0, true)
    end,

	on_step = function(self, dtime)
        automobiles_lib.on_step(self, dtime)

        local angle_factor = self._steering_angle / 10
        local anim_speed = self._longit_speed * (15 - angle_factor)
        --core.chat_send_all(dump(anim_speed))
        self.object:set_animation_frame_speed(anim_speed)
        --whell turn
        self.object:set_bone_position("eixo_direcao", {x=0, y=0, z=0}, {x=0, y=-self._steering_angle-angle_factor, z=0})
        self.lights:set_bone_position("eixo_direcao", {x=0, y=0, z=0}, {x=0, y=-self._steering_angle-angle_factor, z=0})

        local player = nil
        local is_attached = false
        if self.driver_name then
            player = minetest.get_player_by_name(self.driver_name)
            
            if player then
                local player_attach = player:get_attach()
                if player_attach then
                    if self.driver_seat then
                        if player_attach == self.driver_seat then is_attached = true end
                    end
                end

                local steering_angle_max = 30
                -- -30 direita -> steering_angle_max
                -- +30 esquerda
                local arm_range = 2
                local range = steering_angle_max * 2
                local armZ = -((self._steering_angle+steering_angle_max) * arm_range) / 60
                
                --player:set_bone_position("Arm_Left", {x=3.0, y=5, z=-arm_range-armZ}, {x=240-(self._steering_angle/2), y=0, z=0})
                --player:set_bone_position("Arm_Right", {x=-3.0, y=5, z=armZ}, {x=240+(self._steering_angle/2), y=0, z=0})
                if self.driver_mesh then
                    self.driver_mesh:set_bone_position("Arm_Left", {x=3.0, y=5, z=-armZ-0.5}, {x=76-(self._steering_angle/2), y=0, z=0})
                    self.driver_mesh:set_bone_position("Arm_Right", {x=-3.0, y=5, z=armZ+1.5}, {x=76+(self._steering_angle/2), y=0, z=0})
                end

            end
        end

        if is_attached == false then
            self.object:set_bone_position("descanso", {x=0, y=-0.4, z=6.2}, {x=-90, y=0, z=0})
        else
            self.object:set_bone_position("descanso", {x=0, y=-0.4, z=6.2}, {x=0, y=0, z=0})
        end

    end,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


