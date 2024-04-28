--require("warmod/configs/warmodcfg");
--require("warmod/scripts/functions");

--if RequiredScript == "lib/managers/group_ai_states/groupaistatestreet" then

--	if WarmodCFG.EnableUniqueSpawn then
		function GroupAIStateStreet:AddForceOffset( offset )
			self._police_force_max = self._police_force_max + offset;
		end
--	end

	local OriginalGAISSInitMiscData = GroupAIStateStreet._init_misc_data;
	local OriginalGAISSOSS			= GroupAIStateStreet.on_simulation_started;
	local MinPoliceLim	= WarmodPoliceMinLim();
	local MaxPoliceLim	= WarmodPoliceMaxLim();
--	local PoliceEscLim	= WarmodEscapeOffset();
	
	function GroupAIStateStreet:_init_misc_data()
		OriginalGAISSInitMiscData( self );
		if managers.navigation:is_data_ready() then
			self._police_force_max = CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 );
		end	
	end
	
	function GroupAIStateStreet:on_simulation_started()
		OriginalGAISSOSS( self );
		if managers.navigation:is_data_ready() then
			self._police_force_max = CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 );
		end
	end
	
	-- Эта ***ня только нагружает систему. Ап дерьмо, боты тупые. 
--	if WarmodCFG.EnableUniqueCopLogic then
--		function GroupAIStateStreet:_queue_police_upd_task()
--			self._police_upd_task_queued = true
--			local delay = 0.1;			
--			managers.enemy:queue_task("GroupAIStateStreet._upd_police_activity", GroupAIStateStreet._upd_police_activity, self, self._t + delay )
--		end
--	end
--end