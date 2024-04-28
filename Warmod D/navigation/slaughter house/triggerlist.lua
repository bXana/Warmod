function SlaughterHouseTrigger()
	for _, script in pairs(managers.mission:scripts()) do
		for id, element in pairs(script:elements()) do
			for _, trigger in pairs(element:values().trigger_list or {}) do
				if trigger.notify_unit_sequence == "open" then
					element:on_executed()
				end
			end
		end
	end
end

function SlaughterHouseSubTrigger()

end