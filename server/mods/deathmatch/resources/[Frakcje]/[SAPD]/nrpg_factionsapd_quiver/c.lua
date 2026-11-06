function pobierzPozycjeKol(veh, kolo)
	local x, y, z = 0, 0, 0
	if not veh then return end
	local x1, y1, z1, x2, y2, z2 = getElementBoundingBox(veh)
	if kolo == 1 then
		x, y, z = pobierzPozycje(veh, x1, y2, z1)
	elseif kolo == 2 then
		x, y, z = pobierzPozycje(veh, x1, -y2, z1)		
	elseif kolo == 3 then
		x, y, z = pobierzPozycje(veh, x2, y2, z1)
	elseif kolo == 4 then
		x, y, z = pobierzPozycje(veh, x2, -y2, z1)
	end	 
	return x, y, z
end

function pobierzPozycje(plr, x, y, z)
	if not x or not y or not z then      
		return x, y, z   
	end        
	local matrix = getElementMatrix(plr)
	local pozX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
	local pozY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
	local pozZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
	return pozX, pozY, pozZ
end

function pobierzPunkt(plr, dystans)
    local x, y, z = getElementPosition(plr)
    local rx, ry, rz = getElementRotation(plr)
    x = x + (dystans * (math.sin(math.rad(-rz))))
    y = y + (dystans * (math.cos(math.rad(-rz))))
	return x,y,z
end

addEventHandler("onClientPreRender", root,
function()
	if isPlayerInVehicle(localPlayer) then
	 	local veh = getPedOccupiedVehicle(localPlayer)
		if not veh then return end
		
		local kolczatki = getElementsByType("object", getResourceRootElement(getThisResource()))
		
		local wx1, wy1, wz1 = pobierzPozycjeKol(veh, 1)
		local wx2, wy2, wz2 = pobierzPozycjeKol(veh, 2)
		local wx3, wy3, wz3 = pobierzPozycjeKol(veh, 3)
		local wx4, wy4, wz4 = pobierzPozycjeKol(veh, 4)
		for k, v in ipairs(kolczatki) do
			if getElementData(v,"kolczatka:Policja") == true then
				local x, y, z = getElementPosition(v)
				if getDistanceBetweenPoints3D(wx1, wy1, wz1, x, y, z) <= 1.0 then
					triggerServerEvent("przebijOpone", localPlayer, veh, 1, -1, -1, -1)
				end
				if getDistanceBetweenPoints3D(wx2, wy2, wz2, x, y, z) <= 1.0 then
					triggerServerEvent("przebijOpone", localPlayer, veh, -1, 1, -1, -1)
				end
				if getDistanceBetweenPoints3D(wx3, wy3, wz3, x, y, z) <= 1.0 then
					triggerServerEvent("przebijOpone", localPlayer, veh, -1, -1, 1, -1)
				end
				if getDistanceBetweenPoints3D(wx4, wy4, wz4, x, y, z) <= 1.0 then
					triggerServerEvent("przebijOpone", localPlayer, veh, -1, -1, -1, 1)
				end		
			end										
		end
	 end
end)

function ustawKolczatke()
	local x, y, z = pobierzPunkt(localPlayer, 3)
	local rx, ry ,rz = getElementRotation(localPlayer)
	local z = getGroundPosition(x, y, z)
	triggerServerEvent("utworzKolczatke", resourceRoot, x, y, z, rx, ry ,rz)
end
addCommandHandler("kolczatka", ustawKolczatke)