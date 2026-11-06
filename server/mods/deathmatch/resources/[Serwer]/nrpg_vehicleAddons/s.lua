local elektryki = {

    [587] = true,
	[550] = true,

}


local bikes = {

    [509] = true,
    [481] = true,
    [510] = true,

}


function getVehicleEngine(veh)
    local theEngine = getElementData(veh, "vehicle:engineType") or "Diesel"
    local vehicleModel = getElementModel(veh)


    if elektryki[vehicleModel] then
        return "Elektryczny"
    else
        return theEngine
    end
end

function isBike(veh)
    local vehicleModel = getElementModel(veh)

    if bikes[vehicleModel] then
        return true
    else
        return false
    end
end