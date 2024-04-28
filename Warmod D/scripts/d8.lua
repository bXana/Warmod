--require("warmod/configs/warmodcfg");
--require("warmod/scripts/123");
--if RequiredScript == "lib/units/enemies/cop/logics/coplogicintimidated" then
	if WarmodCFG.EnableWeaponChanger then
		math.randomseed( os.time() );
		function CopLogicIntimidated.on_rescue_SO_completed(ignore_this, data, good_pig)
			local UniqueWeapons = {
				Idstring("units/weapons/hk21_npc/hk21_npc"),
				Idstring("units/weapons/m4_rifle_npc/m4_rifle_npc"),	
				Idstring("units/weapons/ak47_npc/ak47_npc"),
				Idstring("units/weapons/m14_npc/m14_npc")
			};
			if not data.unit:inventory():equipped_unit() then
				if data.unit:inventory():num_selections() <= 0 then
					local weap_name = UniqueWeapons[ math.random(1, 4) ];
					if weap_name then
						data.unit:inventory():add_unit_by_name(weap_name, true, true)
					end

				else
					data.unit:inventory():equip_selection(1, true)
				end

			end

			if data.unit:anim_data().hands_tied then
				local new_action = {
					type = "act",
					variant = "stand",
					body_part = 1
				}
				data.unit:brain():action_request(new_action)
			end

			CopLogicBase._exit(data.unit, "idle")
			good_pig:sound():say("_h01x_sin", true)
		end	
	end
--end