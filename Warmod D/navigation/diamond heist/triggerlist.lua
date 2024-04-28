
local HashData =
{
	["f7ebaa73018f84ac"] = true,
	["b4115032a2c6901c"] = true,
	["cca578ef05249641"] = true,
	["23d1c65959875f7a"] = true
};

local TargetVectors =
{
	Vector3( -875, 1503, 375),
	Vector3( -3400, -5405, 375.80899047852),
	Vector3( -3200, -5405, 375.80899047852),
	Vector3( -2600, -5405, 375.80899047852),
	Vector3( -5172, -4481.7001953125, 1523.01953125),
	Vector3( -5172, -4674.8798828125, 1574.7802734375),
	Vector3( -4872, -4481.7001953125, 1523.01953125),
	Vector3( -4872, -4674.8798828125, 1574.7802734375),
	Vector3( -3400, -5404, 775.80902099609),
	Vector3( -3200, -5404, 775.80902099609),
	Vector3( -2600, -5404, 775.80902099609),
	Vector3( 4, -3049, 775),
	Vector3( 4, -2649, 775),
	Vector3( 4, -2649, 775),
	Vector3( 4, -1824, 775),
	Vector3( 4, -1624, 775),
	Vector3( 5, -824, 775),
	Vector3( 5, -24, 775),
	Vector3( 5, 776, 775),
	Vector3( -525, 1504, 775),
	Vector3( -1075, 1504, 775),
	Vector3( -1675, 1504, 775),
	Vector3( -2225, 1504, 775),
	Vector3( -10, -2499, 375),
	Vector3( 4, -1624, 375),
	Vector3( 4, -824, 375),
	Vector3( 4, -24, 375),
	Vector3( 4, 776, 375),
	Vector3( -525, 1505, 375),
	Vector3( -875, 1503, 375),
	Vector3( -875, 1503, 375),
	Vector3( -1675, 1504, 375),
	Vector3( -2225, 1504, 375),
	Vector3( -6603, -2825, 375),
	Vector3( -6603, -2425, 375),
	Vector3( -6603, -1625, 375),
	Vector3( -6603, -825, 375),
	Vector3( -6603, -25, 375),
	Vector3( -6603, 775, 375),
	Vector3( -6475.0004882813, 1504, 375),
	Vector3( -5925.0004882813, 1504, 375),
	Vector3( -5325.0004882813, 1504, 375),
	Vector3( -4775.0004882813, 1504, 375),
	Vector3( -5325.0004882813, 1504, 775),
	Vector3( -5925.0004882813, 1504, 775),
	Vector3( -6475.0004882813, 1504, 775),
	Vector3( -6603, 775, 775),
	Vector3( -6603, -25, 775),
	Vector3( -6603, -825, 775),
	Vector3( -6603, -1298, 775),
	Vector3( -6603, -2425, 775),
	Vector3( -6603, -2625, 775)
};

function WarmodDHFix()
	local Vector = nil;
--	for _, script in pairs(managers.mission:scripts()) do
--		for id, element in pairs(script:elements()) do
--			for _, trigger in pairs(element:values().trigger_list or {}) do
--				if id == 101789 and trigger.notify_unit_sequence == "open" then
--					element:on_executed()
--				end
--			end
--		end
--	end
	
	for _,unit in pairs(World:find_units_quick('all', 1)) do
		if HashData[ unit:name():key() ] then
			for key, value in ipairs( TargetVectors ) do
				Vector = unit:position();
				if CheckVector( value, Vector ) then
					DamageMelee( unit );
					break;
				end
			end
		end
	end
	


	managers.mission:scripts()["default"]:elements()[101789]:on_executed();
	managers.mission:scripts()["default"]:elements()[101789]._values.enabled = false;
	return true;
end

function WarmodDHLasersDown()
	managers.mission:scripts()["default"]:elements()[100774]._values.enabled = true;
	managers.mission:scripts()["default"]:elements()[100774]:on_executed();
	return true;
end

function WarmodDHGenSecUp()

--	managers.mission:scripts()["default"]:elements()[101064]._values.enabled = true; -- вырезанные охранники.
	managers.mission:scripts()["default"]:elements()[102329]._values.difficulty_easy = true;
	managers.mission:scripts()["default"]:elements()[102329]._values.difficulty_normal = true;
	managers.mission:scripts()["default"]:elements()[102329]._values.difficulty_hard = true;
	managers.mission:scripts()["default"]:elements()[102329]._values.difficulty_overkill = true;
	return true;
end

function WarmodDHAntiCode()
	managers.mission:scripts()["default"]:elements()[100290]:on_executed();
	return false;
end

function WarmodDHUpCop()
	managers.groupai:state():AddForceOffset( WarmodEscapeOffset() );
	return true;
end