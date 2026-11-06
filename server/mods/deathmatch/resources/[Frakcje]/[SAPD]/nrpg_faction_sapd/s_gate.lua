function isPlayerInSAPDFaction(plr)
    local sid=getElementData(plr, 'player:sid')
    if not sid then return end

    local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SAPD", sid)
    if result [1] then
        return true
    else
        return false
    end
end

-------------------------------------------------------------------------------------

local brama = createObject(3055, 1172.7976074219, -1307.9871826172, 15.171799659729, 0, 0, 89.840026855469)
local marker1 = createMarker(1172.80, -1308.43, 12.98, "cylinder", 6, 0, 0, 0, 0)

function onMarkerHit1(hitPlayer)
	if isPlayerInSAPDFaction(hitPlayer) then
		moveObject(brama, 1300, 1172.7976074219, -1307.9871826172, 19.358200073242)
	end
end

function onMarkerLeave1(leavePlayer)
	if isPlayerInSAPDFaction(leavePlayer) then
	moveObject(brama, 1300, 1172.7976074219, -1307.9871826172, 15.171799659729)
end
end

addEventHandler ( "onMarkerLeave", marker1, onMarkerLeave1 )
addEventHandler ( "onMarkerHit", marker1, onMarkerHit1 )


