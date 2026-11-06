main = {}

local sx, sy = guiGetScreenSize()
local w, h = (sx/1280),(sy/720)
local zoom = 1
if sx < 1280 then
    zoom = math.min(2, 1280 / sx)
end


local sx,sy = guiGetScreenSize()
local pojazdNamierzany = nil
local predkoscPojazdu=0
Policevehicle_data = {}
guiopen = false

function RenderCamerAS(status)
	if status == 'on' then
		addEventHandler('onClientRender', getRootElement(), RenderCameraPlayerSpeed)
		guiopen = true
	elseif status == 'off' then
		removeEventHandler('onClientRender', getRootElement(), RenderCameraPlayerSpeed)
		main.gui = false
		guiopen = false
	end
end
addEvent( 'SpeedCam', true )
addEventHandler( 'SpeedCam', localPlayer, RenderCamerAS )

main = {}
main.gui = false

function RenderCameraPlayerSpeed()
	--if not(SpeedMathVehicle) then
	if isMouseIn(1224*w, 675*h, 46*w, 35*h) then
		dxDrawImage(1224*w, 675*h, 46*w, 35*h, ":nrpg_faction_sapd/video.png", 0, 0, 0, tocolor(255, 255, 255, 155), false)
	else
		dxDrawImage(1224*w, 675*h, 46*w, 35*h, ":nrpg_faction_sapd/video.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end

	if main.gui ~= true then return end
	local PoliceVehicle = getPedOccupiedVehicle(localPlayer)
	if not PoliceVehicle then return end

	local vehID = getElementData(PoliceVehicle, 'dbid')
	for i, colshape in pairs(getElementsByType('colshape', root, true)) do
		local ColShapeID = getElementData(colshape,'Speed') or false
		if ColShapeID == vehID then
			local vehicles = getElementsWithinColShape ( colshape, 'vehicle' ) 
			for theKey,veh in pairs(vehicles) do 
				if not(veh == PoliceVehicle) then
					local vx, vy, vz = getElementVelocity(veh)
					local speed=((vx^2+vy^2+vz^2)^(0.5))*180
					predkoscPojazdu=math.floor(speed)
					if pojazdNamierzany and getVehicleName(pojazdNamierzany) == veh then
						pojazdNamierzany = pojazdNamierzany
					else
						pojazdNamierzany = veh
					end
				end
			end		
		end
	end

	

		if pojazdNamierzany ~= veh then
			main.model = getVehicleName(pojazdNamierzany)
			main.register = getVehiclePlateText(pojazdNamierzany)
			main.predkosc = predkoscPojazdu
			main.policeRegister = getVehiclePlateText(PoliceVehicle)

			if getVehicleController(pojazdNamierzany) then
				main.kierowca = getPlayerName(getVehicleController(pojazdNamierzany))
			end

			if isElementFrozen(pojazdNamierzany) then
				main.reczny = "TAK"
			else
				main.reczny = "NIE"
			end
		else
			main.model = "BRAK DANYCH"
			main.register = "BRAK DANYCH"
			main.predkosc = 0
			main.policeRegister = "BRAK DANYCH"
			main.kierowca = "BRAK DANYCH"
			main.reczny = "BRAK DANYCH"
		end

		dxDrawRectangle(441*w, 560*h, 403*w, 118*h, tocolor(15, 15, 30, 255), false)
  		dxDrawText("PRĘDKOŚĆ", 455*w, 594*h, 594*w, 621*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, false, false)
    	dxDrawText(main.predkosc.." KM/H", 455*w, 625*h, 594*w, 652*h, tocolor(254, 226, 35, 255), 1.00, exports.nrpg_interface:getGUIFont("money13"), "center", "top", false, false, false, false, false)
    	dxDrawText("POJAZD: "..utf8.upper(main.model).."\nREJESTRACJA: "..utf8.upper(main.register or "BRAK DANYCH").."\nKIEROWCA: "..utf8.upper(main.kierowca or "BRAK DANYCH").."\nRĘCZNY: "..utf8.upper(main.reczny or "BRAK DANYCH").."", 632*w, 577*h, 829*w, 662*h, tocolor(254, 254, 254, 255), 1.00, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "up" then
	if guiopen == true then
  		if isMouseIn(1224*w, 675*h, 46*w, 35*h) then
  			if main.gui == true then
  				main.gui = false
  			else
  				main.gui = true
  			end
  		end
  	end
end
end)

function isMouseIn ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end