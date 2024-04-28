--require("warmod/configs/warmodcfg");
--require("warmod/scripts/functions");

--if RequiredScript == "lib/managers/group_ai_states/groupaistatebesiege" then
	
--	if WarmodCFG.EnableUniqueSpawn then
		function GroupAIStateBesiege:AddForceOffset( offset )
			self._police_force_max = self._police_force_max + offset;
		end
--	end

	local OriginalGAISSInitMiscData = GroupAIStateBesiege._init_misc_data;
	local OriginalGAISSOSS			= GroupAIStateBesiege.on_simulation_started;
	local MinPoliceLim	= WarmodPoliceMinLim();
	local MaxPoliceLim	= WarmodPoliceMaxLim();
--	local PoliceEscLim	= WarmodEscapeOffset();	

	function GroupAIStateBesiege:_init_misc_data()
		OriginalGAISSInitMiscData( self );
		if managers.navigation:is_data_ready() then
			self._police_force_max = CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 );
		end	
	end
	
	function GroupAIStateBesiege:on_simulation_started()
		OriginalGAISSOSS( self );
		if managers.navigation:is_data_ready() then
			self._police_force_max = CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 );
		end
	end
	
	-- Эта ***ня только нагружает систему. Ап дерьмо, боты тупые. 
--	if WarmodCFG.EnableUniqueCopLogic then
--		function GroupAIStateBesiege:_queue_police_upd_task()
--			self._police_upd_task_queued = true
--			local delay = 0.1;
--			managers.enemy:queue_task("GroupAIStateBesiege._upd_police_activity", GroupAIStateBesiege._upd_police_activity, self, self._t + delay )
--		end
--	end
--end