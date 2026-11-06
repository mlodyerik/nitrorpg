local tunes = {


    ['mk4'] = {"mk4", nil, "MK4"},
    ['licznikrgb'] = {"licznik", nil, "LicznikRGB"},
    ['neonrgb'] = {"neonRGB", nil, "NeonRGB"},
    ['deluxo'] = {"deluxomode", nil, "Deluxomode"},
    ['hover'] = {"hovermode", nil, "Hovermode"},
    ['chip'] = {"chip", nil, "ChipTuning"},



}


addCommandHandler("zamontuj", function(plr, cmd, tune)
    if getAdmin(plr, 4) then
        if not tune or tune == " " or tune == "" then exports.nrpg_interface:showPlayerNotification(plr, "Użycie: /zamontuj <mk4/licznikrgb/deluxo/hover/neonrgb/chip>", "error") return end
        local veh = getPedOccupiedVehicle(plr)
        local tune_ = tunes[tune]

        if tune_ then
            addTune(plr, veh, tune_[3], tune_[1])
        end
    end
end)


addCommandHandler("zdemontuj", function(plr, cmd, tune)
    if getAdmin(plr, 4) then
        if not tune or tune == " " or tune == "" then exports.nrpg_interface:showPlayerNotification(plr, "Użycie: /zdemontuj <mk4/licznikrgb/deluxo/hover/neonrgb>", "error") return end
        local veh = getPedOccupiedVehicle(plr)
        local tune_ = tunes[tune]

        if tune_ then
            deleteTune(plr, veh, tune_[3], tune_[1])
        end
    end
end)

addCommandHandler("zamontuj.paintjob", function(plr, cmd, idP)
    if getAdmin(plr, 4) then
        local veh = getPedOccupiedVehicle(plr)
        idP = tonumber(idP)
        if not veh then return end
        if idP < 0 or idP > 12 then exports.nrpg_interface:showPlayerNotification(plr, "Użycie: /zamontuj.paintjob <0-12>", "error") return end

        local id = getElementData(veh, "vehicle:id")
        if id then
            setElementData(veh, "vehicle:paintjob", idP)
            exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `custompj` = '"..idP.."' WHERE `pystories_vehicles`.`id` = ?", id)
            exports.nrpg_interface:showPlayerNotification(plr, "Zamontowano paintjob!", "success")
        end
    end
end)

addCommandHandler("zamontuj.bak", function(plr, cmd, idP)
    if getAdmin(plr, 4) then
        local veh = getPedOccupiedVehicle(plr)
        idP = tonumber(idP)
        if not veh then return end
        if idP < 1 or idP > 1000 then exports.nrpg_interface:showPlayerNotification(plr, "Użycie: /zamontuj.bak <1-1000>", "error") return end

        local id = getElementData(veh, "vehicle:id")
        if id then
            setElementData(veh, "vehicle:bak", idP)
            exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `bak` = '"..idP.."' WHERE `pystories_vehicles`.`id` = ?", id)
            exports.nrpg_interface:showPlayerNotification(plr, "Zamontowano bak!", "success")
        end
    end
end)

addCommandHandler("zamontuj.motyw", function(plr, cmd, idP)
    if getAdmin(plr, 4) then
        local veh = getPedOccupiedVehicle(plr)
        idP = tonumber(idP)
        if not veh then return end
        if idP < 1 or idP > 5 then exports.nrpg_interface:showPlayerNotification(plr, "Użycie: /zamontuj.motyw <1-5>", "error") return end

        local id = getElementData(veh, "vehicle:id")
        if id then
            setElementData(veh, "vehicle:licznikMotyw", idP)
            exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `motyw` = '"..idP.."' WHERE `pystories_vehicles`.`id` = ?", id)
            exports.nrpg_interface:showPlayerNotification(plr, "Zamontowano motyw licznika!", "success")
        end
    end
end)

addCommandHandler("zamontuj.neon", function(plr, cmd, idP)
    if getAdmin(plr, 4) then
        local veh = getPedOccupiedVehicle(plr)
        idP = tonumber(idP)
        if not veh then return end
        if idP < 1 or idP > 6 then exports.nrpg_interface:showPlayerNotification(plr, "Użycie: /zamontuj.neon <1-6>", "error") return end

        local id = getElementData(veh, "vehicle:id")
        if id then
            setElementData(veh, "vehicle:neon", idP)
            exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `neon` = '"..idP.."' WHERE `pystories_vehicles`.`id` = ?", id)
            exports.nrpg_interface:showPlayerNotification(plr, "Zamontowano neon!", "success")
        end
    end
end)

function addTune(plr, veh, tune, tuneData)
    if veh then
        local id = getElementData(veh, "vehicle:id")
        if id then
            exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zamontowano #FFF600"..tune.."#FFFFFF do pojazdu ID: #FFF600"..id, "success")
            exports["nrpg_vehicles"]:addTuning(veh, tune, true)
            if tuneData == "neon" then
                exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `"..tuneData.."` = '2' WHERE `pystories_vehicles`.`id` = ?", id)
            else
                exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `"..tuneData.."` = '1' WHERE `pystories_vehicles`.`id` = ?", id)
            end
        end
    end
end

function deleteTune(plr, veh, tune, tuneData)
    if veh then
        local id = getElementData(veh, "vehicle:id")
        if id then
            exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie zdemontowano #FFF600"..tune.."#FFFFFF w pojeździe ID: #FFF600"..id, "success")
            exports['nrpg_db']:dbSet("UPDATE `pystories_vehicles` SET `"..tuneData.."` = '0' WHERE `pystories_vehicles`.`id` = ?", id)
        end
    end
end