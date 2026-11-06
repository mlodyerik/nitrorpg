avatarFilter = {

    ['https://cdn.discordapp.com/avatars/'] = true,


}

function foundString(string)
    for i, v in pairs(avatarFilter) do
        while string:lower():find(i:lower(), 1, true) do
            local start, end_ = string:lower():find(i:lower(), 1, true)
            local found = string:sub(start, end_)
            if found then
                return true
            else
                return false
            end
        end
    end
end

function startImageDownload(plr, link)
    fetchRemote ( ""..link.."", myCallback, "", false, plr)
    setElementData(plr, "player:avatar", link)
end

function myCallback( responseData, errno, plr)
    if errno == 0 then
        triggerClientEvent( plr, "onClientGotImage", resourceRoot, responseData )
    end
end

addEvent("selectAvatar", true)
addEventHandler("selectAvatar", root, function(plr, link)
	if not link then return end
	startImageDownload(plr, link)
    
	exports.nrpg_interface:showPlayerNotification(plr, 'Zmieniono avatar', 'success', 15000)
end)