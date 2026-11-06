main = {

    toggleGUI = false,
    actualPage = "Konto",

    pages = {

        {"Konto", "Podstawowe informacje o twoim koncie"},
        {"Pojazdy", "Lista twoich pojazdów"},
        {"Licencje", "Aktywne licencje"},
        {"Kody polecające", "Polecaj serwer i zarabiaj!"},
        {"Ustawienia", "Dostosuj serwer pod siebie!"},

    },

    pagesIcons = {

        ["Konto"] = dxCreateTexture("img/account_icon.png"),
        ["Pojazdy"] = dxCreateTexture("img/vehicle_icon.png"),
        ["Licencje"] = dxCreateTexture("img/license_icon.png"),
        ["Kody polecające"] = dxCreateTexture("img/promo_icon.png"),
        ["Ustawienia"] = dxCreateTexture("img/settings_icon.png"),

    },

}

main.renderUI = function()
    local x, y, w, h = dashboardPos.x, dashboardPos.y, math.floor(100/zoom), math.floor(50/zoom)


    dxDrawImage(dashboardPos.x, dashboardPos.y, dashboardPos.w, dashboardPos.h, interface.colorBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(dashboardPos.x+math.floor(2/zoom), dashboardPos.y+math.floor(2/zoom), dashboardPos.w-math.floor(3/zoom), dashboardPos.h-math.floor(3/zoom), interface.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    dxDrawImage(dashboardPos.x+math.floor(330/zoom), dashboardPos.y+math.floor(30/zoom), math.floor(595/zoom), math.floor(45/zoom), interface.theRectangle, 0, 0, 0, tocolor(255, 255, 255, 50), false)
    dxDrawImage(dashboardPos.x+math.floor(335/zoom), dashboardPos.y+math.floor(35/zoom), math.floor(35/zoom), math.floor(35/zoom), interface.theRectangle2, 0, 0, 0, tocolor(255, 175, 0, 100), false)
    dxDrawImage(dashboardPos.x+math.floor(335/zoom), dashboardPos.y+math.floor(35/zoom), math.floor(35/zoom), math.floor(35/zoom), main.pagesIcons[main.actualPage], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText(main.actualPage, x+math.floor(380/zoom), y+math.floor(42/zoom), x+w, y+h, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, false, false)

    dxDrawText("Główne informacje", x+math.floor(340/zoom), y+math.floor(100/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
    dxDrawText("Nick: TheNoobisty\nSID: 1\nPrzegrany czas: 140 godz. 32 min.", x+math.floor(340/zoom), y+math.floor(125/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, false, false)

    dxDrawText("Majątek", x+math.floor(340/zoom), y+math.floor(210/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
    dxDrawText("Gotówka: 25,000,000 PLN\nKonto bankowe: 50,000,000 PLN", x+math.floor(340/zoom), y+math.floor(235/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, false, false)

    dxDrawText("Organzacja", x+math.floor(340/zoom), y+math.floor(310/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
    dxDrawText("Nazwa organizacji: mtaBrasl\nIlość członków organzacji: 30/50\nZałożyciel: TheNoobisty\nTwoja ranga: Lider", x+math.floor(340/zoom), y+math.floor(335/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, false, false)


    dxDrawText("Frakcja", x+math.floor(340/zoom), y+math.floor(440/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
    dxDrawText("Nie należysz do żadnej frakcji", x+math.floor(340/zoom), y+math.floor(465/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, false, false)

    dxDrawImage(dashboardPos.x+math.floor(25/zoom), dashboardPos.y+math.floor(30/zoom), math.floor(300/zoom), math.floor(490/zoom), interface.theRectangle, 0, 0, 0, tocolor(255, 255, 255, 50), false)

    x = 0
    for i,v in ipairs(main.pages) do
        x = x + 1
        offsetY = math.floor(55/zoom)*(x-1)

        if isMouseIn(dashboardPos.x+math.floor(30/zoom), dashboardPos.y+math.floor(36/zoom)+offsetY, math.floor(290/zoom), math.floor(48/zoom)) then
            dxDrawImage(dashboardPos.x+math.floor(30/zoom), dashboardPos.y+math.floor(36/zoom)+offsetY, math.floor(290/zoom), math.floor(48/zoom), interface.theRectangle2, 0, 0, 0, tocolor(255, 255, 255, 65), false)
            dxDrawImage(dashboardPos.x+math.floor(35/zoom), dashboardPos.y+math.floor(40/zoom)+offsetY, math.floor(40/zoom), math.floor(40/zoom), main.pagesIcons[v[1]], 0, 0, 0, tocolor(255, 255, 255, 175), false)

            dxDrawText(v[1], x+math.floor(575/zoom), y+math.floor(45/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, false, false)
            dxDrawText(v[2], x+math.floor(575/zoom), y+math.floor(60/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont('light10'), "left", "top", false, false, false, false, false) 
        else
            dxDrawImage(dashboardPos.x+math.floor(30/zoom), dashboardPos.y+math.floor(36/zoom)+offsetY, math.floor(290/zoom), math.floor(48/zoom), interface.theRectangle2, 0, 0, 0, tocolor(255, 255, 255, 85), false)
            dxDrawImage(dashboardPos.x+math.floor(35/zoom), dashboardPos.y+math.floor(40/zoom)+offsetY, math.floor(40/zoom), math.floor(40/zoom), main.pagesIcons[v[1]], 0, 0, 0, tocolor(255, 255, 255, 200), false)

            dxDrawText(v[1], x+math.floor(575/zoom), y+math.floor(45/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, false, false)
            dxDrawText(v[2], x+math.floor(575/zoom), y+math.floor(60/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('light10'), "left", "top", false, false, false, false, false)
        end
    end   
end
addEventHandler("onClientRender", root, main.renderUI)

bindKey("F5", "down", function()
    if main.toggleGUI == false then
        main.togglePed(true)
        main.toggleGUI = true
    else
        main.togglePed(false)
        main.toggleGUI = false
    end
end)

if isElement(myObject) then destroyElement(myObject) end
if isElement(windowRender) then destroyElement(windowRender) end
if isElement(thePed) then destroyElement(thePed) end

main.togglePed = function(toggleMode)
    if toggleMode == true then
        thePed = createPed(getElementModel(localPlayer), 0, 0, 0)
        myObject = exports.nrpg_object_preview:createObjectPreview(thePed, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
        windowRender = guiCreateWindow(dashboardPos.x+math.floor(675/zoom), dashboardPos.y+math.floor(75/zoom), math.floor(300/zoom), math.floor(400/zoom), "", false, false)
        guiWindowSetMovable(windowRender, false)
        guiWindowSetSizable(windowRender, false) 
        guiSetAlpha(windowRender, 0)
        local projPosX, projPosY = guiGetPosition(windowRender,true)
        local projSizeX, projSizeY = guiGetSize(windowRender, true)
        exports.nrpg_object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
        exports.nrpg_object_preview:setRotation(myObject, 0, 0, 150)
    elseif toggleMode == false then
        if isElement(myObject) then destroyElement(myObject) end
        if isElement(windowRender) then destroyElement(windowRender) end
        if isElement(thePed) then destroyElement(thePed) end
    end
end