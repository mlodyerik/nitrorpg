local miejsca = {
	{1118.81, -1360.58, 7.73}, --SAPD
	{1703.14, -1745.84, 13.61}, --SAFD
	{-0.08, -295.00, 5.43}, -- SARA
	{-1935.95, 245.04, 34.46}, -- San Fierro, Doherty
	{1041.45, -1022.20, 32.11}, -- Los Santos, Temple
	{1028.63, 1741.55, 10.83}, -- Las Venturas, Whiteewood
	{86.88, -163.09, 2.59}, -- Blueberry
}

for i,v in ipairs(miejsca) do
	local mech = createMarker(v[1],v[2],v[3]-0.9, "cylinder", 4, 0, 255, 0, 25)

	setElementData(mech,"marker:text","Mechanik Frakcyjny")
	setElementData(mech,"marker:downtext","DARMOWA NAPRAWA")


	addEventHandler("onClientMarkerHit", mech, function(el, md)
		local vehicle = getPedOccupiedVehicle(el)
		if not md or getElementType(el) ~= "player" then return end
		if el ~= localPlayer then return end
		if not getPedOccupiedVehicle(el) then return end
		if not getElementData(el,"player:faction") or not getElementData(vehicle, "vehicle:duty") then return end
		fixVehicle(vehicle, true)
	end)
end