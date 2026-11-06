addEvent("onDryerActionSARA", true)
addEventHandler("onDryerActionSARA", root, function(typ, selected, el)
    if not el or not selected then return end
    if typ == "vehicle" then
	
        if selected == 1 then
            local x, y, z = getElementRotation(el)
            setElementRotation(el, 0, 0, z)
	    outputChatBox("#00ff00✔#ffffffPomyślnie obrócono pojazd.", source, 0, 255, 0, true)
        end

        if selected == 2 then 
            setElementFrozen(el, false)
	    outputChatBox("#00ff00✔#ffffffPomyślnie spuszcono ręczny.", source, 0, 255, 0, true)
        end

        if selected == 3 then 
            setVehicleLocked (el,false)
	    outputChatBox("#00ff00✔#ffffffPomyślnie otwarto pojazd.", source, 0, 255, 0, true)
        end

        if selected == 4 then 
		setElementData(el, "vehicle:fuel", 100)
		outputChatBox("#00ff00✔#ffffffPomyślnie zatankowałeś(aś) pojazd.", source, 0, 255, 0, true)
		end
	end
end)


addEventHandler("onVehicleEnter", getRootElement(), function(plr, seat, jacked)
  if seat == 0 then
  local name = getPlayerName(plr)
  setElementData(source, "ostatnikierowca", name)
end
end)