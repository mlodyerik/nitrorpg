screenW, screenH = guiGetScreenSize()
zoom = exports.nrpg_interface:getInterfaceZoom()
interfaceLibary = exports.nrpg_lib

interface = {

    background = interfaceLibary:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(40, 40, 40, 255)),
    colorBackground = interfaceLibary:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 175, 0, 255)),
    theRectangle = interfaceLibary:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 100, 255)),
    theRectangle2 = interfaceLibary:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 100, 255)),
    scrollRectangle = interfaceLibary:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),

}

dashboardPos = {

    x = 0, 
    y = 0, 
    w = math.floor(950/zoom), 
    h = math.floor(550/zoom),

}
dashboardPos.x = screenW-dashboardPos.w-math.floor(475/zoom)
dashboardPos.y = screenH/2-dashboardPos.h+math.floor(300/zoom)

function drawScrollbar(table, x, y, height, m_, k_)
    dxDrawImage(x, y, 8, height, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

	if #table > m_ then
    	local scrollbarHeight = height/#table

   		if k_ == 1 then 
        	scrollbarPos = y
    	elseif k_ > 1 then 
        	scrollbarPos = ((k_)*scrollbarHeight)+y
    	end

    	if #table <= m_ then 
        	scrollbarHeight = height
    	end
		
		dxDrawImage(x, scrollbarPos, 8, scrollbarHeight*(m_-1), interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
    else
        dxDrawImage(x, y, 8, height, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end

    cx,cy = getCursorPosition()
    cx,cy = cx*screenW, cy*screenH

    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end