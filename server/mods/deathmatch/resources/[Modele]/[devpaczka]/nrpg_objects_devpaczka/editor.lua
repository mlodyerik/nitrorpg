local sx, sy = guiGetScreenSize()
local baseX = 2048
zoom = 1 
local minZoom = 2.2
if sx < baseX then
	zoom = math.min(minZoom, baseX/sx)
end
local currentSelected = nil
local normal_small = dxCreateFont("data/font.ttf", 14, false, "antialiased")
local normal_big = dxCreateFont("data/font.ttf", 28, false, "antialiased")
local editingData = {1, "a", 1}
local texturesCount = 343
local tex = false
local gui = guiCreateWindow(sx-550/zoom, sy-600/zoom, 500/zoom, 480/zoom, "libEditor v1.2", false)
guiSetVisible(gui, tex)

function isMouseInPosition(x, y, width, height)
	if(not isCursorShowing()) then
		return false
	end
	local cx, cy = getCursorPosition()
	local cx, cy =(cx * sx),(cy * sy)
	return((cx >= x and cx <= x + width) and(cy >= y and cy <= y + height))
end

addCommandHandler("tex", function(plr)
	if getPlayerSerial(plr) ~= "4789529C23F91124DE049851CFCDAC02" then return end
	tex = not tex
	guiSetVisible(gui, tex)
end)

addEventHandler("onClientClick", root, function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if button ~= "left" or state ~= "down" then return end
	if not tex then return end
	local x, y = guiGetPosition(gui, false)
	local y = y + 20/zoom
	local w, h = guiGetSize(gui, false)
	size = (h - 150/zoom)
	if isMouseInPosition(x + 30/zoom, y + 30/zoom, 160/zoom, 46/zoom) then
		if editingData[2] == "a" then
			editingData[2] = "b"
		else
			editingData[2] = "a"
		end
		return
	end
	if currentSelected and isElement(currentSelected) then
		for i = 0, 3 do
			if isMouseInPosition(x + 55/zoom + 100/zoom*i, y + 100/zoom, 90/zoom, 90/zoom) then
				setElementData(currentSelected, editingData[2] .. "Texture", editingData[1] + 0 + i)
				return
			end
		end
	end
	if currentSelected then
		for i = 0, 3 do
			for sc = 1, (size / (100/zoom)) do
				if isMouseInPosition(x + 55/zoom + 100/zoom*i, y + (100 * sc)/zoom, 90/zoom, 90/zoom) then
					if fileExists("data/images/" .. editingData[1] + 0 + (sc - 1)*4 + i .. ".jpg") then
						setElementData(currentSelected, editingData[2] .. "Texture", editingData[1] + 0 + (sc - 1)*4 + i)
						return
					end
				end
			end
		end
	end
	if isMouseInPosition(x + 465/zoom, y + 80/zoom, 20/zoom, 350/zoom) then
		return
	end
	if clickedElement and getElementType(clickedElement) == "object" and not isMouseInPosition(x, y, 500/zoom, 480/zoom) then
		currentSelected = clickedElement
		return
	end
end)

bindKey("mouse_wheel_down", "down", function()
	if not tex then return end
	if editingData[1] < 334 then
		editingData[1] = editingData[1] + 4
	end
end)

bindKey("mouse_wheel_up", "down", function()
	if not tex then return end
	if editingData[1] > 4 then
		editingData[1] = editingData[1] - 4
	end
end)

addEventHandler("onClientRender", root, function()
	if not guiGetVisible(gui) then return end
	local x, y = guiGetPosition(gui, false)
	local w, h = guiGetSize(gui, false)
	if w ~= 500/zoom then
		w = 500/zoom
	end
	if h < 480/zoom then
		h = 480/zoom
	end
	guiSetSize(gui, w, h, false)
	local y = y + 20/zoom
	size = (h - 150/zoom)
	dxDrawImage(x + 15/zoom, y + 10/zoom, w - 30/zoom, h - 40/zoom, "data/window.png", 0, 0, 0, white, true)
	dxDrawImage(x + 465/zoom, y + 90/zoom, 20/zoom, h - 150/zoom, "data/scrollbg.png", 0, 0, 0, tocolor(255, 255, 0, 255), true)
	dxDrawImage(x + 465/zoom, y + 80/zoom + ((editingData[1] / 334) * size), 20/zoom, 20/zoom, "data/scroll.png", 0, 0, 0, tocolor(255, 255, 0, 255), true)
	if currentSelected and isElement(currentSelected) then model = getElementModel(currentSelected) end
	dxDrawText(model or "Brak zaznaczenia", x + 198/zoom, y + 48/zoom, x + 248/zoom, y + 48/zoom, tocolor(0, 0, 0, 255), 1/zoom, normal_big, "left", "center", false, false, true)
	dxDrawText(model or "Brak zaznaczenia", x + 200/zoom, y + 50/zoom, x + 250/zoom, y + 50/zoom, white, 1/zoom, normal_big, "left", "center", false, false, true)
	dxDrawImage(x + 40/zoom, y + 90/zoom, 420/zoom, h - 150/zoom, "data/window.png", 0, 0, 0, white, true)
	for i = 0, 3 do
		for sc = 1, (size / (100/zoom)) do
			if fileExists("data/images/" .. editingData[1] + 0 + (sc - 1)*3 + i .. ".jpg") then
				dxDrawImage(x + 55/zoom + 100/zoom*i, y + (100 * sc)/zoom, 90/zoom, 90/zoom, "data/images/" .. editingData[1] + 0 + (sc - 1)*4 + i .. ".jpg", 0, 0, 0, white, true)
			end
		end
	end
	dxDrawImage(x + 30/zoom, y + 30/zoom, 160/zoom, 46/zoom, "data/" .. editingData[2] .. ".png", 0, 0, 0, white, true)

	if isMouseInPosition(x + 465/zoom, y + 80/zoom, 20/zoom, size) and getKeyState("mouse1") then -- scroll
		cx, cy = getCursorPosition()
		cy = cy * sy
		cy = cy - (y + 80/zoom)
		cy = (cy / size)
		scroll = cy * 334
		editingData[1] = math.floor(scroll)
		return
	end
end)