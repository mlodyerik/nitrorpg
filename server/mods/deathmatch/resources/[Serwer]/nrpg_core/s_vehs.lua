--[[
    Resource: OURGame v2
    Developers: Split <split.programista@gmail.com>
    You have no right to use this code without my permission.
    (c) 2015 <split.programista@gmail.com>. All rights reserved.
]]

-- Get vehicle keys
function getVehicleKey(plr,veh)
	if plr and veh then
		local sid=getElementData(plr,"player:sid")
		if not sid then return end
		if getElementData(plr,"player:admin") or sid == getElementData(veh,"vehicle:ownedPlayer") then
			return true
		else
			return false
		end
	end
end

local categoryL={[592] = true,[553] = true,[577] = true,[488] = true,[511] = true,[497] = true,[548] = true,[563] = true,[512] = true,[476] = true,[593] = true,[447] = true,[425] = true,[519] = true,[520] = true,[460] = true,[417] = true,[469] = true,[487] = true,[513] = true}
addEventHandler("onVehicleStartEnter", root, function(plr,seat,jacked)
	if getElementHealth(source) < 302 then
		setElementHealth(source,302)
	end
end)

function jestwtabeli(huj,truj)
    for k,v in pairs(huj) do
        if v == truj then
           return true
        end
    end
    return false
end

addCommandHandler("vdodaj",function(plr,cmd,target)
	local veh = getPedOccupiedVehicle(plr)
	if not veh then outputChatBox("* Nie siedzisz w aucie!",plr,255,0,0) return end
	if getElementData(veh,"vehicle:ownedPlayer") ~= getElementData(plr,"player:sid") then outputChatBox("* Ten pojazd nie należy od ciebie!",plr,255,0,0) return end
	if not target then
		outputChatBox("* Zabrano dostep wszystkim graczą!",plr,255,0,0)
		setElementData(veh,"vehicle:rent",0)
	else
		local target=findPlayer(plr, target)
		if not target then
			outputChatBox("* Nie znaleziono gracza online!",plr,255,0,0)
			return
		end
		local rent = getElementData(veh,"vehicle:rent")
		if (type(rent) ~= "table") then
			local tabelka = {}
			table.insert(tabelka,getElementData(target,"player:sid"))
			setElementData(veh,"vehicle:rent",tabelka)
			outputChatBox(string.format("* Dodano gracza "..getPlayerName(target).."(SID: "..getElementData(target,"player:sid")..") do wypożyczeń"),plr)
		else
			local tabelka = rent
			if jestwtabeli(tabelka,getElementData(target,"player:sid")) then outputChatBox("* Ten gracz aktualnie posiada kluczyki do twojego pojazdu!",plr) return end
 			if #tabelka > 25 then outputChatBox("* Możesz wypożyczyć maksymalnie 25 graczą!",plr) return end
			table.insert(tabelka,getElementData(target,"player:sid"))
			setElementData(veh,"vehicle:rent",tabelka)
			outputChatBox(string.format("* Dodano gracza "..getPlayerName(target).."(SID: "..getElementData(target,"player:sid")..") do wypożyczeń"),plr)
		end
	end
end)

addEventHandler ( "onVehicleEnter", getRootElement(), function(thePlayer, seat, jacked) 
	if seat==0 then
--		setVehicleDoorOpenRatio(source, 2, 0, 500)
		if (getVehicleDoorState(source,2)==0) then
		    setVehicleDoorState(source,2,1)
		    setVehicleDoorState(source,2,0)
		end
	elseif seat==1 then
		if (getVehicleDoorState(source,3)==0) then
		    setVehicleDoorState(source,3,1)
		    setVehicleDoorState(source,3,0)
		end
	else
--		if (getVehicleDoorState(source,4)==0) then
		    setVehicleDoorState(source,4,1)
		    setVehicleDoorState(source,4,0)
--		end
--		if (getVehicleDoorState(source,5)==0) then
		    setVehicleDoorState(source,5,1)
		    setVehicleDoorState(source,5,0)
--		end

	end
end)

addEventHandler("onPlayerQuit", root, function()
	if not getElementData(source,"player:job") then return end
	local veh=getPedOccupiedVehicle(source)
	if not veh then return end
	local id=getElementData(veh,"vehicle:id")
	if not id then
	if getElementData(source,"player:job") == "Sweepers" then return end
	triggerEvent("destroyVehicle", root, veh)
	end
end)

addCommandHandler("cb", function(plr, cmd, ...)
local text = table.concat({...}, ' ')
if not text then return end
if getPedOccupiedVehicle(plr) then


local auto = exports["nrpg_vehicles"]:changeName(getVehicleName(getPedOccupiedVehicle(plr)))
local mute = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_punish WHERE type=? AND active=1 AND serial=? AND time>NOW() LIMIT 1;", "mute", getPlayerSerial(plr))
if mute and #mute > 0 then
	return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
end

for _, playerCB in pairs(getElementsByType("player")) do
	if getPedOccupiedVehicle(playerCB) then
		outputChatBox("#848484[ CB: "..getElementData(plr,"id").." - "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." ] "..auto:gsub("#%x%x%x%x%x%x","")..": #ffffff"..text:gsub("#%x%x%x%x%x%x","").."", playerCB, 55, 55, 55, true)
	end
end

local desc = string.format("[#747474CB#ffffff] [%d] %s: %s",getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), text:gsub("#%x%x%x%x%x%x",""))
triggerEvent("admin:addText", resourceRoot, desc:gsub("#%x%x%x%x%x%x",""))
outputServerLog(desc:gsub("#%x%x%x%x%x%x",""))

end
end)

addCommandHandler("model", function(plr, cmd, id)
	if tonumber(id) then
		local checkID = exports["nrpg_db"]:dbGet("SELECT * from pystories_vehicles WHERE id=?", tonumber(id))
		local checkMODEL = exports["nrpg_db"]:dbGet("SELECT * from pystories_vehicles WHERE model=?", checkID[1].model)

		local totalModels = 0
		for i,v in ipairs(checkMODEL) do
			if v.id == tonumber(id) then
				exports.nrpg_interface:showPlayerNotification(plr, "Jest to "..i.." z "..(#checkMODEL).." modeli tego pojazdu na serwerze", "info", 15000)
			end
		end
	else
		exports.nrpg_interface:showPlayerNotification(plr, "Użyj: /model <id pojazdu>", "error", 15000)
	end
end)