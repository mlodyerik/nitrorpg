function glue()
	local player = getLocalPlayer()
	if not getPedOccupiedVehicle(player) then
		local vehicle = getPedContactElement(player)
		if not vehicle then return end
		if getElementType(vehicle) == "vehicle" then		
			local pc, py, pz = getElementPosition(player)
			local vc, vy, vz = getElementPosition(vehicle)
			local sc = pc - vc
			local sy = py - vy
			local sz = pz - vz
			
			local rotpc = 0
			local rotpY = 0
			local rotpZ = getPedRotation(player)
			
			local rotvc,rotvY,rotvZ = getElementRotation(vehicle)
			
			local t = math.rad(rotvc)
			local p = math.rad(rotvY)
			local f = math.rad(rotvZ)
			
			local ct = math.cos(t)
			local st = math.sin(t)
			local cp = math.cos(p)
			local sp = math.sin(p)
			local cf = math.cos(f)
			local sf = math.sin(f)
			
			local z = ct*cp*sz + (sf*st*cp + cf*sp)*sc + (-cf*st*cp + sf*sp)*sy
			local c = -ct*sp*sz + (-sf*st*sp + cf*cp)*sc + (cf*st*sp + sf*cp)*sy
			local y = st*sz - sf*ct*sc + cf*ct*sy
			
			local rotc = rotpc - rotvc
			local rotY = rotpY - rotvY
			local rotZ = rotpZ - rotvZ
			
			local slot = getPedWeaponSlot(player)
			
			--outputDebugString("gluing ".. getPlayerName(player) .." to " .. getVehicleName(vehicle) .. "(offset: "..tostring(c)..","..tostring(y)..","..tostring(z).."; rotation:"..tostring(rotc)..","..tostring(rotY)..","..tostring(rotZ)..")")
			
			triggerServerEvent("gluePlayer", player, slot, vehicle, c, y, z, rotc, rotY, rotZ)
			
			unbindKey("c","down",glue)
			bindKey("c","down",unglue)
			bindKey("jump","down",unglue)
		end
	end
end

addCommandHandler("glue",glue)

function unglue ()
	local player = getLocalPlayer()
	triggerServerEvent("ungluePlayer", player)
	unbindKey("jump","down",unglue)
	unbindKey("c","down",unglue)
	bindKey("c","down",glue)
end

addCommandHandler("unglue",unglue)

bindKey("c","down",glue)