local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local lib = exports.nrpg_lib

local interfacePos = {x=0, y=0, w=math.floor(600/zoom), h=math.floor(100/zoom)}
interfacePos.x = screenW-interfacePos.w-math.floor(665/zoom)
interfacePos.y = screenH/2-interfacePos.h+math.floor(450/zoom)

local kompoPos = {x=0, y=0, w=math.floor(800/zoom), h=math.floor(415/zoom)}
kompoPos.x = screenW-kompoPos.w-math.floor(545/zoom)
kompoPos.y = screenH/2-kompoPos.h+math.floor(225/zoom)

main = {

    positions = {

        {1646.90, -1519.20, 13.55, 1640.61, -1519.78, 12.57, 5.38, 6.83, 3.56},

    },

    components = {

        {"Zmiana koloru pojazdu", 500, "Zmień kolory pojazdu!", "img/car.png"},
        {"Zmiana koloru felg", 1000, "Zmień kolor felg i rantów!", "img/rims.png"},

        {"Zmiana koloru lamp", "100,000 - 300,000", "Zmień kolor lamp w swoim pojeździe!", "img/lights.png"},
        {"Zmiana koloru licznika", "10,000 - 30,000", "Zmień kolor licznika!", "img/speedo.png"},

        {"Zwiększanie pojemności silnika", "85,000 - 200,000", "Zwiększ pojemność silnika aby zwiększyć osiągi swojego pojazdu!", "img/engine.png"},

        {"Zmiana rejestracji", 5000, "Zmień swoją tablice rejestracyjną już teraz!", "img/plate.png"},
        {"Montaż butli nitra", "100,000 - 250,000", "Zamontuj butlę podtlenku azotu i zyskaj większe osiągi!", "img/nitro.png"},

    },

    windowType = nil,
    enterShape = nil,
    actualWindow = "list",
    theCost = 0,
    selectColor = "color1",
    actualVehicle = nil,

    wrongLicenses = {

        ["kurwa"] = true,
        ["szmata"] = true,
        ["nigger"] = true,
        ["chuj"] = true,
        ["cwel"] = true,
        ["murzyn"] = true,
        ["pedal"] = true,

    },

    headlightsColors = {

        {"Hell Red", {175, 0, 0}, 100000},
        {"Piggy Red", {255, 85, 70}, 125000},
        {"Sweet Orange", {255, 110, 0}, 135000},
        {"New Yellow", {255, 255, 0}, 130000},
        {"Vintage Yellow", {255, 250, 95}, 200000},
        {"Light Green", {55, 200, 55}, 185000},
        {"Aqua", {0, 255, 225}, 225000},
        {"Ocean Blue", {0, 110, 255}, 165000},
        {"Saint Purple", {115, 0, 255}, 200000},
        {"Sweet Pink", {255, 0, 230}, 275000},
        {"Lime", {145, 255, 0}, 300000},

    },

    speedoColors = {

        {"Hell Red", {175, 0, 0}, 10000},
        {"Piggy Red", {255, 85, 70}, 12500},
        {"Sweet Orange", {255, 110, 0}, 13500},
        {"New Yellow", {255, 255, 0}, 13000},
        {"Vintage Yellow", {255, 250, 95}, 20000},
        {"Light Green", {55, 200, 55}, 18500},
        {"Aqua", {0, 255, 225}, 22500},
        {"Ocean Blue", {0, 110, 255}, 16500},
        {"Saint Purple", {115, 0, 255}, 20000},
        {"Sweet Pink", {255, 0, 230}, 27500},
        {"Lime", {145, 255, 0}, 30000},

    },

    savedColors = {},
    selectedColor = nil,

    selectedLightsInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}},
    selectedSpeedoInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}},

}

scrollPos = {k=1, m=4, n=4}
scrollLightPos = {k=1, m=5, n=5}
scrollSpeedoPos = {k=1, m=5, n=5}
scrollColorPos = {k=1, m=9, n=9}

buttonsClick = {

    colorButton = {x=0, y=kompoPos.y+math.floor(274/zoom), w=math.floor(145/zoom), h=math.floor(25/zoom)}

}

interface = {

    background = lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(40, 40, 40, 255)),
    backgroundShadow = lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 25, 255)),
    backgroundShadowColor = lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(65, 65, 65, 255)),
    colorBackground = lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 175, 0, 255)),

    scrollRectangle = lib:dgsCreateRoundRect({{4,false},{4,false},{4,false},{4,false}},tocolor(255, 175, 0, 255)),

    compoBackground = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(30, 30, 30, 255)),
    compoList = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(100, 100, 100, 255)),

    plateBackground = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(255, 255, 255, 255)),

}

main.renderUI = function()
    if main.windowType == "info" then
        local x, y, w, h = interfacePos.x, interfacePos.y, math.floor(100/zoom), math.floor(50/zoom)
        local veh = getPedOccupiedVehicle(localPlayer)

        if veh then
            if getVehicleEngineState(veh) then
                czynnosc = "Zgaś silnik w pojeździe"
            elseif getVehicleOverrideLights(veh) == 2 then
                czynnosc = "Zgaś światła w pojeździe"
            elseif not isElementFrozen(veh) then
                czynnosc = "Zaciągnij hamulec ręczny w pojeździe"
            elseif getElementData(localPlayer, "player:sid") ~= getElementData(veh, "vehicle:ownedPlayer") then
                czynnosc = "Nie jesteś właścicielem tego pojazdu"
            else
                czynnosc = nil
            end

            if czynnosc ~= nil then
                dxDrawImage(interfacePos.x, interfacePos.y, interfacePos.w, interfacePos.h, interface.colorBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawImage(interfacePos.x+math.floor(2/zoom), interfacePos.y+math.floor(2/zoom), interfacePos.w-math.floor(3/zoom), interfacePos.h-math.floor(3/zoom), interface.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)

                dxDrawText("Aby skorzystać z montażu komponentów wykonaj następującą czynność", x+math.floor(505/zoom), y, x+w, y+h-math.floor(10/zoom), tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money11'), "center", "bottom", false, false, false, true, false)
                dxDrawText(czynnosc, x+math.floor(505/zoom), y+math.floor(55/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money11'), "center", "top", false, false, false, true, false)
            end
        end
    elseif main.windowType == "kompo" then
        local x, y, w, h = kompoPos.x, kompoPos.y, math.floor(100/zoom), math.floor(50/zoom)
        dxDrawImage(kompoPos.x, kompoPos.y, kompoPos.w, kompoPos.h, interface.colorBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(kompoPos.x+math.floor(2/zoom), kompoPos.y+math.floor(2/zoom), kompoPos.w-math.floor(3/zoom), kompoPos.h-math.floor(3/zoom), interface.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Montaż komponentów", x+math.floor(685/zoom), y+math.floor(15/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money15'), "center", "top", false, false, false, true, false)

        if main.actualWindow == "list" then
            dxDrawImage(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom), math.floor(755/zoom), math.floor(340/zoom), interface.compoBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)

            xList = 0
            for i,v in ipairs(main.components) do
                if i >= scrollPos.k and i <= scrollPos.n then 
                    xList = xList + 1
                    offsetY = math.floor(86/zoom)*(xList-1)

                    dxDrawImage(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetY, math.floor(755/zoom), math.floor(85/zoom), interface.compoList, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                    dxDrawImage(kompoPos.x+math.floor(30/zoom), kompoPos.y+math.floor(60/zoom)+offsetY, math.floor(70/zoom), math.floor(70/zoom), v[4], 0, 0, 0, tocolor(255, 175, 0, 255), false)

                    local textWidth = dxGetTextWidth(v[1], 1, exports.nrpg_interface:getGUIFont('money11'))
                    dxDrawText(v[1], x+math.floor(115/zoom), y+math.floor(65/zoom)+offsetY, x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)
                    dxDrawText(v[3], x+math.floor(115/zoom), y+math.floor(85/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)

                    if tonumber(v[2]) then
                        dxDrawText("Cena: #49ff30"..addPrzecinki(v[2]).." PLN", x+math.floor(115/zoom), y+math.floor(105/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    else
                        dxDrawText("Cena: #49ff30"..v[2].." PLN", x+math.floor(115/zoom), y+math.floor(105/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    end
                    

                    exports["nrpg_buttons"]:dxCreateButton("Więcej", kompoPos.x+math.floor(655/zoom), kompoPos.y+math.floor(80/zoom)+offsetY, math.floor(100/zoom), math.floor(30/zoom), 1, {25, 144, 255, 255})
                end
            end
            drawScrollbar(main.components, kompoPos.x+math.floor(775/zoom), kompoPos.y+math.floor(55/zoom), math.floor(340/zoom), scrollPos.m, scrollPos.k)
        elseif main.actualWindow == "vehcolor" then
            exports["nrpg_buttons"]:dxCreateButton("Zmień kolor pojazdu", kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(55/zoom), math.floor(165/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
            exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(90/zoom), math.floor(165/zoom), math.floor(30/zoom), 2, {155, 155, 155, 255})

            dxDrawText("Wybierz kolor", x+math.floor(330/zoom), y+math.floor(145/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)

            if main.selectColor == "color1" then
                dxDrawText("Kolor pierwszy pojazdu", x+math.floor(330/zoom), y+math.floor(310/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
                dxDrawText("Kolor drugi pojazdu", x+math.floor(330/zoom), y+math.floor(355/zoom), x+w, y+h, tocolor(155, 155, 155, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
            else
                dxDrawText("Kolor pierwszy pojazdu", x+math.floor(330/zoom), y+math.floor(310/zoom), x+w, y+h, tocolor(155, 155, 155, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
                dxDrawText("Kolor drugi pojazdu", x+math.floor(330/zoom), y+math.floor(355/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
            end

            dxDrawText("Informacje dotyczące koloru", x+math.floor(15/zoom), y+math.floor(245/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
            local textWidth = dxGetTextWidth(("Kolor RGB: "..pickerData["color"][1]..", "..pickerData["color"][2]..", "..pickerData["color"][3]), 1, exports.nrpg_interface:getGUIFont('money10'))
            dxDrawRectangle(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(275/zoom), math.floor(20/zoom), math.floor(20/zoom), tocolor(pickerData["color"][1], pickerData["color"][2], pickerData["color"][3], 255))
            dxDrawText("Kolor RGB: #ffaf00"..pickerData["color"][1]..", "..pickerData["color"][2]..", "..pickerData["color"][3], x+math.floor(45/zoom), y+math.floor(278/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
            dxDrawText("Cena zmiany koloru", x+math.floor(15/zoom), y+math.floor(330/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
            dxDrawText(addPrzecinki(main.theCost).." PLN", x+math.floor(15/zoom), y+math.floor(358/zoom), x+w, y+h, tocolor(55, 200, 55, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
            
            exports["nrpg_buttons"]:dxCreateButton("Skopiuj kolor", kompoPos.x+math.floor(50/zoom)+textWidth, kompoPos.y+math.floor(274/zoom), math.floor(145/zoom), math.floor(25/zoom), 3, {35, 144, 255, 255})
            buttonsClick.colorButton.x = kompoPos.x+math.floor(50/zoom)+textWidth

            dxDrawImage(kompoPos.x+math.floor(515/zoom), kompoPos.y+math.floor(55/zoom), math.floor(255/zoom), math.floor(300/zoom), interface.backgroundShadow, 0, 0, 0, tocolor(255, 255, 255, 200), false)

            rList = 0
            for i,v in ipairs(main.savedColors) do
                if i >= scrollColorPos.k and i <= scrollColorPos.n then 
                    rList = rList + 1
                    offsetYC = math.floor(37/zoom)*(rList-1)
                    local theColor = split(v["color"], ",")
                    if main.selectedColor == v.id then
                        dxDrawImage(kompoPos.x+math.floor(517/zoom), kompoPos.y+math.floor(57/zoom)+offsetYC, math.floor(251/zoom), math.floor(35/zoom), interface.backgroundShadowColor, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                        dxDrawImage(kompoPos.x+math.floor(525/zoom), kompoPos.y+math.floor(65/zoom)+offsetYC, math.floor(15/zoom), math.floor(15/zoom), "img/circle.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 200), false)
                        dxDrawText("Kolor #"..i.."  -  "..v["color"], x+math.floor(555/zoom), y+math.floor(98/zoom)+math.floor(offsetYC*2), x+w, y+h, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "center", false, false, false, true, false)
                    else
                        dxDrawImage(kompoPos.x+math.floor(517/zoom), kompoPos.y+math.floor(57/zoom)+offsetYC, math.floor(251/zoom), math.floor(35/zoom), interface.backgroundShadowColor, 0, 0, 0, tocolor(255, 255, 255, 175), false)
                        dxDrawImage(kompoPos.x+math.floor(525/zoom), kompoPos.y+math.floor(65/zoom)+offsetYC, math.floor(15/zoom), math.floor(15/zoom), "img/circle.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 255), false)
                        dxDrawText("Kolor #"..i.."  -  "..v["color"], x+math.floor(555/zoom), y+math.floor(98/zoom)+math.floor(offsetYC*2), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "center", false, false, false, true, false)
                    end
                    
                end
            end
            dxDrawText("Zapisane kolory #ffffff("..#main.savedColors..")", x+math.floor(520/zoom), y+math.floor(30/zoom), x+w, y+h, tocolor(255, 175, 0, 225), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)

            exports["nrpg_buttons"]:dxCreateButton("Zapisz kolor", kompoPos.x+math.floor(515/zoom), kompoPos.y+math.floor(360/zoom), math.floor(125/zoom), math.floor(30/zoom), 4, {55, 200, 55, 200})
            exports["nrpg_buttons"]:dxCreateButton("Usuń kolor", kompoPos.x+math.floor(645/zoom), kompoPos.y+math.floor(360/zoom), math.floor(125/zoom), math.floor(30/zoom), 5, {200, 55, 55, 200})
        elseif main.actualWindow == "rimscolor" then
            if main.selectColor == "color3" then
                exports["nrpg_buttons"]:dxCreateButton("Zmień kolor felg", kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(55/zoom), math.floor(165/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
            else
                exports["nrpg_buttons"]:dxCreateButton("Zmień kolor rantów", kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(55/zoom), math.floor(165/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
            end
            exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(90/zoom), math.floor(165/zoom), math.floor(30/zoom), 2, {155, 155, 155, 255})

            dxDrawText("Wybierz kolor", x+math.floor(330/zoom), y+math.floor(145/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)

            if main.selectColor == "color3" then
                dxDrawText("Kolor felg", x+math.floor(330/zoom), y+math.floor(310/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
                dxDrawText("Kolor rantów", x+math.floor(330/zoom), y+math.floor(355/zoom), x+w, y+h, tocolor(155, 155, 155, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
            else
                dxDrawText("Kolor felg", x+math.floor(330/zoom), y+math.floor(310/zoom), x+w, y+h, tocolor(155, 155, 155, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
                dxDrawText("Kolor rantów", x+math.floor(330/zoom), y+math.floor(355/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
            end

            dxDrawText("Informacje dotyczące koloru", x+math.floor(15/zoom), y+math.floor(245/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
            local textWidth = dxGetTextWidth(("Kolor RGB: "..pickerData["color"][1]..", "..pickerData["color"][2]..", "..pickerData["color"][3]), 1, exports.nrpg_interface:getGUIFont('money10'))
            dxDrawRectangle(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(275/zoom), math.floor(20/zoom), math.floor(20/zoom), tocolor(pickerData["color"][1], pickerData["color"][2], pickerData["color"][3], 255))
            dxDrawText("Kolor RGB: #ffaf00"..pickerData["color"][1]..", "..pickerData["color"][2]..", "..pickerData["color"][3], x+math.floor(45/zoom), y+math.floor(278/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
            dxDrawText("Cena zmiany koloru", x+math.floor(15/zoom), y+math.floor(330/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
            dxDrawText(addPrzecinki(main.theCost).." PLN", x+math.floor(15/zoom), y+math.floor(358/zoom), x+w, y+h, tocolor(55, 200, 55, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
            
            exports["nrpg_buttons"]:dxCreateButton("Skopiuj kolor", kompoPos.x+math.floor(50/zoom)+textWidth, kompoPos.y+math.floor(274/zoom), math.floor(145/zoom), math.floor(25/zoom), 3, {35, 144, 255, 255})
            buttonsClick.colorButton.x = kompoPos.x+math.floor(50/zoom)+textWidth

            dxDrawImage(kompoPos.x+math.floor(515/zoom), kompoPos.y+math.floor(55/zoom), math.floor(255/zoom), math.floor(300/zoom), interface.backgroundShadow, 0, 0, 0, tocolor(255, 255, 255, 200), false)
            rList = 0
            for i,v in ipairs(main.savedColors) do
                if i >= scrollColorPos.k and i <= scrollColorPos.n then 
                    rList = rList + 1
                    offsetYC = math.floor(37/zoom)*(rList-1)
                    local theColor = split(v["color"], ",")
                    if main.selectedColor == v.id then
                        dxDrawImage(kompoPos.x+math.floor(517/zoom), kompoPos.y+math.floor(57/zoom)+offsetYC, math.floor(251/zoom), math.floor(35/zoom), interface.backgroundShadowColor, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                        dxDrawImage(kompoPos.x+math.floor(525/zoom), kompoPos.y+math.floor(65/zoom)+offsetYC, math.floor(15/zoom), math.floor(15/zoom), "img/circle.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 200), false)
                        dxDrawText("Kolor #"..i.."  -  "..v["color"], x+math.floor(555/zoom), y+math.floor(98/zoom)+math.floor(offsetYC*2), x+w, y+h, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "center", false, false, false, true, false)
                    else
                        dxDrawImage(kompoPos.x+math.floor(517/zoom), kompoPos.y+math.floor(57/zoom)+offsetYC, math.floor(251/zoom), math.floor(35/zoom), interface.backgroundShadowColor, 0, 0, 0, tocolor(255, 255, 255, 175), false)
                        dxDrawImage(kompoPos.x+math.floor(525/zoom), kompoPos.y+math.floor(65/zoom)+offsetYC, math.floor(15/zoom), math.floor(15/zoom), "img/circle.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 255), false)
                        dxDrawText("Kolor #"..i.."  -  "..v["color"], x+math.floor(555/zoom), y+math.floor(98/zoom)+math.floor(offsetYC*2), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "center", false, false, false, true, false)
                    end
                    
                end
            end
            dxDrawText("Zapisane kolory #ffffff("..#main.savedColors..")", x+math.floor(520/zoom), y+math.floor(30/zoom), x+w, y+h, tocolor(255, 175, 0, 225), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)

            exports["nrpg_buttons"]:dxCreateButton("Zapisz kolor", kompoPos.x+math.floor(515/zoom), kompoPos.y+math.floor(360/zoom), math.floor(125/zoom), math.floor(30/zoom), 4, {55, 200, 55, 200})
            exports["nrpg_buttons"]:dxCreateButton("Usuń kolor", kompoPos.x+math.floor(645/zoom), kompoPos.y+math.floor(360/zoom), math.floor(125/zoom), math.floor(30/zoom), 5, {200, 55, 55, 200})
        elseif main.actualWindow == "engineupgrade" then
            local engine = getElementData(main.actualVehicle, "Pojemnosc:silnika") or "1.4"
           
            if engine == "2.8" or engine == "3.0" or engine == "3.2" or engine == "3.4" or engine == "3.6" or engine == "3.8" or engine == "4.0" then
                dxDrawImage(kompoPos.x+math.floor(295/zoom), kompoPos.y+math.floor(75/zoom), math.floor(200/zoom), math.floor(200/zoom), "img/engineupgrade.png", 0, 0, 0, tocolor(200, 75, 75, 255), false)
                dxDrawText("Nie możesz ulepszyć tego silnika", x+math.floor(690/zoom), y+math.floor(300/zoom), x+w, y+h, tocolor(255, 55, 55, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Twój silnik posiada maksymalną dozwoloną pojemność dla tego pojazdu", x+math.floor(690/zoom), y+math.floor(330/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
                exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom), 2, {175, 55, 55, 255})
            else
                local vehEngineInfo = getVehicleEngineInfo(main.actualVehicle)
                main.theCost = vehEngineInfo[2] or 0
                dxDrawImage(kompoPos.x+math.floor(295/zoom), kompoPos.y+math.floor(75/zoom), math.floor(200/zoom), math.floor(200/zoom), "img/engineupgrade.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                dxDrawText("Informacje dotyczące silnika", x+math.floor(350/zoom), y+math.floor(175/zoom), x+w+math.floor(185/zoom), y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "right", "top", false, false, false, true, false)
                dxDrawText("Pojemność: "..getElementData(main.actualVehicle, "Pojemnosc:silnika").." dm3\nCylindry: "..getElementData(main.actualVehicle, "vehicle:cylindry").."", x+math.floor(750/zoom), y+math.floor(200/zoom), x+w+math.floor(185/zoom), y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "right", "top", false, false, false, true, false)

                dxDrawText("Informacje dotyczące ulepszenia", x+math.floor(500/zoom), y+math.floor(175/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
                dxDrawText("Cena ulepszenia: "..addPrzecinki(main.theCost).." PLN\nUlepszana pojemność: "..vehEngineInfo[1].." dm3", x+math.floor(500/zoom), y+math.floor(200/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
                exports["nrpg_buttons"]:dxCreateButton("Zwiększ pojemność silnika", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
                exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom), 2, {175, 55, 55, 255})
            end
        elseif main.actualWindow == "licenseplate" then
            local plateName = exports["nrpg_interface"]:getCustomEditboxText('license:text')

            dxDrawImage(kompoPos.x+math.floor(295/zoom), kompoPos.y+math.floor(185/zoom), math.floor(200/zoom), math.floor(55/zoom), interface.plateBackground, 0, 0, 0, tocolor(255, 255, 255, 200), false)
            dxDrawText(string.sub(utf8.upper(plateName), 1, 8), x+math.floor(688/zoom), y+math.floor(377/zoom), x+w, y+h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont('money22'), "center", "center", false, false, false, true, false)
            dxDrawText("Cena zmiany tablicy: "..addPrzecinki(main.theCost).." PLN", x+math.floor(690/zoom), y+math.floor(255/zoom), x+w, y+h, tocolor(55, 200, 55, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

            if main.wrongLicenses[plateName] then
                dxDrawText("Nie możesz zmienić tablicy rejestracyjnej", x+math.floor(690/zoom), y+math.floor(115/zoom), x+w, y+h, tocolor(255, 55, 55, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Wykryto zabronione słowo", x+math.floor(690/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
            elseif string.len(plateName) > 8 then
                dxDrawText("Nie możesz zmienić tablicy rejestracyjnej", x+math.floor(690/zoom), y+math.floor(115/zoom), x+w, y+h, tocolor(255, 55, 55, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Tablica może posiadać maksymalnie 8 znaków", x+math.floor(690/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
            elseif 1 > string.len(plateName) then
                dxDrawText("Nie możesz zmienić tablicy rejestracyjnej", x+math.floor(690/zoom), y+math.floor(115/zoom), x+w, y+h, tocolor(255, 55, 55, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Tablica może posiadać minimum 1 znak", x+math.floor(690/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
            else
                dxDrawText("Tablica gotowa do zmiany", x+math.floor(690/zoom), y+math.floor(115/zoom), x+w, y+h, tocolor(55, 200, 55, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Kliknij przycisk 'zmień' aby zmienić tablice\nw swoim pojeździe", x+math.floor(690/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
            end

            exports["nrpg_buttons"]:dxCreateButton("Zmień tablicę", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
            exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom), 2, {175, 55, 55, 255})
        elseif main.actualWindow == "nitromontage" then
            local nitroType = getVehicleUpgradeOnSlot(main.actualVehicle, 8)
            
            if nitroType ~= 1010 then
                local nitroInfo = getVehicleNitroMontage(main.actualVehicle)
                main.theCost = nitroInfo[3]
                dxDrawImage(kompoPos.x+math.floor(295/zoom), kompoPos.y+math.floor(75/zoom), math.floor(200/zoom), math.floor(200/zoom), "img/nitro.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawImage(kompoPos.x+math.floor(400/zoom), kompoPos.y+math.floor(225/zoom), math.floor(40/zoom), math.floor(40/zoom), "img/circle.png", 0, 0, 0, tocolor(185, 0, 0, 255), false)
                dxDrawText(nitroInfo[1], x+math.floor(1338/zoom), y+math.floor(760/zoom), math.floor(80/zoom), math.floor(80/zoom), tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "center", false, false, false, true, false)
                
                dxDrawText("Butla nitra NoS "..nitroInfo[1], x+math.floor(690/zoom), y+math.floor(270/zoom), x+w, y+h, tocolor(55, 175, 255, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Koszt butli: "..addPrzecinki(nitroInfo[3]).." PLN", x+math.floor(690/zoom), y+math.floor(295/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

                if nitroInfo[1] == "x2" then
                    exports["nrpg_buttons"]:dxCreateButton("Zamontuj nitro x2", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
                else
                    exports["nrpg_buttons"]:dxCreateButton("Ulepsz nitro do "..nitroInfo[1], kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom), 1, {225, 155, 0, 255})
                end
            
                exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom), 2, {175, 55, 55, 255})
            else
                dxDrawImage(kompoPos.x+math.floor(295/zoom), kompoPos.y+math.floor(75/zoom), math.floor(200/zoom), math.floor(200/zoom), "img/nitro.png", 0, 0, 0, tocolor(200, 75, 75, 255), false)

                dxDrawText("Nie możesz ulepszyć butli nitra", x+math.floor(690/zoom), y+math.floor(270/zoom), x+w, y+h, tocolor(255, 55, 55, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "center", "top", false, false, false, true, false)
                dxDrawText("Posiadasz maksymalne ulepszenie butli nitra", x+math.floor(690/zoom), y+math.floor(295/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

                exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom), 2, {175, 55, 55, 255})
            end
        elseif main.actualWindow == "headlights" then

            if main.selectedLightsInfo.id == nil then
                local saveColor = getElementData(main.actualVehicle, "saveLights")
                setVehicleOverrideLights(main.actualVehicle, 1)
                setVehicleHeadLightColor(main.actualVehicle, saveColor[1], saveColor[2], saveColor[3])
            else
                local lightsColor = main.selectedLightsInfo.color
                setVehicleOverrideLights(main.actualVehicle, 2)
                setVehicleHeadLightColor(main.actualVehicle, lightsColor[1], lightsColor[2], lightsColor[3])
            end
            

            yList = 0
            for i,v in ipairs(main.headlightsColors) do
                if i >= scrollLightPos.k and i <= scrollLightPos.n then 
                    yList = yList + 1
                    offsetYH = math.floor(56/zoom)*(yList-1)

                    if main.selectedLightsInfo.id == i then
                        dxDrawImage(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetYH, math.floor(755/zoom), math.floor(55/zoom), interface.compoList, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                    else
                        dxDrawImage(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetYH, math.floor(755/zoom), math.floor(55/zoom), interface.compoList, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                    end
                    
                    local color = v[2]
                    dxDrawImage(kompoPos.x+math.floor(30/zoom), kompoPos.y+math.floor(57/zoom)+offsetYH, math.floor(45/zoom), math.floor(45/zoom), "img/lights.png", 0, 0, 0, tocolor(color[1], color[2], color[3], 255), false)

                    dxDrawText(v[1], x+math.floor(85/zoom), y+math.floor(62/zoom)+offsetYH, x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)

                    if tonumber(v[3]) then
                        dxDrawText("Cena: #49ff30"..addPrzecinki(v[3]).." PLN", x+math.floor(85/zoom), y+math.floor(82/zoom)+offsetYH, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    else
                        dxDrawText("Cena: #49ff30"..v[3].." PLN", x+math.floor(85/zoom), y+math.floor(82/zoom)+offsetYH, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    end
                end
            end
            drawScrollbar(main.headlightsColors, kompoPos.x+math.floor(775/zoom), kompoPos.y+math.floor(55/zoom), math.floor(275/zoom), scrollLightPos.m, scrollLightPos.k)

            dxDrawText("Informacje dotyczące koloru lamp", x+math.floor(15/zoom), y+math.floor(337/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
            dxDrawText("Cena: #49ff30"..addPrzecinki(main.selectedLightsInfo.cost).." PLN#ffffff\nNazwa: #ffae00"..(main.selectedLightsInfo.name or "Wybierz lampy z listy").."", x+math.floor(15/zoom), y+math.floor(360/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)

            exports["nrpg_buttons"]:dxCreateButton("Zmień kolor lamp", kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(335/zoom), math.floor(135/zoom), math.floor(28/zoom), 1, {225, 155, 0, 255})
            exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(368/zoom), math.floor(135/zoom), math.floor(28/zoom), 1, {175, 55, 55, 255})
        elseif main.actualWindow == "speedo" then
            zList = 0
            for i,v in ipairs(main.speedoColors) do
                if i >= scrollSpeedoPos.k and i <= scrollSpeedoPos.n then 
                    zList = zList + 1
                    offsetYHZ = math.floor(56/zoom)*(zList-1)

                    if main.selectedSpeedoInfo.id == i then
                        dxDrawImage(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetYHZ, math.floor(755/zoom), math.floor(55/zoom), interface.compoList, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                    else
                        dxDrawImage(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetYHZ, math.floor(755/zoom), math.floor(55/zoom), interface.compoList, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                    end
                    
                    local color = v[2]
                    dxDrawImage(kompoPos.x+math.floor(30/zoom), kompoPos.y+math.floor(57/zoom)+offsetYHZ, math.floor(45/zoom), math.floor(45/zoom), "img/speedo.png", 0, 0, 0, tocolor(color[1], color[2], color[3], 255), false)

                    dxDrawText(v[1], x+math.floor(85/zoom), y+math.floor(62/zoom)+offsetYHZ, x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)

                    if tonumber(v[3]) then
                        dxDrawText("Cena: #49ff30"..addPrzecinki(v[3]).." PLN", x+math.floor(85/zoom), y+math.floor(82/zoom)+offsetYHZ, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    else
                        dxDrawText("Cena: #49ff30"..v[3].." PLN", x+math.floor(85/zoom), y+math.floor(82/zoom)+offsetYHZ, x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    end
                end
            end
            if main.selectedSpeedoInfo.id ~= nil then
                exports["nrpg_speedo"]:drawLicznikPodglad(main.selectedSpeedoInfo.color[1], main.selectedSpeedoInfo.color[2], main.selectedSpeedoInfo.color[3])
            end
            drawScrollbar(main.speedoColors, kompoPos.x+math.floor(775/zoom), kompoPos.y+math.floor(55/zoom), math.floor(275/zoom), scrollSpeedoPos.m, scrollSpeedoPos.k)

            dxDrawText("Informacje dotyczące koloru licznika", x+math.floor(15/zoom), y+math.floor(337/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money13'), "left", "top", false, false, false, true, false)
            dxDrawText("Cena: #49ff30"..addPrzecinki(main.selectedSpeedoInfo.cost).." PLN#ffffff\nNazwa: #ffae00"..(main.selectedSpeedoInfo.name or "Wybierz licznik z listy").."", x+math.floor(15/zoom), y+math.floor(360/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)

            exports["nrpg_buttons"]:dxCreateButton("Zmień kolor licznika", kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(335/zoom), math.floor(135/zoom), math.floor(28/zoom), 1, {225, 155, 0, 255})
            exports["nrpg_buttons"]:dxCreateButton("Wstecz", kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(368/zoom), math.floor(135/zoom), math.floor(28/zoom), 1, {175, 55, 55, 255})
        end
    end
end

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" and main.windowType == "kompo" then

        yList = 0
        for i,v in ipairs(main.headlightsColors) do
            if i >= scrollLightPos.k and i <= scrollLightPos.n then 
                yList = yList + 1
                offsetYH = math.floor(56/zoom)*(yList-1)

                if isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetYH, math.floor(755/zoom), math.floor(55/zoom)) and main.actualWindow == "headlights" then
                    main.selectedLightsInfo.id = i
                    main.selectedLightsInfo.name = v[1]
                    main.selectedLightsInfo.cost = v[3]
                    main.selectedLightsInfo.color = v[2]
                end 
            end
        end

        zList = 0
        for i,v in ipairs(main.speedoColors) do
            if i >= scrollSpeedoPos.k and i <= scrollSpeedoPos.n then 
                zList = zList + 1
                offsetYHZ = math.floor(56/zoom)*(zList-1)

                if isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom)+offsetYHZ, math.floor(755/zoom), math.floor(55/zoom)) and main.actualWindow == "speedo" then
                    main.selectedSpeedoInfo.id = i
                    main.selectedSpeedoInfo.name = v[1]
                    main.selectedSpeedoInfo.cost = v[3]
                    main.selectedSpeedoInfo.color = v[2]
                end 
            end
        end

        rList = 0
        for i,v in ipairs(main.savedColors) do
            if i >= scrollColorPos.k and i <= scrollColorPos.n then 
                rList = rList + 1
                offsetYC = math.floor(37/zoom)*(rList-1)

                if isMouseIn(kompoPos.x+math.floor(517/zoom), kompoPos.y+math.floor(57/zoom)+offsetYC, math.floor(251/zoom), math.floor(35/zoom)) then
                    if main.actualWindow == "rimscolor" or main.actualWindow == "vehcolor" then
                        main.selectedColor = v.id
                        local theColor = split(v["color"], ",")
                        pickerData["color"][1], pickerData["color"][2], pickerData["color"][3] = theColor[1], theColor[2], theColor[3]
                    end
                end
            end
        end

        if isMouseIn(kompoPos.x+math.floor(515/zoom), kompoPos.y+math.floor(360/zoom), math.floor(125/zoom), math.floor(30/zoom)) then
            if main.actualWindow == "rimscolor" or main.actualWindow == "vehcolor" then
                triggerServerEvent("manageColors", localPlayer, localPlayer, "add", _, {pickerData["color"][1], pickerData["color"][2], pickerData["color"][3]})
            end
        elseif isMouseIn(kompoPos.x+math.floor(645/zoom), kompoPos.y+math.floor(360/zoom), math.floor(125/zoom), math.floor(30/zoom)) then
            if main.actualWindow == "rimscolor" or main.actualWindow == "vehcolor" then
                if main.selectedColor ~= nil then
                    triggerServerEvent("manageColors", localPlayer, localPlayer, "delete", main.selectedColor, _)
                end
            end
        end

        if isMouseIn(kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(335/zoom), math.floor(135/zoom), math.floor(28/zoom)) and main.actualWindow == "headlights" then
            if main.selectedLightsInfo.cost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end
            if main.selectedLightsInfo.id == nil then exports.nrpg_interface:showPlayerNotification("Zaznacz lampy, które chcesz zakupić", "error", 3000, "Zmiana koloru lamp") return end

            triggerServerEvent("changeVehicleLightsColor", localPlayer, main.actualVehicle, main.selectedLightsInfo.cost, main.selectedLightsInfo.name, main.selectedLightsInfo.color)
            main.selectedLightsInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
        elseif isMouseIn(kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(368/zoom), math.floor(135/zoom), math.floor(28/zoom)) and main.actualWindow == "headlights" then
            main.theCost = 0
            main.actualWindow = "list"
            main.windowType = "kompo"
            setVehicleOverrideLights(main.actualVehicle, 1)
            local saveColor = getElementData(main.actualVehicle, "saveLights")
            setVehicleHeadLightColor(main.actualVehicle, saveColor[1], saveColor[2], saveColor[3])
        end

        if isMouseIn(kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(335/zoom), math.floor(135/zoom), math.floor(28/zoom)) and main.actualWindow == "speedo" then
            if main.selectedSpeedoInfo.cost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end
            if main.selectedSpeedoInfo.id == nil then exports.nrpg_interface:showPlayerNotification("Zaznacz licznik, który chcesz zakupić", "error", 3000, "Zmiana koloru lamp") return end

            triggerServerEvent("changeVehicleSpeedoColor", localPlayer, main.actualVehicle, main.selectedSpeedoInfo.cost, main.selectedSpeedoInfo.name, main.selectedSpeedoInfo.color)
            main.selectedSpeedoInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
        elseif isMouseIn(kompoPos.x+math.floor(635/zoom), kompoPos.y+math.floor(368/zoom), math.floor(135/zoom), math.floor(28/zoom)) and main.actualWindow == "speedo" then
            main.theCost = 0
            main.actualWindow = "list"
            main.windowType = "kompo"
        end
        
        if isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom)) and main.actualWindow == "engineupgrade" then
            if main.theCost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end
            local vehEngineInfo = getVehicleEngineInfo(main.actualVehicle)
            local engine = getElementData(main.actualVehicle, "Pojemnosc:silnika") or "1.4"
            if engine == "2.8" then return end

            triggerServerEvent("upgradeVehicleEngine", localPlayer, main.actualVehicle, main.theCost, vehEngineInfo[1])
        elseif isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom)) and main.actualWindow == "engineupgrade" then
            main.theCost = 0
            main.actualWindow = "list"
            main.windowType = "kompo"
        end

        if isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom)) and main.actualWindow == "licenseplate" then
            if main.theCost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end

            local plateName = exports["nrpg_interface"]:getCustomEditboxText('license:text')

            if main.wrongLicenses[plateName] then
                return exports.nrpg_interface:showPlayerNotification("Tablica posiada zabronione słowo", "error", 3000, "Zmiana tablicy")
            end

            if string.len(plateName) > 8 then
                return exports.nrpg_interface:showPlayerNotification("Tablica posiada za dużo znaków", "error", 3000, "Zmiana tablicy")
            end

            if 1 > string.len(plateName) then
                return exports.nrpg_interface:showPlayerNotification("Tablica posiada zbyt mało znaków", "error", 3000, "Zmiana tablicy")
            end

            triggerServerEvent("changeLicensePlate", localPlayer, main.actualVehicle, main.theCost, plateName)
        elseif isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom)) and main.actualWindow == "licenseplate" then
            main.theCost = 0
            main.actualWindow = "list"
            main.windowType = "kompo"
            exports["nrpg_interface"]:destroyCustomEditbox('license:text')
        end

        if isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(330/zoom), math.floor(770/zoom), math.floor(30/zoom)) and main.actualWindow == "nitromontage" then
            if main.theCost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end

            local nitroType = getVehicleUpgradeOnSlot(main.actualVehicle, 8)
            local nitroInfo = getVehicleNitroMontage(main.actualVehicle)
            
            if nitroType == 1010 then
                return
            end

            triggerServerEvent("montageNitro", localPlayer, main.actualVehicle, main.theCost, nitroInfo[1], nitroInfo[2])
        elseif isMouseIn(kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(365/zoom), math.floor(770/zoom), math.floor(30/zoom)) and main.actualWindow == "nitromontage" then
            main.theCost = 0
            main.actualWindow = "list"
            main.windowType = "kompo"
        end

        if isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(192/zoom), math.floor(140/zoom), math.floor(20/zoom)) and main.actualWindow == "vehcolor" then
            main.selectColor = "color2"
        elseif isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(168/zoom), math.floor(160/zoom), math.floor(20/zoom)) and main.actualWindow == "vehcolor" then
            main.selectColor = "color1"
        elseif isMouseIn(buttonsClick.colorButton.x, kompoPos.y+math.floor(274/zoom), math.floor(145/zoom), math.floor(25/zoom)) and main.actualWindow == "vehcolor" then
            setClipboard(pickerData["color"][1]..", "..pickerData["color"][2]..", "..pickerData["color"][3])
            exports.nrpg_interface:showPlayerNotification("Skopiowano link do schowka", "info", 3000, "Kolor pojazdu")
        elseif isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(55/zoom), math.floor(165/zoom), math.floor(30/zoom)) and main.actualWindow == "vehcolor" then
            if main.theCost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end
            triggerServerEvent("changeVehicleColor", localPlayer, main.actualVehicle, main.selectColor, {pickerData["color"][1], pickerData["color"][2], pickerData["color"][3]}, main.theCost)
        elseif isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(90/zoom), math.floor(165/zoom), math.floor(30/zoom)) and main.actualWindow == "vehcolor" then
            main.theCost = 0
            main.actualWindow = "list"
            destroyColorPicker()
            main.windowType = "kompo"
        end

        if isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(192/zoom), math.floor(140/zoom), math.floor(20/zoom)) and main.actualWindow == "rimscolor" then
            main.selectColor = "color4"
        elseif isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(168/zoom), math.floor(160/zoom), math.floor(20/zoom)) and main.actualWindow == "rimscolor" then
            main.selectColor = "color3"
        elseif isMouseIn(buttonsClick.colorButton.x, kompoPos.y+math.floor(274/zoom), math.floor(145/zoom), math.floor(25/zoom)) and main.actualWindow == "rimscolor" then
            setClipboard(pickerData["color"][1]..", "..pickerData["color"][2]..", "..pickerData["color"][3])
            exports.nrpg_interface:showPlayerNotification("Skopiowano link do schowka", "info", 3000, "Kolor felg")
        elseif isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(55/zoom), math.floor(165/zoom), math.floor(30/zoom)) and main.actualWindow == "rimscolor" then
            if main.theCost > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error", 3000, "Brak gotówki") return end
            triggerServerEvent("changeVehicleColor", localPlayer, main.actualVehicle, main.selectColor, {pickerData["color"][1], pickerData["color"][2], pickerData["color"][3]}, main.theCost)
        elseif isMouseIn(kompoPos.x+math.floor(325/zoom), kompoPos.y+math.floor(90/zoom), math.floor(165/zoom), math.floor(30/zoom)) and main.actualWindow == "rimscolor" then
            main.theCost = 0
            main.actualWindow = "list"
            destroyColorPicker()
            main.windowType = "kompo"
        end


        xList = 0
        for i,v in ipairs(main.components) do
            if i >= scrollPos.k and i <= scrollPos.n then
                xList = xList + 1
                offsetY = math.floor(86/zoom)*(xList-1)

                if isMouseIn(kompoPos.x+math.floor(655/zoom), kompoPos.y+math.floor(80/zoom)+offsetY, math.floor(100/zoom), math.floor(30/zoom)) and main.actualWindow == "list" then
                    if v[1] == "Zmiana koloru pojazdu" then
                        main.actualWindow = "vehcolor"
                        main.theCost = v[2]
                        main.selectColor = "color1"
                        main.selectedColor = nil
                        scrollColorPos = {k=1, m=9, n=9}
                        triggerServerEvent("manageColors", localPlayer, localPlayer, "load")
                        local veh = main.actualVehicle
                        createColorPicker(veh, kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom), math.floor(300/zoom), math.floor(150/zoom), "color1")
                    elseif v[1] == "Zmiana koloru felg" then
                        main.actualWindow = "rimscolor"
                        main.theCost = v[2]
                        main.selectColor = "color3"
                        main.selectedColor = nil
                        scrollColorPos = {k=1, m=9, n=9}
                        triggerServerEvent("manageColors", localPlayer, localPlayer, "load")
                        local veh = main.actualVehicle
                        createColorPicker(veh, kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom), math.floor(300/zoom), math.floor(150/zoom), "color3")
                    elseif v[1] == "Zwiększanie pojemności silnika" then
                        main.actualWindow = "engineupgrade"
                    elseif v[1] == "Zmiana rejestracji" then
                        main.actualWindow = "licenseplate"
                        main.theCost = v[2]
                        exports["nrpg_interface"]:destroyCustomEditbox('license:text')
                        exports['nrpg_interface']:createCustomEditbox('license:text', getVehiclePlateText(main.actualVehicle), kompoPos.x+math.floor(15/zoom), kompoPos.y+math.floor(55/zoom), math.floor(770/zoom), math.floor(45/zoom), false, "", false, {25, 25, 25}, ":nrpg_components/img/plate.png")
                    elseif v[1] == "Montaż butli nitra" then
                        main.actualWindow = "nitromontage"
                    elseif v[1] == "Zmiana koloru lamp" then
                        main.actualWindow = "headlights"
                        main.selectedLightsInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
                        local r, g, b = getVehicleHeadLightColor(main.actualVehicle)
                        setElementData(main.actualVehicle, "saveLights", {r, g, b})
                    elseif v[1] == "Zmiana koloru licznika" then
                        main.actualWindow = "speedo"
                        main.selectedSpeedoInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
                    end
                end
            end
        end
    end
end)

function getVehicleNitroMontage(veh)
    local nitroType = getVehicleUpgradeOnSlot(veh, 8)

    if nitroType == 1009 then
        return {"x5", 1008, 150000}
    elseif nitroType == 1008 then
        return {"x10", 1010, 250000}
    else
        return {"x2", 1009, 100000}
    end
end

function getVehicleEngineInfo(veh)
    local engine = getElementData(veh, "Pojemnosc:silnika") or "1.4"
    
    if engine == "1.4" then
        return {"1.6", 85000}
    elseif engine == "1.6" then
        return {"1.8", 100000}
    elseif engine == "1.8" then
        return {"2.0", 115000}
    elseif engine == "2.0" then
        return {"2.2", 150000}
    elseif engine == "2.2" then
        return {"2.4", 185000}
    elseif engine == "2.4" then
        return {"2.6", 200000}
    elseif engine == "2.6" then
        return {"2.8", 250000}
    end
end

function openGUI(el)
    if (el == localPlayer) and not getPedOccupiedVehicle(el) and main.enterShape then
        if getShapeVehicles(main.enterShape) > 1 then
            exports.nrpg_interface:showPlayerNotification("Na stanowisku może znajdować się tylko jeden pojazd", "error")
        else
            if #getShapeVehicle(main.enterShape) == 1 then
                for i,v in ipairs(getShapeVehicle(main.enterShape)) do
                    main.actualVehicle = v
                end

                if getVehicleEngineState(main.actualVehicle) then
                    return
                end

                if getVehicleOverrideLights(main.actualVehicle) == 2 then
                    return
                end

                if not isElementFrozen(main.actualVehicle) then
                    return
                end

                if getElementData(localPlayer, "player:sid") ~= getElementData(main.actualVehicle, "vehicle:ownedPlayer") then
                    return
                end

                main.windowType = "kompo"

                if not isEventHandlerAdded("onClientRender", root, main.renderUI) then
                    addEventHandler("onClientRender", root, main.renderUI)
                end

                showCursor(true, false)
            end
        end
    end
end

function closeGUI(el)
    if (el == localPlayer) and not getPedOccupiedVehicle(el) and main.enterShape then
        if isEventHandlerAdded("onClientRender", root, main.renderUI) then
            removeEventHandler("onClientRender", root, main.renderUI)
        end
        setVehicleOverrideLights(main.actualVehicle, 1)
        destroyColorPicker()
        main.theCost = 0
        main.actualWindow = "list"
        main.windowType = "info"
        main.selectedLightsInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
        main.selectedSpeedoInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
        exports["nrpg_interface"]:destroyCustomEditbox('license:text')
        showCursor(false)
        setVehicleOverrideLights(main.actualVehicle, 1)
        local saveColor = getElementData(main.actualVehicle, "saveLights")
        if saveColor then
            setVehicleHeadLightColor(main.actualVehicle, saveColor[1], saveColor[2], saveColor[3])
        end

        main.actualVehicle = nil
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    for i,v in ipairs(main.positions) do
        local marker = createMarker(v[1], v[2], v[3]-0.95, "cylinder", 1, 35, 175, 255, 55)
        setElementData(marker, "marker:text", "Tuning wizualny")
        setElementData(marker, "marker:downtext", "Montaż komponentów")
        setElementData(marker, "marker:icon", "spray")

        addEventHandler("onClientMarkerHit", marker, openGUI)
        addEventHandler("onClientMarkerLeave", marker, closeGUI)

        local cuboid = createColCuboid(v[4], v[5], v[6], v[7], v[8], v[9])
        setElementData(cuboid, "colID", i)
    end
end)

addEventHandler("onClientVehicleExit", root, function(thePlayer, seat)
    if thePlayer == getLocalPlayer() and seat == 0 and main.enterShape then
        local shape = getShape(main.enterShape)
        if shape then
            if isElementWithinColShape(source, shape) then
                main.windowType = nil

                if isEventHandlerAdded("onClientRender", root, main.renderUI) then
                    removeEventHandler("onClientRender", root, main.renderUI)
                end
            end
        end
    end
end)

addEventHandler("onClientVehicleEnter", root, function(thePlayer, seat)
    if thePlayer == getLocalPlayer() and seat == 0 and main.enterShape then
        local shape = getShape(main.enterShape)
        if shape then
            if isElementWithinColShape(source, shape) then
                main.windowType = "info"

                if not isEventHandlerAdded("onClientRender", root, main.renderUI) then
                    addEventHandler("onClientRender", root, main.renderUI)
                end
            end
        end
    end
end)

function hitShape(el)
    if (el == localPlayer) and getPedOccupiedVehicle(el) and getElementData(source, "colID") then
        local veh = getPedOccupiedVehicle(el)

        if getVehicleController(veh) == el then
            if not isEventHandlerAdded("onClientRender", root, main.renderUI) then
                addEventHandler("onClientRender", root, main.renderUI)
            end
            main.windowType = "info"
            main.enterShape = getElementData(source, "colID")
        end
    end
end
addEventHandler("onClientColShapeHit", resourceRoot, hitShape)

function hitShape2(el)
    if (el == localPlayer) and getElementData(source, "colID") and getPedOccupiedVehicle(el) then
        if isEventHandlerAdded("onClientRender", root, main.renderUI) then
            removeEventHandler("onClientRender", root, main.renderUI)
            destroyColorPicker()
        end
        main.windowType = nil
        main.enterShape = nil
        main.selectedLightsInfo = {cost=0, id=nil, name=nil, color={255, 255, 255}}
        
        if main.actualVehicle then
            local saveColor = getElementData(getPedOccupiedVehicle(el), "saveLights")

            if saveColor then
                setVehicleHeadLightColor(getPedOccupiedVehicle(el), saveColor[1], saveColor[2], saveColor[3])
            end
        end

        main.actualVehicle = nil
    end
end
addEventHandler("onClientColShapeLeave", resourceRoot, hitShape2)

function getShapeVehicles(id)
    for i, v in ipairs(getElementsByType("colshape", resourceRoot, true)) do
        if id == getElementData(v, "colID") then
            return (#getElementsWithinColShape(v, "vehicle"))
        end
    end
end

function getShapeVehicle(id)
    for i, v in ipairs(getElementsByType("colshape", resourceRoot, true)) do
        if id == getElementData(v, "colID") then
            return (getElementsWithinColShape(v, "vehicle"))
        end
    end
end

function getShape(id)
    for i, v in ipairs(getElementsByType("colshape", resourceRoot, true)) do
        if id == getElementData(v, "colID") then
            return v
        end
    end
end

function drawScrollbar(table, x, y, height, m_, k_)
    dxDrawImage(x, y, 8, height, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

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

		dxDrawImage(x, scrollbarPos, 8, scrollbarHeight*(m_-1), interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end

    cx,cy = getCursorPosition()
    cx,cy = cx*screenW, cy*screenH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end

addEvent("loadColors", true)
addEventHandler("loadColors", root, function(table)
	main.savedColors = table
end)

bindKey("mouse_wheel_down", "both", function()
    if main.actualWindow == "list" then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if main.actualWindow == "list" then
        scrollDown()
    end
end)

function scrollDown()
    if scrollPos.n == scrollPos.m then return end
    scrollPos.k = scrollPos.k-1
    scrollPos.n = scrollPos.n-1
end

function scrollUp()
    if scrollPos.n >= #main.components then return end
    scrollPos.k = scrollPos.k+1
    scrollPos.n = scrollPos.n+1
end

bindKey("mouse_wheel_down", "both", function()
    if main.actualWindow == "headlights" then
        scrollUp2()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if main.actualWindow == "headlights" then
        scrollDown2()
    end
end)

function scrollDown2()
    if scrollLightPos.n == scrollLightPos.m then return end
    scrollLightPos.k = scrollLightPos.k-1
    scrollLightPos.n = scrollLightPos.n-1
end

function scrollUp2()
    if scrollLightPos.n >= #main.headlightsColors then return end
    scrollLightPos.k = scrollLightPos.k+1
    scrollLightPos.n = scrollLightPos.n+1
end

bindKey("mouse_wheel_down", "both", function()
    if main.actualWindow == "speedo" then
        scrollUp3()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if main.actualWindow == "speedo" then
        scrollDown3()
    end
end)

function scrollDown3()
    if scrollSpeedoPos.n == scrollSpeedoPos.m then return end
    scrollSpeedoPos.k = scrollSpeedoPos.k-1
    scrollSpeedoPos.n = scrollSpeedoPos.n-1
end

function scrollUp3()
    if scrollSpeedoPos.n >= #main.speedoColors then return end
    scrollSpeedoPos.k = scrollSpeedoPos.k+1
    scrollSpeedoPos.n = scrollSpeedoPos.n+1
end

bindKey("mouse_wheel_down", "both", function()
    if main.actualWindow == "rimscolor" or main.actualWindow == "vehcolor" then
        scrollUp4()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if main.actualWindow == "rimscolor" or main.actualWindow == "vehcolor" then
        scrollDown4()
    end
end)

function scrollDown4()
    if scrollColorPos.n == scrollColorPos.m then return end
    scrollColorPos.k = scrollColorPos.k-1
    scrollColorPos.n = scrollColorPos.n-1
end

function scrollUp4()
    if scrollColorPos.n >= #main.savedColors then return end
    scrollColorPos.k = scrollColorPos.k+1
    scrollColorPos.n = scrollColorPos.n+1
end

function addPrzecinki(amount) 
    local formatted = amount 
    while true do   
      formatted, przecinek = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (przecinek==0) then 
        break 
      end 
    end 
    return formatted 
end