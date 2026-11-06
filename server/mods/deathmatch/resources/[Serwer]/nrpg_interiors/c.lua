local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local backgroundPos = {x=math.floor(screenW/2-600/zoom/2), y=1000, w=math.floor(600/zoom), h=math.floor(80/zoom)}
backgroundPos.y = screenH-backgroundPos.h

local backgroundPos2 = {x=math.floor(screenW/2-600/zoom/2), y=0, w=math.floor(600/zoom), h=math.floor(80/zoom)}
backgroundPos2.y = screenH-backgroundPos2.h

local main = {

    getLib = exports.nrpg_lib,
    toggleGUI = false,
	bindKey = "Q",

}

local interiors = {

	{"SAPD", 1172.08, -1323.50, 15.41, 4620.18, 373.37, 5392.20, 0, 0, "komisariatu", 4618.70, 373.12, 5392.20, 1187.32, -1324.10, 13.56},
	{"Kopalnia", -1885.14, -1636.54, 21.75, -2091.81, -1524.15, 77.80, 0, 0, "kopalni", -2091.99, -1527.28, 77.80, -1885.20, -1642.18, 21.75},
	{"Magazyn", 1765.01, -2040.73, 13.53, 3930.80, 691.38, 84.40, 0, 0, "magazynu", 3932.35, 691.39, 84.40, 1771.22, -2040.58, 13.53},
	{"Sklep", 2047.79, -1897.96, 13.55, 2073.84, -1905.32, -9.70, 0, 0, "sklepu", 2070.76, -1904.52, -9.70, 2047.30, -1901.27, 13.55},
	--{"Szkoła jazdy", 1081.17, -1697.52, 13.55, 1000.52, -1547.67, 29.90, 2137, 0, "szkoły jazdy", 1000.52, -1550.02, 29.90, 1081.06, -1700.37, 13.55},
	{"Urząd", -1961.28, 434.09, 35.17, 4102.17, 456.73, 214.42, 20, 20, "urzędu", 4101.83, 454.42, 214.30, -1965.29, 434.11, 35.17},
	{"Przebieralnia", 1054.24, -1581.36, 13.55, 1541.71, -638.47, 453.30, 2137, 0, "przebieralni", 1541.67, -635.91, 453.30, 1054.33, -1579.34, 13.55},
	{"Kasyno", -2226.34, 252.01, 35.32, 1133.04, -15.83, 1000.68, 1, 12, "kasyna", 1133.00, -12.12, 1000.68, -2230.93, 252.05, 35.32},

}

function addInteriorToList(name, x1, y1, z1, x2, y2, z2, dim, int, name2, x3, y3, z3, x4, y4, z4)
	if name then
		if not interiors[name] then
			table.insert(interiors, {name, x1, y1, z1, x2, y2, z2, dim, int, name2, x3, y3, z3, x4, y4, z4})
			reloadInteriors()
			print("[nrpg_interiors] Dodano interior "..name)
		end
	end
end

local blips = {

	--Los Santos
	{1054.37, -1590.11, 13.54, 45},-- Przebieralnia
	{1802.09, -1889.59, 16.33, 46},-- PKS
	{1804.43, -2072.43, 15.25, 46},-- Magazynier
	{2749.45, -2386.75, 13.98, 46},-- Kurier
	{1802.22, -1689.41, 13.54, 46},-- Sweepers
	{1035.59, -1445.45, 16.33, 16},-- Parking policyjny 
	{1109.11, -1685.33, 13.56, 27},-- Mechanik
	{1310.20, -1367.57, 13.54, 39}, -- Urząd
	{1185.24, -1324.68, 13.57, 30}, -- SAPD
	{1729.84, -1775.15, 13.52, 20}, -- SAFD
	--

	--San Fierro
	--

	--Las Venturas
	--

	--Blueberry
	{-52.77, -317.42, 5.43, 11}, -- SARA
	--



}

local blipsColor = {

	[5] = {0, 255, 68}, 
	[6] = {255, 0, 230},
	[7] = {0, 110, 255},
	[8] = {255, 0, 255},
	[9] = {155, 155, 255},
	[10] = {0, 110, 255},
	[11] = {0, 110, 255},
	[12] = {255, 255, 0},
	[18] = {0, 255, 68},
	[20] = {255, 55, 55},
	[21] = {255, 0, 0},
	[22] = {255, 255, 0},
	[23] = {0, 144, 255},
	[27] = {255, 255, 0},
	[29] = {255, 155, 0},
	[30] = {0, 64, 255},
	[31] = {0, 255, 0},
	[32] = {255, 0, 0},
	[33] = {0, 144, 255},
	[35] = {0, 251, 255},
	[38] = {255, 100, 100},
	[39] = {255, 155, 255},
	[41] = {255, 0, 0},
	[42] = {0, 255, 0},
	[37] = {255, 255, 255},
	[43] = {255, 100, 100},
	[44] = {255, 255, 100},
	[45] = {255, 89, 0},
	[46] = {100, 255, 100},
	[52] = {0, 200, 0},
	[53] = {255, 89, 0},
	[55] = {0, 144, 255},
	[56] = {157, 0, 255},
	[25] = {0, 144, 255},

}

local interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 25, 255)),
	backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
	doorIcon = dxCreateTexture("img/door.png"),
	background = dxCreateTexture("img/loading_background.jpg"),
	loadingIcon = dxCreateTexture("img/loading.png"),
	alpha = 0,
	alphaScreen = 0,
	alphaLoading = 0,
	loading = 0,
	dots = 0,
	dotsText = "",

}

local interiorInfo = {}

function useTeleport()
	if interiorInfo.enterName == "restauracji" then
		if getElementData(localPlayer, "player:napad") then
			exports["nrpg_napady"]:endNapad("exit")
		end
	end
	main.interiorState = 2
	setElementData(localPlayer, "notshowhud", true)
	showChat(false)
	createAnimation(interface.alphaScreen, 255, 'Linear', 500, function(value) interface.alphaScreen = value end)
	createAnimation(backgroundPos.y, 1000, 'Linear', 10, function(value) backgroundPos.y = value end)

	setTimer(function()
		createAnimation(interface.alphaLoading, 255, 'Linear', 500, function(value) interface.alphaLoading = value end)
		triggerServerEvent("warpInterior", localPlayer, interiorInfo.tpPos[1], interiorInfo.tpPos[2], interiorInfo.tpPos[3], interiorInfo.tpPos[4], interiorInfo.tpPos[5], interiorInfo.tpPos[6])

		setTimer(function()
			setElementFrozen(localPlayer, true)
		end, 1000, 1)

		setTimer(function()
			createAnimation(interface.alphaLoading, 0, 'Linear', 500, function(value) interface.alphaLoading = value end)

			setTimer(function()
				createAnimation(interface.alphaScreen, 0, 'Linear', 500, function(value) interface.alphaScreen = value end)
				unbindKey(main.bindKey, "down", useTeleport)
				if isEventHandlerAdded("onClientRender", root, drawInterior) then
					removeEventHandler("onClientRender", root, drawInterior)
				end
				interiorInfo = {}
				setElementFrozen(localPlayer, false)
				setElementData(localPlayer, "notshowhud", false)
				showChat(true)
			end, 500, 1)
		end, 5000, 1)
	end, 600, 1)
end

function drawInterior()
	if main.interiorState == 1 then
		local x, y, w, h = backgroundPos.x, math.floor(backgroundPos.y), backgroundPos.w, backgroundPos.h
		dxDrawImage(backgroundPos.x+math.floor(50/zoom), backgroundPos.y-math.floor(60/zoom), backgroundPos.w-math.floor(125/zoom), backgroundPos.h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, interface.alpha), false)
		dxDrawImage(backgroundPos.x+math.floor(51/zoom), backgroundPos.y-math.floor(59/zoom), backgroundPos.w-math.floor(128/zoom), backgroundPos.h-math.floor(3/zoom), interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, interface.alpha), false)
		dxDrawImage(backgroundPos.x+math.floor(60/zoom), backgroundPos.y-math.floor(45/zoom), math.floor(45/zoom), math.floor(45/zoom), interface.doorIcon, 0, 0, 0, tocolor(255, 255, 255, interface.alpha), false)
		dxDrawText(interiorInfo.name, x+math.floor(110/zoom), y-math.floor(42/zoom), x+w, y+h, tocolor(255, 255, 255, interface.alpha), 1, exports.NRPG_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)	

		if interiorInfo.type == "enter" then
			dxDrawText("Kliknij #fccf03"..main.bindKey.."#ffffff aby wejść do pomieszczenia", x+math.floor(110/zoom), y-math.floor(22/zoom), x+w, y+h, tocolor(255, 255, 255, interface.alpha), 1, exports.NRPG_interface:getGUIFont('light11'), "left", "top", false, false, false, true, false)
		else
			dxDrawText("Kliknij #fccf03"..main.bindKey.."#ffffff aby wyjść do pomieszczenia", x+math.floor(110/zoom), y-math.floor(22/zoom), x+w, y+h, tocolor(255, 255, 255, interface.alpha), 1, exports.NRPG_interface:getGUIFont('light11'), "left", "top", false, false, false, true, false)
		end
	elseif main.interiorState == 2 then
		local x, y, w, h = backgroundPos2.x, math.floor(backgroundPos2.y), backgroundPos2.w, backgroundPos2.h
		interface.loading = interface.loading + 2
		interface.dots = interface.dots + 0.5

		if interface.dots > 120 then
			interface.dots = 0
		elseif interface.dots > 90 then
			interface.dotsText = "..."
		elseif interface.dots > 60 then
			interface.dotsText = ".."
		elseif interface.dots > 30 then
			interface.dotsText = "."
		else
			interface.dotsText = ""
		end

		dxDrawRectangle(0, 0, screenW, screenH, tocolor(0, 0, 0, interface.alphaScreen), false)
		dxDrawImage(0, 0, screenW, screenH, interface.background, 0, 0, 0, tocolor(255, 255, 255, interface.alphaLoading), false)
		dxDrawImage(backgroundPos2.x-math.floor(625/zoom), backgroundPos2.y-math.floor(15/zoom), math.floor(50/zoom), math.floor(50/zoom), interface.loadingIcon, interface.loading, 0, 0, tocolor(255, 255, 255, interface.alphaLoading), false)

		if interiorInfo.type == "enter" then
			dxDrawText("Wchodzisz do "..interiorInfo.enterName..""..interface.dotsText, x-math.floor(555/zoom), y-math.floor(10/zoom), x+w, y+h, tocolor(255, 255, 255, interface.alphaLoading), 1, exports.NRPG_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
		else
			dxDrawText("Wychodzisz z "..interiorInfo.enterName..""..interface.dotsText, x-math.floor(555/zoom), y-math.floor(10/zoom), x+w, y+h, tocolor(255, 255, 255, interface.alphaLoading), 1, exports.NRPG_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
		end
		dxDrawText("Poczekaj chwilę", x-math.floor(555/zoom), y+math.floor(10/zoom), x+w, y+h, tocolor(255, 255, 255, interface.alphaLoading), 1, exports.NRPG_interface:getGUIFont('light12'), "left", "top", false, false, false, true, false)
	end
end

for i,v in ipairs(blips) do
	if blipsColor[v[4]] then
		r, g, b = blipsColor[v[4]][1], blipsColor[v[4]][2], blipsColor[v[4]][3]
	else
		r, g, b = 255, 255, 255
	end

	blip = createBlip(v[1], v[2], v[3], v[4], 2, r, g, b, 255, 0, 650)
end

function reloadInteriors()
for i,v in ipairs(getElementsByType("marker", resourceRoot)) do
	destroyElement(v)
end

for i,v in ipairs(interiors) do
	marker_enter = createMarker(v[2], v[3], v[4]-1, "corona", 1.5, 255, 255, 0, 0)
	local visible = createMarker(v[2], v[3], v[4]-1, "cylinder", 1.5, 255, 255, 0, 25)
	setElementData(visible, "marker:icon", "door")
	setElementData(visible, "marker:text", v[1])
	setElementData(visible, "marker:downtext", "Wejście do pomieszczenia")
	marker_exit = createMarker(v[5], v[6], v[7]-1, "corona", 1.5, 255, 255, 0, 0)
	m2 = createMarker(v[5], v[6], v[7]-1, "cylinder", 1.5, 255, 255, 0, 25)
	setElementData(m2, "marker:icon", "door")
	setElementData(m2, "marker:text", v[1])
	setElementData(m2, "marker:downtext", "Wyjście z pomieszczenia")
	setElementDimension(m2, v[8])
	setElementInterior(m2, v[9])
	setElementDimension(marker_exit, v[8])
	setElementInterior(marker_exit, v[9])

	addEventHandler("onClientMarkerHit", marker_exit, function(el, md)
		if el ~= localPlayer then return end
		if isPedInVehicle(el) then return end
		if md == false then return end
		if getElementData(localPlayer, "player:job") then exports.nrpg_interface:showPlayerNotification("Zakończ pracę!", "error") return end
		if getElementData(localPlayer, "vehicle:id") or getElementData(localPlayer, "vehicle:fuel") or getPedOccupiedVehicle(localPlayer) then return end
		main.interiorState = 1
		if not isEventHandlerAdded("onClientRender", root, drawInterior) then
			addEventHandler("onClientRender", root, drawInterior)
		end
		interiorInfo = {name=v[1], type="exit", enterName=v[10], tpPos={v[14], v[15], v[16], 0, 0, v[1]}}
		setElementData(localPlayer, "player:napad:interior", false)
		bindKey(main.bindKey, "down", useTeleport)
		createAnimation(interface.alpha, 255, 'Linear', 500, function(value) interface.alpha = value end)
		createAnimation(backgroundPos.y, (screenH-backgroundPos.h), 'Linear', 500, function(value) backgroundPos.y = value end)
	end)

	addEventHandler("onClientMarkerHit", marker_enter, function(el, md)
		if el ~= localPlayer then return end
		if isPedInVehicle(el) then return end
		if md == false then return end
		if getElementData(localPlayer, "player:job") then exports.nrpg_interface:showPlayerNotification("Zakończ pracę!", "error") return end
		if getElementData(localPlayer, "vehicle:id") or getElementData(localPlayer, "vehicle:fuel") or getPedOccupiedVehicle(localPlayer) then return end
		main.interiorState = 1
		if not isEventHandlerAdded("onClientRender", root, drawInterior) then
			addEventHandler("onClientRender", root, drawInterior)
		end
		interiorInfo = {name=v[1], type="enter", enterName=v[10], tpPos={v[11], v[12], v[13], v[8], v[9], v[1]}}
		local x, y, z = getElementPosition(source)
		setElementData(localPlayer, "player:napad:interior", {x, y, z, interiorInfo.tpPos[4], interiorInfo.tpPos[5], interiorInfo.tpPos[6]})
		bindKey(main.bindKey, "down", useTeleport)
		createAnimation(interface.alpha, 255, 'Linear', 500, function(value) interface.alpha = value end)
		createAnimation(backgroundPos.y, (screenH-backgroundPos.h), 'Linear', 500, function(value) backgroundPos.y = value end)
--triggerServerEvent("warpInterior", localPlayer, v[11], v[12], v[13], v[8], v[9], v[1])
	end)

	addEventHandler("onClientMarkerLeave", marker_enter, function(el, md)
		if el ~= localPlayer then return end
		if md == false then return end
		if isPedInVehicle(el) then return end
		if getElementData(localPlayer, "player:job") then exports.nrpg_interface:showPlayerNotification("Zakończ pracę!", "error") return end
		if getElementData(localPlayer, "vehicle:id") or getElementData(localPlayer, "vehicle:fuel") or getPedOccupiedVehicle(localPlayer) then return end
		if main.interiorState == 2 then return end
		createAnimation(interface.alpha, 0, 'Linear', 500, function(value) interface.alpha = value end)
		createAnimation(backgroundPos.y, 1000, 'Linear', 500, function(value) backgroundPos.y = value end)
		unbindKey(main.bindKey, "down", useTeleport)
		setElementData(localPlayer, "player:napad:interior", false)
		setTimer(function()
			if isEventHandlerAdded("onClientRender", root, drawInterior) then
				removeEventHandler("onClientRender", root, drawInterior)
			end
			interiorInfo = {}
		end, 560, 1)
	end)

	addEventHandler("onClientMarkerLeave", marker_exit, function(el, md)
		if el ~= localPlayer then return end
		if md == false then return end
		if isPedInVehicle(el) then return end
		if getElementData(localPlayer, "player:job") then exports.nrpg_interface:showPlayerNotification("Zakończ pracę!", "error") return end
		if getElementData(localPlayer, "vehicle:id") or getElementData(localPlayer, "vehicle:fuel") or getPedOccupiedVehicle(localPlayer) then return end
		if main.interiorState == 2 then return end
		createAnimation(interface.alpha, 0, 'Linear', 500, function(value) interface.alpha = value end)
		createAnimation(backgroundPos.y, 1000, 'Linear', 500, function(value) backgroundPos.y = value end)
		unbindKey(main.bindKey, "down", useTeleport)
		setElementData(localPlayer, "player:napad:interior", false)
		setTimer(function()
			if isEventHandlerAdded("onClientRender", root, drawInterior) then
				removeEventHandler("onClientRender", root, drawInterior)
			end
			interiorInfo = {}
		end, 560, 1)
	end)
end
end
reloadInteriors()

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end