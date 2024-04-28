Base = {
	DLCUnlocker = true, -- True - Activates DLC, false - Disable this option	
	EnableDebug = true, -- Enable Debug, false - disable
	EnableSkipIntro = true, -- Skip intro on the start, false - disable.
	DisableEscapeTimer = true, -- false - standart timer, otherwise  EscapeTimer = ∞
	TurnOffDrillJaming = true, -- false - standart. If you install the drill, it will not break.
	NickName = "ReXak.Legendary", -- your NickName here, false - disable option
	
	-- Mask Config --
	MaskUnlockerIsActive = true, -- true - Activates mask config, false - disable this option.
	MaskList = {
		true, -- Developer mask
		true, -- Moderator mask
		true, -- AlienWare
		true, -- Santa
		true, -- President
		true, -- Gold Masks
		true, -- Troll
		true, -- Vyse Masks
		true  -- Secret Mask
	},

	-- --- Sentry Gun Config -----
	
	SentryGunRegeneration = true, -- True - Sentry gun has HP and AMMO regeneration, False - disable this option
	
	-- --- Parameter Multiplier/Division Config -----
	
	ParameterConfigIsActive = true, -- True - enable, false - disable.
	ParameterConfig = {
		ReloadSpeed = 4.0, -- Multiplier Reload Speed. False - disable.		Interval 1.0 < ReloadSpeed <= 4.0 -- ( 1.0 ; 4.0 ]
		Damage 		= 2.0, -- Multiplier Damage. False - disable			Interval 1.0 < Damage <= 2.0   	  -- ( 1.0 ; 2.0 ]
		Spread		= 0.9, -- Division Spread. False - disable. 			Interval 0.0 < Spread < 1.0 	  -- ( 0.0 ; 1.0 )
		Ammo		= 3.0  -- Multiplier Ammo. False - disable.				Interval 1.0 < Ammo <= 3.0		  -- ( 1.0 ; 3.0 ]
	},
	
	
	-- --- Chat commands Config -----
	
	ChatCommandsActive = true, -- Activates the commands in the chat.
	ChatCommandsConfig = {
		true,  -- Enable "!medic" command.
		true,  -- Enable "!ammo" command.
		true,  -- Enable "!sentry" command.
		true   -- Enable "!respawn" command.
	}
	
};