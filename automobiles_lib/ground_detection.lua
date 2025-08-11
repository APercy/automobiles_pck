function automobiles_lib.putAngleOnRange(angle)
    local n_angle = angle/360
    n_angle = (n_angle - math.floor(n_angle))*360
    if n_angle < -180 then n_angle = n_angle + 360 end
    if n_angle > 180 then n_angle = n_angle - 360 end
    return n_angle
end

function automobiles_lib.pid_controller(current_value, setpoint, last_error, delta_t, kp, ki, kd)
    kp = kp or 0
    ki = ki or 0.00000000000001
    kd = kd or 0.05
    delta_t = delta_t or 0.100;

    ti = kp/ki
    td = kd/kp

    local _error = setpoint - current_value
    local derivative = _error - last_error
    --local output = kpv*erro + (kpv/Tiv)*I + kpv*Tdv*((erro - erro_passado)/delta_t);
    if integrative == nil then integrative = 0 end
    integrative = integrative + (((_error + last_error)/delta_t)/2);
    local output = kp*_error + (kp/ti)*integrative + kp * td*((_error - last_error)/delta_t)
    last_error = _error
    return output, last_error

end

-- Função para calcular ângulos de pitch e roll
local function get_vehicle_pitch_roll(pos, wheels, yaw)
    local world = vector.new()
    --core.chat_send_all(dump(wheels))
    
    --rotacionando as posições das rodas
    for i = 1,4,1 do
        local orig_x = wheels[i].x
        local orig_z = wheels[i].z
        wheels[i].x = (orig_x * math.cos(yaw)) - (orig_z * math.sin(yaw))
        wheels[i].z = (orig_x * math.sin(yaw)) + (orig_z * math.cos(yaw))
    end
    --core.chat_send_all(dump(wheels))

    local points = {}

    -- Obter altura do terreno para cada roda
    for i, wheel in ipairs(wheels) do
        world.x = pos.x + wheel.x
        world.y = pos.y + wheel.y
        world.z = pos.z + wheel.z
        local height = automobiles_lib.get_obstacle({x=world.x,y=world.y,z=world.z}).y or 0
        table.insert(points, {x = world.x, y = height, z = world.z})
    end

    -- Calcular os coeficientes do plano Ax + By + Cz + D = 0
    local x1, y1, z1 = points[1].x, points[1].y, points[1].z
    local x2, y2, z2 = points[2].x, points[2].y, points[2].z
    local x3, y3, z3 = points[3].x, points[3].y, points[3].z
    local x4, y4, z4 = points[4].x, points[4].y, points[4].z

    -- Criamos dois vetores a partir das quatro rodas
    local v1 = {x = x2 - x1, y = y2 - y1, z = z2 - z1}
    local v2 = {x = x3 - x1, y = y3 - y1, z = z3 - z1}
    local v3 = {x = x4 - x1, y = y4 - y1, z = z4 - z1}
    
    -- Tiramos a média do produto vetorial entre os três vetores
    local normal1 = {
        x = v1.y * v2.z - v1.z * v2.y,
        y = v1.z * v2.x - v1.x * v2.z,
        z = v1.x * v2.y - v1.y * v2.x
    }

    local normal2 = {
        x = v1.y * v3.z - v1.z * v3.y,
        y = v1.z * v3.x - v1.x * v3.z,
        z = v1.x * v3.y - v1.y * v3.x
    }

    -- Média das duas normais para melhor precisão
    local normal = {
        x = (normal1.x + normal2.x) / 2,
        y = (normal1.y + normal2.y) / 2,
        z = (normal1.z + normal2.z) / 2
    }
    
    -- Normalizar o vetor normal
    local magnitude = math.sqrt(normal.x^2 + normal.y^2 + normal.z^2)
    if magnitude == 0 then
        return 0, 0  -- Retorna ângulos neutros se o cálculo falhar
    end

    normal.x = normal.x / magnitude
    normal.y = normal.y / magnitude
    normal.z = normal.z / magnitude
    --core.chat_send_all("normal2 "..dump(normal).."\nmagnitude: "..magnitude)
    
    -- Criar um vetor de direção do veículo (da traseira para a frente)
    local forward = {
        x = (wheels[1].x + wheels[2].x) / 2 - (wheels[3].x + wheels[4].x) / 2,
        z = (wheels[1].z + wheels[2].z) / 2 - (wheels[3].z + wheels[4].z) / 2
    }

    -- Normalizar o vetor de direção
    local magnitude_forward = math.sqrt(forward.x^2 + forward.z^2)
    forward.x = forward.x / magnitude_forward
    forward.z = forward.z / magnitude_forward

    -- Descobrir se o veículo está apontando para frente ou para trás no eixo Z
    local direction_z = forward.z >= 0 and -1 or 1
    -- Descobrir se o veículo está apontando para direita/esquerda no eixo X
    local direction_x = forward.x >= 0 and -1 or 1

    -- Verificar qual eixo está "apontado para frente"
    local dominantX = math.abs(forward.x) > math.abs(forward.z) 

    local pitch, roll
    local m, n

    if dominantX then
        -- Calcular ângulos de pitch e roll
        m = normal.x/normal.y
        pitch = math.atan(m) * direction_x
        if pitch ~= pitch then pitch = 0 end
        n = normal.z/normal.y
        roll = math.atan(n) * direction_x
        if roll ~= roll then roll = 0 end
    else
        -- Calcular ângulos de pitch e roll
        m = normal.z/normal.y
        pitch = math.atan(m) * direction_z
        if pitch ~= pitch then pitch = 0 end
        n = normal.x/normal.y
        roll = math.atan(n) * direction_z * -1
        if roll ~= roll then roll = 0 end
    end

    --core.chat_send_all(dump("pitch "..math.deg(pitch).." - roll "..math.deg(roll)))
    
    return pitch, roll
end

local function get_nodedef_field(nodename, fieldname)
    if not minetest.registered_nodes[nodename] then
        return nil
    end
    return minetest.registered_nodes[nodename][fieldname]
end

--lets assume that the rear axis is at object center, so we will use the distance only for front wheels
function automobiles_lib.ground_get_distances(self, radius, axis_distance)
    --local mid_axis = (axis_length / 2)/10
    local hip = axis_distance
    --minetest.chat_send_all("entre-eixo "..hip)
    local pitch = self._pitch --+90 for the calculations

    local yaw = self.object:get_yaw()
    local deg_yaw = math.deg(yaw)
    local yaw_turns = math.floor(deg_yaw / 360)
    deg_yaw = deg_yaw - (yaw_turns * 360)
    yaw = math.rad(deg_yaw)
    
    local pos = self.object:get_pos()
    local front_wheel_x = self._front_wheel_xpos / 10
    if math.abs(front_wheel_x) < 0.01 then front_wheel_x = 0.01 end --pra não anular as normals
    local rear_wheel_x = self._rear_wheel_xpos / 10
    if math.abs(rear_wheel_x) < 0.01 then rear_wheel_x = 0.01 end --pra não anular as normals

    local wheels = {
        {x = -front_wheel_x, y = 0, z = axis_distance},  -- Roda frontal esquerda
        {x =  front_wheel_x, y = 0, z = axis_distance},  -- Roda frontal direita
        {x = -rear_wheel_x, y = 0, z = -0},  -- Roda traseira esquerda
        {x =  rear_wheel_x, y = 0, z = -0}   -- Roda traseira direita
    }

    --retornando pitch e roll
    local pitch, roll = get_vehicle_pitch_roll(pos, wheels, yaw)

    if not self._last_pitch then self._last_pitch = pitch end

--[[
* `minetest.raycast(pos1, pos2, objects, liquids)`: returns `Raycast`
    * Creates a `Raycast` object.
    * `pos1`: start of the ray
    * `pos2`: end of the ray
    * `objects`: if false, only nodes will be returned. Default is `true`.
    * `liquids`: if false, liquid nodes won't be returned. Default is `false`.
]]--


    if 1 then
        local pos_elevation = 1
        local f_x, f_z = automobiles_lib.get_xz_from_hipotenuse(pos.x, pos.z, yaw, axis_distance)
        local f_y = pos.y + pos_elevation
        local end_pos = {x=f_x, y=f_y, z=f_z}
        local initial_pos = vector.new(pos)
        initial_pos.y = initial_pos.y + pos_elevation

	    local cast = minetest.raycast(initial_pos, end_pos, true, false)
	    local thing = cast:next()
	    while thing do
		    if thing.type == "node" then
                local pos = thing.intersection_point
                if pos then
                    local nodename = minetest.get_node(thing.under).name
                    local drawtype = get_nodedef_field(nodename, "drawtype")

                    if drawtype ~= "plantlike" then
                        self.object:set_acceleration({x=0,y=0,z=0})
                        local oldvel = self.object:get_velocity()
                        self.object:add_velocity(vector.subtract(vector.new(), oldvel))
                        pitch = math.rad(0)
                        break
                    end
                end
            end
            thing = cast:next()
        end

    end

    self._pitch = pitch -- math.rad(90)
    self._roll = roll -- math.rad(90)
    --core.chat_send_all(dump("pitch "..pitch.." - roll "..roll))

end

function automobiles_lib.get_obstacle(ref_pos, ammount)
    ammount = ammount or -3
    --lets clone the table
    local retval = {x=ref_pos.x, y=ref_pos.y, z=ref_pos.z}
    --minetest.chat_send_all("aa y: " .. dump(retval.y))
    local i_pos = {x=ref_pos.x, y=ref_pos.y + 1, z=ref_pos.z}
    --minetest.chat_send_all("bb y: " .. dump(i_pos.y))

    local y = automobiles_lib.eval_interception(i_pos, {x=i_pos.x, y=ref_pos.y + ammount, z=i_pos.z})
    if y then
        retval.y = y
    end

    --minetest.chat_send_all("y: " .. dump(ref_pos.y) .. " ye: ".. dump(retval.y))
    return retval    
end

function automobiles_lib.eval_interception(initial_pos, end_pos)
    local ret_y = nil
	local cast = minetest.raycast(initial_pos, end_pos, true, false)
	local thing = cast:next()
	while thing do
		if thing.type == "node" then
            local pos = thing.intersection_point
            if pos then
                local nodename = minetest.get_node(thing.under).name
                local drawtype = get_nodedef_field(nodename, "drawtype")

                if drawtype ~= "plantlike" and drawtype ~= nil then
                    if initial_pos.y >= pos.y then 
                        ret_y = pos.y
                        --minetest.chat_send_all("ray intercection: " .. dump(pos.y) .. " -- " .. nodename)
                    end
                    break
                end
            end
        end
        thing = cast:next()
    end
    return ret_y
end

function automobiles_lib.get_node_below(pos, dist)
    local node = minetest.get_node(pos)
    local pos_below = pos
    pos_below.y = pos_below.y - (dist + 0.1)
    local node_below = minetest.get_node(pos_below)
    return node_below
end


