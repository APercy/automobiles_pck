--
-- constants
--
delorean={}
delorean.gravity = automobiles_lib.gravity

delorean.S = nil

if(minetest.get_translator ~= nil) then
    delorean.S = minetest.get_translator(minetest.get_current_modname())

else
    delorean.S = function ( s ) return s end

end

local S = delorean.S

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


