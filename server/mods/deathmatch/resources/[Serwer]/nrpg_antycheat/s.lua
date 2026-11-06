function checkAccount(plr)
    local result = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(plr, "player:sid"))
    local serialTable = fromJSON(result[1].seriale) or {}

    if result[1].register_serial ~= getPlayerSerial(plr) then
        outputChatBox("✘ #ffffffW związku z zmianą numeru seryjnego MTA ta opcja jest zablokowana, jeśli chcesz ją odblokować wejdź na nasz teamspeak3: nitro-rpg - Strefa pomocy.", plr, 255, 0, 0, true)
        return true
    elseif result[1].register_serial == getPlayerSerial(plr) then
        return false
    else
        if #serialTable > 0 then
            serialTotal = 0
            for i,v in ipairs(serialTable) do
                if v == getPlayerSerial(plr) then
                    serialTotal = serialTotal + 1
                end
            end
            if serialTotal > 0 then
                return false
            else
                outputChatBox("✘ #ffffffW związku z zmianą numeru seryjnego MTA ta opcja jest zablokowana, jeśli chcesz ją odblokować wejdź na nasz teamspeak3: nitro-rpg - Strefa pomocy.", plr, 255, 0, 0, true)
                return true
            end
        end
    end
end