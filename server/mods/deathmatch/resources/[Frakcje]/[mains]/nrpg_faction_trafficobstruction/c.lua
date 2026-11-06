c_main = {}

c_main.renderOgraniczenie = function()
    local v = getPedOccupiedVehicle(localPlayer)
    if v then
        if getElementData(v, "vehicle:wypadekStrefa") == true then
            local vm = getElementModel(v)
            local vx, vy, vz=getElementVelocity(v)
    
            if not getVehicleEngineState(v) then
                if getDistanceBetweenPoints2D(0, 0, vx, vy) < 0.1 then
                        vx, vy = 0, 0
                        setElementVelocity(v,vx,vy,vz)
                    return
                end
            end
    
            local actualspeed = ((vx^2 + vy^2 + vz^2)^(0.5))*170
            if actualspeed > 40 then
                if isVehicleOnGround(v) then
                    setElementVelocity(v,vx*0.9,vy*0.9,vz*0.9)
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, c_main.renderOgraniczenie)