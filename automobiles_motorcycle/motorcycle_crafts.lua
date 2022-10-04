--
-- items
--

-- body
minetest.register_craftitem("automobiles_motorcycle:body",{
	description = "Motorcycle body",
	inventory_image = "automobiles_motorcycle_body.png",
})
-- wheel
minetest.register_craftitem("automobiles_motorcycle:wheel",{
	description = "Motorcycle wheel",
	inventory_image = "automobiles_motorcycle_wheel_icon.png",
})

-- motorcycle
minetest.register_craftitem("automobiles_motorcycle:motorcycle", {
	description = "Motorcycle",
	inventory_image = "automobiles_motorcycle.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
        
        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_motorcycle:motorcycle")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
			    car:set_yaw(placer:get_look_horizontal())
			    itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, "motorcycle")
                automobiles_lib.create_inventory(ent, motorcycle.trunk_slots, owner)
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
		output = "automobiles_motorcycle:motorcycle",
		recipe = {
			{"automobiles_motorcycle:wheel", "automobiles_motorcycle:body", "automobiles_motorcycle:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_motorcycle:body",
		recipe = {
            {"default:glass" ,"","default:steel_ingot"},
			{"default:steel_ingot","","default:steel_ingot"},
			{"default:steel_ingot","automobiles_lib:engine", "default:steel_ingot"},
		}
	})
	minetest.register_craft({
		output = "automobiles_motorcycle:wheel",
		recipe = {
			{"default:steel_ingot", "default:tin_ingot", "default:steel_ingot"},
			{"default:steel_ingot","default:steelblock",  "default:steel_ingot"},
            {"default:steel_ingot", "default:tin_ingot", "default:steel_ingot"},
		}
	})
end


