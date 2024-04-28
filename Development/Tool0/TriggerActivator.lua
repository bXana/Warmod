if InGame() and IsPlaying() and Host() then
	local ZZZX =
    {
	
	};	
	for _, script in pairs(managers.mission:scripts()) do
		for id, element in pairs(script:elements()) do
			for _, trigger in pairs(element:values().trigger_list or {}) do

				
					--if ZZZX[trigger.notify_unit_sequence] then
					if trigger.notify_unit_sequence == "drop" then
						element:on_executed()
					end
			end
		end
	end
end

