s_main = {

    blips = {},
    sphere = {},

}


s_main.checkFaction = function(plr)
    if getElementData(plr, "player:faction") == "SAPD" or getElementData(plr, "player:faction") == "SARA" or getElementData(plr, "player:faction") == "SAFD" then
        return true
    else
        return false
    end
end

s_main.enterSphere = function(el)
    if getElementType(el) == "vehicle" then
        setElementData(el, "vehicle:wypadekStrefa", true)
    end
end

s_main.exitSphere = function(el)
    if getElementType(el) == "vehicle" then
        setElementData(el, "vehicle:wypadekStrefa", false)
    end
end

s_main.wypadekCommand = function(plr,cmd)
    if s_main.checkFaction(plr) then
        if (not isElement(s_main.blips[plr])) then
            if getElementInterior(plr) ~= 0 then exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz tego tutaj zrobić', 'error') return end
            if getElementDimension(plr) ~= 0 then exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz tego tutaj zrobić', 'error') return end
            local x, y, z = getElementPosition(plr)
            local street = getZoneName(x, y, z, false)
            local city = getZoneName(x, y, z, true)
            s_main.blips[plr] = createBlip(x, y, z, 19, 2, 255, 255, 255, 255, 0, 255)
            s_main.sphere[plr] = createColSphere(x, y, z, 30)

            addEventHandler("onColShapeHit", s_main.sphere[plr], s_main.enterSphere)
            addEventHandler("onColShapeLeave", s_main.sphere[plr], s_main.exitSphere)

            exports.nrpg_interface:showPlayerNotification(plr, 'Ustawiono utrudnienia w ruchu, aby je usunąć wpisz ponownie /utrudnienia', 'success') 
            triggerClientEvent(root, "admin:rendering", root, "Zanotowano utrudnienia w ruchu lądowym\nLokalizacja: "..street..", "..city.."", "warning")
        else
            if isElement(s_main.blips[plr]) then
                destroyElement(s_main.blips[plr])
            end

            if isElement(s_main.sphere[plr]) then
                for i,v in ipairs(getElementsWithinColShape(s_main.sphere[plr], "vehicle")) do
                    setElementData(v, "vehicle:wypadekStrefa", false)
                end
                destroyElement(s_main.sphere[plr])
            end

            exports.nrpg_interface:showPlayerNotification(plr, 'Strefa utrudnień została usunięta', 'success') 
        end
    end
end
addCommandHandler("utrudnienia", s_main.wypadekCommand)


s_main.quitPlayer = function(quitType)
    plr = source

	if isElement(s_main.blips[plr]) then
        destroyElement(s_main.blips[plr])
    end

    if isElement(s_main.sphere[plr]) then
        for i,v in ipairs(getElementsWithinColShape(s_main.sphere[plr], "vehicle")) do
            setElementData(v, "vehicle:wypadekStrefa", false)
        end
        destroyElement(s_main.sphere[plr])
    end
end
addEventHandler("onPlayerQuit", root, s_main.quitPlayer)

s_main.changeData = function(theKey, oldValue, newValue)
    plr = source

    if theKey == "player:faction" then
        if newValue == false then
            if isElement(s_main.blips[plr]) then
                destroyElement(s_main.blips[plr])
            end
        
            if isElement(s_main.sphere[plr]) then
                for i,v in ipairs(getElementsWithinColShape(s_main.sphere[plr], "vehicle")) do
                    setElementData(v, "vehicle:wypadekStrefa", false)
                end
                destroyElement(s_main.sphere[plr])
            end
        end
    end
end
addEventHandler("onElementDataChange", root, s_main.changeData)