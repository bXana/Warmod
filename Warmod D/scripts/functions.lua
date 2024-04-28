--require("warmod/configs/warmodcfg");

-- Thx _Steed
function chat_message(title, text, no_sync)
	if managers.menu then
		local peer = managers.network:session():local_peer()
		local message = string.upper( title or peer:name() ) .. ": " .. text

		managers.menu:relay_chat_message(message, peer:id())
		if not no_sync then
			managers.network:session():send_to_peers("sync_chat_message", message)
		end
	end
end

-- examples:
-- chat_message("LOBBY", "Welcome")                -- LOBBY: Welcome
-- chat_message(nil, "Hello")                      -- ANXZ: Hello
-- chat_message("MOD", "Something happened", true) -- MOD: Something happened (won't be sent to other players)

function Host()
	if not Network then 
		return false; 
	end

	return Network:is_server();
end

function DamageMelee(unit)
    local col_ray = {}
    col_ray.ray = Vector3(1,0,0)
    col_ray.position = unit:position()
    if unit:body(0) and unit:body(0):extension() then
	  col_ray.body = unit:body(0)
	elseif unit:body(1) and unit:body(1):extension() then --White cams, hospital cams
	  col_ray.body = unit:body(1)
	else
	  return
	end
    col_ray.body:extension().damage:damage_melee( unit, col_ray.normal, col_ray.position, col_ray.direction, 10000 )
    managers.network:session():send_to_peers_synched( "sync_body_damage_melee", col_ray.body, unit, col_ray.normal, col_ray.position, col_ray.direction, 10000 )
end


function GetAccess( AccessList )
	local Access = {};
	for _, AccessType in ipairs( AccessList ) do
		for UnitKey, UnitValue in pairs( AccessType ) do
			Access[UnitKey] = UnitValue;
		end
	end
	
	return Access;
end

function CheckVarInterval( Var, MinInterval, MaxInterval, DefVar )
	if Var >= MinInterval and Var <= MaxInterval then
		return Var;
	else
		return DefVar;
	end
end

function AbstrackCheck( NewValue, DefValue, CFG )
	if CFG then
		return NewValue;
	else
		return DefValue;
	end
end

function CheckVector( Vec1, Vec2 )
	if ( Vec1.x == Vec2.x ) and
	   ( Vec1.y == Vec2.y ) and
	   ( Vec1.z == Vec2.z ) then
	   return true;
	end
	
	return false;
end

function WarmodPoliceMinLim()
	return 25;
end

function WarmodPoliceMaxLim()
	return 50;
end

function WarmodEscapeOffset()
	return CheckVarInterval( WarmodCFG.PoliceEscapeAmountOffset, 0, 25, 0 );
end	