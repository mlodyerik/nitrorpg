function drawDashboardButton(text, x, y, x2, y2)
	if isMouseIn(x-2, y, x2+4, y2) then
		dxDrawImage(x-2, y, x2+4, y2, interface.customButton2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(x-2, y, x2+4, y2, interface.customButton, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end

	dxDrawText(text, x, y, x2+x, y2+y, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
end

function drawScrollbar(table, x, y, height, barheight, m_, k_)
    dxDrawImage(x, y, 6, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 25), false)

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
		
		dxDrawImage(x, scrollbarPos, 6, scrollbarHeight*(m_-1), interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
    else
        dxDrawImage(x, y, 6, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

tabelka = {}
loaded = {}

function drawUserAvatar(x, y, xx, yy, userSID, userStatus)
	dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

	if tabelka[userSID] then
		dxDrawImage(x, y, xx, yy, tabelka[userSID][2], 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end

	if userStatus then
		if userStatus == "Online" then
			dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_border.png", 0, 0, 0, tocolor(25, 255, 25, 255), false)
			dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_border.png", 0, 0, 0, tocolor(25, 255, 25, 255), false)
			dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_border.png", 0, 0, 0, tocolor(25, 255, 25, 255), false)
		else
			dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_border.png", 0, 0, 0, tocolor(255, 25, 25, 255), false)
			dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_border.png", 0, 0, 0, tocolor(255, 25, 25, 255), false)
			dxDrawImage(x, y, xx, yy, ":nrpg_avatars/hud_border.png", 0, 0, 0, tocolor(255, 25, 25, 255), false)
		end
	end
end


maska = dxCreateTexture('files/mask.png')

addEvent( "showClientUserAvatar", true )
addEventHandler( "showClientUserAvatar", resourceRoot,
    function( pixels, plrSID )
        avatars = dxCreateTexture(pixels)
        if avatars then
            costam = dxCreateShader("files/masked.fx")
            dxSetShaderValue( costam, "sPicTexture", avatars)
            dxSetShaderValue( costam, "sMaskTexture", maska)
            tabelka[plrSID] = {plrSID, costam} 
        end
    end
)