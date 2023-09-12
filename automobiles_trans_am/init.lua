--
-- constants
--
trans_am={}
trans_am.LONGIT_DRAG_FACTOR = 0.12*0.12
trans_am.LATER_DRAG_FACTOR = 6.0
trans_am.gravity = automobiles_lib.gravity
trans_am.max_speed = 40
trans_am.max_acc_factor = 12
trans_am.ideal_step = 0.2

trans_am_GAUGE_FUEL_POSITION =  {x=-4,y=6.8,z=16.6}

trans_am.front_wheel_xpos = 9.5
trans_am.rear_wheel_xpos = 9.5

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_trans_am") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_trans_am") .. DIR_DELIM .. "crafts.lua")


