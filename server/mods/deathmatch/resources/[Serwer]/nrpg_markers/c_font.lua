GUI_FONTS = {} 

function loadGUIFonts()
	GUI_FONTS = {

		["money8"] = dxCreateFont("fonts/money.ttf", 8, false, "proof"),
		["money9"] = dxCreateFont("fonts/money.ttf", 9, false, "proof"),
		["money10"] = dxCreateFont("fonts/money.ttf", 10, false, "proof"),
		["money11"] = dxCreateFont("fonts/money.ttf", 11, false, "proof"),
		["money12"] = dxCreateFont("fonts/money.ttf", 12, false, "proof"),
		["money13"] = dxCreateFont("fonts/money.ttf", 13, false, "proof"),
		["money14"] = dxCreateFont("fonts/money.ttf", 14, false, "proof"),
		["money15"] = dxCreateFont("fonts/money.ttf", 15, false, "proof"),
		["money16"] = dxCreateFont("fonts/money.ttf", 16, false, "proof"),
		["money17"] = dxCreateFont("fonts/money.ttf", 17, false, "proof"),
		["money18"] = dxCreateFont("fonts/money.ttf", 18, false, "proof"),
		["money19"] = dxCreateFont("fonts/money.ttf", 19, false, "proof"),
		["money20"] = dxCreateFont("fonts/money.ttf", 20, false, "proof"),
		["money21"] = dxCreateFont("fonts/money.ttf", 21, false, "proof"),
		["money22"] = dxCreateFont("fonts/money.ttf", 22, false, "proof"),
		["money23"] = dxCreateFont("fonts/money.ttf", 23, false, "proof"),
		["money24"] = dxCreateFont("fonts/money.ttf", 24, false, "proof"),
		["money25"] = dxCreateFont("fonts/money.ttf", 25, false, "proof"),
		["money26"] = dxCreateFont("fonts/money.ttf", 26, false, "proof"),
		["money27"] = dxCreateFont("fonts/money.ttf", 27, false, "proof"),
		["money28"] = dxCreateFont("fonts/money.ttf", 28, false, "proof"),
		["money29"] = dxCreateFont("fonts/money.ttf", 29, false, "proof"),
		["money30"] = dxCreateFont("fonts/money.ttf", 30, false, "proof"),
		["money150"] = dxCreateFont("fonts/money.ttf", 50, false, "proof"),
		
	}
end 

function getGUIFont(font)
	return GUI_FONTS[font] or "default-bold"
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	loadGUIFonts()
end)