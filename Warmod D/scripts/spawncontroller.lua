-- SpawnChanger module
-- Version 3.0
-- Author : AnXZ
-- Rus Description:
-- Изменяет юнит на юнит из таблицы конфига  


--require("warmod/scripts/functions");
--require("warmod/configs/warmodcfg");
--require("warmod/configs/spawnlist");
SpawnController = SpawnController or class()
math.randomseed( os.time() );

SpawnController.EnemyHashList = {
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

SpawnController.EnemyList =
{
	["WSec1"]	= Idstring("units/characters/enemies/security/security_guard_01"),
	["WSec2"]	= Idstring("units/characters/enemies/security/security_guard_02"),
	["RSec"]	= Idstring("units/characters/enemies/security/patrol_guard"),
	
	["Gang1"]	= Idstring("units/characters/enemies/gangster1/gangster1"),
	["Gang2"]	= Idstring("units/characters/enemies/gangster2/gangster2"),
	["Gang3"]	= Idstring("units/characters/enemies/gangster3/gangster3"),
	["Gang4"]	= Idstring("units/characters/enemies/gangster4/gangster4"),
	["Gang5"]	= Idstring("units/characters/enemies/gangster5/gangster5"),
	["Gang6"]	= Idstring("units/characters/enemies/gangster6/gangster6"),
	["Dealer"]	= Idstring("units/characters/enemies/dealer/dealer"),
	
	["Murky1"]	= Idstring("units/characters/enemies/murky_water1/murky_water1"),
	["Murky2"]	= Idstring("units/characters/enemies/murky_water2/murky_water2"),
	
	["Cop1"]	= Idstring("units/characters/enemies/cop/cop"),
	["Cop2"]	= Idstring("units/characters/enemies/cop2/cop2"),
	["Cop3"]	= Idstring("units/characters/enemies/cop3/cop3"),
	["Fbi1"]	= Idstring("units/characters/enemies/fbi1/fbi1"),
	["Fbi2"]	= Idstring("units/characters/enemies/fbi2/fbi2"),
	["Fbi3"]	= Idstring("units/characters/enemies/fbi3/fbi3"),
	["Swat1"]	= Idstring("units/characters/enemies/swat/swat"),
	["Swat2"]	= Idstring("units/characters/enemies/swat2/swat2"),
	["Swat3"]	= Idstring("units/characters/enemies/swat3/swat3"),	
	["BSwat1"]	= Idstring("units/characters/enemies/swat_kevlar1/swat_kevlar1"),
	["BSwat2"]	= Idstring("units/characters/enemies/swat_kevlar2/swat_kevlar2"),
	["Cloaker"]	= Idstring("units/characters/enemies/spooc/spooc"),
	["Taser"]	= Idstring("units/characters/enemies/taser/taser"),
	["Shield"]	= Idstring("units/characters/enemies/shield/shield"),
	["BDozer"]	= Idstring("units/characters/enemies/tank/tank"),
	["Sniper"]	= Idstring("units/characters/enemies/sniper/sniper")
	
};

SpawnController.PoliceProtector =
{
	WSec1	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,	

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true	
	},
	WSec2	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,	

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	RSec	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,	

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	
	Gang1	=
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},
	Gang2	= 
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},		
	Gang3	= 
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},
	Gang4	= 
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},
	Gang5	= 
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},
	Gang6	= 
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},
	Dealer	= 
	{
		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true	
	},
	
	Murky1	= 
	{
		WSec1	= true,
		WSec2	= true,
		
		Murky1	= true,
		Murky2	= true,	

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true		
	},
	Murky2	=
	{
		WSec1	= true,
		WSec2	= true,
		
		Murky1	= true,
		Murky2	= true,	

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true	
	},

	Cop1 	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	Cop2	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},		
	Cop3	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	Fbi1	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	Fbi2	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true				
	},
	Fbi3	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true				
	},
	Swat1	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true	
	},
	Swat2	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	Swat3	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	BSwat1	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true				
	},
	BSwat2	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true				
	},
	Cloaker	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true				
	},
	Taser	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	Shield	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	BDozer	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	},
	Sniper	= 
	{
		WSec1	= true,
		WSec2	= true,
		RSec	= true,
		
		Murky1	= true,
		Murky2	= true,

		Gang1	= true,
		Gang2	= true,
		Gang3	= true,
		Gang4	= true,
		Gang5	= true,
		Gang6	= true,
		Dealer	= true,			

		Cop1 	= true,
		Cop2	= true,
		Cop3	= true,
		Fbi1	= true,
		Fbi2	= true,
		Fbi3	= true,
		Swat1	= true,
		Swat2	= true,
		Swat3	= true,
		BSwat1	= true,
		BSwat2	= true,
		Cloaker	= true,
		Taser	= true,
		Shield	= true,
		BDozer	= true,
		Sniper	= true			
	}
};

SpawnController.PoliceAccess =
{
	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

SpawnController.SecurityAccess =
{
	WSec1	= true,
	WSec2	= true
};

SpawnController.SecurityFullAccess =
{
	WSec1	= true,
	WSec2	= true,
	RSec	= true	
};

SpawnController.GangFullAccess =
{
	Gang1	= true,
	Gang2	= true,
	Gang3	= true,
	Gang4	= true,
	Gang5	= true,
	Gang6	= true,
	Dealer	= true
};

SpawnController.GangAccess =
{
	Gang1	= true,
	Gang2	= true
};

SpawnController.MurkyAccess =
{
	Murky1	= true,
	Murky2	= true
};

SpawnController.MapUnitAccess =
{
	["bank"]		=   GetAccess( { SpawnController.SecurityAccess, SpawnController.PoliceAccess } ),
	["heat_street"] = 	GetAccess( { SpawnController.PoliceAccess } ),
	["bridge"]	= 		GetAccess( { SpawnController.PoliceAccess, SpawnController.SecurityAccess } ),
	["apartment"] = 	GetAccess( { SpawnController.PoliceAccess, SpawnController.GangFullAccess } ),
	["slaughter_house"] = GetAccess( { SpawnController.PoliceAccess, SpawnController.MurkyAccess, SpawnController.SecurityAccess } ),
	["diamond_heist"]	= GetAccess( { SpawnController.PoliceAccess, SpawnController.SecurityFullAccess } ),
	["suburbia"]		= GetAccess({SpawnController.PoliceAccess}),
	["secret_stash"]	= GetAccess({SpawnController.PoliceAccess,SpawnController.GangAccess}),
	["hospital"]		= GetAccess({SpawnController.PoliceAccess,SpawnController.SecurityFullAccess})
};

function SpawnController:init()
	self.SpawnList = {};
	self.SpawnListAmount = {};
	
	self:CreateSpawnMap();
	
end

function SpawnController:CreateSpawnMap()
	local Map = Global.level_data.level_id;
	local EnemyHash = nil;
	if WarmodCFG.EnableSpawnChanger then
		for UnitKey, UnitAccess in pairs( SpawnController.MapUnitAccess[ Map ] ) do
			if UnitAccess then
				EnemyHash = SpawnController.EnemyHashList[ UnitKey ];
				managers.dlc:SetNewEnemyBlock( UnitKey );
				self.SpawnList[EnemyHash] = {};
				self.SpawnListAmount[EnemyHash] = 0;
				if SpawnList[ UnitKey ] then
					for SubUnitKey, SubUnitValue in pairs( SpawnList[ UnitKey ] ) do
						if SubUnitValue and SpawnController.MapUnitAccess[Map][SubUnitKey] and SpawnController.PoliceProtector[ UnitKey ][ SubUnitKey ] then
							table.insert( self.SpawnList[EnemyHash], SpawnController.EnemyList[SubUnitKey] );
							self.SpawnListAmount[EnemyHash] = self.SpawnListAmount[EnemyHash] + 1;
						end
					end
				end
				
				if self.SpawnListAmount[EnemyHash] <= 0 then
					table.insert( self.SpawnList[EnemyHash], SpawnController.EnemyList[ UnitKey ] );
					self.SpawnListAmount[EnemyHash] = self.SpawnListAmount[EnemyHash] + 1;
				end
			end
		end
	else
		for UnitKey, UnitAccess in pairs( SpawnController.MapUnitAccess[ Map ] ) do
			if UnitAccess then
				EnemyHash = SpawnController.EnemyHashList[ UnitKey ];
				managers.dlc:SetNewEnemyBlock( UnitKey );				
				self.SpawnList[EnemyHash] = {};
				self.SpawnListAmount[EnemyHash] = 0;
				table.insert( self.SpawnList[EnemyHash], SpawnController.EnemyList[ UnitKey ] );
				self.SpawnListAmount[EnemyHash] = self.SpawnListAmount[EnemyHash] + 1;				
			end
		end
	end
end

function SpawnController:GetSpawnUnit( EnemyHash )
	local Enemy = self.SpawnList[ EnemyHash ][ math.random(1, self.SpawnListAmount[EnemyHash] ) ]
	managers.dlc:SetEnemyHash(Enemy:key());
	return Enemy;
end
