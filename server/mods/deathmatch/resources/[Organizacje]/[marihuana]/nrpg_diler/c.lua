main = {

    lib = exports.nrpg_lib,

}

main.items = {

    {1, "Maska", 1000000, "mask", "true", "buy"},
    {2, "Nasiona marihuany", 50000, "nasiona", "false", "buy"},
    {3, "Marihuana", math.random(350000, 650000), "smoke", "false", "sell"},
    

}

main.gui = {

    optionButton = main.lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(45, 45, 75, 255)),
    infoBar = main.lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(0, 200, 0, 255)),
    sellBar = main.lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(200, 0, 0, 255)),
    windowRectangle = main.lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(18, 18, 38, 255)),

}

info = 0

local k = 1
local n = 8
local m = 8

local sW,sH = guiGetScreenSize()
local w, h = (sW/1366), (sH/768)
local zoom = 1
if sW < 1366 then
    zoom = math.min(2, 1366 / sW)
end

alpha = 0

main.renderShop = function()
    dxDrawImage(497*w, 151*h, 372*w, 465*h, main.gui.windowRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("DILER MARIAN", 497*w, 155*h, 869*w, 184*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, false, false)
    dxDrawText("ABY ZAMKNĄĆ OKNO KLIKNIJ BACKSPACE", 497*w, 180*h, 869*w, 184*h, tocolor(0, 144, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "center", false, false, false, false, false)
    local x = 0   
    for i,v in ipairs(main.items) do
        if i >= k and i <= n then 
            x = x + 1
            local offsetY = (50*h)*(x-1)
            local offsetY2 = (offsetY*2)

            if isMouseIn(507*w, 208*h+offsetY, 352*w, 46*h) then
                alpha = 35
            else
                alpha = 0
            end

            dxDrawImage(507*w, 208*h+offsetY, 352*w, 46*h, main.gui.optionButton, 0, 0, 0, tocolor(255, 255, 255, 155-alpha), false)
            dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, main.gui.optionButton, 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)

            if v[4] == "smoke" or v[4] == "nasiona" then
                dxDrawImage(519*w, 219*h+offsetY, 25*w, 25*h, ":nrpg_ekwipunek/icons/marihuana_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "beer" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/beer_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "food" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/food_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "drink" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/drink_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "ice" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/ice_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "mask" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/mask_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "vodka" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/vodka_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "repair" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/repair_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            elseif v[4] == "fuel" then
                dxDrawImage(512*w, 212*h+offsetY, 38*w, 38*h, ":nrpg_ekwipunek/icons/fuel_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200-alpha), false)
            end

            if v[6] == "buy" then
                dxDrawText(v[2], 558*w, 208*h, 692*w, 230*h+offsetY, tocolor(255, 255, 255, 255-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
            else
                dxDrawText(v[2].." ("..info.."g)", 558*w, 208*h, 692*w, 230*h+offsetY, tocolor(255, 255, 255, 255-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
            end

            if v[6] == "buy" then
                dxDrawText(""..v[3].." PLN", 558*w, 230*h+offsetY, 692*w, 252*h, tocolor(200, 200, 0, 255-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            else
                dxDrawText(""..v[3].." PLN/g", 558*w, 230*h+offsetY, 692*w, 252*h, tocolor(200, 200, 0, 255-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            end

            if v[6] == "buy" then
                if isMouseIn(822*w, 218*h+offsetY, 27*w, 27*h) then
                    dxDrawImage(822*w, 218*h+offsetY, 27*w, 27*h, main.gui.infoBar, 0, 0, 0, tocolor(255, 255, 255, 135-alpha), false)
                    dxDrawText("$", 822*w, 217*h+offsetY2, 849*w, 245*h, tocolor(255, 255, 255, 175-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, false, false, false, false)
                else
                    dxDrawImage(822*w, 218*h+offsetY, 27*w, 27*h, main.gui.infoBar, 0, 0, 0, tocolor(255, 255, 255, 175-alpha), false)
                    dxDrawText("$", 822*w, 217*h+offsetY2, 849*w, 245*h, tocolor(255, 255, 255, 225-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, false, false, false, false)
                end
            else
                if isMouseIn(822*w, 218*h+offsetY, 27*w, 27*h) then
                    dxDrawImage(822*w, 218*h+offsetY, 27*w, 27*h, main.gui.sellBar, 0, 0, 0, tocolor(255, 255, 255, 135-alpha), false)
                    dxDrawText("$", 822*w, 217*h+offsetY2, 849*w, 245*h, tocolor(255, 255, 255, 175-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, false, false, false, false)
                else
                    dxDrawImage(822*w, 218*h+offsetY, 27*w, 27*h, main.gui.sellBar, 0, 0, 0, tocolor(255, 255, 255, 175-alpha), false)
                    dxDrawText("$", 822*w, 217*h+offsetY2, 849*w, 245*h, tocolor(255, 255, 255, 225-alpha), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, false, false, false, false)
                end
            end
        end
    end
end

local markers = {

    {2438.64, -1105.78, 43.08},

}

main.close = function()
    unbindKey("backspace", "down", main.close)
    removeEventHandler("onClientRender", root, main.renderShop)
    main.render = false
    showCursor(false)
end

main.enterMarker = function(el)
    if el == localPlayer then
        bindKey("backspace", "down", main.close)
        addEventHandler("onClientRender", root, main.renderShop)
        main.render = true
        showCursor(true)
        triggerServerEvent("onClientDilerInfo", localPlayer, localPlayer)
    end
end

main.leaveMarker = function(el)
    if el == localPlayer then
        unbindKey("backspace", "down", main.close)
        removeEventHandler("onClientRender", root, main.renderShop)
        main.render = false
        showCursor(false)
    end
end

for i,v in ipairs(markers) do
    marker = createMarker(v[1], v[2], v[3]-1, "corona", 2, 255, 255, 0, 0)
    ped = createPed(21, v[1], v[2], v[3])
    setElementFrozen(ped, true)


    addEventHandler("onClientMarkerHit", marker, main.enterMarker)
    addEventHandler("onClientMarkerLeave", marker, main.leaveMarker)
end

addEventHandler("onClientClick", root, function(btn, state)
    if btn == 'left' and state == 'down' and main.render == true then
        local x = 0   
        for i,v in ipairs(main.items) do
            if i >= k and i <= n then 
                x = x + 1
                local offsetY = (50*h)*(x-1)
                local offsetY2 = (offsetY*2)

                if isMouseIn(822*w, 218*h+offsetY, 27*w, 27*h) then
                    if v[6] == "buy" then
                        if v[3] > getPlayerMoney(localPlayer) then
                            exports.nrpg_interface:showPlayerNotification('Nie posiadasz tyle pieniędzy', 'error')
                        else
                            triggerServerEvent("onClientBuyDiler", localPlayer, localPlayer, v[1], v[2], v[3], v[4], v[5])
                        end
                    else
                        triggerServerEvent("onClientSellDiler", localPlayer, localPlayer, v[1], v[2], v[3], v[4], v[5])

                        setTimer( function()
                            triggerServerEvent("onClientDilerInfo", localPlayer, localPlayer)
                        end, 100, 1)
                    end
                end
            end
        end
    end
end)

bindKey("mouse_wheel_down", "both", function()
    if not isMouseIn(497*w, 151*h, 372*w, 465*h) then return end
    if main.render == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if not isMouseIn(497*w, 151*h, 372*w, 465*h) then return end
    if main.render == true then
        scrollDown()
    end
end)


function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #main.items then return end
    k = k+1
    n = n+1
end

addEvent("clientDilerInfo", true)
addEventHandler("clientDilerInfo", root, function(table)
    info = 0
    info = table
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