addEventHandler("onPlayerConnect", resourceRoot, function(_, _, _, serial)
    local query = exports["nrpg_db"]:dbGet("select * from pystories_whitelist where serial=?", serial)
    if query and #query < 1 then cancelEvent(true, "Nie jesteś wpisany/a na whiteliste!\nStart serwera już niedługo!")
    end
end)

addCommandHandler("whitelist.dodaj", function(plr, cmd, serial)
if exports["nrpg_admin"]:getAdmin(plr, 5) or exports["nrpg_admin"]:getAdmin(plr, 4) then
    if not serial then exports.nrpg_interface:showPlayerNotification(plr, "/whitelist.dodaj [serial]", "error", 3000)  return end
    local query = exports["nrpg_db"]:dbSet("INSERT INTO pystories_whitelist (serial) VALUES (?)", serial)
        if query then 
            exports.nrpg_interface:showPlayerNotification(plr, "Dodano serial ("..serial..") na whiteliste!", "success", 3000) 
        end
    end
end)

addCommandHandler("whitelist.usun", function(plr, cmd, serial)
if exports["nrpg_admin"]:getAdmin(plr, 5) then
    if not serial then exports.nrpg_interface:showPlayerNotification(plr, "/whitelist.usun [serial]", "error", 3000)  return end
        local query = exports["nrpg_db"]:dbGet("select * from pystories_whitelist where serial=?", serial)
        if #query > 1 then 
            exports['nrpg_db']:dbSet("DELETE from pystories_whitelist WHERE serial=?", serial)
            exports.nrpg_interface:showPlayerNotification(plr, "Usunięto serial ("..serial..") z whitelisty!", "success", 3000) 
        end
    end
end)