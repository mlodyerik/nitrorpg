

function dxDrawBorderedText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak,postGUI)
	for oX = -3, 3 do 
		for oY = -3, 3 do 
			dxDrawText(text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak,postGUI) 
		end 
	end 
	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI) 
end

local tempo = {}
function muza ()
	local sound = playSound ("jd.mp3")
	local screenX, screenY = guiGetScreenSize()
	local screenX = screenX/2
	local screenY = screenY/2
	tempo[localPlayer] = 0
	function jebacdisa()
		dxDrawBorderedText ("Ukryta Komenda", screenX-351, screenY-71, 100, 100, tocolor (150, 100, 0, 255), 3, "pricedown")
		dxDrawBorderedText ("Haker pesudoli", screenX-161, screenY, 100, 100, tocolor (255, 255, 255, 255), 3, "pricedown")
	end
	addEventHandler("onClientRender", getRootElement(), jebacdisa)
	setTimer (function()
		tempo[localPlayer] = tempo[localPlayer]+1
		if tempo[localPlayer] == 5 then
			removeEventHandler ("onClientRender", getRootElement(), jebacdisa)
		end
	end, 1000, 5)
end
addEvent("ukryte", true)
addEventHandler("ukryte", getRootElement(), muza)
addCommandHandler ("losuj", muza)
addCommandHandler ("hania", muza)
addCommandHandler ("hania2", muza)