
--------------
-- Manual --
--------------

function roadster.getCarFromPlayer(player)
    local seat = player:get_attach()
    if seat then
        local car = seat:get_attach()
        return car
    end
    return nil
end

function roadster.driver_formspec(name)
    local basic_form = table.concat({
        "formspec_version[3]",
        "size[6,6]",
	}, "")

	basic_form = basic_form.."button[1,1.0;4,1;go_out;Go Offboard]"
	basic_form = basic_form.."button[1,2.5;4,1;top;Close/Open Ragtop]"
    basic_form = basic_form.."button[1,4.0;4,1;lights;Lights]"

    minetest.show_formspec(name, "roadster:driver_main", basic_form)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "roadster:driver_main" then
        local name = player:get_player_name()
        local car_obj = roadster.getCarFromPlayer(player)
        if car_obj then
            local ent = car_obj:get_luaentity()
            if ent then
                if fields.top then
                    if ent._show_rag == true then
                        ent._show_rag = false
                    else
                        ent._show_rag = true
                    end
                end
		        if fields.go_out then

                    if ent._passenger then --any pax?
                        local pax_obj = minetest.get_player_by_name(ent._passenger)
                        automobiles_lib.dettach_pax(ent, pax_obj)
                    end

                    automobiles_lib.dettach_driver(ent, player)
		        end
                if fields.lights then
                    if ent._show_lights == true then
                        ent._show_lights = false
                    else
                        ent._show_lights = true
                    end
                end
            end
        end
        minetest.close_formspec(name, "roadster:driver_main")
    end
end)
