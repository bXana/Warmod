WarmodSpecialTriggers =
{
	["bank"] =
	{
		-- Активация задачи "Зайти в банк"
		-- Делаю некоторые правки в начале через функцию
		["func_objective_001"] =
		{
			true, -- Всегда работает
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankFix;
				return OBJECT;
			end
		},
		-- взрыв по банку
		["logic_random_001"] =
		{
			true,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankDamage;
				return OBJECT;
			end			
		},
		["func_dropin_state_001"] =
		{
			true,
			function ( OBJECT )
				OBJECT._values.enabled = false;
				return OBJECT;
			end				
		},

	-------------------------------------------------------------
	-------------------------------------------------------------
	-------------------------------------------------------------

		
		-- Охранники в банке, вызываем все 12
		["ai_enemy_group_guards"] =
		{
			EventList.Bank.SecurityAtEntrace  and WarmodCFG.EnableUniqueEvents ,
			function ( OBJECT )
				OBJECT._values.amount = 12;
				OBJECT.PreFunction[1] = WarmodBankUGOE;
				return OBJECT;
			end
		},
		-- Снайпера на выходе
		["logic_random_008"] =
		{
			EventList.Bank.HeavySniperCover and WarmodCFG.EnableUniqueEvents ,
			function ( OBJECT )
				OBJECT._values.amount = CheckVarInterval( EventList.Bank.StreetSniperCount, 2, 4, 2 );
				return OBJECT;
			end
		},
		-- Снайпера напротив дрели
		["logic_random_004"] =
		{
			EventList.Bank.HeavySniperCover and WarmodCFG.EnableUniqueEvents ,
			function ( OBJECT )
				OBJECT._values.amount = CheckVarInterval( EventList.Bank.DrillSniperCount, 2, 4, 2 );
				return OBJECT;
			end		
		},
		-- Снайпер на крыше
		["logic_link_082"] =
		{
			EventList.Bank.HeavySniperCover and WarmodCFG.EnableUniqueEvents ,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankSniperFlank;
				return OBJECT;
			end				
		},
		-- Снайпера встречают игроков после хранилища
		["func_objective_011"] =
		{
			EventList.Bank.HeavySniperCover and WarmodCFG.EnableUniqueEvents ,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankSniperFlank;
				return OBJECT;
			end			
		},
		-- Активируем 4 компа
		["logic_random_016"] =
		{
			EventList.Bank.ActivateAllPC and WarmodCFG.EnableUniqueEvents,
			function( OBJECT )
				OBJECT._values.amount = CheckVarInterval( EventList.Bank.PCAmount, 1, 4, 1 );
				return OBJECT;
			end
		},
		-- Требуем 4 компа
		["logic_counter_030"] =
		{
			EventList.Bank.ActivateAllPC and WarmodCFG.EnableUniqueEvents,
			function( OBJECT )
				OBJECT._values.counter_target = CheckVarInterval( EventList.Bank.PCAmount, 1, 4, 1 );
				return OBJECT;
			end		
		},
		-- Бульдозеры в хранилище на всех сложностях
		["tank_suprise_in_vault"] =
		{
			EventList.Bank.BulldozersInVault and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.difficulty_easy = true;
				OBJECT._values.difficulty_normal = true;
				OBJECT._values.difficulty_hard	= true;
				OBJECT._values.difficulty_overkill = true;
				return OBJECT;
			end
		},
		-- 5 бульдозеров в хранилище
		["logic_random_039"] =
		{
			EventList.Bank.BulldozersInVault and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = CheckVarInterval( EventList.Bank.BDZAmountInVault, 4, 5, 4 );
				return OBJECT;
			end
		},
		["logic_link_024"] =
		{
			EventList.Bank.BulldozersInVault and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankBDZWarn;
				return OBJECT;
			end		
		},
		-- cloaker suprise
		["logic_random_038"] =
		{
			EventList.Bank.CloakerSuprise and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = 4;
				return OBJECT;
			end	
		},
		-- cloaker suprise 100%
		["logic_chance_018"] =
		{
			EventList.Bank.CloakerSuprise and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.chance = 100;
				OBJECT._chance		  = 100;
				return OBJECT;
			end			
		},
		-- cloaker suprise all diffs
		["logic_filter_002"] =
		{
			EventList.Bank.CloakerSuprise and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.difficulty_easy = true;
				OBJECT._values.difficulty_normal = true;
				OBJECT._values.difficulty_hard	= true;
				OBJECT._values.difficulty_overkill = true;
				return OBJECT;
			end
		},
		-- stair ambush on all diffs
		["logic_filter_001"] =
		{
			EventList.Bank.TasersOnStairs and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.difficulty_easy = true;
				OBJECT._values.difficulty_normal = true;
				OBJECT._values.difficulty_hard	= true;
				OBJECT._values.difficulty_overkill = true;
				return OBJECT;
			end			
		},
		-- После взрыва, первая засада
		["logic_link_028"] =
		{
			EventList.Bank.CopEscapeAmbush and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankAmbush;
				return OBJECT;
			end
		},
		-- Last escape ambush
		["func_diff_level_check_023"] =
		{
			EventList.Bank.EscapeLastAmbush and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.difficulty = "easy";
				return OBJECT;
			end 
		},
		["logic_random_036"] =
		{
			EventList.Bank.EscapeLastAmbush and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = 4;
				return OBJECT;
			end 		
		},
		["logic_chance_002"] =
		{
			EventList.Bank.EscapeLastAmbush and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.chance = 100;
				OBJECT._chance		  = 100;
				return OBJECT;
			end 		
		},
		["logic_random_022"] =
		{
			EventList.Bank.EscapeLastAmbush and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = 5;
				return OBJECT;
			end 		
		},
		-- fucking bank guards
		["logic_link_176"] =
		{
			EventList.Bank.SecurityInHallV and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodBankGuardsInHallV;
				return OBJECT;
			end 			
		},
		-- Охранники в зале хранилища
		["ai_enemy_group_guards_in_vault"] =
		{
			EventList.Bank.SecurityInHallV and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = 10;
				return OBJECT;
			end 		
		}
	},
	["diamond_heist"] =
	{
		-- Охранники
		["logic_link_022_patrols"] =
		{
			EventList.DiamondHeist.ManyGenSec and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodDHGenSecUp;
				return OBJECT;
			end
		},
		-- Alarm box
		["logic_random_001"] =
		{
			WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = CheckVarInterval( EventList.DiamondHeist.AlarmBoxCount, 3, 7, 3 );
				return OBJECT;
			end
		},
		["logic_counter_003"] =
		{
			WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.counter_target = CheckVarInterval( EventList.DiamondHeist.AlarmBoxCount, 3, 7, 3 );
				return OBJECT;
			end		
		},
		--- Ломаем коды от двери
		["kill_first_time_codes_on_145"] =
		{
			true,
			function( Object )
				Object._values.enabled = false
				return Object;
			end		
		},
		["logic_random_029"] =
		{
			true,
			function( Object )
				Object.PreFunction[1] = WarmodDHAntiCode;
				return Object;
			end				
		},
		["logic_chance_001"] =
		{
			true,
			function( Object )
				Object._values.chance = 0
				Object._chance 		  = 0
				return Object;
			end			
		},
		["logic_chance_operator_001"] =
		{
			true,
			function( Object )
				Object._values.enabled = false
				return Object;
			end			
		},
		["logic_filter_004"] =
		{
			true,
			function( Object )
				Object._values.enabled = false
				return Object;
			end		
		},
		-- ["point_play_sound_018_party_music_stop"] =
		-- {
			-- EventList.DiamondHeist.SaveMusic and WarmodCFG.EnableUniqueEvents,
			-- function( Object )
				-- Object._values.enabled = false
				-- return Object;
			-- end			
		-- },
		-- ["func_sequence_202_kill_party_lghts"] =
		-- {
			-- EventList.DiamondHeist.SavePartyLights and WarmodCFG.EnableUniqueEvents,
			-- function( Object )
				-- Object._values.enabled = false
				-- return Object;
			-- end			
		-- },
		["partypoooper"] =
		{
			EventList.DiamondHeist.SaveParty and WarmodCFG.EnableUniqueEvents,
			function( Object )
				Object._values.enabled = false
				return Object;
			end			
		},
		-- in the vault
		["trigger_area_062_vault_wp_area"] =
		{
			true,
			function( OBJECT )
				OBJECT.PreFunction[1] = WarmodDHUpCop;				
				return OBJECT;
			end
		},
		["alarm_on"] =
		{
			true,
			function( Object )
				Object._values.enabled = true
				Object.PreFunction[1] = WarmodDHFix;
				return Object;
			end			
		},
		["func_sequence_067_deactivate_lasers"] =
		{
			true,
			function( Object )
				Object._values.enabled = false
				return Object;
			end			
		},
		["func_sequence_033"] =
		{
			true,
			function( Object )
				Object.PreFunction[1] = WarmodDHLasersDown;
				return Object;
			end			
		}		
	},
	["apartment"] =
	{
		-- Блокировка снайпер сквадов
		["sniper"] =
		{
			WarmodCFG.EnableUniqueCopLogic or WarmodCFG.EnableUniqueSpawn,
			function ( OBJECT )
				OBJECT._values.ImportantUnit = true;
				return OBJECT;
			end
		},
		-- panic room
		["trigger_area_001"] =
		{
			true,
			function( Object )
				Object.PreFunction[1] = WarmodPRFix;
				
				return Object;
			end			
		}		
	},	
	["suburbia"] =
	{
		["logic_counter_004"] =
		{
			true, -- 
			function (OBJECT)
				OBJECT.PreFunction[1] = WarmodCFTOpenDrop;
				return OBJECT;
			end
		},
		-- Спавн гражданских все варианты
		["logic_random_025"] =
		{
			EventList.Counterfeit.ManyCivs and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 3;
				return OBJECT;
			end
		},
		["logic_random_026"] =
		{
			EventList.Counterfeit.ManyCivs and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 2;
				return OBJECT;
			end
		},
		["logic_random_036"] =
		{
			EventList.Counterfeit.ManyCivs and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 2;
				return OBJECT;
			end
		},		
		["logic_random_027"] =
		{
			EventList.Counterfeit.ManyCivs and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 4;
				return OBJECT;
			end		
		},
		-----------------------------------------------------------------------------
		-- Катушки и c4
		["logic_link_042"] =
		{
			true, -- в prefunction ветка определяет, будет ли работать или нет
			function (OBJECT)
				OBJECT.PreFunction[1] = WarmodCFTapAC4;
				return OBJECT;
			end
		},
		-- Нормализация катушек
		["logic_toggle_009"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		["logic_toggle_012"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		["logic_toggle_024"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		["logic_toggle_023"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end		
		},
		-- Трансформаторы
		["logic_random_015"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 3;
				return OBJECT;
			end
		},
		-- Боксы
		["random a cb spawner"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 3;
				return OBJECT;
			end		
		},
		["random b cb spawner"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.amount = 3;
				return OBJECT;
			end		
		},
		--- Теперь нормализуем каждый Energy бокс отдельно
		["off a1 a2"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end
		},
		["off a2 a3"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end		
		},
		["off a1 a3"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		["off b1 b2"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		["off b1 b3"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end		
		},
		["off b2 b3"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end		
		},
		["off 1 2"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		["off 1 3"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end		
		},
		["off 2 3"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end			
		},
		-- Розетки
		["off"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				if OBJECT._id == 100564 or
				   OBJECT._id == 100994 then
				   OBJECT._values.enabled = false;
				end
				return OBJECT;
			end
		},
		["drill power on"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFSocketController; -- Розетки
				return OBJECT;
			end
		},
		["obj m4 end complete power"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFBoxController; -- Боксы
				return OBJECT;
			end				
		},
		-- Включаем доступные катушки
		["logic_random_012"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT.PreFunction[1] = WarmodCFTKatController;
				return OBJECT;
			end
		},
		-- взрыв 
		["logic_link_030"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT.PreFunction[1] = WarmodCFTExpWarn;
				return OBJECT;
			end		
		},
		-- Счётчик катушек и дрели
		["ball a5"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				if OBJECT._id == 100510 then
					-- Должно быть + 1
					OBJECT._values.counter_target = CheckVarInterval( EventList.Counterfeit.ReelsAmount, 1, 4, 1 ) + 1;
				end
				return OBJECT;
			end 
		},
		-- Бейн голосовой
		["cft_ban_60x"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end
		},
		["obj m4 end hose"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function (OBJECT)
				OBJECT._values.enabled = false;
				return OBJECT;
			end		
		},
		-- вырезано
		["cft_ban_106x"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFTBainVoice;
				return OBJECT;
			end
		},
		-- краны
		["logic_random_011"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT._values.amount = CheckVarInterval( EventList.Counterfeit.ReelsAmount, 1, 4, 1 );
				return OBJECT;
			end			
		},
		["obj m5 end start water"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFTCheckTapI;
				return OBJECT;
			end				
		},
		["interact garden tap d"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFTInteractGD;
				return OBJECT;
			end			
		},
		["interact garden tap c"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFTInteractGC;
				return OBJECT;
			end			
		},
		["interact garden tap b"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFTInteractGB;
				return OBJECT;
			end			
		},
		["interact garden tap a"] =
		{
			EventList.Counterfeit.AllReels and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				OBJECT.PreFunction[1] = WarmodCFTInteractGA;
				return OBJECT;
			end			
		},
		---------------------------------------------------------------
		--- Energy Modify ---
		["anim_start"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
				if OBJECT._id == 100565 then
					OBJECT.PreFunction[1] = WarmodCFTETransformer;
				elseif OBJECT._id == 100215 then
					OBJECT.PreFunction[1] = WarmodCFTEA;
				elseif OBJECT._id == 101214 then
					OBJECT.PreFunction[1] = WarmodCFTEB;
				end
				return OBJECT;
			end 
		},
		["all tb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFETransformInteract;
				return OBJECT;
			end
		},
		["a1 cb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFEA1Interact;
				return OBJECT;
			end		
		},
		["a2 cb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFEA2Interact;
				return OBJECT;
			end		
		},
		["a3 cb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFEA3Interact;
				return OBJECT;
			end		
		},
		["b1 cb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFEB1Interact;
				return OBJECT;
			end		
		},
		["b2 cb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFEB2Interact;
				return OBJECT;
			end		
		},
		["b3 cb interact"] =
		{
			EventList.Counterfeit.ComplexEnergy and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT.PreFunction[1] = WarmodCTFEB3Interact;
				return OBJECT;
			end		
		},
		-- Shield cover --
		["logic_random_049"] =
		{
			EventList.Counterfeit.ShieldCover and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT._values.amount = 3;
				return OBJECT;
			end				
		},
		["logic_random_050"] =
		{
			EventList.Counterfeit.ShieldCover and WarmodCFG.EnableUniqueEvents,
			function ( OBJECT )
			
				OBJECT._values.amount = 3;
				return OBJECT;
			end			
		}
		-- -- плитки побег
		-- -- внутренний двор
		-- ["logic_link_003"] =
		-- {
			-- true,
			
		-- },
		-- -- внешний
		-- ["logic_link_004"] =
		-- {
			-- true,
			
		-- }

	},
	["heat_street"]   	= {},
	["bridge"]			= {},
	["slaughter_house"] = {}, 
	["secret_stash"]	= {},
	["hospital"]		= {} 	
};