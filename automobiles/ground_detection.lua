--[[
os experimentos mostraram que a deteção de uma posição de um item atachado retorna a do objeto pai, então pegar a posição das rodas não presta
proximo experimento sera mis complexo: pegar o yaw do carro, colocar o entreeixos e afastamento das rodas no eixo X e calcular a posição com trigonometria
]]--


--lets assume that the rear axis is at object center, so we will use the distance only for front wheels
function automobiles.ground_get_distances(self, radius, axis_length, axis_distance)


    --[[local lf = self.lf_wheel:get_pos() -- left front
    --automobiles.get_wheel_distance_from_ground(lf, radius)

    local rf = self.rf_wheel:get_pos() -- right front
    --automobiles.get_wheel_distance_from_ground(rf, radius)
    
    --minetest.chat_send_all("x ".. lf.x .." x " .. rf.x .. "\ny " .. lf.y .. " y " .. rf.y .. "\nz " .. lf.z .. " z " .. rf.z)

    local lr = self.lr_wheel:get_pos() -- left rear
    automobiles.get_wheel_distance_from_ground(lr, radius)
    
    local rr = self.rr_wheel:get_pos() -- right rear
    automobiles.get_wheel_distance_from_ground(rr, radius)]]--

    --[[
    --minetest.raycast(pos1, pos2, objects, liquids)

    for pointed_thing in minetest.raycast(p_pos, e_pos, true, false) do
        automobiles.handle_ray(reference,pointed_thing)
    end]]--

    --segunda tentativa fracassada:
    --[[local node = automobiles.get_node_below(self.object)
    if node then
        minetest.chat_send_all(node.name)
    end]]--

    local mid_axis = (axis_length / 2)/10
    local hip = axis_distance / 10

    local yaw = self.object:get_yaw()
    local pos = self.object:get_pos()

    local f_x, f_z = automobiles.get_xz_from_hipotenuse(pos.x, pos.z, yaw, hip)
    local x, f_y = automobiles.get_xz_from_hipotenuse(pos.x, pos.y, self._pitch, hip) --the x is only a mock

    local left_front = {x=0, y=f_y, z=0}
    left_front.x, left_front.z = automobiles.get_xz_from_hipotenuse(f_x, f_z, yaw-90, mid_axis)

    local right_front = {x=0, y=f_y, z=0}
    right_front.x, right_front.z = automobiles.get_xz_from_hipotenuse(f_x, f_z, yaw+90, mid_axis)
    
    local r_x, r_z = automobiles.get_xz_from_hipotenuse(pos.x, pos.z, yaw, 0)
    local r_y = 0
    x, r_y = automobiles.get_xz_from_hipotenuse(pos.x, pos.y, self._pitch, 0) --the x is only a mock

    local left_rear = {x=0, y=r_y, z=0}
    left_rear.x, left_rear.z = automobiles.get_xz_from_hipotenuse(r_x, r_z, yaw-90, mid_axis)

    local right_rear = {x=0, y=r_y, z=0}
    right_rear.x, right_rear.z = automobiles.get_xz_from_hipotenuse(r_x, r_z, yaw+90, mid_axis)    


    --minetest.chat_send_all("front x ".. right_front.x .." x " .. left_front.x .. " --- z " .. right_front.z .. " z " .. left_front.z .. " Y: " .. right_front.y)
    --minetest.chat_send_all("rear x ".. right_rear.x .." x " .. left_rear.x .. " --- z " .. right_rear.z .. " z " .. left_rear.z .. " Y: " .. right_rear.y)

    local node_bellow = automobiles.get_node_below(left_front, 0.5)
    if node_bellow then
        --minetest.chat_send_all("bellow: " .. node_bellow.name)
        local node = minetest.get_node(left_front)
        --minetest.chat_send_all("level: " .. node.name)
    end

end

function automobiles.get_xz_from_hipotenuse(orig_x, orig_z, yaw, distance)
    local z = (math.cos(yaw)*distance) + orig_z
    local x = (math.sin(yaw)*distance) + orig_x
    return x, z
end

function automobiles.get_wheel_distance_from_ground(pos, radius)
    local touch_pos = pos
    --[[touch_pos.y = touch_pos.y - radius
    local max_search_pos = touch_pos
    max_search_pos.y = max_search_pos.y - 0.9
    for pointed_thing in minetest.raycast(touch_pos, max_search_pos, true, false) do
        automobiles.handle_ray(pointed_thing)
    end]]--
    
end

function automobiles.handle_ray(pointed_thing)
    if pointed_thing.type == "node" then
        if pointed_thing.node_box then
            minetest.chat_send_all(minetest.debug(pointed_thing.node_box))
        end
        --[[if pointed_thing.ref ~= user and (not objs or objs and not objs[pointed_thing.ref])
        and (not calls or not calls.on_hit or check_bools(calls.on_hit, itemstack, user, pointed_thing.ref)) then
            local vel = user:get_player_velocity()
            local spd = math.sqrt((vel.x * vel.x) + (vel.z * vel.z))

            if vel.y <= -1 then
                for group, _ in pairs(def.damage_groups) do
                    def.damage_groups[group] = def.damage_groups[group] * def.crit_mp
                end
            end

            pointed_thing.ref:punch(user, 1.0, {full_punch_interval = 1.0, damage_groups = def.damage_groups})

            if pointed_thing.ref:is_player() then
                pointed_thing.ref:add_player_velocity(vector.multiply(user:get_look_dir(), def.kb_mp * spd))
            else
                pointed_thing.ref:add_velocity(vector.multiply(user:get_look_dir(), def.kb_mp * spd))
            end
        end

        if objs then
            depth = depth + 1
            objs[pointed_thing.ref] = pointed_thing.ref

            return depth, objs
        end]]--
    end
end

function automobiles.get_node_below(pos, dist)
    local node = minetest.get_node(pos)
    local pos_below = pos
    pos_below.y = pos_below.y - (dist + 0.1)
    local node_below = minetest.get_node(pos_below)
    return node_below
end

