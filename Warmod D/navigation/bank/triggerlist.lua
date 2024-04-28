-- взрываем стёкла, открываем крышки и лифты
function WarmodBankDamage()
		for Obj, script in pairs(managers.mission:scripts()) do
			if Obj ~= "event_cafeteria_window" and
			   Obj ~= "event_globe_window" then
				for id, element in pairs(script:elements()) do
					for X, trigger in pairs(element:values().trigger_list or {}) do
						if trigger.notify_unit_sequence == "make_dynamic" or 
						   trigger.notify_unit_sequence:lower():find("dest") or 
						   trigger.notify_unit_sequence == "open" then 
							element:on_executed();
							element._values.enabled = false;
						end
					end
				end
			end
		end
	-- boss spawn	
	managers.mission:scripts()["default"]:elements()[102919]:on_executed();
	managers.mission:scripts()["default"]:elements()[103378]:on_executed();

	-- O fuck. Yellow smoke
	managers.mission:scripts()["baldwin"]:elements()[104311]:on_executed();
	managers.mission:scripts()["baldwin"]:elements()[104311]._values.enabled = false;
	return true;
end

-- Удаляем двери лифта, и пару крышек от шахт
function WarmodBankFix(  )
	for _,unit in pairs(World:find_units_quick('all', 1)) do
		if unit:name():key() == "582675668c088fec" or 
		   unit:name():key() == "746c70dfa6cda25a" then
			if CheckVector( unit:position(), Vector3(292.99899291992, 2132.169921875, 475.01901245117 ) ) or
			   CheckVector( unit:position(), Vector3( 4641, -1097, -433.70001220703 ) ) or
			   CheckVector( unit:position(), Vector3( 3880, -1149, -434.41799926758 ) ) then
				World:delete_unit( unit );
			end
		end
	end
	
	-- -- Overdrill visual 
	-- local ElementsZ = managers.mission:scripts()["baldwin"]:elements();
	-- ElementsZ[104180]._values.enabled = false;
	-- ElementsZ[104339]._values.enabled = false;
	
	-- ElementsZ[104323]:on_executed();
	
	-- ElementsZ[104339]._values.enabled = true;
	-- ElementsZ[104180]._values.enabled = true;
	-- --
	
	-- -- DEBUG
		-- local Elements = managers.mission:scripts()["default"]:elements();
		-- Elements[101432]:on_executed(); -- open door
		-- Elements[101432]:on_executed();
		-- Elements[101432]:on_executed();
		
		-- Elements[101341]:on_executed(); -- thermite end
		-- Elements[101657]:on_executed(); -- open door
	-- --
	
	return true;
end

-- вызываем всех оставшихся охранников
function WarmodBankUGOE(  )
	local Elements = managers.mission:scripts()["default"]:elements();
	Elements[102130]:on_executed();
	Elements[102130]._values.enabled = false;
	
	Elements[104070]:on_executed();
	Elements[104069]:on_executed();
	Elements[104071]:on_executed();
	Elements[104070]._values.enabled = false;
	Elements[104069]._values.enabled = false;
	Elements[104071]._values.enabled = false;
	
	return true;
end

-- Снайперов на дрель
function WarmodBankSniperFlank(  )
	local Elements = managers.mission:scripts()["event_drill_roof_snipers"]:elements();
	Elements[101611]:on_executed();
	
	return true;
end

-- Засада спецназа
function WarmodBankAmbush(  )
	managers.mission:scripts()["default"]:elements()[101343]:on_executed();
	managers.mission:scripts()["default"]:elements()[101343]._values.enabled = false;
	managers.mission:scripts()["default"]:elements()[102422]:on_executed();
	managers.mission:scripts()["default"]:elements()[102422]._values.enabled = false;
	
	return true;
end

-- Fucking bank guards
function WarmodBankGuardsInHallV(  )
	managers.mission:scripts()["default"]:elements()[103675]:on_executed();
	return false;
end

function WarmodBankBDZWarn(  )
	chat_message("LOBBY", "Warning! Bulldozers in the vault. Be careful.");
	return true;
end
		