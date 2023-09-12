--
-- constants
--
delorean={}
delorean.LONGIT_DRAG_FACTOR = 0.12*0.12
delorean.LATER_DRAG_FACTOR = 8.0
delorean.gravity = automobiles_lib.gravity
delorean.max_speed = 30
delorean.max_acc_factor = 8
delorean.ideal_step = 0.2

DELOREAN_GAUGE_FUEL_POSITION =  {x=-4.66,y=6.2,z=17.9}

delorean.front_wheel_xpos = 9.5
delorean.rear_wheel_xpos = 9.5

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_delorean") .. DIR_DELIM .. "forms.lua")
dofile(minetest.get_modpath("automobiles_delorean") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_delorean") .. DIR_DELIM .. "flight.lua")
dofile(minetest.get_modpath("automobiles_delorean") .. DIR_DELIM .. "utilities.lua")
dofile(minetest.get_modpath("automobiles_delorean") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_delorean") .. DIR_DELIM .. "crafts.lua")


