-- Counterfeit script 
-- Version : --
-- Author : AnXZ
-- Rus Description:
-- Кучу триггеров перелопатил, прописал новую Energy логику, и много чего ещё.
-- 

function WarmodCFTOpenDrop( MissionScriptObject )
	managers.mission:scripts()["default"]:elements()[102421]:on_executed();
	managers.mission:scripts()["default"]:elements()[102423]:on_executed();
	managers.mission:scripts()["default"]:elements()[102425]:on_executed();
	
	-- debug осмотр электричества
	-- managers.mission:scripts()["default"]:elements()[102044]:on_executed();
	-- managers.mission:scripts()["default"]:elements()[100380]:on_executed();	
	-- managers.mission:scripts()["default"]:elements()[100318]:on_executed();
	
	return true;
end


math.randomseed( os.time() );

function WarmodCFTapAC4(  )
	local VB = managers.dlc:GetVarBase();
	local Taps = { 101510, 101465, 101458, 101457 };
	local EnergySockets = { 101567, 100658 };
	local Elements = managers.mission:scripts()["default"]:elements();
	
	if WarmodCFG.EnableUniqueEvents then
		if EventList.Counterfeit.DefC4 then
			-- Defuse C4
			Elements[101136]:on_executed();
			
			for _,unit in pairs(World:find_units_quick('all', 1)) do
				if unit:name():key() == Idstring("units/world/props/moneyprinter/money_printed"):key() then
					if CheckVector( unit:position(), Vector3(-4300, 3215, -572) ) or
					   CheckVector( unit:position(), Vector3(-4292, 3388, -574.4990234375) ) or
					   CheckVector( unit:position(), Vector3(-4474, 3394, -572) ) or
					   CheckVector( unit:position(), Vector3(-4479, 3289, -572) ) then
						World:delete_unit( unit );
					end
				end
			end			
		else
			-- Normalise random
			Elements[102099]._values.difficulty_hard = true;
			Elements[102099]._values.difficulty_easy = true;
			Elements[102099]._values.difficulty_normal = true;
			Elements[102099]:on_executed();
		end
		
		if EventList.Counterfeit.AllReels then
			VB:Set("TapController", 0 );
			VB:Set("BainHOSEVoice", 0 );
			
			-- Нормализация финальных шлангов
			Elements[101943]._values.enabled = false;
			Elements[101942]._values.enabled = false;
			Elements[100692]._values.enabled = false;
			Elements[102447]._values.enabled = false;
			Elements[100282]._values.enabled = false;
			Elements[102464]._values.enabled = false;
			
			
			-- Reels
			local ReelsAmount = CheckVarInterval( EventList.Counterfeit.ReelsAmount, 1, 4, 1 );
			local TapsAmount = #Taps;
			local Random = 0;
			local ActualTaps = {};
			for z = 1, ReelsAmount do	
				Random = Taps[ math.random( 1, TapsAmount - ( z - 1 ) ) ];
				-- Балансировку шлангов проводить лишь с этой веткой.
				Elements[ Random ]._values.enabled = true;
				Elements[ Random ]:on_executed();
				table.insert( ActualTaps, Random );
				table.delete( Taps, Random );
				Random = 0;
			end
			VB:Set( "ActualTaps", ActualTaps ); -- для определения катушек
			-- Короче, Написал Varbase class, беру из него какую-то структуру через метод, ну то есть получается копия формально.
			-- А эта копия, ни*** не копия: это оригинал! И тем самым, думая что работаешь с копией, ты модифицируешь копию,
			-- Но ***ть, эта копия модифицирует и оригинал, я вообще не вдупляю что происходит здесь.
			-- Как может обычная структура, выведенная копией из класса, модифицировать оригинальные данные внутри класса? 0_0.
			-- Используем альтернативный вариант, и идём лечить свою психику от испытанного.
		else
			-- Reels random normalise
			Elements[101617]._values.difficulty_hard = true;
			Elements[101617]._values.difficulty_easy = true;
			Elements[101617]._values.difficulty_normal = true;
			Elements[101617]:on_executed();
		end
		

		if EventList.Counterfeit.ComplexEnergy then
			rawset( _G, "WarmodNewEnergyCFT", false );
			_G.WarmodNewEnergyCFT = EnergyController:new();
		
			local SocketAmount = CheckVarInterval( EventList.Counterfeit.SocketAmount, 1, 2, 1 );
			VB:Set( "SocketAmount", 0 );
			VB:Set( "CFGSocketAmount", SocketAmount );
			Elements[100563]._values.amount = 2;
			Elements[100563]:on_executed();
			for i = 1, 2 do
				Elements[ EnergySockets[i] ]._values.enabled = false;			
			end
			local Random = 0;
			local EnergySocketsI = #EnergySockets;
			for z = 1, SocketAmount do
				Random = EnergySockets[ math.random( 1, EnergySocketsI - ( z - 1 ) ) ];
				Elements[Random]._values.enabled = true;
				table.delete( EnergySockets, Random );
				Random = 0;
			end
		else
			Elements[100563]:on_executed();
		end
		
		return false;
	end
	
	return true;
end

function WarmodCFTExpWarn()
	managers.dlc:GetVarBase():Set("ExplosionCheck", true );
	return true;
end

function WarmodCFSocketController()
	local VB = managers.dlc:GetVarBase();
	local SocketAmount = VB:Get( "SocketAmount" );
	SocketAmount = SocketAmount + 1;
	VB:Set( "SocketAmount", SocketAmount );
	if SocketAmount >= VB:Get( "CFGSocketAmount" ) then
		return true;
	else
		return false;
	end
end

function WarmodCFTKatController()
	local Elements = managers.mission:scripts()["default"]:elements();
	local Kats =
	{
		[101510] = { 101321, 101284 },
		[101465] = { 100852, 101281 },
		[101458] = { 101452, 101313 }, -- 102439 -> 101452 // Исправил <3
		[101457] = { 101450, 101256 }
	}
	local Taps =
	{
		[101510] = 101449,
		[101465] = 101448,
		[101458] = 101444,
		[101457] = 101443
	};
	local HoseFX =
	{
		[101510] = 102079,
		[101465] = 102084,
		[101458] = 102074,
		[101457] = 100770	
	};
	local KatConnectors =
	{
		[101510] = { 101943, 101943 },
		[101465] = { 101942, 101942 },
		[101458] = { 102447, 100692 },
		[101457] = { 102464, 100282 }
	}	
	local TapsCheck =
	{
		[101510] = false,
		[101465] = false,
		[101458] = false,
		[101457] = false	
	};
	local KatData = managers.dlc:GetVarBase():Get( "ActualTaps" );
	local Explosion = managers.dlc:GetVarBase():Get("ExplosionCheck");
	local State = 1;
	if not Explosion then
		State = 1;
	else
		State = 2;
	end	
	local KatDataI = #KatData;
	for z = 1, KatDataI do
		local Random = KatData[ math.random( 1, KatDataI - ( z - 1 ) ) ];
		Elements[Kats[Random][1]]._values.enabled = true;
		Elements[Kats[Random][2]]._values.enabled = true;
		Elements[Kats[Random][1]]:on_executed();
		Elements[Kats[Random][2]]:on_executed();
		Elements[ KatConnectors[ Random ][ State ] ]._values.enabled = true;	
		TapsCheck[Random] = true;
		table.delete( KatData, Random );
		Random = 0;
	end
	for k, v in pairs( TapsCheck ) do
		if not v then
			Elements[ Taps[k] ]._values.enabled = false;
			Elements[ HoseFX[k] ]._values.enabled = false;
		end
	end
	return false;
end

-- function WarmodCFTTapController()
	-- local Elements = managers.mission:scripts()["default"]:elements();
	-- local Taps =
	-- {
		-- [101510] = 101449,
		-- [101465] = 101448,
		-- [101458] = 101444,
		-- [101457] = 101443
	-- };
	-- local KatData = managers.dlc:GetVarBase():Get( "ActualTaps" );
	-- local KatDataI = #KatData;
	-- for z = 1, KatDataI do
		-- local Random = KatData[ math.random( 1, KatDataI - ( z - 1 ) ) ];
		-- Elements[Taps[Random]]._values.enabled = true;
		-- Elements[Taps[Random]]:on_executed();
		-- table.delete( KatData, Random );
		-- Random = 0;
	-- end	
	-- return false;
-- end

function WarmodCFTBainVoice()
	local Incrim = managers.dlc:GetVarBase():Get("BainHOSEVoice");
	Incrim = Incrim + 1;
	managers.dlc:GetVarBase():Inc("BainHOSEVoice");
	if Incrim == CheckVarInterval( EventList.Counterfeit.ReelsAmount, 1, 4, 1 ) then	
		managers.mission:scripts()["default"]:elements()[100483]._values.enabled = true;
		managers.mission:scripts()["default"]:elements()[100483]:on_executed();
		return false;
	end
	return true;
end

function WarmodCFTCheckTapI()
	if managers.dlc:GetVarBase():Get("TapController") == CheckVarInterval( EventList.Counterfeit.ReelsAmount, 1, 4, 1 ) then
		return true;
	else
		return false;
	end
end

function WarmodCFTInteractGD()
	managers.dlc:GetVarBase():Inc("TapController");
	managers.mission:scripts()["default"]:elements()[101322]._values.enabled = true;
	managers.mission:scripts()["default"]:elements()[101322]:on_executed();
	return true;
end

function WarmodCFTInteractGC()
	managers.dlc:GetVarBase():Inc("TapController");
	managers.mission:scripts()["default"]:elements()[101151]._values.enabled = true;
	managers.mission:scripts()["default"]:elements()[101151]:on_executed();
	return true;
end

function WarmodCFTInteractGB()
	managers.dlc:GetVarBase():Inc("TapController");
	managers.mission:scripts()["default"]:elements()[101314]._values.enabled = true;
	managers.mission:scripts()["default"]:elements()[101314]:on_executed();
	return true;
end

function WarmodCFTInteractGA()
	managers.dlc:GetVarBase():Inc("TapController");
	managers.mission:scripts()["default"]:elements()[101258]._values.enabled = true;
	managers.mission:scripts()["default"]:elements()[101258]:on_executed();
	return true;
end

------------------------
-- Energy Boxes --
------------------------

function WarmodCFBoxController()
	WarmodNewEnergyCFT:DisableEnergy();
	return true;
end

function WarmodCFTETransformer()
	WarmodNewEnergyCFT:OFFTBox();
	return false;
end

function WarmodCFTEA()
	WarmodNewEnergyCFT:OFFABox();
	return false;
end

function WarmodCFTEB()
	WarmodNewEnergyCFT:OFFBBox();
	return false;
end

function WarmodCTFETransformInteract()
	WarmodNewEnergyCFT:ONTBox();
	return false;
end

function WarmodCTFEA1Interact()
	WarmodNewEnergyCFT:ONABox( 1 );
	return false;
end

function WarmodCTFEA2Interact()
	WarmodNewEnergyCFT:ONABox( 2 );
	return false;
end

function WarmodCTFEA3Interact()
	WarmodNewEnergyCFT:ONABox( 3 );
	return false;
end

function WarmodCTFEB1Interact()
	WarmodNewEnergyCFT:ONBBox( 1 );
	return false;
end	

function WarmodCTFEB2Interact()
	WarmodNewEnergyCFT:ONBBox( 2 );
	return false;
end

function WarmodCTFEB3Interact()
	WarmodNewEnergyCFT:ONBBox( 3 );
	return false;
end