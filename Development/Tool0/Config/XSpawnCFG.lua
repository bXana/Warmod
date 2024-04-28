XSpawnCFG = { -- XSpawn 2.0 Addon 

	EnableOVK145Params = true,  -- Police use ovk145+ params
	UnlimSpecialUnits  = false, -- Спец.юниты спавнятся с большим приоритетом

	SpawnIsActive   = false, -- Enable/Disable changed spawn ( true/false )
							-- use spawn list.
							
	ChangeWeapons 	= true, -- Enable/Disable weapon changer ( true/false )
							-- use weapon list.							
	
	MutatorIsActive = true, -- Enable/Disable mutator ( true/false )
	MutatorTable =
	{		--     min max
			--	  [ 1, 10 ] interval
		WSec1	= { 1, 1 },
		WSec2	= { 1, 1 },
		RSec	= { 1, 1 },
		
		Gang1	= { 1, 1 },
		Gang2	= { 1, 1 },
		Gang3	= { 1, 1 },
		Gang4	= { 1, 1 },
		Gang5	= { 1, 1 },
		Gang6	= { 1, 1 },
		Dealer	= { 1, 1 },
		
		Murky1	= { 1, 1 },
		Murky2	= { 1, 1 },
	
		Cop1 	= { 1, 1 },
		Cop2	= { 1, 1 },
		Cop3	= { 1, 1 },
		Fbi1	= { 1, 1 },
		Fbi2	= { 1, 1 },
		Fbi3	= { 1, 1 },
		Swat1	= { 1, 1 },
		Swat2	= { 1, 1 },
		Swat3	= { 1, 1 },
		BSwat1	= { 1, 1 },
		BSwat2	= { 1, 1 },
		Cloaker	= { 1, 1 },
		Taser	= { 1, 1 },
		Shield	= { 1, 1 },
		BDozer	= { 1, 1 },
		Sniper	= { 1, 1 }
	}
};