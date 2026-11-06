allHomes = {}
pickups = {}

function loadHomes()
	local querry = exports['nrpg_db']:dbGet("SELECT * FROM pystories_houses")
	if querry and #querry > 0 then
		local tick = getTickCount()
		for i, v in pairs(querry) do
			local pos = split(v["pos"], ",")
			marker = createMarker(pos[1], pos[2], pos[3], "cylinder", 1, 0, 0, 0, 0)

			if v["owner"] == 0 then
				pickup = createPickup(pos[1], pos[2], pos[3], 3, 1273, 0)
			else
				pickup = createPickup(pos[1], pos[2], pos[3], 3, 1272, 0)
			end

			marker:setData('marker:data',{name = '', icon = 'house'},true)
			marker:setData("house:data", {
				id = v["id"],
				owner = tonumber(v["owner"]),
				ownerName = v["owner_name"],
				date = v["date"],
				name = v["name"],
				price = v["price"],
				locked = tonumber(v["locked"]),
				size = v["interiorSize"],
				exitPos = {pos[1], pos[2], pos[3]},
				rent = fromJSON(v["rent"]) and fromJSON(v["rent"]) or {}
			})
			addEventHandler("onMarkerHit", marker, enterMarker)

			allHomes[v["id"]] = marker
			pickups[v["id"]] = pickup
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, loadHomes)

function enterMarker(el, dm)
	if not dm then return end
	if not el:getType("player") then return end
	if el:getOccupiedVehicle() then return end
--	if getPlayerSerial(el) ~= '0AD10D75869E67B26429659CE5938103' or getPlayerSerial(el) ~= 'BADEAFC4BD0B03F74946BF3EE610E2E4' or getPlayerSerial(el) ~= '4789529C23F91124DE049851CFCDAC02' then return end

	local dataHome = source:getData("house:data")
	triggerClientEvent(el, "openHouseGuiInfo", el, dataHome)
end

function playerAddPlayerToRentHome(plr, data, id)
	if not plr then return end
	if plr:getData("id") == id then exports.nrpg_interface:showPlayerNotification(plr, 'Nie możesz tego zrobić', 'error') return end
	if allHomes[data.id]:getData("house:data").owner ~= plr:getData("player:sid") then return end

	local target = findPlayer(plr, id)
	if target then
		local homeData = allHomes[data.id]:getData("house:data")
		if #homeData.rent < 6 then
			local name = getPlayerName(target):gsub("#%x%x%x%x%x%x","")
			local canAdd = true
			for i,v in ipairs(homeData.rent) do
				if v == name then
					canAdd = false
				end
			end

			if canAdd then
				table.insert(homeData.rent, name)
				allHomes[data.id]:setData("house:data", homeData)
				triggerClientEvent(plr, "updateHouseGuiInfo", plr, homeData)
				local querryPayHome = exports['nrpg_db']:dbSet("UPDATE `pystories_houses` SET `rent`= ? WHERE `id` = ?", toJSON(homeData.rent), data.id)
				exports.nrpg_interface:showPlayerNotification(plr, 'Współlokator dodany', 'success')
			end
		else
			exports.nrpg_interface:showPlayerNotification(plr, 'Za dużo współlokatorów', 'error')
		end
	else
		exports.nrpg_interface:showPlayerNotification(plr, 'Nie znaleziono takiego gracza', 'error')
	end
end
addEvent("playerAddPlayerToRentHome", true)
addEventHandler("playerAddPlayerToRentHome", resourceRoot, playerAddPlayerToRentHome)

function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		target=getElementByID("p"..cel)
	else -- podano fragment nicku
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 0, true) then
				if (target) then
					outputChatBox("* Znaleziono więcej niż jednego gracza o pasującym nicku, podaj więcej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	if target and getElementData(target,"p:inv") then return nil end
	return target
end

function playerRemovePlayerFromRentHome(plr, data, id)
	if not plr or not id then return end
	local homeData = allHomes[data.id]:getData("house:data")
	if homeData.owner ~= plr:getData("player:sid") then return end

	table.remove(homeData.rent, id)
	allHomes[data.id]:setData("house:data", homeData)

	triggerClientEvent(plr, "updateHouseGuiInfo", plr, homeData)
	local querryPayHome = exports['nrpg_db']:dbSet("UPDATE `pystories_houses` SET `rent`= ? WHERE `id` = ?", toJSON(homeData.rent), data.id)
	exports.nrpg_interface:showPlayerNotification(plr, 'Współlokator usunięty', 'success')
end
addEvent("playerRemovePlayerFromRentHome", true)
addEventHandler("playerRemovePlayerFromRentHome", resourceRoot, playerRemovePlayerFromRentHome)


function playerPayForHome(plr, data, price, time)
	if not plr then return end
	local money = getPlayerMoney(plr)
	if tonumber(time) > 0 then
	if tonumber(time) > 7 then exports.nrpg_interface:showPlayerNotification(plr, 'Możesz opłacić domek maksymalnie na 7 dni', 'error') return end
	if money < price then
		exports.nrpg_interface:showPlayerNotification(plr, 'Nie posiadasz tyle pieniędzy', 'error')
		return
	end
	local homeData = allHomes[data.id]:getData("house:data")

	if homeData.owner ~= 0 then
		if homeData.owner == plr:getData("player:sid") then

			local querryPayHome = exports['nrpg_db']:dbSet("UPDATE `pystories_houses` SET `date`= DATE_ADD(date, INTERVAL "..time.." DAY) WHERE `id` = ?", data.id)
			local querryPayHomeNewValue = exports['nrpg_db']:dbGet("SELECT date FROM `pystories_houses` WHERE `id` = ? LIMIT 1", data.id)
			if querryPayHome then
				takePlayerMoney(plr, price)
				homeData.owner = plr:getData('player:sid')
				homeData.ownerName = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
				homeData.date = querryPayHomeNewValue[1]["date"]
				allHomes[data.id]:setData("house:data", homeData)
				pickups[data.id]:setType(3, 1272)

				triggerClientEvent(plr, "updateHouseGuiInfo", plr, homeData)
				exports.nrpg_interface:showPlayerNotification(plr, 'Dom został opłacony na '..time..' dni', 'success')
			end
		else
			exports.nrpg_interface:showPlayerNotification(plr, 'Nie jesteś właścicielem tego domu', 'error')
		end
	else
		local querryCanBuyHouse = exports['nrpg_db']:dbGet("SELECT id FROM `pystories_houses` WHERE `owner` = ?", plr:getData('player:sid'))
		if #querryCanBuyHouse < 4 then

			local querryPayHome = exports['nrpg_db']:dbSet("UPDATE `pystories_houses` SET `date`= DATE_ADD(NOW(), INTERVAL "..time.." DAY), `owner_name` = ?, `owner`=?  WHERE `id` = ?", getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), plr:getData('player:sid'), data.id)
			local querryPayHomeNewValue = exports['nrpg_db']:dbGet("SELECT date FROM `pystories_houses` WHERE `id` = ? LIMIT 1", data.id)

			if querryPayHome then
				takePlayerMoney(plr, price)
				homeData.owner = plr:getData('player:sid')
				homeData.ownerName = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
				homeData.date = querryPayHomeNewValue[1]["date"]
				allHomes[data.id]:setData("house:data", homeData)
				pickups[data.id]:setType(3, 1272)

				triggerClientEvent(plr, "updateHouseGuiInfo", plr, homeData)
				exports.nrpg_interface:showPlayerNotification(plr, 'Dom został opłacony na '..time..' dni', 'success')
			end
		else
			exports.nrpg_interface:showPlayerNotification(plr, 'Przekroczono limit domków (4)', 'error')
		end
	end
end
end
addEvent("playerPayForHome", true)
addEventHandler("playerPayForHome", resourceRoot, playerPayForHome)


function enterHome(plr, data)
	if not plr then return end

	local homeData = allHomes[data.id]:getData("house:data")
	if homeData.owner == plr:getData("player:sid") then
		triggerClientEvent(plr, "closeHouseGuiInfo", plr)
		enterHomeLoadInterior(plr, data.id, data.exitPos)
	else
		if homeData.locked == 1 then
			local name = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
			for i,v in ipairs(homeData.rent) do
				if v == name then
					triggerClientEvent(plr, "closeHouseGuiInfo", plr)
					enterHomeLoadInterior(plr, data.id, data.exitPos)
					return
				end
			end
			exports.nrpg_interface:showPlayerNotification(plr, 'Dom jest zamknięty', 'error')
		else
			triggerClientEvent(plr, "closeHouseGuiInfo", plr)
			enterHomeLoadInterior(plr, data.id, data.exitPos)
		end
	end
end
addEvent("playerEnterHome", true)
addEventHandler("playerEnterHome", resourceRoot, enterHome)


function enterHomeLoadInterior(plr, homeID, pos)
	if not plr or not homeID then return end
	local querryCheckHome = exports['nrpg_db']:dbGet("SELECT interiorFloor, interiorWalls, interiorObjects, interiorSize, pos, pos_int FROM `pystories_houses` WHERE `id` = ?", homeID)
	if querryCheckHome and #querryCheckHome > 0 then
		plr:setData('user:blockOpen', true)
		plr:setData("user:inHome", homeID)
		plr:setData("player:positionOnQuit", pos)

		setTimer(function()
			triggerClientEvent(plr, "interiorLoadObjects", plr, querryCheckHome[1].interiorSize, homeID, querryCheckHome[1].interiorObjects, querryCheckHome[1].pos_int, querryCheckHome[1].pos, querryCheckHome[1].interiorWalls, querryCheckHome[1].interiorFloor)
		end, 1000, 1)
	else
	end
end


function playerCloseHome(plr, data)
	if not plr then return end
	if allHomes[data.id]:getData("house:data").owner == plr:getData("player:sid") then
		local homeData = allHomes[data.id]:getData("house:data")
		local newValue = homeData.locked == 1 and 0 or 1
		homeData.locked = newValue
		allHomes[data.id]:setData("house:data", homeData)
		exports['nrpg_db']:dbSet("UPDATE `pystories_houses` SET locked = ? WHERE `id` = ?", newValue, data.id)
		triggerClientEvent(plr, "updateHouseGuiInfo", plr, homeData)

		if newValue == 1 then
			local posForPlayer = data.exitPos
			for i, v in pairs(getElementsByType("player")) do
				if v:getData("user:inHome") then
					if v:getData("user:inHome") == data.id then
						triggerClientEvent(v, "removePlayerFromBuildedInterior", v)
					end
				end
			end
		end
	else
		exports.nrpg_interface:showPlayerNotification(plr, 'Nie jesteś właścicielem domu', 'error')
	end
end
addEvent("playerCloseHome", true)
addEventHandler("playerCloseHome", resourceRoot, playerCloseHome)


function playerEditHome(plr, data)
	if not plr then return end

	if allHomes[data.id]:getData("house:data").owner == plr:getData("player:sid") then
		triggerClientEvent(plr, "closeHouseGuiInfo", plr)
		editHomeLoader(plr, data.id, data.exitPos)
	else
		exports.nrpg_interface:showPlayerNotification(plr, 'Nie jesteś właścicielem domu', 'error')
	end
end
addEvent("playerEditHome", true)
addEventHandler("playerEditHome", resourceRoot, playerEditHome)


function editHomeLoader(plr, homeID, pos)
  local querryCheckHome = exports['nrpg_db']:dbGet("SELECT interiorFloor, interiorWalls, interiorObjects, interiorSize, pos_int, pos FROM `pystories_houses` WHERE `owner` = ? AND `id` = ?", plr:getData('player:sid'), homeID)
  if querryCheckHome and #querryCheckHome > 0 then
		local homeData = allHomes[homeID]:getData("house:data")
		homeData.locked = 1
		allHomes[homeID]:setData("house:data", homeData)

    	triggerClientEvent(plr, "interiorsBuilderOpen", plr, querryCheckHome[1].interiorSize, homeID, querryCheckHome[1].interiorObjects, querryCheckHome[1].pos_int, querryCheckHome[1].interiorWalls, querryCheckHome[1].interiorFloor, querryCheckHome[1].pos)

		plr:setData("player:positionOnQuit", pos)
  	else
    	exports.nrpg_interface:showPlayerNotification(plr, 'Nie jesteś właścicielem domu', 'error')
  end
end


function cmdAdminCreateHouse(plr, cmd, price, size, int, dim, ...)
if getElementData(plr, "player:level") == 5 or getElementData(plr, "player:level") == 4 then
	if not price or not size or not int or not dim or not ... then
		outputChatBox("Użyj: /"..cmd.." [cena] [wielkość] [int] [dim] [nazwa domu]", plr)
		return
	end
	local pos = Vector3(plr:getPosition())
	local posInt = tostring(pos.x..","..pos.y..","..(pos.z + 1000)..","..int..","..dim)
	local posEnter = tostring(pos.x..","..pos.y..","..pos.z..", 0, 0")
	local querryCheckHome, rows, id = exports['nrpg_db']:dbSet(string.format("INSERT INTO `pystories_houses`(`owner`, `name`, `price`, `pos`, `pos_int`, `interiorSize`, `date`, `interiorObjects`, `interiorWalls`, `interiorFloor`, `rent`) VALUES (0,'%s','%d','%s','%s','%d', NOW(),'%s','%s','%s','%s')", table.concat({...}, " "), tonumber(price), posEnter, posInt, tonumber(size), toJSON({}), toJSON({}), toJSON({}), toJSON({})))
	if querryCheckHome then
		local querry = exports['nrpg_db']:dbGet("SELECT * FROM pystories_houses WHERE id = ? LIMIT 1", id)

		marker = createMarker(pos.x, pos.y, pos.z, "cylinder", 1, 0, 180, 0, 0)

		pickup = createPickup(pos.x, pos.y, pos.z, 3, 1273, 0)

		marker:setData('marker:data',{name = '', icon = 'house'}, true)
		marker:setData("house:data", {
			id = querry[1]["id"],
			owner = tonumber(querry[1]["owner"]),
			ownerName = querry[1]["owner_name"],
			date = querry[1]["date"],
			name = querry[1]["name"],
			price = querry[1]["price"],
			locked = tonumber(querry[1]["locked"]),
			size = querry[1]["interiorSize"],
			exitPos = {pos[1], pos[2], pos[3]},
			rent = fromJSON(querry[1]["rent"]) and fromJSON(querry[1]["rent"]) or {}
		})
		addEventHandler("onMarkerHit", marker, enterMarker)
		allHomes[querry[1]["id"]] = marker
		pickups[querry[1]["id"]] = pickup
	end
end
end
addCommandHandler("dom", cmdAdminCreateHouse)

function restoreHouse(player,commandName,idHouse)
	if not type(idHouse) == 'number' or not idHouse then
		exports.nrpg_interface:showPlayerNotification(player, 'Poprawne użycie: /zwolnij.dom <idDomu>', 'error')
		return
	end

	local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(player, "player:sid"))
	if result[1].register_serial ~= getPlayerSerial(player) then
		return outputChatBox("✘ #ffffffW związku z zmianą numeru seryjnego MTA ta opcja jest zablokowana, jeśli chcesz ją odblokować wejdź na nasz teamspeak3: nitrorpg - Strefa pomocy.", player, 255, 0, 0,true)
	end

	if tonumber(idHouse) > 0 then
		local result = exports['nrpg_db']:dbGet('select * from pystories_houses WHERE id = ? LIMIT 1',idHouse)
		if result and #result > 0 then
			local house = result[1].owner
			if not exports["nrpg_admin"]:getAdmin(player, 5) then
				if house ~= player:getData("player:sid") then 
					exports.nrpg_interface:showPlayerNotification(player, 'Nie jesteś właścicielem domu', 'error')
					return
				end
			end
		--	local query = exports['nrpg_db']:dbSet('UPDATE `pystories_houses` SET `owner`= 0  AND `owner_name` = Brak AND `date` = NOW()  WHERE `id` = ? ',idHouse)
			local query = exports['nrpg_db']:dbSet('update pystories_houses set owner = "0" and owner_name = "Brak" and date = "NOW()" where id=?',idHouse)
			if query then
				exports.nrpg_interface:showPlayerNotification(player, 'Pomyślnie zwolniono dom', 'success')
				restartResource(getThisResource())
			end
		end
	end
end
addCommandHandler('zwolnij.dom',restoreHouse)


function checkHomes()
	local querryCheckHome = exports['nrpg_db']:dbGet("SELECT id FROM `pystories_houses` WHERE `date` < NOW()")
	if querryCheckHome and #querryCheckHome > 0 then
		for i, v in pairs(querryCheckHome) do
			allHomes[v["id"]]:setColor(0, 180, 0, 0)
			local dataHome = allHomes[v["id"]]:getData("house:data")
			dataHome.owner = 0
			allHomes[v["id"]]:setData("house:data", dataHome)
		end

		local querryClearHouses = exports['nrpg_db']:dbSet("UPDATE `pystories_houses` SET `owner`= 0  WHERE `date` < NOW()")
	end
end
setTimer(checkHomes, 10000, 0)