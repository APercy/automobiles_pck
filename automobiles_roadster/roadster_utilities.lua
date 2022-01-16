--dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_global_definitions.lua")
--dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_hud.lua")

-- destroy the roadster
function roadster.destroy(self, puncher)
    if self.sound_handle then
        minetest.sound_stop(self.sound_handle)
        self.sound_handle = nil
    end

    if self.driver_name then
        -- detach the driver first (puncher must be driver)
        puncher:set_detach()
        puncher:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
        if minetest.global_exists("player_api") then
            player_api.player_attached[self.driver_name] = nil
            -- player should stand again
            player_api.set_animation(puncher, "stand")
        end
        self.driver_name = nil
    end

    local pos = self.object:get_pos()
    if self.l_wheel then self.l_wheel:remove() end
    if self.r_wheel then self.r_wheel:remove() end
    if self.steering_base then self.steering_base:remove() end
    if self.steering_axis then self.steering_axis:remove() end
    if self.steering then self.steering:remove() end
    if self.dir_bar then self.dir_bar:remove() end

    self.object:remove()

    pos.y=pos.y+2

    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_roadster:roadster')
end

function roadster.engine_set_sound_and_animation(self, _longit_speed)
    --minetest.chat_send_all('test1 ' .. dump(self._engine_running) )
    if self.sound_handle then
        if (math.abs(self._longit_speed) > math.abs(_longit_speed) + 0.1) or (math.abs(self._longit_speed) + 0.1 < math.abs(_longit_speed)) then
            --minetest.chat_send_all('test2')
            roadster.engineSoundPlay(self)
        end
    end
end

function roadster.engineSoundPlay(self)
    --sound
    if self.sound_handle then minetest.sound_stop(self.sound_handle) end
    if self.object then
        self.sound_handle = minetest.sound_play({name = "roadster_engine"},
            {object = self.object, gain = 0.5,
                pitch = 0.5 + ((self._longit_speed/10)/2),
                max_hear_distance = 10,
                loop = true,})
    end
end
