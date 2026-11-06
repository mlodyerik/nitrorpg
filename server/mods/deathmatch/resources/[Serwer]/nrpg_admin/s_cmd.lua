function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

-- Settings
function pobierzDate(type,time)
	realTime=getRealTime()
	type=tostring(type)
	time=tonumber(time)
	if time < 0 then return end
	if type == "m" then if time > 59 then return end value1=realTime.minute+time else value1=realTime.minute end
	if type == "h" then if time > 23 then return end value2=realTime.hour+time else value2=realTime.hour end
	if type == "d" then if time > 31 then return end value3=realTime.monthday+time else value3=realTime.monthday end
	if type == "w" then  if time > 11 then return end value4=realTime.month+time else value4=realTime.month end
	if value1 >= 60 then value1 = value1-60; value2=value2+1 end
	if value2 >= 24 then value2 = value2-24; value3=value3+1 end
	if value3 >= 31 then value3 = value3-31; value4=value4+1 end
	date=string.format("%04d-%02d-%02d ", realTime.year+1900, value4+1, value3)
	time=string.format("%02d:%02d:%02d", value2, value1, realTime.second)
	--outputChatBox(date..time,root)
	return date..time
end

addCommandHandler("ddom-1",function(plr,cmd)
if exports['nrpg_admin']:getAdmin(plr,4)  then
local x,y,z = getElementPosition(plr)
local stringe = ("INSERT INTO lss_domy (descr,i,vwe,drzwi,punkt_wyjscia,interiorid,koszt,active) VALUES ('%s',%s,%s,'%s','%s',%s,%s,%s)"):format("Mieszkanie", 0,0,("%.2f,%.2f,%.2f"):format(x,y,z),("%.2f,%.2f,%.2f"):format(x,y,z),8,1000,1)
outputChatBox("* Dodano dom", plr)
exports["nrpg_db"]:dbSet(stringe)
end
end)

addCommandHandler("ddom-2",function(plr,cmd)
if exports['nrpg_admin']:getAdmin(plr,4)  then
local x,y,z = getElementPosition(plr)
local stringe = ("INSERT INTO lss_domy (descr,i,vwe,drzwi,punkt_wyjscia,interiorid,koszt,active) VALUES ('%s',%s,%s,'%s','%s',%s,%s,%s)"):format("Dom", 0,0,("%.2f,%.2f,%.2f"):format(x,y,z),("%.2f,%.2f,%.2f"):format(x,y,z),221,5000,1)
outputChatBox("* Dodano dom", plr)
exports["nrpg_db"]:dbSet(stringe)
end
end)

addCommandHandler("boost", function(plr, cmd)
if getElementData(plr, "player:sid") == 1 or
getElementData(plr, "player:sid") == 2 then
if getPedOccupiedVehicle( plr ) then
local vx,vy,vz=getElementVelocity(getPedOccupiedVehicle( plr ))
setElementVelocity(getPedOccupiedVehicle( plr ),vx*1.6,vy*1.6,vz*1.6)
end
end
end)


addCommandHandler('ac', function(plr,cmd, ...)
	local name = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
	if getElementData(plr,"player:admin") or getPlayerName(plr) == "Wercia" then
	local msg=table.concat({...}, " ")
	if getAdmin(plr, 4) then
		ranga = "#880000"
	elseif getAdmin(plr, 3) then
		ranga = "#ff9600"
  	elseif getAdmin(plr, 2) then
        ranga = "#ff0004"
  	elseif getAdmin(plr, 1) then
		ranga = "#02a000"
	elseif getPlayerName(plr) == "Wercia" then
		ranga = "#ff4fe2"
	end
	for _, p in pairs(getElementsByType('player')) do
		if getAdmin(p) or getPlayerName(p) == "Wercia" then
			outputChatBox("#FFFFFF[#c9c9c9Czat Administracji#ffffff]#ffffff - #c9c9c9("..getElementData(plr,"id")..") "..ranga..""..name.."#FFFFFF: "..msg:gsub("#%x%x%x%x%x%x","").."",p,60,172,120,true)			
		end
	end
	local desc = "#c9c9c9CZAT ADMINISTRACJI#ffffff - [SID: #AAAAAA"..getElementData(plr, "player:sid").."#ffffff] - #c9c9c9("..getElementData(plr,"id")..") "..ranga..""..name.."#FFFFFF: "..msg:gsub("#%x%x%x%x%x%x","")..""
	triggerEvent("admin:addText", resourceRoot, desc)
	outputServerLog(desc:gsub("#%x%x%x%x%x%x",""))
end
end)

addCommandHandler("odblokuj", function(plr,cmd,uid,serial)
	if not serial or not tonumber(uid) then 
		exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /odblokuj [SID] [Serial]", "info")
	return end

	if getAdmin(plr, 3) or getAdmin(plr, 4) then
	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", uid)
	if result and #result > 0 then
		local query = exports["nrpg_db"]:dbSet("UPDATE pystories_users SET register_serial=? WHERE id=?", serial, uid)
		exports.nrpg_interface:showPlayerNotification(plr, "Odblokowano konto gracza o SID "..tonumber(uid).." - Serial: "..serial.."", "success")
	end
end
end)

function zmienSloty(player, command, ilosc)
	if getAdmin(player, 4) then
		if tonumber(ilosc) then
			setMaxPlayers(ilosc)
			exports.nrpg_interface:showPlayerNotification(player, "Zmieniasz ilość slotów na: "..ilosc..".", "success")
			triggerClientEvent("reloadSlots", root, ilosc)
		end
	end
end
addCommandHandler("sloty", zmienSloty)

addCommandHandler("zmienpassy", function(plr,cmd,uid,haslo)
	if not haslo or not tonumber(uid) then return end

	if getAdmin(plr, 4) then
	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", uid)
	if result and #result > 0 then
		local query = exports["nrpg_db"]:dbSet("UPDATE pystories_users SET changedpw=1 WHERE id=?", uid)
		local query = exports["nrpg_db"]:dbSet("UPDATE pystories_users SET pass=? WHERE id=?", teaEncode(haslo,"jebaniidioci"), uid)
		exports.nrpg_interface:showPlayerNotification(plr, "Zmieniono hasło gracza o UID "..tonumber(uid).." na "..haslo.."", "success")
	end
end
end)

addCommandHandler("clear.rapsy", function(plr) 
    if getAdmin(plr, 4) then
    exports["nrpg_db"]:dbSet("UPDATE pystories_admins SET reporty=0")
    exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie wyczyszcono reporty każdemu członkowi z administracji.", "success")
    end
end)

addCommandHandler("vopis", function(plr,cmd,...)
	if not getAdmin(plr,4) then outputChatBox("* Brak uprawnień do użycia tej komendy!", plr) return end
	local desc=table.concat(arg, " ")
	local veh=getPedOccupiedVehicle(plr)
	if not veh then
		exports.nrpg_interface:showPlayerNotification(plr, "Musisz siedzieć w pojeździe którego opis chcesz zmienić.", "error")
		return
	end
	if getElementData(veh, "vehicle:desc") then
		setElementData(veh, "vehicle:desc", false)
	return end
	if string.len(desc) < 2 then
		exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /vopis [opis min. 2 znaki]", "info")
		return
	end

	descc=string.format("%s", desc)
	setElementData(veh,"vehicle:desc",descc)
end)


addCommandHandler("a", function(plr,cmd,...)
	if getAdmin(plr,4) then
		local text=table.concat({...}, " ")
		outputChatBox(">> "..text.." - "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 136, 0, 0, true)
	elseif getAdmin(plr,3) then 
		local text=table.concat({...}, " ")
		outputChatBox(">> "..text.." - "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 255, 150, 0, true)	
	elseif getAdmin(plr,2) then 
		local text=table.concat({...}, " ")
		outputChatBox(">> "..text.." - "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 255, 0, 4, true)
	elseif getAdmin(plr,1) then 
		local text=table.concat({...}, " ")
		outputChatBox(">> "..text.." - "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), root, 2, 160, 0, true)
	end
end)

function preventCommandSpam(...)
	text=table.concat({...}, ' ')
	if ... == "Zmniejsz" or ... == "say" or ... == "pm" or ... == "migacz" or ... == "inv" or ... == "ranga" or ... == "organizacja" or ... == "migacze" or ... == "boost" or ... == "admin" or ... == "ucho" or ... == "refreshall" or ... == "refresh" or ... == "stop" or ... == "start" or ... == "dajkase" or ... == "Zwieksz" or ... == "op" or ... == "ogloszenie" or ... == "report" or ... == "repair" or ... == "v" or ... == "admin" or ... == "admins" or ... == "logs" then return end
	local desc = "#00FF60"..getPlayerName(source):gsub("#%x%x%x%x%x%x","").." #ffffffwpisał/a komendę #FF8300"..text.."#ffffff"
	local desc2 = "**"..getPlayerName(source):gsub("#%x%x%x%x%x%x","").."** wpisał/a komendę **"..text.."**"
	exports['nrpg_discord']:connectWeb(desc2, "Komendy")
	triggerEvent("admin:addText", resourceRoot, desc)
	outputServerLog(desc:gsub("#%x%x%x%x%x%x",""))  
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)

addCommandHandler("losuj", function(plr,cmd,...)
	if getAdmin(plr,4) then
		local text = table.concat({...}, " ")
		outputChatBox(" ", root, 255, 255, 0, true)
		outputChatBox("ⓘ #ffffff"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." rozpoczyna losowanie o #F6FF00"..text.."#ffffff", root, 255, 255, 0, true)
		outputChatBox(" ", root, 255, 255, 0, true)

		local losowanieWin = getRandomPlayer()
		setTimer( function()
			if getElementData(losowanieWin, "player:sid") then
				outputChatBox(" ", root, 255, 255, 0, true)
				outputChatBox("ⓘ #ffffffGracz #F6FF00"..getPlayerName(losowanieWin):gsub("#%x%x%x%x%x%x","").."#ffffff wygrywa losowanie i zgarnia #F6FF00"..text.."#ffffff", root, 255, 255, 0, true)
				outputChatBox(" ", root, 255, 255, 0, true)
			else
				local losowanieWin = getRandomPlayer()
				if getElementData(losowanieWin, "player:sid") then
				outputChatBox(" ", root, 255, 255, 0, true)
				outputChatBox("ⓘ #ffffffGracz #F6FF00"..getPlayerName(losowanieWin):gsub("#%x%x%x%x%x%x","").."#ffffff wygrywa losowanie i zgarnia #F6FF00"..text.."#ffffff", root, 255, 255, 0, true)
				outputChatBox(" ", root, 255, 255, 0, true)
				end
			end
		end, 5000, 1)
	end
end)

addCommandHandler("au", function(plr,cmd,typ,...)
	if getAdmin(plr,4) then
		local text=table.concat({...}, " ")
		outputChatBox("ⓘ Aktualizacja:#ffffff  "..text.."", root, 255, 255, 0, true)
		outputServerLog('Chat /au - [Właściciel]: '..text:gsub("#%x%x%x%x%x%x","")..' - '..getPlayerName(plr):gsub('#%x%x%x%x%x%x',''))
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_aktualizacje (dodal,typ,aktualizacja) VALUES (?,?,?)", getPlayerName(plr):gsub('#%x%x%x%x%x%x',''), typ, text)
	end
end)

addCommandHandler("schowaj.all", function(plr)
	if getAdmin(plr,4) then
	outputChatBox("#770000>> #770000"..getPlayerName(plr):gsub("#%x%x%x%x%x%x", "").."#ffffff schował(a) wszystkie pojazdy do przechowalni!", root, 0, 255, 0, true)
	local desc = "[#FFA800UID: "..getElementData(plr, "player:sid").."#ffffff] - #FFA800"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#FFFFFF oddaje wszystkie pojazdy do przechowalni"
	triggerEvent("admin:addText", resourceRoot, desc)
	outputServerLog(desc:gsub("#%x%x%x%x%x%x",""))
	for i,v in ipairs(getElementsByType("vehicle")) do
	if getElementData(v, "vehicle:id") then
	local query = exports['nrpg_db']:dbSet("UPDATE pystories_vehicles SET parking=1")
	exports["nrpg_vehicles"]:onSaveVehicle(v,plr)
	destroyElement(v)
	end
	end
end
end)

addCommandHandler("inv.veh", function(plr)
	if getAdmin(plr, 3) or getAdmin(plr, 4) then
		local plr=getPedOccupiedVehicle(plr)
		if not plr then return end
		if getElementAlpha(plr) > 0 then
			setElementAlpha(plr, 0)
		else
			setElementAlpha(plr, 255)
		end
	end
end)

addCommandHandler("veh.list", function(plr,cmd,cel)
	if not getAdmin(plr) then outputChatBox("* Brak uprawnien", plr) return end
    if not cel then
		exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /veh.list <nick/id>", "info")
        return
    end
	local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
	local resulte = exports['nrpg_db']:dbGet("SELECT * FROM pystories_vehicles WHERE ownedPlayer=?",getElementData(target, "player:sid"))
	if not resulte or #resulte < 1 then
	outputChatBox("* Nie znaleziono pojazdu", plr, 255, 255, 255)
	return end
	outputChatBox("<><> Pojazdy gracza "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." <><>", plr, 255, 255, 255)
	for i,result in pairs(resulte) do
    outputChatBox("#fcc603ID Pojazdu:#FFFFFF " .. result.id .. ", #fcc603Model:#FFFFFF " .. result.model .. " ("..getVehicleNameFromModel(result.model)..")", plr, 255, 255, 255, true)
	end
	outputChatBox("<><><>", plr, 255, 255, 255)
end)

addCommandHandler("schowaj.odl", function(plr, cmd, ilosc)
if getAdmin(plr,4) then
if not tonumber(ilosc) then return end
local x, y, z = getElementPosition(plr)
local vehicles = getElementsWithinRange(x, y, z, ilosc, "vehicle")

for i,v in ipairs(vehicles) do
	if getElementData(v, "vehicle:id") then
		local query = exports['nrpg_db']:dbSet("UPDATE pystories_vehicles SET parking=1")
		exports["nrpg_vehicles"]:onSaveVehicle(v, plr)
		destroyElement(v)
	end
end
end
end)

-- Komendy ownerów
addCommandHandler("przepisz.gracz", function(plr, cmd, vID, oID)
if getAdmin(plr, 4) then

local veh = getPedOccupiedVehicle(plr)

if veh then
	if not vID then return exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /przepisz.gracz [SID gracza]", "info") end
	setElementData(veh, "vehicle:ownedPlayer", vID)

	local result = exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET ownedPlayer=? WHERE id=?", vID, getElementData(veh, "vehicle:id"))

	if result then
		exports.nrpg_interface:showPlayerNotification(plr, "Przepisano pojazd o ID "..getElementData(veh, "vehicle:id").." na gracza o SID "..vID.."", "success")
	end
else
if not vID then return exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /przepisz.gracz [ID pojazdu] [SID gracza]", "info") end
if not oID then return exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /przepisz.gracz [ID pojazdu] [SID gracza]", "info") end
		local result = exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET ownedPlayer=? WHERE id=?", oID, vID)

		if result then
			exports.nrpg_interface:showPlayerNotification(plr, "Przepisano pojazd o ID "..vID.." na gracza o SID "..oID.."", "success")
		end
	end
end
end)


addCommandHandler("daj.kase", function(plr,cmd,cel,value)
	if getAdmin(plr,4) then
		if not cel or not tonumber(value) then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /daj.kase [nick/ID] [koszt]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end

		local dodatek = ""

		if tonumber(value) > 1 then
			dodatek = "+"
		else
			dodatek = ""
		end

		givePlayerMoney(target, value)

		outputChatBox("* "..getPlayerName(plr).." wprowadził/a zmiany w twoim portfelu ("..dodatek..""..value.." PLN)", target)
		outputChatBox("* Pomyślnie wprowadzono zmiany w twoim koncie bankowym "..getPlayerName(target).." ("..dodatek..""..value.." PLN)", plr)
	end
end)


addCommandHandler("daj.bank", function(plr,cmd,cel,value)
	if getAdmin(plr,4) then
		if not cel or not tonumber(value) then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /daj.bank [nick/ID] [koszt]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end

		local dodatek = ""

		if tonumber(value) > 1 then
			dodatek = "+"
		else
			dodatek = ""
		end

		exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money+"..math.abs(tonumber(value)).." WHERE id="..tonumber(getElementData(target, "player:sid")).." LIMIT 1")

		outputChatBox("* "..getPlayerName(plr).." wprowadził/a zmiany w twoim koncie bankowym ("..dodatek..""..value.." PLN)", target)
		outputChatBox("* Pomyślnie wprowadzono zmiany w twoim koncie bankowym "..getPlayerName(target).." ("..dodatek..""..value.." PLN)", plr)
	end
end)


addCommandHandler("daj.srp", function(plr,cmd,cel,value,...)
	if getAdmin(plr,4) then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(value) then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /daj.srp [nick/ID] [ilosc]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		exports["nrpg_db"]:dbSet("UPDATE pystories_users SET srp=? WHERE id=?", getElementData(target,"player:srp")+value, getElementData(target, "player:sid"))
		setElementData(target,"player:srp", getElementData(target,"player:srp")+value)
		outputChatBox("* Otrzymałeś(aś)  "..value.." SRP!", target)
		outputChatBox ("* Nadałeś(aś) "..value.." SRP dla gracza "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
	end
end)


addCommandHandler("jp", function(plr,cmd)
	if getAdmin(plr) then
		if isPedInVehicle(plr) then
			removePedFromVehicle(plr)
		end
		if doesPedHaveJetPack(plr) then
			removePedJetPack(plr)
			outputChatBox ("* Zabrałeś(aś) JetPack'a. [/jp]",plr)
		else
			givePedJetPack(plr)
			outputChatBox ("* Otrzymałeś(aś) JetPack'a. [/jp]",plr)
		end
	end
end)

addCommandHandler("znikaj", function(plr,cmd)
	if getAdmin(plr,4) then
		if not getElementData(plr, "p:inv") then
			setElementData(plr, "p:inv", true)
			exports.nrpg_interface:showPlayerNotification(plr, "Włączyłeś system niewidki, nikt Cię nie widzi!", "info")
		else
			setElementData(plr, "p:inv", false)
			exports.nrpg_interface:showPlayerNotification(plr, "Wyłączyłeś system niewidki, każdy Cię widzi!", "info")
		end
	end
end)

addCommandHandler("daj.pp", function(plr,cmd,cel,value,...)
	if getAdmin(plr,4) then
		local reason=table.concat({...}, " ")
        if not cel or not tonumber(value) then
            exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /daj.pp [nick/id] [ilość]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
        if not target then
            outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		exports["nrpg_db"]:dbSet("UPDATE pystories_users SET pp=? WHERE id=?", (getElementData(target,"player:pp") or 0)+value, getElementData(target, "player:sid"))
        setElementData(target,"player:pp", (getElementData(target,"player:pp") or 0)+value)
        exports.nrpg_interface:showPlayerNotification(target, "Otrzymałeś(aś) "..value.." Punktów Premium!", "info")
        exports.nrpg_interface:showPlayerNotification(plr, "Nadałeś(aś) "..value.." Punktów Premium!", "success")
	end
end)

addCommandHandler("daj.klucze", function(plr,cmd,cel,value,...)
	if getAdmin(plr,4) then
		local reason=table.concat({...}, " ")
        if not cel or not tonumber(value) then
            exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /daj.klucze [nick/id] [ilość]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
        if not target then
            outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		exports["nrpg_db"]:dbSet("UPDATE pystories_users SET klucze=? WHERE id=?", (getElementData(target,"player:keys") or 0)+value, getElementData(target, "player:keys"))
        setElementData(target,"player:keys", (getElementData(target,"player:keys") or 0)+value)
        exports.nrpg_interface:showPlayerNotification(target, "Otrzymałeś(aś) "..value.." kluczy!", "info")
        exports.nrpg_interface:showPlayerNotification(plr, "Nadałeś(aś) "..value.." kluczy!", "success")
	end
end)

addCommandHandler("pp.all", function(plr,cmd,value)
	if getAdmin(plr, 4) and value then
		for i, v in ipairs(getElementsByType("player")) do
			if isElement(v) and getElementData(v, "player:sid") then
				local ilosc = getElementData(v, "player:pp") or 0
				setElementData(v, "player:pp", ilosc+value)
				exports.nrpg_interface:showPlayerNotification(v, ""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." rozdał kazdemu "..value.." punktów premium", "success")
			end
		end
	end
end)

addCommandHandler("klucze.all", function(plr,cmd,value)
	if getAdmin(plr, 4) and value then
		for i, v in ipairs(getElementsByType("player")) do
			if isElement(v) and getElementData(v, "player:sid") then
				local ilosc = getElementData(v, "player:keys") or 0
				setElementData(v, "player:keys", ilosc+value)
				exports.nrpg_interface:showPlayerNotification(v, ""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." rozdał kazdemu "..value.." klucz/y", "success")
			end
		end
	end
end)

addCommandHandler("diamond.all", function(plr,cmd)
	if getAdmin(plr, 4) then
		for i, v in ipairs(getElementsByType("player")) do
			if isElement(v) and getElementData(v, "player:sid") then
				setElementData(v, "player:premiumplus", true)
				exports.nrpg_interface:showPlayerNotification(v, ""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." rozdał każdej zalogowanej osobie diamond do wyjścia z serwera", "success")
			end
		end
	end
end)

addCommandHandler("war", function(plr,cmd,ilosc, ilosc2)
    if getAdmin(plr, 4) then
        if not tonumber(ilosc) then exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /war [liczba] [liczba]", "info") return end
        auto = getPedOccupiedVehicle(plr)
        id = getElementModel(auto)
        if not tonumber(ilosc) or not tonumber(ilosc2) then exports.nrpg_interface:showPlayerNotification(plr, "Nie podałeś liczb!", "error") return end
        if tonumber(ilosc) and tonumber(ilosc2) then
             setVehicleVariant(auto, ilosc, ilosc2)
       	end
    else
        outputChatBox("* Brak uprawnień do użycia tej komendy!", plr)
    end

end)

addCommandHandler("tune", function(plr,cmd,cel,value)
	if getAdmin(plr,4) then
		if not cel or not tonumber(value) then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz /tune [nick/ID] [id]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local veh=getPedOccupiedVehicle(target)
		addVehicleUpgrade(veh,value)
		outputChatBox("* Do twojego pojazdu dodano tuning, o id: "..value.."", target)
		outputChatBox("* Dodałeś(aś) tuning ID "..value.." do pojazdu gracza "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
	end

end)

addCommandHandler("fix.all", function(plr,cmd)
	if getAdmin(plr, 2) or getAdmin(plr, 3) or getAdmin(plr, 4) then
		for i, v in ipairs(getElementsByType("vehicle")) do
			if isElement(v) and getElementData(v, "vehicle:id") then
				fixVehicle( v )
			end
		end
		exports.nrpg_interface:showPlayerNotification(root, ""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." naprawił/a każdemu pojazd", "success")
	end
end)

addCommandHandler("przeladuj", function(plr,cmd,cel,...)
	if getAdmin(plr,4) then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("* Użycie: /przeladuj <nick/ID>", plr)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		triggerEvent("save:player",root,target)
		triggerEvent("load:player",root,target)
		outputChatBox("* Przeładowano statystyki gracza: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
	end
end)

addCommandHandler("zapisz.all", function(plr,cmd)
	if getAdmin(plr,4) then
		for i,v in ipairs(getElementsByType("player")) do
		if isElement(v) then
		triggerEvent("save:player",root,v)
		end
		end
		outputChatBox("* Administrator zapisał wszystkim statystyki.", root, 21,0,170,true)
	end
end)

addCommandHandler("przeladuj.all", function(plr,cmd,cel,...)
	if getAdmin(plr,4) then
		for i,v in ipairs(getElementsByType("player")) do
		if isElement(v) then
		triggerEvent("save:player",root,v)
		triggerEvent("load:player",root,v)
		end
		end
		outputChatBox("* Administrator przeładował wszystkim statystyki.", root, 21,0,170,true)
	end
end)

addCommandHandler("wczytaj", function(plr,cmd,cel,...)
	if getAdmin(plr,4) then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("* Użycie: /wczytaj <nick/ID>", plr)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		triggerEvent("load:player",root,target)
		outputChatBox("* Wczytano statystyki gracza: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
	end
end)

addCommandHandler("zapisz", function(plr,cmd,cel,...)
	if getAdmin(plr,4) then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("* Użycie: /zapisz <nick/ID>", plr)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		triggerEvent("save:player",root,target)
		outputChatBox("* Zapisano statystyki gracza: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
	end
end)

addCommandHandler("fix", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /fix [nick/ID]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local veh=getPedOccupiedVehicle(target)
		if not veh then
			exports.nrpg_interface:showPlayerNotification(plr, ""..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..", nie znajduje się w pojeździe!", "error")
			return
		end
		outputChatBox("* Naprawiłeś(aś) pojazd "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
		setElementHealth(veh, 1000)
		fixVehicle(veh)
	end

end)

addCommandHandler("flip", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz:  /flip [nick/ID]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local veh=getPedOccupiedVehicle(target)
		if not veh then
			exports.nrpg_interface:showPlayerNotification(plr, ""..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..", nie znajduje się w pojeździe!", "error")
			return
		end
		local x,y,z = getElementRotation(veh)
		outputChatBox("* Obróciłeś(aś) pojazd "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
		setElementRotation(veh, 0, 0, z)
	end

end)

addCommandHandler("kolor", function(plr,cmd,cel,value,value2,value3)
	if getAdmin(plr,4) then
		if not cel or not tonumber(value) or not tonumber(value2) or not tonumber(value3) then
			exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /kolor [nick/ID] [r g b]", "info")
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local veh=getPedOccupiedVehicle(target)
		setVehicleColor(veh,value,value2,value3,value,value2,value3)
		outputChatBox("* Twojemu pojazdowi zmieniono kolor.", target)
		outputChatBox("* Zmieniłeś(aś) kolor pojazdu graczu: "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
	end

end)

-- reszta komend


addCommandHandler("k", function(plr,cmd,cel,...)
	if getAdmin(plr) then
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("* Użycie: /k <nick/ID> <powód>", plr)
			return
		end
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
        end
        	if getAdmin(target, 4) then
        		target = plr
        	end
		triggerClientEvent(root, "admin:rendering", root, "Gracz ("..getElementData(target,"id")..") "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został wyrzucony przez ("..getElementData(plr,"id")..") "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." z serwera.\nPowód wyrzucenia: "..reason.."")
        kickPlayer(target, plr, reason)
        exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] został/a wyrzucony/a z serwera przez **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**] z powodem: "..reason.."", "kary-adm")
		triggerEvent("admin:addText", resourceRoot, "[KICK] ["..getElementData(plr,"id").."]"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." wyrzucił(a) ["..getElementData(target,"id").."]"..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..", powód: "..reason:gsub("#%x%x%x%x%x%x","").."")
	end
end)

addCommandHandler("tt", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			outputChatBox("#ff1100✘#ffffff Użycie: /tt <nick/ID>", plr, 0, 0, 0, true)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
			return
		end
		if isPedInVehicle(plr) then
			removePedFromVehicle(plr)
		end
		if isPedInVehicle(target) then
			if getElementData(getPedOccupiedVehicle(target), "vehicle:id") then 
				local max = getVehicleMaxPassengers(getPedOccupiedVehicle(target))
				local occ = getVehicleOccupants(getPedOccupiedVehicle(target))
				warpPedIntoVehicle(plr, getPedOccupiedVehicle(target), max-(#occ))
			end
		end
		outputChatBox("#00ff00✔#ffffff Przeteleportowałeś(aś) się do gracza o nicku "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr, 0, 0, 0, true)
		local x,y,z=getElementPosition(target)
		setElementInterior(plr,getElementInterior(target))
		setElementDimension(plr,getElementDimension(target))
		setElementPosition(plr,x+math.random(1,2),y+math.random(1,2),z)
	end
end)

addCommandHandler("th", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			outputChatBox("#ff1100✘#ffffff Użycie: /th <nick/ID>", plr, 0, 0, 0, true)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
			return
		end
		if isPedInVehicle(target) then
			removePedFromVehicle(target)
		end
		if isPedInVehicle(plr) then
			if getElementData(getPedOccupiedVehicle(plr), "vehicle:id") then 
				local max = getVehicleMaxPassengers(getPedOccupiedVehicle(plr))
				local occ = getVehicleOccupants(getPedOccupiedVehicle(plr))
				warpPedIntoVehicle(target, getPedOccupiedVehicle(plr), max-(#occ))
			end
		end
		if exports['nrpg_admin']:getAdmin(target, 5) then outputChatBox("ale ze zarzad do siebie chcesz tepnac nie pojebalo ci sie cos w glowce skurwysynie", plr) return end
		outputChatBox("#00ff00✔#ffffff Przeteleportowano gracza o nicku "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." do siebie.", plr, 0, 0, 0, true)
		outputChatBox("#00ff00✔#ffffff Administrator(ka) "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." przeteleportował(a) Ciebie do siebie.", target, 0, 0, 0, true)
		local x,y,z=getElementPosition(plr)
		setElementInterior(target,getElementInterior(plr))
		setElementDimension(target,getElementDimension(plr))
		setElementPosition(target,x+math.random(1,2),y+math.random(1,2),z)
	end
end)

addCommandHandler("dim", function(plr, cmd, value)
	if getAdmin(plr) then
        if (not value) then
            outputChatBox("* Użyj: /dim <ilość>", plr)
            return
        end
        setElementDimension(plr, value)
    end
end)

addCommandHandler("int", function(plr, cmd, value)
	if getAdmin(plr) then
        if (not value) then
            outputChatBox("* Użyj: /int <ilość>", plr)
            return
        end
        setElementInterior(plr, value)
    end
end)

addCommandHandler("warn", function(plr,cmd,cel, ...)
    if getAdmin(plr) then
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
        if (not target) then
            outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza.", plr, 0, 0, 0, true)
            return
        end
        local tresc = table.concat(arg, " ")
        if (string.len(tresc)<=1) then
            outputChatBox("#ff1100✘#ffffff Wpisz treść ostrzeżenia!", plr, 0, 0, 0, true)
            return
        end
		--if getElementData(target,"player:sid") == 1 then outputChatBox("* Nie można nadać ostrzeżenie dla gracza o SID: 1 !",plr) return end
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Otrzymałeś(aś) ostrzeżenie od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Treść ostrzeżenia: "..tresc:gsub("#%x%x%x%x%x%x","").."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Nie stostowanie się do ostrzeżenia może skutkować kick'iem lub ban'em!", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
        triggerClientEvent("onPlayerWarningReceived", target, tresc)
		triggerClientEvent(root, "admin:rendering", root, "Gracz ("..getElementData(target,"id")..") "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał ostrzeżenia od ("..getElementData(plr,"id")..") "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."\nTreść ostrzeżenia: "..tresc.."")
		exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] otrzymał/a ostrzeżenie od **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**] z powodem: "..tresc.."", "kary-adm")
		triggerEvent("admin:addText", resourceRoot, "[WARN] ["..getElementData(plr,"id").."]"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." nadał(a) warn'a na ["..getElementData(target,"id").."]"..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..", powód: "..tresc:gsub("#%x%x%x%x%x%x","").."")
	end
end)

addCommandHandler("zpj", function(plr,cmd,cel,time,type,...)
	if getAdmin(plr) then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(time) or not type or not reason then
			outputChatBox("#ff1100✘#ffffff Użycie: /zpj <nick/ID> <czas> <jednostka: m/h/y/w> <powód>", plr, 0, 0, 0, true)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
			return
		end
		if isPedInVehicle(target) then
			removePedFromVehicle(target)
		end
        	if getAdmin(target, 4) then
        		target = plr
        	end
		triggerClientEvent(root, "admin:rendering", root, "Gracz ("..getElementData(target,"id")..") "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał zakaz prowadzenia pojazdów (A, B, C) od ("..getElementData(plr,"id")..") "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."\nPowód: "..reason.."\nCzas: "..time .. type .."")
		if type=="m" or type=="h" or type=="d" then
			if type=="m" then
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? minute,?)",getPlayerSerial(target), reason, time, "A")
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? minute,?)",getPlayerSerial(target), reason, time, "B")
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? minute,?)",getPlayerSerial(target), reason, time, "C")
			end
			if type=="h" then
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? hour,?)",getPlayerSerial(target), reason, time, "A")
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? hour,?)",getPlayerSerial(target), reason, time, "B")
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? hour,?)",getPlayerSerial(target), reason, time, "C")
			end
			if type=="d" then
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? day,?)",getPlayerSerial(target), reason, time, "A")
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? day,?)",getPlayerSerial(target), reason, time, "B")
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? day,?)",getPlayerSerial(target), reason, time, "C")
			end
		end
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Otrzymałeś(aś) zakaz prowadzenia pojazdów od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Powód: "..reason:gsub("#%x%x%x%x%x%x","").."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Czas: "..time .. type .."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
        outputChatBox(" ", target, 255, 0, 0)
        exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] otrzymał/a zakaz prowadzenia pojazdów od **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**] z powodem: "..reason..", czas trwania kary: "..time .. type .."", "kary-adm")
	end
end)

addCommandHandler("skin", function(plr,cmd,cel,id)
	if getAdmin(plr) then
		local id = tonumber(id)
		if not cel or not id then
			outputChatBox("#ff1100✘#ffffff Użycie: /skin <nick/ID> <id skinu> ", plr, 0, 0, 0, true)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
			return
		end
		if id < 0 or id > 311 then outputChatBox("#ff1100✘#ffffff Użycie: /skin <nick/ID> <id skinu>", plr, 0, 0, 0, true) return end
		if id == 22 then outputChatBox("#ff1100✘#ffffff Skin został zablokowany z powodu buga!", plr, 0, 0, 0, true) return end
		setElementModel(target,id)
		local query = exports['nrpg_db']:dbSet("UPDATE pystories_users SET skin=? WHERE id=?",id,getElementData(target,"player:sid"))
		outputChatBox("#00ff00✔#ffffff Zmieniono skin dla gracza "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." na ID "..id..".", plr, 0, 0, 0, true)
	end
end)


addCommandHandler("opj", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
		 outputChatBox("#ff1100✘#ffffff Użycie: /opj ID/nick gracza", plr, 255, 255, 255, true)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza!", plr, 255, 255, 255, true)
			return
		end
		local query=string.format("SELECT * FROM pystories_punish WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","A", getPlayerSerial(target))
		local query2=string.format("SELECT * FROM pystories_punish WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","B", getPlayerSerial(target))
		local query3=string.format("SELECT * FROM pystories_punish WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","C", getPlayerSerial(target))
		local result=exports["DB2"]:pobierzWyniki(query)
		local result2=exports["DB2"]:pobierzWyniki(query2)
		local result3=exports["DB2"]:pobierzWyniki(query3)
		if (result) or (result2) or (result3) then
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_punish WHERE type=? AND active=1 AND serial=?", "A", getPlayerSerial(target))
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_punish WHERE type=? AND active=1 AND serial=?", "B", getPlayerSerial(target))
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_punish WHERE type=? AND active=1 AND serial=?", "C", getPlayerSerial(target))
			outputChatBox("Pomyślnie oddałeś/aś prawo jazdy graczu: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr, 255, 255, 255, true)
            outputChatBox(""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." oddał Tobie prawo jazdy.", target, 255, 255, 255, true)
            exports['nrpg_discord']:connectWeb("**"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr,"player:sid").."**] oddał prawo jazdy dla gracza **"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target, "player:sid").."**]", "kary-adm")
			triggerEvent("admin:addText", resourceRoot, "[#14fc03OPJ#ffffff] ["..getElementData(plr,"id").."]"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." oddaje prawo jazdy gracza ["..getElementData(target,"id").."]"..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".")
		else
		    outputChatBox("#ff1100✘#ffffff Gracz: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." nie posiada zabranego prawa jazdy!", plr, 255, 255, 255, true)
		end
	end
end)

addCommandHandler("b", function(plr,cmd,cel,x,bantype,...)
	if getAdmin(plr,4) or getAdmin(plr,3) or getAdmin(plr,2) then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(x) or not bantype or not reason then
			exports.nrpg_interface:showPlayerNotification(plr, "/b [nick/id] <ilość> [m/h/d] [powod]", "error", 1, 3000)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			exports.nrpg_interface:showPlayerNotification(plr, "Nie znaleziono gracza", "error", 1, 3000)
			return
		end
        	if getAdmin(target, 4) then
        		target = plr
        	end

		if bantype=="m" or bantype=="h" or bantype=="d" then
		if bantype=="m" then
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,NOW() + INTERVAL ? minute,?,1)",getElementData(target, "player:sid"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getPlayerSerial(target),reason, x, "ban")
		end
		if bantype=="h" then
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,NOW() + INTERVAL ? hour,?,1)",getElementData(target, "player:sid"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getPlayerSerial(target),reason, x, "ban")
		end
		if bantype=="d" then
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,NOW() + INTERVAL ? day,?,1)",getElementData(target, "player:sid"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getPlayerSerial(target),reason, x, "ban")
		end
		end
		local desc = "[#ff6600BAN#FFFFFF] (Czas: #ff6600"..x.." "..bantype.."#ffffff) ["..getElementData(target,"id").."]"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został(a) zbanowany(a) przez ["..getElementData(plr,"id").."]"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..". Powód: "..reason..""
		triggerEvent("admin:addText", resourceRoot, desc:gsub("#%x%x%x%x%x%x",""))
		outputServerLog(desc:gsub("#%x%x%x%x%x%x",""))  
		triggerClientEvent(root, "admin:rendering", root, "Gracz ("..getElementData(target,"id")..") "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został zbanowany przez ("..getElementData(plr,"id")..") "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."\nPowód zbanowania: "..reason.."\nCzas: "..x..""..bantype.."")
		outputConsole("["..getElementData(target,"id").."] "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został(a) zbanowany(a) przez ["..getElementData(plr,"id").."] "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..". Powód: "..reason.." ("..x..""..bantype..")")
        exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] został/a zbanowany/a przez **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**] z powodem: "..reason.." ("..x..""..bantype..")", "kary-adm")
        kickPlayer(target, plr, "Niestety zostałeś/aś zbanowany/a - Połącz się ponownie")
	end
end)

addCommandHandler("pb", function(plr,cmd,cel,...)
	if getAdmin(plr,4) or getAdmin(plr,3) or getAdmin(plr,2) then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			exports.nrpg_interface:showPlayerNotification(plr, "/pb [nick/id] [powod]", "error", 1, 3000)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			exports.nrpg_interface:showPlayerNotification(plr, "Nie znaleziono gracza", "error", 1, 3000)
			return
		end
		local query=string.format("SELECT * FROM pystories_ban WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","ban", getPlayerSerial(target))
		local result=exports["DB2"]:pobierzWyniki(query)
		if (result) then
			return exports.nrpg_interface:showPlayerNotification(plr, "Gracz Posiada Bana do "..result["time"]..", za: "..result["reason"], "error", 1, 3000)
		else
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_ban WHERE type=? AND active=1 AND serial=?", "ban", getPlayerSerial(target))
		end
        	if getAdmin(target, 4) then
        		target = plr
        	end

		triggerClientEvent(root, "admin:rendering", root, "Gracz ("..getElementData(target,"id")..") "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został zbanowany przez ("..getElementData(plr,"id")..") "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."\nPowód: "..reason.."\nCzas: Na zawsze")
		outputConsole("["..getElementData(target,"id").."] "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został(a) zbanowany(a) przez ["..getElementData(plr,"id").."] "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." Powód: "..reason.." (999d)")
        exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] został/a zbanowany/a permanentnie przez **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**] z powodem: "..reason.."", "kary-adm")
        exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,NOW() + INTERVAL ? day,?,1)",getElementData(target, "player:sid"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getPlayerSerial(target), reason, "2030-12-31 23:59:59", "ban")
		kickPlayer(target, plr, "Niestety zostałeś/aś zbanowany/a - Połącz się ponownie")

	end
end)

addCommandHandler("ub", function(plr,cmd,cel)
	local sid=getElementData(plr,"player:sid")
	if not sid then return end
	if getAdmin(plr,4) or getAdmin(plr,3) or getAdmin(plr,2) then
		if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "/ub <serial>", "error", 1, 3000)
			return
		end
		local query=string.format("SELECT * FROM pystories_ban WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","ban", cel)
		local result=exports["DB2"]:pobierzWyniki(query)
		if (result) then
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_ban WHERE type=? AND active=1 AND serial=?", "ban", cel)
            exports.nrpg_interface:showPlayerNotification(plr, "Ban zdjęty ("..cel..")")
		else
			exports.nrpg_interface:showPlayerNotification(plr, "Nie wykryto bana!", "error", 1, 3000)
		end
	end
end)

function zmienTryb(player, command, ...)
	if getAdmin(player, 4) then
	local tryb = table.concat({...}, " ")
	if tryb then
		setGameType(""..tryb.."")
		outputChatBox("✔#ffffff Zmieniono tryb gry na #18FF00"..tryb.."#ffffff", player, 0, 255, 0, true)
	end
end
end
addCommandHandler("tryb", zmienTryb)

addCommandHandler("check.1", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "Uzyj: /check.1 [SID]", "info")
			return
		end

	local result = exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE id=?", cel)
	local resultkurwa = exports['nrpg_db']:dbGet("SELECT * FROM synchronizacja_dsc WHERE uid=?", cel)

	if not result or #result < 1 then
		exports.nrpg_interface:showPlayerNotification(plr, "W bazie danych nie ma gracza z takim SID'em", "error")
	return end 

		outputChatBox(" ", plr, 255, 255, 0, true)
		outputChatBox(" ", plr, 255, 255, 0, true)
	outputChatBox("●#ffffff SID: #FFF000" .. result[1].id, plr, 255, 255, 0, true)	
    outputChatBox("●#ffffff Login: #FFF000" .. result[1].login, plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Portfel: #FFF000" .. przecinek(result[1].money), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Bankomat: #FFF000" .. przecinek(result[1].bank_money), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Punkty Premium: #FFF000" .. przecinek(result[1].pp), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Minuty: #FFF000" .. przecinek(result[1].hours), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Minuty na duty: #FFF000" .. przecinek(result[1].worker), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Premium ważne do: #FFF000" .. (result[1].premiumdate), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Data rejestracji: #FFF000" .. result[1].registered, plr, 255, 255, 0, true)
	outputChatBox("●#ffffff Zarejestrowany serial: #FFF000" .. result[1].register_serial, plr, 255, 255, 0, true)
	--outputChatBox("●#ffffff Konto Discord: #FFF000" .. resultkurwa[1].account_discord, plr, 255, 255, 0, true)
	
	if getAdmin(plr, 5) then
		outputChatBox("●#ffffff Hasło: #FFF000" .. teaDecode(result[1].pass, "redskilltojebanykretyniokradadziecinakase"), plr, 255, 255, 0, true)
	end
		outputChatBox(" ", plr, 255, 255, 0, true)
		outputChatBox(" ", plr, 255, 255, 0, true)
	end
end)

addCommandHandler("check.2", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "Uzyj: /check.2 [SERIAL]", "info")
			return
		end

	local result = exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE register_serial=?", cel)
	local resultkurwa = exports['nrpg_db']:dbGet("SELECT * FROM synchronizacja_dsc WHERE uid=?", cel)

	if not result or #result < 1 then
		exports.nrpg_interface:showPlayerNotification(plr, "W bazie danych nie ma gracza z takim serialem", "error")
	return end 

		outputChatBox(" ", plr, 255, 255, 0, true)
		outputChatBox(" ", plr, 255, 255, 0, true)
	outputChatBox("●#ffffff SID: #FFF000" .. result[1].id, plr, 255, 255, 0, true)	
    outputChatBox("●#ffffff Login: #FFF000" .. result[1].login, plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Portfel: #FFF000" .. przecinek(result[1].money), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Bankomat: #FFF000" .. przecinek(result[1].bank_money), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Punkty Premium: #FFF000" .. przecinek(result[1].pp), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Minuty: #FFF000" .. przecinek(result[1].hours), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Minuty na duty: #FFF000" .. przecinek(result[1].worker), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Premium ważne do: #FFF000" .. (result[1].premiumdate), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Data rejestracji: #FFF000" .. result[1].registered, plr, 255, 255, 0, true)
	outputChatBox("●#ffffff Zarejestrowany serial: #FFF000" .. result[1].register_serial, plr, 255, 255, 0, true)
	--outputChatBox("●#ffffff Konto Discord: #FFF000" .. resultkurwa[1].account_discord, plr, 255, 255, 0, true)

	if getAdmin(plr, 4) then
		outputChatBox("●#ffffff Hasło: #FFF000" .. teaDecode(result[1].pass, "redskilltojebanykretyniokradadziecinakase"), plr, 255, 255, 0, true)
	end
		outputChatBox(" ", plr, 255, 255, 0, true)
		outputChatBox(" ", plr, 255, 255, 0, true)
	end
end)

addCommandHandler("check.3", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "Uzyj: /check.3 [NICK]", "info")
			return
		end

	local result = exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE login=?", cel)
	local resultkurwa = exports['nrpg_db']:dbGet("SELECT * FROM synchronizacja_dsc WHERE uid=?", cel)

	if not result or #result < 1 then
		exports.nrpg_interface:showPlayerNotification(plr, "W bazie danych nie ma gracza z takim loginem", "error")
	return end 

		outputChatBox(" ", plr, 255, 255, 0, true)
		outputChatBox(" ", plr, 255, 255, 0, true)
	outputChatBox("●#ffffff SID: #FFF000" .. result[1].id, plr, 255, 255, 0, true)	
    outputChatBox("●#ffffff Login: #FFF000" .. result[1].login, plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Portfel: #FFF000" .. przecinek(result[1].money), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Bankomat: #FFF000" .. przecinek(result[1].bank_money), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Punkty Premium: #FFF000" .. przecinek(result[1].pp), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Minuty: #FFF000" .. przecinek(result[1].hours), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Minuty na duty: #FFF000" .. przecinek(result[1].worker), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Premium ważne do: #FFF000" .. (result[1].premiumdate), plr, 255, 255, 0, true)
    outputChatBox("●#ffffff Data rejestracji: #FFF000" .. result[1].registered, plr, 255, 255, 0, true)
	outputChatBox("●#ffffff Zarejestrowany serial: #FFF000" .. result[1].register_serial, plr, 255, 255, 0, true)
	--outputChatBox("●#ffffff Konto Discord: #FFF000" .. resultkurwa[1].account_discord, plr, 255, 255, 0, true)

	if getAdmin(plr, 4) then
		outputChatBox("●#ffffff Hasło: #FFF000" .. teaDecode(result[1].pass, "redskilltojebanykretyniokradadziecinakase"), plr, 255, 255, 0, true)
	end
		outputChatBox(" ", plr, 255, 255, 0, true)
		outputChatBox(" ", plr, 255, 255, 0, true)
	end
end)

addCommandHandler("check.veh", function(plr,cmd,cel)
    if getAdmin(plr) then
        if not cel then
            exports.nrpg_interface:showPlayerNotification(plr, "Uzyj: /check.veh [SID]", "info")
            return
        end
        local result = exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE id=?", cel)
        local resultveh = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles WHERE ownedPlayer=?", result[1].id)
        local vehicles = {}

        for i,v in ipairs(resultveh) do
            for ii,vv in ipairs(result) do
                table.insert(vehicles, {v.id, v.ownedPlayer, vv.login, exports['nrpg_vehicles']:changeName(getVehicleNameFromModel(v.model))})
            end
        end

        outputChatBox("●#ffffff Pojazdy gracza:", plr, 255, 255, 0, true)
        outputChatBox(" ", plr, 255, 255, 0, true)
        for i,v in ipairs(vehicles) do
            outputChatBox("●#ffffff [ID: "..v[1].."], Właściciel: "..v[3].." [SID: "..v[2].."] - "..v[4].."", plr, 255, 255, 0, true)
        end
        outputChatBox(" ", plr, 255, 255, 0, true)
    end
end)

function przecinek(xd)
	local left,num,right = string.match(xd,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

addCommandHandler("vtt", function(plr,cmd,vid)
	if getAdmin(plr) then
		if not getAdmin(plr, 4) then if getElementData(plr, "player:job") == "tartak" then outputChatBox("* Myślisz że nie wiem kurwa o tym?", plr, 255, 0, 0) return end end
		if not vid or not tonumber(vid) then return end
		vid=tonumber(vid)
		for i,v in ipairs(getElementsByType("vehicle")) do
			local dbid=getElementData(v,"vehicle:id")
			if dbid and tonumber(dbid) == vid then
	    		local x,y,z=getElementPosition(v)
	    		setElementPosition(plr,x,y,z+4)
	    		setElementInterior(plr, getElementInterior(v))
	    		setElementDimension(plr, getElementDimension(v))
				if getAdmin(plr, 4) then
					warpPedIntoVehicle(plr,v)
				end
	    	end
		end
	end
end)

addCommandHandler("vth", function(plr,cmd,vid)
	if getAdmin(plr) then
		if not getAdmin(plr, 4) then if getElementData(plr, "player:job") == "tartak" then outputChatBox("* Myślisz że nie wiem kurwa o tym?", plr, 255, 0, 0) return end end
		if not vid or not tonumber(vid) then return end
		vid=tonumber(vid)

		local result = exports['nrpg_db']:dbGet("SELECT * FROM pystories_vehicles WHERE parking=1 and police=0 and id=?", vid)
		if #result > 0 then
			local x, y, z = getElementPosition(plr)
			local r, o, t = getElementRotation(plr)
			local spawn = exports["nrpg_vehicles"]:onRespawnVehicles(_, vid, {x, y, z, r, o, t})
    		exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie przeniesiono pojazd ID "..vid.." z przechowalni", "success")

   			local car = findCar(plr, vid)
    		if car then
    			setTimer( function()
    				setVehicleEngineState(car, true)
					if getAdmin(plr, 4) then
						warpPedIntoVehicle(plr,car)
					end
    			end, 100, 1)
    		end
		end

		for i,v in ipairs(getElementsByType("vehicle")) do
			local dbid=getElementData(v,"vehicle:id")
			if dbid and tonumber(dbid) == vid then
				exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie przeniesiono pojazd ID "..vid.."", "success")
	    		local x,y,z=getElementPosition(plr)
	    		setElementPosition(v,x,y,z+0.1)
	    		setElementInterior(v, getElementInterior(plr))
	    		setElementDimension(v, getElementDimension(plr))
				if getAdmin(plr, 4) then
					warpPedIntoVehicle(plr,v)
				end
	   		end
		end
	end
end)

function findCar(player, toCar)
    for i,v in ipairs(getElementsByType("vehicle")) do
        if tonumber(toCar) then
            if getElementData(v, "vehicle:id") == tonumber(toCar) then
                return v
            end
        end
    end
end

addCommandHandler("heal", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			outputChatBox("* Użyj: /heal <id/nick>", plr)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		setElementHealth(target, 100)
		outputChatBox("* Uleczyłeś(aś) gracza " ..getPlayerName(target):gsub("#%x%x%x%x%x%x",""), plr)
		outputChatBox("* Zostałeś(aś) uleczony(a) przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), target)
	end
end)

addCommandHandler("spec", function(plr,cmd,cel,target)
	if getAdmin(plr) then
		if not cel then
			outputChatBox("#ff1100✘#ffffff Uzyj: /spec <id/nick>", plr, 255, 255, 255, true)
			return
		end

		local target = exports["nrpg_core"]:findPlayer(plr, cel)
		if not target then
			outputChatBox("#ff1100✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
			return
		end

		local x,y,z = getElementPosition(plr)
		setElementData(plr,"spec:pos",{x,y,z})

		removePedFromVehicle(plr)
		setElementInterior(plr, getElementInterior(target))
		setElementDimension(plr, getElementDimension(target))

		setTimer( function()
			setCameraTarget(plr, target)
		end, 100, 1)
	end
end)

addCommandHandler("specoff", function(plr,cmd)
	if getAdmin(plr) then
		local spec = getElementData(plr,"spec:pos")
		if not spec then setCameraTarget(plr, plr) return end
		setElementPosition(plr, spec[1], spec[2], spec[3])
		setCameraTarget(plr, plr)
	end
end)

addCommandHandler("inv", function(plr)
	if getAdmin(plr) then
		if getElementAlpha(plr) > 0 then
			setElementAlpha(plr,0)
		else
			setElementAlpha(plr,255)
		end
	end
end)


addCommandHandler("cv", function(plr, cmd, ...)
	if getElementData(plr,"player:job") then 
		exports.nrpg_interface:showPlayerNotification(plr, 'Nie ma komend administracyjnych w pracy!', 'error')
	return end
	if getAdmin(plr) then
	if (not ...) then
		exports.nrpg_interface:showPlayerNotification(plr, " Wpisz: /cv [nazwa]", "info")
		return
	end
	local model = table.concat ( { ... }, " " )
	if tonumber(model) then return end

	model = utf8.lower(model)

	if model == "rhino" or model == "hydra" or model == "hunter" or model == "police ls" or model == "police lv" or model == "police sf" or model == "Rhino" or model == "Hunter" or model == "Hydra" or model == "Police LS" or model == "Police LV" or model == "Police SF" then
	return end

	local dim = getElementDimension(plr)
	local x,y,z = getElementPosition(plr)
	local r1,r2,r3 = getElementRotation(plr)
	local model = getVehicleModelFromName(model)
	local vehicle = getPedOccupiedVehicle(plr)
	
	if getPedOccupiedVehicle(plr) then
		exports.nrpg_interface:showPlayerNotification(plr, "Nie możesz podmienić pojazdu!", "error")
	else
		pojazd = createVehicle(model, x, y, z, r1, r2, r3)
		setElementDimension(pojazd, dim)
		setElementData(pojazd, "vehicle:fuel", 100)
		setElementData(pojazd, "vehicle:bak", 100)
		setElementPosition(plr,x, y, z+1.5)
		setVehiclePlateText(pojazd, "RESPIONY")
		--addEventHandler("onVehicleExit", pojazd, function(plr,seat)
		--if seat ~= 0 then return end
		--destroyElement(source)
		--exports.nrpg_interface:showPlayerNotification(plr, "Pojazd usunięty.", "error")
	end
else
end
end)

addCommandHandler("dv", function(plr,cmd)
	if getAdmin(plr) then
		if getElementData(plr, "player:admin") then
			local veh=getPedOccupiedVehicle(plr)
			if not veh then
				outputChatBox("#ff1100✘#ffffff Musisz siedzieć w pojeździe.", plr, 0, 0, 0, true)
				return
			end
			if getElementData(veh,"vehicle:spawn") then
				outputChatBox("#ff1100✘#ffffff Nie możesz usunąć tego pojazdu!", plr, 0, 0, 0, true)
				return
			end
			destroyElement(veh)
			outputChatBox("#00ff00✔#ffffff Pomyślnie usunąłęś(aś) pojazd.", plr, 0, 0, 0, true)
		end
	end
end)

local stopChat = false

addCommandHandler("up", function(plr, cmd, value)
	if getAdmin(plr) then
        if (tonumber(value)==nil) then
            exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /up [ile]", "info")
            return
        end

        local e = plr
        if (isPedInVehicle(plr)) then
            e = getPedOccupiedVehicle(plr)
        end

        local x,y,z = getElementPosition(e)
        setElementPosition(e, x, y, z+tonumber(value))
    end
end)

addCommandHandler("thru", function(plr, cmd, value)
    if getAdmin(plr) then
        if (tonumber(value)==nil) then
            exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /thru [ile]", "info")
            return
        end

        local e = plr
        if getCameraTarget(plr) ~= plr then
            e = getCameraTarget(plr)
        end

        if (isPedInVehicle(plr)) then
            e = getPedOccupiedVehicle(e)
        end
		
        local x,y,z = getElementPosition(e)
        local _,_,rz = getElementRotation(e)
        local rrz = math.rad(rz)
        local x = x + (value * math.sin(-rrz))
        local y = y + (value * math.cos(-rrz))
        setElementPosition(e, x, y, z)
    end
end)


local zapisane_pozycje = {}
addCommandHandler("sp", function(plr,cmd)
	if getAdmin(plr) then
    local pos={}
    pos[1],pos[2],pos[3]=getElementPosition(plr)
    pos[4]=getElementInterior(plr)
    pos[5]=getElementDimension(plr)
	local uid = getElementData(plr,"player:sid")
    zapisane_pozycje[uid] = pos
    exports.nrpg_interface:showPlayerNotification(plr, "Pozycja została zapisana.", "success")
	end
end)

addCommandHandler("lp", function(plr,cmd)
	if getAdmin(plr) then
	local uid = getElementData(plr,"player:sid")
    local pos=zapisane_pozycje[uid]
    if (not pos) then
    exports.nrpg_interface:showPlayerNotification(plr, "Nie masz żadnej zapisanej pozycji.", "error")
    return
    end
	local veh = getPedOccupiedVehicle(plr)
	if veh then plr = veh end
    setElementPosition(plr,pos[1],pos[2],pos[3])
    setElementInterior(plr,pos[4])
    setElementDimension(plr,pos[5])
    pos=zapisane_pozycje[uid]
    exports.nrpg_interface:showPlayerNotification(plr, "Wczytano pozycję.", "success")
	end
end)

addCommandHandler("vinfo", function(plr,cmd,pojazd)
	if not getAdmin(plr) then outputChatBox("* Brak uprawnień!", plr) return end
    if not pojazd or not tonumber(pojazd) then
        exports.nrpg_interface:showPlayerNotification(plr, "Wpisz: /vinfo [id pojazdu]", "info")
        return
    end
    pojazd=tonumber(pojazd)
	local result = exports['nrpg_db']:dbGet("SELECT * FROM pystories_vehicles WHERE id=?",pojazd)
	if not result or #result < 1 then 
	exports.nrpg_interface:showPlayerNotification(plr, "Nie znaleziono podanego pojazdu!", "error")
	return end
	local query = exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE id=?",result[1].ownedPlayer)
    outputChatBox("* Pojazd ID " .. result[1].id .. ", model " .. result[1].model .. " ("..getVehicleNameFromModel(result[1].model)..")", plr)
    outputChatBox("* Własność gracza " .. query[1].login .. " ("..result[1].ownedPlayer..")", plr)
    outputChatBox("* Ostatni kierowca " .. result[1].driver .. "| Przebieg " .. result[1].mileage, plr)
    outputChatBox("* Paliwo " .. result[1].fuel .. " | Przechowalnia : " ..result[1].parking, plr)
end)


addCommandHandler("zatankuj", function(plr,cmd)
	if getAdmin(plr) then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			exports.nrpg_interface:showPlayerNotification(plr, "Nie znajdujesz się w pojeździe!", "error")
			return
		end
		setElementData(veh, "vehicle:fuel", (getElementData(veh, "vehicle:bak") or 25))
		exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zatankowałeś(aś) pojazd.", "success")
	end
end)




p, o, s = nil, nil, nil
dimtpev = nil
inttpev = nil

addCommandHandler("tpev.set", function(plr,cmd,...)
	if p ~= nil and o ~= nil and s ~= nil then return end
	if getAdmin(plr) then
		local msg=table.concat({...}, " ")
		if not msg then
			return
		end
		outputChatBox(" ", root, 255, 255, 255, true)
		outputChatBox("ⓘ#ffffff "..getPlayerName(plr):gsub("#%x%x%x%x%x%x", "").." utworzył/a teleport - "..msg.."", root, 255, 255, 0, true)
		outputChatBox("ⓘ#ffffff Użyj /tpev aby się tam przenieść", root, 255, 255, 0, true)
		outputChatBox(" ", root, 255, 255, 255, true)
		setElementData(root, "event", true)
		p, o, s = getElementPosition(plr)
		dimtpev = getElementDimension(plr)
		inttpev = getElementInterior(plr)
	end
end)

addCommandHandler("tpev.del", function(plr,cmd)
	if getAdmin(plr) then
		outputChatBox("ⓘ#ffffff "..getPlayerName(plr):gsub("#%x%x%x%x%x%x", "").." zamyka teleport!", root, 255, 255, 0, true)
		p, o, s = nil, nil, nil
	end
end)


addCommandHandler("tpev", function(plr,cmd)
	if p ~= nil and o ~= nil and s ~= nil then
	local veh = getPedOccupiedVehicle(plr)
    if getElementData(plr, "player:job") then return end
    if getElementData(plr, "player:jail") then exports.nrpg_interface:showPlayerNotification(plr, "Nie możesz użyć tpev podczas pobytu w więzieniu!", "error") return end
		if veh then
            if not getElementData(veh, "vehicle:id") then return end
            if getElementData(veh, "vehicle:ownedPlayer") ~= getElementData(plr, "player:sid") then return end
			local id = getElementData(veh, "vehicle:id")
			exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET parking=1, tp_to_parking=? WHERE id=?", "TPEV", id)
			exports["nrpg_vehicles"]:onSaveVehicle(veh)
			destroyElement(veh)
			removePedFromVehicle(plr)
		end

		setElementPosition(plr, p, o, s)
		setElementInterior(plr, inttpev)
		setElementDimension(plr, dimtpev)
	end
end)

addCommandHandler("ranga", function(plr, cmd, target, numer)
if getAdmin(plr,4) then

if not target or not numer or not tonumber(numer) then
outputChatBox("0 - #7F7F7FDegrad#FFFFFF, 1 - #02a000 Supporter#FFFFFF, 3 - #ff0004Administrator#FFFFFF, 4 - #ff9600Administrator RCON#FFFFFF, 5 - #880000Zarzad#FFFFFF.", plr, 255, 255, 255, true)
return end

if tonumber(numer) > 4 or tonumber(numer) < 0 then
outputChatBox("0 - #7F7F7FDegrad#FFFFFF, 1 - #02a000 Supporter#FFFFFF, 3 - #ff0004Administrator#FFFFFF, 4 - #ff9600Administrator RCON#FFFFFF, 5 - #880000Zarzad#FFFFFF.", plr, 255, 255, 255, true)
return end

local gracz = exports["nrpg_core"]:findPlayer(plr, target)
if not gracz then outputChatBox("✘#ffffff Nie ma takiego gracza!", plr, 255, 0, 0, true) end
local serial = getPlayerSerial(gracz)

if tonumber(numer) == 0 then
ranga = "#7F7F7FGracz"
elseif tonumber(numer) == 1 then
ranga = "#02a000Supporter"
elseif tonumber(numer) == 2 then
ranga = "#ff0004Administrator"
elseif tonumber(numer) == 3 then
ranga = "#ff9600Administrator RCON"
elseif tonumber(numer) == 4 then
ranga = "#880000Zarząd"
end

local sel = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_admins WHERE serial = ?", serial)

if sel and #sel > 0 then
if tonumber(numer) == 0 then
exports['nrpg_db']:dbSet("DELETE from pystories_admins where serial = ?", serial)
setElementData(gracz,"player:admin",false)
setElementData(gracz,"player:level",false)
triggerEvent("save:player", root, gracz)
triggerEvent("load:player", root, gracz)
setPlayerName(gracz, getPlayerName(gracz):gsub("#%x%x%x%x%x%x",""))
outputChatBox("✔#ffffff Zmieniono rangę. Gracz: #FF9C00"..getPlayerName(gracz):gsub("#%x%x%x%x%x%x","").."#ffffff, Nowa ranga: "..ranga.."", plr, 0, 255, 0, true)
outputChatBox("✘#ffffff Zostałeś/aś zdegradowany do rangi: "..ranga.." przez #FF9C00"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#ffffff!", gracz, 255, 0, 0, true)
return end
exports['nrpg_db']:dbSet("UPDATE pystories_admins set level = ? where serial = ?", numer, serial)
outputChatBox("✔#ffffff Zmieniono rangę. Gracz: #FF9C00"..getPlayerName(gracz):gsub("#%x%x%x%x%x%x","").."#ffffff, Nowa ranga: "..ranga.."", plr, 0, 255, 0, true)
outputChatBox("✔#ffffff Zostałeś/aś awansowany/a przez #FF9C00"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#ffffff na rangę "..ranga.."", gracz, 0, 255, 0, true)
else
if tonumber(numer) == 0 then outputChatBox("✘#ffffff Ta osoba nie posiada rangi!", plr, 255, 0, 0, true) return end
exports["nrpg_db"]:dbSet("INSERT INTO pystories_admins (serial, date, level, uid) VALUES (?,?,?,?)", serial, getPlayerName(gracz):gsub("#%x%x%x%x%x%x",""), numer, getElementData(gracz, "player:sid"))
outputChatBox("✔#ffffff Zmieniono rangę. Gracz: #FF9C00"..getPlayerName(gracz):gsub("#%x%x%x%x%x%x","").."#ffffff, Nowa ranga: "..ranga.."", plr, 0, 255, 0, true)
outputChatBox("✔#ffffff Zostałeś/aś awansowany/a przez #FF9C00"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#ffffff na rangę "..ranga.."", gracz, 0, 255, 0, true)
end
end
end)

walizka = {}

nagrody = {

	[1] = "10 SRP",
	[2] = "500,000 PLN",
	[3] = "5 SRP",
	[4] = "100,000 PLN",
	[5] = "1 Klucz do skrzyni",
	[6] = "250,000 PLN",
	[7] = "1,000,000 PLN",
	[8] = "5,000,000 PLN",
	[9] = "50 SRP",
	[10] = "100 SRP",

}

function rozdajNagrode(plr, nagroda)
	local actualSRP = getElementData(plr, "player:srp") or 0
	local actualKEYS = getElementData(plr, "player:keys") or 0
	if nagroda == 1 then
		setElementData(plr, "player:srp", actualSRP+10)
	elseif nagroda == 2 then
		givePlayerMoney(plr, 500000)
	elseif nagroda == 3 then
		setElementData(plr, "player:srp", actualSRP+5)
	elseif nagroda == 4 then
		givePlayerMoney(plr, 100000)
	elseif nagroda == 5 then
		setElementData(plr, "player:keys", actualKEYS+1)
	elseif nagroda == 6 then
		givePlayerMoney(plr, 250000)
	elseif nagroda == 7 then
		givePlayerMoney(plr, 1000000)
	elseif nagroda == 8 then
		givePlayerMoney(plr, 5000000)
	elseif nagroda == 9 then
		setElementData(plr, "player:srp", actualSRP+50)
	elseif nagroda == 10 then
		setElementData(plr, "player:srp", actualSRP+100)
	end
end

addCommandHandler ( "walizka", function(plr,cmd,...)
	if ... then
		if getAdmin(plr, 2) or getAdmin(plr, 3) or getAdmin(plr, 4) then
			if isElement(walizka[plr]) then exports.nrpg_interface:showPlayerNotification(plr, 'Już porzuciłeś/aś jedną walizkę', 'error') return end
			x, y, z = getElementPosition ( plr )
			msg = table.concat ( {...}, " " )
			walizka[plr] = createPickup ( x, y, z, 3, 1210, 0, 0 )
			setElementData(walizka[plr], "wygrana", math.random(1,10))
			triggerClientEvent(root, "admin:rendering", root, ""..getPlayerName(plr).." porzucił/a walizkę z nieznajomą zawartością\nPodpowiedź: "..msg.."", "walizka")
		end
	end
	
	
	addEventHandler ( "onPickupHit", walizka[plr], function(gracz)
	if plr == gracz then exports.nrpg_interface:showPlayerNotification(gracz, 'Nie możesz zebrać swojej walizki', 'error') return end
	if getElementData(gracz, "player:faction") then exports.nrpg_interface:showPlayerNotification(gracz, 'Nie możesz zebrać walizki na służbie frakcji', 'error') return end
		local nagroda = nagrody[(getElementData(walizka[plr], "wygrana") or 1)]
		local nagrodaNumber = tonumber(getElementData(walizka[plr], "wygrana"))
		triggerClientEvent(root, "admin:rendering", root, "Gracz "..getPlayerName(gracz).." znalazł porzuconą walizkę\nA w niej znajduje w niej "..nagroda.."", "walizka")
		rozdajNagrode(gracz, nagrodaNumber)
		if isElement(walizka[plr]) then
			destroyElement(walizka[plr])
		end
	end)
end)
	

addEventHandler("onPlayerQuit", root, function()
	if isElement(walizka[source]) then
		destroyElement(walizka[source])
	end
end)
