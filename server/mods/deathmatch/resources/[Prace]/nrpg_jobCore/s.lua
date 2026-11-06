function givePlayerJobMoney(plr, value)
    local actualMoney = getPlayerMoney(plr)
    if (actualMoney+value) >= 99999999 then
        
    else
        givePlayerMoney(plr, value)
    end
end