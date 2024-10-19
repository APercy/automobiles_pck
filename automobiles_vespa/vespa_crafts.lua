local S = vespa.S

--
-- items
--

-- body
minetest.register_craftitem("automobiles_vespa:body",{
	description = S("Vespa Body"),
	inventory_image = "automobiles_vespa_body.png",
})
-- wheel
minetest.register_craftitem("automobiles_vespa:wheel",{
	description = S("Vespa Wheel"),
	inventory_image = "automobiles_vespa_wheel_icon.png",
})

-- vespa
minetest.register_tool("automobiles_vespa:vespa", {
	description = S("Vespa"),
	inventory_image = "automobiles_vespa.png",
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
		local car = minetest.add_entity(pointed_pos, "automobiles_vespa:vespa", staticdata)
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
                ent.hp = 50 --reset hp
			    car:set_yaw(placer:get_look_horizontal())
			    itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, S("Vespa"))
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
		output = "automobiles_vespa:vespa",
		recipe = {
			{"automobiles_vespa:wheel", "automobiles_vespa:body", "automobiles_vespa:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_vespa:body",
		recipe = {
            {"default:tin_ingot","",""},
			{"default:tin_ingot","","default:tin_ingot"},
			{"default:tin_ingot","automobiles_lib:engine", "default:tin_ingot"},
		}
	})
	minetest.register_craft({
		output = "automobiles_vespa:wheel",
		recipe = {
			{"default:tin_ingot", "", "default:tin_ingot"},
			{"","default:steelblock",  ""},
            {"default:tin_ingot", "", "default:tin_ingot"},
		}
	})
end
