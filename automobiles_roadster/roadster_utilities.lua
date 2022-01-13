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
