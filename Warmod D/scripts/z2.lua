if WarmodCFG.EnableUniqueCopLogic then
	function ShieldLogicAttack.queue_update(data, my_data)
		local delay = 0.5;
		CopLogicBase.queue_task(my_data, my_data.update_queue_id, ShieldLogicAttack.queued_update, data, data.t + delay, true );
	end	
end