local LADDER = {

	{1721.22, -1772.84, 14.14, 0.1, 360.0, 90.0},
	{1733.56, -1772.84, 14.14, 0.1, 360.0, 90.0},
	
}

local GBA = {

	{1721.48, -1782.29, 13.82, 1.3, 0.0, 90.0},
	{1734.02, -1782.37, 13.82, 0.2, 0.0, 90.0},
	{1736.45, -1768.49, 13.83, 1.3, 0.0, 90.0},

}

local GCBA = {

	{1734.07, -1777.58, 13.82, 0.2, 0.0, 90.0},
	{1721.54, -1777.53, 13.82, 1.3, 0.0, 90.0},

}

local PREMIER = {
	 
	{1737.16, -1758.52, 13.34, 0.0, 0.0, 90.0},
	{1731.23, -1758.47, 13.34, 0.0, 0.0, 90.0},
	{1725.24, -1758.43, 13.33, 0.0, 0.0, 90.0},
	{1719.37, -1758.39, 13.33, 0.0, 0.0, 90.0},
	{1737.16, -1753.69, 13.34, 0.0, 360.0, 90.0},
	{1731.45, -1753.54, 13.34, 0.0, 0.0, 90.0},

}

local HUNTLEY = {
    
	{1725.57, -1753.81, 13.52, 0, 0, 90.0},

}

local AMBULANCE = {

    {1727.86, -1768.04, 13.74, 359.9, 359.6, 90.0},
    {1720.29, -1768.30, 13.74, 0.0, 0, 90.0},

}

local JETMAX = {

	{721.77, -1502.90, -0.15, 3.1, 360.0, 178.2},

}

local BUS = {

	{1720.96, -1745.28, 13.66, 359.4, 359.6, 90.0},

}

local SULTAN = {

    {1726.13, -1763.26, 13.30, 359.9, 360.0, 90.0},
    {1720.16, -1763.32, 13.30, 359.9, 360.0, 90.0},

}

local SENTINEL = {

    {1737.18, -1763.25, 13.47, 0.0, 0.0, 90.0},
    {1731.45, -1763.22, 13.47, 0.0, 360.0, 90.0},

}

for i,v in pairs(GBA) do
	local vehicle = createVehicle(407, v[1], v[2], v[3])
	setVehicleVariant(vehicle, 1, 1)
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	setElementData(vehicle,"vehicle:rank", 2)
	setElementData(vehicle,"vehicle:duty", "SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SAFD_GBA"..i)
	
	setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.25, -0.65})
	setVehicleHandling(vehicle, "steeringLock", 27)
	setVehicleHandling(vehicle, "engineAcceleration", 24)
	setVehicleHandling(vehicle, "maxVelocity", 250)
	setVehicleHandling(vehicle, "dragCoeff", 2.5)
	setVehicleHandling(vehicle, "engineInertia", 15)
	setVehicleHandling(vehicle, "brakeDeceleration", 10)
	setVehicleHandling(vehicle, "tractionLoss", 1.1)
	setVehicleHandling(vehicle, "tractionMultiplier", 1)
	setVehicleHandling(vehicle, "tractionBias", 0.5)
	setVehicleHandling(vehicle, "turnMass", 26000)
	setVehicleHandling(vehicle, "mass", 6500)
end

for i,v in pairs(GCBA) do
	local vehicle = createVehicle(407, v[1], v[2], v[3])
	setVehicleVariant(vehicle, 4, 4)
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	setElementData(vehicle,"vehicle:rank", 5)
	setElementData(vehicle,"vehicle:duty", "SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SAFD_GCBA"..i)
	setVehicleVariant(vehicle, 0, 0)
	
	setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.25, -0.65})
	setVehicleHandling(vehicle, "steeringLock", 27)
	setVehicleHandling(vehicle, "engineAcceleration", 24)
	setVehicleHandling(vehicle, "maxVelocity", 250)
	setVehicleHandling(vehicle, "dragCoeff", 2.5)
	setVehicleHandling(vehicle, "engineInertia", 15)
	setVehicleHandling(vehicle, "brakeDeceleration", 10)
	setVehicleHandling(vehicle, "tractionLoss", 1.1)
	setVehicleHandling(vehicle, "tractionMultiplier", 1)
	setVehicleHandling(vehicle, "tractionBias", 0.5)
	setVehicleHandling(vehicle, "turnMass", 26000)
	setVehicleHandling(vehicle, "mass", 6500)

end

for i,v in pairs(LADDER) do
	local vehicle = createVehicle(544, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	removeVehicleSirens(vehicle)
	setVehicleEngineState(vehicle, false)
	setElementData(vehicle,"vehicle:rank", 6)
	setElementData(vehicle,"vehicle:duty", "SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SAFD_LD"..i)
	
	setVehicleHandling(vehicle, "driveType", "awd")
	setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.25, -0.65})
	setVehicleHandling(vehicle, "steeringLock", 27)
	setVehicleHandling(vehicle, "engineAcceleration", 24)
	setVehicleHandling(vehicle, "maxVelocity", 250)
	setVehicleHandling(vehicle, "dragCoeff", 2.5)
	setVehicleHandling(vehicle, "engineInertia", 15)
	setVehicleHandling(vehicle, "brakeDeceleration", 10)
	setVehicleHandling(vehicle, "tractionLoss", 1.1)
	setVehicleHandling(vehicle, "tractionMultiplier", 1)
	setVehicleHandling(vehicle, "tractionBias", 0.5)
	setVehicleHandling(vehicle, "turnMass", 26000)
	setVehicleHandling(vehicle, "mass", 6500)

end

for i,v in pairs(PREMIER) do
	local vehicle = createVehicle(426, v[1], v[2], v[3])
	setVehicleVariant(vehicle, 1, 1)
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	setElementData(vehicle,"vehicle:rank", 9)
	setElementData(vehicle,"vehicle:duty", "SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SAFD_FL"..i)
	setVehicleVariant(vehicle, 0, 0)

end

for i,v in pairs(HUNTLEY) do
	local vehicle = createVehicle(579, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 0)
	setElementData(vehicle,"vehicle:duty", "SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setVehiclePlateText(vehicle,"SAFD_OM"..i)
end

for i,v in pairs(AMBULANCE) do
	local vehicle = createVehicle(416, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 4)
	setElementData(vehicle,"vehicle:duty","SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle,"dbid", i)
	setVehiclePlateText(vehicle,"SAFD_AD"..i)
	setVehicleHandling(vehicle,"maxVelocity",500)
	setVehicleHandling(vehicle,"engineAcceleration",24)
	setVehicleHandling(vehicle,"steeringLock",37)
	setVehicleHandling(vehicle,"tractionMultiplier",0.85)
    setVehicleHandling(vehicle,"tractionLoss",0.95)
end

for i,v in pairs(JETMAX) do
	local vehicle = createVehicle(493, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 5)
	setElementData(vehicle,"vehicle:duty","SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle,"dbid", i)
end

for i,v in pairs(BUS) do
	local vehicle = createVehicle(431, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 10)
	setElementData(vehicle,"vehicle:duty","SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle,"dbid", i)
	setVehiclePlateText(vehicle,"SAFD_SZ"..i)
end

for i,v in pairs(SULTAN) do
	local vehicle = createVehicle(560, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 2)
	setElementData(vehicle,"vehicle:duty","SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle,"dbid", i)
	setVehiclePlateText(vehicle,"SAFD_SZ"..i)
	setVehicleVariant(vehicle, 1, 1)
end

for i,v in pairs(SENTINEL) do
	local vehicle = createVehicle(405, v[1], v[2], v[3])
	setElementRotation(vehicle, v[4], v[5], v[6])
	setVehicleEngineState(vehicle, false)
	removeVehicleSirens(vehicle)
	setElementData(vehicle,"vehicle:rank", 2)
	setElementData(vehicle,"vehicle:duty","SAFD")
	setVehicleColor(vehicle, 200, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
	addVehicleUpgrade(vehicle, 1025)
	setElementFrozen(vehicle, true)
	setElementData(vehicle,"vehicle:fuel", 100)
	setElementData(vehicle,"dbid", i)
	setVehiclePlateText(vehicle,"SAFD_SZ"..i)
	setVehicleVariant(vehicle, 1, 1)
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
