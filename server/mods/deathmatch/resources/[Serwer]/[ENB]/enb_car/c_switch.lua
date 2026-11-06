function switchSCarShader(el_data_key, new_data)
    if (el_data_key == "shader:car") then
        if getElementData(localPlayer, el_data_key) then
		startCarPaintReflect()
	else
		stopCarPaintReflect()
	end
    end
end
addEventHandler("onClientElementDataChange", root, switchSCarShader)