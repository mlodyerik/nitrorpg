addEvent("showVehicleInfo", true)
addEventHandler("showVehicleInfo", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_vehicles WHERE ownedPlayer=?", player_sid)
	triggerClientEvent(client, "clientVehicleInfo", client, spr)
end)

addEvent("showFriendsInfo", true)
addEventHandler("showFriendsInfo", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_friends WHERE sid=?", player_sid)
	triggerClientEvent(client, "clientFriendInfo", client, spr)
end)

addEvent("showInvitesInfo", true)
addEventHandler("showInvitesInfo", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_invites WHERE friendUID=?", player_sid)
	triggerClientEvent(client, "clientInviteInfo", client, spr)
end)

addEvent("showInvitesInfoSend", true)
addEventHandler("showInvitesInfoSend", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_invites WHERE inviteUID=?", player_sid)
	triggerClientEvent(client, "clientInviteInfoSend", client, spr)
end)

addEvent("showPlayerInfo", true)
addEventHandler("showPlayerInfo", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
	triggerClientEvent(client, "clientPlayerInfo", client, spr)
end)

addEvent("serialAction", true)
addEventHandler("serialAction", root, function(actionType, serial)
	local player_sid = getElementData(client, "player:sid")
	if not player_sid then return end
	if exports["nrpg_antycheat"]:checkAccount(client) == true then return end

	if actionType == "add" then
		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		local tablee = fromJSON(spr[1].seriale) or {}
		local secondTable = {}

		for i, v in ipairs(tablee) do
			table.insert(secondTable, v)
		end
		table.insert(secondTable, serial)

		exports["nrpg_db"]:dbSet("UPDATE pystories_users SET seriale=? WHERE id=?", toJSON(secondTable), player_sid)

		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		triggerClientEvent(client, "clientSerialAction", client, "show", fromJSON(spr[1].seriale))
		exports.nrpg_interface:showPlayerNotification(client, 'Serial został pomyślnie dodany do białej listy', 'success')
	elseif actionType == "delete" then
		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		local tablee = fromJSON(spr[1].seriale) or {}
		local secondTable = {}

		for i, v in ipairs(tablee) do
			if v ~= serial then
				table.insert(secondTable, v)
			end
		end

		exports["nrpg_db"]:dbSet("UPDATE pystories_users SET seriale=? WHERE id=?", toJSON(secondTable), player_sid)

		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		triggerClientEvent(client, "clientSerialAction", client, "show", fromJSON(spr[1].seriale))
		exports.nrpg_interface:showPlayerNotification(client, 'Serial został pomyślnie usunięty', 'success')
	elseif actionType == "show" then
		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		triggerClientEvent(client, "clientSerialAction", client, "show", fromJSON(spr[1].seriale))
	end
end)

addEvent("showDiscordData", true)
addEventHandler("showDiscordData", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
	if spr[1].kod == "Brak" then
		local randomDSC = math.random(100000,999999)
		checkCode(client, randomDSC)
	else
		if spr[1].discordconnected == "Nie" then
			triggerClientEvent(client, "showClientDiscordInfo", client, spr)
			triggerEvent("checkDiscord", client, client, false)
		else
			triggerClientEvent(client, "showClientDiscordInfo", client, spr)
			triggerEvent("checkDiscord", client, client, "Tak")
		end
	end
end)

function insertCode(plr, code)
	local player_sid = getElementData(plr, "player:sid")
	exports["nrpg_db"]:dbSet("UPDATE pystories_users SET kod=?, discordconnected=? WHERE id=?", code, "Nie", player_sid)
end

function checkCode(plr, code)
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE kod=?", code)

	if #spr > 1 then

	else
		insertCode(plr, code)
	end
end

function callBackAvatars( responseData, errno, playerToReceive, plrSID )
    if errno == 0 then
        triggerClientEvent( playerToReceive, "showClientUserAvatar", resourceRoot, responseData, plrSID )
    end
end

avatarFilter = {

    ['https://cdn.discordapp.com/avatars/'] = true,


}

function foundString(string)
    for i, v in pairs(avatarFilter) do
        while string:lower():find(i:lower(), 1, true) do
            local start, end_ = string:lower():find(i:lower(), 1, true)
            local found = string:sub(start, end_)
            if found then
                return true
            else
                return false
            end
        end
    end
end

addEvent("loadPlayerCustomAvatar", true)
addEventHandler("loadPlayerCustomAvatar", root, function(plrSID)
	local theUserInfo = exports['nrpg_db']:dbGet("SELECT * FROM discord_connect WHERE sid=?", plrSID)
    if #theUserInfo > 0 then
        if foundString(tostring(theUserInfo[1].avatarurl)) == true then
            fetchRemote(tostring(theUserInfo[1].avatarurl), callBackAvatars, "", false, client, plrSID)
        end
    end
end)


function getPremiumDate(plr)
	local queryA=exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE id=? AND premiumdate>NOW() LIMIT 1", getElementData(source,"player:sid"))
	if (queryA and #queryA > 0) then
		return queryA[1].premiumdate
	end
	return false	
end

function getPremiumPlusDate(plr)
	local queryA=exports['nrpg_db']:dbGet("SELECT * FROM pystories_users WHERE id=? AND premiumplusdate>NOW() LIMIT 1", getElementData(source,"player:sid"))
	if (queryA and #queryA > 0) then
		return queryA[1].premiumplusdate
	end
	return false	
end


function setPremiumDay(plr,days)
	if getPremiumDate(plr) then
	local queryA=exports['nrpg_db']:dbSet(string.format("UPDATE pystories_users SET premiumdate = DATE(premiumdate) + INTERVAL %d DAY WHERE id=%d",days,getElementData(source,"player:sid")))
	return end
	local queryA=exports['nrpg_db']:dbSet(string.format("UPDATE pystories_users SET premiumdate = DATE(curdate()) + INTERVAL %d DAY WHERE id=%d",days,getElementData(source,"player:sid")))
end

function setPremiumPlusDay(plr,days)
	if getPremiumPlusDate(plr) then
	local queryA=exports['nrpg_db']:dbSet(string.format("UPDATE pystories_users SET premiumplusdate = DATE(premiumplusdate) + INTERVAL %d DAY WHERE id=%d",days,getElementData(source,"player:sid")))
	return end
	local queryA=exports['nrpg_db']:dbSet(string.format("UPDATE pystories_users SET premiumplusdate = DATE(curdate()) + INTERVAL %d DAY WHERE id=%d",days,getElementData(source,"player:sid")))
end

addEvent("buyPremium", true)
addEventHandler("buyPremium", root, function(plr, data)
	local player_sid = getElementData(client, "player:sid")
	if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end
	if player_sid then
		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		triggerEvent("save:player", root, plr)

		local offert, cost, type, value = data[1], data[2], data[3], data[4]

		if data then
			if type == "premium+" then
				local actualPoints = getElementData(plr, "player:pp") or 0
    			setElementData(plr, "player:pp", actualPoints-cost)

				setPremiumPlusDay(plr, value)
				setElementData(plr, "player:premiumplus", true)
				setElementData(plr, "player:premiumplusdate", spr[1].premiumplusdate)
				
				if getElementData(plr, "player:premium") then
					exports.nrpg_interface:showPlayerNotification(plr, 'Zakupiłeś/aś konto '..offert..'.', 'success')
					setElementData(plr, "player:premium", false)
					setElementData(plr, "player:premiumdate", false)
				else
					exports.nrpg_interface:showPlayerNotification(plr, 'Zakupiłeś/aś konto '..offert..'.', 'success')
				end
			else
				if not getElementData(plr, "player:premiumplus") then
					local actualPoints = getElementData(plr, "player:pp") or 0
    				setElementData(plr, "player:pp", actualPoints-cost)

					setPremiumDay(plr, value)
					setElementData(plr, "player:premium", true)
					setElementData(plr, "player:premiumdate", spr[1].premiumplusdate)

					exports.nrpg_interface:showPlayerNotification(plr, 'Zakupiłeś/aś konto '..offert, 'success')
				else
					exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz zakupić, masz konto premium+', 'error')
				end
			end
		end
	end
end)

addEvent("buyFreePremium", true)
addEventHandler("buyFreePremium", root, function(plr, data)
	local player_sid = getElementData(client, "player:sid")
	if player_sid then
		local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
		if spr[1].freepremium == 1 then exports.nrpg_interface:showPlayerNotification(plr, 'Już odebrano darmowe premium!', 'error') return end

		triggerEvent("save:player", root, plr)

		local offert, cost, type, value = data[1], data[2], data[3], data[4]

		if data then
			if type == "freepremium" then
				exports["nrpg_db"]:dbSet("UPDATE pystories_users SET freepremium=1 WHERE id=?", player_sid)	
				local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)

				setPremiumDay(plr, value)
				setElementData(plr, "player:premium", true)
				setElementData(plr, "player:premiumdate", spr[1].premiumplusdate)
			
				exports.nrpg_interface:showPlayerNotification(plr, 'Odebrano darmowe premium na 3 dni!', 'success')
			end
		end
	end
end)

addEvent("buyKeys", true)
addEventHandler("buyKeys", root, function(plr, data)
	local player_sid = getElementData(client, "player:sid")
	if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end
	if player_sid then
		triggerEvent("save:player", root, plr)
		local offert, cost, type, value = data[1], data[2], data[3], data[4]

		if data then
			if type == "keys" then
				local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)

				local actualKeys = getElementData(plr, "player:keys") or 0
				exports["nrpg_db"]:dbSet("UPDATE pystories_users SET klucze=klucze+? WHERE id=?", value, player_sid)	
				setElementData(plr, "player:keys", actualKeys+value)
				triggerEvent("save:player", root, plr)
				local actualPoints = getElementData(plr, "player:pp") or 0
    			setElementData(plr, "player:pp", actualPoints-cost)
			
				exports.nrpg_interface:showPlayerNotification(plr, 'Zakupiono '..value..' klucz/y!', 'success')
			end
		end
	end
end)

addEvent("givePlayerReward", true)
addEventHandler("givePlayerReward", root, function(plr, reward, type, value)
	local player_sid = getElementData(plr, "player:sid")
	if player_sid then
		if type == "motorbike" or type == "car" then
			exports.nrpg_interface:showPlayerNotification(plr, 'Wygrywasz: '..reward..'', 'success')
			exports["nrpg_db"]:dbSet("INSERT INTO pystories_vehicles SET model = ?, ownedPlayer = ?, parking = 1, silnik = ?, bak = 25, fuel = 25", value, player_sid, "1.6")
		elseif type == "money" then
			exports.nrpg_interface:showPlayerNotification(plr, 'Wygrywasz: '..reward..'', 'success')
			givePlayerMoney(plr, value)
		elseif type == "points" then
			exports.nrpg_interface:showPlayerNotification(plr, 'Wygrywasz: '..reward..'', 'success')
			local actualPoints = getElementData(plr, "player:pp") or 0
			setElementData(plr, "player:pp", actualPoints+value)
		else
			exports.nrpg_interface:showPlayerNotification(plr, 'Niestety nic nie wygrałeś/aś', 'error')
		end
	end
end)

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

setTimer( function()
	for i,v in ipairs(getElementsByType("player")) do
		loadFriendTable(v)
	end
end, 60000, 1)

addEvent("showFriendMessages", true)
addEventHandler("showFriendMessages", root, function(friendSID)
	local player_sid = getElementData(client, "player:sid")
	local chatID = player_sid..""..friendSID
	local chatID2 = friendSID..""..player_sid
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_chat WHERE sid=? AND friendsid=?", player_sid, friendSID)
	local spr2 = exports["nrpg_db"]:dbGet("SELECT * from pystories_chat WHERE sid=? AND friendsid=?", friendSID, player_sid)
	local user = findUser(tonumber(friendSID))

	if #spr > 0 then
		triggerClientEvent(client, "clientChatInfo", client, spr[1].messages, spr[1].nick, spr[1].emoji, (spr[1].unread or 0))
	else
		twojstary = {}
		twojstary = toJSON( twojstary )
		triggerClientEvent(client, "clientChatInfo", client, twojstary)
	end

	if user then
		if getElementData(user, "player:chat") == player_sid then
			if #spr2 > 0 then
				triggerClientEvent(user, "clientChatInfo", user, spr2[1].messages, spr2[1].nick, spr2[1].emoji, (spr2[1].unread or 0))
			else
				twojstary2 = {}
				twojstary2 = toJSON( twojstary2 )
				triggerClientEvent(user, "clientChatInfo", user, twojstary2)
			end
		end
	end
end)

addEvent("editChat", true)
addEventHandler("editChat", root, function(uid, operation, change)
	local player_sid = getElementData(client, "player:sid")

	if operation == "emoji" then
		local chatID = player_sid..""..uid
		local chatID2 = uid..""..player_sid

		local chat = exports["nrpg_db"]:dbGet("SELECT * from pystories_chat WHERE sid=? AND friendsid=? AND chatID=?", player_sid, uid, chatID)
		if #chat > 0 then
			exports["nrpg_db"]:dbSet("UPDATE pystories_chat SET emoji=? WHERE sid=? AND friendsid=? AND chatID=?", change, player_sid, uid, chatID)	
		end

		local chat2 = exports["nrpg_db"]:dbGet("SELECT * from pystories_chat WHERE sid=? AND friendsid=? AND chatID=?", uid, player_sid, chatID2)
		if #chat2 > 0 then
			exports["nrpg_db"]:dbSet("UPDATE pystories_chat SET emoji=? WHERE sid=? AND friendsid=? AND chatID=?", change, uid, player_sid, chatID2)	
		end

		if #chat > 0 and #chat2 > 0 then
			exports.nrpg_interface:showPlayerNotification(client, 'Zmieniono emoji', 'success')
		else
			exports.nrpg_interface:showPlayerNotification(client, 'Aby zmienić emoji musisz rozpocząć konwersacje', 'error')
		end

		triggerClientEvent(client, "reloadTables", client, client)

		local user = findUser(tonumber(uid))
		if user then
			triggerClientEvent(user, "reloadTables", user, user)
		end
	end
end)

addEvent("carOperation", true)
addEventHandler("carOperation", root, function(vehicle, operation)
	if operation == "close" then
		local lights = getVehicleOverrideLights(vehicle)
		local lights = lights

		if getVehicleOverrideLights(vehicle) ~= 2 then
		setVehicleOverrideLights(vehicle, 2)

		setTimer( function()
		setVehicleOverrideLights(vehicle, 1)

		setTimer( function()
			setVehicleOverrideLights(vehicle, 2)
				setTimer( function()
					setVehicleOverrideLights(vehicle, lights)
				end, 350, 1)
			end, 350, 1)
		end, 350, 1)
		else
		setVehicleOverrideLights(vehicle, 1)

		setTimer( function()
		setVehicleOverrideLights(vehicle, 2)

		setTimer( function()
			setVehicleOverrideLights(vehicle, 1)
				setTimer( function()
					setVehicleOverrideLights(vehicle, lights)
				end, 350, 1)
			end, 350, 1)
		end, 350, 1)
		end

		if isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, false)
		else
			setVehicleLocked(vehicle, true)
		end

	elseif operation == "lights" then
		if getVehicleOverrideLights(vehicle) ~= 2 then
			setVehicleOverrideLights(vehicle, 2)
		else
			setVehicleOverrideLights(vehicle, 1)
		end
	elseif operation == "passager" then
		local passagers = getVehicleOccupants(vehicle)
		    for i,v in ipairs(passagers) do
			    if v ~= client then
				    setControlState(v, "enter_exit", true) 

                setTimer( function()
                	setControlState(v, "enter_exit", false)
                end, 100, 1)
			end
		end
	end
end)

addEvent("manageInvite", true)
addEventHandler("manageInvite", root, function(plr, type, uid, nick)
	local player_sid = getElementData(client, "player:sid")
	if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end
	
	if type == "accept" then
		local resultfriend = exports["nrpg_db"]:dbGet("SELECT * from pystories_friends WHERE sid=?", player_sid)
		if #resultfriend > 49 then exports.nrpg_interface:showPlayerNotification(plr, 'Osiągasz limit znajomych!', 'error') return end

		exports["nrpg_db"]:dbSet("INSERT INTO pystories_friends SET sid=?, friendsid=?, nick=?", player_sid, uid, nick)
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_friends SET sid=?, friendsid=?, nick=?", uid, player_sid, getPlayerName(plr):gsub("#%x%x%x%x%x%x", ""))
		exports['nrpg_db']:dbSet("DELETE from pystories_invites WHERE friendUID=? AND inviteUID=?", player_sid, uid)
		exports['nrpg_db']:dbSet("DELETE from pystories_invites WHERE friendUID=? AND inviteUID=?", uid, player_sid)
		exports.nrpg_interface:showPlayerNotification(plr, 'Dodano gracza '..nick..' do grona znajomych', 'success')
		triggerClientEvent(client, "reloadTables", client, client)
		loadFriendTable(client)

		local user = findUser(tonumber(uid))
		if user then
			triggerClientEvent(user, "reloadTables", user, user)
			loadFriendTable(user)
		end
	elseif type == "delete" then
		exports['nrpg_db']:dbSet("DELETE from pystories_invites WHERE friendUID=? AND inviteUID=?", player_sid, uid)
		exports['nrpg_db']:dbSet("DELETE from pystories_invites WHERE friendUID=? AND inviteUID=?", uid, player_sid)
		exports.nrpg_interface:showPlayerNotification(plr, 'Zaproszenie odrzucone', 'info')
		triggerClientEvent(client, "reloadTables", client, client)
	elseif type == "delete_send" then
		exports['nrpg_db']:dbSet("DELETE from pystories_invites WHERE friendUID=? AND inviteUID=?", uid, player_sid)
		exports['nrpg_db']:dbSet("DELETE from pystories_invites WHERE friendUID=? AND inviteUID=?", player_sid, uid)
		exports.nrpg_interface:showPlayerNotification(plr, 'Zaproszenie anulowane', 'info')
		triggerClientEvent(client, "reloadTables", client, client)

		local user = findUser(tonumber(uid))
		if user then
			triggerClientEvent(user, "reloadTables", user, user)
			loadFriendTable(user)
		end
	end
end)

addEvent("deleteFriend", true)
addEventHandler("deleteFriend", root, function(uid, nick)
	local player_sid = getElementData(client, "player:sid")
	if exports["nrpg_antycheat"]:checkAccount(client) == true then return end

	exports['nrpg_db']:dbSet("DELETE from pystories_friends WHERE sid=? AND friendsid=?", player_sid, uid)
	exports['nrpg_db']:dbSet("DELETE from pystories_friends WHERE sid=? AND friendsid=?", uid, player_sid)
	exports.nrpg_interface:showPlayerNotification(client, 'Wyrzucono '..nick..' ze znajomych', 'info')
	triggerClientEvent(client, "reloadTables", client, client)
	loadFriendTable(client)

	local user = findUser(tonumber(uid))
	if user then
		triggerClientEvent(user, "reloadTables", user, user)
		loadFriendTable(user)
	end
end)

addEvent("sendMessage", true)
addEventHandler("sendMessage", root, function(table, toPlr)
	local player_sid = getElementData(client, "player:sid")
	local user = findUser(tonumber(toPlr))
	local chatID = player_sid..""..toPlr
	local chatID2 = toPlr..""..player_sid

	local chat = exports["nrpg_db"]:dbGet("SELECT * from pystories_chat WHERE sid=? AND friendsid=? AND chatID=?", player_sid, toPlr, chatID)
	if #chat > 0 then
		exports["nrpg_db"]:dbSet("UPDATE pystories_chat SET messages=? WHERE sid=? AND friendsid=? AND chatID=?", toJSON(table), player_sid, toPlr, chatID)	
	else
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_chat SET messages=?, sid=?, friendsid=?, chatID=?, emoji=?", toJSON(table), player_sid, toPlr, chatID, "like_icon")
	end

	local chat2 = exports["nrpg_db"]:dbGet("SELECT * from pystories_chat WHERE sid=? AND friendsid=? AND chatID=?", toPlr, player_sid, chatID2)
	if #chat2 > 0 then
		exports["nrpg_db"]:dbSet("UPDATE pystories_chat SET messages=?, unread=unread+1 WHERE sid=? AND friendsid=? AND chatID=?", toJSON(table), toPlr, player_sid, chatID2)	
	else
		exports["nrpg_db"]:dbSet("INSERT INTO pystories_chat SET messages=?, sid=?, friendsid=?, chatID=?, emoji=?, unread=?", toJSON(table), toPlr, player_sid, chatID2, "like_icon", 0)
	end

	if user then
		exports.nrpg_interface:showPlayerNotification(user, 'Otrzymałeś/aś wiadomość od '..getPlayerName(client):gsub("#%x%x%x%x%x%x", ""), 'message_take')
		exports.nrpg_interface:showPlayerNotification(client, 'Wysłano wiadomość', 'info')
		triggerClientEvent(client, "loadMessages", client, client, toPlr)

		if getElementData(user, "player:chat") == player_sid then
			triggerClientEvent(user, "loadMessages", user, user, player_sid)
		end
	else
		exports.nrpg_interface:showPlayerNotification(client, 'Wysłano wiadomość offline', 'info')
		triggerClientEvent(client, "loadMessages", client, client, toPlr)
	end
end)


addEvent("sendRequest", true)
addEventHandler("sendRequest", root, function(plr, uid, type)
	local player_sid = getElementData(plr, "player:sid")
	if player_sid then
		local resultfriend = exports["nrpg_db"]:dbGet("SELECT * from pystories_friends WHERE sid=?", player_sid)
		if #resultfriend > 49 then exports.nrpg_interface:showPlayerNotification(plr, 'Osiągasz limit znajomych!', 'error') return end
		
		if tonumber(uid) then
			if tonumber(uid) == tonumber(player_sid) then exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz wysłać zaproszenia samemu sobie', 'error') return end
			local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_friends WHERE friendsid=? AND sid=?", uid, player_sid)
			if #spr > 0 then
				exports.nrpg_interface:showPlayerNotification(plr, 'Ta osoba jest już na liście twoich znajomych', 'error')
			else
				local invite = exports["nrpg_db"]:dbGet("SELECT * from pystories_invites WHERE friendUID=? AND inviteUID=?", uid, player_sid)

				if #invite > 0 then
					exports.nrpg_interface:showPlayerNotification(plr, 'Już wysłałeś/aś zaproszenie do tej osoby', 'error')
				else
					local friend = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", uid)
					if #friend > 0 then
						exports["nrpg_db"]:dbSet("INSERT INTO pystories_invites SET friendUID=?, friendNick=?, inviteUID=?, inviteNick=?", tonumber(uid), friend[1].login, player_sid, getPlayerName(plr):gsub("#%x%x%x%x%x%x", ""))
						exports.nrpg_interface:showPlayerNotification(plr, 'Wysłano zaproszenie do grona znajomych ('..friend[1].login..')', 'success')
						triggerClientEvent(client, "reloadTables", client, client)

						local user = findUser(tonumber(uid))
						if user then
							triggerClientEvent(user, "reloadTables", user, user)
							exports.nrpg_interface:showPlayerNotification(user, 'Otrzymałeś/aś zaproszenie do grona znajomych od '..getPlayerName(plr):gsub("#%x%x%x%x%x%x", "")..'', 'success')
						end
					else
						exports.nrpg_interface:showPlayerNotification(plr, 'Taki gracz nie istnieje', 'error')
					end
				end
			end
		end
	end
end)

addEvent("changeNick", true)
addEventHandler("changeNick", root, function(plr, nick)
	if getElementData(plr,"player:sid") then
		if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end
		local nick = nick:gsub("#%x%x%x%x%x%x","")
		if not nick then return end
		local sel = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE login=?", nick)
		if sel and #sel > 0 then exports.nrpg_interface:showPlayerNotification(plr, 'Taki login już istnieje', 'error') return end



		local zmiana = exports['nrpg_db']:dbSet("UPDATE pystories_users set login=? where id=?", nick, getElementData(plr,"player:sid"))
		if zmiana then
			setPlayerName(plr, nick)
			exports.nrpg_interface:showPlayerNotification(plr, 'Twój nick został zmieniony ('..nick..'). Pamiętaj, że to od teraz także twój login.', 'info')
		end
	end
end)

addEvent("changePassword", true)
addEventHandler("changePassword", root, function(plr, pass)
	if getElementData(plr,"player:sid") then
		if not pass then return end
		if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end

		local zmiana = exports['nrpg_db']:dbSet("UPDATE pystories_users set pass=? where id=?", teaEncode(pass,"redskilltojebanykretyniokradadziecinakase"), getElementData(plr,"player:sid"))
		if zmiana then
			exports.nrpg_interface:showPlayerNotification(plr, 'Twoje hasło zostało zmienione pomyślnie, możesz sprawdzić je w konsoli.', 'info')
			outputConsole(teaDecode(pass, "redskilltojebanykretyniokradadziecinakase"), plr)
		end
	end
end)

function findUser(uid)
	for _, plr in ipairs(getElementsByType("player")) do
		if getElementData(plr, "player:sid") == uid then
			return plr
		end
	end
end