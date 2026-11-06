sx, sy = guiGetScreenSize()

local zoom = 1 
if sx < 1920 then
	zoom = math.min(2, 1920/sx)
end

function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end