addEvent("reloadStereo", true)
addEventHandler("reloadStereo", root, function()
	local player_sid = getElementData(client, "player:sid")
	local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_stereo WHERE sid=?", player_sid)
	triggerClientEvent(client, "reloadStereo:c", client, spr)
end)

addEvent("stereo:addMusic", true)
addEventHandler("stereo:addMusic", root, function(link, name)
    if link and name then
        exports["nrpg_db"]:dbSet("INSERT INTO pystories_stereo SET sid=?, nazwa=?, link=?", getElementData(client, "player:sid"), name, link)
        exports.nrpg_interface:showPlayerNotification(client, "Dodano utwór '"..name.."' do listy utworów.", "success")

        local player_sid = getElementData(client, "player:sid")
	    local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_stereo WHERE sid=?", player_sid)
	    triggerClientEvent(client, "reloadStereo:c", client, spr)
    end
end)

addEvent("stereo:toggleFavourite", true)
addEventHandler("stereo:toggleFavourite", root, function(songID, state)
    if songID then
        if state == true then
            exports["nrpg_db"]:dbSet("UPDATE pystories_stereo SET ulubione=? WHERE id=?", 1, songID)
        else
            exports["nrpg_db"]:dbSet("UPDATE pystories_stereo SET ulubione=? WHERE id=?", 0, songID)
        end

        local player_sid = getElementData(client, "player:sid")
	    local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_stereo WHERE sid=?", player_sid)
	    triggerClientEvent(client, "reloadStereo:c", client, spr)
    end
end)

addEvent("stereo:deleteMusic", true)
addEventHandler("stereo:deleteMusic", root, function(id)
    if id then
        exports["nrpg_db"]:dbSet("DELETE FROM pystories_stereo WHERE id=?", id)
        exports.nrpg_interface:showPlayerNotification(client, "Utwór usunięty.", "success")

        local player_sid = getElementData(client, "player:sid")
	    local spr = exports["nrpg_db"]:dbGet("SELECT * from pystories_stereo WHERE sid=?", player_sid)
	    triggerClientEvent(client, "reloadStereo:c", client, spr)
    end
end)