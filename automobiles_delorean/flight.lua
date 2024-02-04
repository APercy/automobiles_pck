function delorean.gravity_auto_correction(self, dtime)
    local factor = 1
    --minetest.chat_send_player(self.driver_name, "antes: " .. self._car_gravity)
    if self._car_gravity > 0 then factor = -1 end
    local time_correction = (dtime/automobiles_lib.ideal_step)
    local intensity = 1
    local correction = (intensity*factor) * time_correction
    if math.abs(correction) > 1 then correction = 1 * math.sign(correction) end
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
        if curr_vel.y < 0 then
            self._car_gravity = 0.5
        else
            self._car_gravity = -0.5
        end
    end
    
    --minetest.chat_send_player(self.driver_name, "depois: " .. self._car_gravity)
end

function delorean.control_flight(self, player)
    if self._is_flying == 1 then
        local ctrl = player:get_player_control()
        local max = 6
        local min = -6
        local curr_vel = self.object:get_velocity()
        if ctrl.jump then
            if self._car_gravity < max and curr_vel.y < 2.5 then
                self._car_gravity = self._car_gravity + 1
            end
        elseif ctrl.sneak then
            if self._car_gravity > min and curr_vel.y > -2.5 then
                self._car_gravity = self._car_gravity - 1
            end
        end
    end
end

function delorean.set_wheels_mode(self, angle_factor)
    if not self._is_flying or self._is_flying == 0 then
        --whell turn
        --[[self.lf_wheel:set_attach(self.front_suspension,'',{x=-self._front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle-angle_factor,z=0})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=self._front_wheel_xpos,y=0,z=0},{x=0,y=(-self._steering_angle+angle_factor)+180,z=0})
        self.lr_wheel:set_attach(self.rear_suspension,'',{x=-self._rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
        self.rr_wheel:set_attach(self.rear_suspension,'',{x=self._rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})]]--
    else
        local extra_space = 0.5
        self.lf_wheel:set_attach(self.front_suspension,'',{x=-self._front_wheel_xpos-extra_space,y=0,z=0},{x=0,y=0,z=90})
        self.rf_wheel:set_attach(self.front_suspension,'',{x=self._front_wheel_xpos+extra_space,y=0,z=0},{x=0,y=180,z=-90})
        self.lr_wheel:set_attach(self.rear_suspension,'',{x=-self._rear_wheel_xpos-extra_space,y=0,z=0},{x=0,y=0,z=90})
        self.rr_wheel:set_attach(self.rear_suspension,'',{x=self._rear_wheel_xpos+extra_space,y=0,z=0},{x=0,y=180,z=-90})
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

function delorean.set_mode(self, is_attached, curr_pos, velocity, player, dtime)
    if self._car_type == 1 then
        local ent_propertioes = self.normal_kit:get_properties()
        if ent_propertioes.mesh ~= "automobiles_delorean_time_machine_accessories.b3d" then
            delorean.set_kit(self)
        end

        if is_attached == true then
            self.instruments:set_properties(
                {
                    textures={
                        "automobiles_metal.png", --time panel
                        "automobiles_delorean_time.png", --time panel
                        "automobiles_metal.png", -- flux capacitor
                        "automobiles_delorean_flux.png", --flux capacitor
                        "automobiles_black.png", --flux capacitor
                        "automobiles_dark_grey.png", --roof panel
                        "automobiles_delorean_roof_1.png", --root panel
                        "automobiles_delorean_roof_2.png", --roof panel
                    }, glow=15}
            )
        else
            self.instruments:set_properties(
                {
                    textures={
                        "automobiles_metal.png", --time panel
                        "automobiles_delorean_time_off.png", --time panel
                        "automobiles_metal.png", -- flux capacitor
                        "automobiles_delorean_flux_off.png", --flux capacitor
                        "automobiles_black.png", --flux capacitor
                        "automobiles_dark_grey.png", --roof panel
                        "automobiles_delorean_roof_1_off.png", --root panel
                        "automobiles_delorean_roof_2_off.png", --roof panel
                    }, glow=0}
            )
        end

        --start flight functions
        if self._is_flying == 1 then
            if is_attached then
                delorean.control_flight(self, player)
            end
            delorean.gravity_auto_correction(self, dtime)

            --check if is near the ground, so revert the flight mode
            local noded = automobiles_lib.nodeatpos(automobiles_lib.pos_shift(curr_pos,{y=-0.6}))
            if (noded and noded.drawtype ~= 'airlike') then
                if noded.drawtype ~= 'liquid' then
                    self._is_flying = 0
                end
                --avoid liquids
                if noded.drawtype == 'liquid' then
                    self._car_gravity = 5
                    local fixed_vel = velocity
                    fixed_vel.y = 0.1
                    self.lastvelocity.y = fixed_vel.y --do not compute collision after
                    self.object:set_velocity(fixed_vel)
                    --curr_pos.y = curr_pos.y + 0.5
                    --self.object:move_to(curr_pos)
                end
            end
        end
        delorean.set_wheels_mode(self, 0)
    end
end

