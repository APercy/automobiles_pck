--
-- constants
--
catrelle={}
catrelle.gravity = automobiles_lib.gravity

catrelle.S = nil

if(minetest.get_translator ~= nil) then
    catrelle.S = minetest.get_translator(minetest.get_current_modname())

else
    catrelle.S = function ( s ) return s end

end

local S = catrelle.S

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_catrelle") .. DIR_DELIM .. "entities.lua")
dofile(minetest.get_modpath("automobiles_catrelle") .. DIR_DELIM .. "crafts.lua")


