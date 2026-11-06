local vehicles = {}

addEventHandler( "onClientElementStreamIn", root, function()
    if getElementType(source)  == 'vehicle' and getElementData(source, "vehicle:id") then
        if exports["nrpg_vehicles"]:getTuning(source, "Neon") then
            vehicles[#vehicles + 1] = {
                vehicle = source,
                neon = exports["nrpg_vehicles"]:getTuning(source, "Neon"),
                isRGB = exports["nrpg_vehicles"]:getTuning(source, "NeonRGB"),
            }
            
            if #vehicles > 0 then
                if not isEventHandlerAdded("onClientPreRender", root, renderNeons) then
                    addEventHandler("onClientPreRender", root, renderNeons)
                end
            end
        end
    end
end)
 
addEventHandler( "onClientElementStreamOut", root, function()
    if getElementType(source)  == 'vehicle' then
        for i = 1,#vehicles do
            local v = vehicles[i];
            if not v then return end

            if(source == v.vehicle)then
                table.remove(vehicles, i);
            end;
        end

        if #vehicles == 0 then
            if isEventHandlerAdded("onClientPreRender", root, renderNeons) then
                removeEventHandler("onClientPreRender", root, renderNeons)
            end
        end
    end
end)

for i,v in ipairs(getElementsByType("vehicle")) do
    if getElementData(v, "vehicle:id") then
        if exports["nrpg_vehicles"]:getTuning(v, "Neon") then
            vehicles[#vehicles + 1] = {
                vehicle = v,
                neon = exports["nrpg_vehicles"]:getTuning(v, "Neon"),
                isRGB = exports["nrpg_vehicles"]:getTuning(source, "NeonRGB"),
            }
        end
    end
end

setTimer(function()
    if #vehicles > 0 then
        if not isEventHandlerAdded("onClientPreRender", root, renderNeons) then
            addEventHandler("onClientPreRender", root, renderNeons)
        end
    end
end, 1000, 1)

local textures = {

    [1] = dxCreateTexture("neons/1.png"),
    [2] = dxCreateTexture("neons/2.png"),
    [3] = dxCreateTexture("neons/3.png"),
    [4] = dxCreateTexture("neons/4.png"),
    [5] = dxCreateTexture("neons/5.png"),
    [6] = dxCreateTexture("neons/6.png"),

}

addEventHandler( "onResourceStop", resourceRoot, function( resource )
    for i,v in ipairs(textures) do
        if isElement(textures[i]) then
            destroyElement(textures[i])
        end
    end
end)

local frequency = 3

function renderNeons()
    for i = 1, #vehicles do
        local v = vehicles[i]
        if isElement(v.vehicle) then
            if isElementStreamedIn(v.vehicle) then
                if isVehicleOnGround(v.vehicle) and v.neon and isElementOnScreen(v.vehicle) then
                    if (not getElementData(v.vehicle, "vehicle:neon:state")) then
                        local rootx, rooty, rootz = getCameraMatrix()
                        local x, y, z = getElementPosition(v.vehicle)
                        local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
                        if isLineOfSightClear(rootx, rooty, rootz, x, y, z, false, false, false) and 30 >= distance then  
                            local vehicleFront = v.vehicle.matrix.forward*3
                            local x1, y1, z1 = x+vehicleFront['x'], y+vehicleFront['y'], z+vehicleFront['z']
                            local x2, y2, z2 = x-vehicleFront['x'], y-vehicleFront['y'], z-vehicleFront['z']

                            if v.isRGB then
                                local curtime = getTickCount() / 1000
			                    r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
			                    g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
			                    b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
                                color = {r, g, b}
                            else
                                color = getElementData(v.vehicle, "neonColor") or {255, 255, 255}
                            end
                            
                            local data = getElementData(v.vehicle, "vehicle:neon")

                            g1 = getGroundPosition(x1, y1, z1)
                            g2 = getGroundPosition(x2, y2, z2)
                            
                            if v.neon then
                                dxDrawMaterialLine3D(x1, y1, g1+0.03, x2, y2, g2+0.03, textures[data], 2.75, tocolor(color[1], color[2], color[3], 175), x1+0.01, y1+0.01, g1-1.5)
                            end
                        end
                    end
                end
            end
        end
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end