screenW, screenH = guiGetScreenSize()
w, h = (screenW/1280), (screenH/720)
zoom = 1
if screenW < 1280 then
    zoom = math.min(2, 1280 / screenW)
end


main = {}

main.points = {

	{-2182.52, 44.35, 35.32},
	{-2181.90, 40.57, 35.32},
	{-2181.90, 36.96, 35.32},
	-- LS
	{1406.58, -1776.44, 13.55},
	{1406.58, -1780.11, 13.55},
	{1406.58, -1783.64, 13.55},
	{1406.58, -1787.63, 13.55},
	{1406.58, -1791.48, 13.55},
	{1406.58, -1795.38, 13.55},
	{1406.58, -1799.03, 13.55},
	{1406.58, -1802.97, 13.55},
	-- LV
	{1941.82, 2171.29, 10.82},
	{1941.87, 2174.36, 10.82},

	--SF
	{-2141.41, -131.93, 35.32},
	{-2141.77, -138.31, 35.32},
	{-2141.50, -144.36, 35.32},

}

main.electricModels = {

	[587] = true,
	[550] = true,

}

main.checkVehicle = function(veh)
if isElement(veh) then
	return true
else
	return false
end
end


main.showCharger = function()
if not main.veh then return end
	main.batteryState = getElementData(main.veh, "vehicle:fuel") or 0

    dxDrawRectangle(346*w, 194*h, 588*w, 333*h, tocolor(20, 20, 35, 255), false)
    dxDrawText("TESLA CHARGER", 346*w, 193*h, 934*w, 245*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money15"), "center", "bottom", false, false, false, false, false)
    dxDrawText("PUNKT DARMOWEGO ŁADOWANIA POJAZDÓW ELEKTRYCZNYCH", 346*w, 245*h, 934*w, 297*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, false, false, false)
    dxDrawRectangle(519*w, 321*h, 245*w, 66*h, tocolor(45, 45, 75, 255), false)
    dxDrawText("ŁADOWANIE", 520*w, 419*h, 764*w, 459*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money15"), "center", "bottom", false, false, false, false, false)
    

    dxDrawText("ABY ZACZĄĆ ŁADOWANIE TRZYMAJ SPACJĘ", 384*w, 459*h, 896*w, 499*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, false, false, false)


    dxDrawRectangle(524*w, 327*h, 234*w, 54*h, tocolor(15, 15, 25, 255), false)
    dxDrawRectangle(524*w, 327*h, 234*w/100*main.batteryState, 54*h, tocolor(11, 253, 0, 101), false)
    dxDrawRectangle(766*w, 335*h, 6*w, 36*h, tocolor(45, 45, 75, 255), false)
    dxDrawText(math.floor(main.batteryState).."%", 384*w, 210*h, 896*w, 499*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, false, false)


    if getKeyState("space") == true then
    	if main.checkVehicle(main.veh) then
    		main.tankuj()
    	end
    end
end

main.tankuj = function()
	if main.veh then
		main.batteryState = getElementData(main.veh, "vehicle:fuel") or 0
		if main.batteryState >= 100 then
			-- Stopujemy
		else
			if main.batteryState >= 100 then setElementData(main.veh, "vehicle:fuel", 100) return end
			setElementData(main.veh, "vehicle:fuel", main.batteryState+0.05)
		end
	end
end

main.markerHit = function(el)
if el ~= localPlayer then return end
main.veh = getPedOccupiedVehicle(el)
if not main.veh then return end
if el ~= getVehicleController(main.veh) then return end
	if main.electricModels[getElementModel(main.veh)] then
		addEventHandler( "onClientRender", root, main.showCharger)
	else
		outputChatBox("✘#ffffff Ten pojazd nie posiada baterii", 255, 0, 0, true)
	end
end

main.markerLeave = function(el)
if el ~= localPlayer then return end
removeEventHandler( "onClientRender", root, main.showCharger)
end

for i,v in ipairs(main.points) do
	main.marker = createMarker(v[1], v[2], v[3]-3, "cylinder", 2.5, 255, 255, 0, 55)
	addEventHandler( "onClientMarkerHit", main.marker, main.markerHit)
	addEventHandler( "onClientMarkerLeave", main.marker, main.markerLeave)
end