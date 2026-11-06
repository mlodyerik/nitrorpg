																																													--[[
Author: TheNoobisty
For: DemusMTA
Contact: thenoobisty@gmail.com

																																													]]--

local shader, masked, myAvatar
masked = dxCreateTexture('mask.png')
shader = dxCreateShader('masked.fx')

addEvent( "onClientGotImage", true )
addEventHandler( "onClientGotImage", resourceRoot, function(pixel)
if myAvatar then
    destroyElement( myAvatar )
end
myAvatar = dxCreateTexture(pixel)
    
dxSetShaderValue(shader, 'sPicTexture', myAvatar)
dxSetShaderValue(shader, 'sMaskTexture', masked)
dxSetShaderValue(shader, 'gUVScale', 1, 1)
end)

textures = {

	hud_bg = dxCreateTexture('hud_bg.png'),
	hud_border_shadow = dxCreateTexture('hud_border_shadow.png'),
	hud_border = dxCreateTexture('hud_border.png'),

}


function dxCreateAvatar(x, y, w, h, alpha, color)	
	if color then
		theColor = color
	else
		theColor = tocolor(125, 125, 125, 255)
	end

    if myAvatar then
        dxDrawImage(x,y,w,h, textures.hud_bg, 0, 0, 0, tocolor(45, 45, 45, alpha), false)
        dxDrawImage(x,y,w,h, shader, 0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawImage(x,y,w,h, textures.hud_border_shadow, 0, 0, 0, tocolor(0, 0, 0, alpha), false)
		dxDrawImage(x,y,w,h, textures.hud_border, 0, 0, 0, tocolor(0, 0, 0, alpha), false)
		dxDrawImage(x,y,w,h, textures.hud_border, 0, 0, 0, theColor, false)
    else
        dxDrawImage(x,y,w,h, textures.hud_bg, 0, 0, 0, tocolor(45, 45, 45, alpha), false)
        dxDrawImage(x,y,w,h, "no_avatar.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawImage(x,y,w,h, textures.hud_border_shadow, 0, 0, 0, tocolor(0, 0, 0, alpha), false)
		dxDrawImage(x,y,w,h, textures.hud_border, 0, 0, 0, tocolor(0, 0, 0, alpha), false)
		dxDrawImage(x,y,w,h, textures.hud_border, 0, 0, 0, theColor, false)
    end
end