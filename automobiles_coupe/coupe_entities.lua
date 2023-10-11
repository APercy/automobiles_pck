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

minetest.register_entity('automobiles_coupe:rear_suspension',{
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

minetest.register_entity('automobiles_coupe:pivot_mesh',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
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

minetest.register_entity('automobiles_coupe:pointer',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pointer.b3d",
    visual_size = {x = 0.5, y = 0.5, z = 0.5},
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

    get_staticdata = function(self) -- unloaded/unloads ... is now saved
        return minetest.serialize({
            stored_owner = self.owner,
            stored_hp = self.hp,
            stored_color = self._color,
            stored_steering = self._steering_angle,
            stored_energy = self._energy,
            --race data
            stored_last_checkpoint = self._last_checkpoint,
            stored_total_laps = self._total_laps,
            stored_race_id = self._race_id,
            stored_rag = self._show_rag,
            stored_pitch = self._pitch,
            stored_light_old_pos = self._light_old_pos,
            stored_inv_id = self._inv_id,
        })
    end,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

	on_activate = function(self, staticdata, dtime_s)
        if staticdata ~= "" and staticdata ~= nil then
            local data = minetest.deserialize(staticdata) or {}
            self.owner = data.stored_owner
            self.hp = data.stored_hp
            self._color = data.stored_color
            self._steering_angle = data.stored_steering
            self._energy = data.stored_energy
            --minetest.debug("loaded: ", self.energy)
            --race data
            self._last_checkpoint = data.stored_last_checkpoint
            self._total_laps = data.stored_total_laps
            self._race_id = data.stored_race_id
            self._show_rag = data.stored_rag
            self._pitch = data.stored_pitch
            self._light_old_pos = data.stored_light_old_pos
            self._inv_id = data.stored_inv_id
            automobiles_lib.setText(self, "Coupe")
        end

        self.object:set_animation({x = 1, y = 8}, 0, 0, true)

        automobiles_lib.paint(self, self._color)
        local pos = self.object:get_pos()

        local front_suspension=minetest.add_entity(self.object:get_pos(),'automobiles_coupe:front_suspension')
	    front_suspension:set_attach(self.object,'',{x=0,y=1.5,z=24.5},{x=0,y=0,z=0})
	    self.front_suspension = front_suspension

	    local lf_wheel=minetest.add_entity(pos,'automobiles_lib:wheel')
	    lf_wheel:set_attach(self.front_suspension,'',{x=-coupe.front_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
		-- set the animation once and later only change the speed
        lf_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.lf_wheel = lf_wheel

	    local rf_wheel=minetest.add_entity(pos,'automobiles_lib:wheel')
	    rf_wheel:set_attach(self.front_suspension,'',{x=coupe.front_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
		-- set the animation once and later only change the speed
        rf_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.rf_wheel = rf_wheel

        local rear_suspension=minetest.add_entity(self.object:get_pos(),'automobiles_coupe:rear_suspension')
	    rear_suspension:set_attach(self.object,'',{x=0,y=1.5,z=0},{x=0,y=0,z=0})
	    self.rear_suspension = rear_suspension

	    local lr_wheel=minetest.add_entity(pos,'automobiles_lib:wheel')
	    lr_wheel:set_attach(self.rear_suspension,'',{x=-coupe.rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
		-- set the animation once and later only change the speed
        lr_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.lr_wheel = lr_wheel

	    local rr_wheel=minetest.add_entity(pos,'automobiles_lib:wheel')
	    rr_wheel:set_attach(self.rear_suspension,'',{x=coupe.rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
		-- set the animation once and later only change the speed
        rr_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.rr_wheel = rr_wheel

	    local steering_axis=minetest.add_entity(pos,'automobiles_coupe:pivot_mesh')
        steering_axis:set_attach(self.object,'',{x=-4.26,y=6.01,z=14.18},{x=15,y=0,z=0})
	    self.steering_axis = steering_axis

	    local steering=minetest.add_entity(self.steering_axis:get_pos(),'automobiles_coupe:steering')
        steering:set_attach(self.steering_axis,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.steering = steering

	    local driver_seat=minetest.add_entity(pos,'automobiles_coupe:pivot_mesh')
        driver_seat:set_attach(self.object,'',{x=-4.25,y=0.48,z=9.5},{x=0,y=0,z=0})
	    self.driver_seat = driver_seat

	    local passenger_seat=minetest.add_entity(pos,'automobiles_coupe:pivot_mesh')
        passenger_seat:set_attach(self.object,'',{x=4.25,y=0.48,z=9.5},{x=0,y=0,z=0})
	    self.passenger_seat = passenger_seat

        local fuel_gauge=minetest.add_entity(pos,'automobiles_coupe:pointer')
        fuel_gauge:set_attach(self.object,'',COUPE_GAUGE_FUEL_POSITION,{x=0,y=0,z=0})
        self.fuel_gauge = fuel_gauge

        local lights = minetest.add_entity(pos,'automobiles_coupe:f_lights')
	    lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.lights = lights
        self.lights:set_properties({is_visible=true})

        local r_lights = minetest.add_entity(pos,'automobiles_coupe:r_lights')
	    r_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.r_lights = r_lights
        self.r_lights:set_properties({is_visible=true})

        local reverse_lights = minetest.add_entity(pos,'automobiles_coupe:reverse_lights')
	    reverse_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.reverse_lights = reverse_lights
        self.reverse_lights:set_properties({is_visible=true})

        local turn_l_light = minetest.add_entity(pos,'automobiles_coupe:turn_left_light')
	    turn_l_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.turn_l_light = turn_l_light
        self.turn_l_light:set_properties({is_visible=true})

        local turn_r_light = minetest.add_entity(pos,'automobiles_coupe:turn_right_light')
	    turn_r_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.turn_r_light = turn_r_light
        self.turn_r_light:set_properties({is_visible=true})

		self.object:set_armor_groups({immortal=1})

		local inv = minetest.get_inventory({type = "detached", name = self._inv_id})
		-- if the game was closed the inventories have to be made anew, instead of just reattached
		if not inv then
            automobiles_lib.create_inventory(self, self._trunk_slots)
		else
		    self.inv = inv
        end


        automobiles_lib.actfunc(self, staticdata, dtime_s)
	end,

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
            (coupe.LONGIT_DRAG_FACTOR - fuel_weight_factor) * -1 * automobiles_lib.sign(longit_speed))
        
		local later_speed = automobiles_lib.dot(velocity,nhdir)
        local later_drag = vector.multiply(nhdir,later_speed*
            later_speed*coupe.LATER_DRAG_FACTOR*-1*automobiles_lib.sign(later_speed))

        local accel = vector.add(longit_drag,later_drag)
        local stop = nil

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
                self.lights:set_properties({textures={"automobiles_coupe_lights.png"}, glow=15})
                if is_breaking == false then
                    self.r_lights:set_properties({textures={"automobiles_rear_lights.png"}, glow=10})
                end
                automobiles_lib.put_light(self)
            else
                --self.lights:set_properties({is_visible=false})
                self.lights:set_properties({textures={"automobiles_grey.png"}, glow=0})
                if is_breaking == false then
                    self.r_lights:set_properties({textures={"automobiles_rear_lights_off.png"}, glow=0})
                end
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
			accel, stop = automobiles_lib.control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, coupe.max_acc_factor, coupe.max_speed, steering_angle_max, steering_speed)
        else
            self._show_lights = false
            if self.sound_handle ~= nil then
	            minetest.sound_stop(self.sound_handle)
	            self.sound_handle = nil
            end
		end

        local angle_factor = self._steering_angle / 10
        self.lf_wheel:set_animation_frame_speed(longit_speed * (12 - angle_factor))
        self.rf_wheel:set_animation_frame_speed(-longit_speed * (12 + angle_factor))
        self.lr_wheel:set_animation_frame_speed(longit_speed * (12 - angle_factor))
        self.rr_wheel:set_animation_frame_speed(-longit_speed * (12 + angle_factor))

        --whell turn
        self.steering:set_attach(self.steering_axis,'',{x=0,y=0,z=0},{x=0,y=0,z=self._steering_angle*2})
        self.lf_wheel:set_attach(self.front_suspension,'',{x=-coupe.front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle-angle_factor,z=0})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=coupe.front_wheel_xpos,y=0,z=0},{x=0,y=(-self._steering_angle+angle_factor)+180,z=0})

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
            if self._steering_angle < 0 then
                self.turn_r_light:set_properties({textures={"automobiles_turn_on.png"}, glow=20})
            end
            if self._steering_angle > 0 then
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
        self.fuel_gauge:set_attach(self.object,'',COUPE_GAUGE_FUEL_POSITION,{x=0,y=0,z=energy_indicator_angle})
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
            automobiles_lib.ground_get_distances(self, 0.372, 2.3)
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


