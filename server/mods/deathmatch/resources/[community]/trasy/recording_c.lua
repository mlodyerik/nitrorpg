--[[
	Zasób pobrany z GTAO.pl
	
	Kontakt z autorem:
	- GG: 55893614

	Zakaz udostępniania zasobu na inne strony

	Readme:
	- Aby uruchomić nagrywanie wpisz /trasa.nagrywanie [ilość sekund] / przykład /trasa.nagrywanie 60
	- Aby zakończyć nagrywanie wpisz /trasa.zakoncz / przykład /trasa.zakoncz
]]

-- Variables
local data = {
	points = {},

	timer = nil,
	file = nil,
}

local wm = {}
local sx, sy = guiGetScreenSize()

wm.window = guiCreateWindow(sx*245/1024, sy*180/768, sx*553/1024, sy*374/768, "Nagrywanie trasy", false)
guiWindowSetSizable(wm.window, false)
guiWindowSetMovable(wm.window, false)
guiSetVisible(wm.window, false)

wm.memo = guiCreateMemo(sx*19/1024, sy*31/768, sx*514/1024, sy*259/768, "", false, wm.window)
wm.button = guiCreateButton(sx*133/1024, sy*311/768, sx*296/1024, sy*53/768, "Zamknij", false, wm.window)

-- Functions
function pobieraj()
	if isTimer(data.timer) then
		element = localPlayer

		local veh = getPedOccupiedVehicle(localPlayer)

		if veh then
			local model = getVehicleModel(veh)
			local x,y,z = getElementPosition(veh)
			local rx,ry,rz = getElementRotation(veh)

			p = string.format("{%d, %.02f, %.02f, %.02f, %.02f, %.02f, %.02f},", model, x, y, z, rx, ry, rz)
		else
			local x,y,z = getElementPosition(localPlayer)
			p = string.format("{%.02f, %.02f, %.02f},", x,y,z)
		end

		table.insert(data.points, p)
		outputChatBox("* Pobrano pozycję ...")
	end
end

function rozpocznij()
	plr = localPlayer

	local format = table.concat(data.points,"\n").."\n\n\n\nSkopiuj te kordy do swojej tablicy w LUA"
	
	if format then
		showCursor(true,false)
		guiSetText(wm.memo, format)
		guiSetVisible(wm.window, true)
	end
end

addEventHandler("onClientGUIClick", wm.button, function()
	if not guiGetVisible(wm.window) then return end

	showCursor(false)
	guiSetText(wm.memo, "")
	guiSetVisible(wm.window, false)
end)

addCommandHandler("trasa.zakoncz", function(cmd)
	if not isTimer(data.timer) then
		outputChatBox("* Nie posiadasz aktywnego nagrywania...", 255, 0, 0)
		
		return
	end

	rozpocznij()
	killTimer(data.timer)
	outputChatBox("* Zakończono nagrywanie", 0, 255, 0)
end)

addCommandHandler("trasa.nagrywanie", function(cmd,value)
	if guiGetVisible(wm.window) == true then
		outputChatBox("* Najpierw zamknij okno.", 255, 0, 0)
		
		return
	end

	if not tonumber(value) then
		outputChatBox("* Nie wpisałes(aś) sekund pobierania ...", 255, 0, 0)
		outputChatBox("* Użycie: /trasa.nagrywanie [ilość sekund]", 255, 0, 0)
		
		return
	end

	value = value * 1000

	data.timer = setTimer(pobieraj, value, 0)

	outputChatBox("* Rozpocząłeś(aś) nagrywanie trasy, po ukończeniu nagrywania pokaże się okno z pobranymi kordami.", 0, 255, 0)
	outputChatBox("* Aby zakończyć nagrywanie wpisz /trasa.zakoncz", 0, 255, 0)
end)