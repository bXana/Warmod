--require("warmod/configs/warmodcfg");

--if RequiredScript == "lib/managers/group_ai_states/groupaistatebase" then
--managers.dlc:GetWarmodNavigation():ResetNavigationData( PeerId );

function GroupAIStateBase:on_player_criminal_death(peer_id)
	local unit = managers.network:game():unit_from_peer_id(peer_id)
	if not unit then
		return
	end

	local my_peer_id = managers.network:session():local_peer():id()
	if my_peer_id ~= peer_id then
		managers.hint:show_hint("teammate_dead", nil, false, {
			TEAMMATE = unit:base():nick_name()
		})
	end

	if not Network:is_server() then
		return
	end

	managers.dlc:GetWarmodNavigation():ResetNavigationData( peer_id );
	local criminal_name = managers.criminals:character_name_by_peer_id(peer_id)
	local respawn_penalty = self._criminals[unit:key()].respawn_penalty or tweak_data.player.damage.base_respawn_time_penalty
	managers.trade:on_player_criminal_death(criminal_name, respawn_penalty, self._criminals[unit:key()].hostages_killed or 0)
end

function GroupAIStateBase:on_enemy_weapons_hot()
	if not self._enemy_weapons_hot then
		self._enemy_weapons_hot = true
		self:_call_listeners("enemy_weapons_hot")
		self._radio_clbk = callback(self, self, "_radio_chatter_clbk")
		managers.enemy:add_delayed_clbk("_radio_chatter_clbk", self._radio_clbk, Application:time() + 4 )
		if not self._hstg_hint_clbk then
			self._first_hostage_hint = true
			self._hstg_hint_clbk = callback(self, self, "_hostage_hint_clbk")
			managers.enemy:add_delayed_clbk("_hostage_hint_clbk", self._hstg_hint_clbk, Application:time() + 8 )
		end
	end
end

-- ver 1.2
-- bye bye ovk 193+

function GroupAIStateBase:_try_use_task_spawn_event(t, target_area, task_type, target_pos, force)
	local mvec3_dis = mvector3.distance
	target_pos = target_pos or managers.navigation._nav_segments[target_area].pos
	self._spawn_events = self._spawn_events or {}
	for _, event_data in pairs(self._spawn_events) do
		if event_data.task_type == task_type or event_data.task_type == "any" then
			local dis = mvec3_dis(target_pos, event_data.pos)
			if 1000000 >= dis then
				if force or math.random() < event_data.chance then
					self._anticipated_police_force = self._anticipated_police_force + event_data.amount
					self._police_force = self._police_force + event_data.amount
					self:_use_spawn_event(event_data)
					return 0;
				else
					event_data.chance = math.min(1, event_data.chance + event_data.chance_inc)
				end
			end
		end
	end
	return 0;
end

--end