data = {

	tick = getTickCount(),
	render_targets = {},
	render_targets_update = getTickCount()-10000,

	icons = {

		["default"] = dxCreateTexture("img/default.png"),
		["station"] = dxCreateTexture("img/station.png"),
		["door"] = dxCreateTexture("img/door.png"),
		["parking"] = dxCreateTexture("img/parking.png"),
		["tuning"] = dxCreateTexture("img/tuning.png"),
		["mechanic"] = dxCreateTexture("img/mechanic.png"),
		["engine"] = dxCreateTexture("img/engine.png"),
		["spray"] = dxCreateTexture("img/spray.png"),
		["pack"] = dxCreateTexture("img/pack.png"),

	},

	images = {

		["marker"] = dxCreateTexture("img/marker.png"),

	},
	
	ground = {},
	markerData  = {},
	groundCount = 5,
	groundSize = 10,

}

data.renderMarker = function(marker, pos)
		x, y, z = pos[1], pos[2], pos[3]
		z=z+0.01

		if not data.render_targets[marker] then
			data.render_targets[marker] = dxCreateRenderTarget(512, 512, true);
		end


		dxSetRenderTarget(data.render_targets[marker], true)
    	dxSetBlendMode("modulate_add")
		

    	local text = getElementData(marker, "marker:text") -- Górny napis
    	local downtext = getElementData(marker, "marker:downtext") -- Dolny napis
		local icon = getElementData(marker, "marker:icon") -- Ikona
		local r, g, b = getMarkerColor(marker) -- Pobieranie koloru z markeru
		local markerSize = getMarkerSize(marker)
		local px, py, pz = getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints3D(px, py, pz, x, y, z)

		if not icon then
			dxDrawImage(185, 5, 140, 115, data.icons["default"], 0, 0, 0, tocolor(r, g, b, 255), false)
		else
			dxDrawImage(185, 5, 140, 115, data.icons[icon], 0, 0, 0, tocolor(r, g, b, 255), false)
		end

    	dxDrawText(text or " ", 0, 225, 512, 50, tocolor(255, 255, 255, 255), 1, getGUIFont("money20"), "center", "center", false, false, false, true)
    	dxDrawText(downtext or " ", 0, 280, 512, 50, tocolor(225, 225, 225, 255), 1, getGUIFont("money12"), "center", "center", false, false, false, true)


    	dxSetBlendMode("blend")
    	dxSetRenderTarget() 

		local z2 = interpolateBetween(z, 0, 0, z-0.1, 0, 0, (getTickCount()-data.tick)/2500, 'SineCurve')

    	dxDrawMaterialLine3D(x, y, z2+2, x, y, z2-1, data.render_targets[marker], 2.5, tocolor(255,255,255,255))


    for i = 1, data.groundCount do
        local size = data.ground[i].value * markerSize
        dxDrawMaterialLine3D(x - size, y, z, x + size, y, z, data.images["marker"], size * 2, tocolor(r, g, b, 255 * (1 - data.ground[i].value)), false, x, y, z + 0.5)
    end
end

data.ground = {}
progress = {}

for i = 1, data.groundCount do
	data.ground[i] = {value = 0, tick = getTickCount() - 1000 * i}
end

for i,v in ipairs(getElementsByType("marker")) do
	setElementAlpha(v, 0)
end

addEventHandler("onClientPreRender", root, function()
	for element, render_target in pairs(data.render_targets) do
		if not render_target then break end
			if not isElement(element) then
				destroyElement(render_target)
				data.render_targets[element] = false
			break 
		end
	end

	for i = 1, data.groundCount do
		progress[i] = (getTickCount() - data.ground[i].tick)/(data.groundCount * 1000)
	    if progress[i] >= 0 then
    	    data.ground[i].value = interpolateBetween(0, 0, 0, 1, 0, 0, progress[i], "Linear")
        	if progress[i] >= 1 then
            	data.ground[i].tick = getTickCount()
        	    data.ground[i].value = 0
    	    end
		end
	end

	local x,y,z = getElementPosition(localPlayer)
	local markers = getElementsWithinRange(x, y, z, 35, "marker")
	for i,v in ipairs(markers) do
		if getMarkerType(v) == "cylinder" and getElementDimension(v) == getElementDimension(localPlayer) and getElementInterior(v) == getElementInterior(localPlayer) then
			local x,y,z = getElementPosition(v)
			local r, g, b = getMarkerColor(v)
			data.renderMarker(v, {x,y,z})
			setMarkerColor(v, r, g, b, 0)
		end
	end
end)

setTimer(function()
data.ground = {}
progress = {}

for i = 1, data.groundCount do
	data.ground[i] = {value = 0, tick = getTickCount() - 1000 * i}
end
end, 5000, 0)