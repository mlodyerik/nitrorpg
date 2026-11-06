addEventHandler( "onVehicleStartEnter", root, function(plr, seat, jacked)
local vehiclePlayers = getVehicleOccupants(source)
local vehicleModel = 551
local vehicleSeats = 2

if getElementModel(source) == vehicleModel then
	if #vehiclePlayers >= vehicleSeats then
		cancelEvent()
	end
end
end)