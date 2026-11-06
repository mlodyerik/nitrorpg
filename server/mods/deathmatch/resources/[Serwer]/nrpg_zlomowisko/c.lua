local marker = createMarker(2188.35, -1989.37, 13.55-5, "cylinder", 5, 255, 255, 0, 55)
createBlip(2188.35, -1989.37, 13.55, 47, 2, 0, 0, 0, 0, 0, 550)

sx,sy = guiGetScreenSize()
screenW, screenH = guiGetScreenSize()
w, h = (screenW/1280),(screenH/720)
px, py = (screenW/1280),(screenH/720)

money = nil
gui = false

getLib = exports.nrpg_lib

interface = {

    backg_1 = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(20, 20, 30, 255)),
    backg_3 = getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(25, 25, 40, 255)),
	backg_2 = getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(30, 30, 55, 255)),

}

function window()
	local vehicles = getPedOccupiedVehicle(localPlayer)
	if not vehicles then return end
	local handlingTable = getVehicleHandling(vehicles) 
	money1 = handlingTable["mass"]*500
	money = math.floor(money1/2)

	if gui == true then
		dxDrawImage(356*w, 247*h, 568*w, 227*h, interface.backg_1, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawText("ZŁOMOWISKO", 366*w, 257*h, 914*w, 286*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, false, false)
    	dxDrawText("KLIKNIJ 'ZŁOMUJ' ABY ZEZŁOMOWAĆ POJAZD", 366*w, 286*h, 914*w, 315*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, false, false, false)
    	dxDrawImage(366*w, 325*h, 267*w, 84*h, interface.backg_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(369*w, 328*h, 28*w, 25*h, ":nrpg_interface/img/vehicle_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawText(exports["nrpg_vehicles"]:changeName(getVehicleName(vehicles)).." - "..(getElementData(vehicles, "Pojemnosc:silnika") or "1.4").." dm3", 402*w, 328*h, 628*w, 353*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
		dxDrawImage(369*w, 360*h, 259*w, 44*h, interface.backg_3, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		
		
    	dxDrawText("ZŁOMOWANIE", 645*w, 325*h, 914*w, 353*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, false, false)
    	dxDrawText("TEN PROCES JEST NIEODWRACALNY", 645*w, 353*h, 914*w, 409*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, false, false, false)
		dxDrawText("ZA ZEZŁOMOWANIE POJAZDU OTRZYMASZ\n#29FF00"..convertNumber(money).." PLN", 396*w, 385*h, 610*w, 382*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money9"), "center", "center", false, false, false, true, false)

		exports["buttons"]:createCustomButton("Złomuj", 366*w, 424*h, 548*w, 40*h, 1, {0, 144, 255}, "light")
	end
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
		if isMouseIn(366*w, 424*h, 548*w, 40*h) and gui == true then
			triggerServerEvent('ev',resourceRoot, 'recycling', localPlayer, money)
			showCursor(false)
			removeEventHandler('onClientRender', root, window)
			gui = false
		end
	end
end)

addEventHandler('onClientMarkerHit', marker, function(plr,dim)
	if plr == localPlayer and dim then
			if getPedOccupiedVehicle(plr) then
			if not getElementData(getPedOccupiedVehicle(plr), "vehicle:ownedPlayer") == getElementData(plr, "player:sid") then return end
			addEventHandler('onClientRender', root, window)
			gui = true
			showCursor(true,false)
		end
	end
end)

addEventHandler('onClientMarkerLeave', marker, function(plr,dim)
	if plr == localPlayer and dim then
			removeEventHandler('onClientRender', root, window)
			gui = false
			showCursor(false)
	end
end)

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