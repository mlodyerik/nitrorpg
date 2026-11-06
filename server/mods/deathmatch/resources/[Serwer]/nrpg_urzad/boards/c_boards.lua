local marker=createMarker(4103.27, 427.72, 214.30-1, "cylinder", 1.2, 255, 255, 0, 55)
setElementDimension(marker, 20)
setElementInterior(marker, 20)
setElementData(marker,'marker:text','Zmiana tablic rejestracyjnych pojazdu')

listgrid = guiCreateGridList(0.28, 0.30, 0.44, 0.27, true)
guiGridListAddColumn(listgrid, "ID", 0.2)
guiGridListAddColumn(listgrid, "Nazwa", 0.5)
guiGridListAddColumn(listgrid, "Tablica", 0.2)
guiSetVisible(listgrid, false)
edit=guiCreateEdit(0.43, 0.65, 0.29, 0.06, "", true)
guiSetVisible(edit, false)


local sx,sy=guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
local w, h = (sx/1440),(sy/900)

function guichujwie()
        exports["buttons"]:createCustomWindow("Zmiana rejestracji", screenW * 0.2726, screenH * 0.2733-10, screenW * 0.4548, screenH * 0.4543+10, tocolor(255, 255, 255, 255), false)        	
        dxDrawText("Poniżej wpisz tekst, który będzie widnieć na rejestracji\nwybranego pojazdu", screenW * 0.4305, screenH * 0.5861, screenW * 0.7180, screenH * 0.6347, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		exports["buttons"]:createCustomButton("Zamknij", screenW * 0.2798, screenH * 0.6524, screenW * 0.1190, screenH * 0.0610, 1)
		exports["buttons"]:createCustomButton("Zmień\n5,000 PLN", screenW * 0.2798, screenH * 0.5819, screenW * 0.1190, screenH * 0.0610, 2)
end

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

addEventHandler("onClientClick", root, function(btn, state)
    if getElementData(localPlayer, "marker:board") then
    if btn == "left" and state == "down" then
    if cursorPosition(screenW * 0.2798, screenH * 0.5819, screenW * 0.1190, screenH * 0.0610) then
    	local selectedRow=guiGridListGetSelectedItem(listgrid)
		local new_board=guiGetText(edit)
		if selectedRow < 0 then return end
		local cost=5000
		if string.len(new_board) < 1 then
			outputChatBox("* Podaj więcej znaków.", 255, 0, 0)
			return
		end
		if string.len(new_board) > 5 then
			outputChatBox("* Podaj mniej znaków.", 255, 0, 0)
			return
		end
		if cost > getPlayerMoney(localPlayer) then
			outputChatBox("* Nie posiadasz tyle gotówki.", 255, 0, 0)
			return
		end
		local id=tostring(guiGridListGetItemText(listgrid, selectedRow, 1))
		local name=tostring(guiGridListGetItemText(listgrid, selectedRow, 2))
		triggerServerEvent("board:new", resourceRoot, id, name, new_board, cost)
    elseif cursorPosition(screenW * 0.2798, screenH * 0.6524, screenW * 0.1190, screenH * 0.0610) then
    	setElementData(localPlayer, "marker:board", false)
        removeEventHandler("onClientRender", root, guichujwie)
        showCursor(false)
    	guiSetVisible(listgrid, false)
        guiSetVisible(edit, false)
        end
    end
end
end)

addEvent("board:refresh", true)
addEventHandler("board:refresh", resourceRoot, function(result)
	guiGridListClear(listgrid)
	for i,v in pairs(result) do
		if string.len(v.plateText) < 1 then v.plateText="Brak" end
		local row=guiGridListAddRow(listgrid)
		guiGridListSetItemText(listgrid, row, 1, v.id, false, false)
		guiGridListSetItemText(listgrid, row, 2, exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), false, false)
		guiGridListSetItemText(listgrid, row, 3, v.plateText or v.id, false, false)
	end
end)

addEventHandler("onClientMarkerHit", marker, function(el,md)
    if el~=localPlayer then return end
        showCursor(true)
        guiSetVisible(listgrid, true)
        guiSetVisible(edit, true)
        setElementData(localPlayer, "marker:board", true)
        addEventHandler("onClientRender", root, guichujwie)
        triggerServerEvent("board:download", resourceRoot, el)
end)