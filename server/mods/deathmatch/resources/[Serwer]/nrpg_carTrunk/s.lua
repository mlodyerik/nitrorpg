trunks = {}

addEvent("tpTrunk", true)
addEventHandler("tpTrunk", root, function(plr, veh)
    local x, y, z = getElementPosition(veh)
	local rx, ry, rz = getElementRotation(veh)
	if not getElementData(plr, "player:bagaznik") or getElementData(plr, "player:bagaznik") == false then
        if trunks[veh] == true then return end
		setElementPosition(plr, x, y, z)
		setElementRotation(plr, 0, 0, 0)
		setPedAnimation(plr, "CRACK", "crckidle2", -1, true, false)
		setElementCollisionsEnabled(plr, false)
		setElementData(plr, "player:bagaznik", veh)
		attachElements(plr, veh, 0, -2, 1, 90, 0, 0)
        trunks[veh] = true
	else
		detachElements(plr)
		setPedAnimation(plr, false)
		setElementCollisionsEnabled(plr, true)
		setElementData(plr, "player:bagaznik", false)
        trunks[veh] = false
	end
end)

addEventHandler( "onPlayerWasted", root, function()
    local bagol = getElementData(source, "player:bagaznik")
	if bagol then
        trunks[bagol] = false
        setElementData(source, "player:bagaznik", false)
    end
end)

addEventHandler( "onPlayerQuit", root, function()
    local bagol = getElementData(source, "player:bagaznik")
	if bagol then
        trunks[bagol] = false
        setElementData(source, "player:bagaznik", false)
    end
end)