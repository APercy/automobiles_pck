
function automobiles_lib.on_rightclick (self, clicker)
	if not clicker or not clicker:is_player() then
		return
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
        if name == self.owner then
            if clicker:get_player_control().aux1 == true then
                automobiles_lib.show_vehicle_trunk_formspec(self, clicker, self._trunk_slots)
            else
                --is the owner, okay, lets attach
                automobiles_lib.attach_driver(self, clicker)
                -- sound
                self.sound_handle = minetest.sound_play({name = self._engine_sound},
                        {object = self.object, gain = 1.5, pitch = 1, max_hear_distance = 30, loop = true,})
            end
        else
            --minetest.chat_send_all("clicou")
            --a passenger
            if self._passenger == nil then
                --there is no passenger, so lets attach
                if self.driver_name then
                    automobiles_lib.attach_pax(self, clicker, true)
                end
            else
                --there is a passeger
                if self._passenger == name then
                    --if you are the psenger, so deattach
                    automobiles_lib.dettach_pax(self, clicker)
                end
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
    if math.abs(speed) <= 0.1 then
        if automobiles_lib.loadFuel(self, puncher:get_player_name(), false, self._max_fuel) then return end
    end
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
