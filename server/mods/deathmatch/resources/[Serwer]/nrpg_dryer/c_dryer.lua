local screenW, screenH = guiGetScreenSize()
local w, h = screenW/1280, screenH/720

local option={}
local vehicle={}
local player={}
value = nil
element = nil
option.selected = 0
option.actived = false

zoom = 1
if screenW < 1920 then
    zoom = math.min(2, 1920 / screenW)
end


option["vehicle"] = {

    "OBRÓĆ",
    "NAPRAW",
    "PRZENIEŚ DO SIEBIE",
    "SCHOWAJ DO PRZECHOWALNI",
    "ODDAJ NA PARKING POLICYJNY",
    "RESPAWNUJ POJAZD(USUŃ)",
    "ZATANKUJ",
    "OTWORZ AUTO",

}

option["player"] = {

    "ULECZ",
    "ZABIJ",
    "PRZENIEŚ DO SIEBIE",
    "PRZENIEŚ DO NIEGO",

}

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

function isRendering()
    if isPedAiming(localPlayer) and getPedWeapon(localPlayer) == 22 and getElementData(localPlayer, "player:admin") == true then
    if option.actived == true then
    	if not element then return end
        if value == "vehicle" then
            
            local v_pojemnosc = getElementData(element, "Pojemnosc:silnika") or "1.4"
            local v_bak = getElementData(element, "vehicle:bak") or 25
            local v_fuel = math.floor(getElementData(element, "vehicle:fuel") or 0)
            local v_last_driver = getElementData(element, "vehicle:driver") or "Brak"
            local v_organization = getElementData(element, "vehicle:ownedGroup") or "Brak"
            local v_owner = getElementData(element, "vehicle:ownedPlayer") or "Brak"
            
            if v_organization == "0" or v_organization == 0 or v_organization == " " or v_organization then
                v_organization = "Brak"
            end

            local v_id = getElementData(element, "vehicle:id") or "Brak"
            local v_mileage = math.floor(getElementData(element, "vehicle:mileage") or 0)

            local sx, sy, sz = getElementVelocity(element)
            local v_speed = math.ceil(((sx^2+sy^2+sz^2)^(0.5)) * 161) or 0
	        local v_idm = getVehicleID(element)
 	        local v_nazwa = getVehicleName(element)

            stringInfo = "ID: "..v_id.."\nPojazd: "..exports["nrpg_vehicles"]:changeName(v_nazwa).." (Model: "..v_idm..")\nPojemność silnika: "..v_pojemnosc.." dm3 (Bak: "..v_bak.." L)\nPaliwo: "..v_fuel.."/"..v_bak.."L\nOstatni kierowca: "..v_last_driver.."\nPrzebieg: "..v_mileage.." km\n\nPrędkość: "..v_speed.." km/h"

            dxDrawText(option[value][option.selected] or "WYBIERZ OPCJE", 515*w, 11*h, 852*w, 44*h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont("money15"), "center", "bottom", false, false, false, false, false)
            dxDrawText(stringInfo, 515*w, 45*h, 852*w, 78*h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont("light14"), "center", "top", false, false, false, false, false)
            dxDrawText(option[value][option.selected] or "WYBIERZ OPCJE", 514*w, 10*h, 852*w, 44*h, tocolor(255, 255, 0, 255), 1, exports.nrpg_interface:getGUIFont("money15"), "center", "bottom", false, false, false, false, false)
            dxDrawText(stringInfo, 514*w, 44*h, 852*w, 78*h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont("light14"), "center", "top", false, false, false, false, false)


        elseif value == "player" then

            local p_uid = getElementData(element, "player:sid") or 0
            local p_id = getElementData(element, "id") or 0
            local p_money = getPlayerMoney(element)
            local p_skin = getElementData(element, "player:skin") or 0
            local p_organization = getElementData(element, "player:organization") or "Brak"
            local p_faction = getElementData(element, "player:faction") or "Brak"
            local p_time = getElementData(element, "player:hours") or 0
            local p_pp = getElementData(element, "player:pp") or 0

            stringInfo2 = "SID: "..p_uid.."\ID: "..p_id.."\nGotówka: "..p_money.." PLN\nPunkty premium: "..p_pp.."\nSkin: "..p_skin.."\nOrganizacja: "..p_organization.."\nFrakcja: "..p_faction.."\nPrzegrany czas: "..p_time.." minut"

            dxDrawText(option[value][option.selected] or "WYBIERZ OPCJE", 515*w, 11*h, 852*w, 44*h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont("money15"), "center", "bottom", false, false, false, false, false)
            dxDrawText(stringInfo2, 515*w, 45*h, 852*w, 78*h, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont("light14"), "center", "top", false, false, false, false, false)
            dxDrawText(option[value][option.selected] or "WYBIERZ OPCJE", 514*w, 10*h, 852*w, 44*h, tocolor(255, 255, 0, 255), 1, exports.nrpg_interface:getGUIFont("money15"), "center", "bottom", false, false, false, false, false)
            dxDrawText(stringInfo2, 514*w, 44*h, 852*w, 78*h, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont("light14"), "center", "top", false, false, false, false, false)

 		end
	end
end
end

addEventHandler("onClientPlayerTarget",root, function(el)
    if isPedAiming(localPlayer) and el and getPedWeapon(localPlayer) == 22 and getElementData(localPlayer, "player:admin") == true then
        if not option.actived  then
			if getElementData(el,"p:inv") then return end
            if getElementType(el) == "vehicle" then
                value="vehicle"
                element=el
                option.actived=true
            elseif getElementType(el) == "player" then
                value="player"
                element=el
                option.actived=true
            else return end
            bindKey("mouse1", "down", onElementClicked)
            bindKey("mouse_wheel_down", "down", onElementMoveDown)
            bindKey("mouse_wheel_up", "down", onElementMoveUp)
            bindKey("q", "down", onElementMoveDown)
            bindKey("e", "down", onElementMoveUp)
            addEventHandler("onClientHUDRender", root, isRendering)
        end
    else
        if option.actived then
            vehicle.el=nil
            option.actived=false
            unbindKey("mouse1", "down", onElementClicked)
            unbindKey("mouse_wheel_down", "down", onElementMoveDown)
            unbindKey("mouse_wheel_up", "down", onElementMoveUp)
            unbindKey("q", "down", onElementMoveDown)
            unbindKey("e", "down", onElementMoveUp)
            removeEventHandler("onClientHUDRender", root, isRendering)
        end
    end
end)

function onElementMoveUp() if option.selected > 9 then option.selected=1 else option.selected=option.selected+1 end end
function onElementMoveDown() if option.selected < 1 then option.selected=9 else option.selected=option.selected-1 end end
function onElementClicked() if option.selected > 0 then triggerServerEvent("onDryerAction", localPlayer, value, option.selected, element) element=nil end element=nil end

function blokada ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(), newSlot) == 22 then 
		toggleControl( "fire", false )
        toggleControl( "action", false )
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), blokada)