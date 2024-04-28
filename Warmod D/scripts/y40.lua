--require("warmod/configs/warmodcfg");

--if RequiredScript == "lib/units/enemies/cop/copbrain" then
--	if WarmodCFG.EnableUniqueCopLogic then
		local OriginalCOPB = CopBrain.init;

		function CopBrain:init(unit)
			OriginalCOPB( self, unit );
			self.TargetPeerId = managers.dlc:GetWarmodNavigation():GetPeerId();
			self.UnitHash = nil;
			self.UnitImportant = nil;
		end	
	
		function CopBrain:GetNavigation()
			return managers.dlc:GetWarmodNavigation():GetPeerNavigation( self.TargetPeerId );
		end
		
		function CopBrain:CheckUnit()
			if self.UnitHash == "2e46807f6e933907" or self.UnitImportant then
				return false;
			end
			
			return true;
		end
		
		function CopBrain:SetUnitData( UnitHash, UnitImportant )
			self.UnitHash 	   = UnitHash;
			self.UnitImportant = UnitImportant;
		end
--	end
--end