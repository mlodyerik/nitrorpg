screenW, screenH = guiGetScreenSize()
zoom = exports.nrpg_interface:getInterfaceZoom()
local windowPos = {x=math.floor(screenW/2-1000/zoom/2), y=math.floor(screenH/2-600/zoom/2), w=math.floor(1000/zoom), h=math.floor(600/zoom)}
local windowPos1 = {x=math.floor(screenW/2-1200/zoom/2), y=math.floor(screenH/2-800/zoom/2), w=math.floor(1200/zoom), h=math.floor(800/zoom)}

local sx,sy = guiGetScreenSize()
local xres,yres = (sx/1920), (sy/1080)

tabela={}
table_statistics = {}

mozliwybet = true
blokadaColor = false

windows = {
    main = false,
}

markery = {
    {1127.92, 3.01, 1000.68},
    {1126.94, 3.01, 1000.68},
    {1125.89, 3.00, 1000.68},
    {1135.06, -3.87, 1000.68},
    {1132.90, -1.80, 1000.68},
    {1134.94, 0.61, 1000.68},
    {1124.84, 3.01, 1000.68},
}

textures = {
    cross = dxCreateTexture(':nrpg_interface/img/cross.png'),
}

for i=1,6 do
table.insert(tabela,{0,0,181,0,"zielone","x14",math.random(0,14)})
table.insert(tabela,{1,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{2,0,0,0,"czarne","x2",math.random(0,14)})
table.insert(tabela,{3,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{4,0,0,0,"czarne","x2",math.random(0,14)})
table.insert(tabela,{5,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{6,0,0,0,"czarne","x2",math.random(0,14)})
table.insert(tabela,{7,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{8,0,0,0,"czarne","x2",math.random(0,14)})
table.insert(tabela,{9,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{10,0,0,0,"czarne","x2",math.random(0,14)})
table.insert(tabela,{11,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{12,0,0,0,"czarne","x2",math.random(0,14)})
table.insert(tabela,{13,255,0,0,"czerwone","x2",math.random(0,14)})
table.insert(tabela,{14,0,0,0,"czarne","x2",math.random(0,14)})
end

betyr={}
betyb={}
betyg={}


iloscokienek=75
czas = 4000
kolejnelosowanie = 0
kolejnelosowaniestart= 0

function betowaniefroms(kolor,kwota)
    ilosc = 0
    if kolor == "red" then
        for i,v in pairs(betyr) do
            if betyr[i][1] == getPlayerName(source) then
                ilosc = betyr[i][2]
                table.remove (betyr,i)
            end
        end
        table.insert ( betyr,{""..getPlayerName(source).."", tonumber(kwota+ilosc)})
        table.sort(betyr, function(a, b) return a[2]>b[2] end)
    end

    if kolor == "black" then
        for i,v in pairs(betyb) do
            if betyb[i][1] == getPlayerName(source) then
                ilosc = betyb[i][2]
                table.remove (betyb,i)
            end
        end
        table.insert ( betyb,{""..getPlayerName(source).."", tonumber(kwota+ilosc)})
        table.sort(betyb, function(a, b) return a[2]>b[2] end)
    end

    if kolor == "green" then
        for i,v in pairs(betyg) do
            if betyg[i][1] == getPlayerName(source) then
                ilosc = betyg[i][2]
                table.remove (betyg,i)
            end
        end
        table.insert ( betyg,{""..getPlayerName(source).."", tonumber(kwota+ilosc)})
        table.sort(betyg, function(a, b) return a[2]>b[2] end)
    end
end
addEvent("betowanietoc", true )
addEventHandler("betowanietoc", getRootElement(), betowaniefroms)

bankMoney = 0

function getPlayerBankMoney()
    return bankMoney
end

function triggerBankMoney(money)
    bankMoney = money
end
addEvent("triggerMoney", true )
addEventHandler("triggerMoney", getRootElement(), triggerBankMoney)

ruletkapola = dxCreateRenderTarget(1100/zoom, 70/zoom, true)
ruletkabety = dxCreateRenderTarget(1100/zoom, 390/zoom, true)
start = getTickCount()
koniec= getTickCount()
random = 15
winColor = {}

function window()
    if windows.main == true then
        local xTEXT, yTEXT, wTEXT, hTEXT = windowPos.x, windowPos.y, windowPos.w, windowPos.h
        x =94*6.21/zoom
        exports["buttons"]:createCustomWindow("", windowPos1.x-math.floor(2/zoom), windowPos1.y, windowPos1.w+math.floor(3/zoom), windowPos1.h, tocolor(255, 255, 255, 255), false) 

        if isMouseIn(windowPos1.x+windowPos1.w-math.floor(35/zoom), windowPos1.y+math.floor(8/zoom), math.floor(27/zoom), math.floor(27/zoom)) then
            dxDrawImage(windowPos1.x+windowPos1.w-math.floor(36/zoom), windowPos1.y+math.floor(8/zoom), math.floor(27/zoom), math.floor(27/zoom), textures.cross, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(windowPos1.x+windowPos1.w-math.floor(35/zoom), windowPos1.y+math.floor(9/zoom), math.floor(25/zoom), math.floor(25/zoom), textures.cross, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end

        aktualnyczas= getTickCount()
        if aktualnyczas > kolejnelosowanie then
            text = "LOSOWANIE TRWA"
        else
            zailelosowanie = (kolejnelosowanie-aktualnyczas)/1000
            zailelosowanie = string.format("%.1f", zailelosowanie ) 
            text = "LOSOWANIE ROZPOCZNIE SIĘ ZA "..math.floor(zailelosowanie).." SEKUND/Y"
        end

        dxDrawRectangle(windowPos1.x+math.floor(10/zoom), windowPos1.y+math.floor(105/zoom), math.floor(1180/zoom), math.floor(10/zoom), tocolor(60, 60, 60, 190), false)

        local postepodliczania = (aktualnyczas-kolejnelosowaniestart)/(kolejnelosowanie-kolejnelosowaniestart)
        odliczaniepasek= interpolateBetween(math.floor(1180/zoom),0,0,math.floor(0/zoom),0,0,postepodliczania ,'OutQuad')

        if odliczaniepasek > 0 then
            dxDrawRectangle(windowPos1.x+math.floor(10/zoom), windowPos1.y+math.floor(105/zoom), odliczaniepasek,  math.floor(10/zoom),tocolor(100, 100, 255, 230), false)
        end

        dxDrawText(""..text.."", xTEXT, yTEXT-math.floor(650/zoom), xTEXT+wTEXT, yTEXT+hTEXT, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), "center", "center", true )

        local postep =  (getTickCount()- start)/(koniec- start)
        przesuniecie = interpolateBetween(-15*70,0,0,-random*70,0,0,postep ,'OutQuad')

        dxDrawText('PORTFEL: '..przecinek(getPlayerBankMoney(localPlayer))..' PLN', xTEXT, yTEXT-math.floor(310/zoom), xTEXT+wTEXT, yTEXT+hTEXT, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light15'), 'center', 'center', false, false, false, false, false)
        
        exports["nrpg_buttons"]:dxCreateButton("CZERWONY\nX2", windowPos1.x+math.floor(50/zoom), windowPos1.y+math.floor(350/zoom), math.floor(330/zoom), math.floor(60/zoom), 1, {255, 0, 0})
        exports["nrpg_buttons"]:dxCreateButton("ZIELONY\nx14", windowPos1.x+math.floor(435/zoom), windowPos1.y+math.floor(350/zoom), math.floor(330/zoom), math.floor(60/zoom), 2, {0, 255, 0})
        exports["nrpg_buttons"]:dxCreateButton("CZARNY\nX2", windowPos1.x+windowPos1.w-math.floor(50/zoom)-math.floor(330/zoom), windowPos1.y+math.floor(350/zoom), math.floor(330/zoom), math.floor(60/zoom), 3, {25, 25, 25})

dxSetRenderTarget(ruletkabety ,true)

        betyx = 5
        suma = 0
        betyy = 38

        for i,v in pairs(betyr) do
            suma=suma+betyr[i][2]
            dxDrawText(betyr[i][1]:gsub("#%x%x%x%x%x%x", ""), betyx/zoom-5/zoom, betyy/zoom, betyx/zoom+320/zoom, betyy/zoom+30/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "left", "center", false, false, false, false, false)
            if winColor[v[1]] == "red" then
                dxDrawText('+'..przecinek(betyr[i][2]*2)..'', betyx/zoom, betyy/zoom, betyx/zoom+320/zoom, betyy/zoom+30/zoom, tocolor(9, 255, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            elseif winColor[v[1]] == "black" then
                dxDrawText('-'..przecinek(betyr[i][2])..'', betyx/zoom, betyy/zoom, betyx/zoom+320/zoom, betyy/zoom+30/zoom, tocolor(255, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            elseif winColor[v[1]] == "green" then
                dxDrawText('-'..przecinek(betyr[i][2])..'', betyx/zoom, betyy/zoom, betyx/zoom+320/zoom, betyy/zoom+30/zoom, tocolor(255, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            else
                dxDrawText(przecinek(betyr[i][2]), betyx/zoom, betyy/zoom, betyx/zoom+320/zoom, betyy/zoom+30/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            end
            betyy = betyy+32
        end

        dxDrawRectangle(betyx/zoom-5/zoom, 33/zoom, 330/zoom, math.floor(2/zoom), tocolor (100, 100, 255, 255), false)
        dxDrawText("PULA: "..przecinek(suma).."", betyx/zoom, 1/zoom, betyx/zoom+320/zoom, 35/zoom, tocolor(255, 255, 255,255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), "right", "center", false, false, false, false, false)

        betyx = 260+260+15
        suma = 0
        betyy = 38
        for i,v in pairs(betyb) do
            suma=suma+betyb[i][2]
            dxDrawText(betyb[i][1]:gsub("#%x%x%x%x%x%x", ""), betyx/zoom+235/zoom, betyy/zoom, betyx/zoom+450/zoom, betyy/zoom+30/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "left", "center", false, false, false, false, false)
            if winColor[v[1]] == "black" then
                dxDrawText('+'..przecinek(betyb[i][2]*2)..'', betyx/zoom+115/zoom, betyy/zoom, betyx/zoom+560/zoom, betyy/zoom+30/zoom, tocolor(9, 255, 0,255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            elseif winColor[v[1]] == "red" then
                dxDrawText('-'..przecinek(betyb[i][2])..'', betyx/zoom+115/zoom, betyy/zoom, betyx/zoom+560/zoom, betyy/zoom+30/zoom, tocolor(255, 0, 0,255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            elseif winColor[v[1]] == "green" then
                dxDrawText('-'..przecinek(betyb[i][2])..'', betyx/zoom+115/zoom, betyy/zoom, betyx/zoom+560/zoom, betyy/zoom+30/zoom, tocolor(255, 0, 0,255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            else
                dxDrawText(przecinek(betyb[i][2]), betyx/zoom+115/zoom, betyy/zoom, betyx/zoom+560/zoom, betyy/zoom+30/zoom, tocolor(255, 255, 255,255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            end
            betyy = betyy+32
        end

        dxDrawRectangle(betyx/zoom+235/zoom, 33/zoom, 330/zoom, math.floor(2/zoom), tocolor (100, 100, 255, 255), false)
        dxDrawText("PULA: "..przecinek(suma).."", betyx/zoom, 1/zoom, betyx/zoom+560/zoom, 35/zoom, tocolor(255, 255, 255,255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), "right", "center", false, false, false, false, false)

        betyx = 260+10
        suma = 0
        betyy = 38
        for i,v in pairs(betyg) do
            suma=suma+betyg[i][2]
            dxDrawText(betyg[i][1]:gsub("#%x%x%x%x%x%x", ""), betyx/zoom+115/zoom, betyy/zoom, betyx/zoom+370/zoom, betyy/zoom+30/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "left", "center", false, false, false, false, false)
            if winColor[v[1]] == "green" then
                dxDrawText('+'..przecinek(betyg[i][2]*14)..'', betyx/zoom, betyy/zoom, betyx/zoom+440/zoom, betyy/zoom+30/zoom, tocolor(9, 255, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            elseif winColor[v[1]] == "black" then
                dxDrawText('-'..przecinek(betyg[i][2])..'', betyx/zoom, betyy/zoom, betyx/zoom+440/zoom, betyy/zoom+30/zoom, tocolor(255, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            elseif winColor[v[1]] == "red" then
                dxDrawText('-'..przecinek(betyg[i][2])..'', betyx/zoom, betyy/zoom, betyx/zoom+440/zoom, betyy/zoom+30/zoom, tocolor(255, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            else
                dxDrawText(przecinek(betyg[i][2]), betyx/zoom, betyy/zoom, betyx/zoom+440/zoom, betyy/zoom+30/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money15'), "right", "center", false, false, false, false, false)
            end
            betyy = betyy+32
        end

        dxDrawRectangle(betyx/zoom+115/zoom, 33/zoom, 330/zoom, math.floor(2/zoom), tocolor (100, 100, 255, 255), false)
        dxDrawText("PULA: "..przecinek(suma).."", betyx/zoom, 1/zoom, betyx/zoom+440/zoom, 35/zoom, tocolor(255, 255, 255,255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), "right", "center", false, false, false, false, false)

dxSetRenderTarget()

dxSetRenderTarget(ruletkapola,true)

        for i,v in pairs(tabela) do
            dxDrawRectangle(x+przesuniecie/zoom, 0, math.floor(70/zoom), math.floor(70/zoom), tocolor (v[2], v[3], v[4], 255))
            x=x+70/zoom
       end

dxSetRenderTarget()

        dxDrawImage(windowPos.x-math.floor(100/zoom), windowPos.y+math.floor(40/zoom), windowPos.w+200/zoom, windowPos.h-math.floor(530/zoom), ruletkapola)
        dxDrawImage(windowPos.x-math.floor(50/zoom), windowPos.y+math.floor(310/zoom), windowPos.w+100/zoom, windowPos.h-math.floor(210/zoom), ruletkabety)

        dxDrawRectangle(windowPos1.x, windowPos1.y+math.floor(140/zoom), math.floor(1200/zoom), math.floor(2/zoom), tocolor(100, 100, 255, 255), false)
        dxDrawRectangle(windowPos1.x, windowPos1.y+math.floor(210/zoom), math.floor(1200/zoom), math.floor(2/zoom), tocolor(100, 100, 255, 255), false)
        dxDrawRectangle(windowPos1.x+math.floor(600/zoom), windowPos1.y+math.floor(140/zoom), math.floor(2/zoom), math.floor(70/zoom), tocolor(100, 100, 255, 255), false)

        dxDrawRectangle(windowPos1.x+math.floor(405/zoom), windowPos1.y+math.floor(450/zoom), math.floor(2/zoom), math.floor(320/zoom), tocolor(100, 100, 255, 255), false)
        dxDrawRectangle(windowPos1.x+math.floor(790/zoom), windowPos1.y+math.floor(450/zoom), math.floor(2/zoom), math.floor(320/zoom), tocolor(100, 100, 255, 255), false)
        --dxDrawRectangle(windowPos.x-math.floor(50/zoom), windowPos.y+math.floor(310/zoom), windowPos.w+100/zoom, windowPos.h-math.floor(210/zoom), tocolor (0, 0, 0, 220) )

        --dxDrawText(windowPos.h-math.floor(210/zoom), xres*565, yres*(-150), xres*565+790, yres*350+40, tocolor(255, 255, 255,255), yres*0.7, font, "center", "center", true )
    end
end

addEventHandler('onClientClick', root, function(btn, state)
    if btn == 'left' and state == 'down' then
        if isMouseIn(windowPos1.x+math.floor(50/zoom), windowPos1.y+math.floor(350/zoom), math.floor(330/zoom), math.floor(60/zoom)) and windows.main == true then
            local kwota = exports['nrpg_interface']:getCustomEditboxText('kwota')
            if mozliwybet then
                if blokadaColor == true then return end
                if tonumber(kwota) and tonumber(kwota) > 0 and not string.find(kwota, "%D") then
                    --if tonumber(kwota) > tonumber(1000000000) then exports.nrpg_interface:showPlayerNotification('Nie możesz obstawić więcej!', 'error') return end
                    triggerServerEvent("betowanietos",localPlayer,'red',kwota)
                    triggerServerEvent("bankTriggerMoney",localPlayer,localPlayer)
                    blokadaColor = true
                end
            end

        elseif isMouseIn(windowPos1.x+math.floor(435/zoom), windowPos1.y+math.floor(350/zoom), math.floor(330/zoom), math.floor(60/zoom)) and windows.main == true then
            local kwota = exports['nrpg_interface']:getCustomEditboxText('kwota')
            if mozliwybet then
                if blokadaColor == true then return end
                if tonumber(kwota) and tonumber(kwota) > 0 and not string.find(kwota, "%D") then
                    --if tonumber(kwota) > tonumber(1000000000) then exports.nrpg_interface:showPlayerNotification('Nie możesz obstawić więcej!', 'error') return end
                    triggerServerEvent("betowanietos",localPlayer,'green',kwota)
                    triggerServerEvent("bankTriggerMoney",localPlayer,localPlayer)
                    blokadaColor = true
                end
            end

        elseif isMouseIn(windowPos1.x+windowPos1.w-math.floor(50/zoom)-math.floor(330/zoom), windowPos1.y+math.floor(350/zoom), math.floor(330/zoom), math.floor(60/zoom)) and windows.main == true then
            local kwota = exports['nrpg_interface']:getCustomEditboxText('kwota')
            if mozliwybet then
                if blokadaColor == true then return end
                if tonumber(kwota) and tonumber(kwota) > 0 and not string.find(kwota, "%D") then
                    --if tonumber(kwota) > tonumber(1000000000) then exports.nrpg_interface:showPlayerNotification('Nie możesz obstawić więcej!', 'error') return end
                    triggerServerEvent("betowanietos",localPlayer,'black',kwota)
                    triggerServerEvent("bankTriggerMoney",localPlayer,localPlayer)
                    blokadaColor = true
                end
            end

        elseif isMouseIn(windowPos1.x+windowPos1.w-math.floor(35/zoom), windowPos1.y+math.floor(8/zoom), math.floor(27/zoom), math.floor(27/zoom)) and windows.main == true then
            showCursor(false)
            windows.main = false
            removeEventHandler("onClientRender", root, window)
            exports['nrpg_interface']:destroyCustomEditbox('kwota')
        end
    end
end)

function rollowanie (liczba, wygrywajacyKolor)
random = liczba
  start = getTickCount()
 koniec = getTickCount()+czas
mozliwybet = false


setTimer(function()
    kolejnelosowaniestart= getTickCount()
    kolejnelosowanie = getTickCount()+10000
    mozliwybet = true
    blokadaColor = false
    betyr={}
    betyb={}
    betyg={}
end, czas, 1)


end
addEvent( "losowanieliczb", true )
addEventHandler( "losowanieliczb", getRootElement(), rollowanie )

local function showGUI(el, md)
    if not md or getElementType(el) ~= "player" or el ~= localPlayer then return end
    showCursor(true, true)
    windows.main = true
    addEventHandler("onClientRender", root, window)
    triggerServerEvent("bankTriggerMoney",localPlayer,localPlayer)
    exports['nrpg_interface']:createCustomEditbox('kwota', 'Wpisz kwotę', windowPos.x+math.floor(220/zoom), windowPos.y+math.floor(180/zoom), math.floor(550/zoom), math.floor(50/zoom), false, "")
end

local function setup()
    for k,v in ipairs(markery) do
        local col = createMarker(v[1], v[2], v[3]-.95, "cylinder", 0.5, 255, 255, 0, 55)
        setElementInterior(col, 12)
        setElementDimension(col, 1)
        addEventHandler("onClientMarkerHit", col, showGUI)
        triggerServerEvent("bankTriggerMoney",localPlayer,localPlayer)
    end
end
setup()

function przecinek(xd)
    local left,num,right = string.match(xd,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function isMouseIn(x, y, width, height)
    if (not isCursorShowing()) then
        return false
    end
    local sx, sy = guiGetScreenSize ()
    local cx, cy = getCursorPosition ()
    local cx, cy = (cx * sx), (cy * sy)
    if (cx >= x and cx <= x + width ) and (cy >= y and cy <= y + height) then
        return true
    else
        return false
    end
end