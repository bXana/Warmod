local player_unit = managers.player:player_unit()
	local camera = managers.player:player_unit():movement()._current_state._ext_camera
	local mvec_to = Vector3()
	local from_pos = camera:position()
	mvector3.set( mvec_to, camera:forward() )
	mvector3.multiply( mvec_to, 20000 )
	mvector3.add( mvec_to, from_pos )
	local col_ray = World:raycast( "ray", from_pos, mvec_to, "slot_mask", managers.slot:get_mask( "all" ) )
	--if col_ray then
if col_ray then	
	World:delete_unit( col_ray.unit );
end
--managers.player:warp_to(RXKCOORDS[GlobalIndex][1], player_unit:rotation())
