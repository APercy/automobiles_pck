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
    _seat_pos = {{x=-4.25,y=7.12,z=9.5},{x=4.25,y=7.12,z=9.5}},

    _front_suspension_ent = 'automobiles_roadster:front_suspension',
    _front_suspension_pos = {x=0,y=0,z=24.22},
    _front_wheel_ent = 'automobiles_roadster:wheel',
    _front_wheel_xpos = 10.26,
    _front_wheel_frames = {x = 2, y = 13},
    _rear_suspension_ent = 'automobiles_roadster:rear_suspension',
    _rear_suspension_pos = {x=0,y=0,z=0},
    _rear_wheel_ent = 'automobiles_roadster:wheel',
    _rear_wheel_xpos = 10.26,
    _rear_wheel_frames = {x = 2, y = 13},

    _fuel_gauge_pos = {x=0,y=8.04,z=17.84},
    _gauge_pointer_ent = 'automobiles_roadster:pointer',
    _front_lights = 'automobiles_roadster:lights',

    get_staticdata = automobiles_lib.get_staticdata,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

    on_activate = automobiles_lib.on_activate,

	on_step = function(self, dtime)
        automobiles_lib.stepfunc(self, dtime)
        --[[sound play control]]--
        self._last_time_collision_snd = self._last_time_collision_snd + dtime
        if self._last_time_collision_snd > 1 then self._last_time_collision_snd = 1 end
        self._last_time_drift_snd = self._last_time_drift_snd + dtime
        if self._last_time_drift_snd > 1 then self._last_time_drift_snd = 1 end
        --[[end sound control]]--

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
            (roadster.LONGIT_DRAG_FACTOR - fuel_weight_factor) * -1 * automobiles_lib.sign(longit_speed))
        
		local later_speed = automobiles_lib.dot(velocity,nhdir)
        local later_drag = vector.multiply(nhdir,later_speed*
            later_speed*roadster.LATER_DRAG_FACTOR*-1*automobiles_lib.sign(later_speed))

        local accel = vector.add(longit_drag,later_drag)
        local stop = nil

        if self._show_rag == true then
            self.object:set_bone_position("windshield", {x=0, z=15.8317, y=15.0394}, {x=145, y=0, z=0})
            self.rag_rect:set_properties({is_visible=true})
            self.rag:set_properties({is_visible=false})
        else
            self.object:set_bone_position("windshield", {x=0, z=15.8317, y=15.0394}, {x=0, y=0, z=0})
            self.rag_rect:set_properties({is_visible=false})
            self.rag:set_properties({is_visible=true})
        end

        local player = nil
        local is_attached = false
        if self.driver_name then
            player = minetest.get_player_by_name(self.driver_name)
            
            if player then

        		local ctrl = player:get_player_control()
		        if ctrl.aux1 then
                    --sets the engine running - but sets a delay also, cause keypress
                    if self._last_time_command > 0.8 then
                        self._last_time_command = 0
                        minetest.sound_play({name = "roadster_horn"},
		                        {object = self.object, gain = 0.6, pitch = 1.0, max_hear_distance = 32, loop = false,})
                    end
		        end                


                local player_attach = player:get_attach()
                if player_attach then
                    if self.driver_seat then
                        if player_attach == self.driver_seat then is_attached = true end
                    end
                end
            end
        end

        self._last_light_move = self._last_light_move + dtime
        if self._last_light_move > 0.15 then
            self._last_light_move = 0
            if self._show_lights == true and is_attached then
                self.lights:set_properties({is_visible=true})
                automobiles_lib.put_light(self)
            else
                self.lights:set_properties({is_visible=false})
                automobiles_lib.remove_light(self)
            end
        end

        local curr_pos = self.object:get_pos()
        self.object:move_to(curr_pos)
		if is_attached then --and self.driver_name == self.owner then
            local impact = automobiles_lib.get_hipotenuse_value(velocity, self.lastvelocity)
            if impact > 1 then
                --self.damage = self.damage + impact --sum the impact value directly to damage meter
                if self._last_time_collision_snd > 0.3 then
                    self._last_time_collision_snd = 0
                    minetest.sound_play("collision", {
                        to_player = self.driver_name,
	                    --pos = curr_pos,
	                    --max_hear_distance = 5,
	                    gain = 1.0,
                        fade = 0.0,
                        pitch = 1.0,
                    })
                end
                --[[if self.damage > 100 then --if acumulated damage is greater than 100, adieu
                    automobiles_lib.destroy(self)
                end]]--
            end

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

            --control
            local steering_angle_max = 30
            local steering_speed = 40
            if math.abs(longit_speed) > 3 then
                local mid_speed = (steering_speed/2)
                steering_speed = mid_speed + mid_speed / math.abs(longit_speed*0.25)
            end
			accel, stop = automobiles_lib.control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, roadster.max_acc_factor, roadster.max_speed, steering_angle_max, steering_speed)
        else
            self._show_lights = false
            if self.sound_handle ~= nil then
	            minetest.sound_stop(self.sound_handle)
	            self.sound_handle = nil
            end
		end

        local angle_factor = self._steering_angle / 10
        self.lf_wheel:set_animation_frame_speed(longit_speed * (10 + angle_factor))
        self.rf_wheel:set_animation_frame_speed(longit_speed * (10 - angle_factor))
        self.lr_wheel:set_animation_frame_speed(longit_speed * (10 - angle_factor))
        self.rr_wheel:set_animation_frame_speed(longit_speed * (10 + angle_factor))

        --whell turn
        self.steering:set_attach(self.steering_axis,'',{x=0,y=0,z=0},{x=0,y=0,z=self._steering_angle*2})
        self.lf_wheel:set_attach(self.front_suspension,'',{x=self._front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle-angle_factor,z=0})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=-self._front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle+angle_factor,z=0})

		if math.abs(self._steering_angle)>5 then
            local turn_rate = math.rad(40)
			newyaw = yaw + dtime*(1 - 1 / (math.abs(longit_speed) + 1)) *
                self._steering_angle / 30 * turn_rate * automobiles_lib.sign(longit_speed)
		end

        --[[
        accell correction
        under some circunstances the acceleration exceeds the max value accepted by set_acceleration and
        the game crashes with an overflow, so limiting the max acceleration in each axis prevents the crash
        ]]--
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

        accel.y = -automobiles_lib.gravity

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
            automobiles_lib.ground_get_distances(self, 0.5, 2.422)
        end
		local newpitch = self._pitch --velocity.y * math.rad(6)

		if newyaw~=yaw or newpitch~=pitch then self.object:set_rotation({x=newpitch,y=newyaw,z=0}) end

        --saves last velocity for collision detection (abrupt stop)
        self.lastvelocity = self.object:get_velocity()
        self._longit_speed = longit_speed

	end,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


