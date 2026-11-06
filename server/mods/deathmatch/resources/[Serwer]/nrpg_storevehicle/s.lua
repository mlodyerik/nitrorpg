storeVehs = {

{
{982.12, -1435.37, 13.55},
setElementData(createMarker(982.12, -1435.37, 13.55-1, "cylinder", 4, 35, 175, 255, 55),"store:hiding:id",1),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody i motocykle"
},

{
{1617.86, -1554.69, 13.58},
setElementData(createMarker(1617.86, -1554.69, 13.58-1, "cylinder", 3.5, 35, 175, 255, 55),"store:hiding:id",2),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody i motocykle"
},

}

local categoryA = {[463] = true, [462] = true, [461] = true, [581] = true, [448] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true} 
local categoryB = {[602] = true, [545] = true, [401] = true, [496] = true, [517] = true, [585] = true, [410] = true, [518] = true, [600] = true, [506] = true, [436] = true, [589] = true, [580] = true, [419] = true, [506] = true, [533] = true, [549] = true, [526] = true, [491] = true, [474] = true, [445] = true, [467] = true, [604] = true, [426] = true, [507] = true, [547] = true, [585] = true, [405] = true, [587] = true, [409] = true, [466] = true, [550] = true, [492] = true, [566] = true, [546] = true, [540] = true, [551] = true, [421] = true, [516] = true, [529] = true, [488] = true, [460] = true, [469] = true, [487] = true, [510] = true, [509] = true, [481] = true, [586] = true, [472] = true, [473] = true, [493] = true, [595] = true, [484] = true, [430] = true, [453] = true, [452] = true, [446] = true, [454] = true, [485] = true, [552] = true, [438] = true, [574] = true, [420] = true, [525] = true, [408] = true, [596] = true, [597] = true, [427] = true, [599] = true, [490] = true, [432] = true, [528] = true, [601] = true, [407] = true, [544] = true, [470] = true, [598] = true, [588] = true, [532] = true, [443] = true, [486] = true, [531] = true, [543] = true, [422] = true, [583] = true, [478] = true, [605] = true, [554] = true, [530] = true, [418] = true, [572] = true, [582] = true, [536] = true, [575] = true, [534] = true, [567] = true, [535] = true, [576] = true, [412] = true, [402] = true, [542] = true, [603] = true, [475] = true, [449] = true, [537] = true, [570] = true, [441] = true, [464] = true, [501] = true, [465] = true, [564] = true, [568] = true, [557] = true, [424] = true, [504] = true, [495] = true, [457] = true, [539] = true, [483] = true, [571] = true, [500] = true,  [444] = true, [556] = true, [429] = true, [411] = true, [541] = true, [559] = true, [415] = true, [561] = true, [480] = true, [560] = true, [562] = true, [506] = true, [565] = true, [451] = true, [434] = true, [558] = true, [494] = true, [535] = true, [502] = true, [477] = true, [503] = true, [579] = true, [400] = true, [404] = true, [489] = true, [505] = true, [479] = true, [442] = true, [458] = true, [606] = true, [607] = true, [610] = true, [590] = true, [569] = true, [611] = true, [584] = true, [608] = true, [435] = true, [450] = true, [591] = true, [594] = true}
local categoryC = {[403] = true, [406] = true, [413] = true, [414] = true, [416] = true, [423] = true, [428] = true, [431] = true, [433] = true, [437] = true, [440] = true, [455] = true, [456] = true, [459] = true, [482] = true, [498] = true, [499] = true, [508] = true, [514] = true, [515] = true, [524] = true, [538] = true, [573] = true}


for i,v in ipairs(getElementsByType("marker", resourceRoot)) do
	if getElementData(v, "store:hiding:id") then
		setElementData(v, "marker:text", "Przechowalnia")
		setElementData(v, "marker:downtext", "Pozostawianie pojazdów")
		setElementData(v, "marker:icon", "parking")
	end
end

for _,c in pairs(storeVehs) do
	createBlip(c[1][1],c[1][2],c[1][3], 35,2,0,0,0,0,0,450)
end

addEventHandler("onMarkerHit", root, function(plr,md)
	local id_store = getElementData(source,"store:hiding:id")
	if not id_store then return end
    if getElementType(plr) == "player" then
        local veh=getPedOccupiedVehicle(plr)
        if not veh then return end
        if getVehicleController(veh) ~= plr then return end
        local id=getElementData(veh,"vehicle:id")
        if not id then return end
		if getElementData(plr, "job:taxi") then
			exports.nrpg_interface:showPlayerNotification(plr, "Zakończ pracę!", "error")
		return end
		if storeVehs[id_store][3][getVehicleType(veh)] then
        if isTimer(timeroddania) then return end
			timeroddania=setTimer(function()
				local id=getElementData(veh,"vehicle:id")
				if not id then return end
				exports["nrpg_vehicles"]:onSaveVehicle(veh)
				destroyElement(veh)
				exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET parking=1,tp_to_parking=? WHERE id=?","Schowany recznie", id)
				exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie schowano pojazd do przechowalni", "success", 15000)
			end, 1, 1)
		end
	end
end)

addEvent("showVehiclesParkCar", true)
addEventHandler("showVehiclesParkCar", root, function()
	local player_sid = getElementData(client, "player:sid")
	local check = exports["nrpg_db"]:dbGet("SELECT * from pystories_vehicles WHERE (ownedPlayer=? or rent=?) and parking=1",player_sid)
	triggerClientEvent(client, "showVehiclesParkCarClient", client, check)
end)

addEvent("showVehiclesParkCarOrg", true)
addEventHandler("showVehiclesParkCarOrg", root, function()
	local organizacja = getElementData(client, "player:organization") or "Brak"
	if organizacja == "Brak" then return end
	local check = exports["nrpg_db"]:dbGet("SELECT * from pystories_vehicles WHERE ownedGroup=? and parking=1", organizacja)
	triggerClientEvent(client, "showVehiclesParkCarClient", client, check)
end)

addEvent("selectCarParkCar", true)
addEventHandler("selectCarParkCar", root, function(sid)
	local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles WHERE id=?", sid)
	if #check > 0 then
		triggerClientEvent(client, "selectCarParkCarClient", client, check)
	end
end)

addEvent("spawnVehicleParkCar", true)
addEventHandler("spawnVehicleParkCar", root, function(id,plr,place)
    if not id then return end
	if not place then return end
	if getElementData(plr, "player:job") == "Listonosz" then
			cancelEvent()
		return
	end
	vehicleInfo = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles WHERE id=?", id)

	if categoryA[vehicleInfo[1].model] then
        if getVehicleLicense(plr,"A") then
            return
        end
    elseif categoryB[vehicleInfo[1].model] then
        if getVehicleLicense(plr,"B") then
            return
        end
    elseif categoryC[vehicleInfo[1].model] then
        if getVehicleLicense(plr,"C") then
            return
        end
    end

	local spawn = exports["nrpg_vehicles"]:onRespawnVehicles(_, id, place)
    exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie wyjmujesz pojazd ID "..id.." z przechowalni", "success")

    local car = findCar(plr, id)
    if car then
    	setTimer( function()
    		warpPedIntoVehicle(plr, car)
    		setVehicleEngineState(car, true)
    	end, 100, 1)
    end
end)

function findCar(player, toCar)
    for i,v in ipairs(getElementsByType("vehicle")) do
        if tonumber(toCar) then
            if getElementData(v, "vehicle:id") == tonumber(toCar) then
                return v
            end
        end
    end
end

function getVehicleLicense(plr, type)
    if getElementData(plr,"player:license:pj"..type.."") ~= 1 then
		outputChatBox("✘#ffffff Nie posiadasz prawa jazdy kategorii "..type.."", plr, 255, 0, 0, true)
		return true
	end

	local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_punish WHERE serial=? AND type=? AND active=1 AND time>NOW()", getPlayerSerial(plr), tostring(type))
	if result and #result > 0 then
			v = result[1]
			outputChatBox("✘#ffffff Posiadasz zawieszone prawo jazdy do "..v.time.." za "..v.reason, plr, 255, 0, 0, true)
		return true
	else
			exports["nrpg_db"]:dbSet("DELETE FROM pystories_punish WHERE serial=? AND type=? AND active=1 AND time<NOW()", getPlayerSerial(plr), tostring(type))
		return false
	end
end