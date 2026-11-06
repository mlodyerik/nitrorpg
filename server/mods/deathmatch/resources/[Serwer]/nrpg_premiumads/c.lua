
local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local backgroundPos = {x=math.floor(screenW/2-600/zoom/2), y=0,  w=math.floor(600/zoom), h=math.floor(80/zoom)}
backgroundPos.y = screenH-backgroundPos.h

animations = {
	alpha255 = 0,
}

main = {

    getLib = exports.nrpg_lib,
    tab = nil,

}

interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(15, 15, 25, 255)),
    backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(25, 25, 45, 255)),

}

text = ""
id = ""
nick = ""
hex = ""
color = {100, 100, 200}

function getHexPlayer( player )
	local level = getElementData(player, 'player:level');
    if level == 5 then
        return '#AC0008'
    elseif level == 4 then
		return '#0066D0'
	elseif level == 3 then
		return '#FF0000'
	elseif level == 2 then
		return '#05FF00'
	elseif level == 1 then
		return '#00F0FF'
    elseif getElementData(player, 'player:premiumplus') then
		return '#ff9900'
    elseif getElementData(player, "player:premium") then
        return '#FFFC00'
	else
		return '#FFFC00'
	end
end

function getRankColor(plr)
	if getElementData(plr, "player:level") == 5 then
		return {172, 0, 8}
	elseif getElementData(plr, "player:level") == 4 then
		return {0, 100, 200}
	elseif getElementData(plr, "player:level") == 3 then
		return {255, 0, 0}
	elseif getElementData(plr, "player:level") == 2 then
		return {0, 200, 0}
	elseif getElementData(plr, "player:level") == 1 then
		return {0, 255, 255}
	elseif getElementData(plr, "player:premiumplus") then
		return {255, 153, 0}
    elseif getElementData(plr, "player:premium") then
		return {255, 225, 0}
	else
		return {255, 225, 0}
	end
end

function ogloszenie()
	if not getElementData(localPlayer, "player:sid") then return end
	local x, y, w, h = backgroundPos.x, math.floor(backgroundPos.y), backgroundPos.w, backgroundPos.h
	main.getLib:dgsRoundRectSetColor(interface.backgroundRectangle,tocolor(color[1], color[2], color[3], animations.alpha255))
	dxDrawImage(backgroundPos.x, backgroundPos.y-math.floor(60/zoom), backgroundPos.w, backgroundPos.h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, animations.alpha2552), false)
	dxDrawImage(backgroundPos.x+math.floor(3/zoom), backgroundPos.y-math.floor(57/zoom), backgroundPos.w-math.floor(5/zoom), backgroundPos.h-math.floor(8/zoom), interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, animations.alpha255), false)
	dxDrawText('#d1d1d1Ogłoszenie gracza:\n('..hex..''..id..'#d1d1d1) '..nick, x+math.floor(15/zoom), y-math.floor(48/zoom), x+w, y+h, tocolor(0, 0, 0, animations.alpha255), 1/zoom, exports.NRPG_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)	
	dxDrawText(text, x+math.floor(10/zoom), y-math.floor(90/zoom), x+w, y+h, tocolor(230, 230, 230, animations.alpha255), 1/zoom, exports.NRPG_interface:getGUIFont('light12'), "center", "center", false, false, false, false, false)
end


addEvent("show_ads", true)
addEventHandler("show_ads", resourceRoot, function(plr, text1)
	if isEventHandlerAdded("onClientRender", root, ogloszenie) then return end
	text = text1
	id = getElementData(plr,"id")
	nick = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
	hex = getHexPlayer(plr)
	color = getRankColor(plr)
	addEventHandler("onClientRender", root, ogloszenie)
	createAnimation(0, 255, 'InOutQuad', 500, function(value) animations.alpha255 = value end)
	createAnimation(0, 255, 'InOutQuad', 1200, function(value) animations.alpha2552 = value end)
	setTimer(function()
		show_ads()
	end, 10000, 1)
end)

function show_ads()
	createAnimation(255, 0, 'InOutQuad', 800, function(value) animations.alpha255 = value end)
	createAnimation(255, 0, 'InOutQuad', 200, function(value) animations.alpha2552 = value end)
	setTimer(function()
	removeEventHandler("onClientRender", root, ogloszenie)
		text=false
		id=false
		nick=false
		hex=false
		color = {100, 100, 200}
	end,800,1)
end

function isEventHandlerAdded(sEventName,pElementAttachedTo,func)
	if type(sEventName)=='string' and isElement(pElementAttachedTo) and type(func)=='function' then local aAttachedFunctions = getEventHandlers(sEventName,pElementAttachedTo)
	if type(aAttachedFunctions)=='table' and #aAttachedFunctions > 0 then for i,v in ipairs(aAttachedFunctions) do if v==func then return true end end end
	end return false
end