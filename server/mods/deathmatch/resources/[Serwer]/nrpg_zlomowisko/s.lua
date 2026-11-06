addEvent("ev",true)
addEventHandler("ev",resourceRoot, function(ev,arg1,arg2)			
	if (ev=="recycling") then	
		local vehicles = getPedOccupiedVehicle(arg1)
		local uid = getElementData(vehicles, "vehicle:id")
		local owner = getElementData(vehicles, "vehicle:ownedPlayer")
		local p_uid = getElementData(arg1, "player:sid")
		local serial = getPlayerSerial(arg1)
		if uid and owner and owner == p_uid then
			givePlayerMoney(arg1, arg2)
			outputChatBox("✓#ffffff Pomyślnie zezłomowano pojazd, otrzymujesz "..arg2.." PLN! (ID: "..uid..", Model: "..getElementModel(vehicles)..")", arg1, 0, 255, 0, true)
			destroyElement(vehicles)
			exports["nrpg_db"]:dbSet('update pystories_vehicles set ownedPlayer=?, parking=?, ownedGroup=? where id=?', 1, 1,'', uid)
		else
			exports.nrpg_interface:showPlayerNotification(arg1, "Nie możesz zezłomować tego pojazdu", "error")
		end
	end
end)