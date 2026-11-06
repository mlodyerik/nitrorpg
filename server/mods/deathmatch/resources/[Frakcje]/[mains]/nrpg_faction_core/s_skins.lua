
local skins={
	["SAPD"]={
		code="SAPD",
		positions={


            --{258.52331542969, 76.513771057129, 1003.640625, 284, "POLICE OFFICER\nIII", 0, 6, 1}, 
			--{238.0316619873, 71.363037109375, 1005.0390625, 285, "S.W.A.T", 0, 6, 1}, 
			--{256.20611572266, 79.187858581543, 1003.640625, 286, "SERGANTt\nI", 0, 6, 1}, 
			--{257.2341003418, 73.250732421875, 1003.640625, 287, "POLICE OFFICER\nI", 0, 6, 1}, 
			--{229.69116210938, 71.356781005859, 1005.0390625, 283, "ZARZĄD", 0, 6, 1}, 
			--{231.20909118652, 76.413284301758, 1005.0390625, 282, "POLICE GIRL", 0, 6, 1}, 
			--{226.76542663574, 82.23267364502, 1005.0390625, 288, "DETECTIVE\nI", 0, 6, 1}, 
			--{264.06, 86.40, 1001.04, 71, "CADET", 0, 6, 1},
			--{253.07, 80.16, 1003.64, 280, "DETECTIVE\nII", 0, 6, 1},
			--{240.41, 81.90, 1005.04, 281, "DEPUTY CHIEF", 0, 6, 1}
		},
		text="Nie jesteś zatrudniony do SAPD lub nie jesteś na służbie!",
	},

	["SARA"]={
		code="SARA",
		positions={

            {3884.67, -723.16, 76.40, 27, "WORKER", 0, 0, 1}, 
            {3884.72, -719.41, 76.40, 153, "SPECIALIST", 0, 0, 5},
            {3888.54, -719.44, 76.40, "INSPECTOR", 0, 0, 7},
            {3888.52, -723.22, 76.40, 295, "GENERAL\nBRYGADIER", 0, 0, 10}

		},
		text="Nie jesteś zatrudniony do SARA lub nie jesteś na służbie!",
	},

	["SAFD"]={
		code="SAFD",
		positions={
			{1725.28, -1799.16, 13.59, 305,"KOSZARY 1", 0, 0, 1},
			{1723.21, -1799.16, 13.59, 206,"KOSZARY 2", 0, 0, 1},
			{1720.46, -1799.16, 13.59, 278,"A-SAFD", 0, 0, 1},
			{1731.28, -1747.54, 13.59, 277,"B-SAFD", 0, 0, 1},
			{1729.69, -1747.54, 13.59, 279,"DOWÓDCA", 0, 0, 1},
			{1732.94, -1747.54, 13.59, 275,"MEDYK 1", 0, 0, 1},
			{1734.62, -1747.54, 13.59, 274,"MEDYK 2", 0, 0, 1},
		},
		text="Nie jesteś zatrudniony do SAFD lub nie jesteś na służbie!",
      },

	

}

for _,skin in pairs(skins) do
	for _,pos in ipairs(skin.positions) do
		local pickup=createPickup(pos[1], pos[2], pos[3], 3, 1275, 2000)
		setElementDimension(pickup,pos[6])
		setElementInterior(pickup,pos[7])
    	setElementData(pickup,"p:faction",tostring(skin.code))
    	setElementData(pickup,"p:skin", tonumber(pos[4]))
		setElementData(pickup,"p:rank", pos[8] or 1)
		local t=createElement("text")
    	setElementData(t,"name",pos[5] or "Skin")
		setElementDimension(t,pos[6])
		setElementInterior(t,pos[7])
    	setElementPosition(t,pos[1],pos[2],pos[3])
    end
end

addEventHandler("onPickupHit", resourceRoot, function(el,md)
	if getElementType(el)~="player" then return end
    local faction=getElementData(source,"p:faction")
    if not faction then return end
    local skin=getElementData(source,"p:skin")
	local rank=getElementData(source,"p:rank")
    if not skin then return end
    if not getPlayerFaction(el,faction) or getElementData(el,"player:faction") ~= faction then
		exports.nrpg_interface:showPlayerNotification(el,skins[faction].text, 'info')
    	cancelEvent()
		return end
	if rank then
	if rank > getElementData(el,"player:rank")  then
		exports.nrpg_interface:showPlayerNotification(el,skins[faction].text, 'info')
    	cancelEvent()
    return end
	end
    setElementModel(el,skin)
end)