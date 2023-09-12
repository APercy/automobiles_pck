--
-- constants
--
buggy={}
buggy.LONGIT_DRAG_FACTOR = 0.14*0.14
buggy.LATER_DRAG_FACTOR = 25.0
buggy.gravity = automobiles_lib.gravity
buggy.max_speed = 15
buggy.max_acc_factor = 5

BUGGY_GAUGE_FUEL_POSITION =  {x=0,y=4.65,z=15.17}

buggy.front_wheel_xpos = 8
buggy.rear_wheel_xpos = 8

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_forms.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_utilities.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_entities.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_crafts.lua")


