zoom = 1
sW, sH = guiGetScreenSize()
if sW < 1920 then
    zoom = math.min(2, 1920 / sW)
end

main = {

    getLib = exports.nrpg_lib,
    tab = nil,

}

interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(200, 155, 0, 255)),
    backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(45, 45, 45, 255)),
    backgroundRectangle3 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(100, 100, 100, 255)),
    buttonRectangle = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(200, 155, 0, 255)),
    backgroundKeyRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(55, 55, 55, 255)),
    keyRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(75, 75, 75, 255)),

}

helpText = [[
Witaj graczu na NitroRPG!

Jesteś nowy/a? Zaczynasz grac? Dobrze trafiłeś/aś! Ten krótki poradnik pomoże ci zacząć grę na naszym serwerze!
Na sam początek zdaj prawo jazdy w OSK, najlepiej aby była to kategoria B, prawo jazdy jest darmowe więc bez obaw.
Prawo jazdy zdane? Udaj się do pracy dorywczej (na sam początek polecamy magazyniera, streetview bądź też busy), kiedy zarobisz już swoje pierwsze pieniądze udaj się do salonu czy też tzw. Cygana
zakupisz tam swoją pierwszą bryke. Na serwerze jest mnóstwo tuningów więc masz na co zarabiać, prócz tego możesz pobawić się w budowniczego i udekorować swoje mieszkanie, oczywiście zakładając, że sobie je zakupisz.

Co dalej? O tym decydujesz już ty! Życzymy miłej gry.
]]

jobText = [[
- Górnik,
- Lawety, 
- Magazynier,
- Rybak,
- Taksometr,
- StreetView,
- Kierowca autobusu,
- Kurier,
- Zapylanie,
- Maszynista

Niektóre z prac posiadają ulepszenia czy też swoje wymagania. SRP możesz zdobywać poprzez pracę na np. Magazynierze, tam jest największa szansa, że otrzymasz więcej SRP.
Co do ulepszeń, na niektórych pracach są Punkty, które zdobywasz poprzez pracę na owej pracy dorywczej.
]]

premiumText = [[
Gdzie zakupić konto diamond?
Premium możesz zakupić w panelu gracza (F5).

Korzyści konta diamond:
- Pieniądze co godzinę,
- Skiny premium w przebieralni,
- Specjalny czat diamond (/vp - diamond),
- Większy zarobek na większości prac (diamond - 50%),
- Unikatowy kolor nicku (Niebieski - diamond)

Gdzie zakupić punkty premium?
Punkty premium zakupisz u jednego z Ownerów, akceptowane płatności:
- Blik, PayPal, SMS, PaySafeCard, Przelew.
]]

main.drawButton = function(text, x, y, w, h)
    if isMouseIn(x, y, w, h) then
        if getKeyState("mouse1") then
            dxDrawImage(x, y, w, h, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
            dxDrawText(text, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true)  
        else
            dxDrawImage(x, y, w, h, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 155), false)
            dxDrawText(text, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true)  
        end
    else
        dxDrawImage(x, y, w, h, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText(text, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true)  
    end
end

main.drawKey = function(text, text2, x, y, w, h)
    local width = dxGetTextWidth(text2, 1/zoom, exports.nrpg_interface:getGUIFont("light11"))
    local width = width + (15/zoom)
    dxDrawImage(x+w/2, y, w+width-w/2, h, interface.backgroundKeyRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(x, y, w, h, interface.keyRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText(text, x+2, y+2, w+x, h+y, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "center", "center", false, true)  
    dxDrawText(text2, x+6+w, y+2, w+x, h+y, tocolor(255, 255, 255, 225), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
end

main.renderHelp = function()
    dxDrawImage(500/zoom, 245/zoom, 900/zoom, 580/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(502/zoom, 247/zoom, 896/zoom, 576/zoom, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(510/zoom, 255/zoom, 880/zoom, 55/zoom, interface.backgroundRectangle3, 0, 0, 0, tocolor(255, 255, 255, 55), false)
    dxDrawText("PANEL POMOCY", 600/zoom, 5/zoom, 1280/zoom, 560/zoom, tocolor(200, 200, 200, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "center", false, true)  

    main.drawButton("Pomoc", 530/zoom, 325/zoom, 130/zoom, 30/zoom)
    main.drawButton("Klawiszologia", 665/zoom, 325/zoom, 130/zoom, 30/zoom)
    main.drawButton("Prace dorywcze", 800/zoom, 325/zoom, 130/zoom, 30/zoom)
    main.drawButton("Diamond", 935/zoom, 325/zoom, 130/zoom, 30/zoom)

    if main.tab ~= nil then
        if main.tab == "Pomoc" then
            dxDrawText("Pomocnik", 535/zoom, 325/zoom, 1125/zoom, 560/zoom, tocolor(200, 175, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, true)  
            dxDrawText(helpText, 535/zoom, 455/zoom, 1366/zoom, 560/zoom, tocolor(200, 200, 200, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "top", false, true) 
        elseif main.tab == "Klawiszologia" then
            dxDrawText("Klawiszologia", 535/zoom, 260/zoom, 1125/zoom, 560/zoom, tocolor(200, 175, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, true)  
            main.drawKey("Z", "Czat głosowy", 532/zoom, 425/zoom, 50/zoom, 50/zoom)
            main.drawKey("F3", "Pokaż/Schowaj kursor", 690/zoom, 425/zoom, 50/zoom, 50/zoom)
            main.drawKey("K", "Pokaż/Schowaj okno taksometru", 905/zoom, 425/zoom, 50/zoom, 50/zoom)
            main.drawKey("F1", "Panel pomocy", 532/zoom, 480/zoom, 50/zoom, 50/zoom)
            main.drawKey("F7", "Pokaż/Schowaj HUD", 695/zoom, 480/zoom, 50/zoom, 50/zoom)
            main.drawKey("F5", "Panel gracza", 532/zoom, 535/zoom, 50/zoom, 50/zoom)
            main.drawKey("F11", "Mapa", 688/zoom, 535/zoom, 50/zoom, 50/zoom)
            main.drawKey("M", "Megafon frakcji", 532/zoom, 590/zoom, 50/zoom, 50/zoom)
            main.drawKey("F8", "Konsola", 704/zoom, 590/zoom, 50/zoom, 50/zoom)
            main.drawKey("Y", "Czat frakcji", 532/zoom, 645/zoom, 50/zoom, 50/zoom)
            main.drawKey("F6", "Panel administracji", 678/zoom, 645/zoom, 50/zoom, 50/zoom)
            main.drawKey("U", "Krótkofalówka frakcyjna", 532/zoom, 700/zoom, 50/zoom, 50/zoom)
            main.drawKey("I", "Ekwipunek", 759/zoom, 700/zoom, 50/zoom, 50/zoom)
        elseif main.tab == "Prace dorywcze" then
            dxDrawText("Prace dorywcze, które u nas znajdziesz", 535/zoom, 325/zoom, 1125/zoom, 560/zoom, tocolor(200, 175, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, true)  
            dxDrawText(jobText, 535/zoom, 455/zoom, 1366/zoom, 560/zoom, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "top", false, true) 
        elseif main.tab == "Premium" then
            dxDrawText("Diamond", 535/zoom, 325/zoom, 1125/zoom, 560/zoom, tocolor(200, 175, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, true)  
            dxDrawText(premiumText, 535/zoom, 455/zoom, 1366/zoom, 560/zoom, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "top", false, true) 
        end
    end
end

local lastClick = getTickCount()
local clickTimer = 50


addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" and main.togglehelp == true then
        if lastClick-getTickCount() > 0 then
            return
        end
        lastClick = getTickCount()+clickTimer

        if isMouseIn(532/zoom, 325/zoom, 130/zoom, 30/zoom) then
            main.tab = "Pomoc"
        elseif isMouseIn(665/zoom, 325/zoom, 130/zoom, 30/zoom) then
            main.tab = "Klawiszologia"
        elseif isMouseIn(800/zoom, 325/zoom, 130/zoom, 30/zoom) then
            main.tab = "Prace dorywcze"
        elseif isMouseIn(935/zoom, 325/zoom, 130/zoom, 30/zoom) then
            main.tab = "Premium"
        end

    end
end)

bindKey("f1", "down", function()
    if not getElementData(localPlayer, "player:sid") then return end
    if main.togglehelp == true then
        showCursor(false)
        removeEventHandler("onClientRender", root, main.renderHelp)
        main.togglehelp = false
        main.tab = "Pomoc"
    else
        showCursor(true)
        addEventHandler("onClientRender", root, main.renderHelp)
        main.togglehelp = true
        main.tab = "Pomoc"
    end
end)


function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end

    cx,cy = getCursorPosition()
    cx,cy = cx*sW, cy*sH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end