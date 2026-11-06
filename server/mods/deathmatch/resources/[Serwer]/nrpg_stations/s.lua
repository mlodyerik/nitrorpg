local costs = {

    ["Diesel"] = 0,
    ["LPG"] = 0,
    ["Benzyna"] = 0,
    ["Elektryczny"] = 0,

}

function randomFuelCost()
    local randomLPG = math.random(2000, 3000)
    local randomBenzyna = math.random(7500, 10000)
    local randomDiesel = math.random(4000, 7500)
    local randomBateria = math.random(2750, 4000)
    local data = {Diesel=randomDiesel, Benzyna=randomBenzyna, LPG=randomLPG, Elektryczny=randomBateria}

    costs["Diesel"] = randomDiesel
    costs["LPG"] = randomLPG
    costs["Benzyna"] = randomBenzyna
    costs["Elektryczny"] = randomBateria

    triggerClientEvent(root, "getPetrolCost", root, data)
end

addEvent("getPetrolCostServer", true)
addEventHandler("getPetrolCostServer", root, function()
    local data = {Diesel=costs["Diesel"], Benzyna=costs["Benzyna"], LPG=costs["LPG"], Elektryczny=costs["Elektryczny"]}

    triggerClientEvent(client, "getPetrolCost", client, data)
end)

setTimer(function()
    randomFuelCost()

    setTimer(function()
        randomFuelCost()
    end, 60000*60, 0)
end, 1000, 1)
