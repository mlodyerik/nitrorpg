main = {}

eldats = {
    
	{"shader:shadow"},
	{"shader:blur"},
	{"shader:colors"},
	{"shader:detail"},
	{"shader:car"},
	{"shader:sky"},
	{"shader:water"},
	{"shader:snow"},
    {"shader:render"},
	{"player:showfps"},
	{"player:premiumchat"},
    {"player:chatbubbles"},
    {"player:customradar"},
	{"pmoff"},

}

main.saveSettings = function(plr)
    local theTable = {}

    for i,v in pairs(eldats) do
        if getElementData(plr, v[1]) == true then
            table.insert(theTable, {v[1], true})
        else
            table.insert(theTable, {v[1], false})
        end
    end

    local check = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_settings WHERE serial=?", getPlayerSerial(plr))
    if #check > 0 then
        exports['nrpg_db']:dbSet("UPDATE pystories_settings SET data=? WHERE serial=?", toJSON(theTable), getPlayerSerial(plr))
    else
        exports["nrpg_db"]:dbSet("INSERT INTO pystories_settings (serial,data) VALUES (?,?)", getPlayerSerial(plr), toJSON(theTable))
    end
end
addEventHandler("onPlayerQuit", root, function() main.saveSettings(source) end)

main.loadSettings = function(plr)
    local loadData = exports["nrpg_db"]:dbGet("SELECT * FROM pystories_settings WHERE serial=?", getPlayerSerial(plr))
    if #loadData > 0 then
        local theTable = fromJSON(loadData[1].data)

        for i,v in ipairs(theTable) do
            setElementData(plr, v[1], v[2])
            if v[1] == "shader:render" then
                triggerClientEvent(plr, "changeRender", resourceRoot, v[2])
            end
        end
    else
        for i,v in ipairs(eldats) do
            setElementData(plr, v[1], false)
            if v[1] == "shader:render" then
                triggerClientEvent(plr, "changeRender", resourceRoot, false)
            end
        end
    end
end
addEvent("loadPlayerSettings", true)
addEventHandler("loadPlayerSettings", root, main.loadSettings)