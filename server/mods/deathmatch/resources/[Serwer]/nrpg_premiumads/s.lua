theTimer = setTimer(function()
	for i, v in pairs(getElementsByType("player")) do
		setElementData(v, "ogloszenie:timer", false)
	end
end, 60000, 0)
for i, v in pairs(getElementsByType("player")) do
	setElementData(v, "ogloszenie:timer", false)
end

addCommandHandler("ogloszenie", function(plr, _, ...)
	if getElementData(plr,"player:premium") or getElementData(plr,"player:premiumplus") then
		local mute = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_punish WHERE type=? AND active=1 AND serial=? AND time>NOW() LIMIT 1;", "mute", getPlayerSerial(plr))
		if mute and #mute > 0 then
			return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
		end
	remaining, executesRemaining, totalExecutes = getTimerDetails(theTimer)
	if getElementData(plr, "ogloszenie:timer") == true then exports.nrpg_interface:showPlayerNotification(plr, "Ogłoszenie możesz wysyłać za "..math.floor(remaining/1000).." sekund!", "error") return end
	if not ... then exports.nrpg_interface:showPlayerNotification(plr, 'Użyj: /ogloszenie [wiadomość]', "error") return end
	local text=table.concat({...}, " ")
	if text:len() < 3 or text:len() > 70 then
		exports.nrpg_interface:showPlayerNotification(plr, "Ogłoszenie powininno zawierać od 3 do 14 znaków!", "error")
	return end
	triggerClientEvent(root, "show_ads", resourceRoot, plr, text)
	setElementData(plr, "ogloszenie:timer", true)
	else
		exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz premium/premium+", "error")
	end
end)