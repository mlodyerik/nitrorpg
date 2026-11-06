addEvent("changeVehicleColor", true)
addEventHandler("changeVehicleColor", root, function(veh, colorType, color, cost)
    if getPlayerMoney(client) >= cost then
        r, g, b = color[1], color[2], color[3]
        v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = getVehicleColor(veh, true)

        if colorType == "color1" then
            setVehicleColor(veh, r, g, b, v4, v5, v6, v7, v8, v9, v10, v11, v12)
        elseif colorType == "color2" then
            setVehicleColor(veh, v1, v2, v3, r, g, b, v7, v8, v9, v10, v11, v12)
        elseif colorType == "color3" then
            setVehicleColor(veh, v1, v2, v3, v4, v5, v6, r, g, b, v10, v11, v12)
        elseif colorType == "color4" then
            setVehicleColor(veh, v1, v2, v3, v4, v5, v6, v7, v8, v9, r, g, b)
        end

        exports["nrpg_vehicles"]:onSaveVehicle(veh)
        takePlayerMoney(client, cost)
        exports.nrpg_interface:showPlayerNotification(client, "Kolor pojazdu został zmieniony", "success", 3000, "Kolor pojazdu")
    end
end)

addEvent("upgradeVehicleEngine", true)
addEventHandler("upgradeVehicleEngine", root, function(veh, cost, engine)
    if getPlayerMoney(client) >= cost then
        setElementData(veh, "Pojemnosc:silnika", engine)
        takePlayerMoney(client, cost)
        exports["nrpg_vehicles"]:onSaveVehicle(veh)

        exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie ulepszono silnik do pojemności "..engine.." dm3 za kwotę "..addPrzecinki(cost).." PLN", "success", 3000, "Ulepszenie silnika")
    end
end)

addEvent("changeLicensePlate", true)
addEventHandler("changeLicensePlate", root, function(veh, cost, plate)
    if getPlayerMoney(client) >= cost then
        setVehiclePlateText(veh, plate)
        takePlayerMoney(client, cost)
        exports["nrpg_vehicles"]:onSaveVehicle(veh)

        exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie zmieniono rejestracje pojazdu na "..utf8.upper(plate).." za kwotę "..addPrzecinki(cost).." PLN", "success", 3000, "Zmiana rejestracji")
    end
end)

addEvent("montageNitro", true)
addEventHandler("montageNitro", root, function(veh, cost, name, id)
    if getPlayerMoney(client) >= cost then
        addVehicleUpgrade(veh, id)
        takePlayerMoney(client, cost)
        exports["nrpg_vehicles"]:onSaveVehicle(veh)

        exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie zakupiono butlę nitra "..name.." za kwotę "..addPrzecinki(cost).." PLN", "success", 3000, "Butla nitra")
    end
end)

addEvent("changeVehicleLightsColor", true)
addEventHandler("changeVehicleLightsColor", root, function(veh, cost, name, color)
    if getPlayerMoney(client) >= cost then
        setElementData(veh, "saveLights", {color[1], color[2], color[3]})
        setVehicleHeadLightColor(veh, color[1], color[2], color[3])
        takePlayerMoney(client, cost)
        exports["nrpg_vehicles"]:onSaveVehicle(veh)

        exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie zmieniono kolor lamp na "..name.." za kwotę "..addPrzecinki(cost).." PLN", "success", 3000, "Kolor lamp")
    end
end)

addEvent("changeVehicleSpeedoColor", true)
addEventHandler("changeVehicleSpeedoColor", root, function(veh, cost, name, color)
    if getPlayerMoney(client) >= cost then
        setElementData(veh, "licznikColor", {color[1], color[2], color[3]})
        takePlayerMoney(client, cost)
        exports["nrpg_vehicles"]:onSaveVehicle(veh)

        exports.nrpg_interface:showPlayerNotification(client, "Pomyślnie zmieniono kolor licznika na "..name.." za kwotę "..addPrzecinki(cost).." PLN", "success", 3000, "Kolor licznika")
    end
end)

function reloadColors(plr, sid)
    result = exports["nrpg_db"]:dbGet("SELECT * from pystories_components WHERE sid=?", sid)
            
    if #result > 0 then
        triggerClientEvent(plr, "loadColors", resourceRoot, result)
    else
        local table = {}
        triggerClientEvent(plr, "loadColors", resourceRoot, table)
    end
end

addEvent("manageColors", true)
addEventHandler("manageColors", root, function(plr, type, id, color)
    if type == "add" then
        local sid = getElementData(plr, "player:sid")

        if sid then
            exports["nrpg_db"]:dbSet("INSERT INTO pystories_components SET sid = ?, color = '?, ?, ?'", sid, color[1], color[2], color[3])
            reloadColors(plr, sid)
        end
    elseif type == "delete" then
        local sid = getElementData(plr, "player:sid")

        if sid then
            exports['nrpg_db']:dbSet("DELETE from pystories_components WHERE id=? AND sid=?", id, sid)
            reloadColors(plr, sid)
        end
    elseif type == "load" then
        local sid = getElementData(plr, "player:sid")

        if sid then
            result = exports["nrpg_db"]:dbGet("SELECT * from pystories_components WHERE sid=?", sid)

            if #result > 0 then
                triggerClientEvent(plr, "loadColors", resourceRoot, result)
            else
                local table = {}
                triggerClientEvent(plr, "loadColors", resourceRoot, table)
            end
        end
    end
end)

function addPrzecinki(amount) 
    local formatted = amount 
    while true do   
      formatted, przecinek = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (przecinek==0) then 
        break 
      end 
    end 
    return formatted 
end

