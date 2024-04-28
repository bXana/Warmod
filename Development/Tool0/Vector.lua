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
	--MidText( "dis", mvector3.distance( col_ray.unit:position(), camera:position() ), 1.0 );
	local File = io.open("ZZZZ.log", "ab");
	File:write( "Name = \"" .. col_ray.unit:name():key() .. "\"\nVector3( " .. col_ray.unit:position().x .. ", " ..  col_ray.unit:position().y  .. ", " .. col_ray.unit:position().z .. ")\n" );
	File:close();
end
--managers.player:warp_to(RXKCOORDS[GlobalIndex][1], player_unit:rotation())
