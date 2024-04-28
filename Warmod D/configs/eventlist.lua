-- New in Warmod 1.1. Includes many events that are not available by standart methods.
EventList = {
	Bank 			= {},
	HeatStreet 		= {},
	PanicRoom 		= {},
	GreenBridge 	= {},
	SlaughterHouse 	= {},
	DiamondHeist 	= {},
	Counterfeit 	= {},
	Undercover  	= {},
	NoMercy 		= {}
};

-----------------------------  Bank  -----------------------------

EventList.Bank.SecurityAtEntrace = true   -- Activate all security guards at the entrance
													
EventList.Bank.HeavySniperCover  = true   -- There are 4 snipers at the exit, + 5 snipers guard the drill
EventList.Bank.DrillSniperCount  = 4	  -- [ 2, 4 ]
EventList.Bank.StreetSniperCount = 4	  -- [ 2, 4 ]
													
EventList.Bank.ActivateAllPC	 = true	  -- Need activate 4 pc, "security footage" objective.
EventList.Bank.PCAmount			 = 3	  -- [ 1, 4 ] 

EventList.Bank.SecurityInHallV	 = true	  -- Security in vault hall ( Fucking bank guards... )

EventList.Bank.BulldozersInVault = true	  -- Bulldozers in vault on all difficulties.
EventList.Bank.BDZAmountInVault	 = 5      -- [ 4, 5 ]

EventList.Bank.CloakerSuprise	 = true   -- Cloakers suprise in vault hall.

EventList.Bank.TasersOnStairs	 = true   -- Escape, taser stair ambush.

EventList.Bank.CopEscapeAmbush   = true   -- POINT of no return guys!!! ... smoke, cloaker, shield, swat	

EventList.Bank.EscapeLastAmbush  = true   -- bulldozers, tasers break down doors, spawn cloakers.	

-----------------------------  Counterfeit  -----------------------------

EventList.Counterfeit.ManyCivs		 = true -- call all civ spawn variants

EventList.Counterfeit.DefC4			 = true -- need defuse c4 in the shelter

EventList.Counterfeit.AllReels  	 = true -- spawn all reels
EventList.Counterfeit.ReelsAmount 	 = 3    -- [ 1, 4 ]

EventList.Counterfeit.ComplexEnergy  = true -- new energy logic
EventList.Counterfeit.SocketAmount	 = 1	-- drill energy sockets [ 1, 2 ]  

EventList.Counterfeit.ShieldCover 	 = true -- shield cover on escape ways.
									
-----------------------------  Diamond Heist  -----------------------------		

EventList.DiamondHeist.ManyGenSec 	 	 = true  -- activate all patrol guards
EventList.DiamondHeist.AlarmBoxCount	 = 7 	 -- Alarm Box count [ 3, 7 ]
EventList.DiamondHeist.SaveParty		 = true  -- save party lights & music

-----------------------------  No Mercy  -----------------------------

EventList.NoMercy.AllCameras = true -- activate all cameras on map
									