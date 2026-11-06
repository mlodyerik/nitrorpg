addEvent("reloadFotoradarInfo", true)
addEventHandler("reloadFotoradarInfo", root, function(plr, przek, dop)
    local secondTable = {}

    secondTable.przek = przek
    secondTable.dop = dop
    secondTable.zaplata = math.floor(secondTable.dop*secondTable.przek)*2

    if getPlayerMoney(plr) >= secondTable.zaplata then
        takePlayerMoney(plr, secondTable.zaplata)
    end

    triggerClientEvent(plr, "radarInfoClient", plr, plr, secondTable)
end)