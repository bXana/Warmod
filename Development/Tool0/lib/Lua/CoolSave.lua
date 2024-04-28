		local XPOS = RXKCOORDS[GlobalIndex][1].x;
		local YPOS = RXKCOORDS[GlobalIndex][1].y;
		local ZPOS = RXKCOORDS[GlobalIndex][1].z;
		
		local XROT = RXKCOORDS[GlobalIndex][2]:x();
		local YROT = RXKCOORDS[GlobalIndex][2]:y();
		local ZROT = RXKCOORDS[GlobalIndex][2]:z();
		
		local Action = RXKCOORDS[GlobalIndex][3];

File = io.open("RxkCoords.txt", "ab");
			local Z = {};
			Z.XPOS = XPOS;
			Z.YPOS = YPOS;
			Z.ZPOS = ZPOS;
			
			Z.XROT = XROT;
			Z.YROT = YROT;
			Z.ZROT = ZROT;
			Z.Action = Action;
File:write("{ " .. "Vector3( " .. Z.XPOS .. ", " .. Z.YPOS .. ", " .. Z.ZPOS .. " ), Rotation( " .. Z.XROT .. ", " .. Z.YROT .. ", " .. Z.ZROT .. "), \"" .. Z.Action .. "\" },\n");
File:close();

MidText("saved", "vector", 0.2 );