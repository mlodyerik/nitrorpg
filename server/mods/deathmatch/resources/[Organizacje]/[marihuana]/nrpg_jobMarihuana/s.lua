marihuana = {}
shapes = {}

addEvent("posadzKrzak", true)
addEventHandler("posadzKrzak", root, function(plr)
    if isPedDead(plr) then return end
    local playerSID = getElementData(plr, "player:sid")

    if playerSID then
        if not getElementData(plr, "player:strefaDM") then exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz tutaj sadzić krzaków, udaj się na strefę bezprawia!', 'error') return end

        if getElementData(plr, "player:organization") then
            smokeSlots = 10
        else
            smokeSlots = 5
        end
        
        local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE sid=? AND item=?", playerSID, "Nasiona marihuany")
        if tonumber(check[1].ilosc) > 0 then
            local checkMarihuana = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_marihuana WHERE sid=?", playerSID)
            if #checkMarihuana > smokeSlots-1 then
                exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz posadzić więcej niż '..smokeSlots..' sadzonek', 'error')
            else
                result_use = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE item=? AND sid=?", "Nasiona marihuany", getElementData(plr, "player:sid"))

                if tonumber(result_use[1].ilosc) == 1 or 1 > tonumber(result_use[1].ilosc) then
                    exports['nrpg_db']:dbSet("DELETE from pystories_ekwipunek WHERE item=? AND sid=?", "Nasiona marihuany", getElementData(plr, "player:sid"))
                end
        
                if tonumber(result_use[1].ilosc) == 0 or 0 > tonumber(result_use[1].ilosc) then
                    exports['nrpg_db']:dbSet("DELETE from pystories_ekwipunek WHERE item=? AND sid=?", "Nasiona marihuany", getElementData(plr, "player:sid"))
                else
                    exports["nrpg_db"]:dbSet("UPDATE pystories_ekwipunek SET ilosc=ilosc-1 WHERE item=? AND sid=?", "Nasiona marihuany", getElementData(plr, "player:sid"))
                end
    
                result_us = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE sid=?", getElementData(plr, "player:sid"))
                if #result_us > 0 then
                    triggerClientEvent(plr, "eqGetDataClient", root, result_us)
                else
                    table = {}
                    triggerClientEvent(plr, "eqGetDataClient", root, table)
                end
                
                setPedAnimation(plr, "COP_AMBIENT", "Copbrowse_nod", -1, true, false)

                setTimer(function()
                    setPedAnimation(plr, false)
                    local x, y, z = getElementPosition(plr)
                    local dimension = getElementDimension(plr)
                    local interior = getElementInterior(plr)
                    local position = x..", "..y..", "..z..", "..dimension..", "..interior
                    exports["nrpg_db"]:dbSet("INSERT INTO pystories_marihuana SET stan=?, pos=?, sid=?", 0, position, getElementData(plr, "player:sid"))
                    reloadCreatedMarihuana()
                
                    exports.nrpg_interface:showPlayerNotification(plr, 'Posadziłeś/aś krzak marihuany', 'success')
                end, 2500, 1)
            end
        end
    end
end)

addEvent("zbierzKrzak", true)
addEventHandler("zbierzKrzak", root, function(plr, id)
    if isPedDead(plr) then return end
    local playerSID = getElementData(plr, "player:sid")

    if playerSID then
        setPedAnimation(plr, "COP_AMBIENT", "Copbrowse_nod", -1, true, false)

        setTimer(function()
            setPedAnimation(plr, false)
            if isElement(marihuana[id]) then destroyElement(marihuana[id]); marihuana[id] = nil end
            if isElement(shapes[id]) then destroyElement(shapes[id]); shapes[id] = nil  end
            exports['nrpg_db']:dbSet("DELETE from pystories_marihuana WHERE id=? AND sid=?", id, playerSID)

            local randomMarihuana = math.random(12,15)

            local result_buy = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE item=? AND sid=?", "Marihuana", playerSID)

            if #result_buy > 0 then
                exports["nrpg_db"]:dbSet("UPDATE pystories_ekwipunek SET ilosc=ilosc+? WHERE item=? AND sid=?", randomMarihuana, "Marihuana", playerSID)
            elseif #result_buy == 0 then
                exports["nrpg_db"]:dbSet("INSERT INTO pystories_ekwipunek SET ilosc=?, legal=?, item=?, type=?, sid=?", randomMarihuana, "false", "Marihuana", "smoke", playerSID)
            end

            exports.nrpg_interface:showPlayerNotification(plr, 'Zebrano krzaka, otrzymujesz '..randomMarihuana..'g marihuany', 'success')
        end, 5000, 1)
    end
end)

addEvent("usunKrzak", true)
addEventHandler("usunKrzak", root, function(plr, id, sid)
    if isPedDead(plr) then return end
    local playerSID = getElementData(plr, "player:sid")

    if playerSID then
        exports['nrpg_db']:dbSet("DELETE from pystories_marihuana WHERE id=? AND sid=?", id, sid)

        if isElement(marihuana[id]) then destroyElement(marihuana[id]); marihuana[id] = nil end
        if isElement(shapes[id]) then destroyElement(shapes[id]); shapes[id] = nil  end

        local marihuanaResultDelete = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", sid)
        exports.nrpg_interface:showPlayerNotification(plr, 'Usunięto krzak gracza '..marihuanaResultDelete[1].login..', SID: '..sid, 'success')
    end
end)

mathScale = function(scale)
    if scale then
        if scale > 25 then
            scaleMath = 30
        else
            scaleMath = 5
        end
        actualScale = scale + 1
        actualScale = actualScale/scaleMath
        return actualScale
    end
end

refreshMarihuana = function()
    local marihuanaResult = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_marihuana")
    for i,v in ipairs(marihuanaResult) do
        if isElement(marihuana[v.id]) then
            if 100 > v.stan then
                exports["nrpg_db"]:dbSet("UPDATE pystories_marihuana SET stan=stan+1 WHERE id=?", v.id)
                setElementData(marihuana[v.id], "marihuana:info", "#32a852Marihuana#ffffff\n\nStan: #bd39b6".. v.stan+1 .."%#ffffff")
                setElementData(shapes[v.id], "shape:info", {stan=v.stan+1, owner=v.sid, id=v.id})
                setObjectScale(marihuana[v.id], mathScale(v.stan))
            end
        end
    end
end

reloadCreatedMarihuana = function()
    local marihuanaResult = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_marihuana")
    for i,v in ipairs(marihuanaResult) do
        if not isElement(marihuana[v.id]) then
            local pos = split(v["pos"], ",")

            marihuana[v.id] = createObject(325, pos[1], pos[2], pos[3]-0.95)
            shapes[v.id] = createColSphere(pos[1], pos[2], pos[3]-0.55, 1.25)
            setElementData(marihuana[v.id], "marihuana:info", "#32a852Marihuana#ffffff\n\nStan: #bd39b6"..v.stan.."%#ffffff")
            setElementData(shapes[v.id], "shape:info", {stan=v.stan, owner=v.sid, id=v.id})
            setObjectScale(marihuana[v.id], mathScale(v.stan))
            setElementCollisionsEnabled(marihuana[v.id], false)

            if pos[4] and pos[5] then
                setElementInterior(marihuana[v.id], pos[5])
                setElementDimension(marihuana[v.id], pos[4])
            end
        end
    end
end

startMarihuana = function()
    local marihuanaResult = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_marihuana")
    for i,v in ipairs(marihuanaResult) do
        local pos = split(v["pos"], ",")

        marihuana[v.id] = createObject(325, pos[1], pos[2], pos[3]-0.95)
        shapes[v.id] = createColSphere(pos[1], pos[2], pos[3]-0.55, 1.25)
        setElementData(marihuana[v.id], "marihuana:info", "#32a852Marihuana#ffffff\n\nStan: #bd39b6"..v.stan.."%#ffffff")
        setElementData(shapes[v.id], "shape:info", {stan=v.stan, owner=v.sid, id=v.id})
        setObjectScale(marihuana[v.id], mathScale(v.stan))
        setElementCollisionsEnabled(marihuana[v.id], false)

        if pos[4] and pos[5] then
            setElementInterior(marihuana[v.id], pos[5])
            setElementDimension(marihuana[v.id], pos[4])
        end
    end
    setTimer(refreshMarihuana, 60000*5, 0)
end
startMarihuana()