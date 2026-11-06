function switchSWaterShader(el_data_key, new_data)
    if (el_data_key == "shader:water") then
        if getElementData(localPlayer, el_data_key) then
		enableWaterRef()
	else
		disableWaterRef()
	end
    end
end
addEventHandler("onClientElementDataChange", root, switchSWaterShader)