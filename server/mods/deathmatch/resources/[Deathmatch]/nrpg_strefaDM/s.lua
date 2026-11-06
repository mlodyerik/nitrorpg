local strefa =  createColRectangle( 1959.3610839844, -1826.8842773438, 1035.3498535156, 2300.19055175781)
local skillstable = { 69, 70, 71, 72, 73, 74, 76, 77, 78, 79 }
local weaponstable = { 24, 25, 30, 31, 28}

addEventHandler("onColShapeHit", strefa, function(el)
    if getElementType(el) == "player" then
        reloadDMInfo(el)
        toggleControl(el, "fire", true)
        toggleControl(el, "aim_weapon", true)
        setElementData(el, "player:strefaDM", true)
        exports.nrpg_interface:showPlayerNotification(el, 'Wchodzisz do strefy bezprawia', 'info', 15000)

        
        local saveSkin = getElementModel(el)
        if saveSkin == 49 then
            setElementData(el, "dmSaveSkin", saveSkin)
            setElementModel(el, 0)
        end

        if not getElementData(el, "player:faction") then
            for _, stat in ipairs(skillstable) do
                setPedStat(el, stat, 1000)
            end

            for _, weapon in ipairs(weaponstable) do
                giveWeapon(el, weapon, 9999)

                if weapon == 24 then
                    giveWeapon(el, 24, 9999, true)
                end
            end
        end
    end
end)

addEventHandler("onColShapeLeave", strefa, function(el)
    if getElementType(el) == "player" then
        reloadDMInfo(el)

        if not getElementData(el, "player:faction") then
            if getElementData(el, "player:level") ~= 5 then
                toggleControl(el, "fire", false)
                toggleControl(el, "aim_weapon", false)
            else
                giveWeapon(el, 22, 9999)
                setPedStat(el, 69, 0)
            end
            takeAllWeapons(el)
        end

        local saveSkin = getElementData(el, "dmSaveSkin")
        if saveSkin then
            setElementModel(el, saveSkin)
        end
        
        setElementData(el, "player:strefaDM", false)
        exports.nrpg_interface:showPlayerNotification(el, 'Wychodzisz ze strefy bezprawia', 'info', 15000)
    end
end)

addEventHandler ( "onPlayerWasted", root, function(ammo, killer, killerweapon, bodypart)
	if ( killer ) and ( killer ~= source ) and getElementData(source, "player:sid") and getElementData(killer, "player:sid") then
        local playerRespekt = math.random(1,2)
        local organizationRespekt = math.random(5,6)

        if getElementData(killer, "player:organization") then
		    exports.nrpg_interface:showPlayerNotification(killer, 'Zabito gracza '..getPlayerName(source)..', otrzymujesz: '..playerRespekt..' pkt. respektu, twoja organizacja otrzymuje: '..organizationRespekt..' pkt. respektu', 'success', 15000)
            exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje_info SET punkty=punkty+? WHERE nazwa=?", organizationRespekt, getElementData(killer, "player:organization"))	
        else
            exports.nrpg_interface:showPlayerNotification(killer, 'Zabito gracza '..getPlayerName(source)..', otrzymujesz: '..playerRespekt..' pkt. respektu', 'success', 15000)
        end
        exports["nrpg_db"]:dbSet("UPDATE pystories_users SET respekt=respekt+? WHERE id=?", playerRespekt, getElementData(killer, "player:sid"))	

        local playerDieRespekt = 1
        local organizationDieRespekt = math.random(3,4)
        if getElementData(source, "player:organization") then
		    exports.nrpg_interface:showPlayerNotification(source, 'Zostałeś/aś zabity/a przez '..getPlayerName(killer)..', tracisz: '..playerDieRespekt..' pkt. respektu, twoja organizacja traci: '..organizationDieRespekt..' pkt. respektu', 'error', 15000)
            exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje_info SET punkty=punkty-? WHERE nazwa=?", organizationDieRespekt, getElementData(source, "player:organization"))	
        else
            exports.nrpg_interface:showPlayerNotification(source, 'Zostałeś/aś zabity/a przez '..getPlayerName(killer)..', tracisz: '..playerDieRespekt..' pkt. respektu', 'error', 15000)
        end
        exports["nrpg_db"]:dbSet("UPDATE pystories_users SET respekt=respekt-? WHERE id=?", playerDieRespekt, getElementData(source, "player:sid"))	
    end
    setElementData(source, "player:skinID", getElementModel(source))
    triggerClientEvent(source, "oknoNieprzytomnosci", source)

    if isElement(killer) then
        reloadDMInfo(killer)
    end

    if isElement(source) then
        reloadDMInfo(source)
    end
end)

function healGod(plr, loss)
    local actualHealth = getElementHealth(plr)
    setElementHealth(plr, actualHealth+loss)
end

addEventHandler("onPlayerDamage", root, function(attacker,attackerweapon,bodypart,loss)
    if getElementData(source, "player:safeDM") then
            healGod(source, loss)
        return
    end

    if isElementWithinColShape(source, strefa) then
        if bodypart == 9 then
		    local actualHealth = getElementHealth(source)
            if actualHealth < 5 then
                killPlayer(source, attacker, attackerweapon, bodypart)
            else
                setElementHealth(source, actualHealth-math.random(30,50))
            end
        end
    end
end)

addEvent("zrespZmarlego", true)
addEventHandler("zrespZmarlego", root, function()
	local x, y, z = getElementPosition(source)
	spawnPlayer(source, x, y, z)
	setCameraTarget(source, source)
	setElementData(source, "safe:bw", true)
    setElementModel(source, (getElementData(source, "player:skinID") or 0))

    if getElementData(source, "player:strefaDM") then
        for _, weapon in ipairs(weaponstable) do
            giveWeapon(source, weapon, 9999)

            if weapon == 24 then
                giveWeapon(source, 24, 9999, true)
            end
        end

        setElementAlpha(source, 200)
        setElementData(source, "player:safeDM", true)
        exports.nrpg_interface:showPlayerNotification(source, 'Otrzymujesz ochronę na 15 sekund, nie możesz być zabity/a', 'info', 15000)
        plr = source

        setTimer( function()
            if plr then
                setElementAlpha(plr, 255)
                setElementData(plr, "player:safeDM", false)
            end
        end, 15000, 1)
    end
end)

for i,v in ipairs(getElementsByType("player")) do
    if isPedDead(v) then
        triggerEvent("zrespZmarlego", v)
        setElementData(v, "player:bw", false)
        setElementData(v, "notshowhud", false)
    end
    
    
    if getElementData(v, "player:safeDM") then
        setElementAlpha(v, 255)
        toggleControl(v, "fire", true)
        toggleControl(v, "aim_weapon", true)
        setElementData(v, "player:safeDM", false)
    end
end

addEvent("deleteSafeBW", true)
addEventHandler("deleteSafeBW", root, function(plr)
    setElementAlpha(plr, 255)
    toggleControl(plr, "fire", true)
    toggleControl(plr, "aim_weapon", true)
    setElementData(plr, "player:safeDM", false)
    exports.nrpg_interface:showPlayerNotification(plr, 'Ochrona wyłączona', 'error', 15000)
end)

function reloadDMInfo(plr)
    if plr and getElementType(plr) ~= "player" and isElement(plr) then return end

    local player_sid = getElementData(plr, "player:sid")

    if player_sid then
        if getElementData(plr, "player:organization") then
            local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", player_sid)
            local result2 = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje_info WHERE nazwa=?", getElementData(plr, "player:organization"))
            triggerClientEvent(plr, "dmInfoReloadClient", plr, result[1].respekt, result2[1].punkty)
        else
            local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", player_sid)
            triggerClientEvent(plr, "dmInfoReloadClient", plr, result[1].respekt, 0)
        end
    end
end