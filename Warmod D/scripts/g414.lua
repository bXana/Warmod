--require("warmod/configs/warmodcfg");
--if RequiredScript == "lib/managers/hudmanager" then
--	if WarmodCFG.EnableUniqueSpawn then
		function HUDManager:GetMugshots()
			return self._hud.mugshots;		
		end
		
		function HUDManager:GetObject()
			return self
		end
--	end
--end