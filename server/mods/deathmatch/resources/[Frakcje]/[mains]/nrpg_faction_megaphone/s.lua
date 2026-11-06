function globalMessage(plr, cmd, ...)
if getElementData(plr, "player:faction") == "SAPD" or getElementData(plr, "player:faction") == "SAFD" then
local x, y, z = getElementPosition(plr)
local strefa = createColSphere(x, y, z, 40)
local players = getElementsWithinColShape(strefa, 'player')
local wiadomosc = table.concat({...}, " ")

for i,v in pairs(players) do
local id = getElementData(plr, "id")
local name = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
outputChatBox("#71BDFF*MEGAFON*#ffffff "..name..": #C0C0C0"..wiadomosc:gsub("#%x%x%x%x%x%x","").."#ffffff #71BDFF*MEGAFON*#ffffff", v, 255, 255, 255, true)
if isElement(strefa) then
	destroyElement(strefa)
	blip = nil
end
end
else
end
end
addCommandHandler("Megafon", globalMessage)

addEventHandler("onResourceStart", root, function() 
	local players = getElementsByType('player')
	for _,v in pairs(players) do
		bindKey(v, "m", "down", "chatbox", "Megafon")
	end
end)