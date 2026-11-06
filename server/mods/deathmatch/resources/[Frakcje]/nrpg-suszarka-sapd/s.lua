addEvent("pobierzwlasciciela", true)
addEventHandler("pobierzwlasciciela", root, function(el)
if not el then return end
local id = getElementData(el,"vehicle:id")
if not id then return end
local result = exports['pystories-db']:dbGet("SELECT pystories_vehicles.*,pystories_users.login FROM pystories_vehicles left join pystories_users on pystories_users.id=pystories_vehicles.ownedPlayer WHERE pystories_vehicles.id=?",id)
if not result or #result < 1 then return end
local owner = result[1].login
triggerClientEvent(client,"wczytajwlasciciela",resourceRoot,owner)
end)