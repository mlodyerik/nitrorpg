main = {}

sx,sy = guiGetScreenSize()
screenW, screenH = guiGetScreenSize()
w, h = (screenW/1366), (screenH/768)

zoom = 1
if sx < 1366 then
    zoom = math.min(2, 1366 / sx)
end

main.checkRender = function(value)
    if value == true then

    end
end
addEvent("discordResultClient", true)
addEventHandler("discordResultClient", root, main.checkRender)


main.isEventHandlerAdded = function( sEventName, pElementAttachedTo, func )
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