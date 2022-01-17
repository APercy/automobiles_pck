--[[
os experimentos mostraram que a deteção de uma posição de um item atachado retorna a do objeto pai, então pegar a posição das rodas não presta
proximo experimento sera mis complexo: pegar o yaw do carro, colocar o entreeixos e afastamento das rodas no eixo X e calcular a posição com trigonometria
]]--


--lets assume that the rear axis is at object center, so we will use the distance only for front wheels
function automobiles.ground_get_distances(self, radius, axis_distance)

    --local mid_axis = (axis_length / 2)/10
    local hip = (axis_distance / 10)
    minetest.chat_send_all("entre-eixo "..hip)
    local pitch = self._pitch --+90 for the calculations

    local yaw = self.object:get_yaw()
    local deg_yaw = math.deg(yaw)
    local yaw_turns = math.floor(deg_yaw / 360)
    deg_yaw = deg_yaw - (yaw_turns * 360)
    yaw = math.rad(deg_yaw)
    
    local pos = self.object:get_pos()

    local r_x, r_z = automobiles.get_xz_from_hipotenuse(pos.x, pos.z, yaw, 0)
    local r_y = pos.y
    local rear_axis = {x=r_x, y=r_y, z=r_z}

    local rear_obstacle_level = automobiles.get_obstacle(rear_axis)

    local f_x, f_z = automobiles.get_xz_from_hipotenuse(pos.x, pos.z, yaw, hip)
    --local f_y, x = automobiles.get_xz_from_hipotenuse(pos.y, pos.x, 0, hip) --the x is only a mock
    local front_axis = {x=f_x, y=pos.y, z=f_z}
    local front_obstacle_level = automobiles.get_obstacle(front_axis)

    --[[local left_front = {x=0, y=f_y, z=0}
    left_front.x, left_front.z = automobiles.get_xz_from_hipotenuse(f_x, f_z, yaw+math.rad(90), mid_axis)

    local right_front = {x=0, y=f_y, z=0}
    right_front.x, right_front.z = automobiles.get_xz_from_hipotenuse(f_x, f_z, yaw-math.rad(90), mid_axis)]]--
    
    --[[

    local rear_obstacle_level = automobiles.get_obstacle(rear_axis, 0.2, 0.25)]]--

    --[[local left_rear = {x=0, y=r_y, z=0}
    left_rear.x, left_rear.z = automobiles.get_xz_from_hipotenuse(r_x, r_z, yaw+math.rad(90), mid_axis)

    local right_rear = {x=0, y=r_y, z=0}
    right_rear.x, right_rear.z = automobiles.get_xz_from_hipotenuse(r_x, r_z, yaw-math.rad(90), mid_axis)]]--

    --lets try to get the pitch
    local deltaX = axis_distance;
    local deltaY = front_obstacle_level.y - rear_obstacle_level.y;
    minetest.chat_send_all("deutaY "..deltaY)
    local m = (deltaY/deltaX)*10
    pitch = math.atan(m) --math.atan2(deltaY, deltaX);
    minetest.chat_send_all("m: "..m.." pitch ".. math.deg(pitch))
    self._pitch = pitch

end

function automobiles.get_xz_from_hipotenuse(orig_x, orig_z, yaw, distance)
    --cara, o minetest é bizarro, ele considera o eixo no sentido ANTI-HORÁRIO... Então pra equação funcionar, subtrair o angulo de 360 antes
    yaw = math.rad(360) - yaw
    local z = (math.cos(yaw)*distance) + orig_z
    local x = (math.sin(yaw)*distance) + orig_x
    return x, z
end

function automobiles.get_obstacle(ref_pos)
    --lets clone the table
    local retval = {x=ref_pos.x, y=ref_pos.y, z=ref_pos.z}
    --minetest.chat_send_all("aa y: " .. dump(retval.y))
    local i_pos = {x=ref_pos.x, y=ref_pos.y, z=ref_pos.z}
    --minetest.chat_send_all("bb y: " .. dump(retval.y))

    retval.y = eval_interception(i_pos, {x=i_pos.x, y=i_pos.y - 2, z=i_pos.z})

    --minetest.chat_send_all("y: " .. dump(ref_pos.y) .. " ye: ".. dump(retval.y))
    return retval    
end

function eval_interception(initial_pos, end_pos)
    local ret_y = nil
	local cast = minetest.raycast(initial_pos, end_pos, true, false)
	local thing = cast:next()
	while thing do
		if thing.type == "node" then
            local pos = thing.intersection_point
            if pos then
                ret_y = pos.y
                --local node_name = minetest.get_node(thing.under).name
                --minetest.chat_send_all("ray intercection: " .. dump(pos.y) .. " -- " .. node_name)
                break
            end
        end
        thing = cast:next()
    end
    return ret_y
end

function automobiles.get_node_below(pos, dist)
    local node = minetest.get_node(pos)
    local pos_below = pos
    pos_below.y = pos_below.y - (dist + 0.1)
    local node_below = minetest.get_node(pos_below)
    return node_below
end


