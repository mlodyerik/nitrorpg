addEvent("vehicleEngine", true)
addEventHandler("vehicleEngine", root, function(veh)
    setVehicleEngineState(veh, not getVehicleEngineState(veh))
end)

addEvent("vehicleLights", true)
addEventHandler("vehicleLights", root, function(veh)
    setVehicleOverrideLights(veh, (getVehicleOverrideLights(veh) == 2) and 1 or 2)
end)

addEvent("vehicleHandbrake", true)
addEventHandler("vehicleHandbrake", root, function(veh)
    setElementFrozen(veh, not isElementFrozen(veh))
end)

addEvent("vehicleDoors", true)
addEventHandler("vehicleDoors", root, function(veh)
    setVehicleLocked(veh, not isVehicleLocked(veh))
end)

addEvent("vehicleABS", true)
addEventHandler("vehicleABS", root, function(veh)
    setElementData(veh, "vehicle:toggleABS", not getElementData(veh, "vehicle:toggleABS"))
end)

addEvent("vehicleLPG", true)
addEventHandler("vehicleLPG", root, function(veh)
    setElementData(veh, "vehicle:togglelpg", not getElementData(veh, "vehicle:togglelpg"))
end)

addEvent("kickPassengers", true)
addEventHandler("kickPassengers", root, function(veh)
    for seat,plr in pairs(getVehicleOccupants(veh)) do
        if seat ~= 0 then
            removePlayerFromVehicle(plr)
        end
    end
end)

addEvent("suspensionRegulate", true)
addEventHandler("suspensionRegulate", root, function(veh, state)
    if state == "down" then
        local getSuspension = getVehicleHandlingProperty(veh, "suspensionForceLevel")
        
        setVehicleHandling(veh, "suspensionForceLevel", tonumber(getSuspension) - 0.10)
    elseif state == "up" then
        local getSuspension = getVehicleHandlingProperty(veh, "suspensionForceLevel")
        
        setVehicleHandling(veh, "suspensionForceLevel", tonumber(getSuspension) + 0.10)
    end
end)

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getVehicleHandling ( element ) 
        local value = handlingTable[property] 
 
        if value then
            return value
        end
    end
 
    return false
end