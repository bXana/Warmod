local TargetVectors =
{
	Vector3( 491, 1276, 773),
	Vector3( 801, 1385, 827),
	Vector3( 487, 966, 1099),
	Vector3( 489, 963, 1423),
	Vector3( 491, 1274, 1423),
	Vector3( 490, 118, 1424),	
	Vector3( 488, 120, 1099)
};

function WarmodPRFix()
	local Vector = nil;
	for _, unit in pairs(World:find_units_quick('all', 1)) do
		if unit:name():key() == "61a8213c6f063610" then
			Vector = unit:position();
			for _, VectorX in ipairs( TargetVectors ) do
				if CheckVector( Vector, VectorX ) then
					DamageMelee( unit );
					break;				
				end
			end
		end
	end
	return true;
end