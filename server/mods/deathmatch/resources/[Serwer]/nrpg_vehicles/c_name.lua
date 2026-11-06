local vehiclesNames = {

    ["Banshee"] = "Corvette C7",
	["Intruder"] = "Audi A6",
	["Euros"] = "Tesla Roadster",
	["Hotring Racer"] = "Deluxo",
	["Super GT"] = "BMW M2",
    ["Fortune"] = "Ferrari Italia",
    ["Sunrise"] = "Tesla Model S",
    ["Stratum"] = "Mercedes GT63 AMG",
    ["Feltzer"] = "BMW e36",
    ["Club"] = "Golf MK4",
    ["Willard"] = "BMW M4",
    ["Solair"] = "Audi RS6",
    ["Emperor"] = "Subaru Impreza",

}

function changeName(name)
    local changedName = vehiclesNames[name]
    if changedName then
        return changedName
    else
        return name
    end
end

function getTuning(veh, tuning)
    if not getElementData(veh, "vehicle:id") then return end
    
	local theTable = getElementData(veh, "vehicle:tuning")
	for i,v in ipairs(theTable) do
		if tuning == v[1] then
			return true
		end
	end
end

local noWindow = {

    [411] = {4, 1},
    [411] = {4, 2},

}

function openWindowsJoin()
    for i,v in ipairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle:id") then
            local vehicleModel = getElementModel(v)
            local var1, var2 = getVehicleVariant(v)
            if noWindow[vehicleModel] then
                if noWindow[vehicleModel][1] == var1 and noWindow[vehicleModel][2] == var2 then
                    setVehicleWindowOpen(v, 2, true)
                    setVehicleWindowOpen(v, 3, true)
                    setVehicleWindowOpen(v, 4, true)
                    setVehicleWindowOpen(v, 5, true)
                end
            end
        end
    end
end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), openWindowsJoin)

function openWindows(id)
    for i,v in ipairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle:id") == id then
            local vehicleModel = getElementModel(v)
            local var1, var2 = getVehicleVariant(v)
            if noWindow[vehicleModel] then
                if noWindow[vehicleModel][1] == var1 and noWindow[vehicleModel][2] == var2 then
                    setVehicleWindowOpen(v, 2, true)
                    setVehicleWindowOpen(v, 3, true)
                    setVehicleWindowOpen(v, 4, true)
                    setVehicleWindowOpen(v, 5, true)
                end
            end
        end
    end
end
addEvent("openVehicleWindows", true)
addEventHandler("openVehicleWindows", root, openWindows)