addEvent("pokazPracownikowBiznes", true)
addEventHandler("pokazPracownikowBiznes", root, function()
	local spr = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_admins")
	triggerClientEvent(client, "pokazPracownikowBiznesClient", client, spr)
end)

addEvent("graczePanelAdm", true)
addEventHandler("graczePanelAdm", root, function()
	local spr = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users")
	triggerClientEvent(client, "graczePanelAdmClient", client, spr)
end)

addEvent("pojazdyPrzechoPanelAdm", true)
addEventHandler("pojazdyPrzechoPanelAdm", root, function()
	local spr = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles WHERE parking=0")
	triggerClientEvent(client, "pojazdyPrzechoPanelAdmClient", client, spr)
end)

addEvent("pojazdyPanelAdm", true)
addEventHandler("pojazdyPanelAdm", root, function()
	local spr = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles")
	triggerClientEvent(client, "pojazdyPanelAdmClient", client, spr)
end)

addEvent("sumaKontDiscord", true)
addEventHandler("sumaKontDiscord", root, function()
	local spr = exports["nrpg_db"]:dbGet("SELECT * FROM discord_connect")
	triggerClientEvent(client, "sumaPolaczonychKont", client, spr)
end)

addEvent("wybranyAdmin", true)
addEventHandler("wybranyAdmin", root, function(uid)
	local spr = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_admins WHERE uid=?", uid)
	if #spr > 0 then
		triggerClientEvent(client, "wybranyAdminClient", client, spr)
		for i, v in ipairs(getElementsByType("player")) do
			if spr[1].dbid == getElementData(v, "player:sid") then
				triggerClientEvent(client, "wybranyAdminClient", client, spr[1].dbid)
			end
		end
	end
end)

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
	return date..time
end

addEvent("ev",true)
addEventHandler("ev",resourceRoot, function(ev,serial,powod,time,type,nick,uid)			
	if (ev=="mute") then
		result1=pobierzDate(type,time)
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,?,?)", serial, powod, result1, "mute")
		triggerClientEvent(root, "admin:rendering", root, ""..nick.." został/a wyciszonya przez ["..getElementData(client,"id").."] "..getPlayerName(client):gsub("#%x%x%x%x%x%x","")..".\nPowód: "..powod.."\nCzas: "..time .. type .."")
		
	elseif (ev=="prawko") then
		result2=pobierzDate(type,time)
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,?,?)", serial, powod, result2, "A")
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,?,?)", serial, powod, result2, "B")
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_punish (serial,reason,time,type) VALUES (?,?,?,?)", serial, powod, result2, "C")
		triggerClientEvent(root, "admin:rendering", root, ""..nick.." otrzymał/a zakaz prowadzenia pojazdów w panelu administracji przez ["..getElementData(client,"id").."] "..getPlayerName(client):gsub("#%x%x%x%x%x%x","")..".\nPowód: "..powod.."\nCzas: "..time .. type .."")
		
	elseif (ev=="ban") then
		if exports['nrpg_admin']:getAdmin(client,5) or exports['nrpg_admin']:getAdmin(client,4) or exports['nrpg_admin']:getAdmin(client,3) or exports['nrpg_admin']:getAdmin(client,2) then
			result3=pobierzDate(type,time)
			exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,?,?,1)", uid, nick, getPlayerName(client):gsub("#%x%x%x%x%x%x",""), serial, powod, result3, "ban")
			triggerClientEvent(root, "admin:rendering", root, ""..nick.." został/a zbanowany/a przez ["..getElementData(client,"id").."] "..getPlayerName(client):gsub("#%x%x%x%x%x%x","")..".\nPowód: "..powod.."\nCzas: "..time .. type .."")
		else
			exports.nrpg_interface:showPlayerNotification(client, "Nie masz dostępu do tej opcji", "error")
		end
		
	elseif (ev=="perm") then
		if exports['nrpg_admin']:getAdmin(client,5) or exports['nrpg_admin']:getAdmin(client,4) or exports['nrpg_admin']:getAdmin(client,3) then
			exports["nrpg_db"]:dbSet("INSERT INTO pystories_ban (uid,nick,nadawca,serial,reason,time,type,active) VALUES (?,?,?,?,?,?,?,1)", uid, nick, getPlayerName(client):gsub("#%x%x%x%x%x%x",""), serial, powod, "2030-12-31 23:59:59", "ban")
			triggerClientEvent(root, "admin:rendering", root, ""..nick.." został/a zbanowany/a permamentnie przez\n["..getElementData(client,"id").."] "..getPlayerName(client):gsub("#%x%x%x%x%x%x","")..".\nPowód: "..powod.."")
		else
			exports.nrpg_interface:showPlayerNotification(client, "Nie masz dostępu do tej opcji", "error")
		end
	end
end)