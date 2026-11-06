vehicleData = {}

addEvent("wystawPojazd", true)
addEventHandler("wystawPojazd", root, function(plr, veh, cost, desc)
    if exports["nrpg_admin"]:getAdmin(plr, 5) then
    else
        if getTradeBan(veh) then exports.nrpg_interface:showPlayerNotification(plr, "Pojazd posiada blokadę tradeban, nie możesz go wymieniać czy też sprzedać, wygasa: "..getTradeBan(veh), "error") return end
    end
    if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end

    local theVehicleData = {

        ["tunes"] = {

            ["UP1"] = exports["nrpg_vehicles"]:getTuning(veh, "UP1"),
            ["UP2"] = exports["nrpg_vehicles"]:getTuning(veh, "UP2"),
            ["UP3"] = exports["nrpg_vehicles"]:getTuning(veh, "UP3"),
            ["UP4"] = exports["nrpg_vehicles"]:getTuning(veh, "UP4"),
            ["Zaplon"] = exports["nrpg_vehicles"]:getTuning(veh, "Zaplon"),
            ["RH"] = exports["nrpg_vehicles"]:getTuning(veh, "RH"),
            ["ABS"] = exports["nrpg_vehicles"]:getTuning(veh, "ABS"),
            ["Wykrywacz"] = exports["nrpg_vehicles"]:getTuning(veh, "Wykrywacz"),
            ["Naped"] = exports["nrpg_vehicles"]:getTuning(veh, "Naped"),
            ["Neon"] = exports["nrpg_vehicles"]:getTuning(veh, "Neon"),
            ["Turbo"] = exports["nrpg_vehicles"]:getTuning(veh, "Turbo"),
            ["Taxi"] = exports["nrpg_vehicles"]:getTuning(veh, "Taksometr"),
            ["Hovermode"] = exports["nrpg_vehicles"]:getTuning(veh, "Hovermode"),
            ["Deluxomode"] = exports["nrpg_vehicles"]:getTuning(veh, "Deluxomode"),
            ["Chiptuning"] = exports["nrpg_vehicles"]:getTuning(veh, "ChipTuning"),
            ["Licznik"] = exports["nrpg_vehicles"]:getTuning(veh, "LicznikRGB"),

        },

        ["other"] = {

            ["Name"] = exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(getElementModel(veh))),
            ["ID"] = getElementData(veh, "vehicle:id"),
            ["Przebieg"] = math.floor(getElementData(veh, "vehicle:mileage")),
            ["LPG"] = getElementData(veh, "vehicle:lpg"),
            ["Bak"] = getElementData(veh, "vehicle:bak") or 25,
            ["Szyby"] = getElementData(veh, "vehicle:carTint") or 0,
            ["Opony"] = exports["nrpg_vehicles"]:getTuning(veh, "Opony"),
            ["Engine"] = getElementData(veh, "Pojemnosc:silnika") or "1.4",
            ["Cylindry"] = getElementData(veh, "vehicle:cylindry") or "V2",


        },

    }

    local dodatki = {}
    local lights = {}
    local unique = {}

    if theVehicleData["tunes"]["UP1"] then table.insert(dodatki, "UP1") end
    if theVehicleData["tunes"]["UP2"] then table.insert(dodatki, "UP2") end
    if theVehicleData["tunes"]["UP3"] then table.insert(dodatki, "UP3") end
    if theVehicleData["tunes"]["UP4"] then table.insert(dodatki, "UP4") end
    if theVehicleData["tunes"]["Zaplon"] then table.insert(dodatki, "Wspomaganie zapłonu") end
    if theVehicleData["tunes"]["RH"] then table.insert(dodatki, "RH") end
    if theVehicleData["tunes"]["ABS"] then table.insert(dodatki, "System ABS") end
    if theVehicleData["tunes"]["Wykrywacz"] then table.insert(dodatki, "Wykrywacz fotoradarów") end
    if theVehicleData["tunes"]["Naped"] then table.insert(dodatki, "Zmienny napęd") end
    if theVehicleData["tunes"]["Turbo"] then table.insert(dodatki, "Turbosprężarka") end
    if theVehicleData["other"]["LPG"] then table.insert(dodatki, "Butla LPG") end
    if theVehicleData["tunes"]["Neon"] then table.insert(dodatki, "Neony") end
    if theVehicleData["tunes"]["Taxi"] then table.insert(dodatki, "Taxometr") end
    if theVehicleData["tunes"]["Hovermode"] then table.insert(unique, "Hovermode") end
    if theVehicleData["tunes"]["Deluxomode"] then table.insert(unique, "Deluxomode") end
    if theVehicleData["tunes"]["Chiptuning"] then table.insert(unique, "Chiptuning") end
    if theVehicleData["tunes"]["Licznik"] then table.insert(unique, "Licznik RGB") end
    if theVehicleData["other"]["Szyby"] ~= 0 then table.insert(dodatki, "Przyciemniane szyby ("..theVehicleData["other"]["Szyby"].."%)") end

    local r, g, b = getVehicleHeadLightColor(veh)
    local neonColor = getElementData(veh, "neonColor")
    local r2, g2, b2 = tonumber(neonColor[1]), tonumber(neonColor[2]), tonumber(neonColor[3])
    local licznikColor = getElementData(veh, "licznikColor")
    local r3, g3, b3 = tonumber(licznikColor[1]), tonumber(licznikColor[2]), tonumber(licznikColor[3])

    if r == 255 and g == 255 and b == 255 then
    else
        table.insert(lights, "Kolor świateł ("..RGBToHex(r, g, b).."██#ffffff)")
    end

    if r2 == 255 and g2 == 255 and b2 == 255 then
    else
        table.insert(lights, "Kolor neonu ("..RGBToHex(r2, g2, b2).."██#ffffff)")
    end

    if r3 == 255 and g3 == 255 and b3 == 255 then
    else
        if theVehicleData["tunes"]["Licznik"] then
            table.insert(lights, "Kolor licznika ("..RGBToHex(255, 0, 0).."█"..RGBToHex(0, 255, 0).."█"..RGBToHex(0, 0, 255).."█#ffffff)")
        else
            table.insert(lights, "Kolor licznika ("..RGBToHex(r3, g3, b3).."██#ffffff)")
        end
    end

    if #dodatki > 0 then
        actualVehicleUpgrades = table.concat(dodatki,", ")
    else
        actualVehicleUpgrades = "Brak"
    end

    if #unique > 0 then
        actualVehicleUpgradesUnique = table.concat(unique,", ")
    else
        actualVehicleUpgradesUnique = "Brak"
    end

    if #lights > 0 then
        actualVehicleColors = table.concat(lights,", ")
    else
        actualVehicleColors = "Brak"
    end

    vehicleData[veh] = "#B3B3B3"..theVehicleData["other"]["ID"].."#ffffff - "..theVehicleData["other"]["Name"].."\n\nCena: #83FF77"..convertNumber(cost).." PLN#ffffff\nPrzebieg: #4DADFF"..theVehicleData["other"]["Przebieg"].." km#ffffff\nPojemność silnika: #FF9241"..theVehicleData["other"]["Engine"].." dm3 "..theVehicleData["other"]["Cylindry"].."#ffffff #B3B3B3(Pojemność baku: "..theVehicleData["other"]["Bak"].." L)#ffffff\nOświetlenie: "..actualVehicleColors.."\nDodatki: #B3B3B3"..actualVehicleUpgrades.."#ffffff\nUnikatowe dodatki: #B3B3B3"..actualVehicleUpgradesUnique.."\n#ffffffDodatkowe informacje: #B3B3B3"..desc.."#ffffff\n\n\nSprzedający: #07A4FF"..getPlayerName(plr).."#ffffff\nAby zakupić pojazd wsiądź do niego i wpisz /zakup"
    setElementData(veh, "vehicle:desc", vehicleData[veh])
    setElementData(veh, "vehicle:gielda", {cena=cost, owner=getElementData(plr, "player:sid")})
end)

function convertNumber(amount) 
    local formatted = amount 
    while true do   
      formatted, ss = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (ss==0) then 
        break 
      end 
    end 
    return formatted 
end

function getTradeBan(veh)
	local queryA = exports['nrpg_db']:dbGet("SELECT * FROM pystories_vehicles WHERE id=? AND tradeban>NOW() LIMIT 1", getElementData(veh,"vehicle:id"))
	if (queryA and #queryA > 0) then
		return queryA[1].tradeban
	end
	return false	
end

function addTradeBan(veh, days)
	if getTradeBan(veh) then exports['nrpg_db']:dbSet(string.format("UPDATE pystories_vehicles SET tradeban = DATE(tradeban) + INTERVAL %d DAY WHERE id=%d", days, getElementData(veh, "vehicle:id"))) return end
	exports['nrpg_db']:dbSet(string.format("UPDATE pystories_vehicles SET tradeban = DATE(curdate()) + INTERVAL %d DAY WHERE id=%d", days, getElementData(veh, "vehicle:id")))
end

addCommandHandler("zakup", function(plr, cmd)
    if getPedOccupiedVehicle(plr) and getElementData(getPedOccupiedVehicle(plr), "vehicle:gielda") and getElementData(getPedOccupiedVehicle(plr), "vehicle:ownedPlayer") ~= getElementData(plr, "player:sid") then
        local carInfo = getElementData(getPedOccupiedVehicle(plr), "vehicle:gielda")
        if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end

        if getPlaeyerBankMoney(plr) > carInfo.cena then
            exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET ownedPlayer=?, ownedGroup=? WHERE id=?", getElementData(plr, "player:sid"), "", getElementData(getPedOccupiedVehicle(plr), "vehicle:id"))
            exports["nrpg_db"]:dbSet("UPDATE pystories_users SET bank_money=bank_money+? WHERE id=?", carInfo.cena, carInfo.owner)
            takePlayerBankMoney(plr, carInfo.cena)
            setElementData(getPedOccupiedVehicle(plr), "vehicle:ownedPlayer", getElementData(plr, "player:sid"))
            setElementData(getPedOccupiedVehicle(plr), "vehicle:ownedGroup", false)
            setElementData(getPedOccupiedVehicle(plr), "vehicle:desc", false)
            setElementData(getPedOccupiedVehicle(plr), "vehicle:gielda", false)
            addTradeBan(getPedOccupiedVehicle(plr), 1)

            exports.nrpg_interface:showPlayerNotification(plr, "Pojazd pomyślnie zakupiony", "success")
        else
            exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz tyle pieniędzy", "error")
        end
    end
end)

function getPlaeyerBankMoney(plr)
	local sr = exports["DB2"]:pobierzWyniki("SELECT `bank_money` FROM `pystories_users` WHERE id="..tonumber(getElementData(plr, "player:sid")).." LIMIT 1")
	if not sr or not sr.bank_money then return end
	sr.bank_money = tonumber(sr.bank_money)

	if sr.bank_money then
		return sr.bank_money
	end
end

function takePlayerBankMoney(plr, money)
	local sr = exports["DB2"]:pobierzWyniki("SELECT `bank_money` FROM `pystories_users` WHERE id="..tonumber(getElementData(plr, "player:sid")).." LIMIT 1")
	if not sr or not sr.bank_money then return end
	sr.bank_money = tonumber(sr.bank_money)

	if (sr.bank_money > math.abs(money-1)) then
		exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money-"..math.abs(tonumber(money)).." WHERE id="..tonumber(getElementData(plr, "player:sid")).." LIMIT 1")
		return true
	else
		exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz tyle pieniędzy", "error", 15000)
		return false
	end
end

function RGBToHex(red, green, blue, alpha)
    if ( (red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255) ) ) then
        return nil
    end
    if ( alpha ) then
        return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
    else
        return string.format("#%.2X%.2X%.2X", red,green,blue)
    end
end