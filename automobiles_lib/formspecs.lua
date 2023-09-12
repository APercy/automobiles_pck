

function automobiles_lib.getCarFromPlayer(player)
    local seat = player:get_attach()
    if seat then
        local car = seat:get_attach()
        return car
    end
    return nil
end

function automobiles_lib.driver_formspec(name)
    local player = minetest.get_player_by_name(name)
    if player then
        local vehicle_obj = automobiles_lib.getCarFromPlayer(player)
        if vehicle_obj == nil then
            return
        end
        local ent = vehicle_obj:get_luaentity()

        if ent then
            local yaw = "false"
            if ent._yaw_by_mouse then yaw = "true" end

            local basic_form = table.concat({
                "formspec_version[3]",
                "size[6,7]",
	        }, "")

	        basic_form = basic_form.."button[1,1.0;4,1;go_out;Go Offboard]"
            basic_form = basic_form.."button[1,2.5;4,1;lights;Lights]"
            basic_form = basic_form.."checkbox[1,5.5;yaw;Direction by mouse;"..yaw.."]"

            minetest.show_formspec(name, "automobiles_lib:driver_main", basic_form)
        end
    end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "automobiles_lib:driver_main" then
        local name = player:get_player_name()
        local car_obj = automobiles_lib.getCarFromPlayer(player)
        if car_obj then
            local ent = car_obj:get_luaentity()
            if ent then
		        if fields.go_out then
                    if ent._passenger then --any pax?
                        local pax_obj = minetest.get_player_by_name(ent._passenger)

                        local dettach_pax_f = automobiles_lib.dettach_pax
                        if ent._dettach_pax then attach_driver_f = ent._dettach_pax end
                        dettach_pax_f(ent, pax_obj)                        
                    end
                    ent._is_flying = 0

                    local dettach_f = automobiles_lib.dettach_driver
                    if ent._dettach then dettach_f = ent._dettach end
                    dettach_f(ent, player) 
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
            end
        end
        minetest.close_formspec(name, "automobiles_lib:driver_main")
    end
end)
