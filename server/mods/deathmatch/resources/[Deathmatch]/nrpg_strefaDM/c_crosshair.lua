function toggleCrosshair()
    local weaponSlot = getPedWeaponSlot (localPlayer)
	if (weaponSlot > 1 and weaponSlot < 7) and not isElementInWater(localPlayer) then
		local hX,hY,hZ = getPedTargetEnd (localPlayer)
		local screen1, screen2 = getScreenFromWorldPosition ( hX,hY,hZ )

		setPlayerHudComponentVisible("crosshair", false)
		
		if (screen1 and screen2) then
            if main.crosshairTarget ~= nil then
                if getElementData(main.crosshairTarget, "player:organization") == getElementData(localPlayer, "player:organization") then
			        dxDrawImage(screen1-25/2, screen2-25/2, 25, 25, "img/crosshair.png", 0, 0, 0, tocolor(55, 175, 255, 255))
                else
                    dxDrawImage(screen1-25/2, screen2-25/2, 25, 25, "img/crosshair.png", 0, 0, 0, tocolor(255, 155, 155, 255))
               	end

				dxDrawText('ZDROWIE', screen1+45/2, screen2-10/2, 700, 380, tocolor(225, 225, 255, 255), 1, exports.nrpg_interface:getGUIFont('money7'), 'center', 'center', false, false, false, false, false)
				dxDrawText(getElementHealth(main.crosshairTarget)..'/100', screen1+45/2, screen2+20/2, 700, 390, tocolor(225, 225, 255, 255), 1, exports.nrpg_interface:getGUIFont('light7'), 'center', 'center', false, false, false, false, false) 
           else
                dxDrawImage(screen1-25/2, screen2-25/2, 25, 25, "img/crosshair.png", 0, 0, 0, tocolor(255, 255, 255, 255))
            end
		end
	end
end

addEventHandler("onClientPlayerTarget", root, function(el)
    if isPedAiming(localPlayer) and el and getElementType(el) == "player" then
        main.crosshairTarget = el
    else
        main.crosshairTarget = nil
    end
end)

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

function aimPlayer (_, state)
	if (state == "down") then 
		local playerWeapon = getPedWeapon(localPlayer)
		addEventHandler ("onClientHUDRender", root, toggleCrosshair)
		setPlayerHudComponentVisible("crosshair", false)

		if getElementData(localPlayer, "player:safeDM") then
			triggerServerEvent("deleteSafeBW", localPlayer, localPlayer)
		end
	else 
		removeEventHandler ("onClientHUDRender", root, toggleCrosshair)
	end
end

addEventHandler ("onClientResourceStart", getResourceRootElement (getThisResource ()),
	function () 
		bindKey ("aim_weapon", "both", aimPlayer)
	end
)
	
addEventHandler ("onClientResourceStop", getResourceRootElement (getThisResource ()),
	function ()
		unbindKey ("aim_weapon", "both", aimPlayer)
	end
)