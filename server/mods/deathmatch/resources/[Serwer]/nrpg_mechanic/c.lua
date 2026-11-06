zoom = 1
sW, sH = guiGetScreenSize()
if sW < 1920 then
    zoom = math.min(2, 1920 / sW)
end

main = {

    mechanicPositions = {

    },

    toggleMechanic = false,
    getLib = exports.nrpg_lib,
    theVehicle = nil,

}

interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(25, 25, 25, 255)),
    backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(35, 35, 35, 255)),
    backgroundRectangle3 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(100, 100, 100, 255)),
    backgroundRectangle4 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(255, 175, 0, 255)),
    buttonRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(125, 125, 125, 255)),
    scrollRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
    scrollRectangle2 = main.getLib:dgsCreateRoundRect({{3,false},{3,false},{3,false},{3,false}},tocolor(255, 175, 0, 255)),

}

doFixed = {

	{"Silnik", 1, fn=function(veh) if getElementHealth(veh)>=1000 then return true end; return false end}, 
	{"Maska", 2, fn=function(veh) if getVehicleDoorState(veh, 0)==0 then return true end; return false end},
	{"Bagażnik", 3, fn=function(veh) if getVehicleDoorState(veh, 1)==0 then return true end; return false end},
	{"Drzwi lewy przód", 4, fn=function(veh) if getVehicleDoorState(veh, 2)==0 then return true end; return false end},
	{"Drzwi prawy przód", 5, fn=function(veh) if getVehicleDoorState(veh, 3)==0 then return true end; return false end},
	{"Drzwi lewy tył", 6, fn=function(veh) if getVehicleDoorState(veh, 4)==0 then return true end; return false end},
	{"Drzwi prawy tył", 7, fn=function(veh) if getVehicleDoorState(veh, 5)==0 then return true end; return false end},
	{"Szyba przednia", 8, fn=function(veh) if getVehiclePanelState(veh, 4)==0 then return true end; return false end},
	{"Zderzak przedni", 9, fn=function(veh) if getVehiclePanelState(veh, 5)==0 then return true end; return false end},
	{"Zderzak tylni", 10, fn=function(veh) if getVehiclePanelState(veh, 6)==0 then return true end; return false end},
	{"Światło lewe przednie", 11, fn=function(veh) if getVehicleLightState(veh, 0)==0 then return true end; return false end},
	{"Światła prawe przednie", 12, fn=function(veh) if getVehicleLightState(veh, 1)==0 then return true end; return false end},
	{"Światła lewe tylnie", 13, fn=function(veh) if getVehicleLightState(veh, 2)==0 then return true end; return false end},
	{"Światła prawe tylnie", 14, fn=function(veh) if getVehicleLightState(veh, 3)==0 then return true end; return false end},

}

doCosts = {150, 45, 35, 65, 65, 95, 95, 80, 80, 85, 85, 100, 45, 45}
selected = {}
selectAll = false
alternativeTable = {}
allCost = 0
vehicleMnoznik = 0

k = 1
n = 9
m = 9


main.renderMechanic = function()
    alternativeTable = {}
    for i,v in pairs(doFixed) do
        if v.fn(getPedOccupiedVehicle(localPlayer)) == false then
            table.insert(alternativeTable, v)
        end
    end

    if #alternativeTable == 0 then
        removeEventHandler("onClientRender", root, main.renderMechanic)
        showCursor(false)
        main.toggleMechanic = false
        main.theVehicle = nil
        selectAll = false
    end

    dxDrawImage(500/zoom, 245/zoom, 895/zoom, 580/zoom, interface.backgroundRectangle4, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(501/zoom, 246/zoom, 893/zoom, 578/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(510/zoom, 255/zoom, 875/zoom, 560/zoom, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(510/zoom, 755/zoom, 875/zoom, 60/zoom, interface.backgroundRectangle3, 0, 0, 0, tocolor(255, 255, 255, 55), false)
    dxDrawText("Część", 215/zoom, 5/zoom, 975/zoom, 560/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, true)  
    dxDrawText("Kwota", 645/zoom, 5/zoom, 980/zoom, 560/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, true)  
    dxDrawText("Łączna kwota naprawy: "..allCost.." PLN", 535/zoom, 1005/zoom, 980/zoom, 560/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, true)  
    exports["nrpg_buttons"]:dxCreateButton("Napraw", 1270/zoom, 770/zoom, 100/zoom, 30/zoom, 1, {25, 144, 255, 255})

    x = 0
    for i,v in pairs(alternativeTable) do
        if i >= k and i <= n then 
            x = x + 1
            offsetY = math.floor(45/zoom)*(x-1)
            offsetY2 = math.floor(offsetY*2)

            if selected[i] then
                dxDrawImage(530/zoom, 305/zoom+offsetY, 820/zoom, 40/zoom, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 65), false)
                dxDrawText(v[1], 575/zoom, 90/zoom+offsetY2, 980/zoom, 560/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
                dxDrawText(doCosts[i]+vehicleMnoznik.." PLN", 790/zoom, 90/zoom+offsetY2, 980/zoom, 560/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
            elseif isMouseIn(530/zoom, 305/zoom+offsetY, 820/zoom, 40/zoom) then
                dxDrawImage(530/zoom, 305/zoom+offsetY, 820/zoom, 40/zoom, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                dxDrawText(v[1], 575/zoom, 90/zoom+offsetY2, 980/zoom, 560/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
                dxDrawText(doCosts[i]+vehicleMnoznik.." PLN", 790/zoom, 90/zoom+offsetY2, 980/zoom, 560/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
            else
                dxDrawImage(530/zoom, 305/zoom+offsetY, 820/zoom, 40/zoom, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)
                dxDrawText(v[1], 575/zoom, 90/zoom+offsetY2, 980/zoom, 560/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
                dxDrawText(doCosts[i]+vehicleMnoznik.." PLN", 790/zoom, 90/zoom+offsetY2, 980/zoom, 560/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "left", "center", false, true)  
            end

            if selected[i] then
                dxDrawImage(535/zoom, 307/zoom+offsetY, 35/zoom, 35/zoom, ":nrpg_userpanel/icons/checkbox_empty.png", 0, 0, 0, tocolor(125, 125, 125, 255), false)
                dxDrawImage(535/zoom, 307/zoom+offsetY, 35/zoom, 35/zoom, ":nrpg_userpanel/icons/checkbox_clicked.png", 0, 0, 0, tocolor(255, 175, 0, 255), false)
            else
                dxDrawImage(535/zoom, 307/zoom+offsetY, 35/zoom, 35/zoom, ":nrpg_userpanel/icons/checkbox_empty.png", 0, 0, 0, tocolor(125, 125, 125, 255), false)
            end 
        end
	end

    if selectAll == true then
        dxDrawImage(535/zoom, 710/zoom, 35/zoom, 35/zoom, ":nrpg_userpanel/icons/checkbox_empty.png", 0, 0, 0, tocolor(125, 125, 125, 255), false)
        dxDrawImage(535/zoom, 710/zoom, 35/zoom, 35/zoom, ":nrpg_userpanel/icons/checkbox_clicked.png", 0, 0, 0, tocolor(255, 175, 0, 255), false)
    else
        dxDrawImage(535/zoom, 710/zoom, 35/zoom, 35/zoom, ":nrpg_userpanel/icons/checkbox_empty.png", 0, 0, 0, tocolor(125, 125, 125, 255), false)
    end
    dxDrawText("Zaznacz wszystko", 575/zoom, 895/zoom, 980/zoom, 560/zoom, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "left", "center", false, true)  

    drawScrollbar(alternativeTable, 1355/zoom, 305/zoom, 395/zoom, m, k)
end

local lastClick = getTickCount()
local clickTimer = 100

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" and main.toggleMechanic == true then
        if lastClick-getTickCount() > 0 then
            return
        end
        lastClick = getTickCount()+clickTimer

        if isMouseIn(535/zoom, 710/zoom, 35/zoom, 35/zoom) then
            if selectAll == false then selected = {}; allCost = 0 end
            for i,v in pairs(alternativeTable) do
                if selectAll == true then
                    if selected[i] then
                        allCost = 0
                        selected[i] = nil
                    end
                else
                    allCost = allCost + doCosts[i]+vehicleMnoznik
                    selected[i] = i
                end
            end
            if selectAll == true then selectAll = false else selectAll = true end
        end

        if isMouseIn(1270/zoom, 770/zoom, 100/zoom, 30/zoom) then
            if getPlayerMoney(localPlayer) > allCost then
                for i,v in pairs(alternativeTable) do
                    if selected[i] then
                        selected[i] = nil
                        allCost = allCost - (doCosts[i]+vehicleMnoznik)
                        triggerServerEvent("fixVehicleMechanic", localPlayer, getPedOccupiedVehicle(localPlayer), v[2], doCosts[i]+vehicleMnoznik)
                    end
                end
                selectAll = false
            else
                exports.nrpg_interface:showPlayerNotification('Nie posiadasz tyle pieniędzy', 'error')
            end
        end

        x = 0
        for i,v in pairs(alternativeTable) do
            if i >= k and i <= n then 
                x = x + 1
                offsetY = math.floor(45/zoom)*(x-1)
                offsetY2 = math.floor(offsetY*2)

                if isMouseIn(530/zoom, 305/zoom+offsetY, 820/zoom, 40/zoom) then
                    if not selected[i] then
                        selected[i] = v[1]
                        allCost = allCost + doCosts[i]+vehicleMnoznik
                    else
                        selected[i] = nil
                        allCost = allCost - (doCosts[i]+vehicleMnoznik)
                    end
                end
            end
        end
    end
end)

main.markerHit = function(el)
    if el == localPlayer and getPedOccupiedVehicle(localPlayer) then
        alternativeTable = {}
        number = 0
        main.theVehicle = getPedOccupiedVehicle(localPlayer)
        for i,v in pairs(doFixed) do
            if v.fn(main.theVehicle) == false then
                number = number + 1
                table.insert(alternativeTable, v)
            end
        end

        if number ~= 0 then
            addEventHandler("onClientRender", root, main.renderMechanic)
            showCursor(true, false)
            main.toggleMechanic = true
            allCost = 0
            selected = {}
            selectAll = false
            vehicleMnoznik = main.getVehicleMnoznik(main.theVehicle)/2
        else
            exports.nrpg_interface:showPlayerNotification('Twój pojazd jest już sprawny', 'error')
        end
    end
end


main.getVehicleMnoznik = function(veh)
    local mnoznik = getVehicleOriginalProperty(veh, "maxVelocity")
    if mnoznik then
        return mnoznik
    end
end

main.markerLeave = function(el)
    if el == localPlayer and getPedOccupiedVehicle(localPlayer) then
        removeEventHandler("onClientRender", root, main.renderMechanic)
        showCursor(false)
        main.toggleMechanic = false
        main.theVehicle = nil
        selectAll = false
        vehicleMnoznik = 0
    end
end

for i, v in ipairs(main.mechanicPositions) do
    local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 3, 200, 25, 25, 255)
    setElementData(marker, "marker:text", "Mechanik")
    setElementData(marker, "marker:downtext", "Tutaj naprawisz swój pojazd")
    setElementData(marker, "marker:icon", "mechanic")

    addEventHandler("onClientMarkerHit", marker, main.markerHit)
    addEventHandler("onClientMarkerLeave", marker, main.markerLeave)
end

bindKey("mouse_wheel_down", "both", function()
    if main.toggleMechanic == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if main.toggleMechanic == true then
        scrollDown()
    end
end)

function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #alternativeTable then return end
    k = k+1
    n = n+1
end

function drawScrollbar(table, x, y, height, m_, k_)
    dxDrawImage(x, y, 8, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)

	if #table > m_ then
    	local scrollbarHeight = height/#table

   		if k_ == 1 then 
        	scrollbarPos = y
    	elseif k_ > 1 then 
        	scrollbarPos = ((k_)*scrollbarHeight)+y
    	end

    	if #table <= m_ then 
        	scrollbarHeight = height
    	end
		
		dxDrawImage(x, scrollbarPos, 8, scrollbarHeight*(m_-1), interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
    else
        dxDrawImage(x, y, 8, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

function getVehicleOriginalProperty( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then -- Make sure there's a valid vehicle and a property string
        local modelID = getElementModel ( element )
        local handlingTable = getOriginalHandling ( modelID ) -- Get the handling as table and save as handlingTable
        local value = handlingTable[property] -- Get the value from the table
        
        if value then -- If there's a value (valid property)
            return value -- Return it
        end
    end
    
    return false -- Not an element, not a vehicle or no valid property string. Return failure
end

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end

    cx,cy = getCursorPosition()
    cx,cy = cx*sW, cy*sH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end