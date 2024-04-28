--require("warmod/configs/warmodcfg");

--if RequiredScript == "lib/units/enemies/cop/logics/coplogictravel" then
	if WarmodCFG.EnableUniqueCopLogic then
		local CLT_UPD = CopLogicTravel.queued_update;
		
		function CopLogicTravel.queued_update(data)
			if data.unit:brain():CheckUnit() then
				data.objective.nav_seg = data.unit:brain():GetNavigation() or data.objective.nav_seg;
			end			
			CLT_UPD( data );
		end

		function CopLogicTravel.queue_update(data, my_data)
			local delay = 0.1;
			CopLogicBase.queue_task(my_data, my_data.upd_task_key, CopLogicTravel.queued_update, data, data.t + delay, true)
		end
	end		
--end