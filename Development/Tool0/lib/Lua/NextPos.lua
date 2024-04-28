if GlobalIndex == #RXKCOORDS then
	GlobalIndex = 1;
	MidText( GlobalIndex, "changed", 0.2 );
	return
end

if #RXKCOORDS == 0 then
	GlobalIndex = 1;
	MidText( GlobalIndex, "changed", 0.2 );
	return
end

GlobalIndex = GlobalIndex + 1;

MidText( GlobalIndex, "changed", 0.2 );