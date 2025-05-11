minetest.register_entity('automobiles_vespa:player_mesh',{
initial_properties = {
	    physical = false,
	    collide_with_objects=false,
	    pointable=false,
	    visual = "mesh",
	    mesh = "character.b3d",
	    textures = {"character.png"},
        is_visible = false,
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

-- attach player
function vespa.attach_driver_stand(self, player)
    local name = player:get_player_name()
    self.driver_name = name
    self.driver_properties = player:get_properties()
    self.driver_properties.selectionbox = nil
    self.driver_properties.pointable = false
    self.driver_properties.show_on_minimap = false
    self.driver_properties.static_save = nil
    self.driver_properties.makes_footstep_sound = nil
    --minetest.chat_send_all(dump(self.driver_properties))
   
    -- attach the driver
    local x_pos = 0  --WHY?! because after the 5.9.1 version the motorcycle got an strange shaking. But when I move it from the center, it ceases. Then I use the camera center bug.
    --player:set_attach(self.driver_seat, "", {x = x_pos, y = 0, z = 0}, {x = 0, y = 0, z = 0})
    player:set_attach(self.object, "", self._seat_pos[1], {x = 0, y = 0, z = 0})
    --player:set_eye_offset({x = 0, y = 0, z = 1.5}, {x = 0, y = 3, z = -30})
    player:set_eye_offset({x = self._seat_pos[1].x, y = 0, z = self._seat_pos[1].z}, {x = 0, y = 3, z = -30})
    if automobiles_lib.is_minetest then
        player_api.player_attached[name] = true
    elseif airutils.is_mcl then
        mcl_player.player_attached[name] = true
    end

    -- makes it "invisible"
    player:set_properties({mesh = "automobiles_pivot_mesh.b3d"})
    

    --create the dummy mesh
    local pos = player:get_pos()
    local driver_mesh=minetest.add_entity(pos,'automobiles_vespa:player_mesh')
    driver_mesh:set_attach(player,'',{x=x_pos*-1,y=-0.0,z=0.0},{x=0,y=0,z=0})
    self.driver_mesh = driver_mesh
    self.driver_mesh:set_properties({is_visible=false})

    --position the dummy arms and legs
    self.driver_mesh:set_properties(self.driver_properties)
    if automobiles_lib.mot_anim_mode then
        self.driver_mesh:set_bone_position("Leg_Left", {x=1.1, y=1, z=0}, {x=180+12, y=0, z=7})
        self.driver_mesh:set_bone_position("Leg_Right", {x=-1.1, y=1, z=0}, {x=180+12, y=0, z=-7})
    end
	self.driver_mesh:set_properties({
        is_visible=true,
	})
end

function vespa.dettach_driver_stand(self, player)
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
        player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
        if automobiles_lib.is_minetest then
            if player_api.player_attached[name] then
                player_api.player_attached[name] = nil
            end
            player_api.set_animation(player, "stand")
        elseif automobiles_lib.is_mcl then
            if mcl_player.player_attached[name] then
                mcl_player.player_attached[name] = nil
            end
            mcl_player.player_set_animation(player, "stand")
        end


        if self.driver_properties then
            player:set_properties({mesh = self.driver_properties.mesh})
            self.driver_properties = nil
        end
    end

    --player:set_properties({visual_size = {x=1, y=1}})
    if self.driver_mesh then
        self.driver_mesh:set_properties({is_visible=false})
        self.driver_mesh:remove()
    end
    self.driver = nil
end

-- attach passenger
function vespa.attach_pax_stand(self, player)
    local onside = onside or false
    local name = player:get_player_name()

    self.pax_properties = player:get_properties()
    self.pax_properties.selectionbox = nil
    self.pax_properties.pointable = false
    self.pax_properties.show_on_minimap = false
    self.pax_properties.static_save = nil
    self.pax_properties.makes_footstep_sound = nil

    if self._passenger == nil then
        self._passenger = name

        -- attach the driver
        local x_pos = 0  --WHY?! because after the 5.9.1 version the motorcycle got an strange shaking. But when I move it from the center, it ceases. Then I use the camera center bug.
        --player:set_attach(self.passenger_seat, "", {x = x_pos, y = 0, z = 0}, {x = 0, y = 0, z = 0})
        player:set_attach(self.object, "", self._seat_pos[2], {x = 0, y = 0, z = 0})
        --player:set_eye_offset({x = 0, y = 3, z = 0}, {x = 0, y = 3, z = -30})
        player:set_eye_offset({x = self._seat_pos[2].x, y = 3, z = self._seat_pos[2].z}, {x = 0, y = 3, z = -30})
        if automobiles_lib.is_minetest then
            player_api.player_attached[name] = true
        elseif airutils.is_mcl then
            mcl_player.player_attached[name] = true
        end

        -- makes it "invisible"
        player:set_properties({mesh = "automobiles_pivot_mesh.b3d"})

        --create the dummy mesh
        local pos = player:get_pos()
        local pax_mesh=minetest.add_entity(pos,'automobiles_vespa:player_mesh')        
        pax_mesh:set_attach(player,'',{x=x_pos*-1,y=-0.0,z=0.0},{x=0,y=0,z=0})
        self.pax_mesh = pax_mesh
        self.pax_mesh:set_properties({is_visible=false})

        --position the dummy arms and legs
        self.pax_mesh:set_properties(self.pax_properties)
        if automobiles_lib.mot_anim_mode then
            self.pax_mesh:set_bone_position("Leg_Left", {x=1.1, y=0, z=0}, {x=180+12, y=0, z=15})
            self.pax_mesh:set_bone_position("Leg_Right", {x=-1.1, y=0, z=0}, {x=180+12, y=0, z=-15})

            self.pax_mesh:set_bone_position("Arm_Left", {x=3.0, y=5, z=0}, {x=180+45, y=0, z=0})
            self.pax_mesh:set_bone_position("Arm_Right", {x=-3.0, y=5, z=0}, {x=180+45, y=0, z=0})
        end
	    self.pax_mesh:set_properties({
            is_visible=true,
	    })
    end

end

function vespa.dettach_pax_stand(self, player)
    if not player then return end
    local name = player:get_player_name() --self._passenger

    -- passenger clicked the object => driver gets off the vehicle
    if self._passenger == name then
        self._passenger = nil
    end

    -- detach the player
    if player then
        --player:set_properties({physical=true})
        player:set_detach()
        player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})

        if automobiles_lib.is_minetest then
            if player_api.player_attached[name] then
                player_api.player_attached[name] = nil
            end
            player_api.set_animation(player, "stand")
        elseif automobiles_lib.is_mcl then
            if mcl_player.player_attached[name] then
                mcl_player.player_attached[name] = nil
            end
            mcl_player.player_set_animation(player, "stand")
        end

        if self.pax_properties then
            player:set_properties({mesh = self.pax_properties.mesh})
            self.pax_properties = nil
        end
    end
    --player:set_properties({visual_size = {x=1, y=1}})
    if self.pax_mesh then
        self.pax_mesh:set_properties({is_visible=false})
        self.pax_mesh:remove()
    end
end


