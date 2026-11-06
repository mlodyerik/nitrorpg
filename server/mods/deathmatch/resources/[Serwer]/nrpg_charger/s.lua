local elektryki = {

    [587] = true,
	[550] = true,

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