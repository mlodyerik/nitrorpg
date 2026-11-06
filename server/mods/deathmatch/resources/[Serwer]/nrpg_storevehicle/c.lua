local screenW, screenH = guiGetScreenSize()
local px, py = screenW/1920, screenH/1080

local k = 1
local n10 = 5
local m10 = 5

local tick = getTickCount()

local table_vehicles = {}
local table_selectvehicles = {}
local actualVehTable = {}

animations = {
	alpha255 = 0,
	alpha255_background = 0,
	alpha200 = 0,
	alpha100 = 0,
}

windows = {
	togglegui = false,
	selectcar = false,
}

storeVehs = {

{
{1004.23, -1431.45, 13.55},
setElementData(createMarker(1004.23, -1431.45, 13.55-0.95, "cylinder", 1.5, 255, 175, 0, 55),"store:id",1),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody, motocykle#ffffff",
createColCuboid(978.29, -1439.58, 12.55, 7.94, 8.73, 4.56),{995.95, -1435.19, 13.27, 0.0, 0.0, 180.0}
},

{
{1612.77, -1559.49, 14.17},
setElementData(createMarker(1612.77, -1559.49, 14.17-0.95, "cylinder", 1.5, 255, 175, 0, 55),"store:id",2),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody, motocykle#ffffff",
createColCuboid(1604.7, -1557.9, 12.58, 6.3, 6, 4.56),{1607.95, -1553.12, 13.42, 0, 0, 0},
},

}

for i,v in ipairs(getElementsByType("marker", resourceRoot)) do
	if getElementData(v, "store:id") then
		setElementData(v, "marker:text", "Przechowalnia")
		setElementData(v, "marker:downtext", "Odbieranie pojazdów")
		setElementData(v, "marker:icon", "parking")
	end
end

id_stored_entered = nil

lib = exports.nrpg_lib

local zoom = 1
if screenW < 1920 then
    zoom = math.min(2, 1920 / screenW)
end

local zoom = exports.nrpg_interface:getInterfaceZoom()
local storePos = {x=0, y=0, w=math.floor(450/zoom), h=math.floor(615/zoom)}
storePos.x = screenW-storePos.w-math.floor(742/zoom)
storePos.y = screenH/2-storePos.h+math.floor(300/zoom)

local interface = {

    backgroundRectangle = lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(35, 35, 35, 255)),
	backgroundRectangle2 = lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 175, 0, 255)),
	backgroundCarRectangle = lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(100, 100, 100, 255)),
	listRectangle = lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(85, 85, 85, 255)),
	scrollRectangle = lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
    scrollRectangle2 = lib:dgsCreateRoundRect({{3,false},{3,false},{3,false},{3,false}},tocolor(255, 175, 0, 255)),

	fuelIcon = dxCreateTexture("libs/fuel.png"),
	mileageIcon = dxCreateTexture("libs/km.png"),
	lastIcon = dxCreateTexture("libs/last_time.png"),
	statusIcon = dxCreateTexture("libs/status.png"),

}

function window()
	local x, y, w, h = storePos.x, storePos.y, math.floor(100/zoom), math.floor(50/zoom)
	dxDrawImage(storePos.x, storePos.y, storePos.w, storePos.h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(storePos.x+math.floor(2/zoom), storePos.y+math.floor(2/zoom), storePos.w-math.floor(3/zoom), storePos.h-math.floor(3/zoom), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

	dxDrawImage(storePos.x+math.floor(15/zoom), storePos.y+math.floor(15/zoom), math.floor(405/zoom), math.floor(500/zoom), interface.backgroundCarRectangle, 0, 0, 0, tocolor(255, 255, 255, 25), false)

	exports["nrpg_buttons"]:dxCreateButton("Wyjmij pojazd", storePos.x+math.floor(15/zoom), storePos.y+math.floor(520/zoom), math.floor(420/zoom), math.floor(35/zoom), 1, {200, 145, 0})
	exports["nrpg_buttons"]:dxCreateButton("Zamknij okno", storePos.x+math.floor(15/zoom), storePos.y+math.floor(560/zoom), math.floor(420/zoom), math.floor(35/zoom), 1, {200, 55, 55})
	dxDrawText("Przechowalnia", x+math.floor(345/zoom), y-math.floor(40/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money17'), "center", "top", false, false, false, false, false)

	local xx = 0
	for i, v in ipairs(actualVehTable) do
		if i >= k and i <= n10 then 
			xx = xx + 1
			additionY = (math.floor(100/zoom))*(xx-1)

			if windows.selectcar == v.id then
				dxDrawImage(storePos.x+math.floor(15/zoom), storePos.y+math.floor(15/zoom)+additionY, math.floor(405/zoom), math.floor(95/zoom), interface.backgroundCarRectangle, 0, 0, 0, tocolor(255, 255, 255, 85), false)

				if windows.selectcar == v.id then
					dxDrawText("Wybrany pojazd", x, y+math.floor(25/zoom)+additionY, x+w+math.floor(310/zoom), y+h, tocolor(55, 255, 55, 200), 0.6, exports.nrpg_interface:getGUIFont('normal15'), "right", "top", false, false, false, false, false)
				else
					dxDrawText("Kliknij aby wybrać ten pojazd", x, y+math.floor(25/zoom)+additionY, x+w+math.floor(310/zoom), y+h, tocolor(255, 175, 0, 200), 0.6, exports.nrpg_interface:getGUIFont('normal15'), "right", "top", false, false, false, false, false)
				end

				local textWidth = dxGetTextWidth(exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), 1, exports.nrpg_interface:getGUIFont('money12'))
				dxDrawText(exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), x+math.floor(35/zoom), y+math.floor(30/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 225), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
				dxDrawText(v.id, x+math.floor(38/zoom)+textWidth, y+math.floor(30/zoom)+additionY, x+w, y+h, tocolor(255, 175, 0, 225), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)
			
				dxDrawImage(storePos.x+math.floor(35/zoom), storePos.y+math.floor(55/zoom)+additionY, math.floor(20/zoom), math.floor(20/zoom), interface.fuelIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
				dxDrawText(v.fuel.."/"..v.bak.." L", x+math.floor(60/zoom), y+math.floor(57/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 225), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)

				dxDrawImage(storePos.x+math.floor(35/zoom), storePos.y+math.floor(78/zoom)+additionY, math.floor(19/zoom), math.floor(19/zoom), interface.mileageIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
				dxDrawText(v.mileage.." km", x+math.floor(60/zoom), y+math.floor(80/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 225), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)
			else
				if isMouseIn(storePos.x+math.floor(15/zoom), storePos.y+math.floor(15/zoom)+additionY, math.floor(405/zoom), math.floor(95/zoom)) then
					dxDrawImage(storePos.x+math.floor(15/zoom), storePos.y+math.floor(15/zoom)+additionY, math.floor(405/zoom), math.floor(95/zoom), interface.backgroundCarRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

					if windows.selectcar == v.id then
						dxDrawText("Wybrany pojazd", x, y+math.floor(25/zoom)+additionY, x+w+math.floor(310/zoom), y+h, tocolor(55, 255, 55, 200), 0.6, exports.nrpg_interface:getGUIFont('normal15'), "right", "top", false, false, false, false, false)
					else
						dxDrawText("Kliknij aby wybrać ten pojazd", x, y+math.floor(25/zoom)+additionY, x+w+math.floor(310/zoom), y+h, tocolor(255, 175, 0, 200), 0.6, exports.nrpg_interface:getGUIFont('normal15'), "right", "top", false, false, false, false, false)
					end

					local textWidth = dxGetTextWidth(exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), 1, exports.nrpg_interface:getGUIFont('money12'))
					dxDrawText(exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), x+math.floor(35/zoom), y+math.floor(30/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
					dxDrawText(v.id, x+math.floor(38/zoom)+textWidth, y+math.floor(30/zoom)+additionY, x+w, y+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)
			
					dxDrawImage(storePos.x+math.floor(35/zoom), storePos.y+math.floor(55/zoom)+additionY, math.floor(20/zoom), math.floor(20/zoom), interface.fuelIcon, 0, 0, 0, tocolor(255, 255, 255, 225), false)
					dxDrawText(v.fuel.."/"..v.bak.." L", x+math.floor(60/zoom), y+math.floor(57/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)

					dxDrawImage(storePos.x+math.floor(35/zoom), storePos.y+math.floor(78/zoom)+additionY, math.floor(19/zoom), math.floor(19/zoom), interface.mileageIcon, 0, 0, 0, tocolor(255, 255, 255, 225), false)
					dxDrawText(v.mileage.." km", x+math.floor(60/zoom), y+math.floor(80/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)
				else
					dxDrawImage(storePos.x+math.floor(15/zoom), storePos.y+math.floor(15/zoom)+additionY, math.floor(405/zoom), math.floor(95/zoom), interface.backgroundCarRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)

					if windows.selectcar == v.id then
						dxDrawText("Wybrany pojazd", x, y+math.floor(25/zoom)+additionY, x+w+math.floor(310/zoom), y+h, tocolor(55, 255, 55, 155), 0.6, exports.nrpg_interface:getGUIFont('normal15'), "right", "top", false, false, false, false, false)
					else
						dxDrawText("Kliknij aby wybrać ten pojazd", x, y+math.floor(25/zoom)+additionY, x+w+math.floor(310/zoom), y+h, tocolor(255, 175, 0, 155), 0.6, exports.nrpg_interface:getGUIFont('normal15'), "right", "top", false, false, false, false, false)
					end

					local textWidth = dxGetTextWidth(exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), 1, exports.nrpg_interface:getGUIFont('money12'))
					dxDrawText(exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(v.model)), x+math.floor(35/zoom), y+math.floor(30/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
					dxDrawText(v.id, x+math.floor(38/zoom)+textWidth, y+math.floor(30/zoom)+additionY, x+w, y+h, tocolor(255, 175, 0, 175), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)
			
					dxDrawImage(storePos.x+math.floor(35/zoom), storePos.y+math.floor(55/zoom)+additionY, math.floor(20/zoom), math.floor(20/zoom), interface.fuelIcon, 0, 0, 0, tocolor(255, 255, 255, 200), false)
					dxDrawText(v.fuel.."/"..v.bak.." L", x+math.floor(60/zoom), y+math.floor(57/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)

					dxDrawImage(storePos.x+math.floor(35/zoom), storePos.y+math.floor(78/zoom)+additionY, math.floor(19/zoom), math.floor(19/zoom), interface.mileageIcon, 0, 0, 0, tocolor(255, 255, 255, 200), false)
					dxDrawText(v.mileage.." km", x+math.floor(60/zoom), y+math.floor(80/zoom)+additionY, x+w, y+h, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)
				end
			end
		end
	end
	drawScrollbar(actualVehTable, storePos.x+math.floor(425/zoom), storePos.y+math.floor(15/zoom), math.floor(495/zoom), m10, k)
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "up" then
	if windows.togglegui == true then
		local xx = 0
		for i, v in ipairs(actualVehTable) do
			if i >= k and i <= n10 then 
				xx = xx + 1
				additionY2 = (math.floor(100/zoom))*(xx-1)
				if isMouseIn(storePos.x+math.floor(15/zoom), storePos.y+math.floor(15/zoom)+additionY2, math.floor(405/zoom), math.floor(95/zoom)) and windows.togglegui == true and storeVehs[id_stored_entered][3][getVehicleType(v["model"])] then
					if v["id"] then
						windows.selectcar = v["id"]
					end
				end
			end
		end
	end


		if isMouseIn(storePos.x+math.floor(15/zoom), storePos.y+math.floor(520/zoom), math.floor(420/zoom), math.floor(35/zoom)) and windows.togglegui == true then
			if windows.selectcar ~= false then
				triggerServerEvent("spawnVehicleParkCar", localPlayer, windows.selectcar, localPlayer, storeVehs[id_stored_entered][6])
				showCursor(false)
				windows.selectcar = false
				removeEventHandler("onClientRender", root, window)
			else
				exports.nrpg_interface:showPlayerNotification("Wybierz pojazd", "error")
			end
		elseif isMouseIn(storePos.x+math.floor(15/zoom), storePos.y+math.floor(560/zoom), math.floor(420/zoom), math.floor(35/zoom)) and windows.togglegui == true then
			showCursor(false)
			windows.selectcar = false
			removeEventHandler("onClientRender", root, window)
		end
	end
end)

addEventHandler("onClientMarkerHit", root, function(plr,md)
	local id = getElementData(source, "store:id")
	if not id then return end
	if plr == localPlayer then
	if isPedInVehicle(plr) then return end
	k = 1
	 n10 = 5
	 m10 = 5
		showCursor(true)
		windows.togglegui=true
		windows.selectcar=false
		addEventHandler("onClientRender", root, window)
		triggerServerEvent("showVehiclesParkCar", plr)
		id_stored_entered = id
	end
end)

function drawScrollbar(table, x, y, height, m_, k_)
    dxDrawImage(x, y, 6, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)

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

addEventHandler("onClientMarkerLeave", root, function(plr,md)
	if plr~= localPlayer then return end
	if isPedInVehicle(plr) then return end

	showCursor(false)
	windows.togglegui=false
	windows.selectcar=false
	removeEventHandler("onClientRender", root, window)
end)

addEvent("showVehiclesParkCarClient", true)
addEventHandler("showVehiclesParkCarClient", root, function(tablee)
  table_vehicles = tablee
  actualVehTable = {}
  	
 	for i, v in ipairs(table_vehicles) do
		if storeVehs[id_stored_entered][3][getVehicleType(v["model"])] then
			table.insert(actualVehTable, v)
		end
	end
end)

bindKey("mouse_wheel_down", "both", function()
	if windows.togglegui == true and isMouseIn(storePos.x, storePos.y, storePos.w, storePos.h) then
		scrollUp()
	end
end)

bindKey("mouse_wheel_up", "both", function()
	if windows.togglegui == true and isMouseIn(storePos.x, storePos.y, storePos.w, storePos.h) then
    	scrollDown()
	end
end)

function scrollDown()
    if n10 == m10 then return end
    k = k-1
    n10 = n10-1
end

function scrollUp()
    if n10 >= #actualVehTable then return end
    k = k+1
    n10 = n10+1
end

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