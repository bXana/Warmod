require("Config/RXKConfig");

if not Base.EnableSkipIntro then
	return;
end

if InGame() and InChat() then
	if managers.network.game and Host() then
		managers.network:game():spawn_players();
	end
else
	return;
end