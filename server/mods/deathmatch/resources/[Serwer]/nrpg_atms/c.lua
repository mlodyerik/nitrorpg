main = {

    getLib = exports.nrpg_lib,
    transactionHistory = {},
    actualMoney = 0,
    toggleGUI = false,
    historyPage = false,
    actualPage = "Wypłata",
    atmPositions = {
        {1810.55, -1913.15, 13.3, 0, 0, -90},
        {1764.55, -2037.98, 13.25, 0, 0, 90},
        {1031.86, -1440.88, 13.35, 0, 0, -90},
    },

    atms = {},
    shapes = {},

}

interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(35, 35, 35, 255)),
    backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(255, 175, 0, 255)),
    historyRectangle = main.getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(55, 55, 55, 255)),
    moneyBackgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(45, 45, 45, 255)),
    historyBackgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(25, 25, 25, 155)),
    scrollRectangle = main.getLib:dgsCreateRoundRect({{3,false},{3,false},{3,false},{3,false}},tocolor(255, 175, 0, 255)),

}

k = 1
n = 4
m = 4

sx, sy = guiGetScreenSize()
w, h = (sx/1366), (sy/768)


local zoom = exports.nrpg_interface:getInterfaceZoom()
local atmPos = {x=0, y=0, w=math.floor(600/zoom), h=math.floor(205/zoom)}
atmPos.x = sx-atmPos.w-math.floor(680/zoom)
atmPos.y = sy/2-atmPos.h+math.floor(400/zoom)


main.renderUI = function()
    if main.toggleGUI == true then
        local x, y, w, h = atmPos.x, atmPos.y, math.floor(100/zoom), math.floor(50/zoom)

        dxDrawImage(atmPos.x, atmPos.y, atmPos.w, atmPos.h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(atmPos.x+math.floor(2/zoom), atmPos.y+math.floor(2/zoom), atmPos.w-math.floor(3/zoom), atmPos.h-math.floor(3/zoom), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText("Saldo na koncie bankowym: #ffaf00"..convertNumber(main.actualMoney).." PLN", x+math.floor(495/zoom), y+math.floor(175/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

        exports["nrpg_buttons"]:dxCreateButton("Wypłata", atmPos.x+math.floor(20/zoom), atmPos.y+math.floor(52/zoom), math.floor(125/zoom), math.floor(30/zoom), 1, {225, 145, 0})
        exports["nrpg_buttons"]:dxCreateButton("Wpłata", atmPos.x+math.floor(20/zoom), atmPos.y+math.floor(87/zoom), math.floor(125/zoom), math.floor(30/zoom), 2, {225, 145, 0})
        exports["nrpg_buttons"]:dxCreateButton("Historia", atmPos.x+math.floor(20/zoom), atmPos.y+math.floor(120/zoom), math.floor(125/zoom), math.floor(30/zoom), 3, {0, 144, 255})

        if main.actualPage == "Wypłata" then
            exports["nrpg_buttons"]:dxCreateButton("Wypłać", atmPos.x+math.floor(200/zoom), atmPos.y+math.floor(115/zoom), math.floor(100/zoom), math.floor(30/zoom), 4, {225, 145, 0})
            dxDrawText("Wpisz kwotę, którą chcesz wypłacić", x+math.floor(600/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "center", "top", false, false, false, true, false)
        else
            exports["nrpg_buttons"]:dxCreateButton("Wpłać", atmPos.x+math.floor(200/zoom), atmPos.y+math.floor(115/zoom), math.floor(100/zoom), math.floor(30/zoom), 4, {225, 145, 0})
            dxDrawText("Wpisz kwotę, którą chcesz wpłacić", x+math.floor(600/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "center", "top", false, false, false, true, false)
        end

        dxDrawText("Pamiętaj! Każda akcja zapisuje się\nw historii transakcji", x+math.floor(310/zoom), y+math.floor(117/zoom), x+w, y+h, tocolor(200, 55, 55, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)

        if main.historyPage == true then
            dxDrawImage(atmPos.x+math.floor(605/zoom), atmPos.y, atmPos.w+math.floor(7/zoom), atmPos.h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(atmPos.x+math.floor(2/zoom)+math.floor(605/zoom), atmPos.y+math.floor(2/zoom), atmPos.w-math.floor(3/zoom)+math.floor(7/zoom), atmPos.h-math.floor(3/zoom), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

            xx = 0
            for i, v in ipairs(main.transactionHistory) do
                if i >= k and i <= n then 
                    xx = xx + 1
                    local offsetY = math.floor(40/zoom)*(xx-1)

                    dxDrawImage(atmPos.x+math.floor(620/zoom), atmPos.y+math.floor(35/zoom)+offsetY, math.floor(570/zoom), math.floor(35/zoom), interface.historyRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                    if v.typ == "+" then
                        dxDrawText("Wpłata", x+math.floor(635/zoom), y+math.floor(45/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    else
                        dxDrawText("Wypłata", x+math.floor(635/zoom), y+math.floor(45/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    end
                    dxDrawText(convertNumber(tostring(v.ile):gsub("-", "")), x+math.floor(710/zoom), y+math.floor(45/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    dxDrawText(v.serial, x+math.floor(800/zoom), y+math.floor(45/zoom)+offsetY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
                    dxDrawText(v.data, x+math.floor(500/zoom), y+math.floor(45/zoom)+offsetY, x+w+math.floor(1080/zoom), y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "right", "top", false, false, false, true, false)
                end
            end
            drawScrollbar(main.transactionHistory, atmPos.x+math.floor(1195/zoom), atmPos.y+math.floor(35/zoom), math.floor(155/zoom), m, k)

            dxDrawText("Typ", x+math.floor(635/zoom), y+math.floor(15/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
            dxDrawText("Kwota", x+math.floor(710/zoom), y+math.floor(15/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
            dxDrawText("Numer seryjny", x+math.floor(800/zoom), y+math.floor(15/zoom), x+w, y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
            dxDrawText("Data", x+math.floor(500/zoom), y+math.floor(15/zoom), x+w+math.floor(1080/zoom), y+h, tocolor(255, 175, 0, 255), 1, exports.nrpg_interface:getGUIFont('money9'), "right", "top", false, false, false, true, false)
        end
    end
end

main.shapeEnter = function(el)
    if el == localPlayer then
        if not getPedOccupiedVehicle(localPlayer) then
            addEventHandler("onClientRender", root, main.renderUI)
            exports['nrpg_interface']:destroyCustomEditbox('atm:money')
            main.toggleGUI = true
            showCursor(true, false)

            k = 1
            n = 4
            m = 4

            exports['nrpg_interface']:createCustomEditbox('atm:money', 'Kwota', atmPos.x+math.floor(200/zoom), atmPos.y+math.floor(60/zoom), math.floor(300/zoom), math.floor(45/zoom), false, "", false, {65, 65, 65}, ":nrpg_atms/img/cash.png")

            triggerServerEvent("showBankHistory", localPlayer)
            triggerServerEvent("showBankMoney", localPlayer)
        end
    end
end


main.shapeLeave = function(el)
    if el == localPlayer then
        removeEventHandler("onClientRender", root, main.renderUI)
        main.actualPage = "Wypłata"
        exports['nrpg_interface']:destroyCustomEditbox('atm:money')
        main.toggleGUI = false
        main.fingerprintProgress = 0
        showCursor(false)
    end
end


for i,v in ipairs(main.atmPositions) do
    main.atms[i] = createObject(2942, v[1], v[2], v[3]-0.1)
    setElementRotation(main.atms[i], v[4], v[5], v[6])

    main.shapes[i] = createColSphere(v[1], v[2], v[3], 1.5)
    addEventHandler("onClientColShapeHit", main.shapes[i], main.shapeEnter)
    addEventHandler("onClientColShapeLeave", main.shapes[i], main.shapeLeave)

   createBlip(v[1], v[2], v[3], 52, 2, 55, 255, 55, 255, 0, 450)
end

function drawScrollbar(table, x, y, height, m_, k_)
    dxDrawImage(x, y, 5, height, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

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
		
		dxDrawImage(x, scrollbarPos, 5, scrollbarHeight*(m_-1), interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
    else
        dxDrawImage(x, y, 5, height, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" and main.toggleGUI == true then
        if isMouseIn(atmPos.x+math.floor(20/zoom), atmPos.y+math.floor(52/zoom), math.floor(125/zoom), math.floor(30/zoom)) then
            main.actualPage = "Wypłata"
        elseif isMouseIn(atmPos.x+math.floor(20/zoom), atmPos.y+math.floor(87/zoom), math.floor(125/zoom), math.floor(30/zoom)) then
            main.actualPage = "Wpłata"
        elseif isMouseIn(atmPos.x+math.floor(20/zoom), atmPos.y+math.floor(120/zoom), math.floor(125/zoom), math.floor(30/zoom)) then
            if main.historyPage == false then
                main.historyPage = true
            else
                main.historyPage = false
            end
        elseif isMouseIn(atmPos.x+math.floor(200/zoom), atmPos.y+math.floor(115/zoom), math.floor(100/zoom), math.floor(30/zoom)) and main.actualPage == "Wpłata" then
            local bankMoney = exports['nrpg_interface']:getCustomEditboxText('atm:money')
            if not bankMoney then return end
            if not tonumber(bankMoney) then return end
            local bankMoney = math.floor(bankMoney)
            if not bankMoney or bankMoney < 1 then return end
            if bankMoney > getPlayerMoney() then outputChatBox("✘#ffffff Nie posiadasz tyle pieniędzy", 255, 0, 0, true) return end

            triggerServerEvent("amtOperation", resourceRoot, bankMoney)
            triggerServerEvent("showBankHistory", localPlayer)
            triggerServerEvent("showBankMoney", localPlayer)
        elseif isMouseIn(atmPos.x+math.floor(200/zoom), atmPos.y+math.floor(115/zoom), math.floor(100/zoom), math.floor(30/zoom)) and main.actualPage == "Wypłata" then
            local bankMoney = exports['nrpg_interface']:getCustomEditboxText('atm:money')
            if not bankMoney then return end
            if not tonumber(bankMoney) then return end
            local bankMoney = math.floor(bankMoney)
            if not bankMoney or bankMoney < 1 then return end
            if getPlayerMoney() + bankMoney > 99999999 then return end

            triggerServerEvent("amtOperation", resourceRoot, -bankMoney)
            triggerServerEvent("showBankHistory", localPlayer)
            triggerServerEvent("showBankMoney", localPlayer)
        end
    end
end)

addEvent("clientBankMoney", true)
addEventHandler("clientBankMoney", root, function(table)
	main.actualMoney = table
end)

addEvent("clientBankHistory", true)
addEventHandler("clientBankHistory", root, function(table)
	main.transactionHistory = table
end)

bindKey("mouse_wheel_down", "both", function()
    if not isMouseIn(atmPos.x+math.floor(605/zoom), atmPos.y, atmPos.w+math.floor(7/zoom), atmPos.h) then return end
    if main.toggleGUI == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if not isMouseIn(atmPos.x+math.floor(605/zoom), atmPos.y, atmPos.w+math.floor(7/zoom), atmPos.h) then return end
    if main.toggleGUI == true then
        scrollDown()
    end
end)


function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #main.transactionHistory then return end
    k = k+1
    n = n+1
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

function isMouseIn ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end