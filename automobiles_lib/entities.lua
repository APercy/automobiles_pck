minetest.register_entity('automobiles_lib:pivot_mesh',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pivot_mesh.b3d",
    textures = {"automobiles_black.png",},
	},
	
    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
	
})

minetest.register_entity('automobiles_lib:pointer',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pointer.b3d",
    visual_size = {x = 0.5, y = 0.5, z = 0.5},
	textures = {"automobiles_white.png"},
	},
	
    on_activate = function(self,std)
	    self.sdata = minetest.deserialize(std) or {}
	    if self.sdata.remove then self.object:remove() end
    end,
	    
    get_staticdata=function(self)
      self.sdata.remove=true
      return minetest.serialize(self.sdata)
    end,
})

function automobiles_lib.on_rightclick (self, clicker)
	if not clicker or not clicker:is_player() then
		--return
	end

	local name = clicker:get_player_name()
    --[[if self.owner and self.owner ~= name and self.owner ~= "" then return end]]--
    if self.owner == "" then
        self.owner = name
    end
    
	if name == self.driver_name then
        local formspec_f = automobiles_lib.driver_formspec
        if self._formspec_function then formspec_f = self._formspec_function end
        formspec_f(name)
	else
        if name == self.owner or
            (self.driver_name == nil and
            ( minetest.check_player_privs(clicker, "valet_parking") or minetest.check_player_privs(clicker, {server=true}) )
            ) then
            if clicker:get_player_control().aux1 == true then
                automobiles_lib.show_vehicle_trunk_formspec(self, clicker, self._trunk_slots)
            else
                --is the owner, okay, lets attach
                local attach_driver_f = automobiles_lib.attach_driver
                if self._attach then attach_driver_f = self._attach end
                attach_driver_f(self, clicker)
                -- sound
                local base_pitch = 1
                if self._base_pitch then base_pitch = self._base_pitch end
                self.sound_handle = minetest.sound_play({name = self._engine_sound},
                        {object = self.object, gain = 1, pitch = base_pitch, max_hear_distance = 30, loop = true,})
            end
        else
            --minetest.chat_send_all("clicou")
            --a passenger
            if not player_api.player_attached[name] then
                --there is no passenger, so lets attach
                if self.driver_name then
                    local attach_pax_f = automobiles_lib.attach_pax
                    if self._attach_pax then attach_pax_f = self._attach_pax end
                    attach_pax_f(self, clicker, true)
                end
            else
                --there is a passeger
                --if you are the psenger, so deattach
                local dettach_pax_f = automobiles_lib.dettach_pax
                if self._dettach_pax then dettach_pax_f = self._dettach_pax end
                dettach_pax_f(self, clicker)
            end
        end
	end
end

function automobiles_lib.on_punch (self, puncher, ttime, toolcaps, dir, damage)
	if not puncher or not puncher:is_player() then
		return
	end

	local name = puncher:get_player_name()
    --[[if self.owner and self.owner ~= name and self.owner ~= "" then return end]]--
    if self.owner == nil then
        self.owner = name
    end
    	
    if self.driver_name and self.driver_name ~= name then
		-- do not allow other players to remove the object while there is a driver
		return
	end
    
    local is_attached = false
    if puncher:get_attach() == self.driver_seat then is_attached = true end

    local itmstck=puncher:get_wielded_item()
    local item_name = ""
    if itmstck then item_name = itmstck:get_name() end

    --refuel procedure
    --[[
    refuel works it car is stopped and engine is off
    ]]--
    local velocity = self.object:get_velocity()
    local speed = automobiles_lib.get_hipotenuse_value(vector.new(), velocity)
    --if math.abs(speed) <= 0.1 then
    local was_refueled = automobiles_lib.loadFuel(self, puncher:get_player_name(), false, self._max_fuel)
    if was_refueled then
        return
    end
    --end
    -- end refuel

    if is_attached == false then

        -- deal with painting or destroying
	    if itmstck then
            --race status restart
            if item_name == "checkpoints:status_restarter" and self._engine_running == false then
                --restart race current status
                self._last_checkpoint = ""
                self._total_laps = -1
                self._race_id = ""
                return
            end

            local paint_f = automobiles_lib.set_paint
            if self._painting_function then paint_f = self._painting_function end
            if paint_f(self, puncher, itmstck) == false then
                local is_admin = false
                is_admin = minetest.check_player_privs(puncher, {server=true})
                --minetest.chat_send_all('owner '.. self.owner ..' - name '.. name)
			    if not self.driver and (self.owner == name or is_admin == true) and toolcaps and
                        toolcaps.damage_groups and toolcaps.damage_groups.fleshy then
                    self.hp = self.hp - 10
                    minetest.sound_play("automobiles_collision", {
                        object = self.object,
                        max_hear_distance = 5,
                        gain = 1.0,
                        fade = 0.0,
                        pitch = 1.0,
                    })
			    end
		    end
        end

        if self.hp <= 0 then
            local destroy_f = automobiles_lib.destroy
            if self._destroy_function then destroy_f = self._destroy_function end
            destroy_f(self)
        end

    end
end

function automobiles_lib.get_staticdata(self) 
    return minetest.serialize({
        stored_owner = self.owner,
        stored_hp = self.hp,
        stored_color = self._color,
        stored_det_color = self._det_color,
        stored_steering = self._steering_angle,
        stored_energy = self._energy,
        stored_rag = self._show_rag,
        stored_pitch = self._pitch,
        stored_light_old_pos = self._light_old_pos,
        stored_inv_id = self._inv_id,
        stored_car_type = self._car_type,
        stored_car_gravity = self._car_gravity,
        --race data
        stored_last_checkpoint = self._last_checkpoint,
        stored_total_laps = self._total_laps,
        stored_race_id = self._race_id,
    })
end

function automobiles_lib.on_activate(self, staticdata, dtime_s)
    if staticdata ~= "" and staticdata ~= nil then
        local data = minetest.deserialize(staticdata) or {}
        self.owner = data.stored_owner
        self.hp = data.stored_hp
        self._color = data.stored_color
        self._det_color = data.stored_det_color
        self._steering_angle = data.stored_steering
        self._energy = data.stored_energy
        --minetest.debug("loaded: ", self.energy)
        --race data
        self._last_checkpoint = data.stored_last_checkpoint
        self._total_laps = data.stored_total_laps
        self._race_id = data.stored_race_id
        self._show_rag = data.stored_rag
        self._pitch = data.stored_pitch
        self._light_old_pos = data.stored_light_old_pos
        self._inv_id = data.stored_inv_id

        self._car_type = data.stored_car_type
        self._car_gravity = data.stored_car_gravity or -automobiles_lib.gravity

        automobiles_lib.setText(self, self._vehicle_name)
    end

    if self._painting_load then
        self._painting_load(self, self._color)
    else
        automobiles_lib.paint(self, self._color)
    end
    local pos = self.object:get_pos()

    local front_suspension=minetest.add_entity(self.object:get_pos(),self._front_suspension_ent)
    front_suspension:set_attach(self.object,'',self._front_suspension_pos,{x=0,y=0,z=0})
    self.front_suspension = front_suspension

    local lf_wheel=minetest.add_entity(pos,self._front_wheel_ent)
    lf_wheel:set_attach(self.front_suspension,'',{x=-self._front_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
	-- set the animation once and later only change the speed
    lf_wheel:set_animation(self._front_wheel_frames, 0, 0, true)
    self.lf_wheel = lf_wheel

    local rf_wheel=minetest.add_entity(pos,self._front_wheel_ent)
    rf_wheel:set_attach(self.front_suspension,'',{x=self._front_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
	-- set the animation once and later only change the speed
    rf_wheel:set_animation(self._front_wheel_frames, 0, 0, true)
    self.rf_wheel = rf_wheel

    local rear_suspension=minetest.add_entity(self.object:get_pos(),self._rear_suspension_ent)
    rear_suspension:set_attach(self.object,'',self._rear_suspension_pos,{x=0,y=0,z=0})
    self.rear_suspension = rear_suspension

    local lr_wheel=minetest.add_entity(pos,self._rear_wheel_ent)
    lr_wheel:set_attach(self.rear_suspension,'',{x=-self._rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
	-- set the animation once and later only change the speed
    lr_wheel:set_animation(self._rear_wheel_frames, 0, 0, true)
    self.lr_wheel = lr_wheel

    local rr_wheel=minetest.add_entity(pos,self._rear_wheel_ent)
    rr_wheel:set_attach(self.rear_suspension,'',{x=self._rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
	-- set the animation once and later only change the speed
    rr_wheel:set_animation(self._rear_wheel_frames, 0, 0, true)
    self.rr_wheel = rr_wheel


    if self._steering_ent then
	    local steering_axis=minetest.add_entity(pos,'automobiles_lib:pivot_mesh')
        steering_axis:set_attach(self.object,'',self._drive_wheel_pos,{x=self._drive_wheel_angle,y=0,z=0})
	    self.steering_axis = steering_axis

	    local steering=minetest.add_entity(self.steering_axis:get_pos(), self._steering_ent)
        steering:set_attach(self.steering_axis,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.steering = steering
    else
        self.object:set_bone_position("drive_adjust", self._drive_wheel_pos, {x=self._drive_wheel_angle, y=0, z=0}) 
    end

    if self._rag_retracted_ent then
        local rag_rect=minetest.add_entity(self.object:get_pos(),self._rag_retracted_ent)
	    rag_rect:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.rag_rect = rag_rect
        self.rag_rect:set_properties({is_visible=false})
    end

    if self._rag_extended_ent then
        local rag=minetest.add_entity(self.object:get_pos(),self._rag_extended_ent)
	    rag:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.rag = rag
    end

    automobiles_lib.seats_create(self)

    --[[local driver_seat=minetest.add_entity(pos,'automobiles_lib:pivot_mesh')
    driver_seat:set_attach(self.object,'',self._seat_pos[1],{x=0,y=0,z=0})
    self.driver_seat = driver_seat

    local passenger_seat=minetest.add_entity(pos,'automobiles_lib:pivot_mesh')
    passenger_seat:set_attach(self.object,'',self._seat_pos[2],{x=0,y=0,z=0})
    self.passenger_seat = passenger_seat]]--

    local pointer_entity = 'automobiles_lib:pointer'
    if self._gauge_pointer_ent then pointer_entity = self._gauge_pointer_ent end
    local fuel_gauge=minetest.add_entity(pos, pointer_entity)
    fuel_gauge:set_attach(self.object,'',self._fuel_gauge_pos,{x=0,y=0,z=0})
    self.fuel_gauge = fuel_gauge

    if self._front_lights then
        local lights = minetest.add_entity(pos,self._front_lights)
        lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.lights = lights
        self.lights:set_properties({is_visible=true})
    end

    if self._rear_lights then
        local r_lights = minetest.add_entity(pos,self._rear_lights)
        r_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.r_lights = r_lights
        self.r_lights:set_properties({is_visible=true})
    end

    if self._reverse_lights then
        local reverse_lights = minetest.add_entity(pos,self._reverse_lights)
        reverse_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.reverse_lights = reverse_lights
        self.reverse_lights:set_properties({is_visible=true})
    end

    if self._turn_left_lights then
        local turn_l_light = minetest.add_entity(pos,self._turn_left_lights)
        turn_l_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.turn_l_light = turn_l_light
        self.turn_l_light:set_properties({is_visible=true})
    end

    if self._turn_right_lights then
        local turn_r_light = minetest.add_entity(pos,self._turn_right_lights)
        turn_r_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
        self.turn_r_light = turn_r_light
        self.turn_r_light:set_properties({is_visible=true})
    end

    if self._extra_items_function then
        self._extra_items_function(self)
    end

	self.object:set_armor_groups({immortal=1})

	local inv = minetest.get_inventory({type = "detached", name = self._inv_id})
	-- if the game was closed the inventories have to be made anew, instead of just reattached
	if not inv then
        automobiles_lib.create_inventory(self, self._trunk_slots)
	else
	    self.inv = inv
    end

    automobiles_lib.actfunc(self, staticdata, dtime_s)
end
