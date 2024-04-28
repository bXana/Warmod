-- MissionScriptController module
-- Version 1.1
-- Author : AnXZ
-- Rus Description:
-- Позволяет контролировать триггеры

core:module("CoreMissionScriptElement")

if not Host() then
	return;
end

local OriginalMS = MissionScriptElement.init;

function MissionScriptElement:init(mission_script, data)
	OriginalMS( self, mission_script, data );
	self.PreFunction = { nil };
	local Lvl 	  = Global.level_data.level_id
	
	if WarmodSpecialTriggers[Lvl][ self._editor_name ] then
		if WarmodSpecialTriggers[Lvl][ self._editor_name ][1] then
			self = WarmodSpecialTriggers[Lvl][ self._editor_name ][2]( self );
		end
	end	
end
