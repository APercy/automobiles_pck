--
-- constants
--
buggy={}
buggy.gravity = automobiles_lib.gravity

buggy.S = nil

if(minetest.get_translator ~= nil) then
    buggy.S = minetest.get_translator(minetest.get_current_modname())

else
    buggy.S = function ( s ) return s end

end

local S = buggy.S

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_forms.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_entities.lua")
dofile(minetest.get_modpath("automobiles_buggy") .. DIR_DELIM .. "buggy_crafts.lua")


