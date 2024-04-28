--require("warmod/configs/warmodcfg");

--if RequiredScript == "lib/managers/mission/elementspecialobjective" then
--	if WarmodCFG.UpSpawnSpeed then
		function ElementSpecialObjective:nav_link_delay()
			return 1;
		end
--	end
--end