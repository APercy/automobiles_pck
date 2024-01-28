local S = delorean.S

--
-- items
--

-- body
minetest.register_craftitem("automobiles_delorean:delorean_body",{
	description = S("Delorean Body"),
	inventory_image = "automobiles_delorean_body.png",
})

-- delorean
minetest.register_craftitem("automobiles_delorean:delorean", {
	description = S("Delorean"),
	inventory_image = "automobiles_delorean.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_delorean:delorean")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
                ent._car_type = 0
                --minetest.chat_send_all("owner: " .. ent.owner)
		        car:set_yaw(placer:get_look_horizontal())
		        itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, S("Delorean"))
                automobiles_lib.create_inventory(ent, ent._trunk_slots, owner)
            end
		end

		return itemstack
	end,
})

-- delorean
minetest.register_craftitem("automobiles_delorean:time_machine", {
	description = S("Time Machine"),
	inventory_image = "automobiles_delorean.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_delorean:delorean")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
                ent._car_type = 1
                --minetest.chat_send_all("delorean: " .. ent._car_type)
                --minetest.chat_send_all("owner: " .. ent.owner)
		        car:set_yaw(placer:get_look_horizontal())
		        itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, "Delorean")
                automobiles_lib.create_inventory(ent, ent._trunk_slots, owner)
            end
		end

		return itemstack
	end,
})

--
-- crafting
--
if minetest.get_modpath("default") then
	minetest.register_craft({
		output = "automobiles_delorean:delorean",
		recipe = {
			{"automobiles_lib:wheel", "automobiles_lib:engine", "automobiles_lib:wheel"},
			{"automobiles_lib:wheel","automobiles_delorean:delorean_body",  "automobiles_lib:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_delorean:delorean_body",
		recipe = {
            {"default:glass" ,"default:glass","default:steelblock"},
			{"default:steelblock","","default:steelblock"},
			{"default:steelblock","default:steelblock", "default:steelblock"},
		}
	})
end
