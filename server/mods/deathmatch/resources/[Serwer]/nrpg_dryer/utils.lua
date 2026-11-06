--[[
    @author - TheNoobisty
    @for - SantoriRPG
]]

function isPedAiming(plr)
    if isElement(plr) then
        if getElementType(plr) == "player" or getElementType(plr) == "vehicle" then
            if getPedTask(plr, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
                return true
            end
        end
    end
    return false
end