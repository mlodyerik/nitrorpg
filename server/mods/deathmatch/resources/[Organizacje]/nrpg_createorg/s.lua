addEvent("createOrganization", true)
addEventHandler("createOrganization", root, function(plr, name, tag)
if plr and name and tag then
local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE code=? AND uid=? LIMIT 1;", name, getElementData(plr,"player:sid")) 
if #result > 0 then exports.nrpg_interface:showPlayerNotification(plr, "Taka organizacja juz istnieje", "error") return end
local create = exports['nrpg_db']:dbSet('insert into pystories_organizacje (code, login, uid, aktywny, rank, tag) values(?,?,?,now(),5,?)', tostring(name), getPlayerName(plr):gsub("%x%x%x%x%x%x",""), getElementData(plr,'player:sid'), tag)
local create2 = exports['nrpg_db']:dbSet('insert into pystories_organizacje_info (nazwa, zalozyciel, utworzona, tag) values(?,?,now(),?)', tostring(name), getPlayerName(plr):gsub("%x%x%x%x%x%x",""), tag)


setElementData(plr, "player:organization", name)
setElementData(plr, "player:organizationtag", tag)
takePlayerMoney(plr, 10000000)
exports.nrpg_interface:showPlayerNotification(plr, "Założono organizacje "..name.." o tagu "..tag.."", "info")
end
end)