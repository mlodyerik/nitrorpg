local pension = { --za 1 minute
    ["SAPD"] = {
        [1] = 450000,
        [2] = 500000,
        [3] = 600000,
        [4] = 600000,
        [5] = 600000,
        [6] = 700000,
        [7] = 850000,
        [8] = 1000000,
        [9] = 1200000,
        [10] = 1300000,
        [11] = 1600000,
    },
    ["SAFD"] = {
       [1] = 45000,
        [2] = 500000,
        [3] = 600000,
        [4] = 600000,
        [5] = 600000,
        [6] = 700000,
        [7] = 850000,
        [8] = 1000000,
        [9] = 1200000,
        [10] = 1300000,
        [11] = 1600000,
    },
    ["SARA"] = {       
       [1] = 450000,
        [2] = 500000,
        [3] = 500000,
        [4] = 500000,
        [5] = 500000,
        [6] = 500000,
        [7] = 650000,
        [8] = 800000,
        [9] = 900000,
        [10] = 1100000,
        [11] = 1300000,
    },

}

local mnoznik = 1

local markersFactionPayment={
	{4093.72, 427.82, 214.30, 20, 20},
}

for i,v in ipairs(markersFactionPayment) do
	local marker=createMarker(v[1], v[2], v[3]-1, "cylinder", 1.25, 255, 255, 0, 55)
    setElementData(marker,'marker:text','Wypłata z frakcji')
	setElementInterior(marker, v[4] or 0)
	setElementDimension(marker, v[5] or 0)
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
	if not md or getElementType(el) ~= "player" then return end
	local sid=getElementData(el,"player:sid")
	if not sid then return end
    local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE uid=? LIMIT 1;", sid)
	if result and #result > 0 then
	local resulted=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_factions WHERE faction=?", faction)
		local sid = getElementData(el,"player:sid")
		if #result > 0 then
			if pension[result[1].faction] then
				if getElementData(el,"player:workinjob") and getElementData(el,"player:workinjob") >= 1 then
					local money = pension[result[1].faction][result[1].rank]
                    local money = money * getElementData(el,"player:workinjob")
					local money = math.floor(money*mnoznik)
					exports.nrpg_interface:showPlayerNotification(el, "Otrzymujesz "..money.." PLN (przepracowane: "..getElementData(el,"player:workinjob").." minut), pieniądze trafiły do bankomatu.", "success")
					exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money+"..(tonumber(money) or 0).." WHERE id="..tonumber(sid).." LIMIT 1")
					setElementData(el,"player:workinjob",0)
				else
					exports.nrpg_interface:showPlayerNotification(el, "Nie masz nic do odebrania!", "error")
				end
			end
		end
	end
end)