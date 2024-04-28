if not RXKCOORDS[GlobalIndex][1] then return end
local player_unit = managers.player:player_unit()
managers.player:warp_to(RXKCOORDS[GlobalIndex][1], player_unit:rotation())

MidText("Actived", "vector", 0.2);