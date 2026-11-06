local zaproszenia = {}
local max_people_in_org = 50

function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if getElementData(thePlayer,"player:sid") == tonumber(cel) then target = thePlayer end
		end
	else -- podano fragment nicku
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 0, true) then
				if (target) then
					outputChatBox("* Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	if target and getElementData(target,"p:inv") then return nil end
	return target
end

addEvent("ev",true)
addEventHandler("ev",resourceRoot, function(ev,arg1,arg2)			
	if (ev=="amtOperationOrganization") then			
		if arg1 > 0 and arg1 > getPlayerMoney(client) then return end
		local organizationName=getElementData(client,"player:organization")
		if arg1 > 0 then
			if getPlayerMoney(client)<arg1 then return end
			takePlayerMoney(client, arg1)
			local query=exports["nrpg_db"]:dbSet("UPDATE `pystories_organizacje_info` SET kasa=kasa+? WHERE `nazwa`=?", tonumber(arg1), organizationName)
			exports.nrpg_interface:showPlayerNotification(client, "Wpłacono "..(tonumber(arg1) or 0).." PLN do organizacji", "success", 15000)
			exports["nrpg_db"]:dbSet("INSERT INTO logs_atm_org SET uid=?, nick=?, serial=?, ile=?, typ=?, organizacja=?", getElementData(client, "player:sid"), getPlayerName(client):gsub("#%x%x%x%x%x%x",""), getPlayerSerial(client), arg1, "Wplata", organizationName)
			exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje SET wplacil=wplacil+? WHERE uid=?", math.abs(tonumber(arg1)), getElementData(client, "player:sid"))
		elseif arg1 < 0 then
			local check1=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
			--local check1=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` LIMIT 1")
			if not check1 or not check1.rank then return end
			check1.rank=tonumber(check1.rank)
			if (check1.rank<5) then
				exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
				return
			end
			local check=exports["DB2"]:pobierzWyniki("SELECT * FROM `pystories_organizacje_info` WHERE nazwa=? LIMIT 1", organizationName)
			if not check then return end
			srr=tonumber(check.kasa)
			if (srr<math.abs(arg1)) then
				exports.nrpg_interface:showPlayerNotification(client, "Nie posiadasz środków na koncie!", "error", 15000)
				return
			end
			local query_min = exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje_info SET kasa=kasa-? WHERE nazwa=?", math.abs(tonumber(arg1)), organizationName)
			exports.nrpg_interface:showPlayerNotification(client, "Wypłacono "..math.abs(tonumber(arg1)).." PLN z organizacji", "success", 15000)
			givePlayerMoney(client, math.abs(arg1))	
			exports["nrpg_db"]:dbSet("INSERT INTO logs_atm_org SET uid=?, nick=?, serial=?, ile=?, typ=?, organizacja=?", getElementData(client, "player:sid"), getPlayerName(client):gsub("#%x%x%x%x%x%x",""), getPlayerSerial(client), arg1, "Wyplata", organizationName)
		end
	
	elseif (ev=="degradeUserOrganization") then	
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<5) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
			
		local check1=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(arg1).." LIMIT 1")
			if not check1 or not check1.rank then return end
				check1.rank=tonumber(check1.rank)
			if (check1.rank<2) then
				exports.nrpg_interface:showPlayerNotification(client, "Użytkownik osiągnął najniższą rangę", "error")
			return end
			
		local query=exports["nrpg_db"]:dbSet("UPDATE `pystories_organizacje` SET rank=rank-1 WHERE `uid`=?", arg1)
		exports.nrpg_interface:showPlayerNotification(client, 'Pomyślnie zdegradowano gracza', 'success')
	
	elseif (ev=="advanceUserOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<5) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
			
		local check1=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(arg1).." LIMIT 1")
			if not check1 or not check1.rank then return end
				check1.rank=tonumber(check1.rank)
			if (check1.rank>4) then
				exports.nrpg_interface:showPlayerNotification(client, "Użytkownik osiągnął najwyższą rangę", "error")
			return end
			
		local query=exports["nrpg_db"]:dbSet("UPDATE `pystories_organizacje` SET rank=rank+1 WHERE `uid`=?", arg1)
		exports.nrpg_interface:showPlayerNotification(client, 'Pomyślnie awansowano gracza', 'success')
		
	elseif (ev=="removeUserOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<4) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
		
		local query1=exports["nrpg_db"]:dbSet("DELETE FROM pystories_organizacje WHERE uid=?",arg1)
		exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie usunieto gracza z organizacji.", "success")

		local target = findPlayer(client,arg1)
		exports.nrpg_interface:showPlayerNotification(target, "Twoja przynależność w organizacji została zaaktualizowana.", "info",1,10000)
		if target then 
		setElementData(target,"player:organization",false) 
		setElementData(target,"player:organizationtag",false)
		end
		
	elseif (ev=="addUserOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<4) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
		if string.len(arg1) <= 0 then return end
		local check1=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE login=?", arg1)
		if not check1 or #check1 < 0 then outputChatBox("* Podany użytkownik nie istnieje w bazie danych.", client, 255, 0, 0) return end
		local check2=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE login=? and code=?", arg1, arg2)
		if check2 and #check2 > 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik już znajduje się w tej organizacji.", "error") return end
		local check3=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE code=?", arg2)
		if check3 and #check3 >= max_people_in_org then exports.nrpg_interface:showPlayerNotification(client, 'Posiadasz maksymalną ilość osób w organizacji.', 'error') return end
		local check4=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE login=?", arg1)
		if check4 and #check4 > 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik już znajduje się w innej organizacji.", "error") return end
		local target=findPlayer(client,arg1)
		if target then
			if zaproszenia[target] then exports.nrpg_interface:showPlayerNotification(client, 'Gracz już dostał zaproszenie!', 'error') return end
			if zaproszenia[target] and isTimer(zaproszenia[target][3]) then killTimer(zaproszenia[target][3]) end
			zaproszenia[target] = {arg2,client,setTimer(function() zaproszenia[target] = nil end ,10000,1)}
			exports.nrpg_interface:showPlayerNotification(target, "Masz 10 sekund na zaakceptowanie zaproszenia! (Wpisz /akceptuj)", "info")
			exports.nrpg_interface:showPlayerNotification(target, 'Zaproszono cię do organizacji o nazwie: "'..arg2..'"', 'info')
		end
	
	elseif (ev=="lastActived") then
		exports['nrpg_db']:dbSet("UPDATE pystories_organizacje SET aktywny=now() WHERE uid=?", getElementData(client,"player:sid"))
		
	elseif (ev=="addLiderMessageOrganization") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<4) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
		local organizationName=getElementData(client,"player:organization")
		exports['nrpg_db']:dbSet("UPDATE pystories_organizacje_info SET wiadomosc=? WHERE nazwa=?", arg1, organizationName)
		exports.nrpg_interface:showPlayerNotification(client,"Pomyślnie dodano wiadomość.", "success")

	elseif (ev=="changeRankName") then
		local check=exports["DB2"]:pobierzWyniki("SELECT `rank` FROM `pystories_organizacje` WHERE uid="..tonumber(getElementData(client, "player:sid")).." LIMIT 1")
		if not check or not check.rank then return end
		check.rank=tonumber(check.rank)
		if (check.rank<4) then
			exports.nrpg_interface:showPlayerNotification(client, "Brak dostępu do opcji", "error")
		return end
		
		if arg1 == 1 then
			local query1=exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje SET rank_1=? WHERE code=?", arg2, getElementData(client, "player:organization"))
		elseif arg1 == 2 then
			local query1=exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje SET rank_2=? WHERE code=?", arg2, getElementData(client, "player:organization"))
		elseif arg1 == 3 then
			local query1=exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje SET rank_3=? WHERE code=?", arg2, getElementData(client, "player:organization"))
		elseif arg1 == 4 then
			local query1=exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje SET rank_4=? WHERE code=?", arg2, getElementData(client, "player:organization"))
		elseif arg1 == 5 then
			local query1=exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje SET rank_5=? WHERE code=?", arg2, getElementData(client, "player:organization"))
		end
		exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie zmieniono nazwę rangi", "info",1,10000)

	end
end)

addCommandHandler("ustawspawn",function (plr,cmd)
    local uid=getElementData(plr,"player:sid")
    if not uid then return end
    local code=getElementData(plr,"player:organization")
    if not code then exports.nrpg_interface:showPlayerNotification(plr,"Nie jesteś w organizacji.", "error") return end
    local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE uid=? and code=?", uid,code) -- pobieramy tylko JEDEN rekord
    if result and #result > 0 then
        if result[1].rank == 4 then exports.nrpg_interface:showPlayerNotification(plr,"Nie jesteś głównym liderem.", "error") return end
    end
    local int = getElementInterior(plr)
    local dim = getElementDimension(plr)
    local x,y,z = getElementPosition(plr)
    --local query1=exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje_info set spawn=? where nazwa=?", ("%s,%s,%s"):format(x,y,z),code)
	local query1=exports["nrpg_db"]:dbSet("UPDATE `pystories_organizacje_info` SET spawn=? WHERE `nazwa`=?", ("%s,%s,%s,%s,%s"):format(x,y,z,int,dim),code)
    exports.nrpg_interface:showPlayerNotification(plr,"Spawn w twojej organizacji zostal zaaktualizowany.", "info")
end)

addEvent("showGuiOrganization", true)
addEventHandler("showGuiOrganization", root, function()
	local code=getElementData(client,"player:organization")
	if not code then return end
	local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE code=?", code)
	triggerClientEvent(client, "showGuiOrganizationClient", client, check)
end)

addEvent("showGuiOrganizationInfo", true)
addEventHandler("showGuiOrganizationInfo", root, function()
	local code=getElementData(client,"player:organization")
	if not code then return end
	local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje_info WHERE nazwa=?", code)
	triggerClientEvent(client, "showGuiOrganizationInfoClient", client, check)
end)

addEvent("selectUserOrganization", true)
addEventHandler("selectUserOrganization", root, function(uid)
	local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE uid=?", uid)
	if #check > 0 then
		triggerClientEvent(client, "selectUserOrganizationClient", client, check)
		for i, v in ipairs(getElementsByType("player")) do
			if check.uid == getElementData(v, "player:sid") then
				triggerClientEvent(client, "selectUserOrganizationClient", client, check.uid)
			end
		end
	end
end)

addEvent("showVehiclesOrganization", true)
addEventHandler("showVehiclesOrganization", root, function()
	local organizationName = getElementData(client, "player:organization")
	local check = exports["nrpg_db"]:dbGet("SELECT * from pystories_vehicles WHERE ownedGroup=?",organizationName)
	triggerClientEvent(client, "showVehiclesOrganizationClient", client, check)
end)

addEvent("showAtmOperactionOrganization", true)
addEventHandler("showAtmOperactionOrganization", root, function()
	local organizationName = getElementData(client, "player:organization")
	local check = exports["nrpg_db"]:dbGet("SELECT * from logs_atm_org WHERE organizacja=? order by data desc",organizationName)
	triggerClientEvent(client, "showAtmOperactionOrganizationClient", client, check)
end)

addCommandHandler("akceptuj",function (plr,cmd)
	local uid=getElementData(plr,"player:sid")
	if not uid then return end
	if not zaproszenia[plr] then exports.nrpg_interface:showPlayerNotification(plr, "Nie masz zaproszenia do organizacji lub przedawniło się!", "error") return end
	local check1=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", uid)
	if not check1 or #check1 < 0 then outputChatBox("* Nie wczytano twoich danych !", plr, 255, 0, 0) return end 
	local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE uid=? and code=?", uid,  zaproszenia[plr][1])
	if result and #result > 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik już znajduje się w tej organizacji.", "error") return end
	local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE uid=?", uid)
	if result and #result > 0 then exports.nrpg_interface:showPlayerNotification(client, "Podany użytkownik już znajduje się w innej organizacji.", "error") return end
	local query1=exports["nrpg_db"]:dbSet("INSERT pystories_organizacje (uid,login,code,rank) VALUES (?,?,?,1)",uid,check1[1].login, zaproszenia[plr][1])
	if isElement(zaproszenia[plr][2]) then
	if isTimer(zaproszenia[plr][3]) then killTimer(zaproszenia[plr][3]) end
	local resulted=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE code=?", zaproszenia[plr][1])
	exports.nrpg_interface:showPlayerNotification(zaproszenia[plr][2], "Pomyślnie dodano gracza "..check1[1].login.." do organizacji.", "success")
	end
	exports.nrpg_interface:showPlayerNotification(plr, "Zaakceptowano zaproszenie do organizacji o nazwie: "..zaproszenia[plr][1]..". Aby odejść wpisz /opusc", "success")
	setElementData(plr,"player:organization",zaproszenia[plr][1])
	local getTag = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje_info WHERE nazwa=?", zaproszenia[plr][1])
	setElementData(plr,"player:organizationtag",getTag[1].tag)
	exports['nrpg_db']:dbSet("UPDATE pystories_organizacje SET aktywny=now() and rank=1 WHERE uid=?", getElementData(plr,"player:sid"))
	zaproszenia[plr] = nil
end)

function globalMessage(plr, cmd, ...)
	local organization=getElementData(plr,'player:organization')
	if not organization then
		return
	end
	local msg = table.concat ( { ... }, " " )
	local admins=getElementsByType('player')
	for i,v in pairs(admins) do
	local organization1=getElementData(v,'player:organization')
	local rank = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE code=? AND uid=? LIMIT 1;", faction, getElementData(plr,"player:sid")) 
		if organization == organization1 then
			outputChatBox("#747474"..organization1.."#FFFFFF> "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#FFFFFF:#FFFFFF "..msg:gsub("#%x%x%x%x%x%x",""), v,_,_,_,true)
		end
	end
		local desc = "[#747474ORGANIZACJA#ffffff] ["..getElementData(plr,"id").."]"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."("..getElementData(plr,"player:organization").."): "..msg:gsub("#%x%x%x%x%x%x","")..""
		triggerEvent("admin:addText", resourceRoot, desc:gsub("#%x%x%x%x%x%x",""))
		outputServerLog(desc)
end
addCommandHandler("Organizacja", globalMessage)

addCommandHandler("opusc",function (plr,cmd)
	local uid=getElementData(plr,"player:sid")
	if not uid then return end
	local code=getElementData(plr,"player:organization")
	if not code then exports.nrpg_interface:showPlayerNotification(plr, "Nie jesteś w żadnej organizacji", "error") return end
	local query1=exports["nrpg_db"]:dbSet("DELETE FROM pystories_organizacje WHERE uid=? AND code=?",uid, code)
	setElementData(plr,"player:organization",false)	
	setElementData(plr,"player:organizationtag",false)	
	exports.nrpg_interface:showPlayerNotification(plr, "Opuściłeś(aś) organizacje "..code.." !", "info")
end)

addEventHandler("onPlayerJoin", root, function() 
	local players=getElementsByType('player')
	for _, p in pairs(players) do
		bindKey(p, "o", "down", "chatbox", "Organizacja")
	end
end)