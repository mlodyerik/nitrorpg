function switchSShadowShader(el_data_key, new_data)
    if (el_data_key == "shader:shadow") then
        if getElementData(localPlayer, el_data_key) then
		enableAO()
	else
		disableAO()
	end
    end
end
addEventHandler("onClientElementDataChange", root, switchSShadowShader)