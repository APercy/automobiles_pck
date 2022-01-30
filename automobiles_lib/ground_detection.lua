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

    local r_x, r_z = automobiles_lib.get_xz_from_hipotenuse(pos.x, pos.z, yaw, 0)
    local r_y = pos.y
    local rear_axis = {x=r_x, y=r_y, z=r_z}

    local rear_obstacle_level = automobiles_lib.get_obstacle(rear_axis)
    --minetest.chat_send_all("rear"..dump(rear_obstacle_level))

    local f_x, f_z = automobiles_lib.get_xz_from_hipotenuse(pos.x, pos.z, yaw, hip)
    local f_y = pos.y
    --local x, f_y = automobiles_lib.get_xz_from_hipotenuse(f_x, r_y, pitch - math.rad(90), hip) --the x is only a mock
    --minetest.chat_send_all("r: "..r_y.." f: "..f_y .." - "..math.deg(pitch))
    local front_axis = {x=f_x, y=f_y, z=f_z}
    local front_obstacle_level = automobiles_lib.get_obstacle(front_axis)
    --minetest.chat_send_all("front"..dump(front_obstacle_level))

    --[[ here lets someting to smooth the detection using the middle os the car as reference]]--
    --[[f_x, f_z = automobiles_lib.get_xz_from_hipotenuse(pos.x, pos.z, yaw, hip/2)
    f_y = pos.y
    --x, f_y = automobiles_lib.get_xz_from_hipotenuse(f_x, r_y, pitch - math.rad(90), hip/2) --the x is only a mock
    --minetest.chat_send_all("r: "..r_y.." f: "..f_y .." - "..math.deg(pitch))
    local mid_car = {x=f_x, y=f_y, z=f_z}
    local mid_car_level = automobiles_lib.get_obstacle(mid_car)]]--


    --[[local left_front = {x=0, y=f_y, z=0}
    left_front.x, left_front.z = automobiles_lib.get_xz_from_hipotenuse(f_x, f_z, yaw+math.rad(90), mid_axis)

    local right_front = {x=0, y=f_y, z=0}
    right_front.x, right_front.z = automobiles_lib.get_xz_from_hipotenuse(f_x, f_z, yaw-math.rad(90), mid_axis)]]--
    
    --[[

    local rear_obstacle_level = automobiles_lib.get_obstacle(rear_axis, 0.2, 0.25)]]--

    --[[local left_rear = {x=0, y=r_y, z=0}
    left_rear.x, left_rear.z = automobiles_lib.get_xz_from_hipotenuse(r_x, r_z, yaw+math.rad(90), mid_axis)

    local right_rear = {x=0, y=r_y, z=0}
    right_rear.x, right_rear.z = automobiles_lib.get_xz_from_hipotenuse(r_x, r_z, yaw-math.rad(90), mid_axis)]]--

    --lets try to get the pitch
    if front_obstacle_level.y ~= nil and rear_obstacle_level.y ~= nil then
        local deltaX = axis_distance;
        local deltaY = front_obstacle_level.y - rear_obstacle_level.y;
        --minetest.chat_send_all("deutaY "..deltaY)
        local m = (deltaY/deltaX)
        pitch = math.atan(m) --math.atan2(deltaY, deltaX);
        --minetest.chat_send_all("m: "..m.." pitch ".. math.deg(pitch))

        --[[if mid_car_level then
            deltaX = axis_distance/2;
            if mid_car_level.y ~= nil then
                local deltaY_mid = mid_car_level.y - rear_obstacle_level.y;
                if deltaY >= 1 and deltaY_mid < (deltaY / 2) then
                    --self.initial_properties.stepheight
                    pitch = math.rad(0)
                end
                --[[m = (deltaY_mid/deltaX)
                local midpitch = math.atan(m)
                if math.abs(math.deg(pitch) - math.deg(midpitch)) < 20 then
                    pitch = pitch + ((pitch - midpitch) / 2)
                end]]--
            --[[end
        end]]--

    else
        pitch = math.rad(0)
    end

    self._pitch = pitch

end

function automobiles_lib.get_obstacle(ref_pos)
    --lets clone the table
    local retval = {x=ref_pos.x, y=ref_pos.y, z=ref_pos.z}
    --minetest.chat_send_all("aa y: " .. dump(retval.y))
    local i_pos = {x=ref_pos.x, y=ref_pos.y + 1, z=ref_pos.z}
    --minetest.chat_send_all("bb y: " .. dump(i_pos.y))

    local y = automobiles_lib.eval_interception(i_pos, {x=i_pos.x, y=i_pos.y - 4, z=i_pos.z})
    retval.y = y

    --minetest.chat_send_all("y: " .. dump(ref_pos.y) .. " ye: ".. dump(retval.y))
    return retval    
end

local function get_nodedef_field(nodename, fieldname)
    if not minetest.registered_nodes[nodename] then
        return nil
    end
    return minetest.registered_nodes[nodename][fieldname]
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
                if drawtype ~= "plantlike" then
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


