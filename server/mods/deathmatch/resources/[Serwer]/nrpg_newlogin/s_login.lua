--[[

    @author: TheNoobisty <thenoobisty@gmail.com>
    @resource: nrpg_login
    @description: Login Panel
    @file: s_login.lua

    @info: Zakazuje się używania bądź edycji kodu bez zgody autora w przeciwnym razie sprawa zostanie skierowana do sądu.

]]--

addEvent("loginAccount", true)
addEventHandler("loginAccount", root, function(login,pass)
	local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE login=?", login)
	if result and #result > 0 then
		if result[1].login == login and result[1].pass == teaEncode(pass, "redskilltojebanykretyniokradadziecinakase") then
			setElementData(client, "new:sid", result[1].id)

			local queryB = string.format("SELECT * FROM pystories_users WHERE id=%d AND premiumplusdate>NOW() LIMIT 1", getElementData(client,"new:sid"))
			local resultB = exports["DB2"]:pobierzWyniki(queryB)
			if (resultB) then
				setElementData(client,"player:premiumplus", true)
				setElementData(client,"player:premiumplusdate", result[1].premiumplusdate)
			else
				setElementData(client,"player:premium", true)
				setElementData(client,"player:premiumdate", "Na zawsze")
			end

			local result_ban = exports['nrpg_db']:dbGet('SELECT * FROM pystories_ban WHERE active=1 AND uid=? AND time>NOW() LIMIT 1;', result[1].id)
			if #result_ban > 0 then
				if result_ban[1].time == "2030-12-31 23:59:59" then
					kickPlayer(client, client, "Omijanie bana (Perm.).")
					exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,?,?,1)", result[1].id, getPlayerName(client), "System", getPlayerSerial(client), "Omijanie bana", "2030-12-31 23:59:59", "ban")
					triggerClientEvent(root, "admin:rendering", root, ""..getPlayerName(client).." ("..login..") został(a) automatycznie zbanowany(a) na zawsze. Powód: Omijanie bana.")
				else
					result3 = pobierzDate("d",7)
					exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,?,?,1)", result[1].id, getPlayerName(client), "System", getPlayerSerial(client), "Omijanie bana", result3, "ban")
					kickPlayer(client, client, "Omijanie bana (7 dni).")
				end
			end

			local sprpos = exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(client,"new:sid"))
			if sprpos[1].ostatnia_pozycja:len() > 1 then
				local pozycja = split(sprpos[1].ostatnia_pozycja, ", ")
				local x2, y2, z2, interior, dimension = pozycja[1], pozycja[2], pozycja[3], pozycja[4], pozycja[5]
				setElementData(client, "ostatnia:pozycja", {x2, y2, z2, interior, dimension})
			end

			local org = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE uid=? LIMIT 1", getElementData(client,"new:sid")) -- pobieramy tylko JEDEN rekord
			if org and #org > 0 then
				setElementData(client, "player:organization", org[1].code)
				local orgtag = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje_info WHERE nazwa=? LIMIT 1", org[1].code) -- pobieramy tylko JEDEN rekord
				if orgtag and #orgtag > 0 then
					setElementData(client, "player:organizationtag", orgtag[1].tag)
					outputChatBox("✔ #ffffffJesteś w organizacji "..org[1].code.." ("..orgtag[1].tag..")", client, 0, 255, 0, true)	 
					exports['nrpg_db']:dbSet("UPDATE pystories_organizacje SET aktywny=curdate() WHERE uid=?", getElementData(client,"new:sid"))

					local pozycja = split(orgtag[1].spawn, ", ")
					local x2, y2, z2, interior, dimension = pozycja[1], pozycja[2], pozycja[3], pozycja[4], pozycja[5]
					setElementData(client, "organizacja:spawn", {x2, y2, z2, interior, dimension})
				end
			end

			exports['nrpg_discord']:connectWeb("**"..getPlayerName(client):gsub("#%x%x%x%x%x%x","").."** loguje się na konto **"..result[1].login:gsub("#%x%x%x%x%x%x","").."** (Numer seryjny: **"..getPlayerSerial(client).."**)", "Logowania") 
			
			--triggerEvent("SprawdzDom", root, client)
			setPlayerName(client, ""..result[1].login:gsub("#%x%x%x%x%x%x","").."")
			triggerClientEvent(client, "loginResult", resourceRoot, client, true)
			triggerEvent("loadPlayerSettings", client, client)
            exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie zalogowano", "success")
			getFriends(client)
		else
			exports.nrpg_interface:showPlayerNotification(client, "Podane dane nie są prawidłowe!", "error")
		end
	end
end)

addEvent("registerAccount", true)
addEventHandler("registerAccount", root, function(login, pass, email)
	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE register_serial=?", getPlayerSerial(client))
	if result and #result >= 1 then
		exports.nrpg_interface:showPlayerNotification(client, "Osiągasz limit kont - 1 konto", "error")
	return end

	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE login=?", login)
	if result and #result > 0 then
		exports.nrpg_interface:showPlayerNotification(client, "Podany login już istnieje!", "error")
	return end

    local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE email=?", email)
	if result and #result > 0 then
		exports.nrpg_interface:showPlayerNotification(client, "Podany adres E-Mail jest przypisany do innego konta", "error")
	else
		local query = exports["nrpg_db"]:dbSet("INSERT INTO pystories_users (login,pass,register_serial,email,changedpw) VALUES (?,?,?,?,?)", login:gsub("#%x%x%x%x%x%x",""), teaEncode(pass,"redskilltojebanykretyniokradadziecinakase"), getPlayerSerial(client), tostring(email), 1)
		exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie utworzono konto!", "success")
		randomPassCode(client, getPlayerSerial(client))
	end
end)

addEvent("showUpdatesLogin", true)
addEventHandler("showUpdatesLogin", root, function()
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_aktualizacje ORDER BY id DESC")
	triggerClientEvent(client, "clientShowLoginUpdates", client, spr)
end)

addEvent("quitServerBan", true)
addEventHandler("quitServerBan", root, function(plr)
	kickPlayer(plr, plr, "Opuszczono serwer")
end)

addEvent("loginCheckBan", true)
addEventHandler("loginCheckBan", root, function(plr)
	local playerSerial = getPlayerSerial(plr)
	local result = exports['nrpg_db']:dbGet('SELECT * FROM pystories_ban WHERE active=1 AND serial=? AND time>NOW() LIMIT 1;', playerSerial)
	if #result > 0 then
		setElementData(plr, "player:banInfo", {nadawca=result[1].nadawca, czas=result[1].time, powod=result[1].reason, nadany=result[1].nick, serial=result[1].serial, sid=result[1].uid})
		triggerClientEvent(plr, "loginBanResult", resourceRoot, plr, true)
	else
		triggerClientEvent(plr, "loginBanResult", resourceRoot, plr, false)
		exports["nrpg_db"]:dbSet("DELETE FROM pystories_ban WHERE type=? AND active=1 AND serial=?", "ban", playerSerial)
	end
end)

function getFriends(plr)
	local friendsList = loadFriends(plr)
	local lista = {}

	for i,v in ipairs(friendsList) do
		table.insert(lista, {v.sid, v.friendsid})
	end

	setTimer( function()
		setElementData(plr, "player:friends", lista)
	end, 1000, 1)
end

function loadFriends(plr)
	local player_sid = getElementData(plr, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_friends WHERE sid=?", player_sid)

	if spr then
		return spr
	end
end

function loadFriendTable(source)
	local friendsList = loadFriends(source)
	local lista = {}
	for i,v in ipairs(friendsList) do
		table.insert(lista, {friendSID=v.friendsid})
	end

	setTimer( function()
		setElementData(source, "player:friends", lista)
	end, 1000, 1)
end

function generateCode()
	local random = math.random(500, 1000)
	local random2 = math.random(500, 1000)
	local random3 = math.random(500, 1000)

	if random and random2 and random3 then
		return math.floor((random+random2+random3))
	end
end

function randomPassCode(plr, serial)
	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE login=?", login)
	if #result > 0 then
		return false
	else
		local theCode = generateCode()
		exports["nrpg_db"]:dbSet("UPDATE pystories_users SET code=? WHERE login=?", theCode, login)
		exports.nrpg_interface:showPlayerNotification(client, "Twój kod odzyskiwania to: "..theCode.." - Pojawia się tylko raz, zapisz go!", "info")
	end
end