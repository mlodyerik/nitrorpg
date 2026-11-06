local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local w, h = (sx/1280),(sy/720)

local sw,sh = guiGetScreenSize()
local zoom = 1
if sw < 1280 then
    zoom = math.min(2, 1280 / sw)
end

local wyposapd = nil

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

main = {

    lib = exports.nrpg_lib,
    
}

local interface = {

    backgroundRectangle = main.lib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 25, 255)),
    buttonRectangle = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 35, 255)),
    buttonWeapons = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(70, 168, 50)),
    backButton = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 0, 0, 155)),

}

function gui()
	dxDrawImage(470*w, 206*h, 375*w, 238*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawText("WYPOSAŻENIE - SAPD", 550*w, 206*h, 765*w, 229*h, tocolor(100, 100, 200, 255), 0.95, exports.nrpg_interface:getGUIFont("money12"), "center", "bottom", false, false, false, false, false)
	exports['nrpg_buttons']:dxCreateButton("PARALIZATOR", 480*w, 245*h, 114*w, 37*h, 1)
	exports['nrpg_buttons']:dxCreateButton("PAŁKA (TONFA)", 600*w, 245*h, 114*w, 37*h, 2)
	exports['nrpg_buttons']:dxCreateButton("SUSZARKA", 720*w, 245*h, 114*w, 37*h, 3)
	exports['nrpg_buttons']:dxCreateButton("SNAJPERKA", 480*w, 290*h, 114*w, 37*h, 4)
	exports['nrpg_buttons']:dxCreateButton("GAZ ŁZAWIĄCY", 600*w, 290*h, 114*w, 37*h, 5)
	exports['nrpg_buttons']:dxCreateButton("M4", 720*w, 290*h, 114*w, 37*h, 6)
	exports['nrpg_buttons']:dxCreateButton("MP5", 480*w, 335*h, 114*w, 37*h, 7)
	exports['nrpg_buttons']:dxCreateButton("STRZELBA", 600*w, 335*h, 114*w, 37*h, 8)
	exports['nrpg_buttons']:dxCreateButton("KAMIZELKA KULOODPORNA", 720*w, 335*h, 114*w, 37*h, 9)
	exports['nrpg_buttons']:dxCreateButton("ANULUJ", 600*w, 395*h, 114*w, 37*h, 10)
end

addEventHandler("onClientMarkerHit", resourceRoot, function(el)
	if el == localPlayer then
		if getElementData(localPlayer, "player:faction") == "SAPD" then
			if not wyposapd then
				wyposapd = true
				addEventHandler("onClientRender", root, gui)
				showCursor(true)
			end
		else
			exports.nrpg_interface:showPlayerNotification("Nie posiadasz uprawnień do wyciągania wyposażenia!", "error")
		end
	end
end)

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" and wyposapd then
		if isMouseIn(600*w, 395*h, 114*w, 37*h) then -- zamykanie gui
			wyposapd = nil
			removeEventHandler("onClientRender", root, gui)
			showCursor(false)
		elseif isMouseIn(480*w, 245*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "tazer", 23) -- paralizator
		elseif isMouseIn(600*w, 245*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "pałka", 3) -- pałka 
		elseif isMouseIn(720*w, 245*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "deagle", 24) -- Deagle
		elseif isMouseIn(480*w, 290*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "snajperka", 34) -- snajperka
		elseif isMouseIn(600*w, 290*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "gaz", 17) -- Gaz łzawiący
		elseif isMouseIn(720*w, 290*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "m4", 34) -- M4
		elseif isMouseIn(480*w, 335*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "mp5", 29) -- mp5
		elseif isMouseIn(600*w, 335*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "strzelba", 29) -- mp5
		elseif isMouseIn(720*w, 335*h, 114*w, 37*h) then
			triggerServerEvent("sapd:wyposazenie", localPlayer, "kamizelka") -- kamizelka
		end
	end
end)