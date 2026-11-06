local screenW, screenH = guiGetScreenSize()
local w, h = screenW/1280, screenH/720

local option={}
local vehicle={}
local player={}
value = nil
element = nil
option.selected = 0
option.actived = false


option["vehicle"] = {

    "OBRÓĆ",
    "SPUŚĆ RĘCZNY",
    "OTWORZ AUTO",
    "ZATANKUJ",

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
	if isPedAiming(localPlayer) and getPedWeapon(localPlayer) == 26 then
	if not (getElementData(localPlayer, "player:faction") == "SARA") then
		return
	end
	if option.actived == true then
    	if not element then return end
	if not isElement(element) then return end
        if value == "vehicle" then      
            local v_last_driver = getElementData(element, "vehicle:driver") or "Brak"
            local v_owner = getElementData(element, "vehicle:ownedPlayer") or "Brak"
            local v_fuel = getElementData(element, "vehicle:fuel") or 0
  	    local v_rejka = getVehiclePlateText(element)
 	    local v_nazwa = getVehicleName(element)
	    local hp = getElementHealth(element)            
            local v_id = getElementData(element, "vehicle:id") or "0"
	    local v_idm = getVehicleID(element)
            local v_drive_resp = getElementData(element, "ostatnikierowca") or "Brak"
	local stan = "Ładowanie"
	
        if hp > 900 then
    	stan = "idealny"
  	elseif hp < 901 and hp > 700 then
   	stan = "Bardzo dobry"
  	elseif hp < 701 and hp > 400 then
   	stan = "Zły"
 	elseif hp < 401 then
   	stan = "bardzo zły"
  	end

        dxDrawImage(434*w, 423*h, 391*w, 261*h, ":nrpg_interface/img/background_circle.png", 0, 0, 0, tocolor(28, 28, 226, 224), false)
        dxDrawImage(434*w, 426*h, 391*w, 33*h, ":nrpg_interface/img/background_circle.png", 0, 0, 0, tocolor(60, 48, 221, 255), false)
        dxDrawText("SUSZARKA FRAKCJI SARA", 437*w, 431*h, 825*w, 461*h, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText(option[value][option.selected] or "WYBIERZ OPCJE", 436*w, 449*h, 825*w, 489*h, tocolor(255, 150, 15, 255), 1.10, "default-bold", "center", "center", false, false, false, false, false)
       dxDrawText("ID: "..v_id.."\nPaliwo: "..v_fuel.."\nStan: "..stan.."\nRejestracja: "..v_rejka.."\nUID Właściciela: "..v_owner.."\nOstatni kierowca: "..v_last_driver.."\nKierowca respionego auta: "..v_drive_resp.."\nNazwa pojazdu: "..v_nazwa.."("..v_idm..")", 437*w, 514*h, 821*w, 720*h, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)  
      
       end
 end
end
end

addEventHandler("onClientPlayerTarget",root, function(el)
	--print(getElementData(localPlayer, "player:faction"))
	if isPedAiming(localPlayer) and getPedWeapon(localPlayer) == 26 and getElementData(localPlayer, "player:faction") == "SARA" then  
        if not option.actived  then
	if getElementData(localPlayer,"p:inv") then return end
            if getElementType(el) == "vehicle" then
                value="vehicle"
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

function onElementMoveUp() if option.selected > 4 then option.selected=1 else option.selected=option.selected+1 end end
function onElementMoveDown() if option.selected < 1 then option.selected=4 else option.selected=option.selected-1 end end
function onElementClicked() if option.selected > 0 then triggerServerEvent("onDryerActionSARA", localPlayer, value, option.selected, element) element=nil end element=nil end

function blokada ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(), newSlot) == 26 then 
		toggleControl( "fire", false )
        toggleControl( "action", false )
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), blokada)