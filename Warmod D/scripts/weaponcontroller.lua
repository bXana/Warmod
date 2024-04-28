-- WeaponChanger module
-- Version 3.0
-- Author : AnXZ
-- Rus Description:
-- Изменяет оружие на оружие из таблицы конфига

--require("warmod/scripts/functions");
--require("warmod/configs/warmodcfg");
--require("warmod/configs/weaponlist");

WeaponController = WeaponController or class()
math.randomseed( os.time() );

WeaponController.WeaponHash = {
	[ "Shield" ]  = "1c69a7dee40ab2d6",
	[ "M4Laser" ]  = "34b46fd9429a6f6a",
	[ "Reinbeck" ]  = "583219d538ea8762",
	[ "Brenner" ]  = "98cd236033a327bb",
	[ "Ak47" ]  = "9dd226252ba79968",
	[ "M308" ]  = "329be59c01c04370",
	[ "C45" ]  = "4f186776009aaa34",
	[ "Locomotive" ]  = "48cca7565bc63906",
	[ "Mac11" ]  = "ecd66407098bc930",
	[ "M4" ]  = "8f5f750e7646df05",
	[ "Beretta92" ]  = "9b77bb590aab5b41",
	[ "Mp5" ]  = "b5dcce7aa1338df6",
	[ "Bronco" ]  = "6dca65b81945acaf"
};

WeaponController.WeaponList = {
	Beretta92 	  = Idstring("units/weapons/beretta92_npc/beretta92_npc"),
	C45 	  	  = Idstring("units/weapons/c45_npc/c45_npc"),
	Bronco	  	  = Idstring("units/weapons/raging_bull_npc/raging_bull_npc"),	
	Mp5 	  	  = Idstring("units/weapons/mp5_npc/mp5_npc"),
	Mac11 	  	  = Idstring("units/weapons/mac11_npc/mac11_npc"),
	Brenner   	  = Idstring("units/weapons/hk21_npc/hk21_npc"),
	M4 		  	  = Idstring("units/weapons/m4_rifle_npc/m4_rifle_npc"),	
	Ak47	 	  = Idstring("units/weapons/ak47_npc/ak47_npc"),
	M308	  	  = Idstring("units/weapons/m14_npc/m14_npc"),
	Locomotive	  = Idstring("units/weapons/mossberg_npc/mossberg_npc"),	
	Reinbeck 	  = Idstring("units/weapons/r870_shotgun_npc/r870_shotgun_npc"),
	M4Laser	  	  = Idstring("units/weapons/sniper_rifle_npc/sniper_rifle_npc"),
	Shield	  	  = Idstring("units/weapons/shield_pistol_npc/shield_pistol_npc")
};

WeaponController.DefaultWeapons =
{
	["WSec1"]	= WeaponController.WeaponList.C45,
	["WSec2"]	= WeaponController.WeaponList.C45,
	["RSec"]	= WeaponController.WeaponList.Mp5,
	
	["Gang1"]	= WeaponController.WeaponList.Mac11,
	["Gang2"]	= WeaponController.WeaponList.Mac11,
	["Gang3"]	= WeaponController.WeaponList.Mac11,
	["Gang4"]	= WeaponController.WeaponList.Mac11,
	["Gang5"]	= WeaponController.WeaponList.Mac11,
	["Gang6"]	= WeaponController.WeaponList.Mac11,
	["Dealer"]	= WeaponController.WeaponList.Mac11,
	
	["Murky1"]	= WeaponController.WeaponList.M4,
	["Murky2"]	= WeaponController.WeaponList.M4,
	
	["Cop1"]	= WeaponController.WeaponList.C45,
	["Cop2"]	= WeaponController.WeaponList.C45,
	["Cop3"]	= WeaponController.WeaponList.Reinbeck,
	["Fbi1"]	= WeaponController.WeaponList.C45,
	["Fbi2"]	= WeaponController.WeaponList.Beretta92,
	["Fbi3"]	= WeaponController.WeaponList.C45,
	["Swat1"]	= WeaponController.WeaponList.Mp5,
	["Swat2"]	= WeaponController.WeaponList.M4,
	["Swat3"]	= WeaponController.WeaponList.Reinbeck,	
	["BSwat1"]	= WeaponController.WeaponList.Reinbeck,
	["BSwat2"]	= WeaponController.WeaponList.M4,
	["Cloaker"]	= WeaponController.WeaponList.Mp5,
	["Taser"]	= WeaponController.WeaponList.M4,
	["Shield"]	= WeaponController.WeaponList.Shield,
	["BDozer"]	= WeaponController.WeaponList.Reinbeck,
	["Sniper"]	= WeaponController.WeaponList.M4Laser
};

WeaponController.EnemySmallAccess =
{
	Beretta92 	  = true,
	C45 	  	  = true,
	Bronco	  	  = true,	
	Mp5 	  	  = true,
	Mac11 	  	  = true,
	Brenner   	  = true,
	M4 		  	  = true, 
	Ak47	 	  = true, 
	M308	  	  = true, 
	Locomotive	  = true, 
	Reinbeck 	  = true, 
	M4Laser	  	  = true 
};

WeaponController.EnemyCoolAccess =
{	
	Mp5 	  	  = true,
	Mac11 	  	  = true,
	Brenner   	  = true,
	M4 		  	  = true, 
	Ak47	 	  = true, 
	M308	  	  = true, 
	Locomotive	  = true, 
	Reinbeck 	  = true, 
	M4Laser	  	  = true 
};

WeaponController.EnemyGoodAccess =
{
	Mac11 	  	  = true,
	M4 		  	  = true, 
	Ak47	 	  = true, 
	M308	  	  = true, 
	Locomotive	  = true, 
	Reinbeck 	  = true, 
	M4Laser	  	  = true 
};

WeaponController.EnemyTAccess =
{
	M4 	 	= true,
	Ak47 	= true,
	M308 	= true,
	M4Laser = true 
};

WeaponController.EnemySAccess =
{
	M4Laser = true,
	M308	= true
};

WeaponController.EnemySHAccess =
{
	Shield = true
};

WeaponController.EnemyOnlyShotguns =
{
	Reinbeck 	= true,
	Locomotive  = true 
};

WeaponController.WeaponUnitAccess = {
	["WSec1"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["WSec2"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["RSec"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	
	["Gang1"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Gang2"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Gang3"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Gang4"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Gang5"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Gang6"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Dealer"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	
	["Murky1"]	= GetAccess( { WeaponController.EnemySmallAccess  }),
	["Murky2"]	= GetAccess( { WeaponController.EnemySmallAccess  }),
	
	["Cop1"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Cop2"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Cop3"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Fbi1"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Fbi2"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Fbi3"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Swat1"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Swat2"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Swat3"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["BSwat1"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["BSwat2"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Cloaker"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Taser"]	= GetAccess( { WeaponController.EnemyTAccess }),
	["Shield"]	= GetAccess( { WeaponController.EnemySmallAccess, WeaponController.EnemySHAccess }),
	["BDozer"]	= GetAccess( { WeaponController.EnemySmallAccess }),
	["Sniper"]	= GetAccess( { WeaponController.EnemyTAccess })
};

WeaponController.WEnemyHashList = {
	[ "Murky1" ]  = "613adf308b80ca15",
	[ "RSec" ]  = "1f29f3bc3fe6334c",
	[ "Shield" ]  = "0e797bd1e644d628",
	[ "Swat2" ]  = "1ecc769580f1c536",
	[ "Sniper" ]  = "2e46807f6e933907",
	[ "Cop1" ]  = "1c26f0eb97521d88",
	[ "BDozer" ]  = "3bdf4b192980a559",
	[ "Murky2" ]  = "567687f78dd4238e",
	[ "Taser" ]  = "b629e65ac5d203d7",
	[ "WSec1" ]  = "7544d17ae88d9c45",
	[ "Cop3" ]  = "704e4704ee42bcbc",
	[ "BSwat1" ]  = "355742a822b815dd",
	[ "Gang6" ]  = "c0edb839a1d50812",
	[ "WSec2" ]  = "6eae0b0599f34acf",
	[ "Swat1" ]  = "6a1ac63b209e379a",
	[ "Cloaker" ]  = "1d8086e65dbae309",
	[ "BSwat2" ]  = "56db607d8f091ddf",
	[ "Swat3" ]  = "0d23b52b17dea1f9",
	[ "Cop2" ]  = "1c7af86c8c573ef9",
	[ "Fbi3" ]  = "61f5c9b1868f6304",
	[ "Fbi2" ]  = "b1038f8e54f92560",
	[ "Fbi1" ]  = "3757b5460c844a85",
	[ "Gang1" ]  = "673b940e892f4f53",
	[ "Gang2" ]  = "de4b80f4158841a7",
	[ "Dealer" ]  = "95a2b5a2a9152b06",
	[ "Gang5" ]  = "9404449892861a3e",
	[ "Gang3" ]  = "ca3ad64366e52654",
	[ "Gang4" ]  = "8c7419fe2460decb"
};

function WeaponController:init()
	self.WeaponList = {};
	self.WeaponListAmount = {};
	
	self:CreateSpawnWeaponMap();
end

function WeaponController:GetWeapon()
	local Hash = managers.dlc:GetEnemyHash();
--	if Hash then
--		managers.dlc:SetEnemyHash(nil);
		return self.WeaponList[Hash][math.random(1, self.WeaponListAmount[Hash])];
--	end
	
--	return WeaponController.UniqueWeapons[ math.random( 1, 4 ) ];
end

function WeaponController:CreateSpawnWeaponMap()
	local EnemyHash = nil;
	local CurrentEnemies = managers.dlc:GetCurrentEnemiesBlock();
	if WarmodCFG.EnableWeaponChanger then
		for UnitKey, UnitAccess in pairs( CurrentEnemies ) do
			EnemyHash = WeaponController.WEnemyHashList[UnitKey];
			self.WeaponList[ EnemyHash ] = {};
			self.WeaponListAmount[ EnemyHash ] = 0;
			if WeaponList[UnitKey] then
				for WeaponKey, WeaponValue in pairs( WeaponList[UnitKey] ) do
					if WeaponValue and WeaponController.WeaponUnitAccess[ UnitKey ][WeaponKey] then
						table.insert( self.WeaponList[ EnemyHash ], WeaponController.WeaponList[WeaponKey] );
						self.WeaponListAmount[EnemyHash] = self.WeaponListAmount[EnemyHash] + 1;
					end
				end			
			end
			
			if self.WeaponListAmount[EnemyHash] <= 0 then
				table.insert( self.WeaponList[ EnemyHash ], WeaponController.DefaultWeapons[UnitKey] );
				self.WeaponListAmount[EnemyHash] = self.WeaponListAmount[EnemyHash] + 1;			
			end
		end
	else
		for UnitKey, UnitAccess in pairs( CurrentEnemies ) do
			EnemyHash = WeaponController.WEnemyHashList[UnitKey];
			self.WeaponList[ EnemyHash ] = {};
			self.WeaponListAmount[ EnemyHash ] = 0;
			table.insert( self.WeaponList[EnemyHash], WeaponController.DefaultWeapons[UnitKey] );
			self.WeaponListAmount[EnemyHash] = self.WeaponListAmount[EnemyHash] + 1;
		end
	end
end