-- By ReXak.Legendary;
	require("Config/RXKConfig");
	
	if not Base.ChatCommandsActive then
		return;
	end


	local function ScanMessage( Message, Id )
		
		if InGame() and IsPlaying() then
			if Message:lower():find("!medic") and Base.ChatCommandsConfig[1] ~= false then
				local _ = managers.network:game():member( Id );
				if _ then
					local Unit = _:unit();
					if alive(Unit) then
						DoctorBagBase.spawn(Unit:position(), Unit:rotation(), 5);
					end
				end
			elseif Message:lower():find("!ammo") and Base.ChatCommandsConfig[2] ~= false then
				local _ = managers.network:game():member( Id );
				if _ then
					local Unit = _:unit();
					if alive(Unit) then
						AmmoBagBase.spawn(Unit:position(), Unit:rotation(), 5);
					end
				end
			elseif Message:lower():find("!sentry") and Base.ChatCommandsConfig[3] ~= false then
				local _ = managers.network:game():member( Id );
				if _ then
					local Unit = _:unit();
					if alive(Unit) then
						SentryGunBase.spawn(Unit:position(), Unit:rotation(), 5, 5);
					end
				end
			elseif Message:lower():find("!respawn") and Base.ChatCommandsConfig[4] ~= false then
				local _ = managers.network:game():member( Id );
				if _ then
					local Unit = _:unit();
					if not alive(Unit) then
						IngameWaitingForRespawnState.request_player_spawn( Id );
					end
				end
			end
		end
	end		
	
if RequiredScript == "lib/managers/hudmanager" then
	function HUDManager:_say(message, id)
		print("_say", message, id)
			ScanMessage(message, id);
		self._sound_source:post_event("prompt_exit")
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN)
		local s = hud.panel:child("textscroll"):script()
		local i = utf8.find_char(message, ":")
		s.box_print(message, tweak_data.chat_colors[id], i)
		s.scrollus:set_color(Color.white)
	end
end

if RequiredScript == "lib/managers/menu/menunodegui" then
	function MenuNodeGui:_say(message, row_item, id)
			ScanMessage(message, id);
		
		if managers.menu:active_menu() then
			managers.menu:active_menu().renderer:post_event("prompt_exit")
		end

		local s = row_item.chat_output:script()
		local i = utf8.find_char(message, ":")
		s.box_print(message, tweak_data.chat_colors[id], i)
	end	
end