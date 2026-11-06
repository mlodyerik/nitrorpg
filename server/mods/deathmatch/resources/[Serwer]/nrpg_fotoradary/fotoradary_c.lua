local sw,sh = guiGetScreenSize()
local alphaGraphics = 255
local element = element or true
local czasZnikania = 10000
local infoTable = {}


local punkty = {

	{-2322.27, -63.40, 35.32, 8, limit=60, 50},
	{-1994.31, 506.14, 35.17, 10, limit=60, -20},
	{-2245.04, 117.21, 35.32, 8, limit=60, -30},
	{-2699.46, 259.69, 4.34, 8, limit=60, -30},
	{-1678.49, 1247.21, 7.18, 20, limit=120, 180},
	{-1655.93, 382.97, 7.19, 10, limit=60, -60},
	{-2164.46, -468.67, 46.18, 30, limit=120, -120},
	{-1812.47, -444.08, 15.11, 10, limit=80, -30},
	{-2828.49, -396.84, 7.19, 10, limit=80, 150},

}

function getAllPoints()
	return punkty
end

function onRender()
	if pokazRender == true and render_data then
		if isPedInVehicle(localPlayer) then
			local dodatkoweInfo = dodatkoweInfo or "-"
			
			local dopuszczalnaPredkosc = infoTable.dop
			local przekroczonaPredkosc = infoTable.przek
			local pln = tonumber(infoTable.zaplata)

			
		
			if pln then
				local text = "#FFFFFFTwój nick: #C4C4C4"..getPlayerName(localPlayer).."#ffffff\nModel pojazdu: #008AFF"..exports['nrpg_vehicles']:changeName(getVehicleName(getPedOccupiedVehicle(localPlayer))).."#ffffff\nRejestracja pojazdu: "..string.gsub(getVehiclePlateText(getPedOccupiedVehicle(localPlayer))," ", "").."\n#FFFFFFPrzekroczona prędkość o: #FF0000"..math.floor(przekroczonaPredkosc).."#FFFFFF km/h\nWysokość mandatu: #00FF00"..convertNumber(pln).."#FFFFFF PLN"
				dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sw/2,sh/2+(516*w),sw/2+(2*w),sh/2+(2*w),tocolor(0,0,0,alphaGraphics or 0),1,exports.nrpg_interface:getGUIFont("money10"),"center","center",false,false,false,true)
				dxDrawText(text,sw/2,sh/2+(515*w),sw/2,sh/2,tocolor(200,200,200,alphaGraphics or 0),1,exports.nrpg_interface:getGUIFont("money10"),"center","center",false,false,false,true)
			else
				local text = "Ładowanie..."
				dxDrawText(text:gsub("#%x%x%x%x%x%x", ""),sw/2,sh/2+(516*w),sw/2+(2*w),sh/2+(2*w),tocolor(0,0,0,alphaGraphics or 0),1,exports.nrpg_interface:getGUIFont("money10"),"center","center",false,false,false,true)
				dxDrawText(text,sw/2,sh/2+(515*w),sw/2,sh/2,tocolor(200,200,200,alphaGraphics or 0),1,exports.nrpg_interface:getGUIFont("money10"),"center","center",false,false,false,true)
			end
		
		
			if element == true then
				if alphaGraphics > 224 then
					alphaGraphics = 225 
					element = false
				else
					alphaGraphics = alphaGraphics+0.4
				end
			end
		
		end
	else
		render_data = nil
	end

	if isPedInVehicle(localPlayer) then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh and isElement(veh) and getElementData(veh, "vehicle:wykrywaczState") == true then
			local x,y,z = getElementPosition(localPlayer)
			for i,v in ipairs(punkty) do
				local dist = getDistanceBetweenPoints3D(x,y,z,v[1],v[2],v[3])
				if dist <= 151 then
					
					dxDrawImage(10,sh-60-50,50,50,"radar.png")
					local s=1.5
					if tonumber(v.limit) >= 100 then s=1.2 end
					dxDrawText(v.limit,10,sh-110-50,60,sh-10,tocolor(0,0,0,255),s,"default-bold","center","center",false,false,false,false)
						
					dxDrawRectangle(10,sh-60-50-30,50,20,tocolor(0,0,0,200))
					s=1.2
					if tonumber(v.limit) >= 100 then s=1.0 end
					dxDrawText(tostring(math.floor(dist)).." m",10,sh-110-50-30,60,sh-10-50-30+20,tocolor(255,255,255,255),s,"default-bold","center","center",false,false,false,false)
					return
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,onRender)

function convertNumber(amount) 
    local formatted = amount 
    while true do   
      formatted, ss = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (ss==0) then 
        break 
      end 
    end 
    return formatted 
end

local czas = getTickCount()
local sww,shh = guiGetScreenSize()
local screenRot = math.random(-25,25)
local screen = dxCreateScreenSource(sww/3,shh/3)

GUIEditor = {
    button = {},
    window = {},
    label = {}
}


mojeW,mojeH = 1280,1024 sWW,sHH = guiGetScreenSize() w,h = (sWW/mojeW),(sHH/mojeH)
mw2,mh2=1920,1080
w2,h2=(sWW/mw2),(sHH/mh2)



-- function pokazWykrywacz()
	-- if isPedInVehicle(localPlayer) and getElementData(getPedOccupiedVehicle(localPlayer),"tune:Wykrywacz_radarow") == 1 then
		-- if getElementData(getPedOccupiedVehicle(localPlayer),"Wykrywacz_radarow:stan") == true then
			-- stan = "Włączony"
			-- stan2 = "Wyłącz"
		-- else
			-- stan = "Wyłączony"
			-- stan2 = "Włącz"
		-- end
		-- if getVehicleController(getPedOccupiedVehicle(localPlayer)) ~= localPlayer then return end
		-- GUIEditor.window[1] = guiCreateWindow(1280/2*w,764*h,202*w,250*h,"Wykrywacz radarow",false)
		-- GUIEditor.label[1] = guiCreateLabel(10*w,26*h,182*w,62*h,"Stan wykrywacza:\n"..stan,false,GUIEditor.window[1])
		-- GUIEditor.button[1] = guiCreateButton(9*w,161*h,182*w,43*h,stan2,false,GUIEditor.window[1])
		-- guiWindowSetSizable(GUIEditor.window[1],false)
		-- guiSetFont(GUIEditor.label[1],"default-bold-small")
		-- guiLabelSetHorizontalAlign(GUIEditor.label[1],"center",false)
		-- guiLabelSetVerticalAlign(GUIEditor.label[1],"center")
		-- guiSetFont(GUIEditor.button[1],"clear-normal")
		-- guiSetProperty(GUIEditor.button[1],"NormalTextColour","FFAAAAAA")
		-- showCursor(true)
	-- end
-- end


-- bindKey("k","up",function()
	-- if GUIEditor.window[1] then
		-- ukryjWykrywacz()
	-- else
		-- pokazWykrywacz()
	-- end
-- end)

function ukryjWykrywacz()
	if GUIEditor.window[1] and isElement(GUIEditor.window[1]) then
		showCursor(false) destroyElement(GUIEditor.window[1]) GUIEditor = { button = {},window = {},label = {} }
	end
end

function wlaczWykrywacz()
	if GUIEditor.label[1] and isElement(GUIEditor.label[1]) then guiSetText(GUIEditor.label[1],"Stan wykrywacza:\nWłączony") end
	if GUIEditor.button[1] and isElement(GUIEditor.button[1]) then guiSetText(GUIEditor.button[1],"Wyłącz") end
	if isPedInVehicle(localPlayer) then setElementData(getPedOccupiedVehicle(localPlayer),"Wykrywacz_radarow:stan",true) end
	for _,object in ipairs(getElementsByType("object",resourceRoot)) do
		if getElementModel(object) == 16101 then blip = createBlipAttachedTo(object,0,1,255,255,0,255,200,200) setElementData(blip,"Wykrywacz_radarow:blip","tak") end
	end
end

function wylaczWykrywacz()
	if GUIEditor.label[1] and isElement(GUIEditor.label[1]) then guiSetText(GUIEditor.label[1],"Stan wykrywacza:\nWyłączony") end
	if GUIEditor.button[1] and isElement(GUIEditor.button[1]) then guiSetText(GUIEditor.button[1],"Włącz") end
	if isPedInVehicle(localPlayer) then setElementData(getPedOccupiedVehicle(localPlayer),"Wykrywacz_radarow:stan",false) end
	for _,blip in ipairs(getElementsByType("blip",resourceRoot)) do
		if getElementData(blip,"Wykrywacz_radarow:blip") == "tak" then destroyElement(blip) end
	end
end
addEventHandler("onClientVehicleExit",localPlayer,ukryjWykrywacz)


addEventHandler("onClientGUIClick",resourceRoot,function()
	if GUIEditor.button[1] and isElement(GUIEditor.button[1]) and source == GUIEditor.button[1] then
		if guiGetText(GUIEditor.button[1]) == "Włącz" then wlaczWykrywacz() else wylaczWykrywacz() end
	end
end)

function niePokazujonClientRender()
	--removeEventHandler("onClientRender",root,onRender)
	pokazRender = false
end

function wlaczFotoradar(theElement,matchingDimension)
	for k,v in pairs(punkty) do
		if (source == punkty[k].cs) then
			if getTickCount()-czas<500 then return end
			if (theElement == getLocalPlayer() and isPedInVehicle(getLocalPlayer())) then
				if getElementData(localPlayer, "player:faction") == "SAPD" then return end
				pojazd = getPedOccupiedVehicle(theElement)
				if not getElementData(pojazd, "vehicle:id") then return end
				if getVehicleController(pojazd) ~= localPlayer then return end
				if (getVehicleSirensOn(pojazd) and not getElementData(pojazd,"private")) or getVehicleType(pojazd)=="Plane" or getVehicleType(pojazd)=="Helicopter" or getVehicleType(pojazd)=="Boat" or getVehicleType(pojazd)=="BMX" or (getElementModel(pojazd) == 490 and not getElementData(pojazd,"private")) or (getElementModel(pojazd) == 523 and not getElementData(pojazd,"private")) or (getElementModel(pojazd) == 586 and not getElementData(pojazd,"private")) then
				else
					if getElementDimension(localPlayer) ~= 0 then return end
					if getElementInterior(localPlayer) ~= 0 then return end
					local carTint = getElementData(pojazd, "vehicle:carTint") or 0
					if tonumber(carTint) > 50 then return end
					--speedx,speedy,speedz = getElementVelocity(pojazd)
					--kmh = math.sqrt(speedx^2 + speedy^2 + speedz^2)*0.93*180
					local sx, sy, sz = getElementVelocity(pojazd)
					local kmh = (( sx^2 + sy^2 + sz^2)^(0.5))*160
			
					
					przekroczoneo = kmh - punkty[k].limit
					przekroczoneoZ = string.format("%.01f",przekroczoneo)
					if (kmh-10>punkty[k].limit) then
						fadeCamera(false,0.1,255,255,255)
						setSoundMaxDistance(playSound3D("fotoradar.ogg",punkty[k][1],punkty[k][2],punkty[k][3],false),31337)
						if (screen) then
							dxUpdateScreenSource(screen)
							x,y,z = getElementPosition(pojazd)
							if timer and isTimer(timer) then killTimer(timer) end
							timer = setTimer(niePokazujonClientRender,czasZnikania,1)
							
							--setTimer(function(v1,v2)
								local v1,v2=punkty[k].limit,przekroczoneoZ
								pokazRender = true
								
								render_data = {dop=v1,przek=v2}
								
								-- setElementData(localPlayer,"fotoradar:mandat:dopuszczalnaPredkosc",v1)
								-- setElementData(localPlayer,"fotoradar:mandat:przekroczonaPredkosc",v2)
							--end,100,1,punkty[k].limit,przekroczoneoZ)
						end
						czas = getTickCount()
						setTimer(fadeCamera,60,1,true,1.5)
						triggerServerEvent("reloadFotoradarInfo", localPlayer, localPlayer, render_data.przek, render_data.dop)
					end
				end
			end return
		end
	end
end

addEvent("radarInfoClient", true)
addEventHandler("radarInfoClient", root, function(plr, info)
	infoTable = info
end)

for k,v in pairs(punkty) do
	punkty[k].cs = createColSphere(punkty[k][1],punkty[k][2],punkty[k][3],punkty[k][4])
	ograniczenie = createMarker (punkty[k][1],punkty[k][2],punkty[k][3]-10,"cylinder",30,0,0,0,0)
	model = createObject(16101,punkty[k][1],punkty[k][2],punkty[k][3]-1.25, 0, 0, punkty[k][5])
end
addEventHandler("onClientColShapeHit",resourceRoot,wlaczFotoradar)