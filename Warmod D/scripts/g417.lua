--require("warmod/configs/warmodcfg");
--if RequiredScript == "lib/network/base/hostnetworksession" then
--	function HostNetworkSession:load(data) -- Данные о подключенных игроках

	-- Игрок подключается
--	function HostNetworkSession:add_peer(name, rpc, in_lobby, loading, synched, id, mask_set, user_id)

	-- Игрок выключается
--	if WarmodCFG.EnableUniqueSpawn then
		local HNS_remove_peer = HostNetworkSession.remove_peer
		function HostNetworkSession:remove_peer(peer, peer_id, reason)
			managers.dlc:GetWarmodNavigation():ResetNavigationData(peer_id)
			HNS_remove_peer(self, peer, peer_id, reason)
		end
--	end
--end