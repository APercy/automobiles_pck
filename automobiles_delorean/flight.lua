function delorean.set_kit(self)
    local normal_kit = nil
    if self.normal_kit then self.normal_kit:remove() end
    local pos = self.object:get_pos()
    if self._delorean_type == 0 or self._delorean_type == nil then
        normal_kit = minetest.add_entity(pos,'automobiles_delorean:normal_kit')
        normal_kit:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.normal_kit = normal_kit
        self.normal_kit:set_properties({is_visible=true})
    elseif self._delorean_type == 1 then
        --time machine
        normal_kit = minetest.add_entity(pos,'automobiles_delorean:time_machine_kit')
        normal_kit:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.normal_kit = normal_kit
        self.normal_kit:set_properties({is_visible=true})
    end
end

function delorean.gravity_auto_correction(self, dtime)
    local factor = 1
    --minetest.chat_send_player(self.driver_name, "antes: " .. self._car_gravity)
    if self._car_gravity > 0 then factor = -1 end
    local time_correction = (dtime/delorean.ideal_step)
    local intensity = 0.2
    local correction = (intensity*factor) * time_correction
    --minetest.chat_send_player(self.driver_name, correction)
    local before_correction = self._car_gravity
    local new_car_gravity = self._car_gravity + correction
    if math.sign(before_correction) ~= math.sign(new_car_gravity) then
        self._car_gravity = 0
    else
        self._car_gravity = new_car_gravity
    end

    --now desacelerate
    if self._car_gravity == 0 then
        local curr_vel = self.object:get_velocity()
        curr_vel.y = 0
        self.object:set_velocity(curr_vel)
    end
    
    --minetest.chat_send_player(self.driver_name, "depois: " .. self._car_gravity)
end

function delorean.control_flight(self, player)
    if self._is_flying == 1 then
        local ctrl = player:get_player_control()
        if ctrl.jump then
            self._car_gravity = 5
        elseif ctrl.sneak then
            self._car_gravity = -5
        end
    end
end

function delorean.set_wheels_mode(self, angle_factor)
    if not self._is_flying or self._is_flying == 0 then
        --whell turn
        self.lf_wheel:set_attach(self.front_suspension,'',{x=-delorean.front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle-angle_factor,z=0})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=delorean.front_wheel_xpos,y=0,z=0},{x=0,y=(-self._steering_angle+angle_factor)+180,z=0})
        self.lr_wheel:set_attach(self.rear_suspension,'',{x=-delorean.rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
        self.rr_wheel:set_attach(self.rear_suspension,'',{x=delorean.rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
    else
        local extra_space = 0.5
        self.lf_wheel:set_attach(self.front_suspension,'',{x=-delorean.front_wheel_xpos-extra_space,y=0,z=0},{x=0,y=0,z=90})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=delorean.front_wheel_xpos+extra_space,y=0,z=0},{x=0,y=180,z=-90})
        self.lr_wheel:set_attach(self.rear_suspension,'',{x=-delorean.rear_wheel_xpos-extra_space,y=0,z=0},{x=0,y=0,z=90})
        self.rr_wheel:set_attach(self.rear_suspension,'',{x=delorean.rear_wheel_xpos+extra_space,y=0,z=0},{x=0,y=180,z=-90})
    end
end

function delorean.turn_flight_mode(self)
    if self._is_flying == 1 then
        --initial lift
        self._car_gravity = 5
        local curr_pos = self.object:get_pos()
        curr_pos.y = curr_pos.y + 1.5
        self.object:move_to(curr_pos)
    end
end

