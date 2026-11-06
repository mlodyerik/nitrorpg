local markersFactionPanel={
	{"SAPD", 1, 4609.49, 379.71, 5392.20},
	{"SARA", 1, 3898.52, -713.82, 76.41},	
    {"SAFD", 1, 1717.8, -1787, 13.59,0,0},
	{"TAXI", 1, 3725.34, -207.87, 242.80,60,60},
}

for i,v in ipairs(markersFactionPanel) do
	local marker=createMarker(v[3], v[4], v[5]-1, "cylinder", 1.5, 255, 255, 0, 55)
	setElementData(marker,"marker:id",tonumber(v[2]))
	setElementInterior(marker, (v[6] or 0))
	setElementDimension(marker, (v[7] or 0))
	setElementData(marker,"marker:faction",v[1])
	setElementData(marker,"marker:text","FRAKCJA - "..v[1].."\nZARZĄDZANIE")
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
	if not md or getElementType(el) ~= "player" then return end
	local faction=getElementData(source,"marker:faction")
	if not faction then return end
	local uid=getElementData(el,"player:sid")
	if not uid then return end
	--if not getElementData(el,"player:faction") then exports.nrpg_interface:showPlayerNotification(el, "Wejdź na służbę", "error") return end
	if getElementData(el,"player:faction") ~= faction then exports.nrpg_interface:showPlayerNotification(el, "Nie jesteś na służbie lub nie pracujesz tutaj", "error") return end
    local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;", faction, uid) -- pobieramy tylko JEDEN rekord
	if result and #result > 0 then
		--if result[1].rank ~= 1 then exports.nrpg_interface:showPlayerNotification(el, "Brak uprawnień", "error") return end
	local resulted=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE faction=?", faction)
		triggerClientEvent(el, "showGuiFaction", resourceRoot,faction, resulted)
	end
end)

addEvent("ev",true)
addEventHandler("ev",resourceRoot, function(ev,arg1,arg2)
		player_uid = getElementData(client, "player:sid")

		local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(client, "player:sid"))
		if result[1].register_serial ~= getPlayerSerial(client) then
			return outputChatBox("✘ #ffffffW związku z zmianą numeru seryjnego MTA ta opcja jest zablokowana, jeśli chcesz ją odblokować wejdź na nasz teamspeak3: nitrorpg - Strefa pomocy.", client, 255, 0, 0,true)
		end

	if (ev=="degradeUserOrganization") then	
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_factions` WHERE uid="..tonumber(player_uid).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<11) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
			
		local check1=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_factions` WHERE uid="..tonumber(arg1).." LIMIT 1")
			if not check1 or not check1.rank then return end
				check1.rank=tonumber(check1.rank)
			if (check1.rank<2) then
				exports.nrpg_interface:showPlayerNotification(client, "Użytkownik osiągnął najniższą rangę", "error")
			return end
			
		local query=exports["nrpg_db"]:dbSet("UPDATE `pystories_factions` SET rank=rank-1 WHERE `uid`=?", arg1)
		exports.nrpg_interface:showPlayerNotification(client, 'Pomyślnie zdegradowano gracza', 'success')
	
	elseif (ev=="advanceUserOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_factions` WHERE uid="..tonumber(player_uid).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<11) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
			
		local check1=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_factions` WHERE uid="..tonumber(arg1).." LIMIT 1")
			if not check1 or not check1.rank then return end
				check1.rank=tonumber(check1.rank)
			if (check1.rank>10) then
				exports.nrpg_interface:showPlayerNotification(client, "Użytkownik osiągnął najwyższą rangę", "error")
			return end
			
		local query=exports["nrpg_db"]:dbSet("UPDATE `pystories_factions` SET rank=rank+1 WHERE `uid`=?", arg1)
		exports.nrpg_interface:showPlayerNotification(client, 'Pomyślnie awansowano gracza', 'success')
		
	elseif (ev=="removeUserOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_factions` WHERE uid="..tonumber(player_uid).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<11) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end	
		local query1=exports["nrpg_db"]:dbSet("DELETE FROM pystories_factions WHERE uid=?",arg1)
		exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie usunieto gracza z frakcji.", "success")
		
	elseif (ev=="addUserOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_factions` WHERE uid="..tonumber(player_uid).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<11) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
		local check1=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", arg1)
		if not check1 or #check1 < 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik nie istnieje w bazie danych", "error") return end
		local check2=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE uid=? and faction=?", arg1, arg2)
		if check2 and #check2 > 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik już znajduje się w tej frakcji.", "error") return end
		local check3=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE uid=?", arg1)
		if check3 and #check3 > 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik już znajduje się w innej frakcji.", "error") return end
		outputDebugString(check1[1].login.." (UID: "..arg1..") dodany do frakcji "..arg2.."")
		local query1=exports["nrpg_db"]:dbSet("INSERT pystories_factions (uid,faction,nick,actived) VALUES (?,?,?,now())",arg1, arg2, check1[1].login)
		if query1 then
		local resulted=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE faction=?", arg2)
			exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie dodano gracza (UID: "..arg1..") do frakcji.", "success")
		end
	end
end)

addEvent("showGuiFractionsPanel", true)
addEventHandler("showGuiFractionsPanel", root, function()
	local faction=getElementData(client,"player:faction")
	if not faction then return end
	local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE faction=?", faction)
	triggerClientEvent(client, "showGuiFractionsPanelClient", client, check)
end)

addEvent("selectUserFaction", true)
addEventHandler("selectUserFaction", root, function(uid)
	local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE uid=?", uid)
	if #check > 0 then
		triggerClientEvent(client, "selectUserFactionClient", client, check)
		for i, v in ipairs(getElementsByType("player")) do
			if check.uid == getElementData(v, "player:sid") then
				triggerClientEvent(client, "selectUserOrganizationClient", client, check.uid)
			end
		end
	end
end)