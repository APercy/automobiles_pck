-- Minetest 5.4.1 : automobiles

automobiles_lib = {}

automobiles_lib.fuel = {['biofuel:biofuel'] = 1,['biofuel:bottle_fuel'] = 1,
                ['biofuel:phial_fuel'] = 0.25, ['biofuel:fuel_can'] = 10}

automobiles_lib.gravity = 9.8
automobiles_lib.is_creative = minetest.settings:get_bool("creative_mode", false)

--cars colors
automobiles_lib.colors ={
    black='#2b2b2b',
    blue='#0063b0',
    brown='#8c5922',
    cyan='#07B6BC',
    dark_green='#567a42',
    dark_grey='#6d6d6d',
    green='#4ee34c',
    grey='#9f9f9f',
    magenta='#ff0098',
    orange='#ff8b0e',
    pink='#ff62c6',
    red='#dc1818',
    violet='#a437ff',
    white='#FFFFFF',
    yellow='#ffe400',
}

--
-- helpers and co.
--

function automobiles_lib.get_hipotenuse_value(point1, point2)
    return math.sqrt((point1.x - point2.x) ^ 2 + (point1.y - point2.y) ^ 2 + (point1.z - point2.z) ^ 2)
end

function automobiles_lib.dot(v1,v2)
	return (v1.x*v2.x)+(v1.y*v2.y)+(v1.z*v2.z)
end

function automobiles_lib.sign(n)
	return n>=0 and 1 or -1
end

function automobiles_lib.minmax(v,m)
	return math.min(math.abs(v),m)*minekart.sign(v)
end

--painting
function automobiles_lib.paint(self, colstr)
    if colstr then
        self._color = colstr
        local l_textures = self.initial_properties.textures
        for _, texture in ipairs(l_textures) do
            local indx = texture:find('automobiles_painting.png')
            if indx then
                l_textures[_] = "automobiles_painting.png^[multiply:".. colstr
            end
        end
	    self.object:set_properties({textures=l_textures})
    end
end

-- attach player
function automobiles_lib.attach_driver(self, player)
    local name = player:get_player_name()
    self.driver_name = name

    -- attach the driver
    player:set_attach(self.driver_seat, "", {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
    player:set_eye_offset({x = 0, y = -4, z = 0}, {x = 0, y = 1, z = -30})
    player_api.player_attached[name] = true
    -- make the driver sit
    minetest.after(0.2, function()
        player = minetest.get_player_by_name(name)
        if player then
	        player_api.set_animation(player, "sit")
            --apply_physics_override(player, {speed=0,gravity=0,jump=0})
        end
    end)
end

function automobiles_lib.dettach_driver(self, player)
    local name = self.driver_name

    --self._engine_running = false

    -- driver clicked the object => driver gets off the vehicle
    self.driver_name = nil

    if self._engine_running then
	    self._engine_running = false
    end
    -- sound and animation
    if self.sound_handle then
        minetest.sound_stop(self.sound_handle)
        self.sound_handle = nil
    end

    -- detach the player
    if player then
        --automobiles_lib.remove_hud(player)

        player:set_detach()
        player_api.player_attached[name] = nil
        player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
        player_api.set_animation(player, "stand")
    end
    self.driver = nil
end

-- attach passenger
function automobiles_lib.attach_pax(self, player, onside)
    local onside = onside or false
    local name = player:get_player_name()

    if onside == true then
        if self._passenger == nil then
            self._passenger = name

            -- attach the driver
            player:set_attach(self.passenger_seat, "", {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
            player:set_eye_offset({x = 0, y = -4, z = 0}, {x = 0, y = 3, z = -30})
            player_api.player_attached[name] = true
            -- make the driver sit
            minetest.after(0.2, function()
                player = minetest.get_player_by_name(name)
                if player then
	                player_api.set_animation(player, "sit")
                    --apply_physics_override(player, {speed=0,gravity=0,jump=0})
                end
            end)
        end
    else
        --randomize the seat
        --[[local t = {1,2,3,4,5,6,7,8,9,10}
        for i = 1, #t*2 do
            local a = math.random(#t)
            local b = math.random(#t)
            t[a],t[b] = t[b],t[a]
        end

        --for i = 1,10,1 do
        for k,v in ipairs(t) do
            i = t[k]
            if self._passengers[i] == nil then
                --minetest.chat_send_all(self.driver_name)
                self._passengers[i] = name
                player:set_attach(self._passengers_base[i], "", {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
                if i > 2 then
                    player:set_eye_offset({x = 0, y = -4, z = 2}, {x = 0, y = 3, z = -30})
                else
                    player:set_eye_offset({x = 0, y = -4, z = 0}, {x = 0, y = 3, z = -30})
                end
                player_api.player_attached[name] = true
                -- make the driver sit
                minetest.after(0.2, function()
                    player = minetest.get_player_by_name(name)
                    if player then
	                    player_api.set_animation(player, "sit")
                        --apply_physics_override(player, {speed=0,gravity=0,jump=0})
                    end
                end)
                break
            end
        end]]--

    end
end

function automobiles_lib.dettach_pax(self, player)
    local name = player:get_player_name() --self._passenger

    -- passenger clicked the object => driver gets off the vehicle
    if self._passenger == name then
        self._passenger = nil
    else
        --[[for i = 10,1,-1 
        do 
            if self._passengers[i] == name then
                self._passengers[i] = nil
                break
            end
        end]]--
    end

    -- detach the player
    player:set_detach()
    player_api.player_attached[name] = nil
    player_api.set_animation(player, "stand")
    player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
    --remove_physics_override(player, {speed=1,gravity=1,jump=1})
end

function automobiles_lib.get_gauge_angle(value, initial_angle)
    initial_angle = initial_angle or 90
    local angle = value * 18
    angle = angle - initial_angle
    angle = angle * -1
	return angle
end

dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles_lib") .. DIR_DELIM .. "ground_detection.lua")

