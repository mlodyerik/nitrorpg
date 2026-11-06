local INFERNUS = {

	{1528.31, -1688.00, 5.62, 0, 0, 270},
	{1528.31, -1683.98, 5.62, 0, 0, 270},
}

local BULLET = {

	{1526.55, -1644.69, 5.52, 0, 0, 180},
	{1530.59, -1644.69, 5.52, 0, 0, 180},
}

local CHEETAH = {

	{1528.85, -1683.98, 5.62, 0, 0, 270},
	{1183.37, -1340.27, 7.51, 359.5, 0.0, 180.0},

}

local OZNAKOWANE = {

	{1099.85, -1338.39, 7.45, 359.5, 0.0, 180},
	{1102.97, -1338.39, 7.45, 359.5, 0.0, 180},
	{1106.04, -1338.39, 7.45, 359.5, 0.0, 180},
	{1109.31, -1338.39, 7.45, 359.5, 0.0, 180},
	{1112.57, -1338.39, 7.45, 359.5, 0.1, 180},

}

local AKADEMICKIE = {

	{1129.82, -1338.39, 7.45, 359.5, 0.0, 180},
	{1133.10, -1338.39, 7.45, 359.5, 0.0, 180},
	{1136.15, -1338.39, 7.45, 359.5, 0.0, 180},
	{1139.29, -1338.39, 7.45, 359.5, 0.0, 180},
	{1142.38, -1338.39, 7.45, 359.5, 0.1, 180},
}

local PREMIER = {

	{1108.46, -1382.47, 7.47, 0.0, 0.0, 360},
	{1112.24, -1382.47, 7.48, 0.0, 360.0, 360},
	{1115.65, -1382.47, 7.48, 0.0, 360.0, 360},
	
	}

local SULTAN = {

	{1129.69, -1383.08, 7.44, 359.9, 360.0, 360},
	{1133.10, -1383.08, 7.44, 359.9, 0.0, 360},
	{1136.85, -1383.08, 7.44, 359.9, 0.0, 360},

}

local FBI = {

	{1087.65, -1381.48, 7.73, 359.7, 0.0, 360},
	{1091.42, -1381.48, 7.73, 359.9, 0.0, 360},
	{1094.73, -1381.48, 7.73, 359.9, 0.0, 360},
	{1098.15, -1381.48, 7.73, 359.9, 0.0, 360},

}

local RANGER = {

	{1225.37, -1339.61, 7.76, 0.4, 360.0, 180},
	{1221.58, -1339.61, 7.76, 359.9, 0.0, 180},
	{1218.19, -1339.61, 7.76, 359.9, 0.0, 180},
	{1214.88, -1339.61, 7.76, 0.4, 360.0, 180},

}

local SWAT = {

	{1232.38, -1339.83, 7.49, 0.0, 0.0, 180},
	{1235.82, -1339.96, 7.49, 0.0, 360.0, 180},

}


local ENFORCER = {

	{1217.03, -1382.95, 7.98, 0.0, 0.0, 0},
	{1223.59, -1383.07, 7.98, 0.0, 0.0, 0},

}

local BUS = {

	{1180.75, -1385.44, 7.83, 359.5, 0.0, 0},

}

local LAWETA = {

	{1187.01, -1383.98, 8.36, 359.9, 0.0, 0},
	{1190.19, -1383.98, 8.36, 359.9, 360.0, 0},
	{1193.40, -1383.98, 8.36, 359.9, 360.0, 0},

}







local HELIKOPTER = {

	{1159.39, -1318.34, 31.68, 0.2, 359.8, 270.8},
	{1159.88, -1304.27, 31.68, 0.2, 359.7, 269.0},

}

local woda2 = {

--{-1476.41, 679.52, 0.09, 2.4, 360.0, 212.4},

}

local colspheres = { }
local najazd = { }
local najazd2 = { }


for i,v in pairs(LAWETA) do
local vehicle = createVehicle(578, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
removeVehicleSirens(vehicle)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")
setVehicleColor(vehicle, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setElementData(vehicle, "zaladowane", false)
setElementData(vehicle, "laweta", true)
setElementData(vehicle, "laweta:xd", 5)
setVehiclePlateText(vehicle,"TOM-0"..i)
removeVehicleSirens(vehicle)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleVariant(vehicle, 0, 2)

local x,y,z = getElementPosition(vehicle)
colspheres[vehicle] = createColSphere(x,y,z, 4)
attachElements(colspheres[vehicle], vehicle, 0, -8, -0.605)


removeVehicleSirens(vehicle)
end

for i,v in pairs(woda2) do
local vehicle = createVehicle(472, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
removeVehicleSirens(vehicle)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 255, 255, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
end

for i,v in pairs(HELIKOPTER) do
local vehicle = createVehicle(497, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
removeVehicleSirens(vehicle)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
end

for i,v in pairs(OZNAKOWANE) do
local vehicle = createVehicle(596, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")
--
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
addVehicleUpgrade(vehicle, 1025)
addVehicleUpgrade(vehicle, 1010)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setVehicleVariant(vehicle, 1, 5)
setVehiclePlateText(vehicle,"ADAM-0"..i)

removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.1, -0.5})
setVehicleHandling(vehicle, "steeringLock", 39)
setVehicleHandling(vehicle, "engineAcceleration", 40)
setVehicleHandling(vehicle, "maxVelocity", 390)
setVehicleHandling(vehicle,"dragCoeff", 0.95)
setVehicleHandling(vehicle, "engineInertia", 28)
setVehicleHandling(vehicle, "brakeDeceleration", 16)
setVehicleHandling(vehicle, "tractionLoss", 1.4)
setVehicleHandling(vehicle, "tractionMultiplier", 1.35)
setVehicleHandling(vehicle, "tractionBias", 0.43)
setVehicleHandling(vehicle, "turnMass", 5600)
setVehicleHandling(vehicle, "mass", 3000)
end

for i,v in pairs(SULTAN) do
local vehicle = createVehicle(560, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")

setVehicleColor(vehicle, 15, 15, 15, 255, 255, 255, 255, 255, 255, 255, 255, 255)
addVehicleUpgrade(vehicle, 1077)
addVehicleUpgrade(vehicle, 1010)
setElementFrozen(vehicle, true)
setVehicleVariant(vehicle, 0, 5)
setElementData(vehicle,"vehicle:fuel", 100)
setVehiclePlateText(vehicle,"FRANK-0"..i+3)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle,"engineAcceleration", 47.5)
setVehicleHandling(vehicle,"mass", 5500)
setVehicleHandling(vehicle,"turnMass", 6000)
setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.1, -0.5})
setVehicleHandling(vehicle,"steeringLock", 35)
setVehicleHandling(vehicle,"dragCoeff", 1.4)
setVehicleHandling(vehicle, "brakeDeceleration", 16)
setVehicleHandling(vehicle,"maxVelocity", 420)
setVehicleHandling(vehicle,"tractionMultiplier", 1.3)
setVehicleHandling(vehicle,"engineInertia", 16)
setVehicleHandling(vehicle,"tractionLoss", 1.45)
setVehicleHandling(vehicle,"tractionBias", 0.42)
setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "suspensionAntiDiveMultiplier", 0.3)
setVehicleHandling(vehicle, "suspensionForceLevel", 1.0)
end

for i,v in pairs(INFERNUS) do
local vehicle = createVehicle(411, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")

setVehicleColor(vehicle, 15, 15, 15, 0, 0, 0, 255, 255, 255, 255, 255, 255)
setElementFrozen(vehicle, true)
addVehicleUpgrade(vehicle, 1077)
setElementData(vehicle,"vehicle:fuel", 100)
setVehicleVariant(vehicle, 0, 1)
setVehiclePlateText(vehicle,"EDWARD-"..i)
addVehicleUpgrade(vehicle, 1010)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle,"engineAcceleration", 41)
setVehicleHandling(vehicle,"mass", 1400)
setVehicleHandling(vehicle,"turnMass", 2725.3)
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.1, -0.4})
setVehicleHandling(vehicle,"steeringLock", 36)
setVehicleHandling(vehicle, "brakeDeceleration", 17)
setVehicleHandling(vehicle,"dragCoeff", 1)
setVehicleHandling(vehicle,"maxVelocity", 430)
setVehicleHandling(vehicle,"tractionMultiplier", 1.35)
setVehicleHandling(vehicle,"engineInertia", 25)
setVehicleHandling(vehicle,"tractionLoss", 1.5)
setVehicleHandling(vehicle, "driveType", "awd")
end

for i,v in pairs(PREMIER) do
local vehicle = createVehicle(426, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")

setVehicleColor(vehicle, 15, 15, 15, 255, 255, 255, 255, 255, 255, 255, 255, 255)
addVehicleUpgrade(vehicle, 1077)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setVehiclePlateText(vehicle,"FRANK-0"..i)
setVehicleVariant(vehicle, 0, 0)
addVehicleUpgrade(vehicle, 1010)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.25, -0.47})
setVehicleHandling(vehicle, "steeringLock", 35)
setVehicleHandling(vehicle, "engineAcceleration", 40)
setVehicleHandling(vehicle, "maxVelocity", 395)
setVehicleHandling(vehicle, "dragCoeff", 1)
setVehicleHandling(vehicle, "engineInertia", 17)
setVehicleHandling(vehicle, "brakeDeceleration", 16)
setVehicleHandling(vehicle, "tractionLoss", 1.2)
setVehicleHandling(vehicle, "tractionMultiplier", 1.31)
setVehicleHandling(vehicle, "tractionBias", 0.49)
setVehicleHandling(vehicle, "brakeBias", 0.59)
setVehicleHandling(vehicle, "turnMass", 5000)
setVehicleHandling(vehicle, "mass", 3000)
setVehicleHandling(vehicle, "suspensionForceLevel", 1.0)
setVehicleHandling(vehicle, "suspensionLowerLimit", -0.15)
end

for i,v in pairs(FBI) do
local vehicle = createVehicle(490, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
setElementFrozen(vehicle, true)
addVehicleUpgrade(vehicle, 1025)
setElementData(vehicle,"vehicle:fuel", 100)
setElementData(vehicle,"dbid", i)
setVehiclePlateText(vehicle,"QUEEN-0"..i)

removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.1, -0.65})
setVehicleHandling(vehicle, "steeringLock", 35)
setVehicleHandling(vehicle, "engineAcceleration", 35)
setVehicleHandling(vehicle, "maxVelocity", 500)
setVehicleHandling(vehicle, "dragCoeff", 1.3)
setVehicleHandling(vehicle, "engineInertia", 16)
setVehicleHandling(vehicle, "brakeDeceleration", 12)
setVehicleHandling(vehicle, "tractionLoss", 1.3)
setVehicleHandling(vehicle, "tractionMultiplier", 1.2)
setVehicleHandling(vehicle, "tractionBias", 0.49)
setVehicleHandling(vehicle, "brakeBias", 0.59)
setVehicleHandling(vehicle, "turnMass", 19156.2)
setVehicleHandling(vehicle, "mass", 4500)
end

for i,v in pairs(RANGER) do
local vehicle = createVehicle(599, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setElementData(vehicle,"dbid", i)
setVehiclePlateText(vehicle,"ADAM-0"..i+10)
addVehicleUpgrade(vehicle, 1025)
addVehicleUpgrade(vehicle, 1010)
	
removeVehicleSirens(vehicle)
addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.2, -0.4})
setVehicleHandling(vehicle, "steeringLock", 35)
setVehicleHandling(vehicle, "engineAcceleration", 45)
setVehicleHandling(vehicle, "maxVelocity", 420)
setVehicleHandling(vehicle, "dragCoeff", 1.45)
setVehicleHandling(vehicle, "engineInertia", 16)
setVehicleHandling(vehicle, "brakeDeceleration", 14)
setVehicleHandling(vehicle, "tractionLoss", 1.45)
setVehicleHandling(vehicle, "tractionMultiplier", 1.15)
setVehicleHandling(vehicle, "tractionBias", 0.49)
setVehicleHandling(vehicle, "brakeBias", 0.6)
setVehicleHandling(vehicle, "turnMass", 7000)
setVehicleHandling(vehicle, "mass", 4000)
end



for i,v in pairs(SWAT) do
local vehicle = createVehicle(601, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
removeVehicleSirens(vehicle)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 55, 55, 55, 0, 0, 0, 0, 0, 0, 255, 255, 255)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setElementData(vehicle,"dbid", i)
setVehiclePlateText(vehicle,"TITAN-0"..i+2)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
end

for i,v in pairs(ENFORCER) do
local vehicle = createVehicle(427, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
removeVehicleSirens(vehicle)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 0, 0, 0, 255, 255, 255)
addVehicleUpgrade(vehicle, 1025)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setElementData(vehicle,"dbid", i)
setVehiclePlateText(vehicle,"TITAN-0"..i)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, 0.3, -0.3})
setVehicleHandling(vehicle, "steeringLock", 35)
setVehicleHandling(vehicle, "engineAcceleration", 25)
setVehicleHandling(vehicle, "maxVelocity", 300)
setVehicleHandling(vehicle, "engineInertia", 17)
setVehicleHandling(vehicle, "brakeDeceleration", 15)
setVehicleHandling(vehicle, "tractionLoss", 1.1)
setVehicleHandling(vehicle, "tractionMultiplier", 1.03)
setVehicleHandling(vehicle, "tractionBias", 0.45)
setVehicleHandling(vehicle, "brakeBias", 0.59)
setVehicleHandling(vehicle, "turnMass", 17333.301)
setVehicleHandling(vehicle, "mass", 5500)
end


for i,v in pairs(CHEETAH) do
local vehicle = createVehicle(415, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")

setVehicleColor(vehicle, 15, 15, 15, 0, 0, 0, 255, 255, 255, 255, 255, 255)
setElementFrozen(vehicle, true)
addVehicleUpgrade(vehicle, 1077)
setElementData(vehicle,"vehicle:fuel", 100)
setVehicleVariant(vehicle, 0, 0)
addVehicleUpgrade(vehicle, 1010)
setVehiclePlateText(vehicle, "EDWARD-"..i+4)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.1, -0.4})
setVehicleHandling(vehicle, "stee	ringLock", 38)
setVehicleHandling(vehicle, "engineAcceleration", 30)
setVehicleHandling(vehicle, "maxVelocity", 410)
setVehicleHandling(vehicle, "dragCoeff", 0.8)
setVehicleHandling(vehicle, "engineInertia", 20)
setVehicleHandling(vehicle, "brakeDeceleration", 18)
setVehicleHandling(vehicle, "tractionLoss", 1.15)
setVehicleHandling(vehicle, "tractionMultiplier", 1.08)
setVehicleHandling(vehicle, "tractionBias", 0.47)
setVehicleHandling(vehicle, "BrakeBias", 0.47)
setVehicleHandling(vehicle, "turnMass", 5000)
setVehicleHandling(vehicle, "mass", 3000)
end

for i,v in pairs(BULLET) do
local vehicle = createVehicle(541, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")
	
setVehicleColor(vehicle, 15, 15, 15, 15, 15, 15, 255, 255, 255, 255, 255, 255)
setElementFrozen(vehicle, true)
addVehicleUpgrade(vehicle, 1077)
setElementData(vehicle,"vehicle:fuel", 100)
setVehiclePlateText(vehicle,"EDWARD-"..i+2)
addVehicleUpgrade(vehicle, 1010)
	
addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.1, -0.46})
setVehicleHandling(vehicle, "steeringLock", 37)
setVehicleHandling(vehicle, "engineAcceleration", 36.5)
setVehicleHandling(vehicle, "maxVelocity", 420)
setVehicleHandling(vehicle, "dragCoeff", 1)
setVehicleHandling(vehicle, "engineInertia", 27)
setVehicleHandling(vehicle, "brakeDeceleration", 17)
setVehicleHandling(vehicle, "tractionLoss", 1.25)
setVehicleHandling(vehicle, "tractionMultiplier", 1.2)
setVehicleHandling(vehicle, "tractionBias", 0.47)
setVehicleHandling(vehicle, "BrakeBias", 0.47)
setVehicleHandling(vehicle, "turnMass", 5000)
setVehicleHandling(vehicle, "mass", 3000)
end

for i,v in pairs(AKADEMICKIE) do
local vehicle = createVehicle(596, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty", "SAPD")

setVehicleVariant(vehicle, 1, 5)
setVehicleColor(vehicle, 0, 61, 11, 255, 255, 255, 0, 0, 0, 0, 0, 0)
addVehicleUpgrade(vehicle, 1025)
addVehicleUpgrade(vehicle, 1010)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
removeVehicleSirens(vehicle)
setVehiclePlateText(vehicle,"ADAM-0"..i+5)

addVehicleSirens(vehicle, 1, 1 )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "centerOfMass", {0.0, -0.1, -0.5})
setVehicleHandling(vehicle, "steeringLock", 39)
setVehicleHandling(vehicle, "engineAcceleration", 39)
setVehicleHandling(vehicle, "maxVelocity", 375)
setVehicleHandling(vehicle,"dragCoeff", 0.95)
setVehicleHandling(vehicle, "engineInertia", 28)
setVehicleHandling(vehicle, "brakeDeceleration", 16)
setVehicleHandling(vehicle, "tractionLoss", 1.4)
setVehicleHandling(vehicle, "tractionMultiplier", 1.35)
setVehicleHandling(vehicle, "tractionBias", 0.43)
setVehicleHandling(vehicle, "turnMass", 5600)
setVehicleHandling(vehicle, "mass", 3000)
end

for i,v in pairs(BUS) do
local vehicle = createVehicle(437, v[1], v[2], v[3])
setElementRotation(vehicle, v[4], v[5], v[6])
setVehicleEngineState(vehicle, false)
setElementData(vehicle,"vehicle:rank", 1)
setElementData(vehicle,"vehicle:duty","SAPD")
setVehicleColor(vehicle, 3, 11, 252, 0, 0, 0)
setElementFrozen(vehicle, true)
setElementData(vehicle,"vehicle:fuel", 100)
setElementData(vehicle,"dbid", i)
setVehiclePlateText(vehicle,"SAPD_BR"..i)

addVehicleSirens(vehicle, 8, 2, true, false, true, true )

setVehicleHandling(vehicle, "driveType", "awd")
setVehicleHandling(vehicle, "steeringLock", 35)
setVehicleHandling(vehicle, "engineAcceleration", 20)
setVehicleHandling(vehicle, "maxVelocity", 550)
setVehicleHandling(vehicle, "engineInertia", 30)
setVehicleHandling(vehicle, "brakeDeceleration", 10)
setVehicleHandling(vehicle, "tractionLoss", 0.85)
setVehicleHandling(vehicle, "tractionMultiplier", 0.9)
end

setTimer(function()
 for i,vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
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
    if isPedInVehicle(player) and getElementData(player, "player:faction") == "SAPD" then
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
    if isPedInVehicle(player) and getElementData(player, "player:faction") == "SAPD" then
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


for i,vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
	setElementData(vehicle, "dbid", i)
end







function SpeedCam_Render_ON( thePlayer, matchingDimension )
if getElementType ( thePlayer ) == "player" then 
local SpeedName = getElementData(source,"Speed")
setElementData(thePlayer,"Speed:ON",SpeedName)
end
	end

 

function SpeedCam_Render_OFF( thePlayer, matchingDimension )
if getElementType ( thePlayer ) == "player" then 
removeElementData(thePlayer,"Speed:ON")
end
	end

function ToggleSpeedCamera(player)
local vehicle = getPedOccupiedVehicle ( player )
local Speed = getElementData(vehicle,"Speed")
local model = getElementModel(vehicle)
if getElementData(vehicle,"vehicle:duty") == "SAPD" then
if Speed == true then
triggerClientEvent ( player, "Speed:Cam", player,"off" )
setElementData(vehicle,"Speed",false)
local el=getAttachedElements(vehicle)
for i,v in ipairs(el) do
if getElementType(v)=="colshape" then
destroyElement(v)
end
	end
elseif Speed == false then
	local x, y, z = getElementPosition(vehicle)
	local radiusLevel = 6
	local radius = createColSphere(x, y, z, radiusLevel)
	local ID = getElementData(vehicle,"dbid")
	attachElements ( radius,vehicle, 0, 5+radiusLevel, 0 )
	setElementData(radius,"Speed",ID)
	setElementData(vehicle,"Speed",true)
	addEventHandler ( "onColShapeHit", radius ,SpeedCam_Render_ON )
	addEventHandler ( "onColShapeLeave", radius, SpeedCam_Render_OFF )	
	triggerClientEvent ( player, "SpeedCam", player,"on" )
end
	end
		end

 
 
function enterVehicle ( player, seat, jacked ) 
local model = getElementModel(source)
if getElementData(source,"vehicle:duty") == "SAPD" and (seat == 0 or seat == 1) then
	local x, y, z = getElementPosition(source)
	local radiusLevel = 6
	local radius = createColSphere(x, y, z, radiusLevel)
	if seat == 0 then
	local PoliceNames = string.gsub(getPlayerName(player),"_"," ")
	setElementData(source,"SpeedCurrise:Police:Name",PoliceNames)
	end

	local ID = getElementData(source,"dbid")
	attachElements ( radius,source, 0, 5+radiusLevel, 0 )
	setElementData(radius,"Speed",ID)
	setElementData(source,"Speed",true)
	addEventHandler ( "onColShapeHit", radius ,SpeedCam_Render_ON )
	addEventHandler ( "onColShapeLeave", radius, SpeedCam_Render_OFF )		
triggerClientEvent ( player, "SpeedCam", player,"on" )	
end	
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle )

function exitVehicle ( thePlayer, seat, jacked ) 
local model = getElementModel(source)
if getElementData(source,"vehicle:duty") == "SAPD" and (seat == 0 or seat == 1) then
triggerClientEvent ( thePlayer, "SpeedCam", thePlayer,"off" )	
end	
end
addEventHandler ( "onVehicleExit", getRootElement(), exitVehicle ) 