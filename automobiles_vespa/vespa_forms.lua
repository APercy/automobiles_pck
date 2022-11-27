
--------------
-- Manual --
--------------

function vespa.getCarFromPlayer(player)
    local seat = player:get_attach()
    if seat then
        local car = seat:get_attach()
        return car
    end
    return nil
end

function vespa.driver_formspec(name)
    local player = minetest.get_player_by_name(name)
    local vehicle_obj = vespa.getCarFromPlayer(player)
    if vehicle_obj == nil then
        return
    end
    local ent = vehicle_obj:get_luaentity()

    local basic_form = table.concat({
        "formspec_version[3]",
        "size[6,6]",
	}, "")

    local yaw = "false"
    if ent._yaw_by_mouse then yaw = "true" end

	basic_form = basic_form.."button[1,1.0;4,1;go_out;Go Offboard]"
    basic_form = basic_form.."checkbox[1,3.0;yaw;Direction by mouse;"..yaw.."]"

    minetest.show_formspec(name, "vespa:driver_main", basic_form)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "vespa:driver_main" then
        local name = player:get_player_name()
        local car_obj = vespa.getCarFromPlayer(player)
        if car_obj then
            local ent = car_obj:get_luaentity()
            if ent then
		        if fields.go_out then

                    if ent._passenger then --any pax?
                        local pax_obj = minetest.get_player_by_name(ent._passenger)
                        vespa.dettach_pax_stand(ent, pax_obj)
                    end

                    vespa.dettach_driver_stand(ent, player)
		        end
                if fields.yaw then
                    if ent._yaw_by_mouse == true then
                        ent._yaw_by_mouse = false
                    else
                        ent._yaw_by_mouse = true
                    end
                end
            end
        end
        minetest.close_formspec(name, "vespa:driver_main")
    end
end)
