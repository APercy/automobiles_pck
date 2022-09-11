local storage = minetest.get_mod_storage()
automobiles_lib.modname = minetest.get_current_modname()

local function get_formspec_by_size(self, size)
    local background = default.gui_bg .. default.gui_bg_img .. default.gui_slots
    local default_inventory_formspecs = {
	    ["4"]="size[8,6]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;2,0;4,1;]" ..
	    "list[current_player;main;0,2;8,4;]" ..
	    "listring[]",

	    ["6"]="size[8,6]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;1,0;6,1;]"..
	    "list[current_player;main;0,2;8,4;]" ..
	    "listring[]",

	    ["8"]="size[8,6]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;0,0;8,1;]"..
	    "list[current_player;main;0,2;8,4;]" ..
	    "listring[]",

	    ["12"]="size[8,7]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;1,0;6,2;]"..
	    "list[current_player;main;0,3;8,4;]" ..
	    "listring[]",

	    ["16"]="size[8,7]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;0,0;8,2;]"..
	    "list[current_player;main;0,3;8,4;]" ..
	    "listring[]",

	    ["24"]="size[8,8]".. background ..
	    "list[context:" .. self._inv_id .. ";main;0,0;8,3;]"..
	    "list[current_player;main;0,4;8,4;]" ..
	    "listring[]",

	    ["32"]="size[8,9]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;0,0.3;8,4;]"..
	    "list[current_player;main;0,4.85;8,1;]"..
	    "list[current_player;main;0,6.08;8,3;8]"..
	    "listring[context;main]" ..
	    "listring[current_player;main]" ..
	    default.get_hotbar_bg(0,4.85),

	    ["50"]="size[10,10]".. background ..
	    "list[detached:" .. self._inv_id .. ";main;0,0;10,5;]"..
	    "list[current_player;main;1,6;8,4;]" ..
	    "listring[]",
    }

	local formspec = default_inventory_formspecs[tostring(size)]
	return formspec
end

local function inventory_id(maker_name)
	local id= automobiles_lib.modname .. "_" .. maker_name .. "_"
	for i=0,5 do
		id=id..(math.random(0,9))
	end
	return id
end

function automobiles_lib.load_inventory(self)
	if self._inv then
		local inv_content = minetest.deserialize(storage:get_string(self._inv_id))
        if inv_content then
		    self._inv:set_list("main", inv_content)
        end
	end
end

function automobiles_lib.save_inventory(self)
    if self._inv then
	    local inv_content = self._inv:get_list("main")
        if inv_content then
	        for k, v in pairs(inv_content) do
		        inv_content[k] = v:to_string()
	        end

	        local inv_content = minetest.serialize(inv_content)
	        storage:set_string(self._inv_id, inv_content)
        end
    end
end

function automobiles_lib.remove_inventory(self)
    local inventory = automobiles_lib.get_inventory(self)
    if inventory then
        if inventory:is_empty("main") then
	        return minetest.remove_detached_inventory(self._inv_id)
        else
            local inv_content = inventory:get_list("main")
            if inv_content then
                local pos = self.object:get_pos()
                for k, v in pairs(inv_content) do
                    local count = 0
                    for i = 0,v:get_count()-1,1 
                    do 
                        minetest.add_item({x=pos.x+math.random()-0.5,y=pos.y,z=pos.z+math.random()-0.5},v:get_name())
                        count = count + 1
                        if count >= 5 then break end
                    end
                end
            end
            return minetest.remove_detached_inventory(self._inv_id)
        end
    end
    return false
end

function automobiles_lib.destroy_inventory(self)
    automobiles_lib.remove_inventory(self)
    storage:set_string(self._inv_id, nil)
end

--show inventory form to user
function automobiles_lib.show_vehicle_trunk_formspec(self, player, size)
    if size then
        local form = get_formspec_by_size(self, size)
        if form then
            minetest.show_formspec(player:get_player_name(), automobiles_lib.modname .. ":inventory",
                form
            )
        end
    end
end

function automobiles_lib.create_inventory(self, size, owner)
    owner = owner or ""
    if owner == "" then owner = self.owner end
    if owner ~= nil and owner ~= "" then
        if self._inv_id == "" then
            self._inv_id = inventory_id(owner)
        end
        local vehicle_inv = minetest.create_detached_inventory(self._inv_id, {
            allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
                return count -- allow moving
            end,

            allow_put = function(inv, listname, index, stack, player)
                return stack:get_count() -- allow putting
            end,

            allow_take = function(inv, listname, index, stack, player)
                return stack:get_count() -- allow taking
            end,
	        on_put = function(inv, toList, toIndex, stack, player)
                automobiles_lib.save_inventory(self)
	        end,
	        on_take = function(inv, toList, toIndex, stack, player)
                automobiles_lib.save_inventory(self)
	        end,
            on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
                automobiles_lib.save_inventory(self)
            end,
        })
        if size >= 8 then
            if vehicle_inv:set_size("main", size) then
	            vehicle_inv:set_width("main", 8)
            end
        else
            vehicle_inv:set_size("main", size)
        end
	    self._inv = vehicle_inv
        automobiles_lib.load_inventory(self)
    end
end

function automobiles_lib.get_inventory(self)
    if self._inv then
        return minetest.get_inventory({type="detached", name=self._inv_id})
    end
    return nil
end

function automobiles_lib.list_inventory(self)
    local inventory = automobiles_lib.get_inventory(self)
    if inventory then
        local list = inventory.get_list("main")
        
        minetest.chat_send_all(dump(list))
    end
end

