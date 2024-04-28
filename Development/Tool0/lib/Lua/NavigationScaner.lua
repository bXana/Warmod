if RequiredScript == "lib/units/beings/player/states/playerstandard" then
	local temp_vec1 = Vector3()
	local mvec3_dis_sq = mvector3.distance_sq
	local mvec3_set = mvector3.set
	local mvec3_sub = mvector3.subtract
	local mvec3_add = mvector3.add
	local mvec3_mul = mvector3.multiply
	local mvec3_norm = mvector3.normalize

--	if WarmodCFG.EnableUniqueSpawn then
		function PlayerStandard:_upd_nav_data()
			if mvec3_dis_sq(self._m_pos, self._pos) > 1 then
				if self._ext_movement:nav_tracker() then
					self._ext_movement:nav_tracker():move(self._pos)
					--local WarmodNavigation = managers.dlc:GetWarmodNavigation();				
					local nav_seg_id = self._ext_movement:nav_tracker():nav_segment()
					
					if self._standing_nav_seg_id ~= nav_seg_id then
						self._standing_nav_seg_id = nav_seg_id
						MidText( "s", nav_seg_id, 0.8 );
						--if WarmodNavigation:HaveNavigation( 1 ) then
						--	WarmodNavigation:RebootNavigation( 1, nav_seg_id );						
						--else
						--	WarmodNavigation:AddNewNavigation( 1, nav_seg_id );
						--end
						local location_id = managers.navigation:location_id(nav_seg_id)
						managers.hud:set_player_location(location_id)
					end
				end
				if self._pos_reservation then
					managers.navigation:move_pos_rsrv(self._pos_reservation)
					local slow_dist = 100
					mvec3_set(temp_vec1, self._pos_reservation_slow.position)
					mvec3_sub(temp_vec1, self._pos_reservation.position)
					if slow_dist < mvec3_norm(temp_vec1) then
						mvec3_mul(temp_vec1, slow_dist)
						mvec3_add(temp_vec1, self._pos_reservation.position)
						mvec3_set(self._pos_reservation_slow.position, temp_vec1)
						managers.navigation:move_pos_rsrv(self._pos_reservation)
					end
				end
				self._ext_movement:set_m_pos(self._pos)
			end
		end
	--end
end