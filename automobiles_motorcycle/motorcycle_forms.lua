
--------------
-- Manual --
--------------

function motorcycle.getCarFromPlayer(player)
    local seat = player:get_attach()
    if seat then
        local car = seat:get_attach()
        return car
    end
    return nil
end

function motorcycle.driver_formspec(name)
    local basic_form = table.concat({
        "formspec_version[3]",
        "size[6,6]",
	}, "")

	basic_form = basic_form.."button[1,1.0;4,1;go_out;Go Offboard]"

    minetest.show_formspec(name, "motorcycle:driver_main", basic_form)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "motorcycle:driver_main" then
        local name = player:get_player_name()
        local car_obj = motorcycle.getCarFromPlayer(player)
        if car_obj then
            local ent = car_obj:get_luaentity()
            if ent then
		        if fields.go_out then

                    if ent._passenger then --any pax?
                        local pax_obj = minetest.get_player_by_name(ent._passenger)
                        motorcycle.dettach_pax_stand(ent, pax_obj)
                    end

                    motorcycle.dettach_driver_stand(ent, player)
		        end
            end
        end
        minetest.close_formspec(name, "motorcycle:driver_main")
    end
end)
