local sx, sy = guiGetScreenSize()
local baseX = 1920
local zoom = 1 
local minZoom = 2 
if sx < baseX then 
    zoom = math.min(minZoom, baseX/sx)
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

addEvent("wczytajwlasciciela", true)
addEventHandler("wczytajwlasciciela",resourceRoot,function(wlasciciel)
if not wlasciciel then owner="Brak Danych" return end
owner=wlasciciel
end)

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

tick=getTickCount()
function render()
	if(getKeyState("mouse2"))then
		if(tick+100<getTickCount())then
			predkosc=getElementSpeed(cel_,"km/h")
			driver=getElementData(cel_,"vehicle:driver") or "Brak"
			id=getElementData(cel_,"vehicle:id") or "Brak"
            		wlasciciel=getElementData(cel_,"vehicle:ownedPlayer") or "Brak"
			tick=getTickCount()
		end
	dxDrawImage(731/zoom, 683/zoom, 442/zoom, 280/zoom, ":nrpg_interface/img/background_circle.png", 0, 0, 0, tocolor(103, 103, 103, 208), false)
        dxDrawText("ID: "..id.."\nOSTATNI KIEROWCA: "..driver:gsub("#%x%x%x%x%x%x","").."\nSID WŁAŚCICIELA: "..wlasciciel.."\nPRĘDKOŚĆ: "..math.round(predkosc or 0,2).." km/h", 734/zoom, 685/zoom, 1173/zoom, 963/zoom, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	end
	if(localPlayer:getWeapon()~=24)then
		if(r)then
			removeEventHandler("onClientRender",root,render)
			r=false
		end
	end
end
r=false
function mierzPredkosc(cel)
	if(source~=localPlayer)then return end
	if(localPlayer:getWeapon()==24)then
		cel_=cel
		if(cel)then
			if(cel.type=="vehicle")then
				if(not r)then
					r=true
					addEventHandler("onClientRender",root,render)
				end
			end
		else
			if(r)then
				removeEventHandler("onClientRender",root,render)
				r=false
			end
		end
	end
end
addEventHandler("onClientPlayerTarget",getRootElement(),mierzPredkosc)

function blokada ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(), newSlot) == 24 then 
		toggleControl( "fire", false )
        toggleControl( "action", false )
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), blokada)