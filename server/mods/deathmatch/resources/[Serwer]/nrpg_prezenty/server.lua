local Gifts = {
	position = {


{-2685.90, -5.51, 6.13},

	},
	special = {
		
		{495, "Sandking 1.6dm3"},
		{565, "Flash 1.6dm3"},
		{411, "Infernus 1.6dm3"},
		{475, "Sabre 1.6dm3"},

	},
}

Gifts.settings = {}
Gifts.settings.pickupID = 1241
Gifts.settings.giftMoney = 2000000

Gifts.create = function()
	for k, v in ipairs(Gifts.position) do
		v.pickup = createPickup(v[1], v[2], v[3], 3, Gifts.settings.pickupID, 0)
		if v[4] then setElementDimension(v.pickup, v[4]) end
		setElementData(v.pickup, "gift:id", k)
		addEventHandler("onPickupHit", v.pickup, Gifts.hitPickup)
	end
end

Gifts.hitPickup = function(player)
	if getElementType(player) == "player" then
		if getPedOccupiedVehicle(player) then return end
		local gifts = exports["nrpg_db"]:dbGet("select prezenty from pystories_prezenty where id = ?", getElementData(player, "player:sid"))
		if not gifts[1] or not gifts[1].prezenty then _gifts = {} else _gifts = fromJSON(gifts[1].prezenty) end
		

		if not table.find(_gifts, getElementData(source, "gift:id")) then
			table.insert(_gifts, getElementData(source, "gift:id"))
		else
			outputChatBox("#ff0000✗ #ffffffZebrałeś/aś już ten prezent!", player, 63, 173, 168, true)
			return
		end

		if not gifts[1] then
			exports["nrpg_db"]:dbSet("insert into pystories_prezenty values(?,?)", toJSON(_gifts), getElementData(player, "player:sid"))
		else
			exports["nrpg_db"]:dbSet("update pystories_prezenty set prezenty = ? where id = ?", toJSON(_gifts), getElementData(player, "player:sid"))
		end

		if #_gifts >= #Gifts.position then
			local veh = Gifts.special[math.random(#Gifts.special)]
			outputChatBox("#FFDE00ⓘ#ffffff Gracz #FFDE00"..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." #ffffffzebrał/a prezent a w nim znajduje #FFDE00"..veh[2].."#ffffff!", root, 255, 255, 255, true)
			exports["nrpg_db"]:dbSet("insert into pystories_vehicles set model = ?, ownedPlayer = ?, parking = 1, silnik = ?, bak = 25", veh[1], getElementData(player, "player:sid"), "1.6")
		else
			givePlayerMoney(player, Gifts.settings.giftMoney)
			outputChatBox("#00FF1E✓ #ffffffZebrałeś/aś prezent, otrzymujesz #FFDE00"..formatNumber(Gifts.settings.giftMoney).." PLN#ffffff ("..(#_gifts).."/"..#Gifts.position..")", player, 63, 173, 168, true)
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, Gifts.create)

function table.find(t, val)
	for k, v in pairs(t) do
		if v == val then
			return true
		end
	end

	return false
end

function formatNumber(number) 
	while true do      
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if k==0 then      
			break   
		end  
	end  
	return number
end