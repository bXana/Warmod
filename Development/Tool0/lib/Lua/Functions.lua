	require("Config/RXKConfig");
if not Functions then
	Functions = true;
	
	if NetworkAccountSTEAM then
		if Base.MaskUnlockerIsActive then	
			function NetworkAccountSTEAM:has_mask(mask)
				if mask == "developer" and Base.MaskList[1] then
					return true;
				elseif mask == "hockey_com" and Base.MaskList[2] then
					return true;
				elseif mask == "alienware" and Base.MaskList[3] then
					return true;
				elseif mask == "santa" and Base.MaskList[4] then
					return true;
				elseif mask == "president" and Base.MaskList[5] then
					return true;
				elseif mask == "gold" and Base.MaskList[6] then
					return true;
				elseif mask == "troll" and Base.MaskList[7] then
					return true;
				elseif mask == "vyse" and Base.MaskList[8] then
					return true;
				elseif (mask == "tester_achievment" or mask == "tester_group") and Base.MaskList[9] then
					return true;
				end
				
				return self._masks[mask];
			end
		end

		function NetworkAccountSTEAM:username_id()
			return Base.NickName or Steam:username();
		end
	end

	if Base.DLCUnlocker and Global then
		for k, v in pairs(Global.dlc_manager.all_dlc_data) do
			k = {app_ip = "24240", no_install = true };
			v.verified = true;
		end
	end
end