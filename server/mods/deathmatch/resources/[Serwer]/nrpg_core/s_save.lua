
function getPremium(plr,premium)
	if premium then
		local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=? AND premium=?",getElementData(plr,"player:sid"), premium)
		if result and #result > 0 then
			return true
		else
			return false
		end
	else
		local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(plr,"player:sid"))
		if result and #result > 0 then
			return true
		else
			return false
		end
	end
end

function przecinkiAdd(amount) 
	local formatted = amount 
	while true do   
	  formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
	  if (k==0) then 
		break 
	  end 
	end 
	return formatted 
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

function loadPlayerData(plr)
	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(plr,"player:sid"))
	local result2 = exports["nrpg_db"]:dbGet("SELECT * FROM discord_connect WHERE sid=?", getElementData(plr,"player:sid"))
	if result and #result > 0 then
		local v = result[1]
		setPlayerMoney(plr, v.money)
		setElementModel(plr, v.skin)
		setElementData(plr, "status","Aktywny")
		setElementData(plr, "player:logged",true)
		setElementData(plr, "player:license:pjA", v.pjA)
		setElementData(plr, "player:license:pjB", v.pjB)
		setElementData(plr, "player:license:pjC", v.pjC)
		setElementData(plr, "player:license:pjL", v.pjL)

		setElementData(plr, "player:lvl", v.lvl)
		exports["nrpg_levels"]:setExp(plr, v.exp)
		setElementData(plr, "player:workinjob", v.worker)
		setElementData(plr, "player:registerdate", v.registered)
		setElementData(plr, "player:hours", v.hours)
		setElementData(plr, "player:pp", v.pp)
		setElementData(plr, "player:keys", v.klucze)
		loadFriendTable(plr)

		if result2 and #result2 > 0 then
			exports["nrpg_avatars"]:startImageDownload(plr, result2[1].avatarurl)

			if result2[1].booster == 1 then
				setElementData(plr, "player:discordbooster", true)
			end
		else

		end

		local mute = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_punish WHERE type=? AND active=1 AND serial=? AND time>NOW() LIMIT 1;", "mute", getPlayerSerial(plr))
		if mute and #mute > 0 then
			setElementData(plr,'mute:player',true)
		end
		
		return true
	end
	return false
end

function findUser(uid)
	for _, plr in ipairs(getElementsByType("player")) do
		if getElementData(plr, "player:sid") == uid then
			return plr
		end
	end
end

function savePlayerData(plr)
	local sid = getElementData(plr,"player:sid")
	if not sid then return end

	local x,y,z = getElementPosition(plr)
	local data = {

		money = getPlayerMoney(plr),
		mandate = getElementData(plr,"player:mandate"),
		licensea = getElementData(plr,"player:license:pjA"),
		licenseb = getElementData(plr,"player:license:pjB"),
		licensec = getElementData(plr,"player:license:pjC"),
		licensel = getElementData(plr,"player:license:pjL"),
		lvl = getElementData(plr,"player:lvl"),
		exp = getElementData(plr,"player:exp"),
		worker = getElementData(plr,"player:workinjob"),
		pp = getElementData(plr,"player:pp") or 0,
		klucze = getElementData(plr,"player:keys") or 0,
		hours = tonumber(getElementData(plr,"player:hours")) or 0,
	 	ostatnia_pozycja = x..", "..y..", "..z..", "..getElementInterior(plr)..", "..getElementDimension(plr),
	}

	exports["nrpg_db"]:dbSet("UPDATE pystories_users SET money=?, lvl=?, exp=?, mandate=?, pjA=?, pjB=?, pjC=?, pjL=?, worker=?, hours=?, pp=?, ostatnia_pozycja=?, klucze=? WHERE id=?", data.money, data.lvl, data.exp, data.mandate, data.licensea, data.licenseb, data.licensec, data.licensel, data.worker, data.hours, data.pp, data.ostatnia_pozycja, data.klucze, data.sid)
end

addEvent("save:player",true)
addEventHandler("save:player", root, function(player)
	if isElement(player) and getElementType(player) == "player" then
		if getElementData(player, "player:sid") then
			savePlayerData(player)
		end
	end
end)

addEvent("load:player",true)
addEventHandler("load:player", root, function(player)
	if isElement(player) and player then
		if getElementType(player) == "player" then
			loadPlayerData(player)
		end
	end
end)


addEventHandler("onPlayerQuit", root, function() savePlayerData(source) end)