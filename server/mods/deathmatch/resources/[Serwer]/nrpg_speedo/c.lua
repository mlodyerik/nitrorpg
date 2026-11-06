local main = {

	texturesList = {

		{"background", "img/background.png"},
		{"engine", "img/engine.png"},
		{"engineon", "img/engineON.png"},
		{"handbrake", "img/handbrake.png"},
		{"handbrakeon", "img/handbrakeON.png"},
		{"lights", "img/lights.png"},
		{"lightson", "img/lightsON.png"},
		{"lpg", "img/LPG.png"},
		{"numbers", "img/numbers.png"},
		{"wskazowka", "img/wskazowka.png"},
		{"fuel", "img/fuel.png"},
		{"mileage", "img/mileage.png"},
		{"nitro", "img/nitro.png"},

	},

	textures = {},
	speedoAlpha = 255,
	speedoFuelAlpha = 255,
	speedoTextAlpha = 255,
	tick = getTickCount(),


}

for i,v in ipairs(main.texturesList) do
	main.textures[v[1]] = dxCreateTexture(v[2])
end

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local lib = exports.nrpg_lib

local speedoPos = {x=0, y=0, w=math.floor(350/zoom), h=math.floor(350/zoom)}
speedoPos.x = screenW-speedoPos.w-math.floor(30/zoom)
speedoPos.y = screenH-speedoPos.h-math.floor(30/zoom)

function convertNumber ( number, color ) 
	if #tostring(number) == 1 then number = "0000000"..color..""..number
	elseif #tostring(number) == 2 then number = "000000"..color..""..number
	elseif #tostring(number) == 3 then number = "00000"..color..""..number
	elseif #tostring(number) == 4 then number = "0000"..color..""..number
	elseif #tostring(number) == 5 then number = "000"..color..""..number
	elseif #tostring(number) == 6 then number = "00"..color..""..number
	elseif #tostring(number) == 7 then number = "0"..color..""..number
	elseif #tostring(number) >= 8 then number = number end

	if number then
		return number
	end
end 

function drawSpeedo()
	local veh = getPedOccupiedVehicle(localPlayer)
	if isPedInVehicle(localPlayer) and veh and not getElementData(localPlayer, "notshowhud") and not exports["nrpg_vehicleAddons"]:isBike(veh) then
		local x, y, w, h = speedoPos.x, speedoPos.y, math.floor(100/zoom), math.floor(50/zoom)
		local sx, sy, sz = getElementVelocity(veh)
		local predkosc = (sx^2 + sy^2 + sz^2)^(0.5)
		local kmh = predkosc * 185
		local predkosc1 = math.ceil(((sx^2+sy^2+sz^2)^(0.5)) * 165)

		local fuel = getElementData(veh, "vehicle:fuel") or 0
		local fuellpg = getElementData(veh, "vehicle:fuellpg") or 0
		local bak = getElementData(veh, "vehicle:bak") or 25
		local licznikColor = getElementData(veh, "licznikColor") or {255, 255, 255}
		local r, g, b = tonumber(licznikColor[1] or 255), tonumber(licznikColor[2] or 255), tonumber(licznikColor[3] or 255)
		local mileage = math.floor(tonumber(getElementData(veh, "vehicle:mileage") or 0))
		local hexColor = RGBToHex(r, g, b)
		local nitroCount = math.floor(((getVehicleNitroLevel(veh) or 0)*100)) 
		local lr, lg, lb = getVehicleHeadLightColor(veh)

		if getVehicleOverrideLights(veh) ~= 2 then
			main.speedoAlpha = 155
			main.speedoFuelAlpha = 25
			main.speedoTextAlpha = 100
		else
			main.speedoAlpha = 255
			main.speedoFuelAlpha = 55
			main.speedoTextAlpha = 175
		end

		dxDrawImage(speedoPos.x, speedoPos.y, speedoPos.w, speedoPos.h, main.textures["background"], 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(speedoPos.x+math.floor(5/zoom), speedoPos.y+math.floor(5/zoom), speedoPos.w-math.floor(10/zoom), speedoPos.h-math.floor(10/zoom), main.textures["numbers"], 0, 0, 0, tocolor(r, g, b, main.speedoAlpha), false)
		dxDrawImage(speedoPos.x+math.floor(5/zoom), speedoPos.y+math.floor(5/zoom), speedoPos.w-math.floor(10/zoom), speedoPos.h-math.floor(10/zoom), main.textures["wskazowka"], predkosc1-21, 0, 0, tocolor(255, 255, 255, main.speedoAlpha), false)
		dxDrawImage(speedoPos.x+math.floor(167/zoom), speedoPos.y+math.floor(105/zoom), math.floor(20/zoom), math.floor(20/zoom), main.textures["fuel"], 0, 0, 0, tocolor(255, 255, 255, main.speedoAlpha), false)

		dxDrawCircle(speedoPos.x+math.floor(176/zoom), speedoPos.y+math.floor(177/zoom), speedoPos.w/2, speedoPos.h/2, tocolor(r, g, b, main.speedoFuelAlpha), 270, 180, 6)
		dxDrawCircle(speedoPos.x+math.floor(176/zoom), speedoPos.y+math.floor(177/zoom), speedoPos.w/2, speedoPos.h/2, tocolor(r, g, b, main.speedoAlpha-75), 270, 180*fuel/bak, 6)

		dxDrawImage(speedoPos.x+math.floor(120/zoom), speedoPos.y+math.floor(197/zoom), math.floor(20/zoom), math.floor(20/zoom), main.textures["mileage"], 0, 0, 0, tocolor(255, 255, 255, main.speedoAlpha), false)
		dxDrawText(convertNumber(mileage, hexColor).." km", x+math.floor(150/zoom), y+math.floor(365/zoom), x+w, y+h, tocolor(255, 255, 255, main.speedoTextAlpha), 1, exports.nrpg_interface:getGUIFont('light11'), "left", "center", false, false, false, true, false)

		if isElementFrozen(veh) then
			dxDrawImage(speedoPos.x+math.floor(128/zoom), speedoPos.y+math.floor(215/zoom), math.floor(45/zoom), math.floor(45/zoom), main.textures["handbrake"], 0, 0, 0, tocolor(255, 175, 0, main.speedoAlpha), false)
		else
			dxDrawImage(speedoPos.x+math.floor(128/zoom), speedoPos.y+math.floor(215/zoom), math.floor(45/zoom), math.floor(45/zoom), main.textures["handbrake"], 0, 0, 0, tocolor(255, 255, 255, main.speedoAlpha), false)
		end

		if getVehicleOverrideLights(veh) == 2 then
			dxDrawImage(speedoPos.x+math.floor(158/zoom), speedoPos.y+math.floor(215/zoom), math.floor(45/zoom), math.floor(45/zoom), main.textures["lights"], 0, 0, 0, tocolor(lr, lg, lb, main.speedoAlpha), false)
		else
			dxDrawImage(speedoPos.x+math.floor(158/zoom), speedoPos.y+math.floor(215/zoom), math.floor(45/zoom), math.floor(45/zoom), main.textures["lights"], 0, 0, 0, tocolor(255, 255, 255, main.speedoAlpha), false)
		end

		if getVehicleEngineState(veh) == true then
			dxDrawImage(speedoPos.x+math.floor(188/zoom), speedoPos.y+math.floor(215/zoom), math.floor(45/zoom), math.floor(45/zoom), main.textures["engine"], 0, 0, 0, tocolor(255, 255, 255, main.speedoAlpha), false)
		else
			dxDrawImage(speedoPos.x+math.floor(188/zoom), speedoPos.y+math.floor(215/zoom), math.floor(45/zoom), math.floor(45/zoom), main.textures["engine"], 0, 0, 0, tocolor(255, 55, 55, main.speedoAlpha), false)
		end

		if getElementData(veh, "vehicle:lpg") then
			lpgDots = {}

			if fuellpg >= 90 then
				lpgDots[5] = true
				lpgDots[4] = true
				lpgDots[3] = true
				lpgDots[2] = true
				lpgDots[1] = true
			elseif fuellpg >= 75 then
				lpgDots[5] = false
				lpgDots[4] = true
				lpgDots[3] = true
				lpgDots[2] = true
				lpgDots[1] = true
			elseif fuellpg >= 50 then
				lpgDots[5] = false
				lpgDots[4] = false
				lpgDots[3] = true
				lpgDots[2] = true
				lpgDots[1] = true
			elseif fuellpg >= 25 then
				lpgDots[5] = false
				lpgDots[4] = false
				lpgDots[3] = false
				lpgDots[2] = true
				lpgDots[1] = true
			elseif fuellpg >= 10 then
				lpgDots[5] = false
				lpgDots[4] = false
				lpgDots[3] = false
				lpgDots[2] = false
				lpgDots[1] = true
			elseif fuellpg >= 2 then
				lpgDots[5] = false
				lpgDots[4] = false
				lpgDots[3] = false
				lpgDots[2] = false
				lpgDots[1] = "light"
			elseif 1 >= fuellpg then
				lpgDots[5] = false
				lpgDots[4] = false
				lpgDots[3] = false
				lpgDots[2] = false
				lpgDots[1] = "red"
			end

			for i, v in ipairs(lpgDots) do
				lpgOffset = math.floor(20/zoom)*(i-1)

				if v == true then
					dxDrawImage(speedoPos.x+math.floor(131/zoom)+lpgOffset, speedoPos.y+math.floor(134/zoom), math.floor(10/zoom), math.floor(10/zoom), main.textures["lpg"], 0, 0, 0, tocolor(75, 185, 75, main.speedoAlpha), false)
				elseif v == false then
					dxDrawImage(speedoPos.x+math.floor(131/zoom)+lpgOffset, speedoPos.y+math.floor(134/zoom), math.floor(10/zoom), math.floor(10/zoom), main.textures["lpg"], 0, 0, 0, tocolor(155, 155, 155, main.speedoAlpha), false)
				elseif v == "light" then
					local alpha = interpolateBetween(55, 0, 0, main.speedoAlpha, 0, 0, (getTickCount()-main.tick)/1500, 'SineCurve')
					dxDrawImage(speedoPos.x+math.floor(131/zoom)+lpgOffset, speedoPos.y+math.floor(134/zoom), math.floor(10/zoom), math.floor(10/zoom), main.textures["lpg"], 0, 0, 0, tocolor(155, 155, 155, main.speedoAlpha), false)
					dxDrawImage(speedoPos.x+math.floor(131/zoom)+lpgOffset, speedoPos.y+math.floor(134/zoom), math.floor(10/zoom), math.floor(10/zoom), main.textures["lpg"], 0, 0, 0, tocolor(255, 175, 0, alpha), false)
				elseif v == "red" then
					local alpha = interpolateBetween(55, 0, 0, main.speedoAlpha, 0, 0, (getTickCount()-main.tick)/1500, 'SineCurve')
					dxDrawImage(speedoPos.x+math.floor(131/zoom)+lpgOffset, speedoPos.y+math.floor(134/zoom), math.floor(10/zoom), math.floor(10/zoom), main.textures["lpg"], 0, 0, 0, tocolor(155, 155, 155, main.speedoAlpha), false)
					dxDrawImage(speedoPos.x+math.floor(131/zoom)+lpgOffset, speedoPos.y+math.floor(134/zoom), math.floor(10/zoom), math.floor(10/zoom), main.textures["lpg"], 0, 0, 0, tocolor(255, 0, 0, alpha), false)
				end
			end
		end
		

		dxDrawText(math.floor(kmh), x+math.floor(255/zoom), y+math.floor(278/zoom), x+w, y+h, tocolor(r, g, b, main.speedoAlpha), 1, exports.nrpg_interface:getGUIFont('money20'), "center", "center", false, false, false, false, false)
		dxDrawText("km/h", x+math.floor(255/zoom), y+math.floor(328/zoom), x+w, y+h, tocolor(r, g, b, main.speedoTextAlpha), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "center", false, false, false, false, false)

		local ograniczenie = getElementData(localPlayer, "Ogranicznik:Set") or ""
		dxDrawText(ograniczenie, x+math.floor(255/zoom), y+math.floor(575/zoom), x+w, y+h, tocolor(255, 25, 25, main.speedoTextAlpha), 1, exports.nrpg_interface:getGUIFont('light15'), "center", "center", false, false, false, false, false)
	end
end

function drawLicznikPodglad(r, g, b)
	if not getElementData(localPlayer, "notshowhud") then
		local x, y, w, h = speedoPos.x, speedoPos.y, math.floor(100/zoom), math.floor(50/zoom)
		local kmh = 0
		local predkosc1 = 0
		local fuel = 25
		local bak = 25
		local mileage = 100
		local hexColor = RGBToHex(r, g, b)


		speedoAlpha = 255
		speedoFuelAlpha = 55
		speedoTextAlpha = 175

		dxDrawImage(speedoPos.x, speedoPos.y, speedoPos.w, speedoPos.h, main.textures["background"], 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(speedoPos.x+math.floor(5/zoom), speedoPos.y+math.floor(5/zoom), speedoPos.w-math.floor(10/zoom), speedoPos.h-math.floor(10/zoom), main.textures["numbers"], 0, 0, 0, tocolor(r, g, b, speedoAlpha), false)
		dxDrawImage(speedoPos.x+math.floor(5/zoom), speedoPos.y+math.floor(5/zoom), speedoPos.w-math.floor(10/zoom), speedoPos.h-math.floor(10/zoom), main.textures["wskazowka"], predkosc1-21, 0, 0, tocolor(255, 255, 255, speedoAlpha), false)
		dxDrawImage(speedoPos.x+math.floor(165/zoom), speedoPos.y+math.floor(105/zoom), math.floor(20/zoom), math.floor(20/zoom), main.textures["fuel"], 0, 0, 0, tocolor(255, 255, 255, speedoAlpha), false)

		dxDrawCircle(speedoPos.x+math.floor(176/zoom), speedoPos.y+math.floor(177/zoom), speedoPos.w/2, speedoPos.h/2, tocolor(r, g, b, speedoFuelAlpha), 270, 180, 6)
		dxDrawCircle(speedoPos.x+math.floor(176/zoom), speedoPos.y+math.floor(177/zoom), speedoPos.w/2, speedoPos.h/2, tocolor(r, g, b, speedoAlpha-75), 270, 180*fuel/bak, 6)

		dxDrawImage(speedoPos.x+math.floor(120/zoom), speedoPos.y+math.floor(190/zoom), math.floor(20/zoom), math.floor(20/zoom), main.textures["mileage"], 0, 0, 0, tocolor(255, 255, 255, speedoAlpha), false)
		dxDrawText(convertNumber(mileage, hexColor).." km", x+math.floor(150/zoom), y+math.floor(355/zoom), x+w, y+h, tocolor(255, 255, 255, speedoTextAlpha), 1, exports.nrpg_interface:getGUIFont('light11'), "left", "center", false, false, false, true, false)

		dxDrawImage(speedoPos.x+math.floor(128/zoom), speedoPos.y+math.floor(215/zoom), math.floor(35/zoom), math.floor(35/zoom), main.textures["handbrake"], 0, 0, 0, tocolor(255, 255, 255, speedoAlpha), false)
		dxDrawImage(speedoPos.x+math.floor(158/zoom), speedoPos.y+math.floor(215/zoom), math.floor(35/zoom), math.floor(35/zoom), main.textures["lights"], 0, 0, 0, tocolor(255, 255, 255, speedoAlpha), false)
		dxDrawImage(speedoPos.x+math.floor(188/zoom), speedoPos.y+math.floor(215/zoom), math.floor(35/zoom), math.floor(35/zoom), main.textures["engine"], 0, 0, 0, tocolor(255, 255, 255, speedoAlpha), false)

		dxDrawText(math.floor(kmh), x+math.floor(250/zoom), y+math.floor(255/zoom), x+w, y+h, tocolor(r, g, b, speedoAlpha), 1, exports.nrpg_interface:getGUIFont('money20'), "center", "center", false, false, false, false, false)
		dxDrawText("km/h", x+math.floor(250/zoom), y+math.floor(305/zoom), x+w, y+h, tocolor(r, g, b, speedoTextAlpha), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "center", false, false, false, false, false)
	end
end

function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end

addEventHandler("onClientResourceStart", resourceRoot, function()
	addEventHandler("onClientRender", root, drawSpeedo)
end)
