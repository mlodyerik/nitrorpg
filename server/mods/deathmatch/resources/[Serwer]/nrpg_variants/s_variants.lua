main = {}

main.sportVariants = {

    ["Sabre"] = {0, 1},
    ["Clover"] = {0, 1},
    ["Sentinel"] = {0, 1},

}

main.changeVariant = {

    ["Flash"] = {0, 1},
    ["Buffalo"] = {0, 2},
    ["Elegy"] = {0, 0},

}

function getVehicleHandlingProperty(element, property)
    if isElement(element) and getElementType(element) == "vehicle" and type(property) == "string" then
        local handlingTable = getVehicleHandling(element) 
        local value = handlingTable[property] 
 
        if value then
            return value
        end
    end
    return false
end

function changeVehicleVariant(theVehicle, isSport)
    if not isSport then isSport = 0 end

    setElementData(theVehicle, "vehicle:sport", isSport)

    if main.sportVariants[getVehicleName(theVehicle)] then
        if isSport == 1 then
            setVehicleVariant(theVehicle, main.sportVariants[getVehicleName(theVehicle)][1], main.sportVariants[getVehicleName(theVehicle)][2])
            local vehicle_engineAcceleration = getVehicleHandlingProperty(theVehicle, "engineAcceleration")
			local vehicle_maxVelocity = getVehicleHandlingProperty(theVehicle, "maxVelocity")
            local vehicle_tractionLoss = getVehicleHandlingProperty(theVehicle, "tractionLoss")
			local vehicle_steeringLock = getVehicleHandlingProperty(theVehicle, "steeringLock")
			setVehicleHandling(theVehicle, "engineAcceleration", vehicle_engineAcceleration+5)
			setVehicleHandling(theVehicle, "maxVelocity", vehicle_maxVelocity+50)
            setVehicleHandling(theVehicle, "tractionLoss", vehicle_tractionLoss+0.85)
        end
    elseif main.changeVariant[getVehicleName(theVehicle)] then
        setVehicleVariant(theVehicle, main.changeVariant[getVehicleName(theVehicle)][1], main.changeVariant[getVehicleName(theVehicle)][2])
    end
end