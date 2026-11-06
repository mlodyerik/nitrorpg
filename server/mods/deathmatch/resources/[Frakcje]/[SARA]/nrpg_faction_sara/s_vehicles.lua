local LAWETY = {

	{-2.15, -364.68, 6.01, 359.7, 360.0, 89.2},
	{-2.15, -357.54, 6.01, 359.7, 360.0, 89.1},
	{-2.15, -350.50, 6.01, 359.7, 360.0, 89.5},
	{-2.15, -343.46, 6.01, 359.7, 359.9, 89.2},
    {-23.17, -375.61, 6.01, 359.7, 360.0, 0.7},
    {-16.51, -375.61, 6.01, 359.7, 360.0, 1.1},
    {-9.86, -375.61, 6.01, 359.7, 360.0, 0.5},
	{-2.15, -336.38, 6.01, 359.7, 360.0, 90.6},
	{-2.15, -329.34, 6.01, 359.7, 360.0, 88.5},
    {-2.15, -322.2, 6.01, 359.7, 0.0, 89.9},
    {-2.15, -315.3, 6.01, 359.7, 0.0, 89.9},
	{-2.15, -308.24, 6.05, 359.9, 0.0, 89.3},
	{-2.15, -301.09, 6.05, 359.9, 0.1, 90.1},

}

local TECHNIK = {

	{-29.91, -377.63, 5.13, 359.7, 0.0, 0.9},
	{-33.47, -377.63, 5.13, 359.7, 360.0, 359.8},
	{-36.48, -377.63, 5.13, 359.2, 0.0, 359.3},
	{-39.80, -377.63, 5.12, 359.1, 0.0, 0.6},
	{-43.17, -377.63, 5.13, 359.2, 360.0, 359.7},
	{-46.56, -377.63, 5.13, 359.2, 0.0, 359.9},

}

local SULTAN = {

	{-53.20, -377.41, 5.13, 359.9, 360.0, 359.3},
	{-56.54, -377.41, 5.13, 359.9, 0.0, 0.7},

}

local INFERNUS = {

	{-63.25, -377.11, 5.16, 0.0, 360.0, 0},
	{-66.62, -377.29, 5.16, 0.0, 0.0, 0},

}

local BUS = {
	{-57.73, -341.85, 5.55, 359.6, 0.0, 287.7},
	{-41.27, -326.91, 5.53, 359.5, 0.0, 337.3},
}

local PREMIER = {
	{-31.18, -290.10, 5.13, 359.7, 0, 269.1},
	{-31.18, -286.80, 5.13, 359.7, 0, 269.1},
    {-31.18, -283.50, 5.13, 359.7, 0, 269.1},
    {-31.18, -280.20, 5.13, 359.7, 0, 269.1},
	{-31.22, -276.57, 5.13, 0.1, 0.0, 269.1},
	{-31.08, -293.54, 5.13, 0.0, 0, 269.1},
	{-31.20, -296.95, 5.13, 0.0, 0, 269.1},
}



local colspheres = { }
local najazd = { }
local najazd2 = { }

for i,v in pairs(LAWETY) do
	local vehicle = createVehicle(578, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 1)
	setElementData(vehicle,"vehicle:duty", "SARA")
	setElementData(vehicle,"vehicle:pojemnosc", "2.2")
	setVehicleColor(vehicle, 225, 100, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle, "zaladowane", false)
	setElementData(vehicle, "laweta", true)
	setElementData(vehicle, "laweta:xd", 5)
	setVehiclePlateText(vehicle,"SARA_MK"..i)
	removeVehicleSirens(vehicle)
	setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleVariant(vehicle, 0, 1)

	local x,y,z = getElementPosition(vehicle)
	colspheres[vehicle] = createColSphere(x,y,z, 4)
	attachElements(colspheres[vehicle], vehicle, 0, -8, -0.605)


	removeVehicleSirens(vehicle)
end


for i,v in pairs(TECHNIK) do
	local vehicle = createVehicle(552, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 3)
	setElementData(vehicle,"vehicle:duty", "SARA")
	setElementData(vehicle,"vehicle:pojemnosc", "2.2")
	setVehicleColor(vehicle, 225, 100, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SARA_TT"..i)

	local technik=getModelHandling(552)
	local Fast = technik["engineAcceleration"]
	local MaxFast = technik["maxVelocity"]
	local TurnMass = technik["turnMass"]
	local Traction = technik["tractionLoss"]
	local Brake = technik["brakeDeceleration"]
	local Wheels = technik["steeringLock"]
	local Supp = technik["suspensionForceLevel"]
	setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle,"steeringLock", Wheels+3)
	setVehicleHandling(vehicle, "brakeDeceleration", Brake+5)
	setVehicleHandling(vehicle, "maxVelocity", MaxFast+150)
	setVehicleHandling(vehicle, "engineAcceleration", Fast+20.5)
	setVehicleHandling(vehicle, "tractionLoss", Traction+0.6)
	setVehicleHandling(vehicle, "engineInertia", 30)
end

for i,v in pairs(SULTAN) do
	local vehicle = createVehicle(560, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 9)
	setElementData(vehicle,"vehicle:duty", "SARA")
	setElementData(vehicle,"vehicle:pojemnosc", "2.2")
	setVehicleColor(vehicle, 225, 100, 0, 0, 0, 255 ,255, 255, 255, 255, 255, 255)
	addVehicleUpgrade(vehicle, 1077)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SARA_ZA"..i)

	local technik=getModelHandling(560)
	local Fast = technik["engineAcceleration"]
	local MaxFast = technik["maxVelocity"]
	local TurnMass = technik["turnMass"]
	local Traction = technik["tractionLoss"]
	local Brake = technik["brakeDeceleration"]
	local Wheels = technik["steeringLock"]
	local Supp = technik["suspensionForceLevel"]
	setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle,"steeringLock", Wheels+5)
	setVehicleHandling(vehicle, "brakeDeceleration", Brake+4)
	setVehicleHandling(vehicle, "maxVelocity", MaxFast+150)
	setVehicleHandling(vehicle, "engineAcceleration", Fast+28.5)
	setVehicleHandling(vehicle, "tractionLoss", Traction+0.8)
	setVehicleHandling(vehicle, "turnMass", TurnMass-45)
	setVehicleHandling(vehicle, "suspensionForceLevel", Supp-0.15)
	setVehicleHandling(vehicle, "engineInertia", 30)
end

for i,v in pairs(INFERNUS) do
local vehicle = createVehicle(411, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
removeVehicleSirens(vehicle)
setElementData(vehicle,"vehicle:rank", 9)
setElementData(vehicle,"vehicle:duty", "SARA")
setElementData(vehicle,"vehicle:pojemnosc", "2.2")
setVehicleColor(vehicle, 225, 100, 0, 0, 0, 255 ,255, 255, 255, 255, 255, 255)
addVehicleUpgrade(vehicle, 1077)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setVehiclePlateText(vehicle,"SARA_ZA"..i)
setVehicleVariant(vehicle, 0, 1)

local technik=getModelHandling(411)
local Fast = technik["engineAcceleration"]
local MaxFast = technik["maxVelocity"]
local TurnMass = technik["turnMass"]
local Traction = technik["tractionLoss"]
local Brake = technik["brakeDeceleration"]
local Wheels = technik["steeringLock"]
local Supp = technik["suspensionForceLevel"]
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle,"steeringLock", Wheels+5)
setVehicleHandling(vehicle, "brakeDeceleration", Brake+15)
setVehicleHandling(vehicle, "maxVelocity", MaxFast+100)
setVehicleHandling(vehicle, "engineAcceleration", Fast+14.5)
setVehicleHandling(vehicle, "tractionLoss", Traction+0.85)
setVehicleHandling(vehicle, "turnMass", TurnMass-45)
setVehicleHandling(vehicle, "suspensionForceLevel", Supp-0.15)
setVehicleHandling(vehicle, "engineInertia", 20)
end

for i,v in pairs(BUS) do
	local vehicle = createVehicle(431, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 10)
	setElementData(vehicle,"vehicle:duty", "SARA")
	setElementData(vehicle,"vehicle:pojemnosc", "2.2")
	setVehicleColor(vehicle, 225, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SARA_BUS"..i)
end

for i,v in pairs(PREMIER) do
	local vehicle = createVehicle(546, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 2)
	setElementData(vehicle,"vehicle:duty","SARA")
	setVehicleColor(vehicle, 225, 100, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255)
	addVehicleUpgrade(vehicle, 1077)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle,"dbid", i)
	setVehiclePlateText(vehicle,"SARA_PP"..i)
end



setTimer(function()
 	for i,vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		setVehicleDamageProof(vehicle,true)
		local x,y,z = getElementPosition(vehicle)
		local r1,r2,r3 = getElementRotation(vehicle)
		setVehicleRespawnPosition(vehicle,x,y,z,r1,r2,r3)
		toggleVehicleRespawn(vehicle,true)
		setVehicleIdleRespawnDelay(vehicle,1000 * 60 * 60)
  	end
end,2000,1)


----------LAWETY-------------
addEvent("zaladujPojazd", true)
addEventHandler("zaladujPojazd", root, function(player)
    if isPedInVehicle(player) and getElementData(player, "player:faction") == "SARA" then
        local veh = getPedOccupiedVehicle(player)
        if getElementModel(veh) == 578 and not getElementData(veh, "zaladowane") and getElementData(veh, "laweta") then
            local pojazd = getElementsWithinColShape(colspheres[veh], "vehicle")
            if getElementModel(pojazd[1]) ~= 578 and pojazd then
                attachElements(pojazd[1], veh, 0, -1.2, 0.5)
                setElementData(veh, "zaladowane", pojazd[1])
                setElementFrozen(pojazd[1], true)
				setElementCollisionsEnabled(pojazd[1], false)
            end
			else
        end
    end
end)


addEvent("rozladujPojazd", true)
addEventHandler("rozladujPojazd", root, function(player)
    if isPedInVehicle(player) and getElementData(player, "player:faction") == "SARA" then
        local veh = getPedOccupiedVehicle(player)
        if getElementModel(veh) == 578 and getElementData(veh, "zaladowane") then
            local zaladunek = getElementData(veh, "zaladowane")
            if zaladunek and getElementType(zaladunek) == "vehicle" then
                local x,y,z = getElementPosition(zaladunek)
                attachElements(zaladunek, veh, 0, -9, 0)
                detachElements(zaladunek, veh)
                setElementFrozen(zaladunek, false)
                setElementData(veh, "zaladowane", false)
				setElementCollisionsEnabled(zaladunek, true)
            else
            end
        end
    end
end)
