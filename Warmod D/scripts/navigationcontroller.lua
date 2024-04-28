-- NavigationController module
-- Version 1.2
-- Author : AnXZ
-- Rus Description:
-- Основной модуль умного спавна. 
-- Именно в нём все спавны объединены в группы, а эти группы соединены с навигационными сегментами.
--


math.randomseed( os.time() );

NavigationController = NavigationController or class()

NavigationController.SpawnPointSet = {
	["bank"] 			= WarmodBankVector,
	["heat_street"]	    = WarmodHeatStreetVector,
	["diamond_heist"] 	= WarmodDiamondHeistVector,
	["bridge"]			= WarmodGreenBridgeVector,
	["apartment"] 		= WarmodPanicRoomVector,
	["slaughter_house"] = WarmodSlaughterHouseVector,
	["suburbia"] 		= WarmodCounterfeitVector,
	["secret_stash"]	= WarmodUndercoverVector,
	["hospital"]		= WarmodNoMercyVector	
};

NavigationController.SpawnActionBlackListX = {
	["bank"] 			= { ["plant_on_window"] = true },
	["heat_street"]   	= {},
	["diamond_heist"] 	= { ["move_ladder_climbover_std"] = true },
	["bridge"]			= {},
	["apartment"] 		= {},
	["slaughter_house"] = {}, 
	["suburbia"] 		= {},
	["secret_stash"]	= {},
	["hospital"]		= {} 	
}

NavigationController.SpawnPointBlackListX = {
	["bank"] 			= WarmodBankVectorBlack,
	["heat_street"] 	= WarmodHeatStreetVectorBlack,
	["diamond_heist"] 	= WarmodDiamondHeistVectorBlack,
	["bridge"]			= WarmodGreenBridgeVectorBlack,
	["apartment"] 		= WarmodPanicRoomVectorBlack,
	["slaughter_house"] = WarmodSlaughterHouseVectorBlack,
	["suburbia"] 		= WarmodCounterfeitVectorBlack,
	["secret_stash"]	= WarmodUndercoverVectorBlack,
	["hospital"]		= WarmodNoMercyVectorBlack
};

NavigationController.SpawnNavigationList = {
	["bank"] 			= WarmodBankNavigation,
	["heat_street"] 	= WarmodHeatStreetNavigation,
	["diamond_heist"] 	= WarmodDiamondHeistNavigation,
	["bridge"]			= WarmodGreenBridgeNavigation,
	["apartment"] 		= WarmodPanicRoomNavigation,
	["slaughter_house"] = WarmodSlaughterHouseNavigation,
	["suburbia"] 		= WarmodCounterfeitNavigation,
	["secret_stash"]	= WarmodUndercoverNavigation,
	["hospital"]		= WarmodNoMercyNavigation	
};

function NavigationController:init()
	self.CurrentNavSeg = {};
	self.CurrentNavSegAmount = {};
	self.SpawnPoints = {};
	self.SpawnPointsAmount = {};
	self.SpawnPointBlackList = {};
	self.SpawnActionBlackList = {};
	
	self:CreateNavigationMap();
end

if WarmodCFG.EnableUniqueSpawn then
	function NavigationController:GetSpawnPoint( Position, EnHash, Action, ImportantUnit )
		if self.SpawnPointBlackList[tostring(Position)] or
		   EnHash == "2e46807f6e933907" or
		   ImportantUnit or		   
		   self.SpawnActionBlackList[ Action ] then
			return nil, nil, nil;
		end
		
		local Location = managers.dlc:GetWarmodNavigation():GetNavigation();
		if not Location then
			return nil, nil, nil;
		end
		
		local EscapeMode = managers.dlc:GetEscapeMode( );
		local ABS = self.CurrentNavSegAmount[EscapeMode][Location];
		if not ABS then
			return nil, nil, nil;
		end
		
		local SpawnPoint = self.CurrentNavSeg[EscapeMode][Location][ math.random(1, ABS ) ];
		local TargetStruct = self.SpawnPoints[SpawnPoint][math.random(1, self.SpawnPointsAmount[SpawnPoint] ) ];
		
		return TargetStruct[1], TargetStruct[2], TargetStruct[3];
	end
else
	function NavigationController:GetSpawnPoint( Position, EnHash, Action, ImportantUnit )
		return nil, nil, nil;
	end
end


function NavigationController:CreateNavigationMap()
	local Map = Global.level_data.level_id;
	for EscapeMode, _ in pairs( NavigationController.SpawnNavigationList[Map] ) do
		self.CurrentNavSeg[EscapeMode] = {};
		self.CurrentNavSegAmount[EscapeMode] = {};
		for NavSeg, SpawnPoints in pairs( NavigationController.SpawnNavigationList[Map][EscapeMode]) do
			self.CurrentNavSeg[EscapeMode][NavSeg] = {};
			self.CurrentNavSegAmount[EscapeMode][NavSeg] = 0;			
			self.CurrentNavSeg[EscapeMode][NavSeg] = NavigationController.SpawnNavigationList[Map][EscapeMode][NavSeg];
			self.CurrentNavSegAmount[EscapeMode][NavSeg] = #NavigationController.SpawnNavigationList[Map][EscapeMode][NavSeg];
		end
	end
	
	
	for SpawnPointGroup, Vector in pairs( NavigationController.SpawnPointSet[Map] ) do
		self.SpawnPoints[SpawnPointGroup] = NavigationController.SpawnPointSet[Map][SpawnPointGroup];
		self.SpawnPointsAmount[SpawnPointGroup] = #NavigationController.SpawnPointSet[Map][SpawnPointGroup];
	end
	
	self.SpawnPointBlackList  = GetAccess( { NavigationController.SpawnPointBlackListX[Map] } );
	self.SpawnActionBlackList = GetAccess( { NavigationController.SpawnActionBlackListX[Map] } ); 
	
end