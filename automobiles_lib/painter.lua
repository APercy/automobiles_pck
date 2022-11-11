--[[
Copyright (C) 2022 Alexsandro Percy
Copyright (C) 2018 Hume2

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
]]--

local S = minetest.get_translator(minetest.get_current_modname())

local function is_hex(color)
    if not color or color:len() ~= 7 then return end
    return color:match("#%x%x%x%x%x%x")
end

-- hex translation
local function hex_to_rgb(hex_value)
    hex_value = hex_value:gsub("#","")
    local rgb = {
        r = tonumber("0x"..hex_value:sub(1,2)),
        g = tonumber("0x"..hex_value:sub(3,4)),
        b = tonumber("0x"..hex_value:sub(5,6)),
    }
    return rgb
end

local function rgb_to_hex(rgb)
    return string.format("#%02X%02X%02X", rgb.r, rgb.g, rgb.b)
end

-- Painter formspec
local function painter_form(player, rgb)
    local color = rgb_to_hex(rgb)
    minetest.show_formspec(player:get_player_name(), "automobiles_lib:painter",
        -- Init formspec
        "formspec_version[3]" .. -- Minetest 5.2+
        "size[5.6,5.2;true]" ..
        "position[0.5,0.45]" ..

        -- Color preview
        "image[0.2,0.2;2,2;automobiles_painting.png^[colorize:" .. color .. ":255]" ..
        "label[0.3,1.2;Preview]" ..

        -- Hex field
        "field_close_on_enter[hex;false]" ..
        "field[2.4,0.2;3,0.8;hex;;" .. color .. "]" ..
        "button[2.4,1;3,0.8;set_hex;Set Hex]" ..

        -- RGB sliders
        "container[0,2.4]" ..
        "scrollbaroptions[min=0;max=255;smallstep=20]" ..

        "box[0.4,0;4.77,0.38;red]" ..
        "label[0.2,0.2;-]" ..
        "scrollbar[0.4,0;4.8,0.4;horizontal;r;" .. rgb.r .."]" ..
        "label[5.2,0.2;+]" ..

        "box[0.4,0.6;4.77,0.38;green]" ..
        "label[0.2,0.8;-]" ..
        "scrollbar[0.4,0.6;4.8,0.4;horizontal;g;" .. rgb.g .."]" ..
        "label[5.2,0.8;+]" ..

        "box[0.4,1.2;4.77,0.38;blue]" ..
        "label[0.2,1.4;-]" ..
        "scrollbar[0.4,1.2;4.8,0.4;horizontal;b;" .. rgb.b .. "]" ..
        "label[5.2,1.4;+]" ..

        "container_end[]" ..

        -- Bottom buttons
        "button_exit[0.2,4.2;2.8,0.8;set_color;Set Color]" ..
        "button_exit[3.2,4.2;2.2,0.8;quit;Cancel]"
    )
end

local automobiles_being_painted = {}
local formspec_timers = {}

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "automobiles_lib:painter" then
        if formspec_timers[player] then
            formspec_timers[player]:cancel()
            formspec_timers[player] = nil
        end

        local function parse_scrollbar_field(value)
            value = value or ""
            local num = math.floor(tonumber((value:gsub(".*:", ""))) or 0)
            if num > 255 or num < 0 then num = 0 end
            return num
        end

        local rgb = {
            r = parse_scrollbar_field(fields.r),
            g = parse_scrollbar_field(fields.g),
            b = parse_scrollbar_field(fields.b),
        }

        if fields.set_hex or fields.key_enter then
            if is_hex(fields.hex) then
                painter_form(player, hex_to_rgb(fields.hex))
            else
                painter_form(player, rgb)
            end
        elseif fields.set_color then
            local object_ref = automobiles_being_painted[player]
            if object_ref and object_ref:get_pos() then
                local luaentity = object_ref:get_luaentity()
                luaentity:_change_color(rgb_to_hex(rgb))
            end
            automobiles_being_painted[player] = nil
        elseif fields.r and fields.r:find("^CHG") or
        fields.g and fields.g:find("^CHG") or
        fields.b and fields.b:find("^CHG") then -- Has a scrollbar changed?
            formspec_timers[player] = minetest.after(0.2, function(itemstack, name)
                local player = minetest.get_player_by_name(name)
                if player then
                    painter_form(player, rgb)
                end
                formspec_timers[player] = nil
            end, itemstack, player:get_player_name())
        end

        if fields.quit then
            automobiles_being_painted[player] = nil
        end
        return true
    end
end)


-- Make the actual thingy
minetest.register_tool("automobiles_lib:painter", {
    description = S("Automobiles Painter"),
    inventory_image = "automobiles_painter.png",
    wield_scale = {x = 2, y = 2, z = 1},
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type == "object" and not pointed_thing.ref:is_player() then
            local luaentity = pointed_thing.ref:get_luaentity()
            if luaentity and type(luaentity._change_color) == "function" then
                local player_name = user:get_player_name()
                if not luaentity.owner or luaentity.owner == player_name then
                    automobiles_being_painted[user] = pointed_thing.ref
                    local color = luaentity._color
                    local rgb = is_hex(color) and hex_to_rgb(color) or {r = 0, g = 0, b = 0}
                    painter_form(user, rgb)
                else
                    minetest.chat_send_player(player_name, "Only the owner can paint this entity.")
                end
            end
        end
    end
})

minetest.register_on_leaveplayer(function(player, timed_out)
    automobiles_being_painted[player] = nil
end)

minetest.register_craft({
    output = "automobiles_lib:painter",
    recipe = {
        {"", "default:steel_ingot", ""},
        {"dye:red", "dye:green", "dye:blue"},
        {"", "default:steel_ingot", ""},
    },
})
