		require("Config/RXKConfig");

if Base.DisableEscapeTimer then		
	if RequiredScript == "lib/managers/mission/elementpointofnoreturn" then
		function ElementPointOfNoReturn:on_executed(instigator)
			return;
		end
	end
end

if Base.TurnOffDrillJaming then
	if RequiredScript == "lib/units/props/timergui" then
		function TimerGui:_set_jamming_values() 
			return;
		end
	end
end