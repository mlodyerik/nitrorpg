peds = {}

addEvent("license:do",true)
addEventHandler("license:do", resourceRoot, function(plr, selected)
	local veh=nil
	if selected == "A" then veh=createVehicle(586, -2021.41, -97.85, 34.94, 360.0, 360.0, 90.4)
	elseif selected == "B" then veh=createVehicle(436, -2021.41, -97.85, 34.94, 360.0, 360.0, 90.4)
	elseif selected == "C" then veh=createVehicle(413, -2021.41, -97.85, 34.94, 360.0, 360.0, 90.4)
	end
	if not veh then return end
	setElementData(veh,"vehicle:mileage", 16442)
	setElementData(veh,"vehicle:fuel", 100)
	setElementData(veh,"vehicle:bak", 100)
	setElementData(veh,"vehicle:lic", true)
	triggerClientEvent("kolizjaPojazd", plr, veh)
	setElementInterior(plr, 0)
	local pedzik = createPed(71, 0, 0, 0)
	peds[veh] = pedzik
	warpPedIntoVehicle(peds[veh],veh,1)
	warpPedIntoVehicle(plr,veh)
	triggerClientEvent(plr, "license:start", resourceRoot, selected, veh)
end)

addEvent("takePlayerMoney",true)
addEventHandler("takePlayerMoney", resourceRoot, function(money)
if getPlayerMoney(source) > money then
takePlayerMoney(source, money)
else
end
end)

addEventHandler("onPlayerQuit", root, function()
	local veh=getPedOccupiedVehicle(source)
	if not veh then return end
	if getVehicleController(veh) ~= source then return end
	if not getElementData(veh,"vehicle:lic") then return end
	destroyPeds(veh)
	destroyElement(veh)
end)

addEventHandler("onVehicleStartExit", resourceRoot, function()
	cancelEvent()
end)

addEvent("license:vehdel", true)
addEventHandler("license:vehdel", resourceRoot, function(veh)
	destroyPeds(veh)
	destroyElement(veh)
end)

function destroyPeds(veh)
if isElement(peds[veh]) then
	destroyElement(peds[veh])
end
end