--require("warmod/scripts/weaponcontroller");
--require("warmod/scripts/functions");

--if RequiredScript == "lib/units/enemies/cop/copbase" then
	if not Host() then
		return;
	end

	RxkWarmodWeaponModule = WeaponController:new();
	
	function CopBase:default_weapon_name()
		return RxkWarmodWeaponModule:GetWeapon();
	end	
--end	