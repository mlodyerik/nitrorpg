local vehiclesWithPaintjob = {}

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
		local paintJob = getElementData(source, "vehicle:paintjob")
		
		if paintJob ~= 0 then
			addVehiclePaintjob(source, paintJob)
		end
	end
end)

function switchPaintJob(el_data_key, new_data)
	if (getElementType(source) == "vehicle") then
    	if (el_data_key == "vehicle:paintjob") then
			if new_data ~= false then
				for i,v in ipairs(getElementsByType("vehicle")) do
					if v == source then
						addVehiclePaintjob(v, tonumber(new_data))
					end
				end
			end
    	end
	end
end
addEventHandler("onClientElementDataChange", root, switchPaintJob)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
		if getElementData(source, "vehicle:id") then
			if getElementData(source, "vehicle:paintjob") then
				removeVehiclePaintjob(source)
			end
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		if getElementData(source, "vehicle:id") then
			local isVehicleHavePaintjob = getElementData(source, "vehicle:paintjob")
		
			if isVehicleHavePaintjob ~= 0 then
				removeVehiclePaintjob(source)
			end
		end
	end
end)

paintJobs = {}

function loadPaintJobs()
	for i = 1, 12 do
		paintJobs[i] = dxCreateTexture("files/"..i..".png")
	end
end
loadPaintJobs()

function addVehiclePaintjob(vehicle, paintjobID)
	if vehicle and paintjobID then
		if getElementData(vehicle, "vehicle:id") then
				removeVehiclePaintjob(vehicle)
			
				vehiclesWithPaintjob[vehicle] = {}
				vehiclesWithPaintjob[vehicle][1] = dxCreateShader("files/textureChanger.fx", 0, 100, false, "vehicle")
			
			if vehiclesWithPaintjob[vehicle][1] and paintJobs[paintjobID] then
				dxSetShaderValue(vehiclesWithPaintjob[vehicle][1], "TEXTURE", paintJobs[paintjobID])
				engineApplyShaderToWorldTexture(vehiclesWithPaintjob[vehicle][1], "*vehiclegrunge256*", vehicle)
				engineApplyShaderToWorldTexture ( vehiclesWithPaintjob[vehicle][1], "?emap*", vehicle)
			end
		end
	end
end

function removeVehiclePaintjob(vehicle)
	if vehicle then
		if vehiclesWithPaintjob[vehicle] then
			local paintjobID = getElementData(vehicle, "vehicle:paintjob")
			if not paintjobID then return end
			destroyElement(vehiclesWithPaintjob[vehicle][1])
			vehiclesWithPaintjob[vehicle] = nil
		end
	end
end