local data = {

    lib = exports.nrpg_lib,
    actualWindow = "main",
    selectedColor = 3,

}

local interface = {

    background = data.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(35, 35, 35, 255)),
    colorBackground = data.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 175, 0, 255)),

}

local colors = {

    {"255,255,0,255,255,0,255,255,255,255,255,255", "Żółty"},
    {"255,0,0,255,0,0,255,255,255,255,255,255", "Czerwony"},
    {"255,255,255,255,255,255,255,255,255,255,255,255", "Biały"},
    {"255,55,255,255,55,255,255,255,255,255,255,255", "Różowy"},
    {"25,155,255,25,155,255,255,255,255,255,255,255", "Niebieski"},
    {"55,255,55,55,255,55,255,255,255,255,255,255", "Zielony"},

}

local sx, sy = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()

function dxDrawButton(text, x, y, w, h, patch, color, font, add)
    if not font then font = exports.nrpg_interface:getGUIFont('money12') end
    if not add then add = 30 end

    if isMouseIn(x, y, w, h) then
        dxDrawImage(x, y, w, h, patch, 0, 0, 0, tocolor(color[1], color[2], color[3], 200), false)
        dxDrawText(text, x, y + h + add/zoom, w+x, h+y, tocolor(color[1], color[2], color[3], 200), 1/zoom, font, "center", "center", false, false, false, true, false)
    else
        dxDrawImage(x, y, w, h, patch, 0, 0, 0, tocolor(color[1], color[2], color[3], 255), false)
        dxDrawText(text, x, y + h + add/zoom, w+x, h+y, tocolor(color[1], color[2], color[3], 255), 1/zoom, font, "center", "center", false, false, false, true, false)
    end
end

function renderUI()
    if data.actualWindow == "main" then
        dxDrawImage(sx / 2 - 300/zoom, sy / 2 - 200/zoom, 601/zoom, 401/zoom, interface.colorBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(sx / 2 - 299/zoom, sy / 2 - 199/zoom, 599/zoom, 399/zoom, interface.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText("Infernus", sx / 2, sy / 2 - 140/zoom, nil, nil, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money20'), "center", "bottom", false, false, false, true, false)
        dxDrawText("Informacje dotyczące pojazdu", sx / 2, sy / 2 - 115/zoom, nil, nil, tocolor(255, 175, 0, 155), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "bottom", false, false, false, true, false)
        dxDrawText("Pojemność silnika: #b3b3b3"..data.vehicleInfo.engine.." dm3#ffffff\nPrzebieg: #b3b3b3"..data.vehicleInfo.mileage.." km#ffffff\nNapęd: #b3b3b3"..utf8.upper(data.vehicleInfo.naped).."#ffffff\nPojemność baku: #b3b3b3"..data.vehicleInfo.bak.." dm3#ffffff\n\nCena pojazdu: #46c242"..convertNumber(data.vehicleInfo.cost).." PLN", sx / 2, sy / 2 - 115/zoom, nil, nil, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "center", "top", false, false, false, true, false)

        dxDrawButton("Zakup pojazd", sx / 2 - 120/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom, "img/buy.png", {55, 200, 55})
        dxDrawButton("Jazda testowa", sx / 2 + 45/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom, "img/drive.png", {55, 155, 255})
    elseif data.actualWindow == "config" then
        dxDrawImage(sx / 2 - 300/zoom, sy / 2 - 200/zoom, 601/zoom, 401/zoom, interface.colorBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(sx / 2 - 299/zoom, sy / 2 - 199/zoom, 599/zoom, 399/zoom, interface.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText("Dostępne kolory", sx / 2, sy / 2 - 160/zoom, nil, nil, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "bottom", false, false, false, true, false)

        colorX = 0
        for i,v in ipairs(colors) do
            colorX = colorX + 1
            offsetX = math.floor(100/zoom)*(colorX-1)
            color = split(v[1], ",")

            if data.selectedColor == i then
                dxDrawButton("Wybrany", sx / 2 - 275/zoom + offsetX, sy / 2 - 140/zoom, 50/zoom, 50/zoom, "img/circle.png", {color[1], color[2], color[3]}, exports.nrpg_interface:getGUIFont('money10'))
            else
                dxDrawButton("#ffffff"..v[2], sx / 2 - 275/zoom + offsetX, sy / 2 - 140/zoom, 50/zoom, 50/zoom, "img/circle.png", {color[1], color[2], color[3]}, exports.nrpg_interface:getGUIFont('money10'))
            end
        end

        dxDrawText("Metody płatności", sx / 2, sy / 2 + 10/zoom, nil, nil, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "bottom", false, false, false, true, false)
        dxDrawButton("Zapłać gotówką\n"..convertNumber(data.vehicleInfo.cost).." PLN", sx / 2 - 120/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom, "img/buy.png", {55, 175, 55}, exports.nrpg_interface:getGUIFont('money12'), 50)
        dxDrawButton("Zapłać kartą\n"..convertNumber(data.vehicleInfo.cost).." PLN", sx / 2 + 45/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom, "img/card.png", {75, 155, 255}, exports.nrpg_interface:getGUIFont('money12'), 50)
    end
end

function buyVehicle(data, color, sid, type)
    triggerServerEvent("buySalonVehicle", localPlayer, localPlayer, sid, color, data, type)
end

function click(btn, state)
    if btn == "left" and state == "up" then
        if isMouseIn(sx / 2 - 120/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom) and data.actualWindow == "config" then
            buyVehicle(data.vehicleInfo, (colors[data.selectedColor][1] or "255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255"), getElementData(localPlayer, "player:sid"), "gotówka")
        elseif isMouseIn(sx / 2 + 45/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom) and data.actualWindow == "config" then
            buyVehicle(data.vehicleInfo, (colors[data.selectedColor][1] or "255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255"), getElementData(localPlayer, "player:sid"), "bank")
        end

        if isMouseIn(sx / 2 - 120/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom) and data.actualWindow == "main" then
            data.actualWindow = "config"
            exports.nrpg_interface:showPlayerNotification("Dostosuj kolor pojazdu oraz wybierz płatność", "info", 3500, "Konfiguracja")
        elseif isMouseIn(sx / 2 + 45/zoom, sy / 2 + 40/zoom, 80/zoom, 80/zoom) and data.actualWindow == "main" then
            triggerServerEvent("vehicleTestDrive", localPlayer, localPlayer, data.vehicleInfo)
            data.vehicleInfo = {}
            showCursor(false)
            removeEventHandler("onClientRender", root, renderUI)
            removeEventHandler("onClientClick", root, click)
        end
        
        colorX = 0
        for i,v in ipairs(colors) do
            colorX = colorX + 1
            offsetX = math.floor(100/zoom)*(colorX-1)

            if isMouseIn(sx / 2 - 275/zoom + offsetX, sy / 2 - 140/zoom, 50/zoom, 50/zoom) and data.actualWindow == "config" then
                data.selectedColor = i
            end
        end
    end
end

addEvent("vehicleInfoToggle", true)
addEventHandler("vehicleInfoToggle", resourceRoot, function(theData, toggle)
    if toggle == true then
        data = {

            lib = exports.nrpg_lib,
            actualWindow = "main",
            selectedColor = 3,
        
        }
        data.vehicleInfo = theData
        data.actualWindow = "main"
        showCursor(true, false)
        addEventHandler("onClientRender", root, renderUI)
        addEventHandler("onClientClick", root, click)
    else
        data.vehicleInfo = {}
        showCursor(false)
        removeEventHandler("onClientRender", root, renderUI)
        removeEventHandler("onClientClick", root, click)
    end
end)

function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end
    cx,cy = getCursorPosition()
    cx,cy = cx*sx, cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end

function convertNumber(amount) 
    local formatted = amount 
    while true do   
      formatted, ss = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (ss==0) then 
        break 
      end 
    end 
    return formatted 
end
