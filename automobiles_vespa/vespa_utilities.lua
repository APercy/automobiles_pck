--dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_global_definitions.lua")
--dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_hud.lua")

-- destroy the vespa
function vespa.destroy(self, puncher)
    automobiles_lib.remove_light(self)
    if self.sound_handle then
        minetest.sound_stop(self.sound_handle)
        self.sound_handle = nil
    end

    if self.driver_name then
        -- detach the driver first (puncher must be driver)
        if puncher then
            puncher:set_detach()
            puncher:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
            if minetest.global_exists("player_api") then
                player_api.player_attached[self.driver_name] = nil
                -- player should stand again
                player_api.set_animation(puncher, "stand")
            end
        end
        self.driver_name = nil
    end

    local pos = self.object:get_pos()

    if self.driver_seat then self.driver_seat:remove() end
    if self.passenger_seat then self.passenger_seat:remove() end
    if self.lights then self.lights:remove() end
    if self.rlights then self.rlights:remove() end
    if self.driver_mesh then self.driver_mesh:remove() end
    if self.pax_mesh then self.pax_mesh:remove() end

    automobiles_lib.destroy_inventory(self)
    self.object:remove()

    pos.y=pos.y+2

    --minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_vespa:vespa')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:engine')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_vespa:wheel')
    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_vespa:wheel')
end

function vespa.engine_set_sound_and_animation(self, _longit_speed)
    --minetest.chat_send_all('test1 ' .. dump(self._engine_running) )
    if self.sound_handle then
        if (math.abs(self._longit_speed) > math.abs(_longit_speed) + 0.03) or (math.abs(self._longit_speed) + 0.03 < math.abs(_longit_speed)) then
            --minetest.chat_send_all('test2')
            vespa.engineSoundPlay(self)
        end
    end
end

function vespa.engineSoundPlay(self)
    --sound
    if self.sound_handle then minetest.sound_stop(self.sound_handle) end
    if self.object then
        self.sound_handle = minetest.sound_play({name = "vespa_engine"},
            {object = self.object, gain = 0.3,
                pitch = 0.7 + ((self._longit_speed/10)/2),
                max_hear_distance = 30,
                loop = true,})
    end
end
