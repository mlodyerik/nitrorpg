main = {}


main.loadKary = function(plr, cmd)
    if getElementData(plr, "player:sid") then
        local result_all = exports["nrpg_db"]:dbGet("SELECT * from pystories_punish WHERE serial=?", getPlayerSerial(plr))

        outputChatBox(" ", plr)
        outputChatBox("Lista kar:", plr, 255, 255, 255, true)
        outputChatBox(" ", plr)
        if #result_all > 0 then
            for i,v in ipairs(result_all) do
                if v.type == "A" or v.type == "B" or v.type == "C" then
                    if i == 3 then
                        outputChatBox("#FF0000PRAWO JAZDY#ffffff - Kategoria: A, B, C, Powód: "..v.reason..", aktywne do: "..v.time.."", plr, 255, 255, 255, true)
                    end
                elseif v.type == "mute" then
                    outputChatBox("#DF6800WYCISZENIE#ffffff - Powód: "..v.reason..", aktywne do: "..v.time.."", plr, 255, 255, 255, true)
                else
                    outputChatBox("#C4C4C4INNE#ffffff - Powód: "..v.reason..", aktywne do: "..v.time.."", plr, 255, 255, 255, true)
                end
            end
        else
            outputChatBox("#FF0000BRAK KAR#ffffff - Nie znaleziono kar", plr, 255, 255, 255, true)
        end
        outputChatBox(" ", plr)
        outputChatBox(" ", plr)
    end
end
addCommandHandler("kary", main.loadKary)