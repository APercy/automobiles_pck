--global constants

function delorean.control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, max_acc_factor, max_speed, steering_limit, steering_speed)
    self._last_time_command = self._last_time_command + dtime
    if self._last_time_command > 1 then self._last_time_command = 1 end

	local player = minetest.get_player_by_name(self.driver_name)
    local retval_accel = accel;
    local stop = false
    
	-- player control
	if player then
		local ctrl = player:get_player_control()
		
        local acc = 0
        if self._energy > 0 then
            if longit_speed < max_speed and ctrl.up then
                --get acceleration factor
                acc = automobiles_lib.check_road_is_ok(self.object, max_acc_factor)
                --minetest.chat_send_all('engineacc: '.. engineacc)
                if acc > 1 and acc < max_acc_factor and longit_speed > 0 then
                    --improper road will reduce speed
                    acc = -1
                end
            end

            --reversing
            if not self._is_flying or self._is_flying == 0 then
	            if ctrl.sneak and longit_speed <= 1.0 and longit_speed > -1.0 then
                    acc = -2
	            end
            end
        end

        --break
        if ctrl.down then
            --[[if math.abs(longit_speed) > 0 then
                acc = -5 / (longit_speed / 2) -- lets set a brake efficience based on speed
            end]]--
        
            --total stop
            --wheel break
            if not self._is_flying or self._is_flying == 0 then
                if longit_speed > 0 then
                    acc = -5
                    --[[if (longit_speed + acc) < 0 then
                        acc = longit_speed * -1
                    end]]--
                end

                if longit_speed < 0 then
                    acc = 5
                    if (longit_speed + acc) > 0 then
                        acc = longit_speed * -1
                    end
                end
                if math.abs(longit_speed) < 0.2 then
                    stop = true
                end
            else
                acc = -5
            end
        end

        if acc then retval_accel=vector.add(accel,vector.multiply(hull_direction,acc)) end

		-- yaw
        local yaw_cmd = 0
        if self._yaw_by_mouse == true then
		    local rot_y = math.deg(player:get_look_horizontal())
            self._steering_angle = automobiles_lib.set_yaw_by_mouse(self, rot_y, steering_limit)
        else
		    -- steering
		    if ctrl.right then
			    self._steering_angle = math.max(self._steering_angle-steering_speed*dtime,-steering_limit)
		    elseif ctrl.left then
			    self._steering_angle = math.min(self._steering_angle+steering_speed*dtime,steering_limit)
            else
                --center steering
                if longit_speed > 0 then
                    local factor = 1
                    if self._steering_angle > 0 then factor = -1 end
                    local correction = (steering_limit*(longit_speed/75)) * factor
                    local before_correction = self._steering_angle
                    self._steering_angle = self._steering_angle + correction
                    if math.sign(before_correction) ~= math.sign(self._steering_angle) then self._steering_angle = 0 end
                end
		    end
        end

        local angle_factor = self._steering_angle / 60
        if angle_factor < 0 then angle_factor = angle_factor * -1 end
        local deacc_on_curve = longit_speed * angle_factor
        deacc_on_curve = deacc_on_curve * -1
        if deacc_on_curve then retval_accel=vector.add(retval_accel,vector.multiply(hull_direction,deacc_on_curve)) end
    
	end

    return retval_accel, stop
end


