local categoryA = {[463] = true, [462] = true, [461] = true, [581] = true, [448] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true} 
local categoryB = {[602] = true, [545] = true, [401] = true, [496] = true, [517] = true, [585] = true, [410] = true, [518] = true, [600] = true, [506] = true, [436] = true, [589] = true, [580] = true, [419] = true, [506] = true, [533] = true, [549] = true, [526] = true, [491] = true, [474] = true, [445] = true, [467] = true, [604] = true, [426] = true, [507] = true, [547] = true, [585] = true, [405] = true, [587] = true, [409] = true, [466] = true, [550] = true, [492] = true, [566] = true, [546] = true, [540] = true, [551] = true, [421] = true, [516] = true, [529] = true, [488] = true, [460] = true, [469] = true, [487] = true, [510] = true, [509] = true, [481] = true, [586] = true, [472] = true, [473] = true, [493] = true, [595] = true, [484] = true, [430] = true, [453] = true, [452] = true, [446] = true, [454] = true, [485] = true, [552] = true, [438] = true, [574] = true, [420] = true, [525] = true, [408] = true, [596] = true, [597] = true, [427] = true, [599] = true, [490] = true, [432] = true, [528] = true, [601] = true, [407] = true, [544] = true, [470] = true, [598] = true, [588] = true, [532] = true, [443] = true, [486] = true, [531] = true, [543] = true, [422] = true, [583] = true, [478] = true, [605] = true, [554] = true, [530] = true, [418] = true, [572] = true, [582] = true, [536] = true, [575] = true, [534] = true, [567] = true, [535] = true, [576] = true, [412] = true, [402] = true, [542] = true, [603] = true, [475] = true, [449] = true, [537] = true, [570] = true, [441] = true, [464] = true, [501] = true, [465] = true, [564] = true, [568] = true, [557] = true, [424] = true, [504] = true, [495] = true, [457] = true, [539] = true, [483] = true, [571] = true, [500] = true,  [444] = true, [556] = true, [429] = true, [411] = true, [541] = true, [559] = true, [415] = true, [561] = true, [480] = true, [560] = true, [562] = true, [506] = true, [565] = true, [451] = true, [434] = true, [558] = true, [494] = true, [535] = true, [502] = true, [477] = true, [503] = true, [579] = true, [400] = true, [404] = true, [489] = true, [505] = true, [479] = true, [442] = true, [458] = true, [606] = true, [607] = true, [610] = true, [590] = true, [569] = true, [611] = true, [584] = true, [608] = true, [435] = true, [450] = true, [591] = true, [594] = true}
local categoryC = {[403] = true, [406] = true, [413] = true, [414] = true, [416] = true, [423] = true, [428] = true, [431] = true, [433] = true, [437] = true, [440] = true, [455] = true, [456] = true, [459] = true, [482] = true, [498] = true, [499] = true, [508] = true, [514] = true, [515] = true, [524] = true, [538] = true, [573] = true}

local vehiclesNames = {

    ["Banshee"] = "Corvette C7",
	["Intruder"] = "Audi A6",
	["Euros"] = "Tesla Roadster",
	["Hotring Racer"] = "Deluxo",
	["Super GT"] = "BMW M2",
    ["Fortune"] = "Ferrari Italia",
    ["Sunrise"] = "Tesla Model S",
    ["Stratum"] = "Mercedes GT63 AMG",
    ["Feltzer"] = "BMW e36",
    ["Club"] = "Golf MK4",
    ["Willard"] = "BMW M4",
    ["Solair"] = "Audi RS6",
    ["Emperor"] = "Subaru Impreza",

}

function changeName(name)
    local changedName = vehiclesNames[name]

    if changedName then
        return changedName
    else
        return name
    end
end

function getVehicleHandlingProperty(element, property)
    if isElement(element) and getElementType(element) == "vehicle" and type(property) == "string" then
        local handlingTable = getVehicleHandling(element) 
        local value = handlingTable[property] 
 
        if value then
            return value
        end
    end
    return false
end


function getAdmin(plr, level)
	if level then
		local result = exports["nrpg_db"]:dbGet("SELECT * from pystories_admins WHERE serial=? AND level=?", getPlayerSerial(plr), level)
		if result and #result > 0 then
			return true
		else
			return false
		end
	else
		local result = exports["nrpg_db"]:dbGet("SELECT * from pystories_admins WHERE serial=?", getPlayerSerial(plr))
		if result and #result > 0 then
			return true
		else
			return false
		end
	end
end

vehicleTuning = {}

function onRespawnVehicles(_,id,poss)
	if id then
		result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles WHERE parking=1 AND id=?", id)
		query = exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET parking=0 WHERE id=?", id)
	else
		result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_vehicles WHERE parking=0")
	end

	for i, vehicle in pairs(result) do
        if id then pos = {poss[1], poss[2], poss[3], poss[4], poss[5], poss[6]} else pos = split(vehicle["pos"], ",") end

        local color = split(vehicle["color"], ",")
        local lights = split(vehicle["headlights"], ",")
		local neonColor = split(vehicle["neonColor"], ",")
		local licznikColor = split(vehicle["licznikColor"], ",")
		local var = split(vehicle["wariant"], ",")

        local veh = createVehicle(vehicle["model"], pos[1], pos[2], pos[3], pos[4], pos[5], pos[6])
        setVehicleColor(veh, color[1], color[2], color[3], color[4],color[5], color[6], color[7], color[8],color[9], color[10], color[11], color[12])
        setVehicleHeadLightColor(veh, lights[1], lights[2], lights[3])
		setElementData(veh, "neonColor", {neonColor[1], neonColor[2], neonColor[3]})
		setElementData(veh, "licznikColor", {licznikColor[1], licznikColor[2], licznikColor[3]})

		local tabl0 = {}
		setElementData(veh, "vehicle:tuning", tabl0)

		if vehicle["plateText"] ~= "" then
			setVehiclePlateText(veh, vehicle["plateText"])
		else
			setVehiclePlateText(veh, tostring("SF "..vehicle["id"]))
		end

        setElementFrozen(veh, (vehicle["frozen"]) > 0)

		if vehicle["paintjob"] ~= 3 then
        	setVehiclePaintjob(veh, vehicle["paintjob"])
		end

        setElementHealth(veh, vehicle["health"])
        setElementData(veh, "vehicle:spawn", true)
        setElementData(veh, "vehicle:id", vehicle["id"])
        setElementData(veh, "vehicle:fuel", vehicle["fuel"])
		setElementData(veh, "vehicle:bak", vehicle["bak"] or 25)
        setElementData(veh, "vehicle:mileage", vehicle["mileage"])
        setElementData(veh, "vehicle:driver", vehicle["driver"])
        setElementData(veh, "vehicle:ownedGroup", vehicle["ownedGroup"])
        setElementData(veh, "vehicle:ownedPlayer", vehicle["ownedPlayer"])
        setElementData(veh, "Pojemnosc:silnika", vehicle["silnik"])
		setElementData(veh, "vehicle:cylindry", vehicle["cylindry"])
		setElementData(veh, "vehicle:carTint", tonumber(vehicle["tint"]))
		setElementData(veh, "vehicle:engineType", (vehicle["engineType"] or "Diesel"))
		setElementData(veh, "vehicle:licznikMotyw", (vehicle["motyw"] or 0))

		if vehicle["custompj"] ~= 0 then
			setElementData(veh, "vehicle:paintjob", vehicle["custompj"])
		end
		
		if (type(vehicle['rent']) == "string") then
			local tabelka = {}
			local rente = split(vehicle['rent'], ',')

			for k,v in ipairs(rente) do
				table.insert(tabelka,v) 
			end

        	setElementData(veh,"vehicle:rent", tabelka or false)
		else
			setElementData(veh,"vehicle:rent",0)
		end

		if vehicle["cylindry"] == "V2" then
			
		elseif vehicle["cylindry"] == "V4" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+0.15)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+5)
		elseif vehicle["cylindry"] == "V6" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+0.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+15)
		elseif vehicle["cylindry"] == "V8" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+1)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+20)
		elseif vehicle["cylindry"] == "V10" then	
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+1.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+25)
		elseif vehicle["cylindry"] == "V12" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+2)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+30)
		end

		if vehicle["silnik"] == "1.4" then
			-- nic nie dajemy
		elseif vehicle["silnik"] == "1.6" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+0.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+5)
		elseif vehicle["silnik"] == "1.8" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+1)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+6)
		elseif vehicle["silnik"] == "1.8" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+1.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+7)
		elseif vehicle["silnik"] == "2.0" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+2)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+15)
		elseif vehicle["silnik"] == "2.2" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+2.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+8)
		elseif vehicle["silnik"] == "2.4" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+3)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+9)
		elseif vehicle["silnik"] == "2.6" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+3.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+10)
		elseif vehicle["silnik"] == "2.8" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+4)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+15)
		elseif vehicle["silnik"] == "3.0" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+4.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+16)
		elseif vehicle["silnik"] == "3.2" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+17)
		elseif vehicle["silnik"] == "3.4" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+5.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+18)
		elseif vehicle["silnik"] == "3.6" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+6)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+19)
		elseif vehicle["silnik"] == "3.8" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+6.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+20)
		elseif vehicle["silnik"] == "4.0" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+7)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+25)
		elseif vehicle["silnik"] == "4.2" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+7.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+26)
		elseif vehicle["silnik"] == "4.4" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+8)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+27)
		elseif vehicle["silnik"] == "4.6" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+8.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+28)
		elseif vehicle["silnik"] == "4.8" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+9)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+29)
		elseif vehicle["silnik"] == "5.0" then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+9.5)
			setVehicleHandling(veh,"maxVelocity", getVehicleHandlingProperty(veh, "maxVelocity")+30)
		end

		if tonumber(vehicle["4x4"]) ~= 0 then
			addTuning(veh, "Naped", true)
		end

		if tonumber(vehicle["lpg"]) ~= 0 then
			setElementData(veh, "vehicle:lpg", true)
		end
		setElementData(veh, "vehicle:togglelpg", false)
		setElementData(veh, "vehicle:fuellpg", tonumber(vehicle["fuellpg"]))

		if tonumber(vehicle["licznik"]) ~= 0 then
			addTuning(veh, "LicznikRGB", true)
		end

		if tonumber(vehicle["zaplon"]) ~= 0 then
			addTuning(veh, "Zaplon", true)
		end
		
		if tonumber(vehicle["rh"]) ~= 0 then
			addTuning(veh, "RH", true)
		end

		if tonumber(vehicle["neonRGB"]) ~= 0 then
			addTuning(veh, "NeonRGB", true)
		end

		if tonumber(vehicle["abs"]) ~= 0 then
			addTuning(veh, "ABS", true)
		end

		if tonumber(vehicle["wykrywacz"]) ~= 0 then
			addTuning(veh, "Wykrywacz", true)
		end

		if tonumber(vehicle["deluxomode"]) ~= 0 then
			addTuning(veh, "Deluxomode", true)
		end

		if tonumber(vehicle["taksometr"]) ~= 0 then
			addTuning(veh, "Taksometr", true)
		end

		if tonumber(vehicle["hovermode"]) ~= 0 then
			addTuning(veh, "Hovermode", true)
		end

		if tonumber(vehicle["neon"]) ~= 0 then
			addTuning(veh, "Neon", true)
			setElementData(veh, "vehicle:neon", vehicle["neon"])
		end

		if tonumber(vehicle["chip"]) ~= 0 then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+5)
			addTuning(veh, "ChipTuning", true)
		end

		if tonumber(vehicle["turbo"]) ~= 0 then
			setVehicleHandling(veh,"engineAcceleration", getVehicleHandlingProperty(veh, "engineAcceleration")+2)
			addTuning(veh, "Turbo", true)
		end

		if tonumber(vehicle["mk1"]) ~= 0 then
			addTuning(veh, "UP1", true)
		end
		
		if tonumber(vehicle["mk2"]) ~= 0 then
			addTuning(veh, "UP2", true)
		end

		if tonumber(vehicle["mk3"]) ~= 0 then
			addTuning(veh, "UP3", true)
		end

		if tonumber(vehicle["mk4"]) ~= 0 then
			addTuning(veh, "UP4", true)
		end

        for i,v in ipairs(split(vehicle["tuning"], ",")) do 
        	addVehicleUpgrade(veh, v) 
        end

        for i,v in ipairs(split(vehicle["panelstates"], ",")) do 
        	setVehiclePanelState(veh, i, tonumber(v)) 
        end

		if vehicle["opony"] == 1 then
			setVehicleHandlingFlags(veh, {3, 4}, 8)
		end

		setTimer( function()
			if var[1] and var[2] then
				setVehicleVariant(veh, var[1], var[2])

				if tonumber(var[1]) == 4 then
					triggerClientEvent("openVehicleWindows", root, vehicle["id"])
				end
			else
				setVehicleVariant(veh, 255, 255)
			end
		end, 100, 1)

		if vehicle["police"] == 1 then
        	destroyElement(veh)
        end

		local color = nil
        local lights = nil
		local neonColor =nil
		local licznikColor = nil
		local var = nil
    end
end

function setVehicleHandlingFlags(vehicle, byte, value)
	if vehicle then
		local handlingFlags = string.format("%X", getVehicleHandling(vehicle)["handlingFlags"])
		local reversedFlags = string.reverse(handlingFlags) .. string.rep("0", 8 - string.len(handlingFlags))
		local currentByte, flags = 1, ""
		
		for values in string.gmatch(reversedFlags, ".") do
			if type(byte) == "table" then
				for _, v in ipairs(byte) do
					if currentByte == v then
						values = string.format("%X", tonumber(value))
					end
				end
			else
				if currentByte == byte then
					values = string.format("%X", tonumber(value))
				end
			end
			
			flags = flags .. values
			currentByte = currentByte + 1
		end
		
		setVehicleHandling(vehicle, "handlingFlags", tonumber("0x" .. string.reverse(flags)))
	end
end

function addTuning(veh, tuning, state)
	if not getElementData(veh, "vehicle:id") then return end

	if isElement(veh) and state == true then
		local theTable = getElementData(veh, "vehicle:tuning")
		table.insert(theTable, {tuning})
		setElementData(veh, "vehicle:tuning", theTable)
	end
end

function getTuning(veh, tuning)
	if not getElementData(veh, "vehicle:id") then return end
	
	local theTable = getElementData(veh, "vehicle:tuning")
	for i,v in ipairs(theTable) do
		if tuning == v[1] then
			return true
		end
	end
end

function onSaveVehicle(vehicle)
    if getElementData(vehicle, "vehicle:spawn") then
        local panelstates = {}
		local model = getElementModel(vehicle)
        local health = getElementHealth(vehicle)
        local x,y,z = getElementPosition(vehicle)
        local rx,ry,rz = getElementRotation(vehicle)
        local id = getElementData(vehicle,"vehicle:id")
        local silnik = getElementData(vehicle,"Pojemnosc:silnika") or "1.4"
		local cylindry = getElementData(vehicle,"vehicle:cylindry") or "V2"
        local fuel = getElementData(vehicle,"vehicle:fuel")
		local bak = getElementData(vehicle,"vehicle:bak") or 25
        local mileage = getElementData(vehicle,"vehicle:mileage")
		local fuellpg = getElementData(vehicle,"vehicle:fuellpg")
		local neoncolor = getElementData(vehicle,"neonColor")
		local licznikColor = getElementData(vehicle,"licznikColor")
		local n1, n2, n3 = neoncolor[1], neoncolor[2], neoncolor[3]
		local l1, l2, l3 = licznikColor[1], licznikColor[2], licznikColor[3]
        local c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12 = getVehicleColor(vehicle, true)
        local driver = getElementData(vehicle,"vehicle:driver") or ""
        local rent = getElementData(vehicle,"vehicle:rent")
        local player = getElementData(vehicle,"vehicle:ownedPlayer")
		local engineType = getElementData(vehicle,"vehicle:engineType") or "Diesel"
        local h1,h2,h3 = getVehicleHeadLightColor(vehicle)
		local wariant, wariant2 = getVehicleVariant(vehicle)
        local paintjob = getVehiclePaintjob(vehicle)
        local frozen = isElementFrozen(vehicle) and 1 or 0

        for i=0,6 do table.insert(panelstates, getVehiclePanelState(vehicle, i)) end
        panelstates = table.concat(panelstates, ",")
        upgrades = getVehicleUpgrades(vehicle)

        if not upgrades then upgrades = {} end
        upgrades = table.concat(upgrades, ",")

        local saveVehicle = exports["nrpg_db"]:dbSet(string.format("UPDATE pystories_vehicles SET model='%d', pos='%.2f,%.2f,%.2f,%.2f,%.2f,%.2f', rent='%d', health='%d', fuel='%d', mileage='%d', frozen='%d', driver='%s', color='%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d', panelstates='%s', paintjob='%d', tuning='%s', headlights='%d,%d,%d', ownedPlayer='%d', silnik='%s', fuellpg='%s', wariant='%s', bak='%s', neonColor='%s,%s,%s', licznikColor='%s,%s,%s', cylindry='%s', engineType='%s' WHERE id=%d", model, x,y,z, rx,ry,rz, "0", health, fuel, mileage, frozen, driver, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, panelstates, paintjob, upgrades, h1, h2, h3, player, silnik, fuellpg, wariant..", "..wariant2, bak, n1, n2, n3, l1, l2, l3, cylindry, engineType, id))
		
		if (type(rent) == "table") then
			local rentTable = string.format("%s", table.concat(rent, ','))
			local rentUpdate = exports['nrpg_db']:dbSet("UPDATE pystories_vehicles SET rent=? WHERE id=?", rentTable, id)
		end
    end
end


function onParkVehicle(vehicle) 
	if isElement(vehicle) then
		local query = exports["nrpg_db"]:dbSet("UPDATE pystories_vehicles SET parking=1 WHERE id=?", getElementData(vehicle, "vehicle:id"))
		if query then
        	destroyElement(vehicle)
		end
	end
end


function getSettings(plr,code,value)
	local sid = getElementData(plr, "player:sid")
	if not sid then return end

	if value == "organization" then
		local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_organizacje WHERE uid=?", sid)
		if result and #result > 0 then
			return result[1].code
		else
			return false
		end
	end

	if value == "owner" then
		local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", sid)
		if result and #result > 0 then
			return result[1].id
		else
			return false
		end
	end
end


addEventHandler("onVehicleStartEnter", resourceRoot, function(plr,seat,jacked)
    if seat == 0 then
    	if categoryA[getElementModel(source)] then
			if getVehicleLicense(plr, "A") then
					cancelEvent()
				return
			end
		elseif categoryB[getElementModel(source)] then
			if getVehicleLicense(plr, "B") then
					cancelEvent()
				return
			end
		elseif categoryC[getElementModel(source)] then
			if getVehicleLicense(plr, "C") then
					cancelEvent()
				return
			end
		end

    	if getElementData(source, "vehicle:id") then
    		local rent = getElementData(source, "vehicle:rent")
    		local group = getElementData(source, "vehicle:ownedGroup")
    		local player = getElementData(source, "vehicle:ownedPlayer")
    		local plrgroup = getElementData(plr,"player:organization")

			if group == "0" then group = "Brak" end

			if not getAdmin(plr, 5) then
			if rent and (type(rent) == "table") then
				for i, s in pairs(rent) do
					if tonumber(s) == getElementData(plr,"player:sid") then return end
				end
			end
		
		
			if plrgroup then
				if getSettings(plr, false, "organization") == group then return end
			end

			if player and player ~= getSettings(plr, false, "owner") then
				outputChatBox("✘#ffffff Nie posiadasz kluczy do tego pojazdu", plr, 255, 0, 0, true)
				cancelEvent()
			end
			end
   		end
	end
end)

addEventHandler("onVehicleStartEnter", root, function(plr,seat,jacked)
	if jacked then 
		if getElementData(source,"vehicle:ownedPlayer") == getElementData(plr,"player:sid") then return end
		cancelEvent()
	end
end)

addEventHandler("onVehicleStartEnter", root, function(plr,seat,jacked)
	if getVehicleController(source) == false and seat ~= 0 then cancelEvent() return end
	if seat == 0 then
		if getElementData(source,"spawnowany") == true then
			if getElementData(plr,"player:admin") == false then
				cancelEvent()
			end
		end
	end
end)

addEventHandler("onVehicleExit", root, function(plr, seat)
	if seat == 0 then
    	if getElementData(source, "vehicle:id") then
			setVehicleOverrideLights(source, 0)
		end
	end
end)

addEventHandler("onVehicleEnter", root, function(plr, seat)
	if seat == 0 then
    	if getElementData(source, "vehicle:id") then
			setElementData(source, "vehicle:driver", getPlayerName(plr):gsub("#%x%x%x%x%x%x", ""), true)
		end
	end
end)


addEventHandler("onPlayerQuit", root, function()
	local veh = getPedOccupiedVehicle(source)
    if veh then
    	if getElementData(veh, "vehicle:id") then
    		onSaveVehicle(veh)
    	end
    end
end)


addEventHandler("onResourceStop", resourceRoot, function()
    for i,v in ipairs(getElementsByType("vehicle")) do
    	onSaveVehicle(v)
    end
end)


function vTeleport()
    for k, veh in pairs(getElementsByType("vehicle")) do
		if getVehicleType(veh) ~= "Boat" then
		if getElementData(veh, "vehicle:id") then
			if isVehicleBlown(veh) then fixVehicle(veh) end
			local plr = getVehicleController(veh)

			if plr then
				local x, y, z = getElementPosition(veh)
				if isElementInWater(veh) then
					setElementPosition(veh, x, y, -1000)
				end
			else
				if isElementInWater(veh) then
					exports["nrpg_vehicles"]:onSaveVehicle(veh)
					exports["nrpg_vehicles"]:onParkVehicle(veh)
				end
			end
		else
			local x, y, z = getElementPosition(veh)
			if isElementInWater(veh) then
				setElementPosition(veh, x, y, -1000)
			end
		end
		end
    end
end
setTimer(vTeleport, 10000, 0)

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

addEventHandler("onResourceStart", resourceRoot, function() onRespawnVehicles(_, false) end)