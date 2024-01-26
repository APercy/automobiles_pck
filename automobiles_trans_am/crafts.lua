local S = trans_am.S

--
-- items
--

-- body
minetest.register_craftitem("automobiles_trans_am:trans_am_body",{
	description = S("Trans Am Body"),
	inventory_image = "automobiles_trans_am_body.png",
})

-- trans_am
minetest.register_craftitem("automobiles_trans_am:trans_am", {
	description = S("Trans Am"),
	inventory_image = "automobiles_trans_am.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_trans_am:trans_am")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
                ent._trans_am_type = 0
                --minetest.chat_send_all("owner: " .. ent.owner)
		        car:set_yaw(placer:get_look_horizontal())
		        itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, S("Trans Am"))
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
		output = "automobiles_trans_am:trans_am",
		recipe = {
			{"automobiles_lib:wheel", "automobiles_lib:engine", "automobiles_lib:wheel"},
			{"automobiles_lib:wheel","automobiles_trans_am:trans_am_body",  "automobiles_lib:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_trans_am:trans_am_body",
		recipe = {
            {"default:glass","default:mese","default:steel_ingot"},
			{"default:steel_ingot","default:steelblock","default:steel_ingot"},
			{"default:steelblock","default:steelblock", "default:steelblock"},
		}
	})
end
