main.codes = {

    {"10-50", "Wypierdolenie sie z rowerka", "SAPD"},

}

main.tableCodes = {}

main.getTable = function()
    if main.tableCodes then
        return main.tableCodes
    end
end

for i, v in ipairs(main.codes) do
    addCommandHandler(v[1], function(plr, cmd)
        if getElementData(plr, "player:faction") == v[3] then
            for _, factionPlayer in ipairs(getElementsByType('player')) do
                if getElementData(factionPlayer, "player:faction") == "SAPD" then
                    outputChatBox(" ", factionPlayer, 255, 255, 255, true)
                    outputChatBox("["..v[1].." - "..getPlayerName(plr).."] - "..v[2], factionPlayer, 255, 255, 255, true)
                    outputChatBox(" ", factionPlayer, 255, 255, 255, true)
                    
                    for index = 4, 2, -1 do
                        main.tableCodes[index] = main.tableCodes[index - 1]
                    end
                    main.tableCodes[1] = {getPlayerName(plr), "["..v[1].." - "..getPlayerName(plr).."] - "..v[2]..""}
                end
            end
        end
    end)
end
