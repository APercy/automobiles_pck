
--------------
-- Manual --
--------------

function catrelle.getCarFromPlayer(player)
    local seat = player:get_attach()
    if seat then
        local car = seat:get_attach()
        return car
    end
    return nil
end

function catrelle.driver_formspec(name)
    local player = minetest.get_player_by_name(name)
    local vehicle_obj = catrelle.getCarFromPlayer(player)
    if vehicle_obj == nil then
        return
    end
    local ent = vehicle_obj:get_luaentity()

    local yaw = "false"
    if ent._yaw_by_mouse then yaw = "true" end

    local flight = "false"
    if ent._is_flying == 1 then flight = "true" end

    local basic_form = table.concat({
        "formspec_version[3]",
        "size[6,7]",
	}, "")

	basic_form = basic_form.."button[1,1.0;4,1;go_out;Go Offboard]"
    basic_form = basic_form.."button[1,2.5;4,1;lights;Lights]"
    if ent._catrelle_type == 1 then basic_form = basic_form.."checkbox[1,4.0;flight;Flight Mode;"..flight.."]" end
    basic_form = basic_form.."checkbox[1,5.5;yaw;Direction by mouse;"..yaw.."]"

    minetest.show_formspec(name, "catrelle:driver_main", basic_form)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "catrelle:driver_main" then
        local name = player:get_player_name()
        local car_obj = catrelle.getCarFromPlayer(player)
        if car_obj then
            local ent = car_obj:get_luaentity()
            if ent then
		        if fields.go_out then
                    if ent._passenger then --any pax?
                        local pax_obj = minetest.get_player_by_name(ent._passenger)
                        automobiles_lib.dettach_pax(ent, pax_obj)
                    end
                    ent._is_flying = 0
                    automobiles_lib.dettach_driver(ent, player)
		        end
                if fields.lights then
                    if ent._show_lights == true then
                        ent._show_lights = false
                    else
                        ent._show_lights = true
                    end
                end
                if fields.yaw then
                    if ent._yaw_by_mouse == true then
                        ent._yaw_by_mouse = false
                    else
                        ent._yaw_by_mouse = true
                    end
                end
                if fields.flight then
                    if ent._is_flying == 1 then
                        ent._is_flying = 0
                    else
                        ent._is_flying = 1
                    end
                    catrelle.turn_flight_mode(ent)
                end
            end
        end
        minetest.close_formspec(name, "catrelle:driver_main")
    end
end)
