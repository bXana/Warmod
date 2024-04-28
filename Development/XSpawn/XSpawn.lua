-- XSpawn mod 
-- VERSION 2.2.0
-- AUTHORS :  ( AnXZ ), IamSeryoga, Just_KirilL ( AnTiMoZG ) 

-- 2.2.0 -> Universal spawn point controller
-- 2.1.1 -> Spawn point controller
-- 2.0.1 -> Changed code ( Optimization )

require("Config/XSpawnCFG");
require("Config/SpawnList");
require("Config/WeaponList");
require("Config/SpawnPointCFG");

	function MidText( message, message_title, duration )
		if managers and managers.hud then
			if not duration then duration = 3 end
			managers.hud:present_mid_text( { text = message_title, title = message, time = duration } )
		end
	end

math.randomseed( os.time() );

function Host()
	if not Network then 
		return false; 
	end

	return Network:is_server();
end

if not Host() then
	return;
end

------------------------
-- Useful Data Structures --
------------------------

local SpawnPointStruct = 
{
	["bank"] =
	{
		["management"] =
		{
			-- менеджер левое окно
			{ Vector3( -775, -3875, 475 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			-- менеджер правое окно
			{ Vector3( -1100, -3875, 475 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" }		
		},
		
		["leftoffice"] =
		{
			-- левое окно
			{ Vector3( 150, -3875, 475 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			-- правое окно
			{ Vector3( -125, -3875, 475 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" }		
		},
		
		["rightoffice"] =
		{
			-- Левое окно
			{ Vector3( -2734, -2720, 475.00100708008 ), Rotation( Vector3(0, -1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			-- Центральное окно
			{ Vector3( -2740, -2294, 475.00100708008 ), Rotation( Vector3(0, -1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" }		
		},
		
		["cloakercall"] =
		{
			-- Шахта с клокерами
			{ Vector3( 520, 57, 476.5530090332 ), Rotation( Vector3(-1, -1.19209e-007, 0), Vector3(1.19209e-007, -1, 0), Vector3(0, 0, 1) ), "run_jumpdown" },

			{ Vector3( 522, 31, 475.01998901367 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "run_jumpdown" },

			{ Vector3( 538, 14, 476.5530090332 ), Rotation( Vector3(-1, -1.19209e-007, 0), Vector3(1.19209e-007, -1, 0), Vector3(0, 0, 1) ), "run_jumpdown" }		
		},
		
		["tasercall"] =
		{
			{ Vector3( -750, -1550, 476.00100708008 ), Rotation( Vector3(0, -1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1) ), "repel_vert" },	
		
			{ Vector3( -550, -1600, 476.00100708008 ), Rotation( Vector3(0, -1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1) ), "repel_vert" }	
		},
		
		["floorelevator"] =
		{
			{ Vector3( 678, 66, 476.5530090332 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "repel_through_wndw_long" },

			{ Vector3( 675, -25, 476.5530090332 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "repel_through_wndw_long" }	
		},
		
		["leftangle"] =
		{
			{ Vector3(-2950, 3775, -125 ), Rotation(Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" },

			{ Vector3(-2850, 3775, -125 ), Rotation(Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" },

			{ Vector3(-2900, 3775, -125 ), Rotation(Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" }		
		},
		
		["rightangle"] =
		{
			{ Vector3(-2975, -3450, -114 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "none" },

			{ Vector3(-3125, -3450, -114 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "none" },

			{ Vector3(-2825, -3575, -124.75 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" },

			{ Vector3( -2850, -3625, -125 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" },

			{ Vector3( -2800, -3525, -125 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" },

			{ Vector3( -2900, -3525, -125 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" },

			{ Vector3( -2900, -3600, -125 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "none" }		
		},
		
		["flywindow"] =
		{
			{ Vector3( -1816, 2750, -15.000100135803 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "repel_vert_skylight" },

			{ Vector3( -1250, 2451, -20 ), Rotation( Vector3(0, -1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1) ), "repel_vert_skylight" },

			{ Vector3( -1250, 2725, -15.000100135803 ), Rotation( Vector3(0, -1, 0), Vector3(1, 0, 0), Vector3(0, 0, 1) ), "repel_vert_skylight" },

			{ Vector3( -1822, 2454, -24.974800109863 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "repel_vert_skylight" }

		--	{ Vector3( -1675, 2800, -24.974800109863 ), Rotation( Vector3(0.707108, 0.707106, 0), Vector3(-0.707106, 0.707108, -0), Vector3(-0, 0, 1) ), "repel_vert" },

		--	{ Vector3( -1700, 2625, -8.5074501037598 ), Rotation( Vector3(0.707108, 0.707106, 0), Vector3(-0.707106, 0.707108, -0), Vector3(-0, 0, 1) ), "repel_vert" }	
		},
		
		["elevator1"] =
		{
			-- 4-й лифт 
			{ Vector3( 1600, 525, -25 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_long" },

			-- 1-й лифт
			{ Vector3( 1583, 1966, -25 ), Rotation( Vector3(-1, -2.38418e-007, 0), Vector3(2.38418e-007, -1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_long" },

			{ Vector3( 1638, 1968, -25 ), Rotation( Vector3(-1, -2.38418e-007, 0), Vector3(2.38418e-007, -1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_long" }	
		},
		
		["elevator2"] =
		{
			-- 3-й лифт
			{ Vector3( 2374, 551, -25 ), Rotation( Vector3(0.981866, 0.189578, 0), Vector3(-0.189578, 0.981866, -0), Vector3(-0, 0, 1) ), "repel_through_wndw_long" },

			{ Vector3( 2437, 545, -25 ), Rotation( Vector3(0.972723, -0.23197, 0), Vector3(0.23197, 0.972723, 0), Vector3(0, 0, 1) ), "repel_through_wndw_long" },

			-- 2-й лифт
			{ Vector3( 2432, 1975, -25 ), Rotation( Vector3(-1, -2.38418e-007, 0), Vector3(2.38418e-007, -1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_long" },

			{ Vector3( 2382, 1959, -25 ), Rotation( Vector3(-0.993861, 0.110633, 0), Vector3(-0.110633, -0.993861, 0), Vector3(0, 0, 1) ), "repel_through_wndw_long" }	
		
		},
		
		["ventilation"] =
		{
			-- Левая
			{ Vector3( 3375, 1775, -15 ), Rotation( Vector3(-1, -2.38418e-007, 0), Vector3(2.38418e-007, -1, 0), Vector3(0, 0, 1) ), "run_jumpdown" },

			-- Правая
			{ Vector3( 3375, 725, -15 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "run_jumpdown" }	
		},
		
		["longventilation"] =
		{
			-- Левая дальняя
			{ Vector3( 5200, 1825, -24.895099639893 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "run_jumpdown" },

			-- Правая дальняя
			{ Vector3( 5175, 675, -24.895099639893 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "run_jumpdown" }
		},
		
		["lastventilation"] =
		{
			-- Дальняя последняя
			{ Vector3( 6775, 1250, -24.89640045166 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "run_jumpdown" },

			-- Дальняя предпоследняя
			{ Vector3( 6350, 1250, -54.895301818848 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "run_jumpdown" }
		},
		
		["backwindow"] =
		{
			{ Vector3( 3243, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 3399, -4532, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 4850, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 3832, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 3658, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 4550, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 4407, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" },

			{ Vector3( 5025, -4525, 464.30899047852 ), Rotation( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1) ), "repel_through_wndw_short" }	
		},
		
		["backelevator"] =
		{
			{ Vector3( 5848, -3025, 464.30899047852 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "repel_through_wndw_short" },
			{ Vector3( 5850, -3250, 464.30899047852 ), Rotation( Vector3(0, 1, 0), Vector3(-1, 0, -0), Vector3(-0, 0, 1) ), "repel_through_wndw_short" }
		}	
	}
};

local SpawnPointActBlackList =
{
	["bank"] =
	{
		["so_cbt_force_door"] = true,
		["cop_car_exit_to_rifle_combat_front_l"] = true,
		["cop_car_exit_to_rifle_combat_front_r"] = true
	},
	["heat_street"] = 	nil,
	["bridge"]	= 		nil,
	["apartment"] = 	nil,
	["slaughter_house"] = nil,
	["diamond_heist"]	= nil,
	["suburbia"]		= nil,
	["secret_stash"]	= nil,
	["hospital"]		= nil	
};

local SpawnBlockPointVectorStruct =
{
	["bank"] = 	
	{
		[1] =
		{
		
		},
		[2] =
		{
		
		}
	},
	["heat_street"] = 	nil,
	["bridge"]	= 		nil,
	["apartment"] = 	nil,
	["slaughter_house"] = nil,
	["diamond_heist"]	= nil,
	["suburbia"]		= nil,
	["secret_stash"]	= nil,
	["hospital"]		= nil
};

local SpawnBlockPointVectorStructAmount = {};
local SpawnPointStructAmount = {};

for Map, x in pairs( SpawnBlockPointVectorStruct ) do
	if SpawnBlockPointVectorStruct[Map] then
		SpawnBlockPointVectorStructAmount[Map] = {};
		for SpawnMode, y in ipairs( SpawnBlockPointVectorStruct[ Map ] ) do
			SpawnBlockPointVectorStructAmount[Map][SpawnMode] = {};
			for Location, Graph in pairs( SpawnBlockPointVectorStruct[ Map ][ SpawnMode ] ) do
				if Graph then
					SpawnBlockPointVectorStructAmount[Map][SpawnMode][Location] = #Graph;			
				end
			end
		end	
	end
end

for Map, x in pairs( SpawnPointStruct ) do
	if SpawnPointStruct[Map] then
		SpawnPointStructAmount[Map] = {};
		for SpawnPoint, Vectors in pairs( SpawnPointStruct[ Map ] ) do
			if Vectors then
				SpawnPointStructAmount[Map][SpawnPoint] = #Vectors;
			end
		end	
	end
end
------------------------
-- Trigger Activator --

-- Выбить все стёкла, открыть все лифты, шахты, вентеляции
function BankTrigger()
	for Obj, script in pairs(managers.mission:scripts()) do
		if Obj ~= "event_cafeteria_window" and 
		   Obj ~= "event_globe_window"     then
			for id, element in pairs(script:elements()) do
				for X, trigger in pairs(element:values().trigger_list or {}) do
					if trigger.notify_unit_sequence == "make_dynamic" or 
					   trigger.notify_unit_sequence:lower():find("dest") or 
					   trigger.notify_unit_sequence == "open" then 
						element:on_executed()
					end
				end
			end
		end
	end	
end

local TriggerMapStruct = 
{
	["bank"] = 			BankTrigger,
	["heat_street"] = 	nil,
	["bridge"]	= 		nil,
	["apartment"] = 	nil,
	["slaughter_house"] = nil,
	["diamond_heist"]	= nil,
	["suburbia"]		= nil,
	["secret_stash"]	= nil,
	["hospital"]		= nil
};

local function TriggerActivate( Map ) -- void --
	TriggerMapStruct[Map]();
end

------------------------
-- SpawnPoint functions
------------------------
XSpawnSpawnPointStatus = 1;

if RequiredScript == "lib/managers/mission/elementpointofnoreturn" then
	function ElementPointOfNoReturn:on_executed(instigator)
		if not self._values.enabled then
			return
		end
		
		XSpawnSpawnPointStatus = 2;

		local diff = Global.game_settings and Global.game_settings.difficulty or "hard"
		if diff == "easy" then
			managers.groupai:state():set_point_of_no_return_timer(self._values.time_easy, self._id)
		elseif diff == "normal" then
			managers.groupai:state():set_point_of_no_return_timer(self._values.time_normal, self._id)
		elseif diff == "hard" then
			managers.groupai:state():set_point_of_no_return_timer(self._values.time_hard, self._id)
		elseif diff == "overkill" then
			managers.groupai:state():set_point_of_no_return_timer(self._values.time_overkill, self._id)
		elseif diff == "overkill_145" then
			managers.groupai:state():set_point_of_no_return_timer(self._values.time_overkill_145, self._id)
		end

		ElementPointOfNoReturn.super.on_executed(self, instigator)
	end
end

if XSpawnCFG.EnableSpawnPointCFG then
	 LastNavigation = { nil, nil, nil, nil };
	 NavigationBlock = {};
	 NavigationBlockAmount = 0;
	
	function ResetNavigationData( PeerId )
		if LastNavigation[ PeerId ] then
			table.delete( NavigationBlock, LastNavigation[ PeerId ] );
			NavigationBlockAmount = NavigationBlockAmount - 1;
			LastNavigation[ PeerId ] = nil;
			MidText( PeerId, "Removed", 1.0 );
			MidText( #NavigationBlock, "size", 1.0 );
			MidText( NavigationBlockAmount, "amount", 1.0 );
		end
	end

	if RequiredScript == "lib/network/extensions/player/huskplayermovement" then
		-- Навигация дальних юнитов
		function HuskPlayerMovement:set_position(pos)
			mvector3.set(self._m_pos, pos)
			self._unit:set_position(pos)
			if self._nav_tracker then
				self._nav_tracker:move(pos)
				local nav_seg_id = self._nav_tracker:nav_segment()
				if self._standing_nav_seg_id ~= nav_seg_id then
					self._standing_nav_seg_id = nav_seg_id
					local MugId = self._unit:unit_data().mugshot_id;
					local Object = managers.hud:GetObject();
					local Mugshots = Object:GetMugshots();

					local location_id = managers.navigation:location_id(nav_seg_id)
					for _, data in ipairs( Mugshots ) do
						if data.id == MugId then
							if LastNavigation[ data.peer_id ] then
								table.delete( NavigationBlock, LastNavigation[ data.peer_id ] );
								LastNavigation[ data.peer_id ] = nav_seg_id;
								table.insert( NavigationBlock, LastNavigation[ data.peer_id ] );
								
								MidText( data.peer_id, "check multi", 1.0 );
								MidText( LastNavigation[ data.peer_id ], "CurrentPos", 1.0 );
								MidText( #NavigationBlock, "size", 1.0 );
								MidText( NavigationBlockAmount, "amount", 1.0 );						
							else
								LastNavigation[ data.peer_id ] = nav_seg_id;
								table.insert( NavigationBlock, LastNavigation[ data.peer_id ] );	
								NavigationBlockAmount = NavigationBlockAmount + 1;
								MidText( data.peer_id, "add multi", 1.0 );
								MidText( LastNavigation[ data.peer_id ], "CurrentPos", 1.0 );
								MidText( #NavigationBlock, "size", 1.0 );
								MidText( NavigationBlockAmount, "amount", 1.0 );								
							end						
							if location_id then
								local s = string.upper(managers.localization:text(location_id))
								data.location_text:set_text(string.upper(s))
								local _, _, w, _ = data.location_text:text_rect()
								data.location_text:set_w(w)
								Object:_update_mugshot_panel_size(data)							
							end
							return;							
						end
					end	
				end
			end
		end
	end
	
	if RequiredScript == "lib/managers/hudmanager" then
		function HUDManager:GetMugshots()
			return self._hud.mugshots;		
		end
		
		function HUDManager:GetObject()
			return self
		end
	end
	
	if RequiredScript == "lib/units/beings/player/states/playerstandard" then
		local temp_vec1 = Vector3()
		local mvec3_dis_sq = mvector3.distance_sq
		local mvec3_set = mvector3.set
		local mvec3_sub = mvector3.subtract
		local mvec3_add = mvector3.add
		local mvec3_mul = mvector3.multiply
		local mvec3_norm = mvector3.normalize

		function PlayerStandard:_upd_nav_data()
			if mvec3_dis_sq(self._m_pos, self._pos) > 1 then
				if self._ext_movement:nav_tracker() then
					self._ext_movement:nav_tracker():move(self._pos)
					local nav_seg_id = self._ext_movement:nav_tracker():nav_segment()
					if self._standing_nav_seg_id ~= nav_seg_id then
						self._standing_nav_seg_id = nav_seg_id
						if LastNavigation[1] then
							table.delete( NavigationBlock, LastNavigation[1] );
							LastNavigation[1] = nav_seg_id;
							table.insert( NavigationBlock, LastNavigation[1] );	
								MidText( 1, "check local", 1.0 );
								MidText( LastNavigation[ 1 ], "CurrentPos", 1.0 );
								MidText( #NavigationBlock, "size", 1.0 );
								MidText( NavigationBlockAmount, "amount", 1.0 );							
						else
							LastNavigation[1] = nav_seg_id;
							table.insert( NavigationBlock, LastNavigation[1] );
							NavigationBlockAmount = NavigationBlockAmount + 1;
															MidText( 1, "add local", 1.0 );
								MidText( LastNavigation[ 1 ], "CurrentPos", 1.0 );
								MidText( #NavigationBlock, "size", 1.0 );
								MidText( NavigationBlockAmount, "amount", 1.0 );
						end
						local location_id = managers.navigation:location_id(nav_seg_id)
						managers.hud:set_player_location(location_id)
					end
				end
				if self._pos_reservation then
					managers.navigation:move_pos_rsrv(self._pos_reservation)
					local slow_dist = 100
					mvec3_set(temp_vec1, self._pos_reservation_slow.position)
					mvec3_sub(temp_vec1, self._pos_reservation.position)
					if slow_dist < mvec3_norm(temp_vec1) then
						mvec3_mul(temp_vec1, slow_dist)
						mvec3_add(temp_vec1, self._pos_reservation.position)
						mvec3_set(self._pos_reservation_slow.position, temp_vec1)
						managers.navigation:move_pos_rsrv(self._pos_reservation)
					end
				end
				self._ext_movement:set_m_pos(self._pos)
			end
		end	
	end
	
	if RequiredScript == "lib/managers/trademanager" then
--		function TradeManager:clbk_respawn_criminal(trading_unit) -- custody respawn hook


		function TradeManager:on_player_criminal_death(criminal_name, respawn_penalty, hostages_killed, skip_netsend)
			if not managers.hud then
				return
			end

			for _, crim in ipairs(self._criminals_to_respawn) do
				if crim.id == criminal_name then
					return
				end
			end

			if tweak_data.player.damage.automatic_respawn_time then
				respawn_penalty = math.min(respawn_penalty, tweak_data.player.damage.automatic_respawn_time)
			end

			local crim_data = managers.criminals:character_data_by_name(criminal_name)
			if crim_data then
				managers.hud:set_mugshot_custody(crim_data.mugshot_id)
				managers.hud:set_mugshot_timer(crim_data.mugshot_id, respawn_penalty)
				managers.hud:show_mugshot_timer(crim_data.mugshot_id)
			end

			local crim = {
				id = criminal_name,
				ai = false,
				respawn_penalty = respawn_penalty,
				hostages_killed = hostages_killed,
				peer_id = managers.criminals:character_peer_id_by_name(criminal_name)
			}
			
			ResetNavigationData( crim.peer_id );
			
			local inserted = false
			for i, crim_to_respawn in ipairs(self._criminals_to_respawn) do
				if crim_to_respawn.ai == true or respawn_penalty < crim_to_respawn.respawn_penalty then
					table.insert(self._criminals_to_respawn, i, crim)
					inserted = true
					break;
				end
			end

			if not inserted then
				table.insert(self._criminals_to_respawn, crim)
			end

			if Network:is_server() and not skip_netsend then
				managers.network:session():send_to_peers("set_trade_death", criminal_name, respawn_penalty, hostages_killed)
				self:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed, true)
			end

			return crim
		end
	end
	
	if RequiredScript == "lib/network/base/hostnetworksession" then
	--	function HostNetworkSession:load(data) -- Данные о подключенных игроках

		-- Игрок подключается
	--	function HostNetworkSession:add_peer(name, rpc, in_lobby, loading, synched, id, mask_set, user_id)
	
		-- Игрок выключается
		function HostNetworkSession:remove_peer(peer, peer_id, reason)
			HostNetworkSession.super.remove_peer(self, peer, peer_id, reason)
			ResetNavigationData( peer_id );
			if self._dead_con_reports then
				local i = #self._dead_con_reports
				while i > 0 do
					local dead_con_report = self._dead_con_reports[i]
					if dead_con_report.reporter == peer or dead_con_report.reported == peer then
						table.remove(self._dead_con_reports, i)
					end

					i = i - 1
				end

				if not next(self._dead_con_reports) then
					self._dead_con_reports = nil
				end

			end

			if NetworkManager.DROPIN_ENABLED then
				for peer_id, other_peer in pairs(self._peers) do
					if other_peer:is_expecting_pause_confirmation(peer_id) then
						self:set_dropin_pause_request(other_peer, peer_id, false)
					end
				end

				if self._local_peer:is_expecting_pause_confirmation(peer_id) then
					self._local_peer:set_expecting_drop_in_pause_confirmation(peer_id, nil)
					managers.network:game():on_drop_in_pause_request_received(peer_id, "", false)
				end

				for other_peer_id, other_peer in pairs(self._peers) do
					self:chk_drop_in_peer(other_peer)
					self:chk_initiate_dropin_pause(other_peer)
					self:chk_spawn_member_unit(other_peer, other_peer_id)
				end

			end

			local info_msg_type
			if reason == "kicked" then
				info_msg_type = "kick_peer"
			else
				info_msg_type = "remove_dead_peer"
			end

			for peer_id, other_peer in pairs(self._peers) do
				if other_peer:handshakes()[peer_id] == true or other_peer:handshakes()[peer_id] == "asked" then
					other_peer:send_after_load(info_msg_type, peer_id)
					other_peer:set_handshake_status(peer_id, "removing")
				end
			end

			if reason ~= "left" and reason ~= "kicked" and peer:ip_verified() then
				peer:send(info_msg_type, peer_id)
			end

			self:chk_server_joinable_state()
		end
	end
	
	local TriggerIsActive = false;
	local Map = Global.level_data.level_id;

	if not Global.game_settings.single_player then
		function GetSpawnPoint( UnitData )
return UnitData[1], UnitData[2], UnitData[3];
		end	
	else
		function GetSpawnPoint( UnitData )
			if UnitData[4] == Idstring("units/characters/enemies/sniper/sniper"):key() or
			   SpawnPointActBlackList[ UnitData[3] ] or
			   not SpawnPointCFG.UnitSpawnPointController[ UnitData[5] ] or 
			   NavigationBlockAmount == 0 then
				return UnitData[1], UnitData[2], UnitData[3];
			end
			
			if not TriggerIsActive then
				TriggerActivate( Map );
			end
			
			local Targetloc = NavigationBlock[ 1 ];
			local TargetGraph = SpawnBlockPointVectorStruct[Map][XSpawnSpawnPointStatus][Targetloc][math.random( 1, SpawnBlockPointVectorStructAmount[Map][XSpawnSpawnPointStatus][Targetloc] )];
			local TargetSP = SpawnPointStruct[Map][TargetGraph][math.random(1, SpawnPointStructAmount[Map][TargetGraph] ) ];
			
			return TargetSP[1], TargetSP[2], TargetSP[3];
		end		
	end
else
	function GetSpawnPoint( UnitData )
		return UnitData[1], UnitData[2], UnitData[3];		
	end
end	


--------------------------------------------
--========================================--
--------------------------------------------
-- Spawn

local EnemyStruct =
{
	["WSec1"]	= Idstring("units/characters/enemies/security/security_guard_01"),
	["WSec2"]	= Idstring("units/characters/enemies/security/security_guard_02"),
	["RSec"]	= Idstring("units/characters/enemies/security/patrol_guard"),
	
	["Gang1"]	= Idstring("units/characters/enemies/gangster1/gangster1"),
	["Gang2"]	= Idstring("units/characters/enemies/gangster2/gangster2"),
	["Gang3"]	= Idstring("units/characters/enemies/gangster3/gangster3"),
	["Gang4"]	= Idstring("units/characters/enemies/gangster4/gangster4"),
	["Gang5"]	= Idstring("units/characters/enemies/gangster5/gangster5"),
	["Gang6"]	= Idstring("units/characters/enemies/gangster6/gangster6"),
	["Dealer"]	= Idstring("units/characters/enemies/dealer/dealer"),
	
	["Murky1"]	= Idstring("units/characters/enemies/murky_water1/murky_water1"),
	["Murky2"]	= Idstring("units/characters/enemies/murky_water2/murky_water2"),
	
	["Cop1"]	= Idstring("units/characters/enemies/cop/cop"),
	["Cop2"]	= Idstring("units/characters/enemies/cop2/cop2"),
	["Cop3"]	= Idstring("units/characters/enemies/cop3/cop3"),
	["Fbi1"]	= Idstring("units/characters/enemies/fbi1/fbi1"),
	["Fbi2"]	= Idstring("units/characters/enemies/fbi2/fbi2"),
	["Fbi3"]	= Idstring("units/characters/enemies/fbi3/fbi3"),
	["Swat1"]	= Idstring("units/characters/enemies/swat/swat"),
	["Swat2"]	= Idstring("units/characters/enemies/swat2/swat2"),
	["Swat3"]	= Idstring("units/characters/enemies/swat3/swat3"),	
	["BSwat1"]	= Idstring("units/characters/enemies/swat_kevlar1/swat_kevlar1"),
	["BSwat2"]	= Idstring("units/characters/enemies/swat_kevlar2/swat_kevlar2"),
	["Cloaker"]	= Idstring("units/characters/enemies/spooc/spooc"),
	["Taser"]	= Idstring("units/characters/enemies/taser/taser"),
	["Shield"]	= Idstring("units/characters/enemies/shield/shield"),
	["BDozer"]	= Idstring("units/characters/enemies/tank/tank"),
	["Sniper"]	= Idstring("units/characters/enemies/sniper/sniper")
	
};

local InvEnemyStruct = 
{
	[Idstring("units/characters/enemies/security/security_guard_01"):key()] = "WSec1",
	[Idstring("units/characters/enemies/security/security_guard_02"):key()] = "WSec2",
	[Idstring("units/characters/enemies/security/patrol_guard"):key()]		= "RSec",
	
	[Idstring("units/characters/enemies/gangster1/gangster1"):key()] = "Gang1",
	[Idstring("units/characters/enemies/gangster2/gangster2"):key()] = "Gang2",
	[Idstring("units/characters/enemies/gangster3/gangster3"):key()] = "Gang3",
	[Idstring("units/characters/enemies/gangster4/gangster4"):key()] = "Gang4",
	[Idstring("units/characters/enemies/gangster5/gangster5"):key()] = "Gang5",
	[Idstring("units/characters/enemies/gangster6/gangster6"):key()] = "Gang6",
	[Idstring("units/characters/enemies/dealer/dealer"):key()] 		 = "Dealer",
	
	[Idstring("units/characters/enemies/murky_water1/murky_water1"):key()] = "Murky1",
	[Idstring("units/characters/enemies/murky_water2/murky_water2"):key()] = "Murky2",
	
	[Idstring("units/characters/enemies/cop/cop"):key()]   = "Cop1",
	[Idstring("units/characters/enemies/cop2/cop2"):key()] = "Cop2",
	[Idstring("units/characters/enemies/cop3/cop3"):key()] = "Cop3",
	[Idstring("units/characters/enemies/fbi1/fbi1"):key()] = "Fbi1",
	[Idstring("units/characters/enemies/fbi2/fbi2"):key()] = "Fbi2",
	[Idstring("units/characters/enemies/fbi3/fbi3"):key()] = "Fbi3",
	[Idstring("units/characters/enemies/swat/swat"):key()] = "Swat1",
	[Idstring("units/characters/enemies/swat2/swat2"):key()] = "Swat2",
	[Idstring("units/characters/enemies/swat3/swat3"):key()] = "Swat3",
	[Idstring("units/characters/enemies/swat_kevlar1/swat_kevlar1"):key()] = "BSwat1",
	[Idstring("units/characters/enemies/swat_kevlar2/swat_kevlar2"):key()] = "BSwat2",
	[Idstring("units/characters/enemies/spooc/spooc"):key()] = "Cloaker",
	[Idstring("units/characters/enemies/taser/taser"):key()] = "Taser",
	[Idstring("units/characters/enemies/shield/shield"):key()] = "Shield",
	[Idstring("units/characters/enemies/tank/tank"):key()] = "BDozer",
	[Idstring("units/characters/enemies/sniper/sniper"):key()] = "Sniper"

};

local UnitBankControl =
{
	WSec1	= true,
	WSec2	= true,

	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

local OnlyPolice = 
{
	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

local UnitPanicRoomControl = 
{
	Gang1	= true,
	Gang2	= true,
	Gang3	= true,
	Gang4	= true,
	Gang5	= true,
	Gang6	= true,
	Dealer	= true,

	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

local UnitSlaughterHouseControl =
{
	WSec1	= true,
	WSec2	= true,
	
	Murky1	= true,
	Murky2	= true,

	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

local UnitSecretStashControl =
{
	Gang1	= true,
	Gang2	= true,

	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

local UnitHospitalControl =
{
	WSec1	= true,
	WSec2	= true,
	RSec	= true,	

	Cop1 	= true,
	Cop2	= true,
	Cop3	= true,
	Fbi1	= true,
	Fbi2	= true,
	Fbi3	= true,
	Swat1	= true,
	Swat2	= true,
	Swat3	= true,
	BSwat1	= true,
	BSwat2	= true,
	Cloaker	= true,
	Taser	= true,
	Shield	= true,
	BDozer	= true,
	Sniper	= true
};

local InvMapStruct =
{
	["bank"] = UnitBankControl,
	["heat_street"] = OnlyPolice,
	["bridge"]	= OnlyPolice,
	["apartment"] = UnitPanicRoomControl,
	["slaughter_house"] = UnitSlaughterHouseControl,
	["diamond_heist"]	= UnitHospitalControl,
	["suburbia"]		= OnlyPolice,
	["secret_stash"]	= UnitSecretStashControl,
	["hospital"]		= UnitHospitalControl
};
------------------------
-- Protect Functions --

-- Math.random intervals Protector 
local function MathRandomProtect( Interval1, Interval2 )
	if Interval1 <= Interval2 then
		return true;
	else
		return false;
	end
end

------------------------
-- MutatorIndex functions
------------------------

local function CreateMutatorMap( MIndex )
	local MutatorLimMin = 1;
	local MutatorLimMax = 10;
	
	local Map = Global.level_data.level_id;
	local MMap = {};
	
	if not XSpawnCFG.MutatorIsActive then
		for k, v in pairs( InvMapStruct[ Map ] ) do
			MMap[ k ] = { 1, 1 };
		end
	else
		for key, value in pairs( InvMapStruct[ Map ] ) do
			if MIndex[ key ] then
				if MathRandomProtect( MIndex[ key ][1], MIndex[ key ][2] ) then
					if MIndex[ key ][1] >= MutatorLimMin and MIndex[ key ][2] <= MutatorLimMax then
						MMap[key] = MIndex[ key ];
					else
						MMap[key] = { 1, 1 };
					end
				else
					MMap[key] = { 1, 1 };
				end
			else
				MMap[ key ] = { 1, 1 };
			end	
		end
	end
	
	return MMap;
end
if not XSpawnCFG.MutatorIsActive then
	function CheckMutatorUnit( EnInterval, FactPoint )
		return 1;
	end
else
	function CheckMutatorUnit( EnInterval, FactPoint )

		if FactPoint == Idstring("units/characters/enemies/sniper/sniper"):key() then
			return 1;
		end

		return math.random( EnInterval[1], EnInterval[2] );
	end
end

------------------------
-- Spawn functions --
------------------------
						
local function CreateSpawnMap( SIndex )	-- void --
	if not XSpawnCFG.SpawnIsActive then
		return nil, nil;
	end

	local Map = Global.level_data.level_id;
	local SpawnStruct = {};
	local UnitAmount = {};
	for k, v in pairs( InvMapStruct[ Map ] ) do
		SpawnStruct[ k ] = {};
		UnitAmount[ k ] = 0;
		if SIndex[k] then
			for key, value in pairs( SIndex[ k ] ) do
				if value == true and InvMapStruct[ Map ] [ key ] then
					table.insert( SpawnStruct[ k ], EnemyStruct[ key ] );
					UnitAmount[ k ] = UnitAmount[ k ] + 1;
				end
			end
			
			if #SpawnStruct[ k ] <= 0 then
				table.insert( SpawnStruct[ k ], EnemyStruct[ k ] );
				UnitAmount[ k ] = UnitAmount[ k ] + 1;
			end		
		else
			table.insert( SpawnStruct[ k ], EnemyStruct[ k ] );
			UnitAmount[ k ] = UnitAmount[ k ] + 1;		
		end
	end
	
	return SpawnStruct, UnitAmount;
end

------------------------
EnKey = nil; 

if RequiredScript == "lib/managers/mission/elementspawnenemydummy" then
	local _MutatorTable = CreateMutatorMap( XSpawnCFG.MutatorTable );
	local _SpawnTable, _SpawnUnitAmount	= CreateSpawnMap( SpawnList );
	
	if not XSpawnCFG.SpawnIsActive or not _SpawnUnitAmount or not _SpawnTable then
		function GetSpawnUnit( Unit )
			return Unit;
		end
	else
		function GetSpawnUnit( Unit )
			local Rand = _SpawnUnitAmount[ InvEnemyStruct[Unit:key()] ];
			return _SpawnTable[ InvEnemyStruct[Unit:key()] ][ math.random( 1, Rand ) ];		
		end
	end

	function ElementSpawnEnemyDummy:produce(params)
		local units_spawned = {}
		local EnInterval = {};
		local TargetUnit = nil;
		local Position, ROtation, Action = nil, nil, nil;
		
		if params then
			for _, data in ipairs( params ) do
				TargetUnit = GetSpawnUnit( data.name );
				EnKey = InvEnemyStruct[ TargetUnit:key() ];
				EnInterval = _MutatorTable[ EnKey ];
				Position, ROtation, Action = GetSpawnPoint( { self._values.position, self._values.rotation, self._values.spawn_action, data.name:key(), EnKey } );
				for i = 1, CheckMutatorUnit( EnInterval, data.name:key() ) do
					local unit = safe_spawn_unit( TargetUnit , Position, ROtation );
					unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
					managers.groupai:state():assign_enemy_to_group_ai(unit)
					unit:unit_data().mission_element = self
					self._values.spawn_action = Action;
					local spawn_ai = self:_create_spawn_AI_parametric(data.stance, data.objective, self._values)
					unit:brain():set_spawn_ai(spawn_ai)
					table.insert(self._units, unit)
					table.insert(units_spawned, unit)
					self:event("spawn", unit)
					if self._values.force_pickup and self._values.force_pickup ~= "none" then
						unit:character_damage():set_pickup(self._values.force_pickup)
					end						
				end
			end
		else
			TargetUnit = GetSpawnUnit( self._enemy_name );
			EnKey = InvEnemyStruct[ TargetUnit:key() ];
			EnInterval = _MutatorTable[ EnKey ];		
			Position, ROtation, Action = GetSpawnPoint( { self._values.position, self._values.rotation, self._values.spawn_action, self._enemy_name:key(), EnKey } );
			for i = 1, CheckMutatorUnit( EnInterval, self._enemy_name:key() ) do
				local unit = safe_spawn_unit( TargetUnit , Position, ROtation );
				unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
				unit:unit_data().mission_element = self
				local objective
				self._values.spawn_action = Action;
				local action = self:_create_action_data(self._values)
				if action.type == "act" then
					objective = {
						type = "act",
						action = action,
						stance = "cbt"
					}
				end

				local spawn_ai = {init_state = "idle", objective = objective}
				unit:brain():set_spawn_ai(spawn_ai)
				if self._values.participate_to_group_ai ~= false then
					managers.groupai:state():assign_enemy_to_group_ai(unit)
				end

				table.insert(self._units, unit)
				table.insert(units_spawned, unit)
				self:event("spawn", unit)
				if self._values.force_pickup and self._values.force_pickup ~= "none" then
					unit:character_damage():set_pickup(self._values.force_pickup)
				end				
			end
		end
		return units_spawned
	end
end

if RequiredScript == "lib/tweak_data/groupaitweakdata" then

	local function UnlimUnit( Def )
		if XSpawnCFG.UnlimSpecialUnits then
			return 100;
		else
			return Def;
		end
	end

	function GroupAITweakData:init()
		local is_singleplayer = Global.game_settings and Global.game_settings.single_player
		self:_create_table_structure()
		self:_init_chatter_data()
		self.max_nr_simultaneous_boss_types = 2
		self.difficulty_curve_points = {0.5}
		self.optimal_trade_distance = {0, 0}
		self.bain_assault_praise_limits = {1, 3}
		self.besiege.regroup.duration = {
			120,
			120,
			120
		}
		self.besiege.assault.anticipation_duration = {
			{45, 0.6},
			{35, 0.3},
			{25, 0.1}
		}
		self.besiege.assault.build_duration = 60
		self.besiege.assault.sustain_duration_min = {
			30,
			40,
			120
		}
		self.besiege.assault.sustain_duration_max = {
			40,
			120,
			160
		}
		self.besiege.assault.delay = {
			120,
			80,
			40
		}
			self.besiege.assault.force = {
				25,
				25,
				25
			}

		self.besiege.assault.units = {
			cop = {
				1,
				0,
				0
			},
			swat = {
				0,
				1,
				0.5
			},
			swat_kevlar = {
				0,
				0.5,
				1
			},
			shield = {
				0,
				0.1,
				0.2
			},
			fbi_special = {
				0,
				0.2,
				0.1
			}
		}
		self.besiege.reenforce.interval = {
			2,
			2,
			2
		}
		self.besiege.reenforce.group_size = {
			5,
			5,
			5
		}
		self.besiege.reenforce.units = {
			spooc = {
				1,
				1,
				1
			}
		}
		self.besiege.recon.interval = {
			1,
			1,
			1
		}
			self.besiege.recon.group_size = {
				4,
				4,
				4
			}
			self.besiege.recon.interval_variation = 7

		self.besiege.recon.units = {
			cop = {
				1,
				0,
				0
			},
			fbi = {
				0,
				0.3,
				0.2
			},
			fbi_special = {
				0,
				0.1,
				0.3
			}
		}
		self.besiege.rescue.interval = {
			10,
			10,
			10
		}
		self.besiege.rescue.interval_variation = 2
		self.besiege.rescue.group_size = {
			2,
			2,
			2
		}
		self.besiege.rescue.units = {
			cop = {
				1,
				0,
				0
			},
			swat = {
				0,
				0.5,
				0.1
			},
			fbi = {
				0,
				0.5,
				0
			},
			fbi_special = {
				0,
				0.1,
				0.1
			}
		}
		self.street.regroup.duration = {
			120,
			120,
			120
		}
		self.street.assault.anticipation_duration = {
			{45, 0.6},
			{35, 0.3},
			{25, 0.1}
		}
		self.street.assault.build_duration = 25
		self.street.assault.sustain_duration_min = {
			30,
			50,
			70
		}
		self.street.assault.sustain_duration_max = {
			40,
			60,
			80
		}
		self.street.assault.delay = {
			120,
			80,
			40
		}
			self.street.assault.force.aggressive = {
				20,
				23,
				25
			}

		self.street.assault.force.defensive = {
			5,
			2,
			0
		}
		self.street.assault.units = {
			cop = {
				1,
				0,
				0
			},
			swat = {
				0,
				1,
				0.5
			},
			swat_kevlar = {
				0,
				0.3,
				1
			},
			shield = {
				0,
				0.1,
				0.2
			}
		}
		self.street.blockade.min_distance = 1500
		self.street.blockade.anticipation_duration = {
			{45, 0.6},
			{35, 0.3},
			{25, 0.1}
		}
		self.street.blockade.build_duration = 5
		self.street.blockade.sustain_duration_min = {
			30,
			50,
			70
		}
		self.street.blockade.sustain_duration_max = {
			40,
			60,
			80
		}
		self.street.blockade.delay = {
			120,
			100,
			80
		}
			self.street.blockade.force.defend = {
				9,
				9,
				9
			}
			self.street.blockade.force.frontal = {
				15,
				15,
				15
			}

		self.street.blockade.units = {
			defend = {
				cop = {
					1,
					0,
					0
				},
				swat = {
					0,
					1,
					0.3
				}
			},
			frontal = {
				cop = {
					1,
					0,
					0
				},
				swat = {
					0,
					1,
					0.3
				},
				swat_kevlar = {
					0,
					0.5,
					1
				},
				shield = {
					0,
					0.1,
					0.5
				}
			},
			flank = {
				spooc = {
					1,
					1,
					1
				},
				taser = {
					1,
					1,
					1
				},
				fbi_special = {
					0.001,
					0.001,
					0.001
				}
			}
		}
		self.street.capture.force = 0
		self.street.capture.units = {
			cop = {
				1,
				0,
				0
			},
			swat = {
				0,
				1,
				0.5
			},
			swat_kevlar = {
				0,
				0.5,
				1
			},
			fbi_special = {
				0,
				0.2,
				0.1
			}
		}
		local access_type_walk_only = {"walk"}
		local access_type_all = {"walk", "acrobatic"}
		self.unit_categories = {
			security = {
				units = {
					Idstring("units/characters/enemies/security/security_guard_01"),
					Idstring("units/characters/enemies/security/security_guard_02")
				},
				access = access_type_all
			},
			cop = {
				units = {
					Idstring("units/characters/enemies/cop/cop"),
					Idstring("units/characters/enemies/cop2/cop2"),
					Idstring("units/characters/enemies/cop3/cop3")
				},
				access = access_type_all
			},
			fbi = {
				units = {
					Idstring("units/characters/enemies/fbi1/fbi1"),
					Idstring("units/characters/enemies/fbi2/fbi2"),
					Idstring("units/characters/enemies/fbi3/fbi3")
				},
				access = access_type_all
			},
			fbi_special = {
				units = {
					Idstring("units/characters/enemies/fbi2/fbi2")
				},
				access = access_type_all
			},
			swat = {
				units = {
					Idstring("units/characters/enemies/swat/swat"),
					Idstring("units/characters/enemies/swat2/swat2"),
					Idstring("units/characters/enemies/swat3/swat3")
				},
				access = access_type_all
			},
			swat_kevlar = {
				units = {
					Idstring("units/characters/enemies/swat_kevlar1/swat_kevlar1"),
					Idstring("units/characters/enemies/swat_kevlar2/swat_kevlar2")
				},
				access = access_type_all
			},
			tank = {
				units = {
					Idstring("units/characters/enemies/tank/tank")
				},
				access = access_type_all,
				max_amount = UnlimUnit( 1 ),
				special_type = "tank"
			},
			shield = {
				units = {
					Idstring("units/characters/enemies/shield/shield")
				},
				access = access_type_all,
				max_amount = UnlimUnit( 2 ),
				special_type = "shield"
			},
			spooc = {
				units = {
					Idstring("units/characters/enemies/spooc/spooc")
				},
				access = access_type_all,
				max_amount = UnlimUnit( 2 ),
				special_type = "spooc"
			},
			taser = {
				units = {
					Idstring("units/characters/enemies/taser/taser")
				},
				access = access_type_all,
				max_amount = UnlimUnit( 2 ),
				special_type = "taser"
			},
			sniper = {
				units = {
					Idstring("units/characters/enemies/sniper/sniper")
				},
				access = access_type_all
			}
		}
	end


	if XSpawnCFG.EnableOVK145Params then
		
		function GroupAITweakData:_set_overkill_145()
			self.difficulty_curve_points = {0.1}
			self.max_nr_simultaneous_boss_types = 4
			self.besiege.assault.build_duration = 30
			self.besiege.assault.sustain_duration_min = {
				200,
				360,
				400
			}
			self.besiege.assault.sustain_duration_max = {
				200,
				360,
				400
			}
			self.besiege.assault.delay = {
				15,
				15,
				15
			}
			self.besiege.assault.units = {
				swat = {
					0,
					0,
					0
				},
				swat_kevlar = {
					1,
					1,
					0.1
				},
				shield = {
					0.5,
					0.7,
					0.7
				},
				tank = {
					0,
					0.1,
					0.2
				},
				spooc = {
					0.2,
					0.7,
					1
				},
				taser = {
					0.05,
					0.35,
					0.45
				}
			}
				self.besiege.assault.force = {
					25,
					35,
					35
				}

			self.besiege.recon.interval = {
				50000,
				50000,
				50000
			}
			self.besiege.recon.group_size = {
				0,
				0,
				0
			}
			self.besiege.recon.interval_variation = 0
			self.street.assault.build_duration = 35
			self.street.assault.sustain_duration_min = {
				60,
				120,
				160
			}
			self.street.assault.sustain_duration_max = {
				60,
				120,
				160
			}
			self.street.assault.delay = {
				30,
				30,
				30
			}
			self.street.assault.units = {
				swat = {
					0,
					0,
					0
				},
				swat_kevlar = {
					0,
					1,
					0.1
				},
				shield = {
					0.2,
					0.5,
					0.7
				},
				tank = {
					0,
					0.1,
					0.2
				},
				spooc = {
					0.2,
					0.7,
					1
				},
				taser = {
					0.05,
					0.35,
					0.45
				}
			}
			self.street.blockade.units = {
				defend = {
					swat = {
						1,
						0.5,
						0.5
					},
					swat_kevlar = {
						0.4,
						1,
						1
					},
					shield = {
						0.1,
						0.2,
						0.3
					}
				},
				frontal = {
					swat = {
						1,
						0.5,
						0.5
					},
					swat_kevlar = {
						0.2,
						0.5,
						1
					},
					shield = {
						0,
						0.1,
						0.5
					},
					spooc = {
						0.1,
						0.3,
						0.4
					}
				},
				flank = {
					spooc = {
						1,
						1,
						1
					},
					taser = {
						1,
						1,
						1
					},
					fbi_special = {
						0.001,
						0.001,
						0.001
					}
				}
			}
		end

		function GroupAITweakData:_set_overkill()
			self:_set_overkill_145();
		end
		
		function GroupAITweakData:_set_hard()
			self:_set_overkill_145();
		end
		
		function GroupAITweakData:_set_normal()
			self:_set_overkill_145();
		end	

		function GroupAITweakData:_set_easy()
			self:_set_overkill_145();
		end		
		
	end
end

------------------------
	-- Group AI --
------------------------

if RequiredScript == "lib/managers/group_ai_states/groupaistatebase" then

	function GroupAIStateBase:on_enemy_weapons_hot()
		local RadioChatterTime = 1;
		local HostageHintTime  = 2;
		
		if not self._enemy_weapons_hot then
			self._enemy_weapons_hot = true
			self:_call_listeners("enemy_weapons_hot")
			self._radio_clbk = callback(self, self, "_radio_chatter_clbk")
			managers.enemy:add_delayed_clbk("_radio_chatter_clbk", self._radio_clbk, RadioChatterTime  );
			if not self._hstg_hint_clbk then
				self._first_hostage_hint = true
				self._hstg_hint_clbk = callback(self, self, "_hostage_hint_clbk")
				managers.enemy:add_delayed_clbk("_hostage_hint_clbk", self._hstg_hint_clbk, HostageHintTime  );
			end
		end
	end
	
	function GroupAIStateBase:_try_use_task_spawn_event(t, target_area, task_type, target_pos, force)
		local mvec3_dis = mvector3.distance
		target_pos = target_pos or managers.navigation._nav_segments[target_area].pos
		self._spawn_events = self._spawn_events or {}
		for _, event_data in pairs(self._spawn_events) do
			if event_data.task_type == task_type or event_data.task_type == "any" then
				local dis = mvec3_dis(target_pos, event_data.pos)
				if 3000 >= dis then
					if force or math.random() < event_data.chance then
						self._anticipated_police_force = self._anticipated_police_force + event_data.amount
						self._police_force = self._police_force + event_data.amount
						self:_use_spawn_event(event_data)
						return
					else
						event_data.chance = math.min(1, event_data.chance + event_data.chance_inc)
					end
				end
			end
		end
	end	
end

if RequiredScript == "lib/managers/mission/elementspecialobjective" then
	function ElementSpecialObjective:nav_link_delay()
		return 0.01;
	end
end

if RequiredScript == "lib/managers/group_ai_states/groupaistatebesiege" then

	if XSpawnCFG.UpSpawnInterval then
		function SpawnIntervalControl()
			return 0.2
		end
	else
		function SpawnIntervalControl()
			return nil;
		end
	end

	function GroupAIStateBesiege:_queue_police_upd_task()
		self._police_upd_task_queued = true
		managers.enemy:queue_task("GroupAIStateBesiege._upd_police_activity", GroupAIStateBesiege._upd_police_activity, self, 0.1 );
	end
	
	function GroupAIStateBesiege:_map_spawn_points_to_respective_areas(id, spawn_points)
		local all_areas = self._area_data
		local nav_manager = managers.navigation
		local t = self._t
		for _, new_spawn_point in ipairs(spawn_points) do
			local pos = new_spawn_point:value("position")
			local interval = SpawnIntervalControl() or new_spawn_point:value("interval");
			local amount = new_spawn_point:value("amount")
			local nav_seg = nav_manager:get_nav_seg_from_pos(pos, true)
			local accessibility = new_spawn_point:value("accessibility")
			local new_spawn_point_data = {
				id = id,
				pos = pos,
				nav_seg = nav_seg,
				spawn_point = new_spawn_point,
				amount = amount > 0 and amount,
				interval = interval,
				delay_t = -1,
				accessibility = accessibility ~= "any" and accessibility
			}
			local area_data = all_areas[nav_seg]
			local area_spawn_points = area_data.spawn_points
			if area_spawn_points then
				table.insert(area_spawn_points, new_spawn_point_data)
			else
				area_spawn_points = {new_spawn_point_data}
				area_data.spawn_points = area_spawn_points
			end
		end
	end
end

if RequiredScript == "lib/managers/group_ai_states/groupaistatestreet" then
	function GroupAIStateStreet:_spawn_cops_with_objective(area, spawn_points, objective, unit_weights)
		if XSpawnCFG.UpSpawnInterval then
			for k,v in pairs(spawn_points) do
				if v.interval and type(v.interval) == "number" and v.interval > 0 then
					spawn_points[k].interval = 0.2;
				end
			end			
		end
	
		local produce_data = {
			{
				name = true,
				spawn_ai = {}
			}
		}
		for i_sp = 1, #spawn_points do
			local sp_data = spawn_points[i_sp]
			local spawn_point = sp_data.spawn_point
			local accessibility = sp_data.accessibility
			local unit_name = self:_get_spawn_unit_name(unit_weights, accessibility)
			if unit_name then
				produce_data[1].name = unit_name
				local sp_data = spawn_points[i_sp]
				local spawn_point = sp_data.spawn_point
				local spawned_enemy = spawn_point:produce(produce_data)[1]
				sp_data.delay_t = sp_data.interval
				local u_key = spawned_enemy:key()
				self:_set_enemy_assigned(self._area_data[area], u_key)
				if spawned_enemy:brain():objective() then
					spawned_enemy:brain():set_followup_objective(deep_clone(objective))
				else
					spawned_enemy:brain():set_objective(deep_clone(objective))
				end
			end
		end
	end	

	function GroupAIStateStreet:_spawn_cops_with_objectives(spawn_points, objectives, unit_weights, spawned_units)
		if XSpawnCFG.UpSpawnInterval then
			for k,v in pairs(spawn_points) do
				if v.interval and type(v.interval) == "number" and v.interval > 0 then
					spawn_points[k].interval = 0.2;
				end
			end
		end
		
		local produce_data = {
			{
				name = true,
				spawn_ai = {}
			}
		}
		local nr_spawns = math.min(#spawn_points, #objectives)
		for i_sp = 1, nr_spawns do
			local sp_data = spawn_points[i_sp]
			local accessibility = sp_data.accessibility
			local unit_name = self:_get_spawn_unit_name(unit_weights, accessibility)
			if unit_name then
				produce_data[1].name = unit_name
				local spawn_point = sp_data.spawn_point
				local spawned_enemy = spawn_point:produce(produce_data)[1]
				sp_data.delay_t = sp_data.interval
				local u_key = spawned_enemy:key()
				self:_set_enemy_assigned(self._area_data[objectives[i_sp].nav_seg], u_key)
				if spawned_enemy:brain():objective() then
					spawned_enemy:brain():set_followup_objective(objectives[i_sp])
				else
					spawned_enemy:brain():set_objective(objectives[i_sp])
				end

				if spawned_units then
					table.insert(spawned_units, spawned_enemy)
				end
			end
		end
	end
end

------------------------
-- Weapon functions --
------------------------
local WeaponStruct = 
{
	Beretta92 = Idstring("units/weapons/beretta92_npc/beretta92_npc"),
	C45 	  = Idstring("units/weapons/c45_npc/c45_npc"),
	Bronco	  = Idstring("units/weapons/raging_bull_npc/raging_bull_npc"),	
	Mp5 	  = Idstring("units/weapons/mp5_npc/mp5_npc"),
	Mac11 	  = Idstring("units/weapons/mac11_npc/mac11_npc"),
	Brenner   = Idstring("units/weapons/hk21_npc/hk21_npc"),
	M4 		  = Idstring("units/weapons/m4_rifle_npc/m4_rifle_npc"),	
	Ak47	  = Idstring("units/weapons/ak47_npc/ak47_npc"),
	M308	  = Idstring("units/weapons/m14_npc/m14_npc"),
	Locom	  = Idstring("units/weapons/mossberg_npc/mossberg_npc"),	
	R870 	  = Idstring("units/weapons/r870_shotgun_npc/r870_shotgun_npc"),
	RSniper	  = Idstring("units/weapons/sniper_rifle_npc/sniper_rifle_npc"),
	SHRifle	  = Idstring("units/weapons/shield_pistol_npc/shield_pistol_npc")
};

local WeaponShieldControl =
{
	Beretta92 = true,
	C45 	  = true,
	Bronco	  = true,	
	Mp5 	  = true,
	Mac11 	  = true,
	Brenner   = true,
	M4 		  = true,	
	Ak47	  = true,
	M308	  = true,
	Locom	  = true,	
	R870 	  = true,
	RSniper	  = true,
	SHRifle	  = true
};

local WeaponSpecialControl =
{
	Brenner   = true,
	M4 		  = true,	
	Ak47	  = true,
	M308	  = true,
	RSniper	  = true
};

local WeaponDefControl =
{
	Beretta92 = true,
	C45 	  = true,
	Bronco	  = true,	
	Mp5 	  = true,
	Mac11 	  = true,
	Brenner   = true,
	M4 		  = true,	
	Ak47	  = true,
	M308	  = true,
	Locom	  = true,	
	R870 	  = true,
	RSniper	  = true
};

local EnemyWeaponStruct =
{
	["WSec1"]	= WeaponDefControl,
	["WSec2"]	= WeaponDefControl,
	["RSec"]	= WeaponDefControl,
	
	["Gang1"]	= WeaponDefControl,
	["Gang2"]	= WeaponDefControl,
	["Gang3"]	= WeaponDefControl,
	["Gang4"]	= WeaponDefControl,
	["Gang5"]	= WeaponDefControl,
	["Gang6"]	= WeaponDefControl,
	["Dealer"]	= WeaponDefControl,
	
	["Murky1"]	= WeaponDefControl,
	["Murky2"]	= WeaponDefControl,
	
	["Cop1"]	= WeaponDefControl,
	["Cop2"]	= WeaponDefControl,
	["Cop3"]	= WeaponDefControl,
	["Fbi1"]	= WeaponDefControl,
	["Fbi2"]	= WeaponDefControl,
	["Fbi3"]	= WeaponDefControl,
	["Swat1"]	= WeaponDefControl,
	["Swat2"]	= WeaponDefControl,
	["Swat3"]	= WeaponDefControl,	
	["BSwat1"]	= WeaponDefControl,
	["BSwat2"]	= WeaponDefControl,
	["Cloaker"]	= WeaponDefControl,
	["Taser"]	= WeaponSpecialControl,
	["Shield"]	= WeaponShieldControl,
	["BDozer"]	= WeaponDefControl,
	["Sniper"]	= WeaponSpecialControl
};

local EnemyDefWeapons =
{
	["WSec1"]	= WeaponStruct.C45,
	["WSec2"]	= WeaponStruct.C45,
	["RSec"]	= WeaponStruct.Mp5,
	
	["Gang1"]	= WeaponStruct.Mac11,
	["Gang2"]	= WeaponStruct.Mac11,
	["Gang3"]	= WeaponStruct.Mac11,
	["Gang4"]	= WeaponStruct.Mac11,
	["Gang5"]	= WeaponStruct.Mac11,
	["Gang6"]	= WeaponStruct.Mac11,
	["Dealer"]	= WeaponStruct.Mac11,
	
	["Murky1"]	= WeaponStruct.M4,
	["Murky2"]	= WeaponStruct.M4,
	
	["Cop1"]	= WeaponStruct.R870,
	["Cop2"]	= WeaponStruct.C45,
	["Cop3"]	= WeaponStruct.R870,
	["Fbi1"]	= WeaponStruct.C45,
	["Fbi2"]	= WeaponStruct.Beretta92,
	["Fbi3"]	= WeaponStruct.C45,
	["Swat1"]	= WeaponStruct.Mp5,
	["Swat2"]	= WeaponStruct.M4,
	["Swat3"]	= WeaponStruct.R870,	
	["BSwat1"]	= WeaponStruct.M4,
	["BSwat2"]	= WeaponStruct.R870,
	["Cloaker"]	= WeaponStruct.Mp5,
	["Taser"]	= WeaponStruct.M4,
	["Shield"]	= WeaponStruct.SHRifle,
	["BDozer"]	= WeaponStruct.R870,
	["Sniper"]	= WeaponStruct.RSniper
};

if RequiredScript == "lib/units/enemies/cop/copbase" then
local WeaponSpawnStruct = {};
local WStructAmount = {};	
	
	if XSpawnCFG.ChangeWeapons then	
		for Unit, WControl in pairs( EnemyWeaponStruct ) do
			WeaponSpawnStruct[ Unit ] = {};
			WStructAmount[ Unit ] = 0;
			for WKey, Control in pairs( WControl ) do
				if Control and WeaponList[ Unit ][ WKey ] then
					table.insert( WeaponSpawnStruct[ Unit ], WeaponStruct[ WKey ] );
					WStructAmount[ Unit ] = WStructAmount[ Unit ] + 1;
				end
			end
			
			if #WeaponSpawnStruct[ Unit ] <= 0 then				
				table.insert( WeaponSpawnStruct[ Unit ], EnemyDefWeapons[ Unit ] );
				WStructAmount[ Unit ] = WStructAmount[ Unit ] + 1;
			end
		end
	else
		return;
	end
	
	function CopBase:default_weapon_name()
		return WeaponSpawnStruct[ EnKey ][ math.random( 1, WStructAmount[ EnKey ] ) ];
	end
end