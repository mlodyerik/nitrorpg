checkDiscord = function(plr, value)
    if value == "Tak" then
        triggerClientEvent(plr, "discordResultClient", plr, true)
    else
        triggerClientEvent(plr, "discordResultClient", plr, false)
    end
end
addEvent("checkDiscord", true)
addEventHandler("checkDiscord", root, checkDiscord)

loadPlayerDiscordInfo = function(plr)
	local player_sid = getElementData(plr, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
	if 1 > #spr then
		local randomDSC = math.random(100000,999999)
		checkCode(plr, randomDSC)
	else
		if spr[1].discordconnecteded == "Nie" then
			checkDiscord(plr, "Nie")
		else
			checkDiscord(plr, "Tak")
		end
	end
end

setTimer( function()
	for i,v in ipairs(getElementsByType("player")) do
		loadPlayerDiscordInfo(v)
	end
end, 1000, 1)