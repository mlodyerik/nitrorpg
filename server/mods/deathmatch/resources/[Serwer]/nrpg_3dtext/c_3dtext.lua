local textss = {

	--{-2533.52, -29.39, 16.52, "Przechowalnia\nOdbiór pojazdów"},

}

tick = getTickCount()

for i,v in ipairs(textss) do
	t = createMarker(v[1], v[2], v[3]-1, "cylinder", 1, 0, 0, 0, 0)
	setElementData(t, "marker:text", v[4])
end


local text= {}
addEventHandler('onClientElementStreamIn', root, function()
    if(getElementType(source) == "marker")then
        local visibleText = (getElementData(source, "marker:text") or "").."\n"..(getElementData(source, "marker:downtext") or "");
        if visibleText then
            text[#text + 1] = {
                marker = source;
                pos = Vector3(getElementPosition(source)),
                visibleText = visibleText,
            };
        end;
        toogle()
    end;
end)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
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

addEventHandler('onClientElementStreamOut',root,function()
    if(getElementType(source) == "marker")then
        for i = 1, #text do 
            local v = text[i];
            if not v then return end
            if(source == v.marker)then 
                table.remove(text, i);
            end;
        end;
        toogle()
    end;
end)

function toogle()
    if #text == 0 then
        if isEventHandlerAdded( 'onClientRender', root, renderMarkers) then
           -- removeEventHandler('onClientRender',root,renderMarkers);
        end
    else
        if not isEventHandlerAdded( 'onClientRender', root, renderMarkers) then
           -- addEventHandler('onClientRender',root,renderMarkers);
        end
    end
end

function renderMarkers()
    for i = 1,#text do
        local v = text[i]
        if v.marker and isElement(v.marker) and getMarkerType(v.marker) == "cylinder" then
            if v.marker then
                local px, py, pz, tx, ty, tz, dist
                px, py, pz = getCameraMatrix( )
                tx, ty, tz = getElementPosition( v.marker )
                dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
                if dist < 20 then
                    local sx, sy, sz = getElementPosition( v.marker )
                    sz=sz+1
                    local x, y = getScreenFromWorldPosition(sx, sy, sz, 100, true)
                    if x then 
			   			dxDrawText(v.visibleText:gsub("#%x%x%x%x%x%x",""), x+1, y+1, x, y, tocolor(0, 0, 0, 200), 0.7, (exports.nrpg_interface:getGUIFont("money10") or "default-bold"), "center", "center", false, false, false, true)
			   			dxDrawText(v.visibleText, x, y, x, y, tocolor(255, 255, 255, 230), 0.7, (exports.nrpg_interface:getGUIFont("money10") or "default-bold"), "center", "center", false, false, false, true)
                    end
			    end
            end
        end
    end
end

function math.percent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        return (maxvalue*percent)/100
    end
    return false
end

local descSize = 0.85

function renderVehicleTags()
    for i,v in ipairs(getElementsByType("vehicle")) do
        if v and isElement(v) and getElementData(v, "vehicle:desc") and getElementDimension(v) == getElementDimension(localPlayer) then
            local px, py, pz, tx, ty, tz, dist
            px, py, pz = getElementPosition( localPlayer )
            tx, ty, tz = getElementPosition( v )
            dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
            if dist < 20 then
                local sx, sy, sz = getElementPosition( v )
                local x, y = getScreenFromWorldPosition(sx, sy, sz, 100, true)

                if x then 
                    local x, y = math.floor(x), math.floor(y)

			   		dxDrawText(getElementData(v, "vehicle:desc"):gsub("#%x%x%x%x%x%x",""), x+1, y+1, x, y, tocolor(0, 0, 0, 245-dist*10), descSize-dist/35, (exports.nrpg_interface:getGUIFont("money10") or "default-bold"), "center", "center", false, false, false, true)
			   		dxDrawText(getElementData(v, "vehicle:desc"), x, y, x, y, tocolor(255, 255, 255, 245-dist*10), descSize-dist/35, (exports.nrpg_interface:getGUIFont("money10") or "default-bold"), "center", "center", false, false, false, true)
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, renderVehicleTags)

