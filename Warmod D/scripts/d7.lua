--require("warmod/scripts/navigationcontroller");
--require("warmod/scripts/spawncontroller");
--require("warmod/scripts/functions");

--if RequiredScript == "lib/managers/mission/elementspawnenemydummy" then

	if not Host() then
		return;
	end
	
	-- local ESED_INIT = ElementSpawnEnemyDummy.init;
	-- function ElementSpawnEnemyDummy:init( ... )
		-- ESED_INIT( self, ... );
		-- self._values.ImportantUnit = false;
	-- end

	RxkWarmodSpawnModule  = SpawnController:new()
	RxkWarmodNaviModule   = NavigationController:new()
	function ElementSpawnEnemyDummy:produce(params)
		local units_spawned = {}
		local Unit = nil;
		local Pos, Rot, Act = nil,nil,nil;
		local FactEnemyHash = nil;
		if params then
			for _, data in ipairs( params ) do
				FactEnemyHash = data.name:key();
				Unit = RxkWarmodSpawnModule:GetSpawnUnit( FactEnemyHash );
				Pos, Rot, Act = RxkWarmodNaviModule:GetSpawnPoint( self._values.position, FactEnemyHash, self._values.spawn_action, self._values.ImportantUnit );
				local unit = safe_spawn_unit( Unit, Pos or self._values.position, Rot or self._values.rotation);
				unit:brain():SetUnitData( FactEnemyHash, self._values.ImportantUnit );
				unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
				managers.groupai:state():assign_enemy_to_group_ai(unit)
				unit:unit_data().mission_element = self
				self._values.spawn_action = Act or self._values.spawn_action;
				local spawn_ai = self:_create_spawn_AI_parametric(data.stance, data.objective, self._values)
				unit:brain():set_spawn_ai(spawn_ai)
				table.insert(self._units, unit)
				table.insert(units_spawned, unit)
				self:event("spawn", unit)
				if self._values.force_pickup and self._values.force_pickup ~= "none" then
					unit:character_damage():set_pickup(self._values.force_pickup)
				end			
			end
		else
			FactEnemyHash = self._enemy_name:key()
			Unit = RxkWarmodSpawnModule:GetSpawnUnit( FactEnemyHash );
			Pos, Rot, Act = RxkWarmodNaviModule:GetSpawnPoint( self._values.position, FactEnemyHash, self._values.spawn_action, self._values.ImportantUnit );			
			local unit = safe_spawn_unit(Unit, Pos or self._values.position, Rot or self._values.rotation);
			unit:brain():SetUnitData( FactEnemyHash, self._values.ImportantUnit );
			unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
			unit:unit_data().mission_element = self
			local objective
			self._values.spawn_action = Act or self._values.spawn_action;			
			local action = self:_create_action_data(self._values)
			if action.type == "act" then
				objective = {
					type = "act",
					action = action,
					stance = "cbt"
				}
			end
			local spawn_ai = {init_state = "idle", objective = objective}
			unit:brain():set_spawn_ai(spawn_ai)
			if self._values.participate_to_group_ai ~= false then
				managers.groupai:state():assign_enemy_to_group_ai(unit)
			end
			table.insert(self._units, unit)
			table.insert(units_spawned, unit)
			self:event("spawn", unit)
			if self._values.force_pickup and self._values.force_pickup ~= "none" then
				unit:character_damage():set_pickup(self._values.force_pickup)
			end
		end
		return units_spawned;
	end
--end