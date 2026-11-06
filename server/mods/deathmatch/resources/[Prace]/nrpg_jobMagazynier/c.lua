data = {

    markerInfo = {{1773.54, -2047.99, 12.56}, "Magazynier", "Odbiór paczki"},
    jobMarker = nil,
    actualPage = "Strona główna",
    
}

toplist = {}

jobPages = {

    {"Strona główna", "Toplista, rozpoczecie pracy"},
    {"Ulepszenia", "Zwiększenie statusu ulepszeń"},
    {"Statystyki", "Statystyki pracy"},

}

interface = {

    backgroundColorRectangle = exports.nrpg_lib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(255, 175, 0, 255)),
    backgroundRectangle = exports.nrpg_lib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(35, 35, 35, 255)),
    jobInfoBackground = exports.nrpg_lib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(25, 25, 25, 255)),
    toplistBackground = exports.nrpg_lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(25, 25, 25, 255)),
    jobPageBackground = exports.nrpg_lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(255, 155, 0, 255)),

}

local zoom = exports["nrpg_interface"]:getInterfaceZoom()

function drawInterface()
    dxDrawImage(sx / 2 - 401/zoom, sy / 2 - 201/zoom, 802/zoom, 402/zoom, interface.backgroundColorRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(sx / 2 - 400/zoom, sy / 2 - 200/zoom, 800/zoom, 400/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    for i,v in ipairs(jobPages) do
        offsetY = math.floor(45/zoom)*(i-1)
        
        if data.actualPage == v[1] then
            dxDrawImage(sx / 2 - 125/zoom, sy / 2 - 179/zoom + offsetY, 190/zoom, 40/zoom, interface.jobPageBackground, 0, 0, 0, tocolor(255, 255, 255, 125), false)
            dxDrawText(v[1], sx / 2 - 90/zoom, sy / 2 - 158/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 255), 1, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, true, false)
            dxDrawText(v[2], sx / 2 - 90/zoom, sy / 2 - 158/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 255), 1, exports.nrpg_interface:getGUIFont("normal9"), "left", "top", false, false, false, true, false)
        elseif isMouseIn(sx / 2 - 125/zoom, sy / 2 - 179/zoom + offsetY, 190/zoom, 40/zoom) then
            dxDrawImage(sx / 2 - 125/zoom, sy / 2 - 179/zoom + offsetY, 190/zoom, 40/zoom, interface.jobPageBackground, 0, 0, 0, tocolor(255, 255, 255, 95), false)
            dxDrawText(v[1], sx / 2 - 90/zoom, sy / 2 - 158/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, true, false)
            dxDrawText(v[2], sx / 2 - 90/zoom, sy / 2 - 158/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("normal9"), "left", "top", false, false, false, true, false)
        else
            dxDrawImage(sx / 2 - 125/zoom, sy / 2 - 179/zoom + offsetY, 190/zoom, 40/zoom, interface.jobPageBackground, 0, 0, 0, tocolor(255, 255, 255, 75), false)
            dxDrawText(v[1], sx / 2 - 90/zoom, sy / 2 - 158/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, true, false)
            dxDrawText(v[2], sx / 2 - 90/zoom, sy / 2 - 158/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("normal9"), "left", "top", false, false, false, true, false)
        end
    end

    dxDrawImage(sx / 2 - 380/zoom, sy / 2 - 180/zoom, 285/zoom, 360/zoom, interface.jobInfoBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(sx / 2 - 300/zoom, sy / 2 - 165/zoom, 125/zoom, 125/zoom, ":nrpg_markers/img/pack.png", 0, 0, 0, tocolor(255, 155, 0, 255), false)

    dxDrawText("Magazynier", sx / 2 - 237/zoom, sy / 2 - 10/zoom, nil, nil, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, true, false)
    dxDrawText("Witaj w pracy #ffaf00magazyniera#e1e1e1\nPraca polega na przenoszeniu skrzyń z ciężarówki\na następnie układaniu ich na\nodpowiednich półkach", sx / 2 - 237/zoom, sy / 2 - 8/zoom, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "center", "top", false, false, false, true, false)

    dxDrawText("Wymagania", sx / 2 - 237/zoom, sy / 2 + 90/zoom, nil, nil, tocolor(55, 175, 255, 200), 1, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, true, false)
    dxDrawText("Ta praca #37afffnie posiada#e1e1e1 wymagań", sx / 2 - 237/zoom, sy / 2 + 90/zoom, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "center", "top", false, false, false, true, false)

    if data.actualPage == "Strona główna" then
        dxDrawImage(sx / 2 + 100/zoom, sy / 2 - 155/zoom, 250/zoom, 240/zoom, interface.toplistBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Najlepsi pracownicy", sx / 2 + 225/zoom, sy / 2 - 160/zoom, nil, nil, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, true, false)

        dxDrawText("#", sx / 2 + 115/zoom, sy / 2 - 130/zoom, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, true, false)
        dxDrawText("Nick", sx / 2 + 155/zoom, sy / 2 - 130/zoom, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, true, false)
        dxDrawText("Przeniesione skrzynie", sx / 2 + 340/zoom, sy / 2 - 130/zoom, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "right", "bottom", false, false, false, true, false)
        dxDrawRectangle(sx / 2 + 100/zoom, sy / 2 - 122/zoom, 248/zoom, 2/zoom, tocolor(255, 255, 255, 55), false)

        for i = 1,10 do
            offsetY = math.floor(20/zoom)*(i-1)
            dxDrawText(i, sx / 2 + 115/zoom, sy / 2 - 100/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, true, false)

            if toplist[i] then
                if getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "") == toplist[i][1] then
                    dxDrawText(toplist[i][1], sx / 2 + 155/zoom, sy / 2 - 100/zoom + offsetY, nil, nil, tocolor(255, 195, 75, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, true, false)
                else
                    dxDrawText(toplist[i][1], sx / 2 + 155/zoom, sy / 2 - 100/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, true, false)
                end
            else
                dxDrawText("---", sx / 2 + 155/zoom, sy / 2 - 100/zoom + offsetY, nil, nil, tocolor(225, 225, 225, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, true, false)
            end
        
            if toplist[i] then
                dxDrawText(toplist[i][2], sx / 2 + 340/zoom, sy / 2 - 100/zoom + offsetY, nil, nil, tocolor(55, 225, 55, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "right", "bottom", false, false, false, true, false)
            else
                dxDrawText("---", sx / 2 + 340/zoom, sy / 2 - 100/zoom + offsetY, nil, nil, tocolor(55, 225, 55, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "right", "bottom", false, false, false, true, false)
            end
        end

        exports['nrpg_buttons']:dxCreateButton("Rozpocznij pracę", sx / 2 + 100/zoom, sy / 2 + 90/zoom, 248/zoom, 35/zoom, 1, {55, 155, 55})
        exports['nrpg_buttons']:dxCreateButton("Zamknij okno", sx / 2 + 100/zoom, sy / 2 + 130/zoom, 248/zoom, 35/zoom, 1, {155, 55, 55})
    elseif data.actualPage == "Ulepszenia" then

    end
end
addEventHandler("onClientRender", root, drawInterface)

function startScript()
    data.jobMarker = createMarker(data.markerInfo[1][1], data.markerInfo[1][2], data.markerInfo[1][3], "cylinder", 2, 255, 175, 0, 55)
    setElementData(data.jobMarker, "marker:icon", "pack")
    setElementData(data.jobMarker, "marker:text", data.markerInfo[2])
    setElementData(data.jobMarker, "marker:downtext", data.markerInfo[3])
end
addEventHandler("onClientResourceStart", resourceRoot, startScript)

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" then
        for i,v in ipairs(jobPages) do
            offsetY = math.floor(45/zoom)*(i-1)
            
            if isMouseIn(sx / 2 - 125/zoom, sy / 2 - 179/zoom + offsetY, 190/zoom, 40/zoom) then
                data.actualPage = v[1]
            end
        end
    end
end)

local sW, sH = guiGetScreenSize()

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
