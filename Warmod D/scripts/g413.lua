--require("warmod/configs/warmodcfg");
--if RequiredScript == "lib/network/extensions/player/huskplayermovement" then
	-- Навигация дальних юнитов
--	if WarmodCFG.EnableUniqueSpawn then
		function HuskPlayerMovement:set_position(pos)
			mvector3.set(self._m_pos, pos)
			self._unit:set_position(pos)
			if self._nav_tracker then
				self._nav_tracker:move(pos)
				local nav_seg_id = self._nav_tracker:nav_segment()
				if self._standing_nav_seg_id ~= nav_seg_id then
					self._standing_nav_seg_id = nav_seg_id
					local MugId = self._unit:unit_data().mugshot_id;
					local Object = managers.hud:GetObject();
					local Mugshots = Object:GetMugshots();
					local WarmodNavigation = managers.dlc:GetWarmodNavigation();
					local location_id = managers.navigation:location_id(nav_seg_id)
					for _, data in ipairs( Mugshots ) do
						if data.id == MugId then
							if WarmodNavigation:HaveNavigation( data.peer_id ) then
								WarmodNavigation:RebootNavigation( data.peer_id, nav_seg_id );
							else
								WarmodNavigation:AddNewNavigation( data.peer_id, nav_seg_id );
							end						
							if location_id then
								local s = string.upper(managers.localization:text(location_id))
								data.location_text:set_text(string.upper(s))
								local _, _, w, _ = data.location_text:text_rect()
								data.location_text:set_w(w)
								Object:_update_mugshot_panel_size(data)							
							end
							return;							
						end
					end	
				end
			end
		end
--	end
--end