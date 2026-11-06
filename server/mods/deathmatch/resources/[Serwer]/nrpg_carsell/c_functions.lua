sw, sh = guiGetScreenSize()
function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end
    cx,cy = getCursorPosition()
    cx,cy = cx*sw, cy*sh
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end
