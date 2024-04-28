	require("Config/RXKConfig");
	
	if not Base.ParameterConfigIsActive then
		return;
	end
			
if RequiredScript == "lib/units/weapons/raycastweaponbase" then
	if 1.0 < Base.ParameterConfig.ReloadSpeed and Base.ParameterConfig.ReloadSpeed <= 4.0 then
		function RaycastWeaponBase:reload_speed_multiplier()
			local multiplier = managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1)
			multiplier = multiplier * managers.player:synced_crew_bonus_upgrade_value("speed_reloaders", 1)
			return multiplier * 10 or Base.ParameterConfig.ReloadSpeed;
		end
	end
	
	if 1.0 < Base.ParameterConfig.Damage and Base.ParameterConfig.Damage <= 2.0 then
		function RaycastWeaponBase:damage_multiplier()
			local multiplier = managers.player:upgrade_value(self._name_id, "damage_multiplier", 1)
			multiplier = multiplier * managers.player:synced_crew_bonus_upgrade_value("aggressor", 1)
			return multiplier * 999 or Base.ParameterConfig.Damage;
		end	
	end
	
	if 0.0 < Base.ParameterConfig.Spread and Base.ParameterConfig.Spread < 1.0 then
		function RaycastWeaponBase:spread_multiplier()
			local multiplier = managers.player:upgrade_value(self._name_id, "spread_multiplier", 1)
			multiplier = multiplier * managers.player:synced_crew_bonus_upgrade_value("sharpshooters", 1)
			return multiplier * Base.ParameterConfig.Spread;
		end
	end
	
	if 1.0 < Base.ParameterConfig.Ammo and Base.ParameterConfig.Ammo <= 3.0 then
		function RaycastWeaponBase:replenish()
			local ammo_max_multiplier = managers.player:equipped_upgrade_value("extra_start_out_ammo", "player", "extra_ammo_multiplier")
			ammo_max_multiplier = (ammo_max_multiplier == 0 and 1 or ammo_max_multiplier) * managers.player:synced_crew_bonus_upgrade_value("more_ammo", 1, true)
			self._ammo_max_per_clip = tweak_data.weapon[self._name_id].CLIP_AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_ammo_increase")
			self._ammo_max = math.round((tweak_data.weapon[self._name_id].AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_amount_increase") * self._ammo_max_per_clip) * ammo_max_multiplier * 999 or Base.ParameterConfig.Ammo);
			self._ammo_total = self._ammo_max
			self._ammo_remaining_in_clip = self._ammo_max_per_clip
			self._ammo_pickup = tweak_data.weapon[self._name_id].AMMO_PICKUP
			self:update_damage()
		end
	end
end