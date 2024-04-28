if WarmodCFG.EnableUniqueCopLogic then
	function TaserLogicAttack.queued_update(data)
		if CopLogicIdle._chk_relocate(data) then
			return
		end
		
		local delay = 0.5;

		CopLogicAttack._update_cover(data)
		local t = TimerManager:game():time()
		data.t = t
		local unit = data.unit
		local my_data = data.internal_data
		local objective = data.objective
		TaserLogicAttack._upd_enemy_detection(data)
		local focus_type = my_data.focus_type
		if focus_type ~= "assault" and focus_type ~= "tase" then
			if not data.unit:movement():chk_action_forbidden("walk") then
				my_data.update_task_key = nil
				if focus_type then
					CopLogicBase._exit(data.unit, focus_type)
				elseif data.objective then
					CopLogicBase._exit(data.unit, "idle")
					CopLogicIdle.on_new_objective(data, nil)
				elseif not managers.groupai:state():on_cop_jobless(data.unit) then
					CopLogicBase._exit(data.unit, "idle", {scan = true})
				end

			end

			CopLogicBase._report_detections(my_data.detected_enemies)
			return
		end

		local focus_enemy = my_data.focus_enemy
		TaserLogicAttack._upd_aim(data, my_data)
		local action_taken = my_data.turning or data.unit:movement():chk_action_forbidden("walk") or my_data.moving_to_cover or my_data.walking_to_cover_shoot_pos or my_data.acting
		if my_data.tasing then
			action_taken = action_taken or CopLogicAttack._chk_request_action_turn_to_enemy(data, my_data, data.m_pos, focus_enemy.m_pos)
			CopLogicBase.queue_task(my_data, my_data.update_task_key, TaserLogicAttack.queued_update, data, data.t + 1 );
			CopLogicBase._report_detections(my_data.detected_enemies)
			return
		end

		CopLogicAttack._process_pathing_results(data, my_data)
		local in_cover = my_data.in_cover
		local best_cover = my_data.best_cover
		if not my_data.processing_cover_path and not my_data.moving_to_cover and best_cover and (not in_cover or best_cover[2] ~= in_cover[2]) then
			local search_id = tostring(unit:key()) .. "cover"
			if data.unit:brain():search_for_path_to_cover(search_id, best_cover[1], best_cover[5]) then
				my_data.cover_path_search_id = search_id
				my_data.processing_cover_path = my_data.best_cover
			end

		end

		local enemy_visible = focus_enemy.verified
		local engage = my_data.attitude == "engage"
		local flank_cover
		if not action_taken then
			local move_to_cover
			if not engage or data.unit:anim_data().reload or my_data.under_fire then
				if in_cover then
					if not in_cover[4] and in_cover[3] and not unit:anim_data().crouch then
						action_taken = CopLogicAttack._chk_request_action_crouch(data)
					end

				elseif my_data.cover_path and not my_data.flank_cover then
					move_to_cover = true
				end

			elseif my_data.cover_path then
				local cover_dis = mvector3.distance(my_data.best_cover[1][1], focus_enemy.m_pos)
				if engage then
					if cover_dis > 400 and focus_enemy.verified_dis - cover_dis > 300 then
						move_to_cover = true
					end

				elseif cover_dis - focus_enemy.verified_dis > 300 then
					move_to_cover = true
				end

			end

			if move_to_cover then
				CopLogicAttack._chk_request_action_walk_to_cover(data, my_data)
				action_taken = true
			else
				local enemy_pos = enemy_visible and focus_enemy.unit:movement():m_pos() or focus_enemy.verified_pos
				action_taken = CopLogicAttack._chk_request_action_turn_to_enemy(data, my_data, data.m_pos, enemy_pos)
			end

			if not action_taken then
				if engage then
					if enemy_visible then
						my_data.cover_sideways_chk = nil
					end

					if not unit:anim_data().crouch then
						if in_cover and 1 < t - my_data.cover_enter_t and not my_data.cover_sideways_chk and not data.unit:anim_data().reload then
							my_data.cover_sideways_chk = true
							local my_tracker = unit:movement():nav_tracker()
							local shoot_from_pos = CopLogicAttack._peek_for_pos_sideways(data, my_data, my_tracker, focus_enemy.m_pos)
							if shoot_from_pos then
								local my_tracker = unit:movement():nav_tracker()
								local path = {
									mvector3.copy(data.m_pos),
									shoot_from_pos
								}
								CopLogicAttack._chk_request_action_walk_to_cover_shoot_pos(data, my_data, path)
							end

						elseif not in_cover or my_data.cover_sideways_chk then
							if my_data.flank_cover then
								local fl_cover = my_data.flank_cover
								if fl_cover.failed then
									if my_data.flank_pos then
										if my_data.flank_path then
											if data.unit:anim_data().reload then
												flank_cover = true
											else
												CopLogicAttack._chk_request_action_crouch(data)
												CopLogicAttack._chk_request_action_walk_to_cover_shoot_pos(data, my_data, my_data.flank_path, 300 < mvector3.distance(data.m_pos, my_data.flank_pos) and "run")
												my_data.flank_path = nil
											end

										elseif not my_data.flank_path_search_id then
											my_data.flank_path_search_id = tostring(unit:key()) .. "flank"
											unit:brain():search_for_path(my_data.flank_path_search_id, my_data.flank_pos)
										end

									else
										local flank_pos = CopLogicAttack._find_flank_pos(data, my_data, focus_enemy.unit:movement():nav_tracker())
										if not flank_pos then
											return
										end

										my_data.flank_pos = flank_pos
									end

								elseif fl_cover.found then
									CopLogicAttack._cancel_cover_pathing(data, my_data)
									local search_id = tostring(unit:key()) .. "cover"
									if data.unit:brain():search_for_path_to_cover(search_id, my_data.best_cover[1], my_data.best_cover[5]) then
										my_data.cover_path_search_id = search_id
										my_data.processing_cover_path = my_data.best_cover
									end

								elseif my_data.cover_path and not data.unit:anim_data().reload then
									CopLogicAttack._chk_request_action_walk_to_cover(data, my_data)
									action_taken = true
								elseif not my_data.processing_cover_path then
									flank_cover = true
								end

							else
								flank_cover = true
							end

						end

					end

					if not action_taken and unit:anim_data().crouch and (not my_data.alert_t or 4 < t - my_data.alert_t) and not data.unit:anim_data().reload then
						action_taken = CopLogicAttack._chk_request_action_stand(data)
					end

					if flank_cover then
						if not my_data.flank_cover then
							local sign = math.random() < 0.5 and -1 or 1
							local step = 30
							my_data.flank_cover = {
								step = step,
								angle = step * sign,
								sign = sign
							}
						end

					else
						my_data.flank_cover = nil
					end

				else
					if (enemy_visible or my_data.under_fire) and not unit:anim_data().crouch then
						action_taken = CopLogicAttack._chk_request_action_crouch(data)
					end

					if not action_taken then
						local enemy_pos = enemy_visible and focus_enemy.unit:movement():m_pos() or focus_enemy.verified_pos
						action_taken = CopLogicAttack._chk_request_action_turn_to_enemy(data, my_data, data.m_pos, enemy_pos)
					end

				end

			end

		end

		CopLogicBase.queue_task(my_data, my_data.update_task_key, TaserLogicAttack.queued_update, data, data.t + delay )
		CopLogicBase._report_detections(my_data.detected_enemies)
	end
end