if not Core then
	
	RXKCOORDS = {};
	
	GlobalIndex = 1;
	
	function MidText( Message, Title, Time )
		if managers and managers.hud then
			managers.hud:present_mid_text( { text = Message, title = Title, time = Time or 3.0 } )
		end
	end

	function InGame()
		if not game_state_machine then 
			return false; 
		end

		return string.find(game_state_machine:current_state_name(), "game");
	end
	
	
	function IsPlaying()
		if not BaseNetworkHandler then 
			return false;
		end
	
		return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ];
	end
	
	
	function Host()
		if not Network then 
			return false; 
		end
	
		return Network:is_server();
	end
	
	function Client()
		if not Network then
			return false;
		end
		
		return Network:is_client();
	end
	
	
	function InChat()
		if managers.hud._chat_focus then
			return true;
		end

		return false;
	end

	Core = true
end