
local whichPlayerAmI = nil;
local thisData = nil;
local object1 = nil;

timer = nil;


local screenW, screenH = guiGetScreenSize()


sw = function(value) 
    return screenW*value/1920
end 

sh = function(value)
    return screenH*value/1080
end 
font = exports.nrpg_interface:getGUIFont("money8")
font2 = exports.nrpg_interface:getGUIFont("light10")
editBox_cars = guiCreateEdit(sw(1418), sh(366), sw(124), sh(38), "", false)

editBox_money = guiCreateEdit(sw(1418), sh(476), sw(124), sh(38), "", false)

editBox_moneyBank = guiCreateEdit(sw(1418), sh(586), sw(124), sh(38), "", false)    

guiSetVisible(editBox_cars,false)
guiSetVisible(editBox_money,false)
guiSetVisible(editBox_moneyBank,false)

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

isReady = function(bool)
    if bool == true then 
        return "Gotowy"
    else 
        return "Niegotowy"
    end 
end 

names = {
    [false] = 'Brak przedmiotu',
    ['money'] = 'Gotówka - ',
    ['bankMoney'] = 'Przelew - ', 
    ['car'] = 'Pojazd - ',
}

images = {
    [false] = 'images/nothing.png',
    ['money'] = 'images/money.png',
    ['bankMoney'] = 'images/przelew.png',
    ['car'] = 'images/car.png'
}

getDataType=function(name,secondValue,thirdValue)
    if name == 'money' then 
        return secondValue..' PLN'
    elseif name == 'bankMoney' then 
        return secondValue..' PLN'
    elseif name == 'car' then 
        return exports['nrpg_vehicles']:changeName(thirdValue)..' (ID: '..secondValue..')'
    else 
        return ''
    end 
end 

main = {

    lib = exports.nrpg_lib,

}

interface = {

    backgroundRectangle = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(15, 15, 35, 255)),
    listBackgroundRectangle = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(5, 5, 15, 255)),
    buttonRectangle = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(40, 40, 70, 255)),
    redRectangle = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 0, 0, 175)),
    greenRectangle = main.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(0, 255, 0, 175)),

}

render = function()

    dxDrawImage((screenW - sw(870) ) / 2, (screenH - sh(620) ) / 2, sw(840), sh(625), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage((screenW - sw(850) ) / 2, (screenH - sh(600) ) / 2, sw(840), sh(600), "images/background.png", 0, 0, 0, tocolor(255, 255, 255, 25), false)
    dxDrawImage((screenW - sw(820) ) / 2, (screenH - sh(580) ) / 2, sw(20), sh(20), "images/off.png", 0, 0, 0, tocolor(255, 255, 0, 255), false)

    dxDrawImage(sw(583), sh(360), sw(41), sh(41), images[thisData.plr1Items[1][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr1Items[1][1],thisData.plr1Items[1][2],thisData.plr1Items[1][3])
    dxDrawText( names[thisData.plr1Items[1][1]]..''..data1 , sw(645), sh(346), sw(927), sh(415), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(583), sh(445), sw(41), sh(41), images[thisData.plr1Items[2][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr1Items[2][1],thisData.plr1Items[2][2],thisData.plr1Items[2][3])
    dxDrawText(names[thisData.plr1Items[2][1]]..''..data1, sw(645), sh(346 + (85*1) ), sw(927), sh(415 + (85*1)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(583), sh(530), sw(41), sh(41), images[thisData.plr1Items[3][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr1Items[3][1],thisData.plr1Items[3][2],thisData.plr1Items[3][3])
    dxDrawText(names[thisData.plr1Items[3][1]]..''..data1, sw(645), sh(346 + (85*2)), sw(927), sh(415 + (85*2)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(583), sh(615), sw(41), sh(41), images[thisData.plr1Items[4][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr1Items[4][1],thisData.plr1Items[4][2],thisData.plr1Items[4][3])
    dxDrawText(names[thisData.plr1Items[4][1]]..''..data1, sw(645), sh(346 + (85*3)), sw(927), sh(415 + (85*3)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(583), sh(700), sw(41), sh(41), images[thisData.plr1Items[5][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr1Items[5][1],thisData.plr1Items[5][2],thisData.plr1Items[5][3])
    dxDrawText(names[thisData.plr1Items[5][1]]..''..data1, sw(645), sh(346 + (85*4)), sw(927), sh(415 + (85*4)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)


    dxDrawText(getPlayerName(thisData.plr1), sw(573), sh(277), sw(927), sh(336), tocolor(255, 255, 0, 255), 1.00, font, "center", "center", false, false, false, true, false)

    dxDrawImage(sw(998), sh(360), sw(41), sh(41), images[thisData.plr2Items[1][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr2Items[1][1],thisData.plr2Items[1][2],thisData.plr2Items[1][3])
    dxDrawText(names[thisData.plr2Items[1][1]]..''..data1, sw(1060), sh(346), sw(1342), sh(415), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(998), sh(445), sw(41), sh(41), images[thisData.plr2Items[2][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr2Items[2][1],thisData.plr2Items[2][2],thisData.plr2Items[2][3])
    dxDrawText(names[thisData.plr2Items[2][1]]..''..data1, sw(1060), sh(346 + (85*1) ), sw(1342), sh(415 + (85*1)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(998), sh(530), sw(41), sh(41), images[thisData.plr2Items[3][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr2Items[3][1],thisData.plr2Items[3][2],thisData.plr2Items[3][3])
    dxDrawText(names[thisData.plr2Items[3][1]]..''..data1, sw(1060), sh(346 + (85*2)), sw(1342), sh(415 + (85*2)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(998), sh(615), sw(41), sh(41), images[thisData.plr2Items[4][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr2Items[4][1],thisData.plr2Items[4][2],thisData.plr2Items[4][3])
    dxDrawText(names[thisData.plr2Items[4][1]]..''..data1, sw(1060), sh(346 + (85*3)), sw(1342), sh(415 + (85*3)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)

    dxDrawImage(sw(998), sh(700), sw(41), sh(41), images[thisData.plr2Items[5][1]], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    local data1 = getDataType(thisData.plr2Items[5][1],thisData.plr2Items[5][2],thisData.plr2Items[5][3])
    dxDrawText(names[thisData.plr2Items[5][1]]..''..data1, sw(1060), sh(346 + (85*4)), sw(1342), sh(415 + (85*4)), tocolor(255, 255, 255, 255), 1.00, font2, "left", "center", false, false, false, false, false)


    dxDrawText(getPlayerName(thisData.plr2), sw(988), sh(277), sw(1342), sh(336), tocolor(255, 255, 0, 255), 1.00, font, "center", "center", false, false, false, true, false)



    dxDrawImage(sw(1375), (screenH - sh(620) ) / 2, sw(335), sh(625), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Dodawanie przedmiotów do wymiany", sw(1400), sh(249), sw(1687), sh(310), tocolor(255, 255, 0, 255), 1.00, font, "center", "center", false, false, false, false, false)
    
    dxDrawText("- Pojazd (ID)", sw(1418), sh(320), sw(1542), sh(362), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    drawButton(sw(1558), sh(367), sw(119), sh(37))
    dxDrawText("Dodaj", sw(1559), sh(367), sw(1677), sh(404), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)

    dxDrawText("- Gotówka", sw(1418), sh(424), sw(1559), sh(466), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    drawButton(sw(1558), sh(476), sw(119), sh(37))
    dxDrawText("Dodaj", sw(1559), sh(476), sw(1677), sh(513), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)

    dxDrawText("- Przelew", sw(1418), sh(534), sw(1597), sh(576), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    drawButton(sw(1558), sh(587), sw(119), sh(37))
    dxDrawText("Dodaj", sw(1559), sh(587), sw(1677), sh(624), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)

    drawButton(sw(1445), sh(700), sw(194), sh(70), 1)
    dxDrawText("Potwierdź gotowość", sw(1446), sh(700), sw(1639), sh(767), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)

    if thisData.plr1Accept == true then
        dxDrawImage(sw(678), sh(779), sw(134), sh(51), interface.greenRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(sw(678), sh(779), sw(134), sh(51), interface.redRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    dxDrawText(isReady(thisData.plr1Accept), sw(678), sh(780), sw(812), sh(830), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)

    if thisData.plr2Accept == true then
        dxDrawImage(sw(1102), sh(779), sw(134), sh(51), interface.greenRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(sw(1102), sh(779), sw(134), sh(51), interface.redRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    dxDrawText(isReady(thisData.plr2Accept), sw(1102), sh(780), sw(1236), sh(830), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false) 
end

click = function(b,s)
    if b=='left' and s=='down' then 
        if isMouseInPosition(sw(1445), sh(700), sw(194), sh(67)) then 
            triggerServerEvent('acceptTrade',localPlayer,object1,whichPlayerAmI)
        end 

        if isMouseInPosition(sw(1558), sh(367), sw(119), sh(37)) then 
            triggerServerEvent('trade_addCar',localPlayer,object1,whichPlayerAmI, tonumber(guiGetText(editBox_cars)) )
        end 

        if isMouseInPosition(sw(1558), sh(476), sw(119), sh(37)) then 
            triggerServerEvent('trade_addMoney',localPlayer,object1,whichPlayerAmI, tonumber(guiGetText(editBox_money)) )
        end 

        if isMouseInPosition(sw(1558), sh(587), sw(119), sh(37)) then 
            triggerServerEvent('trade_addBankmoney',localPlayer,object1,whichPlayerAmI, tonumber(guiGetText(editBox_moneyBank)) )
        end 

        if isMouseInPosition((screenW - sw(820) ) / 2, (screenH - sh(580) ) / 2, sw(20), sh(20)) then 
            triggerServerEvent('cancelTrade',localPlayer,object1,whichPlayerAmI)
        end 
    end 
end 


drawButton = function(x, y, w, h, type)
    if type == 1 then
        if isMouseInPosition(x, y, w, h) then
            dxDrawImage(x, y-3, w, h+4, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        else
            dxDrawImage(x, y-3, w, h+4, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    else
        if isMouseInPosition(x, y, w, h) then
            dxDrawImage(x, y-3, w, h+4, interface.greenRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        else
            dxDrawImage(x, y-3, w, h+4, interface.greenRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    end
end

addEvent('openTradeGui',true)
addEventHandler('openTradeGui',root,function(objectData,whichPlayer)
    whichPlayerAmI=whichPlayer
    object1 = objectData
    thisData = getElementData(objectData,'object_trade_data')
    timer = setTimer(function()
        thisData = getElementData(objectData,'object_trade_data')
    end,50,0)
    addEventHandler('onClientRender',root,render)
    addEventHandler('onClientClick',root,click)
    showCursor(true)
    guiSetVisible(editBox_cars,true)
    guiSetVisible(editBox_money,true)
    guiSetVisible(editBox_moneyBank,true)
end)

addEvent('closeTradeGui',true)
addEventHandler('closeTradeGui',root,function()
    killTimer(timer);
    removeEventHandler('onClientRender',root,render)
    removeEventHandler('onClientClick',root,click)
    showCursor(false)
    guiSetVisible(editBox_cars,false)
    guiSetVisible(editBox_money,false)
    guiSetVisible(editBox_moneyBank,false)
    whichPlayerAmI = nil;
    object1 = nil;
end)
