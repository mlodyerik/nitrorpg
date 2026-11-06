addCommandHandler("spawn.ls", function(el,md)
if not getAdmin(el) then return end	 local gracz = el
    if isPedInVehicle(el) then gracz = getPedOccupiedVehicle(el) end
    setElementPosition(gracz, 1721.75, -1708.66, 13.50)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
    outputChatBox("Spawn Los Santos", el, 255, 255, 255)
end)

addCommandHandler("przecho.ls", function(el,md)
if not getAdmin(el) then return end	 local gracz = el
    if isPedInVehicle(el) then gracz = getPedOccupiedVehicle(el) end
    setElementPosition(gracz, 1612.83, -1556.17, 13.78)
    setElementDimension(gracz,0)
    setElementInterior(gracz,0)
    outputChatBox("Przechowalnia Los Santos", el, 255, 255, 255)
end)

addCommandHandler("przecho.ls2", function(el,md)
if not getAdmin(el) then return end	 local gracz = el
    if isPedInVehicle(el) then gracz = getPedOccupiedVehicle(el) end
    setElementPosition(gracz,  1004.04, -1435.45, 13.55)
    setElementDimension(gracz,0)
    setElementInterior(gracz,0)
    outputChatBox("Przechowalnia Los Santos", el, 255, 255, 255)
end)

addCommandHandler("pp.ls", function(el,md)
if not getAdmin(el) then return end	 local gracz = el
    if isPedInVehicle(el) then gracz = getPedOccupiedVehicle(el) end
    setElementPosition(gracz, 1026.62, -1444.11, 13.55)
    setElementInterior(gracz,0)
    setElementDimension(gracz,0)
    outputChatBox("Parking policyjny Los Santos", el, 255, 255, 255)
end)

addCommandHandler("osk.ls", function(el,md)
if not getAdmin(el) then return end	 local gracz = el
    if isPedInVehicle(el) then gracz = getPedOccupiedVehicle(el) end
    setElementPosition(gracz, 1081.04, -1702.07, 13.55)
    setElementDimension(gracz,666)
    outputChatBox("Szkoła jazdy", el, 255, 255, 255)
end)