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

minetest.register_entity('automobiles_delorean:rear_suspension',{
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
    _car_type = 0,
    _car_gravity = -automobiles_lib.gravity,
    _is_flying = 0,
    _trunk_slots = 8,
    _engine_sound = "delorean_engine",
    _max_fuel = 10,
    _formspec_function = delorean.driver_formspec,
    _destroy_function = delorean.destroy,

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

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

    on_step = automobiles_lib.on_step,
	--[[on_step = function(self, dtime)
        automobiles_lib.stepfunc(self, dtime)
        --sound play control--
        self._last_time_collision_snd = self._last_time_collision_snd + dtime
        if self._last_time_collision_snd > 1 then self._last_time_collision_snd = 1 end
        self._last_time_drift_snd = self._last_time_drift_snd + dtime
        if self._last_time_drift_snd > 1 then self._last_time_drift_snd = 1 end
        --end sound control--

        local rotation = self.object:get_rotation()
        local yaw = rotation.y
		local newyaw=yaw
        local pitch = rotation.x

        local hull_direction = minetest.yaw_to_dir(yaw)
        local nhdir = {x=hull_direction.z,y=0,z=-hull_direction.x}		-- lateral unit vector
        local velocity = self.object:get_velocity()

        local longit_speed = automobiles_lib.dot(velocity,hull_direction)
        local fuel_weight_factor = (5 - self._energy)/5000
        local longit_drag = vector.multiply(hull_direction,(longit_speed*longit_speed) *
            (delorean.LONGIT_DRAG_FACTOR - fuel_weight_factor) * -1 * automobiles_lib.sign(longit_speed))
        
		local later_speed = automobiles_lib.dot(velocity,nhdir)
        local later_drag = vector.multiply(nhdir,later_speed*
            later_speed*delorean.LATER_DRAG_FACTOR*-1*automobiles_lib.sign(later_speed))

        local accel = vector.add(longit_drag,later_drag)
        local stop = nil
        local curr_pos = self.object:get_pos()

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
            end
        end

        --to fix the load on first time and turn on the lights of time machine
        delorean.set_mode(self, is_attached, curr_pos, velocity, player, dtime)

        local is_breaking = false
        if is_attached then
    		local ctrl = player:get_player_control()
	        if ctrl.aux1 then
                --sets the engine running - but sets a delay also, cause keypress
                if self._last_time_command > 0.8 then
                    self._last_time_command = 0
                    minetest.sound_play({name = "automobiles_horn"},
	                        {object = self.object, gain = 0.6, pitch = 1.0, max_hear_distance = 32, loop = false,})
                end
	        end
            if ctrl.down then
                is_breaking = true
                self.r_lights:set_properties({textures={"automobiles_rear_lights_full.png"}, glow=15})
            end
            if ctrl.sneak then
                self.reverse_lights:set_properties({textures={"automobiles_white.png"}, glow=15})
            else
                self.reverse_lights:set_properties({textures={"automobiles_grey.png"}, glow=0})
            end
        end

        self._last_light_move = self._last_light_move + dtime
        if self._last_light_move > 0.15 then
            self._last_light_move = 0
            if self._show_lights == true then
                --self.lights:set_properties({is_visible=true})
                self.lights:set_properties({textures={"automobiles_delorean_lights.png", "automobiles_black.png"}, glow=15})
                if is_breaking == false then
                    self.r_lights:set_properties({textures={"automobiles_rear_lights.png"}, glow=10})
                end
                automobiles_lib.put_light(self)
            else
                --self.lights:set_properties({is_visible=false})
                self.lights:set_properties({textures={"automobiles_grey.png", "automobiles_black.png"}, glow=0})
                if is_breaking == false then
                    self.r_lights:set_properties({textures={"automobiles_rear_lights_off.png"}, glow=0})
                end
                automobiles_lib.remove_light(self)
            end
        end

        -- impacts and control
        self.object:move_to(curr_pos)
		if is_attached then --and self.driver_name == self.owner then
            local impact = automobiles_lib.get_hipotenuse_value(velocity, self.lastvelocity)
            if impact > 1 then
                --self.damage = self.damage + impact --sum the impact value directly to damage meter
                if self._last_time_collision_snd > 0.3 then
                    self._last_time_collision_snd = 0
                    minetest.sound_play("automobiles_collision", {
                        to_player = self.driver_name,
	                    --pos = curr_pos,
	                    --max_hear_distance = 5,
	                    gain = 1.0,
                        fade = 0.0,
                        pitch = 1.0,
                    })
                end
            end

            --control
            local steering_angle_max = 30
            local steering_speed = 40
            if math.abs(longit_speed) > 3 then
                local mid_speed = (steering_speed/2)
                steering_speed = mid_speed + mid_speed / math.abs(longit_speed*0.25)
            end
			accel, stop = delorean.control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, delorean.max_acc_factor, delorean.max_speed, steering_angle_max, steering_speed)
        else
            self._show_lights = false
            if self.sound_handle ~= nil then
	            minetest.sound_stop(self.sound_handle)
	            self.sound_handle = nil
            end
		end

        local angle_factor = self._steering_angle / 10

        --check if the tyres is touching the pavement
        local noded = automobiles_lib.nodeatpos(automobiles_lib.pos_shift(curr_pos,{y=-0.3}))
        if (noded and noded.drawtype ~= 'airlike') then
            if noded.drawtype ~= 'liquid' then
                local min_later_speed = 0.9
                if (later_speed > min_later_speed or later_speed < -min_later_speed) and
                        self._last_time_drift_snd > 0.6 then
                    self._last_time_drift_snd = 0
                    minetest.sound_play("automobiles_drifting", {
                        pos = curr_pos,
                        max_hear_distance = 20,
                        gain = 3.0,
                        fade = 0.0,
                        pitch = 1.0,
                        ephemeral = true,
                    })
                end

                self.lf_wheel:set_animation_frame_speed(longit_speed * (12 - angle_factor))
                self.rf_wheel:set_animation_frame_speed(-longit_speed * (12 + angle_factor))
                self.lr_wheel:set_animation_frame_speed(longit_speed * (12 - angle_factor))
                self.rr_wheel:set_animation_frame_speed(-longit_speed * (12 + angle_factor))
            end
        else
            --is flying
            self.lf_wheel:set_animation_frame_speed(0)
            self.rf_wheel:set_animation_frame_speed(0)
            self.lr_wheel:set_animation_frame_speed(0)
            self.rr_wheel:set_animation_frame_speed(0)
        end

        --drive wheel turn
        self.object:set_bone_position("drive_wheel", {x=-0, y=0, z=0}, {x=0, y=0, z=-self._steering_angle*2}) 
        delorean.set_wheels_mode(self, angle_factor)


		if math.abs(self._steering_angle)>5 then
            local turn_rate = math.rad(40)
			newyaw = yaw + dtime*(1 - 1 / (math.abs(longit_speed) + 1)) *
                self._steering_angle / 30 * turn_rate * automobiles_lib.sign(longit_speed)
		end

        --turn light
        self._turn_light_timer = self._turn_light_timer + dtime
        if math.abs(self._steering_angle) > 15 and self._turn_light_timer >= 1 then
            self._turn_light_timer = 0
            --set turn light
            --minetest.chat_send_all(self._steering_angle)
            if self._steering_angle < 0 then
                --minetest.chat_send_all("direita")
                self.turn_r_light:set_properties({textures={"automobiles_turn_on.png"}, glow=20})
            end
            if self._steering_angle > 0 then
                --minetest.chat_send_all("esquerda")
                self.turn_l_light:set_properties({textures={"automobiles_turn_on.png"}, glow=20})
            end
        end
        if self._turn_light_timer > 0.5 then
            self.turn_l_light:set_properties({textures={"automobiles_turn.png"}, glow=0})
            self.turn_r_light:set_properties({textures={"automobiles_turn.png"}, glow=0})
        end
        if self._turn_light_timer > 1 then
            self._turn_light_timer = 1
        end
        
        --accell correction
        --under some circunstances the acceleration exceeds the max value accepted by set_acceleration and
        --the game crashes with an overflow, so limiting the max acceleration in each axis prevents the crash
        local max_factor = 25
        local acc_adjusted = 10
        if accel.x > max_factor then accel.x = acc_adjusted end
        if accel.x < -max_factor then accel.x = -acc_adjusted end
        if accel.z > max_factor then accel.z = acc_adjusted end
        if accel.z < -max_factor then accel.z = -acc_adjusted end
        -- end correction

        -- calculate energy consumption --
        ----------------------------------
        if self._energy > 0 then
            local zero_reference = vector.new()
            local acceleration = automobiles_lib.get_hipotenuse_value(accel, zero_reference)
            --minetest.chat_send_all(acceleration)
            local consumed_power = acceleration/40000
            self._energy = self._energy - consumed_power;
        end
        if self._energy <= 0 then
            self._engine_running = false
            self._is_flying = 0
            if self.sound_handle then minetest.sound_stop(self.sound_handle) end
            --minetest.chat_send_player(self.driver_name, "Out of fuel")
        else
            self._last_engine_sound_update = self._last_engine_sound_update + dtime
            if self._last_engine_sound_update > 0.300 then
                self._last_engine_sound_update = 0
                automobiles_lib.engine_set_sound_and_animation(self, longit_speed)
            end
        end

        local energy_indicator_angle = automobiles_lib.get_gauge_angle(self._energy)
        self.fuel_gauge:set_attach(self.object,'',self._fuel_gauge_pos,{x=0,y=0,z=energy_indicator_angle})
        ----------------------------
        -- end energy consumption --

        --gravity works
        if not self._is_flying or self._is_flying == 0 then
            accel.y = -automobiles_lib.gravity
        else
            local time_correction = (self.dtime/delorean.ideal_step)
            local y_accel = self._car_gravity*time_correction
            accel.y = y_accel --sets the anti gravity
        end

        if stop ~= true then
            --self.object:set_velocity(velocity)
            self.object:add_velocity(vector.multiply(accel,dtime))
            --self.object:set_acceleration(accel)
        else
            if stop == true then
                self.object:set_acceleration({x=0,y=0,z=0})
                self.object:set_velocity({x=0,y=0,z=0})
            end
        end

        self._last_ground_check = self._last_ground_check + dtime
        if self._last_ground_check > 0.18 then
            self._last_ground_check = 0
            automobiles_lib.ground_get_distances(self, 0.372, 2.6)
        end
		local newpitch = self._pitch --velocity.y * math.rad(6)

        local newroll = 0
        if self._is_flying == 1 then
            local turn_effect_speed = longit_speed
            if turn_effect_speed > 10 then turn_effect_speed = 10 end
            newroll = (-self._steering_angle/100)*(turn_effect_speed/10)
            if math.abs(self._steering_angle) < 1 then newroll = 0 end

            --pitch
            local max_pitch = 6
            local h_vel_compensation = (((longit_speed * 2) * 100)/max_pitch)/100
            if h_vel_compensation < 0 then h_vel_compensation = 0 end
            if h_vel_compensation > max_pitch then h_vel_compensation = max_pitch end
            newpitch = newpitch + (velocity.y * math.rad(max_pitch - h_vel_compensation))
        end

		self.object:set_rotation({x=newpitch,y=newyaw,z=newroll})

        --saves last velocity for collision detection (abrupt stop)
        self.lastvelocity = self.object:get_velocity()
        self._longit_speed = longit_speed

	end,]]--

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


