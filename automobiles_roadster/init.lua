--
-- constants
--
roadster={}
roadster.LONGIT_DRAG_FACTOR = 0.16*0.16
roadster.LATER_DRAG_FACTOR = 30.0
roadster.gravity = automobiles.gravity
roadster.max_speed = 10
roadster.max_acc_factor = 6
roadster.max_fuel = 10

roadster.front_wheel_xpos = 10.26
roadster.rear_wheel_xpos = 10.26

dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_utilities.lua")
dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_entities.lua")




