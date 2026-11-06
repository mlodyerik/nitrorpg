function getHexPlayer( player )
	local level = getElementData(player, 'player:level');
    if level == 4 then
        return '#880000'
    elseif level == 3 then
		return '#ff9600'
	elseif level == 2 then
		return '#ff0004'
	elseif level == 1 then
		return '#02a000'
    elseif getElementData(player, 'mute:player') then
        return '#858585'
    elseif getElementData(player, 'player:premiumplus') then
		return '#19afff'
    elseif getElementData(player, 'player:discordbooster') then
		return '#fc03f0'
    elseif getElementData(player, "player:premium") then
        return '#FFFC00'
	else
		return '#9b9bff'
	end
end

function getRank(plr)
    if getElementData(plr, "player:s2") then
        return "Przerwa"
    elseif getElementData(plr, "player:level") == 4 then
        return "Zarząd"
    elseif getElementData(plr, "player:level") == 3 then
        return "Administrator RCON"
    elseif getElementData(plr, "player:level") == 2 then
        return "Administrator"
    elseif getElementData(plr, "player:level") == 1 then
        return "Supporter"
    elseif getElementData(plr, "player:faction") then
        return getFaction(plr)
    elseif getElementData(plr, "job:mechanic") then
        return "Mechanik"
    elseif getElementData(plr, "mute:player") then
        return "Wyciszony/a"
    elseif getElementData(plr, "player:premiumplus") then
        return "Diamond"
    elseif getElementData(plr, "player:discordbooster") then
        return "Discord Booster"
    elseif getElementData(plr, "player:premium") then
        return "Premium"
    else
        return "Gracz"
    end
end

function getFaction(plr)
    if getElementData(plr, "player:faction") == "SAPD" then
	    return "#004DFFSAPD"
    elseif getElementData(plr, "player:faction") == "SARA" then
	    return "#FF8A00SARA"
    elseif getElementData(plr, "player:faction") == "SAFD" then
	    return "#FF0000SAFD"
    elseif getElementData(plr, "player:faction") == "TAXI" then
        return "#fff200TAXI"
    else
	    return " "
    end
end

function getRankColor(plr)
	if getElementData(plr, "player:level") == 4 then
		return {172, 0, 8}
	elseif getElementData(plr, "player:level") == 3 then
		return {255, 115, 0}
	elseif getElementData(plr, "player:level") == 2 then
		return {255, 0, 0}
	elseif getElementData(plr, "player:level") == 1 then
		return {0, 255, 255}
	elseif getElementData(plr, "player:premiumplus") then
		return {25, 175, 255}
    elseif getElementData(plr, "player:discordbooster") then
        return {252, 3, 240}
    elseif getElementData(plr, "player:premium") then
		return {255, 225, 0}
	else
		return {155, 155, 255}
	end
end

main = {}
main.afk = {

    active = false,
    tick = getTickCount(),
    timeToAFK = 30, -- 30 SEKUND
    keys = false

}

local zoom = 1

function isPlayerFriend(plr)
    local table = getElementData(localPlayer, "player:friends")

    if table then
        for i,v in ipairs(table) do
            if v.friendSID == getElementData(plr, "player:sid") then
                return true
            end
        end
    end
end

interface = {

    background = exports.nrpg_lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(65, 65, 65, 255)),

}

chatBubbles = {}

local nametag_font = dxCreateFont(":nrpg_interface/fonts/money.ttf", 15, false)

addEventHandler( "onClientRender", root, function( )
    if getElementData(localPlayer, "notshowhud") or not getElementData(localPlayer, "player:sid") then return end

        local afk = getElementData(localPlayer, "user:afk")
        if (afk and (getTickCount()-afk.tick) > 1000)then
            setElementData(localPlayer, "user:afk", {tick=getTickCount(),time=afk.time+1})
        end
        dxSetBlendMode("modulate_add")
        local px, py, pz, tx, ty, tz, dist
        px, py, pz = getCameraMatrix()
        for klucz, v in ipairs( getElementsByType 'player', root, true) do
            if getElementData(v, "player:sid") then
                tx, ty, tz = getPedBonePosition(v,8)
                dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz);
                if dist < 14.5 and getElementAlpha(v) ~= 0 and v ~= localPlayer then
                local sx, sy, sz = getPedBonePosition( v, 8 )
                local x, y = getScreenFromWorldPosition( sx, sy, sz + 0.45 )

                if x then 
                    local name = "#c4c4c4("..getElementData(v, "id")..")#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x", "")
				    dxDrawText(getRank(v).."\n"..name:gsub("#%x%x%x%x%x%x", ""), x+1, y+1, x+1, y+1, tocolor(0, 0, 0, 255), 1-dist/15, nametag_font, 'center', 'center', false,false,false,true,true)
				    dxDrawText(getHexPlayer(v)..""..getRank(v).."#ffffff\n"..name, x, y, x, y, tocolor(255, 255, 255, 255), 1-dist/15, nametag_font, 'center', 'center', false,false,false,true,true)
                end
            end
        end
        dxSetBlendMode("blend")
    end
end)

function checkPlayerChatTyping()
	if isChatBoxInputActive() then
		if getElementData(localPlayer, "chat_typing")==false then
			setElementData(localPlayer, "chat_typing", true)
		end
	else
		if getElementData(localPlayer, "chat_typing")==true then
			setElementData(localPlayer, "chat_typing", false)
		end
	end
end
setTimer(checkPlayerChatTyping, 500, 0)

function secondsToClock(seconds)
	seconds = seconds or 0
	seconds = seconds*60
	if seconds <= 0 then
		return "00:00"
	else
		hours = string.format("%02.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
		return ""..hours..":"..mins
	end
end

addEventHandler("onClientResourceStart", resourceRoot, 
    function()
        for k, v in ipairs(getElementsByType("player")) do
            setPlayerNametagShowing ( v, false )
        end
    end
)

addEventHandler("onClientPlayerJoin", root, 
    function()
        setPlayerNametagShowing ( source, false )
    end
)

getRows=function(tbl) local k=0 for _,_ in pairs(tbl) do k=k+1 end return k end

function getAFK()
    if(main.afk.keys)then
        for i,v in pairs(main.afk.keys) do
            if(not getKeyState(i))then
                main.afk.keys[i]=nil
                if(getRows(main.afk.keys) < 1)then
                    main.afk.keys=false
                end
            else
                main.afk.tick=getTickCount()
            end
        end
    elseif(not main.afk.active)then
        local time=getTickCount()-main.afk.tick
        local seconds=time/1000
		if(seconds >= main.afk.timeToAFK and not main.afk.active)then
            main.afk.active=true
            setElementData(localPlayer, "user:afk", {tick=getTickCount(),time=0})
		end
    end
end

addEventHandler("onClientKey", root, function(key, press)
    if(main.afk.active)then
        main.afk.active=false
        main.afk.tick=getTickCount()
        setElementData(localPlayer, "user:afk", false)
    end

    if(press)then
        if(not main.afk.keys)then
            main.afk.keys={}
        end

        main.afk.keys[key]=true
    end
end)

addEventHandler("onClientMinimize", root, function()
    if(not getElementData(localPlayer, "user:afk"))then
		setElementData(localPlayer, "user:afk", {tick=getTickCount(),time=0})
        main.afk.active = true
	end
end)

addEventHandler("onClientRestore", root, function()
	if(getElementData(localPlayer, "user:afk"))then
		setElementData(localPlayer, "user:afk", false)
		main.afk.active = false
	end
end)

setElementData(localPlayer, "user:afk", false)