-- GenericDLCManager используется лишь для "общения" с другими объектами.
-- 
--require("warmod/scripts/warmodnavigationcontroller");

--if RequiredScript == "lib/managers/dlcmanager" then

	local OriginalDLC = GenericDLCManager.init;
	
	function GenericDLCManager:init()
		OriginalDLC( self );
		self.EnemyHash = nil;
		self.CurrentEnemies = {};
		self.WarmodNavigation = WarmodNavigationManager:new();
		self.VarBase		  = VarBase:new();
		self.EscapeMode = 1;
	end
	
	function GenericDLCManager:GetVarBase()
		return self.VarBase;
	end
	
	function GenericDLCManager:SetEscapeMode ( NewVar )
		self.EscapeMode = NewVar;
	end
	
	function GenericDLCManager:GetEscapeMode( )
		return self.EscapeMode;
	end

	function GenericDLCManager:GetCurrentEnemiesBlock()
		return self.CurrentEnemies;
	end
	
	function GenericDLCManager:GetEnemyHash()
		return self.EnemyHash;
	end
	
	function GenericDLCManager:SetEnemyHash( EnHash )
		self.EnemyHash = EnHash;
	end
	
	function GenericDLCManager:SetNewEnemyBlock( Key )
		self.CurrentEnemies[Key] = true;
	end
	
	function GenericDLCManager:GetWarmodNavigation()
		return self.WarmodNavigation;
	end
--end

	