local marker=createMarker(4098.47, 427.74, 214.30-1, "cylinder", 1.2, 255, 255, 0, 55)
setElementDimension(marker, 20)
setElementInterior(marker, 20)
setElementData(marker,'marker:text','Przepisywanie pojazdów\nna organizacje')



function cursorPosition(x, y, w, h) 
if (not isCursorShowing()) then 
return false 
end 
local mx, my = getCursorPosition() 
local fullx, fully = guiGetScreenSize() 
cursorx, cursory = mx*fullx, my*fully 
if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then 
return true 
else 
return false 
end 
end 

local screenW, screenH = guiGetScreenSize()

gridlist = guiCreateGridList(0.28, 0.29, 0.44, 0.33, true)
guiGridListAddColumn(gridlist, "ID", 0.2)
guiGridListAddColumn(gridlist, "Nazwa", 0.2)
guiGridListAddColumn(gridlist, "Organizacja", 0.3)
guiSetVisible(gridlist, false)


function gui()
		exports["buttons"]:createCustomWindow("Przepisywanie pojazdów", screenW * 0.2726, screenH * 0.2733-25, screenW * 0.4548, screenH * 0.4543+25, tocolor(255, 255, 255, 255), false)

       	exports["buttons"]:createCustomButton("Zamknij", screenW * 0.4268, screenH * 0.6390, screenW * 0.1369, screenH * 0.0638, 1)
       	exports["buttons"]:createCustomButton("Przepisz/Wypisz", screenW * 0.2839, screenH * 0.6390, screenW * 0.1369, screenH * 0.0638, 2)
end

addEventHandler("onClientClick", root, function(btn, state)
    if getElementData(localPlayer, "marker:przepis") then
    if btn == "left" and state == "down" then
    if cursorPosition(screenW * 0.2839, screenH * 0.6390, screenW * 0.1369, screenH * 0.0638) then
    	local selectedRow=guiGridListGetSelectedItem(gridlist)
		if selectedRow < 0 then return end
		local id=tostring(guiGridListGetItemText(gridlist, selectedRow, 1))
		local name=tostring(guiGridListGetItemText(gridlist, selectedRow, 2))
		triggerServerEvent("org:check", resourceRoot, id, name)
    elseif cursorPosition(screenW * 0.4268, screenH * 0.6390, screenW * 0.1369, screenH * 0.0638) then
        removeEventHandler("onClientRender", root, gui)
        setElementData(localPlayer, "marker:przepis", false)
        showCursor(false)
        guiSetVisible(gridlist, false)
        end
    end
end
end)
 
addEvent("org:refresh", true)
addEventHandler("org:refresh", resourceRoot, function(result)
	guiGridListClear(gridlist)
	for i,v in pairs(result) do
		if string.len(v.plateText) < 1 then v.plateText="Brak" end
		local row=guiGridListAddRow(gridlist)
		if tostring(v.ownedGroup) == "0" then v.ownedGroup = "Brak" end
		guiGridListSetItemText(gridlist, row, 1, v.id, false, false)
		guiGridListSetItemText(gridlist, row, 2, exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), false, false)
		guiGridListSetItemText(gridlist, row, 3, v.ownedGroup , false, false)
	end
end)

addEventHandler("onClientMarkerHit", marker, function(el,md)
    if el~=localPlayer then return end
	if not getElementData(el,"player:organization") then return end
    if not guiGetVisible(gridlist) then
        showCursor(true)
        guiSetVisible(gridlist, true)
        addEventHandler("onClientRender", root, gui)
        setElementData(el, "marker:przepis", true)
        triggerServerEvent("org:download", resourceRoot, el)
    end
end)