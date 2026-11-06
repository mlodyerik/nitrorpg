local bikesPoints={

-- Salon Doherty

	{481, -1968.41,303.94,34.8, 359.5, 360.0, 90},
	{481, -1968.41,301.50,34.8, 359.5, 360.0, 90},
	{481, -1968.41,298.94,34.8, 359.5, 360.0, 90},

-- Spawn

    {481, -2660.81, -39.98, 3.93, 359.5, 360.0, 180.0},
    {481, -2657.95, -39.98, 3.94, 359.5, 0.0, 180.0},
	{481, -2638.42, -39.98, 3.94, 359.5, 0.0, 180.0},
    {481, -2636.13, -39.98, 3.94, 359.5, 360.0, 180.0},


-- Los santos, spawn

    {481, 1703.41, -1870.42, 13.18, 360, 0.0, 0},
    {481, 1700.60, -1870.65, 13.17, 360, 0.0, 0},
    {481, 970.26, -1306.82, 13.15, 359.5, 0.0, 221.5},

-- Los santos, przechowalnia

    {481, 970.18, -1300.35, 13.16, 359.6, 359.9, 214.9},
    {481, 970.25, -1303.64, 13.15, 359.5, 0.0, 220.3},

-- Las venturas, spawn

    {481, 950.70, 1728.90, 8.25, 359.5, 360.0, 270.0},
    {481, 950.70, 1730.90, 8.25, 359.5, 360.0, 270.0},
    {481, 950.70, 1732.90, 8.25, 359.5, 360.0, 270.0},
    {481, 950.70, 1734.90, 8.25, 359.5, 360.0, 270.0},
    {481, 950.70, 1736.90, 8.25, 359.5, 360.0, 270.0},
    {481, 950.70, 1738.90, 8.25, 359.5, 360.0, 270.0},


-- Las venturas, gielda

    {481, 1659.59, 1785.02, 10.43, 359.5, 0.0, 268.4},
    {481, 1659.59, 1787.02, 10.43, 359.5, 0.0, 268.4},  
    {481, 1659.59, 1789.02, 10.43, 359.5, 0.0, 268.4},


-- Las venturas, przechowalnia

    {481, 1966.41, 2147.52, 10.45, 360.0, 360.0, 90},
    {481, 1966.41, 2149.52, 10.45, 360.0, 360.0, 90},
    {481, 1966.41, 2151.52, 10.45, 360.0, 360.0, 90},
    {481, 1966.41, 2153.52, 10.45, 360.0, 360.0, 90},
    {481, 1966.41, 2155.52, 10.45, 360.0, 360.0, 90},
	

}

for _,v in pairs(bikesPoints) do
    local vehicle = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setElementFrozen(vehicle, true)
	setVehicleColor(vehicle, 255, 255, 255, 0, 0, 0)
    setVehicleHandling(vehicle,"maxVelocity", 41)
	setElementData(vehicle,"vehicle:fuel",100)
    setElementData(vehicle,"vehicle:bak",100)
end

function respawn(plr)
    setElementFrozen(source, true)
	setElementDimension(source,0)
	setElementInterior(source,0)
	setElementData(source,"vehicle:fuel",100)
    setElementData(source,"vehicle:bak",100)
	setVehicleOverrideLights(source,1)
end
    
function enter(plr, seat)
    setElementFrozen(source,false)
    toggleVehicleRespawn(source, true)
    setVehicleIdleRespawnDelay(source, 15000)
end

addEventHandler("onVehicleEnter", resourceRoot, function(plr,seat) 
    enter(plr, seat) 
end)

addEventHandler("onVehicleRespawn", resourceRoot, function() 
    respawn() 
end)