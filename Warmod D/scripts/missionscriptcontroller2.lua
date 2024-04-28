-- MissionScriptController module
-- Version 1.1
-- Author : AnXZ
-- Rus Description:
-- Позволяет контролировать триггеры

if not Host() then
	return;
end

function MissionScriptElement:on_executed(...)
	if Network:is_client() then
		return
	end
	
	-- Задумка простая: перед вызовом триггеров ( MissionScript объекты ), вызывается функция,
	-- через которую вводятся изменения, тем самым можно создавать свои личные ветки событий.
	-- 
	
	if self.PreFunction[1] then
		local Ret = self.PreFunction[1]( );
		if not Ret then
			return;
		end
	end

	MissionScriptElement.super.on_executed(self, ...)
end