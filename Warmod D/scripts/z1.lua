--if RequiredScript == "lib/units/enemies/tank/logics/tankcoplogicattack" then
if WarmodCFG.EnableUniqueCopLogic then
	local TCLA__chk_request_action_walk_to_chase_pos = TankCopLogicAttack._chk_request_action_walk_to_chase_pos
	function TankCopLogicAttack._chk_request_action_walk_to_chase_pos(data, my_data, speed, end_rot)
		TCLA__chk_request_action_walk_to_chase_pos( data, my_data, "run", end_rot);
	end
	
	function TankCopLogicAttack.queue_update(data, my_data)
		my_data.update_queued = true
		local delay = 0.5;
		CopLogicBase.queue_task(my_data, my_data.update_queue_id, TankCopLogicAttack.queued_update, data, data.t + delay );
	end
end	
	
--end