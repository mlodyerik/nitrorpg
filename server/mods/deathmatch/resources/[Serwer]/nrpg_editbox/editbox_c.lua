local sw,sh = guiGetScreenSize()
local baseX = 1920
local scale = 1
local minScale = 2
if sw < baseX then
    scale = math.min(minScale, baseX/sw)
end

local wraca = false
local lib = exports.nrpg_lib

interface2 = {

    editBG = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(75, 75, 150, 255)),

}
 
guiSetInputEnabled(false)

local tick = getTickCount()

function isMouseIn(x, y, w, h)
	if not isCursorShowing() then return end

	local pos = {getCursorPosition()}
	pos[1],pos[2] = (pos[1]*sw),(pos[2]*sh)

	if pos[1] >= x and pos[1] <= (x+w) and pos[2] >= y and pos[2] <= (y+h) then
		return true
	end
	return false
end

function isEventHandlerAdded(eventName, rootName, fnc)
  if type(eventName) == 'string' and isElement(rootName) and type(fnc) == 'function' then
    local eventHandlers = getEventHandlers(eventName, rootName)
    if type(eventHandlers) == 'table' and #eventHandlers > 0 then
      for i,v in ipairs(eventHandlers) do
        if v == fnc then
          return true
        end
      end
    end
  end
  return false
end

local edits = {}

function createCustomEditbox(name, text, x, y, w, h, masked, txt, handler, color, iconPatch)
	name = name or ''
	text = text or ''
	x,y,w,h = x,y,w,h or 0,0,100,25
	txt = txt or ''
	masked = masked or false
	handler = handler or false
	color = color or {25, 25, 45}
	icon = iconPatch or false

	table.insert(edits, {name,txt,x,y,w,h,masked,false,text,false,255,handler,color,icon})

	openGui()
end

function openGui()
	if not isEventHandlerAdded('onClientRender', root, gui) then
		addEventHandler('onClientRender', root, gui)
		addEventHandler('onClientCharacter', root, setSelectedEditBoxText)
		addEventHandler('onClientKey', root, key)
		addEventHandler('onClientClick', root, clicked)
	end
end

function closeGui()
	if isEventHandlerAdded('onClientRender', root, gui) then
		removeEventHandler('onClientRender', root, gui)
		removeEventHandler('onClientCharacter', root, setSelectedEditBoxText)
		removeEventHandler('onClientKey', root, key)
		removeEventHandler('onClientClick', root, clicked)
	end
	showCursor(false)
	guiSetInputEnabled(false)
	stopPaste()
end

function destroyCustomEditbox(name)
		showCursor(false)
		guiSetInputEnabled(false)
		setElementData(localPlayer, "player:editboxWrite", false)
		for i=#edits, 1, -1 do
			if edits[i][1] == name then
				table.remove(edits, i)
			end
		end
	end

function getCustomEditboxText(name)
	local text = ''
	for i,v in ipairs(edits) do
		if v[1] == name then
			text = v[2]
			break
		end
	end
	return text
end

function customEditboxSetText(name, text)
	for i,v in ipairs(edits) do
		if v[1] == name then
			v[2] = text
			break
		end
	end
end

function customEditboxSetAlpha(name, alpha)
	for i,v in ipairs(edits) do
		if v[1] == name then
			v[11] = alpha
			break
		end
	end
end

function customEditboxGetSelected(name)
	local text = ''
	for i,v in ipairs(edits) do
		if v[1] == name then
			text = v[8]
			break
		end
	end
	return text
end

function getEditboxSelected(name)
	local selected = false
	for i,v in ipairs(edits) do
		if v[1] == name then
			selected = v[8]
			break
		end
	end
	return selected
end

function customEditboxSetPosition(name, x, y)
	for i,v in ipairs(edits) do
		if v[1] == name then
			v[3] = x
			v[4] = y
			break
		end
	end
end

function setSelectedEditBoxText(text)
	for i,v in ipairs(edits) do
		if v[8] == true then
			v[2] = v[2]..text
			break
		end
	end
end

function setSelectedEditBoxTextImportant(text)
	for i,v in ipairs(edits) do
		if v[8] == true then
			v[2] = text
			break
		end
	end
end

local sizex = math.floor(sh * 0.002)

local tick = getTickCount()
local trzyma_ms = 0
local font = exports.nrpg_interface:getGUIFont("normal15")
local rgb = {230,230,230}

function gui()
    if #edits < 1 then
		closeGui()
    end

	for i,v in ipairs(edits) do
		local text = ''
		if v[8] == true then
			if v[7] == true then
				text = string.rep('*', string.len(v[2]))
			else
				text = v[2]
			end

			if getKeyState('backspace') then
				trzyma_ms = trzyma_ms + 0.20
			else
				trzyma_ms = 0
			end

			if getKeyState('backspace') and (getTickCount() - tick) > (80 / trzyma_ms) then
				v[2] = string.sub(v[2], 0, string.len(v[2])-1)
				tick = getTickCount()
			end
		else
			text = v[2]
		end

		lib:dgsRoundRectSetColor(interface2.editBG, tocolor(v[13][1], v[13][2], v[13][3], 255))

		if v[14] == false then
			dodatekText = 10/scale
		else
			dodatekText = 50/scale
		end

		editIcon_w, editIcon_h = v[6]/2, v[6]/2
		textAlpha = 0

		if v[8] == true then
			local x = interpolateBetween(v[5], 0, 0, 0, 0, 0, (getTickCount()-v[10])/500, 'Linear')

			if isMouseIn(v[3], v[4], v[5], v[6]) then
				dxDrawImage(v[3], v[4], v[5], v[6], interface2.editBG, 0, 0, 0, tocolor(255, 255, 255, 125), true)
				if v[14] then
					dxDrawImage(v[3]+v[6]/4, v[4]+v[6]/4, editIcon_w, editIcon_h, v[14], 0, 0, 0, tocolor(255, 255, 255, 155), true)
				end
				textAlpha = 25
			else
				dxDrawImage(v[3], v[4], v[5], v[6], interface2.editBG, 0, 0, 0, tocolor(255, 255, 255, 135), true)
				if v[14] then
					dxDrawImage(v[3]+v[6]/4, v[4]+v[6]/4, editIcon_w, editIcon_h, v[14], 0, 0, 0, tocolor(255, 255, 255, 200), true)
				end
				textAlpha = 0
			end

			dxDrawText(text,v[3]+dodatekText,v[4],v[5]+v[3],v[6]+v[4],tocolor(175, 175, 175,v[11]-textAlpha),1/scale,exports.nrpg_interface:getGUIFont("light11"),'left','center',true,false,true)

			local width = dxGetTextWidth(text:gsub("#%x%x%x%x%x%x", ""), 1/scale, exports.nrpg_interface:getGUIFont("light11"))
			if (v[3] + width) <= (v[3] + v[5]) then
				local a = v[11] > 75 and interpolateBetween(100, 0, 0, 155, 0, 0, (getTickCount() - tick)/1000, 'SineCurve') or v[11]
				dxDrawRectangle(v[3] + width + dodatekText+2/scale, v[4] + (v[6] / 4), 1, (v[6] / 2), tocolor(200, 200, 200, a), true)
			else
				v[2] = string.sub(v[2], 0, string.len(v[2]) - 1)
			end
		else
			if v[10] ~= false then
				local x = interpolateBetween(0, 0, 0, v[5], 0, 0, (getTickCount()-v[10])/500, 'Linear')
				if isMouseIn(v[3], v[4], v[5], v[6]) then
					dxDrawImage(v[3], v[4], v[5], v[6], interface2.editBG, 0, 0, 0, tocolor(255, 255, 255, 125), true)

					if v[14] then
						dxDrawImage(v[3]+v[6]/4, v[4]+v[6]/4, editIcon_w, editIcon_h, v[14], 0, 0, 0, tocolor(255, 255, 255, 155), true)
					end
					textAlpha = 25
				else
					dxDrawImage(v[3], v[4], v[5], v[6], interface2.editBG, 0, 0, 0, tocolor(255, 255, 255, 155), true)
					if v[14] then
						dxDrawImage(v[3]+v[6]/4, v[4]+v[6]/4, editIcon_w, editIcon_h, v[14], 0, 0, 0, tocolor(255, 255, 255, 200), true)
					end
					textAlpha = 0
				end
			else
				if isMouseIn(v[3], v[4], v[5], v[6]) then
					dxDrawImage(v[3], v[4], v[5], v[6], interface2.editBG, 0, 0, 0, tocolor(255, 255, 255, 125), true)
					if v[14] then
						dxDrawImage(v[3]+v[6]/4, v[4]+v[6]/4, editIcon_w, editIcon_h, v[14], 0, 0, 0, tocolor(255, 255, 255, 155), true)
					end
					textAlpha = 25
				else
					dxDrawImage(v[3], v[4], v[5], v[6], interface2.editBG, 0, 0, 0, tocolor(255, 255, 255, 155), true)
					if v[14] then
						dxDrawImage(v[3]+v[6]/4, v[4]+v[6]/4, editIcon_w, editIcon_h, v[14], 0, 0, 0, tocolor(255, 255, 255, 200), true)
					end
					textAlpha = 0
				end
			end

			if string.len(v[2]) > 0 then
				local txt = v[2]
				if v[7] == true then
					txt = string.rep('*', string.len(v[2]))
				end

				dxDrawText(txt,v[3]+dodatekText,v[4],v[5]+v[3],v[6]+v[4],tocolor(175, 175, 175,v[11]-textAlpha),1/scale,exports.nrpg_interface:getGUIFont("light11"),'left','center',true,false,true)
			else
				dxDrawText(v[9],v[3]+dodatekText,v[4],v[5]+v[3],v[6]+v[4],tocolor(175, 175, 175,v[11]-textAlpha),1/scale,exports.nrpg_interface:getGUIFont("light11"),'left','center',true,false,true)
			end
		end
	end
end

function key(key, press)
	if not press then return end

	if key == 'tab' then
		for i = 1,#edits do
			if edits[i][8] == true then
				if edits[i+1] and not wraca then
					if (i+1) == #edits then
						wraca = true
					end

					edits[i][8] = false
					edits[i+1][8] = true
					edits[i][10] = getTickCount()
					edits[i+1][10] = getTickCount()
					return
				elseif edits[i-1] then
					if (i-1) == 1 then
						wraca = false
					end

					edits[i][8] = false
					edits[i-1][8] = true
					edits[i][10] = getTickCount()
					edits[i-1][10] = getTickCount()
					return
				end
			end
		end
	end
end

function clicked(btn, state)
	if btn ~= 'state' and state ~= 'down' then return end

	for i,v in ipairs(edits) do
		if isMouseIn(v[3], v[4], v[5], v[6]) then
			if v[8] ~= true then
				if i == 1 then
					wraca = false
				else
					wraca = true
				end

				for _,k in ipairs(edits) do
					k[8] = false
				end

				v[8] = true
				showCursor(false)
				guiSetInputEnabled(true)
				setElementData(localPlayer, "player:editboxWrite", true)
				v[10] = getTickCount()
				startPaste()
				return
			end
		end

		if v[8] == true then
			v[8] = false
			guiSetInputEnabled(false)
			setElementData(localPlayer, "player:editboxWrite", false)
			v[10] = getTickCount()
			stopPaste()
		end
	end
end