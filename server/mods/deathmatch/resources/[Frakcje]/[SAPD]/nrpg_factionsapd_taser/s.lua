function taser(atakujacy, bron, cialo, starciles)
    if atakujacy and (bron == 23) then
        local target = source
        cancelEvent(  )
        

        if isPedInVehicle( target ) then
            local veh = getPedOccupiedVehicle(target)
            setVehicleEngineState(veh, false)
            toggleControl(target, "accelerate", false)
            toggleControl(target, "brake_reverse", false)

            setTimer( function()
                setControlState(target, "enter_exit", true)
                setTimer(function()
                    setControlState(target, "enter_exit", false)
                end, 150, 1)
            end, 250, 1)
        end
    
        setTimer( function()
        setElementFrozen(target, true)
        setPedAnimation(target, "CRACK", "crckdeth1", 10000, false, false)
        setTimer(setElementFrozen, 10000, 1, target, false)		
        setTimer(setPedAnimation, 10000, 1, target, false)
        setElementHealth(target, 100)
        end, 500, 1)

    

    setTimer( function()
        toggleControl(target, "accelerate", true)
        toggleControl(target, "brake_reverse", true) 
    end, 10000, 1)
    end
end
addEventHandler ( "onPlayerDamage", getRootElement(), taser)