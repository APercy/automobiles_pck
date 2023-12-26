--
-- constants
--
coupe={}
coupe.gravity = automobiles_lib.gravity

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_coupe") .. DIR_DELIM .. "coupe_entities.lua")
dofile(minetest.get_modpath("automobiles_coupe") .. DIR_DELIM .. "coupe_crafts.lua")


