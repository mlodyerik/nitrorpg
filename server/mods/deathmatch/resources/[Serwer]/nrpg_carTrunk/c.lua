bindKey("e", "down", function()
	local veh = getNearestVehicle(localPlayer, 4)
	if getPedOccupiedVehicle(localPlayer) then return end
	if not veh then return end
	if getElementSpeed(veh, "km/h") > 2 then return end
	if getVehicleDoorOpenRatio(veh,1) == 0 then return end
	triggerServerEvent("tpTrunk", resourceRoot, localPlayer, veh)
end)

local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local getLib = exports.nrpg_lib
local backgroundPos = {x=math.floor(screenW/2-600/zoom/2), y=0,  w=math.floor(600/zoom), h=math.floor(80/zoom)}
backgroundPos.y = screenH-backgroundPos.h

interface = {

    
    backgroundRectangle = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 45, 255)),
    backgroundRectangle2 = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 255, 0, 255)),

}


addEventHandler("onClientRender", root, function()
    local veh = getNearestVehicle(localPlayer, 4)
    if veh then
        if getPedOccupiedVehicle(localPlayer) then return end
	    if getElementSpeed(veh, "km/h") > 2 then return end
	    if getVehicleDoorOpenRatio(veh, 1) == 0 then return end
        local x, y, w, h = backgroundPos.x, math.floor(backgroundPos.y), backgroundPos.w, backgroundPos.h
        dxDrawImage(backgroundPos.x+math.floor(124/zoom), backgroundPos.y-math.floor(46/zoom), math.floor(60/zoom), math.floor(60/zoom), interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(backgroundPos.x+math.floor(125/zoom), backgroundPos.y-math.floor(45/zoom), math.floor(58/zoom), math.floor(58/zoom), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Kliknij E aby wejść do bagażnika", x+math.floor(191/zoom), y-math.floor(17/zoom), x+w, y+h, tocolor(0, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light12'), "left", "top", false, false, false, true, false)	
        dxDrawText("Kliknij #ffd500E#ffffff aby wejść do bagażnika", x+math.floor(190/zoom), y-math.floor(16/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light12'), "left", "top", false, false, false, true, false)	
        dxDrawText("Bagażnik", x+math.floor(191/zoom), y-math.floor(41/zoom), x+w, y+h, tocolor(0, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)	
        dxDrawText("Bagażnik", x+math.floor(190/zoom), y-math.floor(40/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)	

        dxDrawText("E", x+math.floor(146/zoom), y-math.floor(35/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money20'), "left", "top", false, false, false, true, false)	
    end
end)

function getNearestVehicle(player ,distance)
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)
	for _,v in pairs(getElementsByType("vehicle")) do
		local vint, vdim = getElementInterior(v), getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end