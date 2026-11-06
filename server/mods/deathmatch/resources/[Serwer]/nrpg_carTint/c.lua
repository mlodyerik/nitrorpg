local shaders = {}

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
        if getElementData(source, "vehicle:id") then
		    local carTint = getElementData(source, "vehicle:carTint")
		
		    if carTint then
                applyWindowTint(source, carTint)
		    end
        end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
		if getElementData(source, "vehicle:id") then
			if getElementData(source, "vehicle:carTint") then
				destroyTint(source)
			end
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		if getElementData(source, "vehicle:id") then
			local carTint = getElementData(source, "vehicle:carTint")
		
			if carTint then
				destroyTint(source)
			end
		end
	end
end)

function switchTint(el_data_key, new_data)
	if (getElementType(source) == "vehicle") then
    	if (el_data_key == "vehicle:carTint") then
			for i,v in ipairs(getElementsByType("vehicle")) do
				if v == source then
					local getData = getElementData(v, "vehicle:carTint")
					if getData then
						applyWindowTint(source, getData)
					end
				end
			end
    	end
	end
end
addEventHandler("onClientElementDataChange", root, switchTint)

function applyWindowTint(veh, percent)
    if veh and percent then
        destroyTint(veh)

        shaders[veh] = dxCreateShader("szyby.fx", 1, 200, true)
        engineApplyShaderToWorldTexture(shaders[veh], "vehiclegeneric256", veh)
		engineApplyShaderToWorldTexture(shaders[veh], "@hite", veh)
		engineApplyShaderToWorldTexture(shaders[veh], "car_tint", veh)
		engineApplyShaderToWorldTexture(shaders[veh], "lob_steklo", veh)
		engineApplyShaderToWorldTexture(shaders[veh], "1", veh)
        dxSetShaderValue(shaders[veh], "tint_level", percent)
    end
end

function destroyTint(veh)
    if isElement(shaders[veh]) then
        destroyElement(shaders[veh]) 
        return true
    else
        return false
    end
end