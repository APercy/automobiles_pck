--
-- constants
--
motorcycle={}
motorcycle.LONGIT_DRAG_FACTOR = 0.14*0.14
motorcycle.LATER_DRAG_FACTOR = 25.0
motorcycle.gravity = automobiles_lib.gravity
motorcycle.max_speed = 20
motorcycle.max_acc_factor = 8
motorcycle.max_fuel = 5
motorcycle.trunk_slots = 0

motorcycle.front_wheel_xpos = 0
motorcycle.rear_wheel_xpos = 0

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_player.lua")
dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_utilities.lua")
dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_entities.lua")
dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_forms.lua")
dofile(minetest.get_modpath("automobiles_motorcycle") .. DIR_DELIM .. "motorcycle_crafts.lua")


