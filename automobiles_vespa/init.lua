--
-- constants
--
vespa={}
vespa.gravity = automobiles_lib.gravity

vespa.S = nil

if(minetest.get_translator ~= nil) then
    vespa.S = minetest.get_translator(minetest.get_current_modname())

else
    vespa.S = function ( s ) return s end

end

local S = vespa.S

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_player.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_entities.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_crafts.lua")

