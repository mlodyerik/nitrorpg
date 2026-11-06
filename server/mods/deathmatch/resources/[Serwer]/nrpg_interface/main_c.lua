-------------------- SKALOWANIE REDSKILL:
SW, SH = guiGetScreenSize()

local baseX = 1920
zoom = 1 
local minZoom = 2
if SW < baseX then
	zoom = math.min(minZoom, baseX/SW)
end 

function getInterfaceZoom()
	return zoom
end

-------------------- SKALOWANIE NOOBISTY:

SW2, SH2 = guiGetScreenSize()

local baseX2 = 1680
zoom2 = 1 
local minZoom2 = 2
if SW2 < baseX2 then
	zoom2 = math.min(minZoom2, baseX2/SW2)
end 

function getInterfaceZoom2()
	return zoom2
end


----------------
addEventHandler("onClientResourceStart", resourceRoot, function()
	loadGUIFonts()
end)
----------------

function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*SW,cy*SH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function dxDrawRing (posX, posY, radius, width, startAngle, amount, color, postGUI, absoluteAmount, anglesPerLine)
	if (type (posX) ~= "number") or (type (posY) ~= "number") or (type (startAngle) ~= "number") or (type (amount) ~= "number") then
		return false
	end
	
	if absoluteAmount then
		stopAngle = amount + startAngle
	else
		stopAngle = (amount * 360) + startAngle
	end
	
	anglesPerLine = type (anglesPerLine) == "number" and anglesPerLine or 1
	radius = type (radius) == "number" and radius or 50
	width = type (width) == "number" and width or 5
	color = color or tocolor (255, 255, 255, 255)
	postGUI = type (postGUI) == "boolean" and postGUI or false
	absoluteAmount = type (absoluteAmount) == "boolean" and absoluteAmount or false
	
	for i = startAngle, stopAngle, anglesPerLine do
		local startX = math.cos (math.rad (i)) * (radius - width)
		local startY = math.sin (math.rad (i)) * (radius - width)
		local endX = math.cos (math.rad (i)) * (radius + width)
		local endY = math.sin (math.rad (i)) * (radius + width)
		dxDrawLine (startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI)
	end
	return math.floor ((stopAngle - startAngle)/anglesPerLine)
end