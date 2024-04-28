-- VarBase module
-- Version 1.0
-- Author : AnXZ
-- Rus Description:
-- Контейнер с переменными

-- Сделано специально для Триггер.скриптов ( triggerlist.lua )

VarBase = VarBase or class()

function VarBase:init()
	self.Buffer = {};
end

function VarBase:Get( VarName )
	local Ret = self.Buffer[ VarName ];
	return Ret;
end

function VarBase:Set( VarName, X )
	self.Buffer[ VarName ] = X;
end

function VarBase:Inc( VarName )
	self.Buffer[ VarName ] = self.Buffer[ VarName ] + 1;
end

function VarBase:Dec( VarName )
	self.Buffer[ VarName ] = self.Buffer[ VarName ] - 1;
end

function VarBase:Add( VarName, X )
	self.Buffer[ VarName ] = self.Buffer[ VarName ] + X;
end

function VarBase:Div( VarName, X )
	self.Buffer[ VarName ] = self.Buffer[ VarName ] - X;
end

