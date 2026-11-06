addEvent("onClientBuyShop", true)
addEventHandler("onClientBuyShop", root, function(plr, id, name, cost, type, legal)
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