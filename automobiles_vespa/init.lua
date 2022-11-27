--
-- constants
--
vespa={}
vespa.LONGIT_DRAG_FACTOR = 0.15*0.15
vespa.LATER_DRAG_FACTOR = 30.0
vespa.gravity = automobiles_lib.gravity
vespa.max_speed = 20
vespa.max_acc_factor = 6
vespa.max_fuel = 3
vespa.trunk_slots = 0

vespa.front_wheel_xpos = 0
vespa.rear_wheel_xpos = 0

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_player.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_utilities.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_entities.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_forms.lua")
dofile(minetest.get_modpath("automobiles_vespa") .. DIR_DELIM .. "vespa_crafts.lua")


