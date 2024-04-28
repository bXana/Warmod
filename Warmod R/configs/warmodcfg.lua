WarmodCFG = {};

-- use Notepad++ with encoding "utf-8 without BOOM"
 
WarmodCFG.EnableSpawnChanger   = true -- ( true/false ) -- Changes the spawn table of enemies. Use SpawnList.lua
WarmodCFG.EnableWeaponChanger  = true -- ( true/false ) -- Changes the weapon table of enemies. Use WeaponList.lua
WarmodCFG.EnableUniqueSpawn    = true -- ( true/false ) -- Using nearest spawn in area
WarmodCFG.EnableUniqueEvents   = true -- ( true/false ) -- Many modified classic events that complicate the game. Use EventList.lua
WarmodCFG.EnableUniqueCopLogic = true -- ( true/false ) -- The cops always know where you are and act immediately 

WarmodCFG.UseOVK145Params 		 = false -- ( true/false ) -- using ovk 145+ params for groupai 
WarmodCFG.SpecialPrioritySpawn   = false -- ( true/false ) -- Special priority spawn

WarmodCFG.PoliceAmount 			   = 35 -- [ 25, 50 ]
WarmodCFG.PoliceEscapeAmountOffset = 20 -- [ 0, 25 ] 