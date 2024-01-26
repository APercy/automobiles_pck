--
-- entity
--
local S = vespa.S

minetest.register_entity('automobiles_vespa:lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_vespa_lights.b3d",
    textures = {"automobiles_grey.png",},
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

minetest.register_entity('automobiles_vespa:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_vespa_r_lights.b3d",
    textures = {"automobiles_red.png",},
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

minetest.register_entity('automobiles_vespa:pivot_mesh',{
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

minetest.register_entity('automobiles_vespa:pointer',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_pointer.b3d",
    visual_size = {x = 0.8, y = 0.8, z = 0.8},
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

minetest.register_entity("automobiles_vespa:vespa", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.24, -0.1, 0.1, 1, 0.1},
	    selectionbox = {-1, 1, -1, 1, -1, 1},
        stepheight = 0.8 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_vespa_body.b3d",
        --use_texture_alpha = true,
        backface_culling = false,
        textures = {
                "automobiles_black.png", --bancos
                "automobiles_black.png", --escapamento
                "automobiles_metal.png", --eixo motor
                "automobiles_black.png", --motor
                "automobiles_painting.png", --pintura guidão e paralama
                "automobiles_black.png", --pneus
                "automobiles_metal.png", --rodas e aros
                "automobiles_painting.png", --pintura
                "automobiles_metal.png", --cromo
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = S("A very nice vespa!"),
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#dc1818",
    _steering_angle = 0,
    _engine_running = false,
    _last_checkpoint = "",
    _total_laps = -1,
    _race_id = "",
    _energy = 1,
    _last_time_collision_snd = 0,
    _last_time_drift_snd = 0,
    _last_time_command = 0,
    _roll = math.rad(0),
    _pitch = 0,
    _longit_speed = 0,
    _show_lights = false,
    _light_old_pos = nil,
    _last_ground_check = 0,
    _last_light_move = 0,
    _last_engine_sound_update = 0,
    _inv = nil,
    _inv_id = "",
    _change_color = automobiles_lib.paint,
    _intensity = 2,
    _base_pitch = 0.7,
    _trunk_slots = 0,
    _engine_sound = "vespa_engine",
    _max_fuel = 3,
    _formspec_function = vespa.driver_formspec,
    _destroy_function = vespa.destroy,
    _attach = vespa.attach_driver_stand,
    _dettach = vespa.dettach_driver_stand,
    _attach_pax = vespa.attach_pax_stand,
    _dettach_pax = vespa.dettach_pax_stand,

    get_staticdata = function(self) -- unloaded/unloads ... is now saved
        return minetest.serialize({
            stored_owner = self.owner,
            stored_hp = self.hp,
            stored_color = self._color,
            stored_steering = self._steering_angle,
            stored_energy = self._energy,
            --race data
            stored_last_checkpoint = self._last_checkpoint,
            stored_total_laps = self._total_laps,
            stored_race_id = self._race_id,
            stored_rag = self._show_rag,
            stored_pitch = self._pitch,
            stored_light_old_pos = self._light_old_pos,
            stored_inv_id = self._inv_id,
        })
    end,

	on_deactivate = function(self)
        automobiles_lib.save_inventory(self)
	end,

	on_activate = function(self, staticdata, dtime_s)
        if staticdata ~= "" and staticdata ~= nil then
            local data = minetest.deserialize(staticdata) or {}
            self.owner = data.stored_owner
            self.hp = data.stored_hp
            self._color = data.stored_color
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
            automobiles_lib.setText(self, "vespa")
        end

        self.object:set_animation({x = 1, y = 41}, 0, 0, true)

        automobiles_lib.paint(self, self._color)
        local pos = self.object:get_pos()

        local lights = minetest.add_entity(pos,'automobiles_vespa:lights')
	    lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.lights = lights
        self.lights:set_properties({is_visible=true})

        local rlights = minetest.add_entity(pos,'automobiles_vespa:r_lights')
	    rlights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.rlights = rlights
        self.rlights:set_properties({is_visible=true})

	    local driver_seat=minetest.add_entity(pos,'automobiles_vespa:pivot_mesh')
        driver_seat:set_attach(self.object,'',{x=0.0,y=-1.1,z=5.5},{x=0,y=0,z=0})
	    self.driver_seat = driver_seat

	    local passenger_seat=minetest.add_entity(pos,'automobiles_vespa:pivot_mesh')
        passenger_seat:set_attach(self.object,'',{x=0.0,y=1,z=0.09},{x=0,y=0,z=0})
	    self.passenger_seat = passenger_seat

		self.object:set_armor_groups({immortal=1})

		local inv = minetest.get_inventory({type = "detached", name = self._inv_id})
		-- if the game was closed the inventories have to be made anew, instead of just reattached
		if not inv then
            automobiles_lib.create_inventory(self, self._trunk_slots)
		else
		    self.inv = inv
        end

        self.object:set_bone_position("guidao", {x=0, y=0, z=14}, {x=22, y=180, z=0})
        self.lights:set_bone_position("guidao", {x=0, y=0, z=14}, {x=22, y=180, z=0})

        automobiles_lib.actfunc(self, staticdata, dtime_s)
	end,

	on_step = function(self, dtime)
        automobiles_lib.stepfunc(self, dtime)
        --[[sound play control]]--
        self._last_time_collision_snd = self._last_time_collision_snd + dtime
        if self._last_time_collision_snd > 1 then self._last_time_collision_snd = 1 end
        --[[end sound control]]--

        local rotation = self.object:get_rotation()
        local yaw = rotation.y
		local newyaw=yaw
        local pitch = rotation.x

        local hull_direction = minetest.yaw_to_dir(yaw)
        local nhdir = {x=hull_direction.z,y=0,z=-hull_direction.x}		-- lateral unit vector
        local velocity = self.object:get_velocity()

        local longit_speed = automobiles_lib.dot(velocity,hull_direction)
        local fuel_weight_factor = (5 - self._energy)/5000
        local longit_drag = vector.multiply(hull_direction,(longit_speed*longit_speed) *
            (vespa.LONGIT_DRAG_FACTOR - fuel_weight_factor) * -1 * automobiles_lib.sign(longit_speed))
        
		local later_speed = automobiles_lib.dot(velocity,nhdir)
        local later_drag = vector.multiply(nhdir,later_speed*
            later_speed*vespa.LATER_DRAG_FACTOR*-1*automobiles_lib.sign(later_speed))

        local accel = vector.add(longit_drag,later_drag)
        local stop = nil

        local player = nil
        local is_attached = false
        if self.driver_name then
            player = minetest.get_player_by_name(self.driver_name)
            
            if player then
                local player_attach = player:get_attach()
                if player_attach then
                    if self.driver_seat then
                        if player_attach == self.driver_seat then is_attached = true end
                    end
                end
            end
        end

        local is_breaking = false
        if is_attached then
    		local ctrl = player:get_player_control()
	        if ctrl.aux1 then
                --sets the engine running - but sets a delay also, cause keypress
                if self._last_time_command > 0.8 then
                    self._last_time_command = 0
                    --[[minetest.sound_play({name = "automobiles_horn"},
	                        {object = self.object, gain = 0.6, pitch = 1.0, max_hear_distance = 32, loop = false,})]]--
                end
	        end
            if ctrl.down then
                is_breaking = true
                self.lights:set_properties({textures={"automobiles_vespa_lights.png",}, glow=32})
                self.rlights:set_properties({textures={"automobiles_vespa_rear_lights_full.png",}, glow=32})
            end

        else
            --desligado
            self.lights:set_properties({textures={"automobiles_grey.png",}, glow=0})
            self.rlights:set_properties({textures={"automobiles_rear_lights_off.png",}, glow=0})
        end

        self._last_light_move = self._last_light_move + dtime
        if self._last_light_move > 0.15 then
            self._last_light_move = 0
            if self._show_lights == true then
                --self.lights:set_properties({is_visible=true})
                self.lights:set_properties({textures={"automobiles_vespa_lights.png",}, glow=32})
                self.rlights:set_properties({textures={"automobiles_vespa_rear_lights_full.png",}, glow=32})
                if is_breaking == false then
                    self.lights:set_properties({textures={"automobiles_vespa_lights.png",}, glow=32})
                    self.rlights:set_properties({textures={"automobiles_vespa_rear_lights_full.png",}, glow=10})
                end

                --turn the light on just when needed to avoid lag
                local target_pos = self.object:get_pos()
                target_pos.y = target_pos.y + 2
                local light_now = minetest.get_node_light(target_pos)
                if light_now < 12 then
                    automobiles_lib.put_light(self)
                end
            else
                if is_breaking == false then
                    --desligado
                    self.lights:set_properties({textures={"automobiles_grey.png",}, glow=0})
                    self.rlights:set_properties({textures={"automobiles_rear_lights_off.png",}, glow=0})
                end
                automobiles_lib.remove_light(self)
            end
        end

        local curr_pos = self.object:get_pos()
        local steering_angle_max = 30
        self.object:move_to(curr_pos)
		if is_attached then --and self.driver_name == self.owner then
            self._show_lights = true
            if self.driver_mesh then self.driver_mesh:set_properties({is_visible=true}) end
            local impact = automobiles_lib.get_hipotenuse_value(velocity, self.lastvelocity)
            if impact > 1 then
                --self.damage = self.damage + impact --sum the impact value directly to damage meter
                if self._last_time_collision_snd > 0.3 then
                    self._last_time_collision_snd = 0
                    minetest.sound_play("collision", {
                        to_player = self.driver_name,
	                    --pos = curr_pos,
	                    --max_hear_distance = 5,
	                    gain = 1.0,
                        fade = 0.0,
                        pitch = 1.0,
                    })
                end
                --[[if self.damage > 100 then --if acumulated damage is greater than 100, adieu
                    automobiles_lib.destroy(self)
                end]]--
            end

            --control
            local steering_speed = 80
            if math.abs(longit_speed) > 3 then
                local mid_speed = (steering_speed/2)
                steering_speed = mid_speed + mid_speed / math.abs(longit_speed*0.25)
            end
			accel, stop = automobiles_lib.control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, vespa.max_acc_factor, vespa.max_speed, steering_angle_max, steering_speed)
        else
            if self.driver_mesh then self.driver_mesh:set_properties({is_visible=false}) end
            self._show_lights = false
            if self.sound_handle ~= nil then
	            minetest.sound_stop(self.sound_handle)
	            self.sound_handle = nil
            end
		end

        local angle_factor = self._steering_angle / 10
        self.object:set_animation_frame_speed(longit_speed * (15 - angle_factor))

        --whell turn
        self.object:set_bone_position("eixo_direcao", {x=0, y=0, z=0}, {x=0, y=-self._steering_angle-angle_factor, z=0})
        self.lights:set_bone_position("eixo_direcao", {x=0, y=0, z=0}, {x=0, y=-self._steering_angle-angle_factor, z=0})

        if player then
            -- -30 direita -> steering_angle_max
            -- +30 esquerda
            local arm_range = 2
            local range = steering_angle_max * 2
            local armZ = -((self._steering_angle+steering_angle_max) * arm_range) / 60
            
            --player:set_bone_position("Arm_Left", {x=3.0, y=5, z=-arm_range-armZ}, {x=240-(self._steering_angle/2), y=0, z=0})
            --player:set_bone_position("Arm_Right", {x=-3.0, y=5, z=armZ}, {x=240+(self._steering_angle/2), y=0, z=0})
            if self.driver_mesh then
                self.driver_mesh:set_bone_position("Arm_Left", {x=3.0, y=5, z=-armZ-0.5}, {x=76-(self._steering_angle/2), y=0, z=0})
                self.driver_mesh:set_bone_position("Arm_Right", {x=-3.0, y=5, z=armZ+1.5}, {x=76+(self._steering_angle/2), y=0, z=0})
            end
        end

		if math.abs(self._steering_angle)>5 then
            local turn_rate = math.rad(40)
			newyaw = yaw + dtime*(1 - 1 / (math.abs(longit_speed) + 1)) *
                self._steering_angle / 20 * turn_rate * automobiles_lib.sign(longit_speed)
		end

        --[[
        accell correction
        under some circunstances the acceleration exceeds the max value accepted by set_acceleration and
        the game crashes with an overflow, so limiting the max acceleration in each axis prevents the crash
        ]]--
        local max_factor = 25
        local acc_adjusted = 10
        if accel.x > max_factor then accel.x = acc_adjusted end
        if accel.x < -max_factor then accel.x = -acc_adjusted end
        if accel.z > max_factor then accel.z = acc_adjusted end
        if accel.z < -max_factor then accel.z = -acc_adjusted end
        -- end correction

        -- calculate energy consumption --
        ----------------------------------
        if self._energy > 0 then
            local zero_reference = vector.new()
            local acceleration = automobiles_lib.get_hipotenuse_value(accel, zero_reference)
            --minetest.chat_send_all(acceleration)
            local consumed_power = acceleration/150000
            self._energy = self._energy - consumed_power;
        end
        if self._energy <= 0 then
            self._engine_running = false
            if self.sound_handle then minetest.sound_stop(self.sound_handle) end
            minetest.chat_send_player(self.driver_name, S("Out of fuel"))
        else
            self._last_engine_sound_update = self._last_engine_sound_update + dtime
            if self._last_engine_sound_update > 0.300 then
                self._last_engine_sound_update = 0
                automobiles_lib.engine_set_sound_and_animation(self, longit_speed)
            end
        end

        local energy_indicator_angle = automobiles_lib.get_gauge_angle(self._energy)
        ----------------------------
        -- end energy consumption --

        accel.y = -automobiles_lib.gravity

        if stop ~= true then
            --self.object:set_velocity(velocity)
            self.object:add_velocity(vector.multiply(accel,dtime))
            --self.object:set_acceleration(accel)
        else
            if stop == true then
                self.object:set_acceleration({x=0,y=0,z=0})
                self.object:set_velocity({x=0,y=0,z=0})
                if self._longit_speed > 0 then automobiles_lib.engineSoundPlay(self) end
            end
        end

        self._last_ground_check = self._last_ground_check + dtime
        if self._last_ground_check > 0.18 then
            self._last_ground_check = 0
            automobiles_lib.ground_get_distances(self, 0.6, 1.63)
        end
		local newpitch = self._pitch --velocity.y * math.rad(6)

        local turn_effect_speed = longit_speed
        if turn_effect_speed > 10 then turn_effect_speed = 10 end
        local newroll = (-self._steering_angle/100)*(turn_effect_speed/10)

        if is_attached == false then
            self.object:set_bone_position("descanso", {x=0, y=-0.4, z=6.2}, {x=-90, y=0, z=0})
        else
            self.object:set_bone_position("descanso", {x=0, y=-0.4, z=6.2}, {x=0, y=0, z=0})
        end

		self.object:set_rotation({x=newpitch,y=newyaw,z=newroll})

        --saves last velocity for collision detection (abrupt stop)
        self.lastvelocity = self.object:get_velocity()
        self._longit_speed = longit_speed

	end,

	on_punch = automobiles_lib.on_punch,
    on_rightclick = automobiles_lib.on_rightclick,
})


