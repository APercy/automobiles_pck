--[[
os experimentos mostraram que a deteção de uma posição de um item atachado retorna a do objeto pai, então pegar a posição das rodas não presta
proximo experimento sera mis complexo: pegar o yaw do carro, colocar o entreeixos e afastamento das rodas no eixo X e calcular a posição com trigonometria
]]--


--lets assume that the rear axis is at object center, so we will use the distance only for front wheels
function automobiles.ground_get_distances(self, radius, axis_length, axis_distance)

    local mid_axis = (axis_length / 2)/10
    local hip = (axis_distance / 10) -- + ((axis_distance / 10)/3)

    local yaw = self.object:get_yaw()
    local deg_yaw = math.deg(yaw)
    local yaw_turns = math.floor(deg_yaw / 360)
    deg_yaw = deg_yaw - (yaw_turns * 360)
    yaw = math.rad(deg_yaw)
    
    local pos = self.object:get_pos()

    local f_x, f_z = automobiles.get_xz_from_hipotenuse(pos.x, pos.z, yaw, hip)
    local x, f_y = automobiles.get_xz_from_hipotenuse(pos.x, pos.y, self._pitch, hip) --the x is only a mock
    local front_axis = {x=f_x, y=f_y, z=f_z}

    local front_obstacle_level = automobiles.get_obstacle(front_axis)
    --TODO ajustar inclinação aqui primeiro

    --[[local left_front = {x=0, y=f_y, z=0}
    left_front.x, left_front.z = automobiles.get_xz_from_hipotenuse(f_x, f_z, yaw+math.rad(90), mid_axis)

    local right_front = {x=0, y=f_y, z=0}
    right_front.x, right_front.z = automobiles.get_xz_from_hipotenuse(f_x, f_z, yaw-math.rad(90), mid_axis)]]--
    
    local r_x, r_z = automobiles.get_xz_from_hipotenuse(pos.x, pos.z, yaw, 0)
    local r_y = 0
    x, r_y = automobiles.get_xz_from_hipotenuse(pos.x, pos.y, self._pitch, 0) --the x is only a mock
    local rear_axis = {x=r_x, y=r_y, z=r_z}

    local rear_obstacle_level = automobiles.get_obstacle(rear_axis)
    --TODO ajustar aqui depois



    --[[local left_rear = {x=0, y=r_y, z=0}
    left_rear.x, left_rear.z = automobiles.get_xz_from_hipotenuse(r_x, r_z, yaw+math.rad(90), mid_axis)

    local right_rear = {x=0, y=r_y, z=0}
    right_rear.x, right_rear.z = automobiles.get_xz_from_hipotenuse(r_x, r_z, yaw-math.rad(90), mid_axis)]]--

    --minetest.chat_send_all("x ".. f_x .. " --- z " .. f_z .. " || " ..  math.deg(yaw))
    --minetest.chat_send_all("front x ".. right_front.x .. " - z " .. right_front.z .. " Yaw: " .. math.deg(yaw-math.rad(90)) .. " ||| x " .. left_front.x .. " - z " .. left_front.z .. " Yaw: " .. math.deg(yaw+math.rad(90)))
    --minetest.chat_send_all("rear x ".. right_rear.x .." x " .. left_rear.x .. " --- z " .. right_rear.z .. " z " .. left_rear.z .. " Y: " .. right_rear.y)

end

function automobiles.get_xz_from_hipotenuse(orig_x, orig_z, yaw, distance)
    --cara, o minetest é bizarro, ele considera o eixo no sentido ANTI-HORÁRIO... Então pra equação funcionar, subtrair o angulo de 360 antes
    yaw = math.rad(360) - yaw
    local z = (math.cos(yaw)*distance) + orig_z
    local x = (math.sin(yaw)*distance) + orig_x
    return x, z
end

function automobiles.get_obstacle(ref_pos)
    local retval = ref_pos
    local i_pos = ref_pos
    --minetest.chat_send_all("wheel pos: " .. dump(i_pos.y))
    
    local e_pos = ref_pos
    e_pos.y = e_pos.y - 0.20

	local cast = minetest.raycast(i_pos, e_pos, true, false)
	local thing = cast:next()
	while thing do
		if thing.type == "node" then
            local pos = thing.intersection_point
            retval = pos
            --local node_name = minetest.get_node(thing.under).name
            --minetest.chat_send_all("ray intercection: " .. dump(pos.y) .. " -- " .. node_name)
        end
        thing = cast:next()
    end

    e_pos = ref_pos
    e_pos.y = e_pos.y - 0.25

	cast = minetest.raycast(i_pos, e_pos, true, false)
	thing = cast:next()
	while thing do
		if thing.type == "node" then
            local pos = thing.intersection_point
            retval = pos
            --local node_name = minetest.get_node(thing.under).name
            --minetest.chat_send_all("ray 2 intercection: " .. dump(pos.y) .. " -- " .. node_name)
        end
        thing = cast:next()
    end

    e_pos = ref_pos
    e_pos.y = e_pos.y - 0.35

	cast = minetest.raycast(i_pos, e_pos, true, false)
	thing = cast:next()
	while thing do
		if thing.type == "node" then
            local pos = thing.intersection_point
            retval = pos
            --local node_name = minetest.get_node(thing.under).name
            --minetest.chat_send_all("ray 3 intercection: " .. dump(pos.y) .. " -- " .. node_name)
        end
        thing = cast:next()
    end

    return retval    
end

function automobiles.get_node_below(pos, dist)
    local node = minetest.get_node(pos)
    local pos_below = pos
    pos_below.y = pos_below.y - (dist + 0.1)
    local node_below = minetest.get_node(pos_below)
    return node_below
end


