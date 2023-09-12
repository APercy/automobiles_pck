--
-- constants
--
catrelle={}
catrelle.LONGIT_DRAG_FACTOR = 0.12*0.12
catrelle.LATER_DRAG_FACTOR = 8.0
catrelle.gravity = automobiles_lib.gravity
catrelle.max_speed = 14
catrelle.max_acc_factor = 5
catrelle.ideal_step = 0.2

catrelle_GAUGE_FUEL_POSITION =  {x=-4.47,y=8.50,z=20.5}

catrelle.front_wheel_xpos = 7.5
catrelle.rear_wheel_xpos = 7.5

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_catrelle") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_catrelle") .. DIR_DELIM .. "crafts.lua")


