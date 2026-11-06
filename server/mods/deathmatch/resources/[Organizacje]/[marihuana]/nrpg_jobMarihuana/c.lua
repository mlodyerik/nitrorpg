sw, sh = guiGetScreenSize()
local zoom = 1
if sw < 1920 then
    zoom = math.min(2, 1920 / sw)
end

local getLib = exports.nrpg_lib

interface = {

    backgroundRectangle = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 25, 255)),
    scrollRectangle = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(30, 30, 50, 255)),

}

currentShape = nil

renderShapeInfo = function()
    local shapeInfo = getElementData(currentShape, "shape:info")

    if shapeInfo then
        dxDrawImage(705/zoom, 355/zoom, 465/zoom, 400/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(709/zoom, 359/zoom, 457/zoom, 392/zoom, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("KRZAK MARIHUANY", 905/zoom, 355/zoom, 965/zoom, 400/zoom, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, false, false)
        if shapeInfo.stan == 100 then
            dodatek = "Gotowy do zbioru"
        else
            dodatek = "Niegotowy"
        end
        if getElementData(localPlayer, "player:level") == 5 or getElementData(localPlayer, "player:level") == 4 then
            ownerDodatek = "\nWłaściciel krzaka: SID "..shapeInfo.owner..""
        else
            ownerDodatek = ""
        end
        dxDrawText("Stan: "..shapeInfo.stan.."%"..ownerDodatek.."\n"..dodatek, 905/zoom, 455/zoom, 965/zoom, 400/zoom, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "center", "top", false, false, false, false, false)

        if getElementData(localPlayer, "player:sid") == shapeInfo.owner then
            exports['nrpg_buttons']:dxCreateButton("Zbierz", 865/zoom, 625/zoom, 150/zoom, 40/zoom, 1, {55, 155, 55}, "light") 
        else
            exports['nrpg_buttons']:dxCreateButton("Zbierz", 865/zoom, 625/zoom, 150/zoom, 40/zoom, 1, {80, 80, 130}, "light") 
        end
        exports['nrpg_buttons']:dxCreateButton("Anuluj", 865/zoom, 670/zoom, 150/zoom, 40/zoom, 3, {155, 55, 55}, "light") 

        if getElementData(localPlayer, "player:level") == 5 or getElementData(localPlayer, "player:level") == 4 or getElementData(localPlayer, "player:faction") == "SAPD" then
            exports['nrpg_buttons']:dxCreateButton("Usuń", 720/zoom, 670/zoom, 100/zoom, 40/zoom, 4, {155, 55, 55}, "light") 
        end
    end
end

clickEvent = function(btn, state)
    if btn == 'left' and state == 'down' and currentShape then
        if isPedDead(localPlayer) then return end
        
        if isMouseIn(865/zoom, 625/zoom, 150/zoom, 40/zoom) then
            local shapeInfo = getElementData(currentShape, "shape:info")

            if getElementData(localPlayer, "player:sid") == shapeInfo.owner then
                if shapeInfo.stan == 100 then
                    triggerServerEvent("zbierzKrzak", localPlayer, localPlayer, shapeInfo.id)

                    removeEventHandler("onClientRender", root, renderShapeInfo)
                    removeEventHandler("onClientClick", root, clickEvent)
                    showCursor(false)
                    currentShape = nil
                else
                    exports.nrpg_interface:showPlayerNotification('Ten krzak nie jest gotowy do zebrania', 'error')
                end
            else
                exports.nrpg_interface:showPlayerNotification('To nie twój krzak', 'error')
            end
        elseif isMouseIn(865/zoom, 670/zoom, 150/zoom, 40/zoom) then
            removeEventHandler("onClientRender", root, renderShapeInfo)
            removeEventHandler("onClientClick", root, clickEvent)
            showCursor(false)
            currentShape = nil
        elseif isMouseIn(720/zoom, 670/zoom, 100/zoom, 40/zoom) then
            if getElementData(localPlayer, "player:level") == 5 or getElementData(localPlayer, "player:level") == 4 or getElementData(localPlayer, "player:faction") == "SAPD" then
                local shapeInfo = getElementData(currentShape, "shape:info")

                if shapeInfo then
                    triggerServerEvent("usunKrzak", localPlayer, localPlayer, shapeInfo.id, shapeInfo.owner)
                    removeEventHandler("onClientRender", root, renderShapeInfo)
                    removeEventHandler("onClientClick", root, clickEvent)
                    showCursor(false)
                    currentShape = nil
                end
            end
        end     
    end
end
    
function marihuanaOpenGUI(el)
    if el == localPlayer then
        if getPedOccupiedVehicle(localPlayer) then return end

        if not isEventHandlerAdded("onClientRender", root, renderShapeInfo) then
            addEventHandler("onClientRender", root, renderShapeInfo)
        end

        if not isEventHandlerAdded("onClientClick", root, clickEvent) then
            addEventHandler("onClientClick", root, clickEvent)
        end
        
        showCursor(true)
        currentShape = source
    end
end
addEventHandler("onClientColShapeHit", resourceRoot, marihuanaOpenGUI)

function marihuanaCloseGUI(el)
    if el == localPlayer then
        removeEventHandler("onClientRender", root, renderShapeInfo)
        removeEventHandler("onClientClick", root, clickEvent)
        showCursor(false)
        currentShape = nil
    end
end
addEventHandler("onClientColShapeLeave", resourceRoot, marihuanaCloseGUI)

isMouseIn = function(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*sw,cy*sh
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

isEventHandlerAdded = function( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
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