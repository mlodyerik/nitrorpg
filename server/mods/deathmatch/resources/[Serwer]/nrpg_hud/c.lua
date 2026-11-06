local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local hudPos = {x=math.floor(screenW/2+1010/zoom/2), y=0, w=math.floor(550/zoom), h=math.floor(110/zoom)}
hudPos.y = math.floor(85/zoom)

main = {

    getLib = exports.nrpg_lib,

}

local interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(35, 35, 35, 255)),
	backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
	backgroundRectangle3 = main.getLib:dgsCreateRoundRect({{2,false},{2,false},{2,false},{2,false}},tocolor(55, 55, 55, 255)),
	heart_icon = dxCreateTexture("img/heart_icon.png"),

	factionRectangles = {

		["SARA"] = main.getLib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(200, 135, 0, 255)),
		["SAPD"] = main.getLib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(0, 64, 200, 255)),
		["SAFD"] = main.getLib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(200, 0, 0, 255)),

	},

}

main.renderHUD = function()
	if getElementData(localPlayer, "player:sid") and not getElementData(localPlayer,"notshowhud") then
		local x, y, w, h = hudPos.x, math.floor(hudPos.y), hudPos.w, hudPos.h
		local money = getPlayerMoney(localPlayer)
		local level = exports["nrpg_levels"]:getLevel(localPlayer) or 0
		local exp = exports["nrpg_levels"]:getExp(localPlayer) or 0
		local health = getElementHealth(localPlayer) or 0
		local faction = getElementData(localPlayer, "player:faction") or false

		dxDrawImage(hudPos.x+math.floor(50/zoom), hudPos.y-math.floor(60/zoom), hudPos.w-math.floor(235/zoom), hudPos.h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(hudPos.x+math.floor(51/zoom), hudPos.y-math.floor(59/zoom), hudPos.w-math.floor(238/zoom), hudPos.h-math.floor(2), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		exports["nrpg_avatars"]:dxCreateAvatar(hudPos.x+math.floor(315/zoom), hudPos.y-math.floor(69/zoom), math.floor(125/zoom), math.floor(125/zoom), 255, tocolor(255, 175, 0, 255))

		dxDrawLinedRectangle(hudPos.x+math.floor(65/zoom), hudPos.y-math.floor(15/zoom), math.floor(240/zoom), math.floor(25/zoom), tocolor(100, 100, 100, 200), 1)
		dxDrawRectangle(hudPos.x+math.floor(65/zoom), hudPos.y-math.floor(15/zoom), math.floor(240/zoom), math.floor(25/zoom), tocolor(100, 100, 100, 55))
		dxDrawRectangle(hudPos.x+math.floor(65/zoom), hudPos.y-math.floor(15/zoom), math.floor(240/zoom)*exp/100, math.floor(25/zoom), tocolor(100, 100, 100, 155))
		dxDrawText(level, x+math.floor(73/zoom), y-math.floor(13/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "left", "top", false, false, false, true, false)	
		dxDrawText(tonumber(level)+1, x+math.floor(450/zoom), y-math.floor(13/zoom), math.floor(1760/zoom), y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money11'), "right", "top", false, false, false, true, false)	

		dxDrawLinedRectangle(hudPos.x+math.floor(65/zoom), hudPos.y-math.floor(47/zoom), math.floor(240/zoom), math.floor(25/zoom), tocolor(175, 55, 55, 200), 1)
		dxDrawRectangle(hudPos.x+math.floor(65/zoom), hudPos.y-math.floor(47/zoom), math.floor(240/zoom), math.floor(25/zoom), tocolor(100, 55, 55, 55))
		dxDrawRectangle(hudPos.x+math.floor(65/zoom), hudPos.y-math.floor(47/zoom), math.floor(240/zoom)*health/100, math.floor(25/zoom), tocolor(155, 55, 55, 55))
		dxDrawImage(hudPos.x+math.floor(70/zoom), hudPos.y-math.floor(44/zoom), math.floor(18/zoom), math.floor(18/zoom), interface.heart_icon, 0, 0, 0, tocolor(255, 255, 255, 225), false)
		dxDrawText("Zdrowie", x+math.floor(95/zoom), y-math.floor(42/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
		
		if faction then
			dxDrawImage(hudPos.x+math.floor(330/zoom), hudPos.y+math.floor(35/zoom), math.floor(100/zoom), math.floor(35/zoom), interface.factionRectangles[faction], 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawText(faction, x+math.floor(210/zoom), y+math.floor(45/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont('money11'), "center", "top", false, false, false, true, false)
		end

		dxDrawText("#5cb3ff"..exp.." #ffffffEXP", x+math.floor(65/zoom), y+math.floor(22/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
		dxDrawText("#ffffff"..main.przecinkiAdd(money).."#9bff9b PLN", x+math.floor(200/zoom), y+math.floor(22/zoom), math.floor(1770/zoom), y+h, tocolor(155, 255, 155, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "right", "top", false, false, false, true, false)	
	
		local posX,posY,posZ = getElementPosition(localPlayer)
	    local ulica = getZoneName(posX,posY,posZ, false)
    	local ulica2 = getZoneName(posX,posY,posZ, true)
		dxDrawText(ulica2, math.floor(436/zoom), screenH-math.floor(79/zoom), x+w, y+h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont('bold18'), "left", "top", false, false, false, true, false)
		dxDrawText(ulica, math.floor(436/zoom), screenH-math.floor(49/zoom), x+w, y+h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont('normal15'), "left", "top", false, false, false, true, false)

		dxDrawText(ulica2, math.floor(435/zoom), screenH-math.floor(80/zoom), x+w, y+h, tocolor(255, 175, 0, 225), 1, exports.nrpg_interface:getGUIFont('bold18'), "left", "top", false, false, false, true, false)
		dxDrawText(ulica, math.floor(435/zoom), screenH-math.floor(50/zoom), x+w, y+h, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont('normal15'), "left", "top", false, false, false, true, false)
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	showPlayerHudComponent("all", false)
	showPlayerHudComponent("crosshair", true)

	addEventHandler("onClientRender", root, function()
		main.renderHUD()
	end)	
end)

toggleHUD = false

bindKey("F7", "down", function()
	if toggleHUD == false then
		setElementData(localPlayer, "notshowhud", true)
		showChat(false)
		toggleHUD = true
	else
		setElementData(localPlayer, "notshowhud", false)
		showChat(true)
		toggleHUD = false
	end
end)

main.getPedWeapons = function(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=2,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end

main.przecinkiAdd = function(amount) 
	local formatted = amount 
		while true do   
			formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
			
			if (k==0) then 
				break 
	  		end 
		end 
	return formatted 
end

function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	_width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end