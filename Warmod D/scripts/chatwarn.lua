	if not Host() then
		return;
	end

local OriginalFN1 = NetworkGame.on_drop_in_pause_request_received;

function NetworkGame:on_drop_in_pause_request_received(peer_id, nickname, state)
	if state then
		chat_message("LOBBY", "Integrated Warmod module ver 1.3.0 (Admin). Have a nice game!");
	end
	OriginalFN1( self, peer_id, nickname, state );
end