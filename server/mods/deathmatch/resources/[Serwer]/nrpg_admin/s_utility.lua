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

function getAdmin(plr,level)
	if getElementData(plr,"TheNoobisty") then return true end
	if level then
		local result=exports["nrpg_db"]:dbGet("SELECT * from pystories_admins WHERE serial=? AND level=?", getPlayerSerial(plr), level)
		if result and #result > 0 then
			return true
		else
			return false
		end
	else
		local result=exports["nrpg_db"]:dbGet("SELECT * from pystories_admins WHERE serial=?", getPlayerSerial(plr))
		if result and #result > 0 then
			return true
		else
			return false
		end
	end
end

function getPremiump(plr,level)
	if getElementData(plr,"TheNoobisty") then return true end
	if level then
		local result=exports["nrpg_db"]:dbGet("SELECT * from pystories_premium WHERE serial=? AND level=?", getPlayerSerial(plr), level)
		if result and #result > 0 then
			return true
		else
			return false
		end
	else
		local result=exports["nrpg_db"]:dbGet("SELECT * from pystories_premium WHERE serial=?", getPlayerSerial(plr))
		if result and #result > 0 then
			return true
		else
			return false
		end
	end
end


addCommandHandler("tppos", function(plr,cmd,x,y,z)
if getAdmin(plr) then
	x,y,z = tonumber(x),tonumber(y),tonumber(z)
	if not x or not y or not z then
		outputChatBox("Podaj pozycje x y z!", plr, 255, 255, 255)
		return
	end
	setElementPosition(plr,x,y,z)
	outputChatBox("Przeniesiono!", plr, 255, 255, 255)
end
end)

addCommandHandler("m", function(plr,cmd,cel,x,bantype,...)
	if getAdmin(plr) then
		local reason = table.concat({...}, " ")
		if not cel or not tonumber(x) or not bantype or not reason then
			outputChatBox("* Użycie: /m <nick/ID> <ilość> <m/h/d> <powód>", plr)
			return
		end
		local target = exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			return outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 255, 255)
		end
		
		reason = reason..""
		if bantype == "m" or bantype == "h" or bantype == "d" then
			if bantype == "m" then
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? minute,?)", getPlayerSerial(target),reason, x, "mute")
			elseif bantype == "h" then
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? hour,?)", getPlayerSerial(target),reason, x, "mute")
			elseif bantype == "d" then
				exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,NOW() + INTERVAL ? day,?)", getPlayerSerial(target),reason, x, "mute")
			end
		end
		outputChatBox("* Otrzymałeś/aś blokadę możliwości pisania na czacie od administracji! Od: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255,0,0)
		outputChatBox("* Powód: "..reason.."", target, 255,0,0)
		triggerEvent("save:player",root,target)
		triggerEvent("load:player",root,target)
		setElementData(target, "mute:player", true)
		triggerClientEvent(root, "admin:rendering", root, "Gracz ("..getElementData(target,"id")..") "..getPlayerName(target).." został wyciszony przez ("..getElementData(plr,"id")..") "..getPlayerName(plr).."\nPowód wyciszenia: "..reason.."\nCzas: "..x .. bantype.."")
		exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] został/a wyciszony/a przez **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**] z powodem: "..reason..", czas trwania kary: "..x .. bantype.."", "kary-adm")
	
	end
end)

addCommandHandler("um", function(plr,cmd,cel)
	if getAdmin(plr) then
		if not cel then
			outputChatBox("* Użycie: /um <nick/ID> ", plr)
			return
		end
		local target=exports["nrpg_core"]:findPlayer(plr,cel)
		if not target then
			return
		end
		setElementData(target, "mute:player", false)
		local query=string.format("SELECT * FROM pystories_punish WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","mute", getPlayerSerial(target))
		local result=exports["DB"]:pobierzWyniki(query)
		if (result) then
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_punish WHERE type=? AND active=1 AND serial=?", "mute", getPlayerSerial(target))
			outputChatBox("* "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." oddal Ci możliwość pisania!", target, 0, 255, 0)
			exports['nrpg_discord']:connectWeb("**"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(target,"player:sid").."**] został/a odciszony/a przez **"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** [SID: **"..getElementData(plr, "player:sid").."**].", "kary-adm")
		else
			outputChatBox("* "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." nie posiada blokady mute!", plr, 0, 255, 0)
		end
	end
end)

addCommandHandler("schowaj", function(plr,cmd,id)
if getAdmin(plr) then
    if not id or not tonumber(id) then
        outputChatBox("* Podaj id pojazdu!", plr, 255, 0, 0)
        return
    end
    exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET parking=1,tp_to_parking=? WHERE id=?",getPlayerName(plr), id)
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v,"vehicle:id") == tonumber(id) then
		exports["nrpg_vehicles"]:onSaveVehicle(v)
		destroyElement(v)
		outputChatBox("* Pojazd został przeniesiony do przechowywalni!", plr, 0, 255, 0)
		end
	end
end
end)


addCommandHandler("logs", function(plr,cmd,cel,value)
	if getAdmin(plr) then
		if not getElementData(plr, "player:logs") then
			setElementData(plr, "player:logs", true)
		else
			setElementData(plr, "player:logs", false)
		end
	end
end)

addCommandHandler("rapsy", function(plr,cmd,cel,value)
	if getAdmin(plr) then
		if not getElementData(plr, "player:raps") then
			setElementData(plr, "player:raps", true)
		else
			setElementData(plr, "player:raps", false)
		end
	end
end)


addCommandHandler("duty", function(plr,cmd)
	if getAdmin(plr) then
		if not getElementData(plr,"player:admin") then
			giveWeapon(plr,22)
			toggleControl(plr,"fire",true)
			toggleControl(plr,"aim_weapon",true)
			if getAdmin(plr, 1) then
			  setElementData(plr,"player:level",1)
			  exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zalogowałeś(aś) się na rangę '#02a000Support#FFFFFF'", "info")
			elseif getAdmin(plr, 2) then
			  setElementData(plr,"player:level",2)
			  exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zalogowałeś(aś) się na rangę '#ff0004Administrator#FFFFFF'", "info")
			  setElementData(plr, "player:wlasciciel", true)
		    elseif getAdmin(plr, 3) then
			  setElementData(plr,"player:level",3)
			  exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zalogowałeś(aś) się na rangę '#ff9600Administrator RCON#FFFFFF'", "info")
	          setElementData(plr, "player:wlasciciel", true)
			elseif getAdmin(plr, 4) then
			  setElementData(plr,"player:level",4)
			  exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zalogowałeś(aś) się na rangę '#880000Zarząd#FFFFFF'", "info")
	          setElementData(plr, "player:wlasciciel", true)
	          setElementData(plr, "player:wlasciciell", true)
			end
			setElementData(plr,"player:admin",true)
			  outputChatBox("#FFFFFF############FFFFFF", plr, 0, 0, 0, true)
			  outputChatBox("#ffff00ⓘ #FFFFFFAby włączyć logi i listę reportów wpisz #ffff00/logs#FFFFFF.", plr, 0, 0, 0, true)
			  outputChatBox("#ffff00ⓘ #FFFFFFAby włączyć listę reportów wpisz #ffff00/rapsy#FFFFFF.", plr, 0, 0, 0, true)
			  outputChatBox("#ffff00ⓘ #FFFFFFAby zobaczyć komendy wpisz #ffff00/komendy#FFFFFF.", plr, 0, 0, 0, true)
			  outputChatBox("#FFFFFF############FFFFFF", plr, 0, 0, 0, true)
			setElementData(plr,"player:ucho",true)
		else
			takeWeapon(plr,22)
			toggleControl(plr,"fire",false)
			toggleControl(plr,"aim_weapon",false)
			removeElementData(plr,"player:admin")
			removeElementData(plr,"player:level")
			setElementData(plr, "player:wlasciciell", false)
			setElementData(plr,"player:ucho",false)
			setElementData(plr, "player:wlasciciel", false)
			exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie wylogowałeś(aś) się z służby administracji serwera.", "info")
		end
	else
		outputChatBox("* Nie posiadasz uprawnień.", plr, 255, 0, 0, true)
	end
end)

scianarapsow = createObject ( 16637,-1931.6,883.27,35.41 )
setObjectScale(scianarapsow,3)
setElementDimension(scianarapsow,9999)
reportView = {{"Ściana Raportów:",0}}
setElementData(scianarapsow,"sciana:raportow",reportView)

addEvent("admin:addReport", true)
addEventHandler("admin:addReport", root, function(text,id)
	table.insert(reportView, {text,id})
	if #reportView > 17 then
		table.remove(reportView, 2)
	end
	setElementData(scianarapsow,"sciana:raportow",reportView)
end)

addEvent("admin:removeReport", true)
addEventHandler("admin:removeReport", root, function(id)
	for i=#reportView, 2, -1 do
		if reportView[i][2] == id then
			table.remove(reportView,i)
		end
	end
	setElementData(scianarapsow,"sciana:raportow",reportView)
end)

scianatext = createObject ( 981,0,0,0 )
textView = {{"Logi Serwerowe:",0}}
setElementDimension(scianatext,9999)
setElementData(scianatext,"sciana:text",textView)


addEvent("admin:addText", true)
addEventHandler("admin:addText", root, function(text,id)
	table.insert(textView, {text,id})
	if #textView > 15 then
		table.remove(textView, 2)
	end
	setElementData(scianatext,"sciana:text",textView)
end)


addEvent("admin:removeText", true)
addEventHandler("admin:removeText", root, function(id)
	for i=#textView, 2, -1 do
		if textView[i][2] == id then
			table.remove(textView,i)
		end
	end
	setElementData(scianatext,"sciana:text",textView)
end)

addCommandHandler("raport", function(plr,cmd,cel,...)
	if not getElementData(plr,"player:sid") then return end
	if not cel then
		return
	end
	local target=exports["nrpg_core"]:findPlayer(plr,cel)
	if not target then
		return
	end

	if getElementData(plr, "spam:blokada:report", true) then return outputChatBox("* Zgłoszenie możesz wysyłać raz na 30 sekund!", plr, 255, 0, 30) end
	setElementData(plr, "spam:blokada:report", true)
	if getElementData(plr, "spam:blokada:report") then
		setTimer(function(plr)
			if isElement(plr) then
				setElementData(plr,"spam:blokada:report", false)
			end
		end, 30000, 1, plr)
	end

	local text=table.concat({...}, " ")
	if not text then return end
	desc="[#1DD200"..getElementData(plr,"id").."#ffffff] #1DD200"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#ffffff >> [#CFE200"..getElementData(target,"id").."#ffffff] #CFE200"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."#ffffff: "..text:gsub("#%x%x%x%x%x%x","")
	triggerEvent("admin:addReport", resourceRoot, desc, getElementData(plr,"id"))
	exports.nrpg_interface:showPlayerNotification(plr, "Twoje zgłoszenie zostało wysłane, poczekaj aż ktoś się tym zajmie.", "info")

end)

addCommandHandler("report", function(plr,cmd,cel,...)
	if not getElementData(plr,"player:sid") then return end
	if not cel then
		return
	end
	local target=exports["nrpg_core"]:findPlayer(plr,cel)
	if not target then
		return
	end
	
	if getElementData(plr, "spam:blokada:report", true) then return outputChatBox("* Zgłoszenie możesz wysyłać raz na 30 sekund!", plr, 255, 0, 30) end
	setElementData(plr, "spam:blokada:report", true)
	if getElementData(plr, "spam:blokada:report") then
		setTimer(function(plr)
			if isElement(plr) then
				setElementData(plr,"spam:blokada:report", false)
			end
		end, 30000, 1, plr)
	end

	local text=table.concat({...}, " ")
	if not text then return end
	desc="[#1DD200"..getElementData(plr,"id").."#ffffff] #1DD200"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#ffffff >> [#CFE200"..getElementData(target,"id").."#ffffff] #CFE200"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."#ffffff: "..text:gsub("#%x%x%x%x%x%x","")
	triggerEvent("admin:addReport", resourceRoot, desc, getElementData(plr,"id"))
	exports.nrpg_interface:showPlayerNotification(plr, "Twoje zgłoszenie zostało wysłane, poczekaj aż ktoś się tym zajmie.", "info")
	

end)

addCommandHandler("clp", function(plr,cmd,id,...)
	if not getAdmin(plr) then
		return
	end

	local reason = table.concat({...}, " ")

	if not id then return outputChatBox("ⓘ#ffffff /clp <id> <odpowiedź>", plr, 255, 255, 0, true) end
	if not reason then return outputChatBox("ⓘ#ffffff /clp <id> <odpowiedź>", plr, 255, 255, 0, true) end
	
	local target = exports["nrpg_core"]:findPlayer(plr, id)

	opis = "Użytkownik offline"
	if target then
		id = getElementData(target,"id")
		opis = getPlayerName(target)
		if target ~= plr and not getAdmin(target) then
		end
	end

	if findReport(id) ~= true then outputChatBox("ⓘ#ffffff Nie ma takiego zgłoszenia", plr, 255, 255, 0, true) return end
	if opis == "Użytkownik offline" then outputChatBox("ⓘ#ffffff Nie ma takiego gracza", plr, 255, 0, 0, true) return end
	
	if target == plr then 
		exports['nrpg_discord']:connectWeb("**"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** __przyjmuje__ zgłosznie sam na siebie", "Reporty") 
		outputChatBox("ⓘ#ffffff Nie możesz przyjąć swojego zgłoszenia", plr, 255, 0, 0, true)
	return end


	if reason == "" or reason == " " then
	reason = "#C00004Brak#ffffff"
	end

	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"player:admin") then
				triggerEvent("admin:removeReport", resourceRoot, id)
				local raporcik = getElementData(plr, "admin:reporty") or 0
				outputChatBox("ⓘ#ffffff "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." #22D000przyjmuje#ffffff zgłoszenie gracza "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..". Odpowiedź: "..reason.."", v, 255, 255, 0, true)
		end
	end
	exports['nrpg_discord']:connectWeb("**"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** __przyjmuje__ zgłoszenie gracza **"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."**. Odpowiedź: "..reason:gsub("#%x%x%x%x%x%x","").."", "Reporty")

	exports['nrpg_db']:dbSet("UPDATE pystories_admins SET reporty=reporty+1 WHERE serial=?", getPlayerSerial(plr))

	outputChatBox("ⓘ#ffffff Twoje zgłoszenie zostało #22D000przyjęte#ffffff przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 255, 0, true)
	outputChatBox("ⓘ#ffffff Odpowiedź: "..reason or "Brak".."", target, 255, 255, 0, true)

end)

addCommandHandler("clo", function(plr,cmd,id,...)
	if not getAdmin(plr) then
		return
	end

	local reason = table.concat({...}, " ")

	if not id then return outputChatBox("ⓘ#ffffff /clo <id> <odpowiedź>", plr, 255, 255, 0, true) end
	if not reason then return outputChatBox("ⓘ#ffffff /clo <id> <odpowiedź>", plr, 255, 255, 0, true) end
	
	local target = exports["nrpg_core"]:findPlayer(plr,id)


	opis = "Użytkownik offline"
	if target then
		id = getElementData(target,"id")
		opis = getPlayerName(target)
		if target ~= plr and not getAdmin(target) then
		end
	end

	if findReport(id) ~= true then outputChatBox("ⓘ#ffffff Nie ma takiego zgłoszenia", plr, 255, 255, 0, true) return end
	if opis == "Użytkownik offline" then outputChatBox("ⓘ#ffffff Nie ma takiego gracza", plr, 255, 0, 0, true) return end

	if target == plr then 
		exports['nrpg_discord']:connectWeb("**"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** __odrzucił/a__ zgłosznie sam na siebie", "Reporty") 
		outputChatBox("ⓘ#ffffff Nie możesz odrzucić swojego zgłoszenia", plr, 255, 0, 0, true)
	return end


	if reason == "" or reason == " " then
	reason = "#C00004Brak#ffffff"
	end

	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"player:admin") then
				triggerEvent("admin:removeReport", resourceRoot, id)
				local raporcik = getElementData(plr, "admin:reporty") or 0
				outputChatBox("ⓘ#ffffff "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." #C00004odrzucił/a#ffffff zgłoszenie gracza "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..". Odpowiedź: "..reason.."", v, 255, 255, 0, true)
		end
	end
	exports['nrpg_discord']:connectWeb("**"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."** __odrzucił/a__ zgłoszenie gracza **"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."**. Odpowiedź: "..reason:gsub("#%x%x%x%x%x%x","").."", "Reporty")

	exports['nrpg_db']:dbSet("UPDATE pystories_admins SET reporty=reporty+1 WHERE serial=?", getPlayerSerial(plr))

	outputChatBox("ⓘ#ffffff Twoje zgłoszenie zostało #C00004odrzucone#ffffff przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 255, 0, true)
	outputChatBox("ⓘ#ffffff Odpowiedź: "..reason or "Brak".."", target, 255, 255, 0, true)

end)


addEventHandler( "onPlayerQuit", getRootElement(), function()
	if getElementData(source, "id") then
		triggerEvent("admin:removeReport", resourceRoot, getElementData(source, "id"))
	end
end)

function findReport(id)
	for i=#reportView, 2, -1 do
		if reportView[i][2] == id then
			return true
		end
	end
end

function table.find(tabl, word) 
	if type(tabl) ~= "table" or word == nil then 
		return false 
	else 
		local ret = false 
		for k,v in pairs(tabl) do 
    		if v == word then 
    			return k 
    		end 
		end 
	end 
end