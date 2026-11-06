local vehicles = {

    {"Infernus", 411, 0, 1000000, {2119.21, -1146.42, 24.23, 2.3, 4.3, 314.2}, 25, {2148.76, -1133.47, 25.29, 0.0, 359.8, 267.5}},

}

local blips = {

    {2130.10, -1141.27, 25.12},

}

local engines = {

    cost = {

        ["1.4"] = 1,
        ["1.6"] = 1.05,
        ["1.8"] = 1.15,
        ["2.0"] = 1.20,

    },

    types = {

        {"1.4"},
        {"1.6"},
        {"1.8"},
        {"2.0"},

    },

}

function shapeHit(thePlayer, matchingDimension)
    if getElementType ( thePlayer ) == "player" and matchingDimension == true then
        local shapeData = getElementData(source, "vehicle:salonData") or {}

        triggerClientEvent(thePlayer, "vehicleInfoToggle", resourceRoot, shapeData, true)
    end
end

function shapeLeave(thePlayer, matchingDimension)
    if getElementType ( thePlayer ) == "player" and matchingDimension == true then
        triggerClientEvent(thePlayer, "vehicleInfoToggle", resourceRoot, _, false)
    end
end

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

function convertNumber(amount) 
    local formatted = amount 
    while true do   
      formatted, ss = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (ss==0) then 
        break 
      end 
    end 
    return formatted 
end

for i,v in ipairs(vehicles) do
    local vehicle = createVehicle(v[2], v[5][1], v[5][2], v[5][3], v[5][4], v[5][5], v[5][6])
    setVehicleLocked(vehicle, true)
    setElementFrozen(vehicle, true)
    setVehicleColor(vehicle, 125, 125, 125, 125, 125, 125)
    setVehiclePlateText(vehicle, "FOR SALE")
    local randomEngine = math.random(1, #engines.types)
    local shape = createColSphere(v[5][1], v[5][2], v[5][3], 3)
    

    setElementData(shape, "vehicle:salonData", {name=v[1], model=v[2], mileage=v[3], cost=v[4]*engines.cost[engines.types[randomEngine][1]], engine=engines.types[randomEngine][1], bak=v[6], naped=getVehicleHandlingProperty(vehicle, "driveType"), pos=v[5], respawn=v[7]})
    addEventHandler("onColShapeHit", shape, shapeHit)
    addEventHandler("onColShapeLeave", shape, shapeLeave)

    local vehicleData = getElementData(shape, "vehicle:salonData")
    local vehicleDesc = "Pojazd: #6bbfff"..v[1].."#ffffff\n\nCena: #37c837"..convertNumber(vehicleData.cost).." PLN#ffffff\nPojemność silnika: #ffaf19"..vehicleData.engine.." dm3#ffffff #b8b8b8(Pojemność baku: "..vehicleData.bak.." dm3)#ffffff\nPrzebieg: #ffaf19"..vehicleData.mileage.." km#ffffff\n\nAby dowiedzieć się więcej\nna temat tego pojazdu podejdź do niego"
    setElementData(vehicle, "vehicle:desc", vehicleDesc)
end

local vehs = {}

function endTestDrive(thePlayer)
    local data = getElementData(thePlayer, "player:testDrive")

    if isElement(source) then
        destroyElement(source)
    end

    setTimer( function()
        setElementDimension(thePlayer, 0)
        setElementPosition(thePlayer, data.pos[1], data.pos[2], data.pos[3])
        exports.nrpg_interface:showPlayerNotification(thePlayer, "Jazda próbna zakończona", "error", 4000, "Jazda próbna")
    end, 100, 1)
end

addEvent("vehicleTestDrive", true)
addEventHandler("vehicleTestDrive", root, function(plr, data)
    local dimension = getElementData(plr, "player:sid")

    vehs[plr] = createVehicle(getVehicleModelFromName(data.name), data.pos[1], data.pos[2], data.pos[3], data.pos[4], data.pos[5], data.pos[6])
    setVehicleColor(vehs[plr], 125, 125, 125, 125, 125, 125)
    setElementDimension(vehs[plr], dimension)
    setElementDimension(plr, dimension)
    setVehiclePlateText(vehs[plr], "  TEST  ")
    setElementData(plr, "player:testDrive", {pos=data.pos})

    if data.engine == "1.4" then
        -- nic nie dajemy
    elseif data.engine == "1.6" then
        setVehicleHandling(vehs[plr],"engineAcceleration", getVehicleHandlingProperty(vehs[plr], "engineAcceleration")+0.5)
        setVehicleHandling(vehs[plr],"maxVelocity", getVehicleHandlingProperty(vehs[plr], "maxVelocity")+5)
    elseif data.engine == "1.8" then
        setVehicleHandling(vehs[plr],"engineAcceleration", getVehicleHandlingProperty(vehs[plr], "engineAcceleration")+1)
        setVehicleHandling(vehs[plr],"maxVelocity", getVehicleHandlingProperty(vehs[plr], "maxVelocity")+6)
    elseif data.engine == "1.8" then
        setVehicleHandling(vehs[plr],"engineAcceleration", getVehicleHandlingProperty(vehs[plr], "engineAcceleration")+1.5)
        setVehicleHandling(vehs[plr],"maxVelocity", getVehicleHandlingProperty(vehs[plr], "maxVelocity")+7)
    elseif data.engine == "2.0" then
        setVehicleHandling(vehs[plr],"engineAcceleration", getVehicleHandlingProperty(vehs[plr], "engineAcceleration")+2)
        setVehicleHandling(vehs[plr],"maxVelocity", getVehicleHandlingProperty(vehs[plr], "maxVelocity")+15)
    end

    setTimer(function()
        warpPedIntoVehicle(plr, vehs[plr])
        exports.nrpg_interface:showPlayerNotification(plr, "Rozpoczynasz jazdę próbną, aby zakończyć kliknij F", "info", 4000, "Jazda próbna")
    end, 100, 1)

    addEventHandler("onVehicleStartExit", vehs[plr], endTestDrive)
end)

plrmoney = {}

addEvent("buySalonVehicle", true)
addEventHandler("buySalonVehicle", root, function(plr, sid, color, data, type)
    if type == "bank" then
        local bankmoney = exports["nrpg_db"]:dbGet("SELECT `bank_money` FROM `pystories_users` WHERE `id` = ?", sid)
        for i, v in ipairs(bankmoney) do
            plrmoney[plr] = v["bank_money"]
        end

        if plrmoney[plr] < data.cost then
            exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz tyle pieniędzy w banku", "error", 4000, "Brak środków")
            return
        end
    else
        if getPlayerMoney(plr) < data.cost then
            exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz tyle pieniędzy przy sobie", "error", 4000, "Brak środków")
            return
        end
    end


    if type == "bank" then
        exports["nrpg_db"]:dbSet("UPDATE `pystories_users` SET `bank_money` = `bank_money` - ? WHERE `pystories_users`.`id` = ?", data.cost, sid)
    else
        takePlayerMoney(plr, data.cost)
    end
       
    exports["nrpg_db"]:dbSet("INSERT INTO `pystories_vehicles` (`model`,`ownedPlayer`,`mileage`,`registered`,`parking`,`silnik`,`color`,`bak`,`fuel`,`salondata`) VALUES (?,?,?,?,1,?,?,?,?,?)", getVehicleModelFromName(data.name), sid, data.mileage, "true", data.engine, color, data.bak, data.bak, getElementData(plr,"player:sid"))
    
    local query = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles where salondata=?", sid)
    local vehicleID = query[1].id

    exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET salondata=? WHERE id=?", 0, vehicleID)

    local spawn = exports["nrpg_vehicles"]:onRespawnVehicles(_, vehicleID, data.respawn)

    local car = findCar(plr, vehicleID)
    if car then
        setTimer( function()
            warpPedIntoVehicle(plr, car)
            setVehicleEngineState(car, true)
        end, 100, 1)
    end
    
    exports.nrpg_interface:showPlayerNotification(plr, "Zakupiłeś pojazd "..data.name.." za cenę "..convertNumber(data.cost).." PLN", "success", 4000, "Kupno pojazdu")
    triggerClientEvent(plr, "vehicleInfoToggle", resourceRoot, _, false)
end)

function findCar(player, toCar)
    for i,v in ipairs(getElementsByType("vehicle")) do
        if tonumber(toCar) then
            if getElementData(v, "vehicle:id") == tonumber(toCar) then
                return v
            end
        end
    end
end

for i,v in ipairs(blips) do
    createBlip(v[1], v[2], v[3], 55, 2, 0, 0, 0, 0, 0, 275)
end