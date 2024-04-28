if InGame() and IsPlaying() and Host() then
	--if not IO then
		MidText("Start Dump", "Event");
		local PathFile = "RXKLog.txt";
		local WriteFile = io.open(PathFile, "wb");
		
		MissionScriptsIterator = 1;
		for _, script in pairs(managers.mission:scripts()) do
				ElementsIterator = 1;
				WriteFile:write("[][ Mission Script Iterator ]( ");
				WriteFile:write(_);
				WriteFile:write(" ) : ");
				WriteFile:write(MissionScriptsIterator);
				WriteFile:write("\n");
				WriteFile:write("\n");
			for id, element in pairs(script:elements()) do
				for f, trigger in pairs(element:values().trigger_list or {}) do
					--if trigger.notify_unit_sequence == "make_dynamic" then
					--	WriteFile:write( id .. " " .. tostring(f) .. " -> " );
						--WriteFile:write( id .. "-> "); 
						WriteFile:write( "[\"" ..trigger.notify_unit_sequence .. "\"] = true,\n");
						--WriteFile:write("\n");
					--end
				end
				ElementsIterator = ElementsIterator + 1;
			end
			MissionScriptsIterator = MissionScriptsIterator + 1;
		end
		--MidText("End Dump", "Event");
		--MidText( _VERSION, "Lua Version");
		WriteFile:close();
		
		
	--	IO = true;
--	end	
end