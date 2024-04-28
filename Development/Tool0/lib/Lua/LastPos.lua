if GlobalIndex == 1 then
	--GlobalIndex = #RXKCOORDS;
	
	if #RXKCOORDS == 0 then
		GlobalIndex = 1;
	else
		GlobalIndex = #RXKCOORDS;
	end
	MidText( GlobalIndex, "changed", 0.2 );
	return
end

GlobalIndex = GlobalIndex - 1;

MidText( GlobalIndex, "changed", 0.2 );

