local S = coupe.S

--
-- items
--

-- body
minetest.register_craftitem("automobiles_coupe:coupe_body",{
	description = S("Coupe Body"),
	inventory_image = "automobiles_coupe_body.png",
})

-- coupe
minetest.register_tool("automobiles_coupe:coupe", {
	description = S("Coupe"),
	inventory_image = "automobiles_coupe.png",
    liquids_pointable = false,
    stack_max = 1,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local stack_meta = itemstack:get_meta()
        local staticdata = stack_meta:get_string("staticdata")

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_coupe:coupe", staticdata)
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
                ent.hp = 50 --reset hp
                --minetest.chat_send_all("owner: " .. ent.owner)
		        car:set_yaw(placer:get_look_horizontal())
		        itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, S("Coupe"))
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
		output = "automobiles_coupe:coupe",
		recipe = {
			{"automobiles_lib:wheel", "automobiles_lib:engine", "automobiles_lib:wheel"},
			{"automobiles_lib:wheel","automobiles_coupe:coupe_body",  "automobiles_lib:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_coupe:coupe_body",
		recipe = {
            {"default:glass" ,"default:glass","default:steel_ingot"},
			{"default:steel_ingot","","default:steel_ingot"},
			{"default:steelblock","default:steelblock", "default:steelblock"},
		}
	})
end
