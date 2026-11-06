local lu={}
addEvent("broadcastSound3D", true)
addEventHandler("broadcastSound3D", root, function(dzwiek, range, minrange, delay)
	if delay then
	      if lu[dzwiek] and getTickCount()-lu[dzwiek]<delay then
			return
		end
		lu[dzwiek]=getTickCount()
	end
	triggerClientEvent("broadcastSound3D", source, dzwiek, range, minrange)
end)

addEvent("toggleVehicleSound", true)
addEventHandler("toggleVehicleSound", root, function(dzwiek, range, glos)
	local snd=getElementData(source,"snd:"..dzwiek) 
      triggerClientEvent("destroyVehicleSound", source, dzwiek)
	triggerClientEvent("createVehicleSound", source, dzwiek, range, glos)
	setElementData(source,"snd:"..dzwiek,true)
end)

addEvent("dstVehicleSound", true)
addEventHandler("dstVehicleSound", root, function(dzwiek, range, glos)
	local snd=getElementData(source,"snd:"..dzwiek)
     if snd then
                
	triggerClientEvent("destroyVehicleSound", source, dzwiek)
                removeElementData(source, "snd:"..dzwiek)
		return
	end
       triggerClientEvent("destroyVehicleSound", source, dzwiek)
end)