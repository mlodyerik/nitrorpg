addEventHandler( "onClientElementStreamIn", root,
    function ( )
        if getElementType( source ) == "object" then
			setObjectBreakable(source, false)
		end
end)
addEvent("setBreakable",true)
addEventHandler("setBreakable",root,function(obj)
setObjectBreakable(obj, false)
end)

function stopMinigunDamage ( attacker, weapon, bodypart )
	if ( weapon == 0 ) then 
		cancelEvent()
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )

function nodamage(attacker, bodypart)
	if not attacker then return end
	if getElementType(attacker) == 'vehicle' then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(),nodamage)

function blokada ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(),newSlot) == 0 and getElementData(getLocalPlayer(),"player:admin") == true then 
		toggleControl ( "fire", true )
		toggleControl("aim_weapon", true)
	elseif getPedWeapon(getLocalPlayer(),newSlot) == 7 then
		toggleControl ("fire", false ) 
		toggleControl("aim_weapon", false)
		return false
	elseif getPedWeapon(getLocalPlayer(),newSlot) ~= 0 and  getPedWeapon(getLocalPlayer(),newSlot) ~= 22 then
		toggleControl ("fire", true ) 
		toggleControl("aim_weapon", true)
	elseif getPedWeapon(getLocalPlayer(),newSlot) == 22 and getElementData(getLocalPlayer(),"player:admin") == true then
		toggleControl ("fire", false ) 
		toggleControl("aim_weapon", true)
	elseif getPedWeapon(getLocalPlayer(),newSlot) == 22 and getElementData(getLocalPlayer(),"player:admin") == false then
		toggleControl ("fire", true ) 
		toggleControl("aim_weapon", true)
	else
		toggleControl ( "fire", false ) 
		toggleControl("aim_weapon", false)
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), blokada )

function disableFireForHydra(theVehicle, seat)
    if getElementModel(theVehicle) == 520 or getElementModel(theVehicle) == 425 then
        toggleControl( "vehicle_secondary_fire", false)
        toggleControl( "vehicle_fire", false)
    else
        toggleControl("vehicle_secondary_fire", true)
        toggleControl("vehicle_fire", true)
    end
end
addEventHandler("onClientPlayerVehicleEnter", getLocalPlayer(), disableFireForHydra)

setTimer(function()
	for i, v in ipairs( getElementsByType ( "vehicle" ) ) do
		if getElementHealth(v) < 400 then
			setElementHealth(v, 500)
		end
	end
end, 1000, 0)