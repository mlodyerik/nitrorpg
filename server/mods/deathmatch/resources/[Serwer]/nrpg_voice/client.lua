-- variables
local voicePlayers = {}

zoom = 1
sW, sH = guiGetScreenSize()
if sW < 1920 then
    zoom = math.min(2, 1920 / sW)
end

-- draw (voice reosource)
local g_screenX,g_screenY = guiGetScreenSize()
local BONE_ID = 8
local WORLD_OFFSET = 0.8
local ICON_PATH = "images/voice.png"
local ICON_WIDTH = 0.15*g_screenX
local VOICE_MODE = {}
local lib = exports.nrpg_lib
local windowRectangle = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(18, 18, 38, 255))
local playerBar = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(100, 100, 200, 255))
--
local iconHalfWidth = ICON_WIDTH/2

local ICON_DIMENSIONS = 12
local ICON_LINE = 20
local ICON_TEXT_SHADOW = tocolor ( 0, 0, 0, 255 )
local sx, sy = guiGetScreenSize()
local w, h = (sx/1366), (sy/768)
range = 15

--Draw the voice image
addEventHandler ( "onClientRender", root,
	function()
		local index = 0
		local index2 = 0
		local sX, sY, sZ = getElementPosition(localPlayer)

		for player in pairs(voicePlayers) do
			local rX, rY, rZ = getElementPosition(player)
			local distance = getDistanceBetweenPoints3D(sX, sY, sZ, rX, rY, rZ) 

			setSoundVolume( player, 30-distance )
			
			local color = tocolor(255, 255, 255, 255)
			index = index + 1
			dxDrawVoiceLabel ( player, index, color )
		end
	end
)

function getHexPlayer( player )
	local level = getElementData(player, 'player:level');
    if level == 5 then
        return '#AC0008'
    elseif level == 4 then
		return '#ff7300'
	elseif level == 3 then
		return '#FF0000'
	elseif level == 2 then
		return '#05FF00'
	elseif level == 1 then
		return '#00F0FF'
    elseif getElementData(player, 'mute:player') then
        return '#858585'
    elseif getElementData(player, 'player:premiumplus') then
		return '#19afff'
    elseif getElementData(player, 'player:discordbooster') then
		return '#fc03f0'
    elseif getElementData(player, "player:premium") then
        return '#FFFC00'
	else
		return '#9b9bff'
	end
end

function dxDrawVoiceLabel ( player, index, color )
	local sx, sy = guiGetScreenSize ()
	local scale = (sy / 800)
	local spacing = ( ICON_LINE * scale )
	local icon = ICON_DIMENSIONS * scale
	local px, py = sx-icon, (sy * 0.5 + spacing * index + 65)

	if getPedOccupiedVehicle( localPlayer ) then
		py = (sy * 0.5 - spacing * index)
	end
	px = px
 
	local name = getPlayerName ( player ):gsub("#%x%x%x%x%x%x","")
	local id = getElementData(player, "id")
	local textWidth = dxGetTextWidth("["..id.."] "..name, 1/zoom, exports.nrpg_interface:getGUIFont("money10"))
	dxDrawText ("["..id.."] "..name, px + 1 - textWidth, py + 1, px - textWidth, py, ICON_TEXT_SHADOW, 1/zoom, exports.nrpg_interface:getGUIFont("money10") )
	dxDrawText ("["..getHexPlayer(player)..""..id.."#ffffff] "..name, px - textWidth, py, px - textWidth, py, color, 1/zoom, exports.nrpg_interface:getGUIFont("money10"), _, _, false, false, false, true)
end

-- events
addEventHandler("onClientPlayerVoiceStart",getRootElement(),function()
	if not getElementData (source, "player:logged" ) then
		cancelEvent()
		return
	end
	if getElementData (source, "mute:player" ) then
		cancelEvent()
		return
	end
	if getElementData (source, "voice:off" ) then
		cancelEvent()
		return
	end


	local localDimension = getElementDimension( localPlayer )
	local localInterior = getElementInterior( localPlayer )
	if source == localPlayer then
		setElementData(source, "voice:mowi", true)
		voicePlayers[source] = true
		local posX, posY, posZ = getElementPosition(source)
        local nearbyPlayers = getElementsWithinRange(posX, posY, posZ, 30, "player")
	else
		local sourceDimension = getElementDimension( source )
		local sourceInterior = getElementInterior( source )
		if tonumber(localDimension) ~= tonumber(sourceDimension) or tonumber(localInterior) ~= tonumber(sourceInterior) then
				cancelEvent()
				return
		end
		local sX, sY, sZ = getElementPosition(localPlayer) 
		local rX, rY, rZ = getElementPosition(source)
		local distance = getDistanceBetweenPoints3D(sX, sY, sZ, rX, rY, rZ) 
		if distance <= range then
			voicePlayers[source] = true
		else 
			cancelEvent()
		end
	end 
end)

addEventHandler("onClientPlayerVoiceStop",getRootElement(),function()
	if source == localPlayer then
		setElementData(source, "voice:mowi", false)
	end
	voicePlayers[source] = nil
end)

addEventHandler("onClientPlayerQuit",getRootElement(),function()
	voicePlayers[source] = nil
end)