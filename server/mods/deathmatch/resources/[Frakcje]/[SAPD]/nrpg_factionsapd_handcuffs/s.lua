kaj = {}

function zalozkaj(plr, cmd, target)
	if not target then exports.nrpg_interface:showPlayerNotification(plr, 'Użycie /zakuj <nick>', 'error') return end
	local gracz = exports["nrpg_core"]:findPlayer(plr, target)
	if getElementData(gracz, "inCar") then return end
	if isPedInVehicle(gracz) then return end
    if getElementData(plr, "player:faction") and getElementData(plr, "player:faction") == "SAPD" then
	if getElementData(plr, "kajdanki") == false then
		local gracz = getPlayerName(gracz)
		local gracz = getPlayerFromName(gracz)
		local x2,y2,z2 = getElementPosition(gracz)
		local x,y,z = getElementPosition(plr)
		local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
		if distance < 5 then
			toggleControl(gracz, "enter_exit", false)
			toggleControl(gracz, "enter_passenger", false)
			toggleControl(plr, "jump", false)
			toggleControl(plr, "sprint", false)
			attachElements(gracz, plr, 0,0.55,0)
			setElementPosition(gracz, x,y,z)
			local graczz = getPlayerName(gracz)
			kaj[plr] = {}
			kaj[plr] = {graczz}
			setElementData(plr,"kajdanki", true)
			setPedAnimation ( gracz, "FAT", "IDLE_tired", -180, true, false )
			outputChatBox("#BEBEBE"..getPlayerName(plr).."#ffffff zakuwa cię",gracz, 255,255,255,true)
			outputChatBox("Zakuwasz gracza #BEBEBE"..graczz.."#ffffff",plr,255,255,255,true)
		end
	end
end
end
addCommandHandler("zakuj", zalozkaj)

function taketocar(plr, cmd, target)
	if not target then exports.nrpg_interface:showPlayerNotification(plr, 'Użycie /wsadz <nick>', 'error') return end
	if getElementData(plr,"player:faction") and getElementData(plr,"player:faction") == "SAPD" then
		if getElementData(plr, "kajdanki") then
			local gracz = exports["nrpg_core"]:findPlayer(plr, target)
			local x,y,z = getElementPosition(plr)
			local cars = getElementsWithinRange(x, y, z, 5, "vehicle")
			local car = nil
			if #cars > 1 then
				return exports.nrpg_interface:showPlayerNotification(plr, 'W pobliżu znajduje się więcej niż jeden pojazd', 'error')
			elseif #cars == 0 or not #cars then
				return exports.nrpg_interface:showPlayerNotification(plr, 'Brak pojazdu w pobliżu', 'error')
			end
			for i,v in ipairs(cars) do
				car = v
			end

			local pass = getVehicleOccupants(car)
			local numseats = getVehicleMaxPassengers(car)
			warpPedIntoVehicle(gracz, car, numseats-(#pass))

			local atta = getAttachedElements(plr)
			for i,v in pairs(atta)do
				detachElements(v, plr)
			end
			
			kaj[plr] = {}
			setElementData(plr, "kajdanki", false)
			setElementData(gracz, "inCar", true)

			toggleControl(plr, "jump", true)
			toggleControl(plr, "sprint", true)

			toggleControl(gracz, "enter_exit", false)
			toggleControl(gracz, "enter_passenger", false)

			outputChatBox("#BEBEBE"..getPlayerName(plr).."#ffffff wsadza cię do pojazdu",gracz, 255,255,255,true)
			outputChatBox("Wsadzasz do pojazdu gracza #BEBEBE"..getPlayerName(gracz).."#ffffff",plr,255,255,255,true)
		end
	end
end
addCommandHandler("wsadz", taketocar)

function takefromcar(plr, cmd, target)
	if not target then exports.nrpg_interface:showPlayerNotification(plr, 'Użycie /wyjmij <nick>', 'error') return end
	if getElementData(plr,"player:faction") and getElementData(plr,"player:faction") == "SAPD" then
		local gracz = exports["nrpg_core"]:findPlayer(plr, target)
		if getElementData(gracz, "inCar") then
			local x2,y2,z2 = getElementPosition(gracz)
			local x,y,z = getElementPosition(plr)
			local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
			if distance < 5 then
			setElementData(gracz, "inCar", false)
			removePedFromVehicle(gracz)

			toggleControl(gracz, "enter_exit", false)
			toggleControl(gracz, "enter_passenger", false)
			toggleControl(plr, "jump", false)
			toggleControl(plr, "sprint", false)
			attachElements(gracz, plr, 0,0.55,0)
			local graczz = getPlayerName(gracz)
			kaj[plr] = {}
			kaj[plr] = {graczz}
			setElementData(plr,"kajdanki", true)
			setPedAnimation ( gracz, "FAT", "IDLE_tired", -180, true, false )

			outputChatBox("#BEBEBE"..getPlayerName(plr).."#ffffff wyciąga cię z pojazdu",gracz, 255,255,255,true)
			outputChatBox("Wyciągasz z pojazdu gracza #BEBEBE"..getPlayerName(gracz).."#ffffff",plr,255,255,255,true)
			end
		end
	end
end
addCommandHandler("wyjmij", takefromcar)

function sciagnijkaj(plr, cmd, target)
	if not target then exports.nrpg_interface:showPlayerNotification(plr, 'Użycie /rozkuj <nick>', 'error') return end
	local gracz = exports["nrpg_core"]:findPlayer(plr, target)
	if getElementData(gracz, "inCar") then return end
	if isPedInVehicle(gracz) then return end
	if getElementData(plr,"player:faction") and getElementData(plr,"player:faction") == "SAPD" then
	if getElementData(plr, "kajdanki") then
			local gracz = getPlayerName(gracz)
			local gracz = getPlayerFromName(gracz)
			local x2,y2,z2 = getElementPosition(gracz)
			local x,y,z = getElementPosition(plr)
			if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<5) then
				local atta = getAttachedElements(plr)
				toggleControl(gracz, "enter_exit", true)
				toggleControl(gracz, "enter_passenger", true)
				toggleControl(plr, "jump", true)
				toggleControl(plr, "sprint", true)

				for i,v in pairs(atta)do
					detachElements(v, plr)
				end

				setElementPosition(gracz, x+2,y,z)
				setElementData(plr,"kajdanki", false)
				kaj[plr] = {}
				outputChatBox("#BEBEBE"..getPlayerName(plr).."#ffffff rozkuwa cię",gracz, 255,255,255,true)
				outputChatBox("Rozkuwasz gracza #BEBEBE"..getPlayerName(gracz).."#ffffff",plr,255,255,255,true)
			end
		end
	end
end
addCommandHandler("rozkuj", sciagnijkaj)

