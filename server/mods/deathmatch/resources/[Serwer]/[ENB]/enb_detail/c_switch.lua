function switchSColorShader(el_data_key, new_data)
    if (el_data_key == "shader:detail") then
        if getElementData(localPlayer, el_data_key) then
		enableDetail()
	else
		disableDetail()
	end
    end
end
addEventHandler("onClientElementDataChange", root, switchSColorShader)