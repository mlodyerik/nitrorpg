main = {

    ["markers"] = {

        {"SF", -1903.50, -858.61, 36.02, {0, 100000000}, {-1909.28, -971.26, 31.18, 40.99, 230.03, 3.37}},

    },

    ["markersList"] = {},
    ["cuboidList"] = {},
    ["blipList"] = {},
    ["actualPlayerMarker"] = nil,
    ["guiData"] = {

        ["libary"] = exports.nrpg_lib,
        ["toggleGUI"] = false,
    },

    ["exchangeInformations"] = "Po wystawieniu pojazdu każda osoba może kupić\ngo bez twojej wiedzy, za pomyłki administracja\nnie ponosi odpowiedzialności\n\nReklamowanie innych serwerów, stron etc.\nw dodatkowych informacjach o pojeździe\nkarane jest banem na zawsze",

}

main["guiData"]["interface"] = {

    ["backgroundRectangle"] = main["guiData"]["libary"]:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(15, 15, 25, 255)),

}

zoom = exports["nrpg_interface"]:getInterfaceZoom()

main.exchangeUI = function()
    dxDrawImage( 675/zoom, 325/zoom, 530/zoom, 500/zoom, main["guiData"]["interface"]["backgroundRectangle"], 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("GIEŁDA "..main["markers"][main["actualPlayerMarker"]][1], 600/zoom, 350/zoom, 1300/zoom, 500/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "top")
    --dxDrawText("INFORMACJE", 600/zoom, 400/zoom, 1850/zoom, 500/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "top")
    --dxDrawText(main["exchangeInformations"].."\n\nCena minimalna: #5dff54"..convertNumber(main["markers"][main["actualPlayerMarker"]][5][1]).." PLN#ffffff\nCena maksymalna: #5dff54"..convertNumber(main["markers"][main["actualPlayerMarker"]][5][2]).." PLN#ffffff", 600/zoom, 430/zoom, 1850/zoom, 500/zoom, tocolor(255, 255, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, false, true)

    exports["nrpg_buttons"]:dxCreateButton("Wystaw pojazd", 555/zoom, 710/zoom, 400/zoom, 40/zoom, 1, {55, 155, 55})
    exports["nrpg_buttons"]:dxCreateButton("Anuluj", 555/zoom, 760/zoom, 400/zoom, 40/zoom, 2, {155, 55, 55})
end

main.destroyEditbox = function()
    exports["nrpg_interface"]:destroyCustomEditbox('exchange:cost')
    exports["nrpg_interface"]:destroyCustomEditbox('exchange:info')
end

main.markerHit = function(el)
    if el == localPlayer and getPedOccupiedVehicle(localPlayer) then
        local markerID = tonumber(getElementData(source, "marker:sellingcar"))

        if markerID and getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:id") then
            if getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:ownedPlayer") == getElementData(localPlayer, "player:sid") then
                main["guiData"]["toggleGUI"] = true
                main["actualPlayerMarker"] = markerID
                addEventHandler("onClientRender", root, main.exchangeUI)
                addEventHandler("onClientClick", root, main.guiClick)
                exports["nrpg_interface"]:createCustomEditbox('exchange:cost', 'Cena pojazdu', 700/zoom, 420/zoom, 300/zoom, 50/zoom, false, "", false, {55, 155, 55})
                exports["nrpg_interface"]:createCustomEditbox('exchange:info', 'Dodatkowe informacje', 700/zoom, 480/zoom, 300/zoom, 50/zoom, false, "", false, {0, 85, 225})
                showCursor(true)
            end
        end
    end
end

main.markerLeave = function(el)
    if el == localPlayer then
        main["actualPlayerMarker"] = nil
        main["guiData"]["toggleGUI"] = false
        removeEventHandler("onClientRender", root, main.exchangeUI)
        removeEventHandler("onClientClick", root, main.guiClick)
        main.destroyEditbox()
        showCursor(false)
    end
end

main.shapeLeave = function(el)
    if el == localPlayer then
        if getPedOccupiedVehicle(localPlayer) and getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:gielda") then
            setElementData(getPedOccupiedVehicle(localPlayer), "vehicle:desc", false)
            setElementData(getPedOccupiedVehicle(localPlayer), "vehicle:gielda", false)
            exports.nrpg_interface:showPlayerNotification("Opuszczasz teren giełdy", "info")
        end
    end
end

main.guiClick = function(btn,state)
    if btn == "left" and state == "up" then
        if isMouseIn(555/zoom, 710/zoom, 400/zoom, 40/zoom) then
            local cost = exports['nrpg_interface']:getCustomEditboxText('exchange:cost')
            local desc = exports['nrpg_interface']:getCustomEditboxText('exchange:info')

            if tonumber(cost) then
                local cost = tonumber(cost)
                if cost > main["markers"][main["actualPlayerMarker"]][5][2] then exports.nrpg_interface:showPlayerNotification("Cena jest zbyt wysoka", "error") return end
                if cost < main["markers"][main["actualPlayerMarker"]][5][1] then exports.nrpg_interface:showPlayerNotification("Cena jest zbyt niska", "error") return end

                triggerServerEvent("wystawPojazd", localPlayer, localPlayer, getPedOccupiedVehicle(localPlayer), cost, (desc or "Brak"))
                showCursor(false)
                main["actualPlayerMarker"] = nil
                main["guiData"]["toggleGUI"] = false
                removeEventHandler("onClientRender", root, main.exchangeUI)
                removeEventHandler("onClientClick", root, main.guiClick)
                main.destroyEditbox()
            end
        elseif isMouseIn(555/zoom, 760/zoom, 400/zoom, 40/zoom) then
            showCursor(false)
            main["actualPlayerMarker"] = nil
            main["guiData"]["toggleGUI"] = false
            removeEventHandler("onClientRender", root, main.exchangeUI)
            removeEventHandler("onClientClick", root, main.guiClick)
            main.destroyEditbox()
        end
    end
end

main.startScript = function()
    for i,v in ipairs(main["markers"]) do
        main["markersList"][i] = createMarker(v[2], v[3], v[4]-5, "cylinder", 5, 255, 255, 0, 55)
        main["cuboidList"][i] = createColCuboid(v[6][1], v[6][2], v[6][3], v[6][4], v[6][5], v[6][6])
        main["blipList"][i] = createBlip(v[2], v[3], v[4], 55, 2, 55, 255, 55, 255, 0, 450)
        setElementData(main["markersList"][i], "marker:sellingcar", i)
    
        addEventHandler("onClientMarkerHit", main["markersList"][i], main.markerHit)
        addEventHandler("onClientMarkerLeave", main["markersList"][i], main.markerLeave)
        addEventHandler("onClientColShapeLeave", main["cuboidList"][i], main.shapeLeave)
    end
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

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end