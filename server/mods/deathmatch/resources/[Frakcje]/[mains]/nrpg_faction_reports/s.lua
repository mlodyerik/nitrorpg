local reports = {}
local blips = {}
local markers = {}
local block = {}

addCommandHandler("zgloszenie", function(plr, cmd, faction, ...)
    if utf8.upper(faction) == "SAPD" or utf8.upper(faction) == "SAMC" or utf8.upper(faction) == "SAFD" then
    if not ... then outputChatBox("ⓘ#ffffff Wprowadź treść zgłoszenia", plr, 255, 0, 0, true) return end
    if findReport(getElementData(plr, "id"), utf8.upper(faction)) then outputChatBox("ⓘ#ffffff Wysłałeś/aś już zgłoszenie do tej frakcji", plr, 255, 0, 0, true) return end
    if block[plr] == true then outputChatBox("ⓘ#ffffff Zgłoszenia możesz wysyłać co 30 sekund", plr, 255, 0, 0, true) return end
    local reportText = table.concat({...}, " ")
    local x, y, z = getElementPosition(plr)
    local zoneAll = getZoneName(x, y, z, false)
    local zoneCity = getZoneName(x, y, z, true)
        for i,v in ipairs(getElementsByType("player")) do
            if getElementData(v, "player:faction") == utf8.upper(faction) then
                outputChatBox(" ", v, 255, 255, 0, true)
                outputChatBox(" ", v, 255, 255, 0, true)
                outputChatBox("ⓘ#ffffff Gracz #fce303"..getPlayerName(plr).."#ffffff wysyła zgłoszenie do frakcji #c2c2c2"..utf8.upper(faction).."#ffffff", v, 255, 255, 0, true)
                outputChatBox("ⓘ#ffffff Treść zgłoszenia: #03a9fc"..reportText.."#ffffff", v, 255, 255, 0, true)
                outputChatBox("ⓘ#ffffff Lokalizacja: #c2c2c2"..zoneAll..", "..zoneCity, v, 255, 255, 0, true)
                outputChatBox("ⓘ#ffffff Aby przyjąć zgłoszenie wpisz #03fc14/pz "..getElementData(plr, "id").."#ffffff", v, 255, 255, 0, true)
                outputChatBox(" ", v, 255, 255, 0, true)
                outputChatBox(" ", v, 255, 255, 0, true)
            end
        end
        table.insert(reports, {getElementData(plr, "id"), x, y, z, getPlayerName(plr), utf8.upper(faction)})
        block[plr] = true

        setTimer( function()
            block[plr] = false
        end, 30000, 1)
    else
        outputChatBox("ⓘ#ffffff Złe użycie komendy, użyj /zgloszenie <SAPD/SARA/SAFD>", plr, 255, 0, 0, true)
    end
end)

addCommandHandler("pz", function(plr, cmd, id)
    if not getElementData(plr, "player:faction") then return end

    if id then
        for i,v in ipairs(reports) do
            if v[1] == tonumber(id) and getElementData(plr, "player:faction") == v[6] then
                if findReport(v[1], getElementData(plr, "player:faction")) == false then outputChatBox("ⓘ#ffffff Nie ma takiego zgłoszenia", plr, 255, 0, 0, true) return end

                for ii,vv in ipairs(getElementsByType("player")) do
                    if getElementData(vv, "player:faction") == getElementData(plr, "player:faction") then
                        outputChatBox("ⓘ#ffffff "..getPlayerName(plr).." przyjmuje zgłoszenie gracza #c2c2c2["..v[1].."] "..v[5].."#ffffff", vv, 255, 255, 0, true)
                    end
                end

                local x, y, z = v[2], v[3], v[4]
                blips[plr] = createBlip(x, y, z, 41, 2, 255, 255, 255, 255, 0, 99999, plr)
                markers[plr] = createMarker(x, y, z-2, "cylinder", 20, 0, 0, 0, 0, plr)

                addEventHandler("onMarkerHit", markers[plr], function(el)
                    if isElement(blips[el]) then destroyElement(blips[el]) end
                    if isElement(markers[el]) then destroyElement(markers[el]) end
                end)

                if findReport(id, v[6]) then
                    deleteReport(id, v[6])
                end
            end
        end
    else
        outputChatBox("ⓘ#ffffff Wprowadź ID gracza", plr, 255, 0, 0, true)
    end
end)

function findReport(id, faction)
    for i, v in ipairs(reports) do
        if v[1] == tonumber(id) and v[6] == faction then
            return true
        else
            return false
        end
    end
end

function deleteReport(id, faction)
    for i, v in ipairs(reports) do
         if v[1] == tonumber(id) and v[6] == faction then
            table.remove(reports, i)
            return true
         end
    end
end