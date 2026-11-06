local main = {

    markerPos = {1545.33, -625.97, 453.30},

}
local sW, sH = guiGetScreenSize()
local zoom = 1
if sW < 1920 then
    zoom = math.min(2, 1920 / sW)
end

main.skinsList = {

    {0},
    {1},
    {2},
    {7},
    {14},
    {15},
    {16},
    {18},
    {19},
    {20},
    {21},
    {22},
    {23},
    {24},
    {25},
    {26},
    {28},
    {29},
    {30},
    {32},
    {9},
    {12},
    {13},
    {38},
    {39},
    {40},
    {41},
    {53},
    {54},
    {55},
    {56},
    {63},
    {64},
    {69},
    {75},
    {76},
    {77},
    {85},
    {87},
    {88},
    {89},
    {90},
    {91},
    {92},

    {45, "premium"},
    {48, "premium"},
    {49, "premium"},
    {50, "premium"},
    {51, "premium"},
    {52, "premium"},
    {39, "premium"},
    {145, "premium"},
    {81, "premium"},
    {80, "premium"},
    {84, "premium"},
    {83, "premium"},

}

local k = 1
local n = 11
local m = 11
local selected = nil

local getLib = exports.nrpg_lib

interface = {

    backgroundRectangle = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(25, 25, 25, 255)),
    backgroundRectangle2 = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(255, 175, 0, 255)),
    scrollRectangle = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
    button = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 100, 255)),

}

main.drawButton = function(x, y, w, h, type, id, offset)
    if id == selected then
        dxDrawImage(x, y, w, h, interface.button, 0, 0, 0, tocolor(255, 255, 255, 135), false)

        if type == "premium" then
            dxDrawImage(x+5/zoom, y+5/zoom, 30/zoom, 30/zoom, "diamond_icon.png", 0, 0, 0, tocolor(255, 255, 0, 255), false)
            dxDrawText("Skin premium", x+35/zoom, y+10/zoom+offsetY, 25/zoom, 280/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, true, false)
        else
            dxDrawImage(x+5/zoom, y+5/zoom, 30/zoom, 30/zoom, "diamond_icon.png", 0, 0, 0, tocolor(25, 175, 255, 255), false)
            dxDrawText("Skin normalny", x+35/zoom, y+10/zoom+offsetY, 25/zoom, 280/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, true, false)
        end

        dxDrawText("ID: "..id, x+35/zoom, y+10/zoom+offsetY, 25/zoom, 315/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, true, false)
    elseif isMouseIn(x, y, w, h) then
        dxDrawImage(x, y, w, h, interface.button, 0, 0, 0, tocolor(255, 255, 255, 125), false)

        if type == "premium" then
            dxDrawImage(x+5/zoom, y+5/zoom, 30/zoom, 30/zoom, "diamond_icon.png", 0, 0, 0, tocolor(255, 255, 0, 255), false)
            dxDrawText("Skin premium", x+35/zoom, y+10/zoom+offsetY, 25/zoom, 280/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, true, false)
        else
            dxDrawImage(x+5/zoom, y+5/zoom, 30/zoom, 30/zoom, "diamond_icon.png", 0, 0, 0, tocolor(25, 175, 255, 255), false)
            dxDrawText("Skin normalny", x+35/zoom, y+10/zoom+offsetY, 25/zoom, 280/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, true, false)
        end

        dxDrawText("ID: "..id, x+35/zoom, y+10/zoom+offsetY, 25/zoom, 315/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, true, false)
    else
        dxDrawImage(x, y, w, h, interface.button, 0, 0, 0, tocolor(255, 255, 255, 100), false)

        if type == "premium" then
            dxDrawImage(x+5/zoom, y+5/zoom, 30/zoom, 30/zoom, "diamond_icon.png", 0, 0, 0, tocolor(255, 255, 0, 175), false)
            dxDrawText("Skin premium", x+35/zoom, y+10/zoom+offsetY, 25/zoom, 280/zoom, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, true, false)
        else
            dxDrawImage(x+5/zoom, y+5/zoom, 30/zoom, 30/zoom, "diamond_icon.png", 0, 0, 0, tocolor(25, 175, 255, 175), false)
            dxDrawText("Skin normalny", x+35/zoom, y+10/zoom+offsetY, 25/zoom, 280/zoom, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, true, false)
        end

        dxDrawText("ID: "..id, x+35/zoom, y+10/zoom+offsetY, 25/zoom, 315/zoom, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, true, false)
    end
end

main.renderSkins = function()
    dxDrawImage(450/zoom, 225/zoom, 1000/zoom, 610/zoom, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(451/zoom, 226/zoom, 998/zoom, 608/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    x = 0
    for i,v in ipairs(main.skinsList) do
        if i >= k and i <= n then 
            x = x + 1
            offsetY = math.floor(51/zoom)*(x-1)
            main.drawButton(475/zoom, 250/zoom + offsetY, 200/zoom, 50/zoom, v[2], v[1], offsetY)
        end
    end
    drawScrollbar(main.skinsList, 680/zoom, 250/zoom, 555/zoom, 15/zoom, m, k)

    if selected ~= nil then
        exports['nrpg_buttons']:dxCreateButton("Wybierz", 1225/zoom, 750/zoom, 200/zoom, 50/zoom, 1, {55, 155, 55}, "light")
        exports['nrpg_buttons']:dxCreateButton("Anuluj", 1225/zoom, 695/zoom, 200/zoom, 50/zoom, 2, {155, 55, 55}, "light")
    end
end

main.createDashboardPed = function(id)
    local x1, y1, z1 = getCameraMatrix()
    ped = createPed(id, x1, y1, z1, 0)
    myObject = exports.nrpg_object_preview:createObjectPreview(ped, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
    guiped = guiCreateWindow(750/zoom, 225/zoom, 400/zoom, 550/zoom, "", false, false)
    guiWindowSetMovable(guiped, false)
    guiWindowSetSizable(guiped, false) 
    guiSetAlpha(guiped, 0)
    local projPosX, projPosY = guiGetPosition(guiped,true)
    local projSizeX, projSizeY = guiGetSize(guiped, true)
    exports.nrpg_object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
    exports.nrpg_object_preview:setRotation(myObject, 0, 0, 180)
    setElementInterior(ped, 0)
    setElementDimension(ped, 2137)
end
    
    -- Destroys a ped
main.destroyDashboardPed = function()
    if isElement(ped) then destroyElement(ped) end
    if isElement(myObject) then destroyElement(myObject) end
    if isElement(guiped) then destroyElement(guiped) end
end

main.hitMaker = function(el)
    if el ~= localPlayer or getElementInterior(localPlayer) ~= 0 then return end
    addEventHandler( "onClientRender", root, main.renderSkins)
    showCursor(true)
    main.gui = true
    main.createDashboardPed(0)
    selected = 0

    k = 1
    n = 11
    m = 11
end
    
main.leaveMarker = function(el)
    if el ~= localPlayer then return end
    removeEventHandler( "onClientRender", root, main.renderSkins)
    showCursor(false)
    main.gui = false
    main.destroyDashboardPed()
end

main.createdMarker = createMarker(main.markerPos[1], main.markerPos[2], main.markerPos[3]-1, "cylinder", 2, 255, 255, 0, 55)
setElementInterior(main.createdMarker, 0)
setElementDimension(main.createdMarker, 2137)
setElementData(main.createdMarker, "marker:text", "Przebieralnia")
setElementData(main.createdMarker, "marker:downtext", "Tutaj możesz zmienić swój skin")

addEventHandler( "onClientMarkerHit", main.createdMarker, main.hitMaker)
addEventHandler( "onClientMarkerLeave", main.createdMarker, main.leaveMarker)

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sW,cy*sH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function drawScrollbar(table, x, y, height, barheight, m_, k_)
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

		dxDrawImage(x, y, 8, height, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawImage(x, scrollbarPos, 8, scrollbarHeight*(m_-1), interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end


addEventHandler("onClientClick", root, function(btn, state)
    if btn=="left" and state=="up" and main.gui == true then

        if isMouseIn(1225/zoom, 750/zoom, 200/zoom, 50/zoom) then
            removeEventHandler( "onClientRender", root, main.renderSkins)
            showCursor(false)
            main.gui = false
            main.destroyDashboardPed()
            triggerServerEvent("switchSkin", localPlayer, localPlayer, selected)
        elseif isMouseIn(1225/zoom, 695/zoom, 200/zoom, 50/zoom) then
            removeEventHandler( "onClientRender", root, main.renderSkins)
            showCursor(false)
            main.gui = false
            main.destroyDashboardPed()
        end

        if isMouseIn(475/zoom, 250/zoom, 200/zoom, 555/zoom) then
            x = 0
            for i,v in ipairs(main.skinsList) do
                if i >= k and i <= n then 
                    x = x + 1
                    offsetY = math.floor(51/zoom)*(x-1)
                    if isMouseIn(475/zoom, 250/zoom + offsetY, 200/zoom, 50/zoom) then
                        main.destroyDashboardPed()
                        main.createDashboardPed(v[1])
                        selected = v[1]
                    end
                end
            end
        end
    end
end)

bindKey("mouse_wheel_down", "both", function()
    if isMouseIn(475/zoom, 250/zoom, 200/zoom, 555/zoom) and main.gui == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if isMouseIn(475/zoom, 250/zoom, 200/zoom, 555/zoom) and main.gui == true then
        scrollDown()
    end
end)

function scrollDown()
    if n == m then return end
    k = k - 1
    n = n - 1
end

function scrollUp()
    if n >= #main.skinsList then return end
    k = k + 1
    n = n + 1
end