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

--[[painting functions adapted from bike mod]]--

local function is_hex(color)
    if color:len() ~= 7 then return nil end
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

local function rgb_to_hex(r, g, b)
    return string.format("#%02X%02X%02X", r, g, b)
end

-- Painter formspec
local function painter_form(itemstack, player)
    local meta = itemstack:get_meta()
    local color = meta:get_string("paint_color")
    if color == nil or color == "" then
        color = "#FFFFFF"
        meta:set_string("paint_color", color)
        meta:set_string("description", "Automobiles Painter ("..color:upper()..")")
    end
    local rgb = hex_to_rgb(color)
    minetest.show_formspec(player:get_player_name(), "automobiles_lib:painter",
        -- Init formspec
        "size[6,4.7;true]"..
        "position[0.5, 0.45]"..
        -- Preview
        "label[0,0;Preview:]"..
        "image[1.2,0;2,2;automobiles_painting.png^[colorize:"..color..":255]"..
        -- RGB sliders
        "scrollbaroptions[min=0;max=255]"..
        "scrollbar[0,2;5,0.3;horizontal;r;"..rgb.r.."]"..
        "label[5.1,1.9;R: "..rgb.r.."]"..
        "scrollbar[0,2.6;5,0.3;horizontal;g;"..rgb.g.."]"..
        "label[5.1,2.5;G: "..rgb.g.."]"..
        "scrollbar[0,3.2;5,0.3;horizontal;b;"..rgb.b.."]"..
        "label[5.1,3.1;B: "..rgb.b.."]"..
        -- Hex field
        "field[0.3,4.5;2,0.8;hex;Hex Color;"..color.."]"..
        "button[4.05,4.1;2,1;set;Set color]"
    )
end

local formspec_timers = {}

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "automobiles_lib:painter" then
        if formspec_timers[player] then
            formspec_timers[player]:cancel()
            formspec_timers[player] = nil
        end

        local itemstack = player:get_wielded_item()
        if fields.set or fields.quit then
            if itemstack:get_name() == "automobiles_lib:painter" then
                local meta = itemstack:get_meta()
                local hex = fields.hex
                if hex then
                    if is_hex(hex) == nil then
                        hex = "#FFFFFF"
                    end
                    -- Save color data to painter (rgba sliders will adjust to hex/alpha too!)
                    meta:set_string("paint_color", hex)
                    meta:set_string("description", "Automobiles Painter ("..hex:upper()..")")
                    player:set_wielded_item(itemstack)
                    painter_form(itemstack, player)
                end
            end
        elseif fields.r or fields.g or fields.b then
            if itemstack:get_name() == "automobiles_lib:painter" then
                -- Save on slider adjustment (hex/alpha will adjust to match the rgba!)
                local meta = itemstack:get_meta()
                local function sval(value)
                    local num = math.floor(tonumber((value:gsub(".*:", ""))) or 0)
                    if num > 255 or num < 0 then num = 0 end
                    return num
                end
                meta:set_string("paint_color", rgb_to_hex(sval(fields.r),sval(fields.g),sval(fields.b)))
                -- Keep track of what this painter is painting
                meta:set_string("description", "Automobiles Painter ("..meta:get_string("paint_color"):upper()..")")
                
                formspec_timers[player] = minetest.after(0.2, function(itemstack, name)
                    local player = minetest.get_player_by_name(name)
                    if player then
                        local wield = player:get_wielded_item()
                        if wield:get_name() == itemstack:get_name() then
                            player:set_wielded_item(itemstack)
                            painter_form(itemstack, player)
                        end
                    end
                    formspec_timers[player] = nil
                end, itemstack, player:get_player_name())
            end
        end
        return true
    end
end)
--[[end of adaptations]]--


-- Make the actual thingy
minetest.register_tool("automobiles_lib:painter", {
    description = "Automobiles Painter",
    inventory_image = "automobiles_painter.png",
    wield_scale = {x = 2, y = 2, z = 1},
    on_place = painter_form,
    on_secondary_use = painter_form,
})

minetest.register_craft({
    output = "automobiles_lib:painter",
    recipe = {
        {"", "default:steel_ingot", ""},
        {"dye:red", "dye:green", "dye:blue"},
        {"", "default:steel_ingot", ""},
    },
})
