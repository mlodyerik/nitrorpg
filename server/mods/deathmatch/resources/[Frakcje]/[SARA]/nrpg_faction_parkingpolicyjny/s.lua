
local oddanie = createMarker(998.35, -1459.43, 13.55-0.9,"cylinder",5,255,255,0,55)


setElementData(oddanie,"marker:text","Parking policyjny")
setElementData(oddanie,"marker:downtext","Punkt oddania pojazdu")


addEventHandler("onMarkerHit",oddanie,function(el,md)
if getElementType(el) ~= "player" then return end
local veh = getPedOccupiedVehicle(el)
if not veh then return end
if veh and getElementModel(veh) ~= 525 and getElementModel(veh) ~= 578 then return end
local duty = getElementData(el,"player:faction")
if not duty then return end
local tow = getVehicleTowedByVehicle(veh) or getElementData(veh, "zaladowane")
if not tow or tow1 then return end
triggerClientEvent(el,"glownyparking:refresh",root,tow)
end)
addEventHandler("onMarkerLeave",oddanie,function(el,md)
if getElementType(el) ~= "player" then return end
local veh = getPedOccupiedVehicle(el)
if not veh then return end
if veh and getElementModel(veh) ~= 525 and getElementModel(veh) ~= 578 then return end
local duty = getElementData(el,"player:faction")
if not duty then return end
local tow = getVehicleTowedByVehicle(veh) or getElementData(veh, "zaladowane")
if not tow or tow1 then return end
triggerClientEvent(el,"glownyparking:chowaj",root)
end)



local clicker = {}



addEvent("glownyparking:oddaj",true)
addEventHandler("glownyparking:oddaj",root,function(tabelka)
    local veh = getPedOccupiedVehicle(client)
    if not tabelka then return end
    if clicker[tabelka[1]] then return end
    if tonumber(tabelka[5]) < 1000000 then exports.nrpg_interface:showPlayerNotification(client,'Minimalna kwota to 1,000,000 PLN', 'error') return end
    if tonumber(tabelka[5]) > 70000000 then exports.nrpg_interface:showPlayerNotification(client,'Maksymalna kwota to 70,000,000 PLN', 'error') return end
    exports['nrpg_db']:dbSet("INSERT INTO pystories_vehicles_parking (idpojazdu, funkcjonariusz,rejestracja,data,powod,cena) VALUES (?, ?,?,NOW(),?,?)",tabelka[2],tabelka[3],tabelka[4],tabelka[6],tabelka[5],tabelka[6])
    exports['nrpg_db']:dbSet("Update pystories_vehicles set police=1 where id=?",tabelka[2])
    local kasa = math.random(1000,10000)
    exports.nrpg_interface:showPlayerNotification(client,'Pomyslnie oddano pojazd na parking.\nOtrzymujesz '..kasa..' PLN.', 'success')
    givePlayerMoney(client,kasa)
    clicker[tabelka[1]] = true
    setTimer(function(x) destroyElement(x); clicker[x] = nil end,350,1,tabelka[1])
    setElementData(veh, "zaladowane", false)
    exports['nrpg_discord']:connectWeb("**"..getPlayerName(client):gsub("#%x%x%x%x%x%x","").."** oddał pojazd na parking policyjny. ID POJAZDU: **"..tabelka[2].." ** Rejestracja: ** "..tabelka[4].." ** Kwota: ** "..convertNumber(tabelka[5]).." ** Powód: ** "..tabelka[6].." ** ", "ParkingPoli") 
end)

local odbior = createMarker(1031.35, -1442.66, 13.55-0.9,"cylinder",1.2,255,255,0,55)
setElementData(odbior,"marker:text","Parking policyjny")
setElementData(odbior,"marker:downtext","Punkt odbioru pojazdu")

addEventHandler("onMarkerHit",odbior,function(el,md)
	if getElementType(el) ~= "player" then return end
	local veh = getPedOccupiedVehicle(el)
	if veh then return end
	local uid = getElementData(el,"player:sid")
	local tabelka = exports['nrpg_db']:dbGet("SELECT pystories_vehicles_parking.*,pystories_users.id,pystories_vehicles.id,pystories_vehicles.driver,pystories_vehicles.ownedPlayer from pystories_users left join pystories_vehicles on pystories_vehicles.ownedPlayer=pystories_users.id left join pystories_vehicles_parking on pystories_vehicles_parking.idpojazdu = pystories_vehicles.id where pystories_users.id=? and pystories_vehicles.police=1",uid)
	if not tabelka or tabelka and #tabelka < 1 then exports.nrpg_interface:showPlayerNotification(el,'Brak pojazdów do odebrania z parkingu policyjnego', 'info') return end
	triggerClientEvent(el,"odbior:refresh",root,tabelka)
end)

addEventHandler("onMarkerLeave",odbior,function(el,md)
	if getElementType(el) ~= "player" then return end
	local veh = getPedOccupiedVehicle(el)
	if veh then return end
	triggerClientEvent(el,"odbior:chowaj",root,tabelka)
end)

addEvent("odbior:wydaj",true)
addEventHandler("odbior:wydaj",root,function(id,cena)
	if not id then return end
	local money = getPlayerMoney(client)
	if money < cena then exports.nrpg_interface:showPlayerNotification(client,'Nie posiadasz tyle pieniedzy', 'error') triggerClientEvent(client,"odbior:schowaj",root) return end
	exports['nrpg_db']:dbSet("DELETE from pystories_vehicles_parking where idpojazdu=?",id)
	exports['nrpg_db']:dbSet("Update pystories_vehicles set police=0,parking=1 where id=?",id)
	local poss = {1028.36, -1451.47, 13.26, 0, 0, 90}
	exports['nrpg_vehicles']:onRespawnVehicles(_,id,poss)
	exports.nrpg_interface:showPlayerNotification(client,'Pomyślnie odebrano pojazd z parkingu policyjnego', 'success')
	takePlayerMoney(client,cena)
end)


 -- SARA

local clicker = {}



addEvent("glownyparking2:oddaj",true)
addEventHandler("glownyparking2:oddaj",root,function(tabelka)
	local veh = getPedOccupiedVehicle(client)
	if not tabelka then return end
	if clicker[tabelka[1]] then return end
	if tonumber(tabelka[5]) < 1000000 then exports.nrpg_interface:showPlayerNotification(client,'minimalna kwota to 1,000,000 PLN', 'error') return end
	if tonumber(tabelka[5]) > 70000000 then exports.nrpg_interface:showPlayerNotification(client,'Maksymalna kwota to 70,000,000 PLN', 'error') return end
	exports['nrpg_db']:dbSet("INSERT INTO pystories_vehicles_parking (idpojazdu, funkcjonariusz,rejestracja,data,powod,cena) VALUES (?, ?,?,NOW(),?,?)",tabelka[2],tabelka[3],tabelka[4],tabelka[6],tabelka[5])
	exports['nrpg_db']:dbSet("Update pystories_vehicles set police=1 where id=?",tabelka[2])
	local kasa2 = math.random(1000,10000)
	exports.nrpg_interface:showPlayerNotification(client,'Pomyslnie oddano pojazd na parking.\nOtrzymujesz '..kasa2..' PLN.', 'success')
	givePlayerMoney(client,kasa2)
	clicker[tabelka[1]] = true
	setTimer(function(x) destroyElement(x); clicker[x] = nil end,350,1,tabelka[1])
	setElementData(veh, "zaladowane", false)
end)

local oddanie3 = createMarker(1179.42, -1339.04, 11.9,"cylinder",5,255,255,0,55)


setElementData(oddanie3,"marker:text","Parking policyjny")
setElementData(oddanie3,"marker:downtext","Punkt oddania pojazdu")


addEventHandler("onMarkerHit",oddanie3,function(el,md)
if getElementType(el) ~= "player" then return end
local veh = getPedOccupiedVehicle(el)
if not veh then return end
if veh and getElementModel(veh) ~= 525 and getElementModel(veh) ~= 578 then return end
local duty = getElementData(el,"player:faction")
if not duty then return end
local tow = getVehicleTowedByVehicle(veh) or getElementData(veh, "zaladowane")
if not tow or tow1 then return end
triggerClientEvent(el,"glownyparking:refresh",root,tow)
end)
addEventHandler("onMarkerLeave",oddanie3,function(el,md)
if getElementType(el) ~= "player" then return end
local veh = getPedOccupiedVehicle(el)
if not veh then return end
if veh and getElementModel(veh) ~= 525 and getElementModel(veh) ~= 578 then return end
local duty = getElementData(el,"player:faction")
if not duty then return end
local tow = getVehicleTowedByVehicle(veh) or getElementData(veh, "zaladowane")
if not tow or tow1 then return end
triggerClientEvent(el,"glownyparking:chowaj",root)
end)



local clicker = {}



addEvent("glownyparking3:oddaj",true)
addEventHandler("glownyparking3:oddaj",root,function(tabelka)
	local veh = getPedOccupiedVehicle(client)
	if not tabelka then return end
	if clicker[tabelka[1]] then return end
	if tonumber(tabelka[5]) < 1000000 then exports.nrpg_interface:showPlayerNotification(client,'minimalna kwota to 1,000,000 PLN', 'error') return end
	if tonumber(tabelka[5]) > 70000000 then exports.nrpg_interface:showPlayerNotification(client,'Maksymalna kwota to 70,000,000 PLN', 'error') return end
	exports['nrpg_db']:dbSet("INSERT INTO pystories_vehicles_parking (idpojazdu, funkcjonariusz,rejestracja,data,powod,cena) VALUES (?, ?,?,NOW(),?,?)",tabelka[2],tabelka[3],tabelka[4],tabelka[6],tabelka[5])
	exports['nrpg_db']:dbSet("Update pystories_vehicles set police=1 where id=?",tabelka[2])
	local kasa2 = math.random(20000000,30000000)
	exports.nrpg_interface:showPlayerNotification(client,'Pomyslnie oddano pojazd na parking.\nOtrzymujesz '..kasa2..' PLN.', 'success')
	givePlayerMoney(client,kasa2)
	clicker[tabelka[1]] = true
	setTimer(function(x) destroyElement(x); clicker[x] = nil end,350,1,tabelka[1])
	setElementData(veh, "zaladowane", false)
end)

function convertNumber ( number )  
    local formatted = number  
    while true do      
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
        if ( k==0 ) then      
            break   
        end  
    end  
    return formatted
end
