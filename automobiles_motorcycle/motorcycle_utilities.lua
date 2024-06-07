--dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_global_definitions.lua")
--dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_hud.lua")

-- destroy the motorcycle
function motorcycle.destroy(self, puncher)
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

    pos.y=pos.y+2

    if automobiles_lib.can_collect_car == false then
        --minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_motorcycle:motorcycle')
        minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_lib:engine')
        minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_motorcycle:wheel')
        minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},'automobiles_motorcycle:wheel')
    else
        local lua_ent = self.object:get_luaentity()
        local staticdata = lua_ent:get_staticdata(self)
        local obj_name = lua_ent.name
        local player = puncher

        local stack = ItemStack(obj_name)
        local stack_meta = stack:get_meta()
        stack_meta:set_string("staticdata", staticdata)

        if player then
            local inv = player:get_inventory()
            if inv then
                if inv:room_for_item("main", stack) then
                    inv:add_item("main", stack)
                else
                    minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5}, stack)
                end
            end
        else
            minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5}, stack)
        end
    end

    self.object:remove()
end

