--require("warmod/configs/warmodcfg");
--require("warmod/scripts/functions");

--if RequiredScript == "lib/tweak_data/groupaitweakdata" then
	local OriginalGATDINIT = GroupAITweakData.init;
	local OriginalGATDSOVK145 = GroupAITweakData._set_overkill_145;
	local OriginalGATDSEASY	= GroupAITweakData._set_easy;
	local OriginalGATDSNORMAL = GroupAITweakData._set_normal;
	local OriginalGATDSHARD	  = GroupAITweakData._set_hard;
	local OriginalGATDSOVK	  = GroupAITweakData._set_overkill;
	
	local MinPoliceLim	= WarmodPoliceMinLim();
	local MaxPoliceLim	= WarmodPoliceMaxLim();
	local PoliceEscLim	= WarmodEscapeOffset();
	
	function GroupAITweakData:init()
		OriginalGATDINIT( self );

		self.besiege.assault.force = {
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
		}		
		
		self.street.assault.force.aggressive = {
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 20 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 23 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
		}

		for k, v in pairs( self.unit_categories ) do
			if v.max_amount then
				self.unit_categories[k].max_amount = AbstrackCheck( 1000, 1 , WarmodCFG.SpecialPrioritySpawn );
			end
			self.unit_categories[k].access = {"walk", "acrobatic"};
		end
	end
	
	function GroupAITweakData:_set_overkill_145()
		OriginalGATDSOVK145( self );

		self.besiege.assault.force = {
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 35 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 35 ) + PoliceEscLim
		}
		
		self.street.assault.force.aggressive = {
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 20 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 23 ) + PoliceEscLim,
			CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
		}		
	end	
	
	if WarmodCFG.UseOVK145Params then
		function GroupAITweakData:_set_overkill()
			self:_set_overkill_145();
		end
		
		function GroupAITweakData:_set_hard()
			self:_set_overkill_145();
		end
		
		function GroupAITweakData:_set_normal()
			self:_set_overkill_145();
		end	

		function GroupAITweakData:_set_easy()
			self:_set_overkill_145();
		end
	else
		function GroupAITweakData:_set_easy()
			OriginalGATDSEASY( self );
			
			self.besiege.assault.force = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 15 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 15 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 15 ) + PoliceEscLim
			}

			self.street.assault.force.aggressive = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 10 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 15 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 20 ) + PoliceEscLim
			}
		end

		function GroupAITweakData:_set_normal()
			OriginalGATDSNORMAL( self );
			self.besiege.assault.force = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
			}

			self.street.assault.force.aggressive = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 20 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 23 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
			}
		end

		function GroupAITweakData:_set_hard()
			OriginalGATDSHARD( self );
			self.besiege.assault.force = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
			}

			self.street.assault.force.aggressive = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 20 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 23 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
			}			
		end

		function GroupAITweakData:_set_overkill()
			OriginalGATDSOVK( self );
			self.besiege.assault.force = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
			}

			self.street.assault.force.aggressive = {
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 20 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 23 ) + PoliceEscLim,
				CheckVarInterval( WarmodCFG.PoliceAmount, MinPoliceLim, MaxPoliceLim, 25 ) + PoliceEscLim
			}			
		end		
	end
--end