addEvent("onClientBuyDiler", true)
addEventHandler("onClientBuyDiler", root, function(plr, id, name, cost, type, legal)
    if id and name and cost and type and legal then
        local result_buy = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE item=? AND sid=?", name, getElementData(plr, "player:sid"))
        if cost > getPlayerMoney(plr) then exports.nrpg_interface:showPlayerNotification(plr, 'Nie posidasz tyle pieniędzy', 'error') return end

        if #result_buy > 0 then
            exports["nrpg_db"]:dbSet("UPDATE pystories_ekwipunek SET ilosc=ilosc+? WHERE item=? AND sid=?", 1, name, getElementData(plr, "player:sid"))
            takePlayerMoney(plr, cost)
            exports.nrpg_interface:showPlayerNotification(plr, 'Zakupiłeś/aś '..name, 'success')
        elseif #result_buy == 0 then
            exports["nrpg_db"]:dbSet("INSERT INTO pystories_ekwipunek SET ilosc=?, legal=?, item=?, type=?, sid=?", 1, legal, name, type, getElementData(plr, "player:sid"))
            takePlayerMoney(plr, cost)
            exports.nrpg_interface:showPlayerNotification(plr, 'Zakupiłeś/aś '..name, 'success')
        end
    end
end)

addEvent("onClientDilerInfo", true)
addEventHandler("onClientDilerInfo", root, function(plr)
    if plr then
        local player_sid = getElementData(plr, "player:sid")
	    local spr = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE item=? AND sid=?", "Marihuana", player_sid)
        if #spr > 0 then
	        triggerClientEvent(plr, "clientDilerInfo", plr, spr[1].ilosc)
        else
            triggerClientEvent(plr, "clientDilerInfo", plr, 0)
        end
    end
end)

addEvent("onClientSellDiler", true)
addEventHandler("onClientSellDiler", root, function(plr, id, name, cost, type, legal)
    if id and name and cost and type and legal then
        local result_sell = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_ekwipunek WHERE item=? AND sid=?", name, getElementData(plr, "player:sid"))

        if #result_sell > 0 then
            if tonumber(result_sell[1].ilosc) > 0 then
                exports['nrpg_db']:dbSet("DELETE from pystories_ekwipunek WHERE item=? AND sid=?", name, getElementData(plr, "player:sid"))
                givePlayerBankMoney(plr, tonumber(result_sell[1].ilosc)*cost)
                exports.nrpg_interface:showPlayerNotification(plr, 'Sprzedałeś/aś '..name..' ('..tonumber(result_sell[1].ilosc)..'g) za '..(result_sell[1].ilosc*cost)..' PLN', 'success')
            end
        end
    end
end)

function givePlayerBankMoney(plr, value)
    if not tonumber(value) then return end

    if getElementData(plr, "player:sid") then
        local value = tonumber(value)

        if value and value > 0 then
            exports["nrpg_db"]:dbSet("UPDATE pystories_users SET bank_money=bank_money+? WHERE id=? LIMIT 1", value, getElementData(plr, "player:sid"))
        end
    end
end