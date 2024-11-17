minetest.register_entity('automobiles_lib:pivot_mesh',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pivot_mesh.b3d",
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

minetest.register_entity('automobiles_lib:pointer',{
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

function automobiles_lib.on_rightclick (self, clicker)
	if not clicker or not clicker:is_player() then
		--return
	end

	local name = clicker:get_player_name()
    --[[if self.owner and self.owner ~= name and self.owner ~= "" then return end]]--
    if self.owner == "" then
        self.owner = name
    end
    
	if name == self.driver_name then
        local formspec_f = automobiles_lib.driver_formspec
        if self._formspec_function then formspec_f = self._formspec_function end
        formspec_f(name)
	else
        if name == self.owner or
            (self.driver_name == nil and
            ( minetest.check_player_privs(clicker, "valet_parking") or minetest.check_player_privs(clicker, {server=true}) )
            ) then
            if clicker:get_player_control().aux1 == true then
                automobiles_lib.show_vehicle_trunk_formspec(self, clicker, self._trunk_slots)
            else
                --is the owner, okay, lets attach
                local attach_driver_f = automobiles_lib.attach_driver
                if self._attach then attach_driver_f = self._attach end
                attach_driver_f(self, clicker)
                -- sound
                local base_pitch = 1
                if self._base_pitch then base_pitch = self._base_pitch end
                self.sound_handle = minetest.sound_play({name = self._engine_sound},
                        {object = self.object, gain = 1, pitch = base_pitch, max_hear_distance = 30, loop = true,})
            end
        else
            --minetest.chat_send_all("clicou")
            --a passenger
            if not player_api.player_attached[name] then
                --there is no passenger, so lets attach
                if self.driver_name then
                    local attach_pax_f = automobiles_lib.attach_pax
                    if self._attach_pax then attach_pax_f = self._attach_pax end
                    attach_pax_f(self, clicker, true)
                end
            else
                --there is a passenger
                --if you are the passenger, so deattach
                local dettach_pax_f = automobiles_lib.dettach_pax
                if self._dettach_pax then dettach_pax_f = self._dettach_pax end
                dettach_pax_f(self, clicker)
            end
        end
	end
end

function automobiles_lib.on_punch (self, puncher, ttime, toolcaps, dir, damage)
	if not puncher or not puncher:is_player() then
		return
	end

	local name = puncher:get_player_name()
    --[[if self.owner and self.owner ~= name and self.owner ~= "" then return end]]--
    if self.owner == nil then
        self.owner = name
    end
    	
    if self.driver_name and self.driver_name ~= name then
		-- do not allow other players to remove the object while there is a driver
		return
	end
    
    local is_attached = false
    if puncher:get_attach() == self.driver_seat then is_attached = true end

    local itmstck=puncher:get_wielded_item()
    local item_name = ""
    if itmstck then item_name = itmstck:get_name() end

    --refuel procedure
    --[[
    refuel works it car is stopped and engine is off
    ]]--
    local velocity = self.object:get_velocity()
    local speed = automobiles_lib.get_hipotenuse_value(vector.new(), velocity)
    --if math.abs(speed) <= 0.1 then
    local was_refueled = automobiles_lib.loadFuel(self, puncher:get_player_name(), false, self._max_fuel)
    if was_refueled then
        return
    end
    --end
    -- end refuel

    if is_attached == false then

        -- deal with painting or destroying
	    if itmstck then
            --race status restart
            if item_name == "checkpoints:status_restarter" and self._engine_running == false then
                --restart race current status
                self._last_checkpoint = ""
                self._total_laps = -1
                self._race_id = ""
                return
            end

            local paint_f = automobiles_lib.set_paint
            if self._painting_function then paint_f = self._painting_function end
            if paint_f(self, puncher, itmstck) == false then
                local is_admin = false
                is_admin = minetest.check_player_privs(puncher, {server=true})
                --minetest.chat_send_all('owner '.. self.owner ..' - name '.. name)
			    if not self.driver and (self.owner == name or is_admin == true) and toolcaps and
                        toolcaps.damage_groups and toolcaps.damage_groups.fleshy then
                    self.hp = self.hp - 10
                    minetest.sound_play("automobiles_collision", {
                        object = self.object,
                        max_hear_distance = 5,
                        gain = 1.0,
                        fade = 0.0,
                        pitch = 1.0,
                    })
			    end
		    end
        end

        if self.hp <= 0 then
            local destroy_f = automobiles_lib.destroy
            if self._destroy_function then destroy_f = self._destroy_function end
            destroy_f(self)
        end

    end
end

function automobiles_lib.get_staticdata(self) 
    return minetest.serialize({
        stored_owner = self.owner,
        stored_hp = self.hp,
        stored_color = self._color,
        stored_det_color = self._det_color,
        stored_steering = self._steering_angle,
        stored_energy = self._energy,
        stored_rag = self._show_rag,
        stored_pitch = self._pitch,
        stored_light_old_pos = self._light_old_pos,
        stored_inv_id = self._inv_id,
        stored_car_type = self._car_type,
        stored_car_gravity = self._car_gravity,
        --race data
        stored_last_checkpoint = self._last_checkpoint,
        stored_total_laps = self._total_laps,
        stored_race_id = self._race_id,
    })
end

function automobiles_lib.on_activate(self, staticdata, dtime_s)
    if staticdata ~= "" and staticdata ~= nil then
        local data = minetest.deserialize(staticdata) or {}
        self.owner = data.stored_owner
        self.hp = data.stored_hp
        self._color = data.stored_color
        self._det_color = data.stored_det_color
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

        self._car_type = data.stored_car_type
        self._car_gravity = data.stored_car_gravity or -automobiles_lib.gravity

        automobiles_lib.setText(self, self._vehicle_name)
        if data.remove then
            automobiles_lib.destroy_inventory(self)
            self.object:remove()
            return
        end
    end

    if self._painting_load then
        self._painting_load(self, self._color)
    else
        automobiles_lib.paint(self, self._color)
    end
    local pos = self.object:get_pos()

    local front_suspension=minetest.add_entity(self.object:get_pos(),self._front_suspension_ent)
    front_suspension:set_attach(self.object,'',self._front_suspension_pos,{x=0,y=0,z=0})
    self.front_suspension = front_suspension

    if self._front_wheel_ent then
        local lf_wheel=minetest.add_entity(pos,self._front_wheel_ent)
        lf_wheel:set_attach(self.front_suspension,'',{x=-self._front_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
	    -- set the animation once and later only change the speed
        lf_wheel:set_animation(self._front_wheel_frames, 0, 0, true)
        self.lf_wheel = lf_wheel

        local rf_wheel=minetest.add_entity(pos,self._front_wheel_ent)
        rf_wheel:set_attach(self.front_suspension,'',{x=self._front_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
	    -- set the animation once and later only change the speed
        rf_wheel:set_animation(self._front_wheel_frames, 0, 0, true)
        self.rf_wheel = rf_wheel
    end

    local rear_suspension=minetest.add_entity(self.object:get_pos(),self._rear_suspension_ent)
    rear_suspension:set_attach(self.object,'',self._rear_suspension_pos,{x=0,y=0,z=0})
    self.rear_suspension = rear_suspension

    if self._rear_wheel_ent then
        local lr_wheel=minetest.add_entity(pos,self._rear_wheel_ent)
        lr_wheel:set_attach(self.rear_suspension,'',{x=-self._rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
	    -- set the animation once and later only change the speed
        lr_wheel:set_animation(self._rear_wheel_frames, 0, 0, true)
        self.lr_wheel = lr_wheel

        local rr_wheel=minetest.add_entity(pos,self._rear_wheel_ent)
        rr_wheel:set_attach(self.rear_suspension,'',{x=self._rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
	    -- set the animation once and later only change the speed
        rr_wheel:set_animation(self._rear_wheel_frames, 0, 0, true)
        self.rr_wheel = rr_wheel
    end


    if self._steering_ent then
	    local steering_axis=minetest.add_entity(pos,'automobiles_lib:pivot_mesh')
        steering_axis:set_attach(self.object,'',self._drive_wheel_pos,{x=self._drive_wheel_angle,y=0,z=0})
	    self.steering_axis = steering_axis

	    local steering=minetest.add_entity(self.steering_axis:get_pos(), self._steering_ent)
        steering:set_attach(self.steering_axis,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.steering = steering
    else
        self.object:set_bone_position("drive_adjust", self._drive_wheel_pos, {x=self._drive_wheel_angle, y=0, z=0}) 
    end

    if self._rag_retracted_ent then
        local rag_rect=minetest.add_entity(self.object:get_pos(),self._rag_retracted_ent)
	    rag_rect:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.rag_rect = rag_rect
        self.rag_rect:set_properties({is_visible=false})
    end

    if self._rag_extended_ent then
        local rag=minetest.add_entity(self.object:get_pos(),self._rag_extended_ent)
	    rag:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.rag = rag
    end

    automobiles_lib.seats_create(self)

    local pointer_entity = 'automobiles_lib:pointer'
    if self._gauge_pointer_ent then pointer_entity = self._gauge_pointer_ent end
    if self._fuel_gauge_pos then
        local fuel_gauge=minetest.add_entity(pos, pointer_entity)
        fuel_gauge:set_attach(self.object,'',self._fuel_gauge_pos,{x=0,y=0,z=0})
        self.fuel_gauge = fuel_gauge
    end

    if self._front_lights then
        local lights = minetest.add_entity(pos,self._front_lights)
        lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.lights = lights
        self.lights:set_properties({is_visible=true})
    end

    if self._rear_lights then
        local r_lights = minetest.add_entity(pos,self._rear_lights)
        r_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.r_lights = r_lights
        self.r_lights:set_properties({is_visible=true})
    end

    if self._reverse_lights then
        local reverse_lights = minetest.add_entity(pos,self._reverse_lights)
        reverse_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.reverse_lights = reverse_lights
        self.reverse_lights:set_properties({is_visible=true})
    end

    if self._turn_left_lights then
        local turn_l_light = minetest.add_entity(pos,self._turn_left_lights)
        turn_l_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.turn_l_light = turn_l_light
        self.turn_l_light:set_properties({is_visible=true})
    end

    if self._turn_right_lights then
        local turn_r_light = minetest.add_entity(pos,self._turn_right_lights)
        turn_r_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.turn_r_light = turn_r_light
        self.turn_r_light:set_properties({is_visible=true})
    end

    if self._extra_items_function then
        self._extra_items_function(self)
    end

	self.object:set_armor_groups({immortal=1})

	local inv = minetest.get_inventory({type = "detached", name = self._inv_id})
	-- if the game was closed the inventories have to be made anew, instead of just reattached
	if not inv then
        automobiles_lib.create_inventory(self, self._trunk_slots)
	else
	    self.inv = inv
    end

    automobiles_lib.actfunc(self, staticdata, dtime_s)
end

function automobiles_lib.on_step(self, dtime)
    automobiles_lib.stepfunc(self, dtime)
    --[[sound play control]]--
    self._last_time_collision_snd = self._last_time_collision_snd + dtime
    if self._last_time_collision_snd > 1 then self._last_time_collision_snd = 1 end
    self._last_time_drift_snd = self._last_time_drift_snd + dtime
    if self._last_time_drift_snd > 2.0 then self._last_time_drift_snd = 2.0 end
    --[[end sound control]]--

    --in case it's not declared
    self._max_acc_factor = self._max_acc_factor or 1

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
        (self._LONGIT_DRAG_FACTOR - fuel_weight_factor) * -1 * automobiles_lib.sign(longit_speed))
    
	local later_speed = automobiles_lib.dot(velocity,nhdir)
    local dynamic_later_drag = self._LATER_DRAG_FACTOR
    if longit_speed > 2 then dynamic_later_drag = 2.0 end
    if longit_speed > 8 then dynamic_later_drag = 0.5 end

    if automobiles_lib.extra_drift and longit_speed > 4 then
        dynamic_later_drag = dynamic_later_drag/(longit_speed*2)
    end

    local later_drag = 0
    if self._is_motorcycle == true then
        later_drag = vector.multiply(nhdir,later_speed*
            later_speed*self._LATER_DRAG_FACTOR*-1*automobiles_lib.sign(later_speed))
    else
        later_drag = vector.multiply(nhdir,later_speed*
        later_speed*dynamic_later_drag*-1*automobiles_lib.sign(later_speed))
    end

    local accel = vector.add(longit_drag,later_drag)
    local stop = nil
    local curr_pos = self.object:get_pos()

    if self._show_rag == true then
        if self._windshield_pos and self._windshield_ext_rotation then
            self.object:set_bone_position("windshield", self._windshield_pos, self._windshield_ext_rotation) --extended
        end
        if self.rag_rect then self.rag_rect:set_properties({is_visible=true}) end
        if self.rag then self.rag:set_properties({is_visible=false}) end
    else
        if self._windshield_pos then
            self.object:set_bone_position("windshield", self._windshield_pos, {x=0, y=0, z=0}) --retracted
        end
        if self.rag_rect then self.rag_rect:set_properties({is_visible=false}) end
        if self.rag then self.rag:set_properties({is_visible=true}) end
    end

    local player = nil
    local is_attached = false
    if self.driver_name then
        player = minetest.get_player_by_name(self.driver_name)
        
        if player then
            local player_attach = player:get_attach()
            if player_attach then
                if self.driver_seat then
                    if player_attach == self.driver_seat or player_attach == self.object then is_attached = true end
                end
            end
        end
    end

    --for flying
    if self._setmode then
        self._setmode(self, is_attached, curr_pos, velocity, player, dtime)
    end

    local is_braking = false
    if is_attached then
		local ctrl = player:get_player_control()
        if ctrl.jump then
            dynamic_later_drag = 0.2
        end
        if ctrl.aux1 then
            --sets the engine running - but sets a delay also, cause keypress
            if self._last_time_command > 0.8 then
                self._last_time_command = 0
                local horn_sound = "automobiles_horn"
                if self._horn_sound then horn_sound = self._horn_sound end
                minetest.sound_play({name = horn_sound},
                        {object = self.object, gain = 0.6, pitch = 1.0, max_hear_distance = 32, loop = false,})
            end
        end
        if ctrl.down then
            is_braking = true
            if self.r_lights then self.r_lights:set_properties({textures={"automobiles_rear_lights_full.png"}, glow=15}) end
        end
        if self.reverse_lights then
            if ctrl.sneak then
                self.reverse_lights:set_properties({textures={"automobiles_white.png"}, glow=15})
            else
                self.reverse_lights:set_properties({textures={"automobiles_grey.png"}, glow=0})
            end
        end
    end

    self._last_light_move = self._last_light_move + dtime
    if self._last_light_move > 0.15 then
        self._last_light_move = 0
        if self.lights then
            if self._show_lights == true then
                --self.lights:set_properties({is_visible=true})
                self.lights:set_properties({textures={"automobiles_front_lights.png"}, glow=15})
                if is_braking == false then
                    if self.r_lights then self.r_lights:set_properties({textures={"automobiles_rear_lights.png"}, glow=10}) end
                end
                automobiles_lib.put_light(self)
            else
                --self.lights:set_properties({is_visible=false})
                self.lights:set_properties({textures={"automobiles_grey.png"}, glow=0})
                if is_braking == false then
                    if self.r_lights then self.r_lights:set_properties({textures={"automobiles_rear_lights_off.png"}, glow=0}) end
                end
                automobiles_lib.remove_light(self)
            end
        end
    end

    -- impacts and control
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

        --control
        local steering_angle_max = 40
        local steering_speed = 40
        if math.abs(longit_speed) > 3 then
            local mid_speed = (steering_speed/2)
            steering_speed = mid_speed + mid_speed / math.abs(longit_speed*0.25)
        end

        --adjust engine parameter (transmission emulation)
        local acc_factor = self._max_acc_factor
        local transmission_state = automobiles_lib.get_transmission_state(longit_speed, self._max_speed)

        local target_acc_factor = acc_factor

        if self._have_transmission ~= false then
            if transmission_state == 1 then
                target_acc_factor = (self._max_acc_factor/3)
            end
            if transmission_state == 2 then
                target_acc_factor = (self._max_acc_factor/2)
            end
            self._transmission_state = transmission_state
        end
        --core.chat_send_all(transmission_state)

        --control
        local control = automobiles_lib.control
        if self._control_function then
            control = self._control_function
        end
		accel, stop = control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, target_acc_factor, self._max_speed, steering_angle_max, steering_speed)
    else
        self._show_lights = false
        if self.sound_handle ~= nil then
            minetest.sound_stop(self.sound_handle)
            self.sound_handle = nil
        end
	end

    local angle_factor = self._steering_angle / 10

    --whell turn
    if self.lf_wheel and self.rf_wheel and self.lr_wheel and self.rr_wheel and self._is_flying ~= 1 then
        self.lf_wheel:set_attach(self.front_suspension,'',{x=-self._front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle-angle_factor,z=0})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=self._front_wheel_xpos,y=0,z=0},{x=0,y=(-self._steering_angle+angle_factor)+180,z=0})
        self.lr_wheel:set_attach(self.rear_suspension,'',{x=-self._rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
        self.rr_wheel:set_attach(self.rear_suspension,'',{x=self._rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
    end

    --check if the tyres is touching the pavement
    local noded = automobiles_lib.nodeatpos(automobiles_lib.pos_shift(curr_pos,{y=self.initial_properties.collisionbox[2]-0.5}))
    if (noded and noded.drawtype ~= 'airlike') then
        if noded.drawtype ~= 'liquid' then
            local wheel_compensation = longit_speed * (self._wheel_compensation or 1)
            if self.lf_wheel then self.lf_wheel:set_animation_frame_speed( wheel_compensation * (12 - angle_factor)) end
            if self.rf_wheel then self.rf_wheel:set_animation_frame_speed(-wheel_compensation * (12 + angle_factor)) end
            if self.lr_wheel then self.lr_wheel:set_animation_frame_speed( wheel_compensation * (12 - angle_factor)) end
            if self.rr_wheel then self.rr_wheel:set_animation_frame_speed(-wheel_compensation * (12 + angle_factor)) end
        end
    else
        --is flying
        if self.lf_wheel then self.lf_wheel:set_animation_frame_speed(0) end
        if self.rf_wheel then self.rf_wheel:set_animation_frame_speed(0) end
        if self.lr_wheel then self.lr_wheel:set_animation_frame_speed(0) end
        if self.rr_wheel then self.rr_wheel:set_animation_frame_speed(0) end
    end

    --drive wheel turn
    if self._steering_ent then
        self.steering:set_attach(self.steering_axis,'',{x=0,y=0,z=0},{x=0,y=0,z=self._steering_angle*2})
    else
        self.object:set_bone_position("drive_wheel", {x=-0, y=0, z=0}, {x=0, y=0, z=-self._steering_angle*2})
    end


	if math.abs(self._steering_angle)>5 then
        local turn_rate = math.rad(40)
		newyaw = yaw + dtime*(1 - 1 / (math.abs(longit_speed) + 1)) *
            self._steering_angle / 30 * turn_rate * automobiles_lib.sign(longit_speed)
	end

    --turn light
    if self.turn_l_light and self.turn_r_light then
        self._turn_light_timer = self._turn_light_timer + dtime
        if math.abs(self._steering_angle) > 15 and self._turn_light_timer >= 1 then
            self._turn_light_timer = 0
            --set turn light
            --minetest.chat_send_all(self._steering_angle)
            local textures_l = self._textures_turn_lights_on or {"automobiles_rear_lights_full.png"}
            if self._steering_angle < 0 then
                --minetest.chat_send_all("direita")
                self.turn_r_light:set_properties({textures=textures_l, glow=20})
            end
            if self._steering_angle > 0 then
                --minetest.chat_send_all("esquerda")
                self.turn_l_light:set_properties({textures=textures_l, glow=20})
            end
        end
        if self._turn_light_timer > 0.5 then
            local textures_l = self._textures_turn_lights_off or {"automobiles_rear_lights_off.png"}
            self.turn_l_light:set_properties({textures=textures_l, glow=0})
            self.turn_r_light:set_properties({textures=textures_l, glow=0})
        end
        if self._turn_light_timer > 1 then
            self._turn_light_timer = 1
        end
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
        if automobiles_lib.is_drift_game == false then
            local consumption = 40000
            if self._consumption_divisor then
                consumption = self._consumption_divisor
            end
            local consumed_power = acceleration/consumption
            self._energy = self._energy - consumed_power;
        else
            self._energy = 5
        end
    end
    if self._energy <= 0 then
        self._engine_running = false
        self._is_flying = 0
        if self.sound_handle then
            minetest.sound_stop(self.sound_handle)
            self.sound_handle = nil
            minetest.chat_send_player(self.driver_name, "Out of fuel")
        end
    else
        self._last_engine_sound_update = self._last_engine_sound_update + dtime
        if self._last_engine_sound_update > 0.300 then
            self._last_engine_sound_update = 0
            automobiles_lib.engine_set_sound_and_animation(self, longit_speed)
        end
    end

    local energy_indicator_angle = automobiles_lib.get_gauge_angle(self._energy)
    if self.fuel_gauge then
        self.fuel_gauge:set_attach(self.object,'',self._fuel_gauge_pos,{x=0,y=0,z=energy_indicator_angle})
    end
    ----------------------------
    -- end energy consumption --

    --gravity works
    if not self._is_flying or self._is_flying == 0 then
        accel.y = -automobiles_lib.gravity
    else
        local time_correction = (self.dtime/automobiles_lib.ideal_step)
        local y_accel = self._car_gravity*time_correction
        accel.y = y_accel --sets the anti gravity
    end

    if stop == true then
        self._last_accel = vector.new() --self.object:get_acceleration()
        self.object:set_acceleration({x=0,y=0,z=0})
        self.object:set_velocity({x=0,y=0,z=0})
    else
        self._last_accel = accel
        self.object:move_to(curr_pos)
        --airutils.set_acceleration(self.object, new_accel)
        local limit = (self._max_speed/self.dtime)
        if accel.y > limit then accel.y = limit end --it isn't a rocket :/
    end

    self._last_ground_check = self._last_ground_check + dtime
    if self._last_ground_check > 0.18 then
        self._last_ground_check = 0
        automobiles_lib.ground_get_distances(self, 0.372, (self._front_suspension_pos.z)/10)
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
    else
        local turn_effect_speed = longit_speed
        if self._is_motorcycle then
            if turn_effect_speed > 20 then turn_effect_speed = 20 end
            newroll = (-self._steering_angle/100)*(turn_effect_speed/10)

            if is_attached == false and stop == true then
                newroll = self._stopped_roll
            end
        else
            if turn_effect_speed > 10 then turn_effect_speed = 10 end
            if math.abs(longit_speed) > 0 then
                --local tilt_effect = (-self._steering_angle/100)*(turn_effect_speed/30)
                local max_tilt = 10
                local tilt_effect = (-later_speed/12)*(turn_effect_speed/30)
                local tire_burn = false
                if tilt_effect > max_tilt then
                    tilt_effect = max_tilt
                end
                if tilt_effect < -max_tilt then
                    tilt_effect = -max_tilt
                end 
                newroll = tilt_effect * -1
                self.front_suspension:set_rotation({x=0,y=0,z=tilt_effect})
                self.rear_suspension:set_rotation({x=0,y=0,z=tilt_effect})


                if (noded and noded.drawtype ~= 'airlike') then
                    if noded.drawtype ~= 'liquid' then
                        local min_later_speed = self._min_later_speed or 3
                        local speed_for_smoke = min_later_speed / 2
                        if (later_speed > speed_for_smoke or later_speed < -speed_for_smoke) and not self._is_motorcycle then
                            automobiles_lib.add_smoke(curr_pos, yaw, self._rear_wheel_xpos)
                            if automobiles_lib.extra_drift == false then  --disables the sound when playing drift game.. it's annoying
                                if self._last_time_drift_snd >= 2.0 and (later_speed > min_later_speed or later_speed < -min_later_speed) then
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
                            end
                        end
                    end
                end


            else
                self.front_suspension:set_rotation({x=0,y=0,z=0})
                self.rear_suspension:set_rotation({x=0,y=0,z=0})
            end
        end
    end

	self.object:set_rotation({x=newpitch,y=newyaw,z=newroll})

    self._longit_speed = longit_speed
end
