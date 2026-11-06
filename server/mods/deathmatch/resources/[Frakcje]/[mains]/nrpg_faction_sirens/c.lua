addEvent("broadcastSound3D", true)
addEventHandler("broadcastSound3D", root, function(sound,range,minrange)
	local el=source
	if getElementDimension(localPlayer)~=getElementDimension(el) then return end
	if getElementInterior(localPlayer)~=getElementInterior(el) then return end
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(el)
	local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
	if dist<range*2 then
		local s=playSound3D(sound, x2,y2,z2)
		setSoundMinDistance(s, minrange or 5)
		setSoundMaxDistance(s, range)
	end
end)

addEvent("createVehicleSound", true)
addEventHandler("createVehicleSound", root, function(dzwiek,range, sila)
	local snd=playSound3D(dzwiek, 0,0,0,true)
        setSoundVolume(snd, sila)
	setSoundMaxDistance(snd, range or 150)
	attachElements(snd, source)
end)


addEvent("destroyVehicleSound", true)
addEventHandler("destroyVehicleSound", root, function()
	local el=getAttachedElements(source)
	for i,v in ipairs(el) do
		if getElementType(v)=="sound" then
			destroyElement(v)
		end
	end
end)

local sirenplaying = false

function mta_siren()
	sound=getTickCount()
	local vehicle=getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
         end
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
		sirenplaying = false
		if vehicle_model == 597 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 426 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 503 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 494 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 541 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 579 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 599 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 490 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 411 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 405 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 415 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 402 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 427 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_horn_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 560 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "3_cadrona.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 445 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "3_cadrona.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 426 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "3_cadrona.wav", 350, 0.6)
			sirenplaying = true
			return
		end
	end
end
bindKey("1", "down", mta_siren)

function mta_siren2()
	sound=getTickCount()
	local vehicle=getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
         end
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
		sirenplaying = false
		if vehicle_model == 503 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "1_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 405 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "1_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 494 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "1_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 490 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 597 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 426 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 541 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 579 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 599 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 411 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 415 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 402 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 427 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "5_police_premier.wav", 350, 0.6)
			sirenplaying = true
			return
        end
	end
end
bindKey("2", "down", mta_siren2)

function mta_siren3()
	sound=getTickCount()
	local vehicle=getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
         end
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
		sirenplaying = false
		 if vehicle_model == 411 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 415 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 541 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 597 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 490 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 426 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 427 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 599 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD1.mp3", 350, 0.6)
			sirenplaying = true
			return
		end
	end
end
bindKey("3", "down", mta_siren3)

function mta_siren4()
	sound=getTickCount()
	local vehicle=getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
         end
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
		sirenplaying = false
		if vehicle_model == 411 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 415 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 541 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 597 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 490 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 426 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 427 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 599 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD2.mp3", 350, 0.6)
			sirenplaying = true
			return
        end
	end
end
bindKey("4", "down", mta_siren4)

function mta_siren5()
	sound=getTickCount()
	local vehicle=getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
         end
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
		sirenplaying = false
		if vehicle_model == 411 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 415 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 541 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 597 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 490 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 426 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
        elseif vehicle_model == 560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 427 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
		elseif vehicle_model == 599 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			triggerServerEvent("toggleVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
			sirenplaying = true
			return
        end
	end
end
bindKey("5", "down", mta_siren5)

function mta_siren6()
	sound=getTickCount()
	local vehicle=getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
         end
	if vehicle and getVehicleController(vehicle)==localPlayer then
		local vehicle_model=getElementModel(vehicle)
		sirenplaying = false
            if vehicle_model==426 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "1_premier.wav")
				sirenplaying = false
			return
		    elseif vehicle_model==560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			    triggerServerEvent("dstVehicleSound", vehicle, "4_rancher.wav")
			    sirenplaying = false
			return
            elseif vehicle_model==407 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "2_fire.wav")
				sirenplaying = false
			return
			elseif vehicle_model==426 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
			return
            elseif vehicle_model==527 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "3_cadrona.wav")
				sirenplaying = false
			return
	     	elseif vehicle_model==490 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
			    triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
			    sirenplaying = false
			return
            elseif vehicle_model==560 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "4_rancher.wav")
				sirenplaying = false
			return
            elseif vehicle_model==597 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
			elseif vehicle_model==503 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
			elseif vehicle_model==503 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_horn_premier.wav")
				sirenplaying = false
			elseif vehicle_model==494 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
			elseif vehicle_model==411 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
			elseif vehicle_model==494 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_horn_premier.wav")
				sirenplaying = false
            elseif vehicle_model==541 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
            elseif vehicle_model==579 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
            elseif vehicle_model==599 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
            elseif vehicle_model==445 and getElementData(vehicle, "vehicle:duty") == "SAFD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "3_cadrona.wav")
				sirenplaying = false
            elseif vehicle_model==415 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
            elseif vehicle_model==405 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
            elseif vehicle_model==560 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
			elseif vehicle_model==402 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "5_police_premier.wav")
				sirenplaying = false
				return
			elseif vehicle_model == 427 and getElementData(vehicle, "vehicle:duty") == "SAPD"  then
				triggerServerEvent("dstVehicleSound", vehicle, "SAPD3.mp3", 350, 0.6)
				sirenplaying = false
				return
		end
	end
end
bindKey("6", "down", mta_siren6)