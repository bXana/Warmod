--require("warmod/configs/warmodcfg");
--require("warmod/scripts/functions");

--if RequiredScript == "lib/managers/mission/elementpointofnoreturn" then

	if not Host() then
		return;
	end
	local OriginalEPONR = ElementPointOfNoReturn.on_executed;
	
	function ElementPointOfNoReturn:on_executed(instigator)
		managers.dlc:SetEscapeMode( 2 );
		managers.groupai:state():AddForceOffset( WarmodEscapeOffset() );
		
		OriginalEPONR( self, instigator );	
	end
--end