if not RXKCOORDS[GlobalIndex][1] then return end

File = io.open("RxkCoordsblacklist.txt", "ab");
File:write("[\"" .. tostring(RXKCOORDS[GlobalIndex][1]) .. "\"] = true,\n");
File:close();

MidText("saved", "bvector", 0.2 );