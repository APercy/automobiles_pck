--
-- entity
--

minetest.register_entity('automobiles_trans_am:wheel',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
	visual = "mesh",
	mesh = "automobiles_trans_am_wheel.b3d",
    backface_culling = false,
	textures = {"automobiles_black.png", "automobiles_metal.png", "automobiles_trans_am_wheel.png"},
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

minetest.register_entity('automobiles_trans_am:front_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
    collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
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

    --[[on_step = function(self, dtime, moveresult)
        minetest.chat_send_all(dump(moveresult))
    end,]]--
	
})

minetest.register_entity('automobiles_trans_am:rear_suspension',{
initial_properties = {
	physical = true,
	collide_with_objects=true,
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

minetest.register_entity('automobiles_trans_am:f_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_f_lights.b3d",
    textures = {"automobiles_grey.png"},
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

minetest.register_entity('automobiles_trans_am:r_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_r_lights.b3d",
    textures = {"automobiles_rear_lights_off.png"},
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

minetest.register_entity('automobiles_trans_am:reverse_lights',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_rear_lights.b3d",
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

minetest.register_entity('automobiles_trans_am:turn_left_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_l_turn_light.b3d",
    textures = {"automobiles_rear_lights_off.png",},
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

minetest.register_entity('automobiles_trans_am:turn_right_light',{
initial_properties = {
	physical = false,
	collide_with_objects=false,
	pointable=false,
    glow = 0,
	visual = "mesh",
	mesh = "automobiles_trans_am_r_turn_light.b3d",
    textures = {"automobiles_rear_lights_off.png",},
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

minetest.register_entity('automobiles_trans_am:pivot_mesh',{
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

minetest.register_entity('automobiles_trans_am:pointer',{
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

local function paint(self, colstr)
    automobiles_lib.paint_with_mask(self, colstr, self._det_color, "automobiles_trans_am_painting.png", "automobiles_trans_am_marks.png")
    local l_textures = self.initial_properties.textures

    --paint details
    local target_texture = "automobiles_painting.png"
    local accessorie_texture = "automobiles_painting2.png"
    for _, texture in ipairs(l_textures) do
        local indx = texture:find(target_texture)
        if indx then
            l_textures[_] = target_texture.."^[multiply:".. self._det_color
        end
        local indx = texture:find(accessorie_texture)
        if indx then
            l_textures[_] = accessorie_texture.."^[multiply:".. colstr
        end
    end
    self.object:set_properties({textures=l_textures})
end

function trans_am.set_paint(self, puncher, itmstck)
    local item_name = ""
    if itmstck then item_name = itmstck:get_name() end

    if item_name == "bike:painter" then
        --painting with bike painter
        local meta = itmstck:get_meta()
	    local colstr = meta:get_string("paint_color")
        self._det_color = colstr
        paint(self, self._color)
        return true
    else
        --painting with dyes
        local split = string.split(item_name, ":")
        local color, indx, _
        if split[1] then _,indx = split[1]:find('dye') end
        if indx then
            for clr,_ in pairs(automobiles_lib.colors) do
                local _,x = split[2]:find(clr)
                if x then color = clr end
            end
            --lets paint!!!!
	        --local color = item_name:sub(indx+1)
	        local colstr = automobiles_lib.colors[color]
            --minetest.chat_send_all(color ..' '.. dump(colstr))
	        if colstr then
                self._det_color = colstr
                paint(self, self._color)
		        itmstck:set_count(itmstck:get_count()-1)
		        puncher:set_wielded_item(itmstck)
                return true
	        end
            -- end painting
        end
    end
    return false
end

minetest.register_entity("automobiles_trans_am:trans_am", {
	initial_properties = {
	    physical = true,
        collide_with_objects = true,
	    collisionbox = {-0.1, -0.2, -0.1, 0.1, 1.8, 0.1},
	    selectionbox = {-2.0, 0.0, -2.0, 2.0, 2, 2.0},
        stepheight = 0.65 + automobiles_lib.extra_stepheight,
	    visual = "mesh",
	    mesh = "automobiles_trans_am_body.b3d",
        --use_texture_alpha = true,
        --backface_culling = false,
        textures = {
            "automobiles_black.png", --bancos
            "automobiles_painting2.png", -- scoop
            "automobiles_black.png", --lights
            "automobiles_trans_am_glasses.png", --vidros
            "automobiles_trans_am_painting.png", --pintura grade frontal
            "automobiles_black.png", --detalhe grade frontal
            "automobiles_painting.png", --detalhe grade frontal
            "automobiles_black.png", --interior
            "automobiles_black.png", --painel
            "automobiles_painting.png", --fundo painel
            "automobiles_trans_am_fuel.png", --combustivel
            "automobiles_trans_am_painting.png", --pintura do carro
            "automobiles_trans_am_painting.png", --pintura das portas
            "automobiles_black.png", --forração portas e volante
            "automobiles_metal.png", --espelhos
            "automobiles_trans_am_painting.png", --spoilers
            "automobiles_painting2.png", --tomadas de ar laterais
            "automobiles_black.png", --assoalho
            "automobiles_red.png", --bancos
            "automobiles_trans_am_painting.png", --pintura
            },
    },
    textures = {},
	driver_name = nil,
	sound_handle = nil,
    owner = "",
    static_save = true,
    infotext = "A very nice Trans Am!",
    hp = 50,
    buoyancy = 2,
    physics = automobiles_lib.physics,
    lastvelocity = vector.new(),
    time_total = 0,
    _passenger = nil,
    _color = "#222222",
    _det_color = "#BDA050",
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
    _show_rag = true,
    _show_lights = false,
    _light_old_pos = nil,
    _last_ground_check = 0,
    _last_light_move = 0,
    _last_engine_sound_update = 0,
    _turn_light_timer = 0,
    _inv = nil,
    _inv_id = "",
    _change_color = paint,
    _intensity = 4,
    _car_gravity = -automobiles_lib.gravity,
    --acc control
    _transmission_state = 1,
    _painting_function = trans_am.set_paint,
    _trunk_slots = 12,
    _engine_sound = "trans_am_engine",
    _max_fuel = 10,

    get_staticdata = function(self) -- unloaded/unloads ... is now saved
        return minetest.serialize({
            stored_owner = self.owner,
            stored_hp = self.hp,
            stored_color = self._color,
            stored_det_color = self._det_color,
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
            stored_trans_am_type = self._trans_am_type,
            stored_car_gravity = self._car_gravity,
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

            self._trans_am_type = data.stored_trans_am_type
            self._car_gravity = data.stored_car_gravity or -automobiles_lib.gravity

            automobiles_lib.setText(self, "Trans Am")
        end

        self.object:set_animation({x = 1, y = 8}, 0, 0, true)
        paint(self, self._color)
        local pos = self.object:get_pos()

        local front_suspension=minetest.add_entity(self.object:get_pos(),'automobiles_trans_am:front_suspension')
	    front_suspension:set_attach(self.object,'',{x=0,y=1.5,z=27.0},{x=0,y=0,z=0})
	    self.front_suspension = front_suspension

	    local lf_wheel=minetest.add_entity(pos,'automobiles_trans_am:wheel')
	    lf_wheel:set_attach(self.front_suspension,'',{x=-trans_am.front_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
		-- set the animation once and later only change the speed
        lf_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.lf_wheel = lf_wheel

	    local rf_wheel=minetest.add_entity(pos,'automobiles_trans_am:wheel')
	    rf_wheel:set_attach(self.front_suspension,'',{x=trans_am.front_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
		-- set the animation once and later only change the speed
        rf_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.rf_wheel = rf_wheel

        local rear_suspension=minetest.add_entity(self.object:get_pos(),'automobiles_trans_am:rear_suspension')
	    rear_suspension:set_attach(self.object,'',{x=0,y=1.5,z=0},{x=0,y=0,z=0})
	    self.rear_suspension = rear_suspension

	    local lr_wheel=minetest.add_entity(pos,'automobiles_trans_am:wheel')
	    lr_wheel:set_attach(self.rear_suspension,'',{x=-trans_am.rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
		-- set the animation once and later only change the speed
        lr_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.lr_wheel = lr_wheel

	    local rr_wheel=minetest.add_entity(pos,'automobiles_trans_am:wheel')
	    rr_wheel:set_attach(self.rear_suspension,'',{x=trans_am.rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
		-- set the animation once and later only change the speed
        rr_wheel:set_animation({x = 1, y = 49}, 0, 0, true)
	    self.rr_wheel = rr_wheel

        self.object:set_bone_position("drive_adjust", {x=-4.0, y=6.50, z=15.06}, {x=15, y=0, z=0}) 

	    local driver_seat=minetest.add_entity(pos,'automobiles_trans_am:pivot_mesh')
        driver_seat:set_attach(self.object,'',{x=-4.0,y=0.8,z=9},{x=0,y=0,z=0})
	    self.driver_seat = driver_seat

	    local passenger_seat=minetest.add_entity(pos,'automobiles_trans_am:pivot_mesh')
        passenger_seat:set_attach(self.object,'',{x=4.0,y=0.8,z=9},{x=0,y=0,z=0})
	    self.passenger_seat = passenger_seat

        local fuel_gauge=minetest.add_entity(pos,'automobiles_trans_am:pointer')
        fuel_gauge:set_attach(self.object,'',trans_am_GAUGE_FUEL_POSITION,{x=0,y=0,z=0})
        self.fuel_gauge = fuel_gauge

        local lights = minetest.add_entity(pos,'automobiles_trans_am:f_lights')
	    lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.lights = lights
        self.lights:set_properties({is_visible=true})

        local r_lights = minetest.add_entity(pos,'automobiles_trans_am:r_lights')
	    r_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.r_lights = r_lights
        self.r_lights:set_properties({is_visible=true})

        local reverse_lights = minetest.add_entity(pos,'automobiles_trans_am:reverse_lights')
	    reverse_lights:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.reverse_lights = reverse_lights
        self.reverse_lights:set_properties({is_visible=true})

        local turn_l_light = minetest.add_entity(pos,'automobiles_trans_am:turn_left_light')
	    turn_l_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.turn_l_light = turn_l_light
        self.turn_l_light:set_properties({is_visible=true})

        local turn_r_light = minetest.add_entity(pos,'automobiles_trans_am:turn_right_light')
	    turn_r_light:set_attach(self.object,'',{x=0,y=0,z=0},{x=0,y=0,z=0})
	    self.turn_r_light = turn_r_light
        self.turn_r_light:set_properties({is_visible=true})

		self.object:set_armor_groups({immortal=1})

		local inv = minetest.get_inventory({type = "detached", name = self._inv_id})
		-- if the game was closed the inventories have to be made anew, instead of just reattached
		if not inv then
            automobiles_lib.create_inventory(self, self._trunk_slots)
		else
		    self.inv = inv
        end


        automobiles_lib.actfunc(self, staticdata, dtime_s)
	end,

	on_step = function(self, dtime)
        automobiles_lib.stepfunc(self, dtime)
        --[[sound play control]]--
        self._last_time_collision_snd = self._last_time_collision_snd + dtime
        if self._last_time_collision_snd > 1 then self._last_time_collision_snd = 1 end
        self._last_time_drift_snd = self._last_time_drift_snd + dtime
        if self._last_time_drift_snd > 2.0 then self._last_time_drift_snd = 2.0 end
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
            (trans_am.LONGIT_DRAG_FACTOR - fuel_weight_factor) * -1 * automobiles_lib.sign(longit_speed))
        
		local later_speed = automobiles_lib.dot(velocity,nhdir)
        local dynamic_later_drag = trans_am.LATER_DRAG_FACTOR
        if longit_speed > 2 then dynamic_later_drag = 2.0 end
        if longit_speed > 8 then dynamic_later_drag = 0.5 end
        local later_drag = vector.multiply(nhdir,later_speed*
            later_speed*dynamic_later_drag*-1*automobiles_lib.sign(later_speed))

        local accel = vector.add(longit_drag,later_drag)
        local stop = nil
        local curr_pos = self.object:get_pos()

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
                    minetest.sound_play({name = "automobiles_horn"},
	                        {object = self.object, gain = 0.6, pitch = 1.0, max_hear_distance = 32, loop = false,})
                end
	        end
            if ctrl.down then
                is_breaking = true
                self.r_lights:set_properties({textures={"automobiles_rear_lights_full.png"}, glow=15})
            end
            if ctrl.sneak then
                self.reverse_lights:set_properties({textures={"automobiles_white.png"}, glow=15})
            else
                self.reverse_lights:set_properties({textures={"automobiles_grey.png"}, glow=0})
            end
        end

        self._last_light_move = self._last_light_move + dtime
        if self._last_light_move > 0.15 then
            self._last_light_move = 0
            if self.lights then
                if self._show_lights == true then
                    --self.lights:set_properties({is_visible=true})
                    self.lights:set_properties({textures={"automobiles_trans_am_lights.png"}, glow=15})
                    if is_breaking == false then
                        self.r_lights:set_properties({textures={"automobiles_rear_lights.png"}, glow=10})
                    end
                    automobiles_lib.put_light(self)
                else
                    --self.lights:set_properties({is_visible=false})
                    self.lights:set_properties({textures={"automobiles_grey.png"}, glow=0})
                    if is_breaking == false then
                        self.r_lights:set_properties({textures={"automobiles_rear_lights_off.png"}, glow=0})
                    end
                    automobiles_lib.remove_light(self)
                end
            end
        end

        -- impacts and control
        self.object:move_to(curr_pos)
		if is_attached then --and self.driver_name == self.owner then
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
            local steering_angle_max = 40
            local steering_speed = 40
            if math.abs(longit_speed) > 3 then
                local mid_speed = (steering_speed/2)
                steering_speed = mid_speed + mid_speed / math.abs(longit_speed*0.25)
            end

            --adjust engine parameter (transmission emulation)
            local acc_factor = trans_am.max_acc_factor
            local transmission_state = automobiles_lib.get_transmission_state(longit_speed, trans_am.max_speed)

            local target_acc_factor = acc_factor
            if transmission_state == 1 then
                target_acc_factor = trans_am.max_acc_factor/2
            end
            self._transmission_state = transmission_state
            --minetest.chat_send_all(transmission_state)

            --control
			accel, stop = automobiles_lib.control(self, dtime, hull_direction, longit_speed, longit_drag, later_drag, accel, target_acc_factor, trans_am.max_speed, steering_angle_max, steering_speed)
        else
            self._show_lights = false
            if self.sound_handle ~= nil then
	            minetest.sound_stop(self.sound_handle)
	            self.sound_handle = nil
            end
		end

        local angle_factor = self._steering_angle / 10

        --whell turn
        if self.lf_wheel and self.rf_wheel and self.lr_wheel and self.rr_wheel then
            self.lf_wheel:set_attach(self.front_suspension,'',{x=-trans_am.front_wheel_xpos,y=0,z=0},{x=0,y=-self._steering_angle-angle_factor,z=0})
            self.rf_wheel:set_attach(self.front_suspension,'',{x=trans_am.front_wheel_xpos,y=0,z=0},{x=0,y=(-self._steering_angle+angle_factor)+180,z=0})
            self.lr_wheel:set_attach(self.rear_suspension,'',{x=-trans_am.rear_wheel_xpos,y=0,z=0},{x=0,y=0,z=0})
            self.rr_wheel:set_attach(self.rear_suspension,'',{x=trans_am.rear_wheel_xpos,y=0,z=0},{x=0,y=180,z=0})
        end

        --check if the tyres is touching the pavement
        local noded = automobiles_lib.nodeatpos(automobiles_lib.pos_shift(curr_pos,{y=-0.5}))
        if (noded and noded.drawtype ~= 'airlike') then
            if noded.drawtype ~= 'liquid' then
                local min_later_speed = 4.5
                if (later_speed > min_later_speed or later_speed < -min_later_speed) and
                        self._last_time_drift_snd >= 2.0 then
                    self._last_time_drift_snd = 0
                    minetest.sound_play("automobiles_drifting", {
                        pos = curr_pos,
                        max_hear_distance = 20,
                        gain = 3.0,
                        fade = 0.0,
                        pitch = 1.0,
                        ephemeral = true,
                    })
                end

                if self.lf_wheel and self.rf_wheel and self.lr_wheel and self.rr_wheel then
                    self.lf_wheel:set_animation_frame_speed(longit_speed * (12 - angle_factor))
                    self.rf_wheel:set_animation_frame_speed(-longit_speed * (12 + angle_factor))
                    self.lr_wheel:set_animation_frame_speed(longit_speed * (12 - angle_factor))
                    self.rr_wheel:set_animation_frame_speed(-longit_speed * (12 + angle_factor))
                end
            end
        end

        --drive wheel turn
        self.object:set_bone_position("drive_wheel", {x=-0, y=0, z=0}, {x=0, y=0, z=-self._steering_angle*2}) 


		if math.abs(self._steering_angle)>5 then
            local turn_rate = math.rad(40)
			newyaw = yaw + dtime*(1 - 1 / (math.abs(longit_speed) + 1)) *
                self._steering_angle / 30 * turn_rate * automobiles_lib.sign(longit_speed)
		end

        --turn light
        if self.turn_l_light and self.turn_r_light then
            self._turn_light_timer = self._turn_light_timer + dtime
            if math.abs(self._steering_angle) > 15 and self._turn_light_timer >= 1 then
                self._turn_light_timer = 0
                --set turn light
                --minetest.chat_send_all(self._steering_angle)
                if self._steering_angle < 0 then
                    --minetest.chat_send_all("direita")
                    self.turn_r_light:set_properties({textures={"automobiles_rear_lights_full.png"}, glow=20})
                end
                if self._steering_angle > 0 then
                    --minetest.chat_send_all("esquerda")
                    self.turn_l_light:set_properties({textures={"automobiles_rear_lights_full.png"}, glow=20})
                end
            end
            if self._turn_light_timer > 0.5 then
                self.turn_l_light:set_properties({textures={"automobiles_rear_lights_off.png"}, glow=0})
                self.turn_r_light:set_properties({textures={"automobiles_rear_lights_off.png"}, glow=0})
            end
            if self._turn_light_timer > 1 then
                self._turn_light_timer = 1
            end
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
            local consumed_power = acceleration/40000
            self._energy = self._energy - consumed_power;
        end
        if self._energy <= 0 then
            self._engine_running = false
            self._is_flying = 0
            if self.sound_handle then minetest.sound_stop(self.sound_handle) end
            --minetest.chat_send_player(self.driver_name, "Out of fuel")
        else
            self._last_engine_sound_update = self._last_engine_sound_update + dtime
            if self._last_engine_sound_update > 0.300 then
                self._last_engine_sound_update = 0
                automobiles_lib.engine_set_sound_and_animation(self, longit_speed)
            end
        end

        local energy_indicator_angle = automobiles_lib.get_gauge_angle(self._energy)
        if self.fuel_gauge then
            self.fuel_gauge:set_attach(self.object,'',trans_am_GAUGE_FUEL_POSITION,{x=0,y=0,z=energy_indicator_angle})
        end
        ----------------------------
        -- end energy consumption --

        --gravity works
        if not self._is_flying or self._is_flying == 0 then
            accel.y = -automobiles_lib.gravity
        else
            local time_correction = (self.dtime/trans_am.ideal_step)
            local y_accel = self._car_gravity*time_correction
            accel.y = y_accel --sets the anti gravity
        end

        if stop ~= true then
            --self.object:set_velocity(velocity)
            self.object:set_acceleration(accel)
        else
            if stop == true then
                self.object:set_acceleration({x=0,y=0,z=0})
                self.object:set_velocity({x=0,y=0,z=0})
            end
        end

        self._last_ground_check = self._last_ground_check + dtime
        if self._last_ground_check > 0.18 then
            self._last_ground_check = 0
            automobiles_lib.ground_get_distances(self, 0.372, 2.7)
        end
		local newpitch = self._pitch --velocity.y * math.rad(6)

        local newroll = 0
		self.object:set_rotation({x=newpitch,y=newyaw,z=newroll})

        --saves last velocity for collision detection (abrupt stop)
        self.lastvelocity = self.object:get_velocity()
        self._longit_speed = longit_speed

	end,

	on_punch = automobiles_lib.on_punch,
	on_rightclick = automobiles_lib.on_rightclick,
})


