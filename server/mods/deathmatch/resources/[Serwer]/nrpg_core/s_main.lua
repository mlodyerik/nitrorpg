addEventHandler( "onPlayerJoin", root, function()
outputChatBox(" ", source, 255, 255, 0, true)
outputChatBox("ⓘ#ffffff Witaj "..getPlayerName(source):gsub("#%x%x%x%x%x%x", "").." na #FCFF00NitroRPG", source, 255, 255, 0, true)
outputChatBox("ⓘ#ffffff Nasz serwer discord: #FCFF00discord.gg/nitrorpg", source, 255, 255, 0, true)
outputChatBox("ⓘ#ffffff Forum: #FCFF00https://nitro-rpg.xaa.pl/", source, 255, 255, 0, true)
outputChatBox("ⓘ#ffffff TeamSpeak3: #FCFF00nitro-rpg", source, 255, 255, 0, true)
outputChatBox(" ", source, 255, 255, 0, true)
end)

addEvent("core:spawnPlayer", true)
addEventHandler("core:spawnPlayer", root, function()
	local pos=getElementData(source,"player:spawn")
	if not pos then return end
	
	-- Spawn gracza
	spawnPlayer(source, pos[1], pos[2], pos[3])
	setElementDimension(source, pos[5] or 0)
	setElementInterior(source, pos[4] or 0)
	setCameraTarget(source, source)
	
	-- Fade in kamery
	fadeCamera(source, true, 1.0)
	
	toggleControl(source,"fire", false)
	toggleControl(source,"aim_weapon", false)
	loadPlayerData(source)

	outputChatBox(" ", source, 255, 255, 0, true)
	outputChatBox("ⓘ#ffffff Hej! Jesteś tu pierwszy raz? Pod klawiszem F1 znajdziesz szczegółowy poradnik.", source, 255, 255, 0, true)
	outputChatBox(" ", source, 255, 255, 0, true)
end)

addEventHandler("onPlayerConnect", root, function(playerNick)
	if string.find(playerNick, "#") ~= nil or string.find(playerNick, "?") ~= nil or string.find(playerNick, "!") ~= nil then
		cancelEvent(true,"Twój nick zawiera jeden z niedozwolonych znaków(#,?,!), zmień go.")
	end
end)

addEventHandler('onPlayerConnect', root, function(playerNick, playerIP, playerUsername, playerSerial)
	if playerSerial == "63DAE9E46CE7C6B80AA821B7E3F3C0A1" then
		cancelEvent(  )
	end
end)

addEventHandler("onResourceStart", resourceRoot, function()
	setWaveHeight(0)
	setWeather(0)
end)

addEventHandler("onPlayerChangeNick", root, function() cancelEvent() end)

function resourceStart()
    local realtime = getRealTime()
    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resourceStart)

local tickets = {}
local czas_od_ostatniej_komendy = 500

addEventHandler('onPlayerCommand',root,function()
	if getElementData(source, "player:level") == 4 then return end
	if not tickets[source] then
		tickets[source] = getTickCount() + czas_od_ostatniej_komendy
		return
	end
	if tickets[source]>getTickCount() then
		tickets[source] = getTickCount() + czas_od_ostatniej_komendy
		cancelEvent()
	else
		tickets[source] = getTickCount() + czas_od_ostatniej_komendy
	end
end)

function usuneldaty()
    for i,v in pairs(getElementsByType("player")) do 
        local data = getAllElementData (v)
        for ks, vs in pairs (data) do  
            if vs == false then 
                removeElementData (v, ks) 
            end
        end
    end

    for i,v in pairs(getElementsByType("vehicle")) do 
        local data = getAllElementData (v)
        for ks, vs in pairs (data) do  
            if vs == false then 
                removeElementData (v, ks) 
            end
        end
    end

    for i,v in pairs(getElementsByType("marker")) do 
        local data = getAllElementData (v)
        for ks, vs in pairs (data) do  
            if vs == false then 
                removeElementData (v, ks) 
            end
        end
    end

    for i,v in pairs(getElementsByType("object")) do 
        local data = getAllElementData (v)
        for ks, vs in pairs (data) do  
            if vs == false then 
                removeElementData (v, ks) 
            end
        end
    end
end
setTimer(usuneldaty, 30000, 0)