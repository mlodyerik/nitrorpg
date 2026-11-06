local textsToDraw = {}

local hideown = false
local showtime = 5000
local characteraddition = 100
local maxbubbles = 2

local showthebubbles = true

function incomePed(ped,message)
	addText(ped,message,0)
end

function income(message,messagetype)
	if source ~= getLocalPlayer() or not hideown then
		if getElementData(source, "mute:player") then return end
		if messagetype == 2 then
			if getPlayerTeam(source) == getPlayerTeam(getLocalPlayer()) then
				addText(source,message,messagetype)
			end
		else
			addText(source,message,messagetype)
		end
	end
end

function addText(source,message,messagetype)
	local notfirst = false
	for _,v in pairs(textsToDraw) do
		if v[1] == source then
			v[4] = v[4] + 1
			notfirst = true
		end
	end
	local infotable = {source,message,messagetype,0}
	table.insert(textsToDraw,infotable)
	setTimer(removeText,showtime,1,infotable)
	if not notfirst then
		setTimer(removeText,showtime + (#message * characteraddition),1,infotable)
	end
end

function removeText(infotable)
	for i,v in ipairs(textsToDraw) do
		if v[1] == infotable[1] and v[2] == infotable[2] then
			for i2,v2 in ipairs(textsToDraw) do
				if v2[1] == v[1] and v[4] - v2[4] == 1 then
					setTimer(removeText,showtime + (#v2[2] * characteraddition),1,v2)
				end
			end
			table.remove(textsToDraw,i)
			break
		end
	end
end

function getTextsToRemove()
	for _,v in pairs(textsToDraw) do
		if v[1] == source then
			removeText(v)
		end
	end
end

local messageTypeBackground = {
	[0] = {100, 100, 100},
	[1] = {189, 57, 189},
    [2] = {145, 55, 55},
    [3] = {55, 145, 55},
	[5] = {0, 117, 186},
}

interface = {

    background = exports.nrpg_lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(65, 65, 65, 255)),
	backgroundColored = exports.nrpg_lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(65, 65, 65, 255)),

}

local nametag_font = dxCreateFont(":nrpg_interface/fonts/money.ttf", 9, false)

function handleDisplay()
	if showthebubbles then
		local cx,cy,cz = getCameraMatrix()
		for i=1,#textsToDraw do
			local v = textsToDraw[i]
			if isElement(v[1]) then
				if getElementHealth(v[1]) > 0 and getElementAlpha(v[1]) > 140 and v[1] ~= localPlayer then
					local px, py, pz, tx, ty, tz, dist
                    px, py, pz = getCameraMatrix()
                    px, py, pz = math.floor(px), math.floor(py), math.floor(pz)

					tx, ty, tz = getPedBonePosition(v[1], 8)
                    dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz);
                    posx, posy = getScreenFromWorldPosition( tx, ty, tz + 0.55 )

					if posx and dist <= 20 and ( not maxbubbles or  v[4] < maxbubbles ) then -- change this when multiple ignored elements can be specified
						local width = dxGetTextWidth(v[2],1,nametag_font)
						
						
						local r,g,b = unpack(messageTypeBackground[ v[3] or 0 ])

						exports.nrpg_lib:dgsRoundRectSetColor(interface.backgroundColored,tocolor(r, g, b, 255))
						dxDrawImage(posx - (12 + (0.5 * width)) - 1, posy - ((v[4] * 32)) - 41, width + 26, 32, interface.backgroundColored, 0, 0, 0, tocolor(255, 255, 255, 255), false)
						dxDrawImage(posx - (12 + (0.5 * width)), posy - ((v[4] * 32)) - 40, width + 24, 30, interface.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)
						dxDrawText(v[2], posx - (0.5 * width), posy - (v[4] * 32) - 32, posx - (0.5 * width), posy - (v[4] * 20),tocolor(255,255,255,200),1,nametag_font,"left","top",false,false,false)
					end
				end
			end
		end
	end
end

addEvent("onChatbubblesMessageIncome",true)
addEventHandler("onChatbubblesMessageIncome",getRootElement(),income)
addEvent("onChatbubblesMessageIncomePed",true)
addEventHandler("onChatbubblesMessageIncomePed",getRootElement(),incomePed)
addEventHandler("onClientPlayerQuit",getRootElement(),getTextsToRemove)
addEventHandler("onClientRender",getRootElement(),handleDisplay)
