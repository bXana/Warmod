if InGame() and IsPlaying() and Host() then
	local _ = managers.network:game():member( 1 );
	if _ then
		local Unit = _:unit();
		if alive(Unit) then
			MidText( mvector3.distance( Unit:position(), Vector3( 0, 0, 0 ) ), "Zed", 3.0 );
		end
	end	
end