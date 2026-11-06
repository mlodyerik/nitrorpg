--[[

@author: TheNoobisty | Kacper Glazer | thenoobisty@gmail.com
@for: DemusMTA
@info: Zabrania się kopiowania kodu bez zgody jego autora.

--]]

local zoom = 1
local sw,sh = guiGetScreenSize()
local b_texture= dxCreateTexture('button.png','argb', true, 'clamp')
local b_texture_on = dxCreateTexture('button_on.png','argb', true, 'clamp')

if sw < 1920 then
    zoom = math.min(2, 1920 / sw)
end

a_on = {}
a_on2 = {}
a_txt = {}
a_txt2 = {}
tick = getTickCount(  )

main = {

    lib = exports.nrpg_lib,

}

interface = {}
interface.buttonRectangle = main.lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(30, 30, 60, 255)) 
interface.buttonRectangle2 = main.lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(45, 45, 45, 255)) 

function dxCreateButton(txt, x, y, w, h, id, color, font)
    if not a_on[id] then a_on[id] = 0 end
    if not a_on2[id] then a_on2[id] = 0 end
    if not a_txt[id] then a_txt[id] = 200 end

    if color then
        main.lib:dgsRoundRectSetColor(interface.buttonRectangle,tocolor(color[1], color[2], color[3], (color[4] or 255)))
        alpha = color[4]
    else
        main.lib:dgsRoundRectSetColor(interface.buttonRectangle,tocolor(30, 30, 60, 255))
        alpha = 200
    end

    if isMouseIn(x,y,w,h) then
        if getKeyState("mouse1") then
            
            dxDrawImage(x,y,w,h, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 145), false)
            dxDrawText(txt, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true)  
        else
            
            dxDrawImage(x,y,w,h, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 155), false)
            dxDrawText(txt, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true)  
        end
    else
        
        dxDrawImage(x,y,w,h, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 175), false) 
        dxDrawText(txt, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true)
    end
end


function dxCreateText(txt, x, y, w, h, id)
    if not a_txt2[id] then a_txt2[id] = 0 end
    if isMouseIn(x,y,w,h) then
        a_txt2[id] = a_txt2[id] + 5 <= 255 and a_txt2[id] + 5 or 255
        else
        a_txt2[id] = a_txt2[id] - 5 >= 55 and a_txt2[id] - 5 or 55
    end
    if isMouseIn(x,y,w,h) then
        dxDrawText(txt, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, a_txt2[id]), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, true)
    else
        dxDrawText(txt, x+2, y+2, w+x, h+y, tocolor(255, 255, 255, a_txt2[id]), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, true)
    end
end


function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sw,cy*sh
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end