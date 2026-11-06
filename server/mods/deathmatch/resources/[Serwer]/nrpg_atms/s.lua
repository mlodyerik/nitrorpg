addEvent("showBankMoney", true)
addEventHandler("showBankMoney", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_users WHERE id=?", player_sid)
	triggerClientEvent(client, "clientBankMoney", client, spr[1].bank_money)
end)

addEvent("showBankHistory", true)
addEventHandler("showBankHistory", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from logi_bankomat WHERE sid=? order by data desc", player_sid)
	triggerClientEvent(client, "clientBankHistory", client, spr)
end)

addEvent("amtOperation", true)
addEventHandler("amtOperation", resourceRoot, function(amount)
	if amount > 0 and amount > getPlayerMoney(client) then return end
	local player_sid = getElementData(client, "player:sid")
	if not player_sid then return end
	if not tonumber(amount) then return end

	if exports["nrpg_antycheat"]:checkAccount(client) == true then return end

	amount = math.floor(amount)
	if amount > 0 then
		if getPlayerMoney(client)<amount then return end
		takePlayerMoney(client, amount)
		exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money+"..(tonumber(amount) or 0).." WHERE id="..tonumber(player_sid).." LIMIT 1")
		outputChatBox("✓#FFFFFF Wpłaciłeś/aś "..(tonumber(amount) or 0).." PLN do bankomatu", client, 0, 255, 0, true)
		exports["nrpg_db"]:dbSet("INSERT INTO logi_bankomat SET sid=?, serial=?, ile=?, typ=?", getElementData(client, "player:sid"), getPlayerSerial(client), amount, "+")
	elseif amount<0 then
		local sr=exports["DB2"]:pobierzWyniki("SELECT `bank_money` FROM `pystories_users` WHERE id="..tonumber(player_sid).." LIMIT 1")
		if not sr or not sr.bank_money then return end
		sr.bank_money=tonumber(sr.bank_money)
		if (sr.bank_money<math.abs(amount)) then
			outputChatBox("✘#ffffff Nie posiadasz środków na koncie!", client, 255, 0, 0, true)
			return
		end
		outputChatBox("✓#FFFFFF Wypłaciłeś/aś "..math.abs(tonumber(amount)).." PLN z bankomatu", client, 0, 255, 0, true)
		exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money-"..math.abs(tonumber(amount)).." WHERE id="..tonumber(player_sid).." LIMIT 1")
		exports["nrpg_db"]:dbSet("INSERT INTO logi_bankomat SET sid=?, serial=?, ile=?, typ=?", getElementData(client, "player:sid"), getPlayerSerial(client), amount, "-")
		givePlayerMoney(client, math.abs(amount))	
	end
end)