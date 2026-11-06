--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchSkyAlt", root, true )
--
--	To switch off:
--			triggerEvent( "switchSkyAlt", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
-- Auto switch on at start
--------------------------------

function switchSkyShader(el_data_key, new_data)
    if (el_data_key == "shader:sky") then
        if getElementData(localPlayer, el_data_key) then
			startShaderResource()
	else
		stopShaderResource()
	end
    end
end
addEventHandler("onClientElementDataChange", root, switchSkyShader)

--------------------------------
-- onClientResourceStop
-- Stop the resource
--------------------------------
addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopShaderResource)
