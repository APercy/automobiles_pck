--
-- constants
--
coupe={}
coupe.gravity = automobiles_lib.gravity

coupe.S = nil

if(minetest.get_translator ~= nil) then
    coupe.S = minetest.get_translator(minetest.get_current_modname())

else
    coupe.S = function ( s ) return s end

end

local S = coupe.S

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_coupe") .. DIR_DELIM .. "coupe_entities.lua")
dofile(minetest.get_modpath("automobiles_coupe") .. DIR_DELIM .. "coupe_crafts.lua")


