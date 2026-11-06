
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
	if string.find(getResourceName(v), "nrpg") or string.find(getResourceName(v), "community") or string.find(getResourceName(v), "pystories") or string.find(getResourceName(v), "map") or string.find(getResourceName(v), "psrpg") or string.find(getResourceName(v), "podmianka") then
        startResource(v)
        outputDebugString(getResourceName(v).." started.")
        end
    end
end)