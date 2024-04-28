if RequiredScript == "lib/managers/mission/elementspawnenemydummy" then
local InvEnemyStruct = 
{
	[Idstring("units/characters/enemies/security/security_guard_01"):key()] = "WSec1",
	[Idstring("units/characters/enemies/security/security_guard_02"):key()] = "WSec2",
	[Idstring("units/characters/enemies/security/patrol_guard"):key()]		= "RSec",
	
	[Idstring("units/characters/enemies/gangster1/gangster1"):key()] = "Gang1",
	[Idstring("units/characters/enemies/gangster2/gangster2"):key()] = "Gang2",
	[Idstring("units/characters/enemies/gangster3/gangster3"):key()] = "Gang3",
	[Idstring("units/characters/enemies/gangster4/gangster4"):key()] = "Gang4",
	[Idstring("units/characters/enemies/gangster5/gangster5"):key()] = "Gang5",
	[Idstring("units/characters/enemies/gangster6/gangster6"):key()] = "Gang6",
	[Idstring("units/characters/enemies/dealer/dealer"):key()] 		 = "Dealer",
	
	[Idstring("units/characters/enemies/murky_water1/murky_water1"):key()] = "Murky1",
	[Idstring("units/characters/enemies/murky_water2/murky_water2"):key()] = "Murky2",
	
	[Idstring("units/characters/enemies/cop/cop"):key()]   = "Cop1",
	[Idstring("units/characters/enemies/cop2/cop2"):key()] = "Cop2",
	[Idstring("units/characters/enemies/cop3/cop3"):key()] = "Cop3",
	[Idstring("units/characters/enemies/fbi1/fbi1"):key()] = "Fbi1",
	[Idstring("units/characters/enemies/fbi2/fbi2"):key()] = "Fbi2",
	[Idstring("units/characters/enemies/fbi3/fbi3"):key()] = "Fbi3",
	[Idstring("units/characters/enemies/swat/swat"):key()] = "Swat1",
	[Idstring("units/characters/enemies/swat2/swat2"):key()] = "Swat2",
	[Idstring("units/characters/enemies/swat3/swat3"):key()] = "Swat3",
	[Idstring("units/characters/enemies/swat_kevlar1/swat_kevlar1"):key()] = "BSwat1",
	[Idstring("units/characters/enemies/swat_kevlar2/swat_kevlar2"):key()] = "BSwat2",
	[Idstring("units/characters/enemies/spooc/spooc"):key()] = "Cloaker",
	[Idstring("units/characters/enemies/taser/taser"):key()] = "Taser",
	[Idstring("units/characters/enemies/shield/shield"):key()] = "Shield",
	[Idstring("units/characters/enemies/tank/tank"):key()] = "BDozer",
	[Idstring("units/characters/enemies/sniper/sniper"):key()] = "Sniper"

};


	--local _MutatorTable = XSpawnCFG.MutatorTable;
	--local _SpawnTable, _SpawnUnitAmount	= CreateSpawnMap();
RXKCOORDS = {};

	function ElementSpawnEnemyDummy:produce(params)
	local units_spawned = {}

		local Locked = true;
		
		local Action = self._values.spawn_action;
		local File = nil;
		local BFile = nil;
		
		
		if #RXKCOORDS == 0 then
			table.insert( RXKCOORDS, { self._values.position, self._values.rotation,  self._values.spawn_action } );

		else
			for k, v in ipairs( RXKCOORDS ) do
				if self._values.position.x == v[1].x and
				   self._values.position.y == v[1].y and
				   self._values.position.z == v[1].z then
				   Locked = false;
				   break;
				end
			end
			
			if Locked then
				table.insert( RXKCOORDS, { self._values.position, self._values.rotation,  self._values.spawn_action } );
			end
		end		
	
	if params then
		for _, data in pairs(params) do
			local unit = safe_spawn_unit(data.name, self._values.position, self._values.rotation)
			unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
			managers.groupai:state():assign_enemy_to_group_ai(unit)
			unit:unit_data().mission_element = self
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
		local unit = safe_spawn_unit(self._enemy_name, self._values.position, self._values.rotation)
		unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
		unit:unit_data().mission_element = self
		local objective
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

	return units_spawned
end

end