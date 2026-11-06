addCommandHandler("mandat", function(plr, cmd, target, kwota, powod)
if getElementData(plr, "player:faction") == "SAPD" then 

if not target and not kwota and not powod then
exports.nrpg_interface:showPlayerNotification(plr, "/mandat [id/nick] [kwota] [powod]", "error", 3000)
return
end

local cel = exports["nrpg_core"]:findPlayer(plr, target)
if not cel then
exports.nrpg_interface:showPlayerNotification(plr, "Nie znaleziono podanego gracza", "error", 3000)
return
end

if not kwota then
exports.nrpg_interface:showPlayerNotification(plr, "Wpisz kwotę (0 - 10,000,000 PLN)", "error", 3000)
return
end

if not powod then
exports.nrpg_interface:showPlayerNotification(plr, "Podaj powod", "error", 3000)
return
end

if not tonumber(kwota) then
exports.nrpg_interface:showPlayerNotification(plr, "Podana kwota musi być liczbą", "error", 3000)
return
end

if getElementData(cel, "player:sid") == getElementData(plr, "player:sid") then 
exports.nrpg_interface:showPlayerNotification(plr, "Nie możesz wystawić mandatu sam sobie", "error", 3000)
return
end

local x2,y2,z2 = getElementPosition(cel)
local x,y,z = getElementPosition(plr)
local name = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
local name2 = getPlayerName(cel):gsub("#%x%x%x%x%x%x","")

if (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 20) then

if tonumber(kwota) > 10000000 or tonumber(kwota) < 0 then
exports.nrpg_interface:showPlayerNotification(plr, "Wpisz kwotę (0 - 10,000,000 PLN)", "error", 3000)
return
end

if getPlayerMoney(cel) > tonumber(kwota) then

outputChatBox(" ", cel, 255, 255, 255, true)
outputChatBox("#ffff00"..name.."#cccccc nakłada na ciebie mandat w wysokości #ffff00"..tonumber(kwota).."#cccccc PLN#ffffff.", cel, 255, 255, 255, true)
outputChatBox("#ccccccPowód: #ffff00"..powod.."", cel, 255, 255, 255, true)
outputChatBox(" ", cel, 255, 255, 255, true)

outputChatBox(" ", plr, 255, 255, 255, true)
outputChatBox("#ccccccNakładasz mandat w wysokości #ffff00"..tonumber(kwota).."#cccccc PLN na gracza #ffff00"..name2.."#ffffff.", plr, 255, 255, 255, true)
outputChatBox("#ccccccPowód: #ffff00"..powod.."#ffffff", plr, 255, 255, 255, true)
outputChatBox(" ", plr, 255, 255, 255, true)
outputChatBox("#ccccccDodatkowo otrzymujesz #ffff002000000 #ccccccPLN za wystawienie mandatu#ffffff.", plr, 255, 255, 255, true)
outputChatBox(" ", plr, 255, 255, 255, true)

takePlayerMoney(cel, tonumber(kwota))
givePlayerMoney(plr, 2000000)
else
    exports.nrpg_interface:showPlayerNotification(plr, "Gracz nie posiada danej kwoty", "error", 3000)
end
end
else
exports.nrpg_interface:showPlayerNotification(plr, "Nie pracujesz w SAPD", "error", 3000)
return
end
end)



