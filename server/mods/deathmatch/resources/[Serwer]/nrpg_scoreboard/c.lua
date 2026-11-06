main = {

    lib = exports.nrpg_lib,
    players = {},
    jobPlayers = {},
    selectedUser = nil,
    toggleMenu = false,
    menuPos = {x=0, y=0},
    slots = 50,
    tab = false,

}

local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local tabPos = {x=0, y=0, w=math.floor(1045/zoom), h=math.floor(550/zoom)}
tabPos.x = screenW-tabPos.w-math.floor(440/zoom)
tabPos.y = screenH/2-tabPos.h+math.floor(300/zoom)

main.interface = {

    shadowBackground = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(0, 0, 0, 255)),
    tabBackground = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(40, 40, 40, 255)),
    menuButton = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 25, 255)),
    tabBackground2 = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 175, 0, 255)),
    listBackground = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(70, 70, 70, 255)),
    playerBackground = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(65, 65, 65, 255)),
    playerBackground2 = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
    playerColorBackground = main.lib:dgsCreateRoundRect({{5,false},{0,false},{0,false},{5,false}},tocolor(255, 255, 255, 255)),
    scrollRectangle = main.lib:dgsCreateRoundRect({{4,false},{4,false},{4,false},{4,false}},tocolor(255, 175, 0, 255)),
    moreRectangle = main.lib:dgsCreateRoundRect({{4,false},{4,false},{4,false},{4,false}},tocolor(100, 100, 100, 255)),
    circleTexture = dxCreateTexture("circle.png"),
    scrollbarTexture = dxCreateTexture("scrollbarBG.png"),
    speakerIcon = dxCreateTexture("speaker.png"),

}

k = 1
m = 9
n = 9


voiceList = {}

function renderScoreboard()
    local x, y, w, h = tabPos.x, tabPos.y, math.floor(100/zoom), math.floor(50/zoom)

    main.players = {}
    for i,v in ipairs(getElementsByType("player")) do
        if getElementData(v, "player:job") then
            table.insert(main.jobPlayers, v)
        end

        table.insert(main.players, v)
    end

    dxDrawImage(tabPos.x, tabPos.y, tabPos.w, tabPos.h, main.interface.tabBackground2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(tabPos.x+math.floor(2/zoom), tabPos.y+math.floor(2/zoom), tabPos.w-math.floor(3/zoom), tabPos.h-math.floor(3/zoom), main.interface.tabBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)


    dxDrawImage(tabPos.x+math.floor(20/zoom), tabPos.y+math.floor(128/zoom), tabPos.w-math.floor(60/zoom), math.floor(395/zoom), main.interface.listBackground, 0, 0, 0, tocolor(255, 255, 255, 55), false)
    dxDrawImage(tabPos.x+math.floor(20/zoom), tabPos.y+math.floor(128/zoom), tabPos.w-math.floor(60/zoom), math.floor(35/zoom), main.interface.listBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    

    dxDrawText("ID", x+math.floor(45/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("SID", x+math.floor(105/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("Nick", x+math.floor(195/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("Level", x+math.floor(405/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("Organizacja", x+math.floor(525/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("Frakcja", x+math.floor(725/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("Ping", x+math.floor(895/zoom), y+math.floor(135/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)

    listX = 0
    for i,v in ipairs(main.players) do
        if i >= k and i <= n then 
            listX = listX + 1
            offsetY = math.floor(40/zoom)*(listX-1)
            pingColor = {55, 155, 55}
            playerData = {

                id = getElementData(v, "id") or "---",
                sid = getElementData(v, "player:sid") or "---",
                nick = getPlayerName(v):gsub("#%x%x%x%x%x%x", ""),
                level = exports["nrpg_levels"]:getLevel(v) or 0,
                organizacja = getElementData(v, "player:organization") or "---",
                frakcja = getElementData(v, "player:faction") or "---",
                ping = getPlayerPing(v),
                playerColor = getRankColor(v),

            }
        

            if playerData.ping > 300 then
                pingColor = {200, 10, 10}
            elseif playerData.ping > 100 then
                pingColor = {200, 145, 25}
            elseif playerData.ping > 0 then
                pingColor = {55, 155, 55}
            end

            main.lib:dgsRoundRectSetColor(main.interface.playerColorBackground, tocolor(playerData.playerColor[1], playerData.playerColor[2], playerData.playerColor[3], 255))


            dxDrawImage(tabPos.x+math.floor(20/zoom), tabPos.y+math.floor(168/zoom)+offsetY, tabPos.w-math.floor(60/zoom), math.floor(35/zoom), main.interface.playerBackground, 0, 0, 0, tocolor(255, 255, 255, 135), false)
            dxDrawImage(tabPos.x+math.floor(20/zoom), tabPos.y+math.floor(168/zoom)+offsetY, math.floor(7/zoom), math.floor(35/zoom), main.interface.playerColorBackground, 0, 0, 0, tocolor(255, 255, 255, 225), false)

            
            --[[if getElementData(v, "player:sid") then
                if isMouseIn(tabPos.x+math.floor(970/zoom), tabPos.y+math.floor(173/zoom)+offsetY, math.floor(25/zoom), math.floor(25/zoom)) and main.toggleMenu == false then
                    dxDrawImage(tabPos.x+math.floor(970/zoom), tabPos.y+math.floor(173/zoom)+offsetY, math.floor(25/zoom), math.floor(25/zoom), main.interface.moreRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
                    dxDrawText("...", x+math.floor(1875/zoom), y+math.floor(169/zoom)+offsetY*2, x+w, x+h, tocolor(255, 255, 255, 225), 1, exports.nrpg_interface:getGUIFont('normal15'), "center", "center", false, false, false, true, false, 90)
                else
                    dxDrawImage(tabPos.x+math.floor(970/zoom), tabPos.y+math.floor(173/zoom)+offsetY, math.floor(25/zoom), math.floor(25/zoom), main.interface.moreRectangle, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                    dxDrawText("...", x+math.floor(1875/zoom), y+math.floor(169/zoom)+offsetY*2, x+w, x+h, tocolor(255, 255, 255, 125), 1, exports.nrpg_interface:getGUIFont('normal15'), "center", "center", false, false, false, true, false, 90)
                end
            else
                dxDrawImage(tabPos.x+math.floor(970/zoom), tabPos.y+math.floor(173/zoom)+offsetY, math.floor(25/zoom), math.floor(25/zoom), main.interface.moreRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                    dxDrawText("...", x+math.floor(1875/zoom), y+math.floor(169/zoom)+offsetY*2, x+w, x+h, tocolor(255, 255, 255, 55), 1, exports.nrpg_interface:getGUIFont('normal15'), "center", "center", false, false, false, true, false, 90)
            end
            -]]
            

            dxDrawText(playerData.id, x+math.floor(45/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
            dxDrawText(playerData.sid, x+math.floor(105/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
            dxDrawText(playerData.nick, x+math.floor(195/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
            dxDrawText(playerData.level, x+math.floor(405/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
            dxDrawText(playerData.organizacja, x+math.floor(525/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
            dxDrawText(playerData.frakcja, x+math.floor(725/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
            dxDrawText(playerData.ping, x+math.floor(895/zoom), y+math.floor(175/zoom)+offsetY, x+w, x+h, tocolor(pingColor[1], pingColor[2], pingColor[3], 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
        end
    end
    drawScrollbar(main.players, tabPos.x+math.floor(1015/zoom), tabPos.y+math.floor(128/zoom), math.floor(395/zoom), _, m, k)

    dxDrawText("Aktualna ilość graczy", x+math.floor(20/zoom), y+math.floor(20/zoom), x+w, x+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
    dxDrawText((#main.players).."/"..main.slots, x+math.floor(20/zoom), y+math.floor(40/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)

    dxDrawText("Aktualna ilość pracujących graczy", x+math.floor(20/zoom), y+math.floor(65/zoom), x+w, x+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
    dxDrawText(#main.jobPlayers.."/"..main.slots, x+math.floor(20/zoom), y+math.floor(85/zoom), x+w, x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
    local color = getRankColor(localPlayer)
    exports["nrpg_avatars"]:dxCreateAvatar(tabPos.x+math.floor(940/zoom), tabPos.y+math.floor(20/zoom), math.floor(85/zoom), math.floor(85/zoom), 255, tocolor(255, 175, 0, 255))
    dxDrawText(getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", ""), x, y+math.floor(35/zoom), x+w+math.floor(830/zoom), x+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money15'), "right", "top", false, false, false, true, false)
    dxDrawText(getRank(localPlayer), x, y+math.floor(65/zoom), x+w+math.floor(830/zoom), x+h, tocolor(color[1], color[2], color[3], 200), 1, exports.nrpg_interface:getGUIFont('money13'), "right", "top", false, false, false, true, false)


    --[[if main.toggleMenu == true then
        local selectedUserData = {

            sid = getElementData(main.selectedUser, "player:sid") or "---",
            nick = getPlayerName(main.selectedUser):gsub("#%x%x%x%x%x%x", ""),

        }

        dxDrawImage(main.menuPos.x, main.menuPos.y, math.floor(300/zoom), math.floor(200/zoom), main.interface.playerBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        

        if tonumber(voiceList[main.selectedUser]) < 1 then
            dxDrawImage(main.menuPos.x+math.floor(20/zoom), main.menuPos.y+math.floor(59/zoom), math.floor(25/zoom), math.floor(25/zoom), main.interface.speakerIcon, 0, 0, 0, tocolor(255, 55, 55, 255), false)
        else
            dxDrawImage(main.menuPos.x+math.floor(20/zoom), main.menuPos.y+math.floor(59/zoom), math.floor(25/zoom), math.floor(25/zoom), main.interface.speakerIcon, 0, 0, 0, tocolor(225, 225, 225, 255), false)
        end

        dxDrawText((voiceList[main.selectedUser] or 100)..'%', main.menuPos.x+math.floor(1448/zoom), main.menuPos.y+math.floor(82/zoom), math.floor(45/zoom), math.floor(20/zoom), tocolor(200, 200, 200, 255), 1, exports.nrpg_interface:getGUIFont('money8'), "center", "top", false, false, false, false, false)
        exports["nrpg_ogloszenia"]:drawUserAvatar(main.menuPos.x+math.floor(10/zoom), main.menuPos.y+math.floor(10/zoom), math.floor(45/zoom), math.floor(45/zoom), getElementData(main.selectedUser, "player:sid"), 255, {255, 255, 255})
        dxDrawText(selectedUserData.nick, main.menuPos.x+math.floor(60/zoom), main.menuPos.y+math.floor(15/zoom), math.floor(45/zoom), math.floor(20/zoom), tocolor(255, 255, 255, 255), 0.6/zoom, exports.nrpg_interface:getGUIFont('money15'), "left", "top", false, false, false, false, false)
        dxDrawText("Znajomy/a", main.menuPos.x+math.floor(60/zoom), main.menuPos.y+math.floor(30/zoom), math.floor(45/zoom), math.floor(20/zoom), tocolor(55, 155, 55, 255), 0.6/zoom, exports.nrpg_interface:getGUIFont('money15'), "left", "top", false, false, false, false, false)
    
        dxDrawImage(main.menuPos.x+math.floor(20/zoom), main.menuPos.y+math.floor(105/zoom), math.floor(267/zoom), math.floor(35/zoom), main.interface.menuButton, 0, 0, 0, tocolor(255, 255, 255, 200), false)
    end]]
end

bindKey("mouse_wheel_up", "both", function()
    if isMouseIn(tabPos.x+math.floor(20/zoom), tabPos.y+math.floor(128/zoom), tabPos.w-math.floor(60/zoom), math.floor(395/zoom)) and main.tab == true and main.toggleMenu == false then
        scrollUp()
    end
end)

bindKey("mouse_wheel_down", "both", function()
    if isMouseIn(tabPos.x+math.floor(20/zoom), tabPos.y+math.floor(128/zoom), tabPos.w-math.floor(60/zoom), math.floor(395/zoom)) and main.tab == true and main.toggleMenu == false then
        scrollDown()
    end
end)


function scrollDown()
    if n >= #main.players then return end
    k = k+1
    n = n+1
end

function scrollUp()
    if n == m then return end
    k = k-1
    n = n-1
end

function getRankColor(plr)
	if getElementData(plr, "player:level") == 4 then
		return {136, 0, 0}
	elseif getElementData(plr, "player:level") == 3 then
		return {255, 150, 0}
	elseif getElementData(plr, "player:level") == 2 then
		return {255, 0, 4}
	elseif getElementData(plr, "player:level") == 1 then
		return {2, 160, 0}
	elseif getElementData(plr, "player:premiumplus") then
		return {25, 175, 255}
    elseif getElementData(plr, "player:discordbooster") then
        return {252, 3, 240}
    elseif getElementData(plr, "player:premium") then
		return {255, 225, 0}
	else
		return {155, 155, 155}
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

function drawScrollbar(table, x, y, height, barheight, m_, k_)
    dxDrawImage(x, y, 8, height, main.interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

	if #table > m_ then
    	local scrollbarHeight = height/#table

   		if k_ == 1 then 
        	scrollbarPos = y
    	elseif k_ > 1 then 
        	scrollbarPos = ((k_)*scrollbarHeight)+y
    	end

    	if #table <= m_ then 
        	scrollbarHeight = height
    	end

		dxDrawImage(x, scrollbarPos, 8, scrollbarHeight*(m_-1), main.interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*screenW,cy*screenH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

bindKey("tab", "down", function()
    if main.tab == true then
        removeEventHandler("onClientRender", root, renderScoreboard)
        --removeEventHandler("onClientClick", root, click)
        showCursor(false)
        main.tab = false

       -- if isElement(scrollbar[main.selectedUser]) then
       --     destroyElement(scrollbar[main.selectedUser])
       -- end
    else
        addEventHandler("onClientRender", root, renderScoreboard)
        --addEventHandler("onClientClick", root, click)
        showCursor(true)
        main.tab = true

        --main.selectedUser = nil
       -- main.toggleMenu = false
       -- main.menuPos = {x=0,y=0}
    end
end)

--[[
scrollbar = {}
voiceList = {}

function click(button, state)
    if button == "left" and main.tab == true then
        if not isMouseIn(main.menuPos.x, main.menuPos.y, math.floor(300/zoom), math.floor(200/zoom)) and main.tab == true and main.toggleMenu == true and state == "down" then
            if isElement(scrollbar[main.selectedUser]) then
                destroyElement(scrollbar[main.selectedUser])
            end
            main.selectedUser = nil
            main.toggleMenu = false
            main.menuPos = {x=0,y=0}
        end

        if state == "down" then return end
        
        listX = 0
        for i,v in ipairs(main.players) do
            if i >= k and i <= n then 
                listX = listX + 1
                offsetY = math.floor(40/zoom)*(listX-1)

                if isMouseIn(tabPos.x+math.floor(970/zoom), tabPos.y+math.floor(173/zoom)+offsetY, math.floor(25/zoom), math.floor(25/zoom)) and main.tab == true and main.toggleMenu == false and getElementData(v, "player:sid") then
                    main.selectedUser = v
                    main.toggleMenu = true
                    main.menuPos = {x=tabPos.x+math.floor(985/zoom),y=tabPos.y+math.floor(185/zoom)+offsetY}
                    scrollbar[v] = main.lib:dgsCreateScrollBar(main.menuPos.x+math.floor(55/zoom), main.menuPos.y+math.floor(65/zoom), math.floor(235/zoom), math.floor(25/zoom), true, false, false, false, main.interface.scrollbarTexture, main.interface.circleTexture, tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(155, 155, 155, 255), tocolor(200, 200, 200, 255), tocolor(175, 175, 175, 255), tocolor(155, 155, 155, 255))
                    main.lib:dgsScrollBarSetCursorLength(scrollbar[v], 0.1, true)
                    main.lib:dgsScrollBarSetArrowSize(scrollbar[v], 0)

                    if not voiceList[main.selectedUser] then voiceList[main.selectedUser] = 100 end

                    main.lib:dgsScrollBarSetScrollPosition(scrollbar[v], voiceList[main.selectedUser])


                    function OnScroll()
                        local volume = math.floor(main.lib:dgsScrollBarGetScrollPosition(source))
                        
                        if voiceList[main.selectedUser] then
                            voiceList[main.selectedUser] = volume
                        else
                            voiceList[main.selectedUser] = volume
                        end
                    end
                    addEventHandler("onDgsElementScroll", scrollbar[v], OnScroll)
                end
            end
        end
    end
end
]]