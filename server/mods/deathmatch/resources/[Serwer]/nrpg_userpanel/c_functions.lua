bindKey("F5", "down", function()
    if not getElementData(localPlayer, "player:sid") or main.rolling == true then return end
    if main.toggleGUI == false then
        main.loadPlayerInfo()
        addEventHandler("onClientRender", root, main.renderDashboard)
		triggerServerEvent("showDiscordData", localPlayer)
		triggerServerEvent("showFriendsInfo", localPlayer)
        main.toggleGUI = true
        exports["nrpg_editbox"]:destroyCustomEditbox('friend:chat')
        exports["nrpg_interface"]:destroyCustomEditbox('friend:request')
        exports["nrpg_interface"]:destroyCustomEditbox('verify:account')
		exports["nrpg_interface"]:destroyCustomEditbox('account:nick')
        exports["nrpg_interface"]:destroyCustomEditbox('account:password')
		exports["nrpg_interface"]:destroyCustomEditbox('account:serial')
        exports["nrpg_interface"]:destroyCustomEditbox('account:passwordnew')
        exports["nrpg_interface"]:destroyCustomEditbox('account:passwordnew2')
        main.actualPage = "Główna"
        triggerServerEvent("showPlayerInfo", localPlayer)
        showCursor(true)
        toggleVehicle(false)
        local info = dxGetStatus( )
		main.graphicCard = info.VideoCardName
		main.graphicMemory = info.VideoMemoryFreeForMTA
		main.selectedPack = nil
        main.rolling = false
        main.rollingEnd = false
        main.selectedVehicle = nil
        main.drawSelectEmoji = false
        main.selectedPremium = nil
    	main.premiumInformation = nil

		setTimer(function()
			loadAllFriendsAvatars()
		end, 100, 1)
    else
        removeEventHandler("onClientRender", root, main.renderDashboard)
        main.toggleGUI = false
        exports["nrpg_editbox"]:destroyCustomEditbox('friend:chat')
        exports["nrpg_interface"]:destroyCustomEditbox('friend:request')
        exports["nrpg_interface"]:destroyCustomEditbox('verify:account')
		exports["nrpg_interface"]:destroyCustomEditbox('account:nick')
        exports["nrpg_interface"]:destroyCustomEditbox('account:password')
        exports["nrpg_interface"]:destroyCustomEditbox('account:passwordnew')
		exports["nrpg_interface"]:destroyCustomEditbox('account:serial')
        exports["nrpg_interface"]:destroyCustomEditbox('account:passwordnew2')
        main.actualPage = "Główna"
        triggerServerEvent("showPlayerInfo", localPlayer)
        showCursor(false)
        toggleVehicle(false)
    end
end)

function isScreenElementInPosition(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function loadAllFriendsAvatars()
	for i,v in ipairs(playerInfo.friends) do
		if not loaded[v.friendsid] then
			triggerServerEvent("loadPlayerCustomAvatar", localPlayer, v.friendsid)
			loaded[v.friendsid] = true
		end
	end
	triggerServerEvent("loadPlayerCustomAvatar", localPlayer, getElementData(localPlayer, "player:sid"))
end

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end

    cx,cy = getCursorPosition()
    cx,cy = cx*sW, cy*sH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true, cx, cy
    else
        return false
    end
end

function secondsToClock(seconds)
	seconds = seconds or 0
	seconds = seconds*60
	if seconds <= 0 then
		return "0 godz. 0 min."
	else
		hours = string.format("%02.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
		return ""..hours.." godz. "..mins.." min."
	end
end

function isPlayerTyping(plr)
	if getElementData(plr, "player:editboxWrite") then
		return true
	else
		return false
	end
end

function checkStatus(uid)
	for _, plr in ipairs(getElementsByType("player")) do
		if getElementData(plr, "player:sid") == uid then
			return plr
		end
	end
end

local wd = {[1] = "Pon.", [2] = "Wt.", [3] = "Śr", [4] = "Czw.", [5] = "Pt.", [6] = "Sob.", [0] = "Ndz."}
local m = {[1] = "Lut.", [2] = "Mar.", [3] = "Kwi.", [4] = "Maj.", [5] = "Czrw.", [6] = "Lip.", [7] = "Sie.", [8] = "Wrz.", [9] = "Paź.", [10] = "List.", [11] = "Gru.", [0] = "Sty.", }
function includeZero(n) if #tostring(n) == 1 then return "0"..n end return n end
function getDayName(n) return wd[n] end
function getMonthName(n) return m[n] end

function calcToday()
    local time = getRealTime()
    local thetime = includeZero(time.hour) .. ":" .. includeZero(time.minute)
    local date = getDayName(time.weekday) .. " " .. time.monthday .. " " .. getMonthName(time.month) .. " " .. time.year + 1900

	if thetime and date then
		return date.."\n"..thetime
	end
end

function findCar(id)
	for k,p in ipairs(getElementsByType("vehicle")) do
		if getElementData(p, "vehicle:id") == id then
			return p
		end
	end
end

function findUser(sid)
	if sid then
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "player:sid") == sid then
				return v
			else
				return false
			end
		end
	end
end

function toggleVehicle(model, veh)
	if model ~= false then
		local x1, y1, z1 = getCameraMatrix()
		vehicle = createVehicle(model, 0, 0, -100)

		for i,v in ipairs(split(veh["tuning"], ",")) do 
        	addVehicleUpgrade(vehicle, v) 
        end

		local color = split(veh["color"], ",")
		local var = split(veh["wariant"], ",")

		if var[1] and var[2] then
			setVehicleVariant(vehicle, var[1], var[2])
		else
			setVehicleVariant(vehicle, 0, 1)
		end
		
		if color then
        	setVehicleColor(vehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], color[10], color[11], color[12])
		end
		setElementCollisionsEnabled(vehicle, false)
		setElementAlpha(vehicle, 0)

		myObject = exports.nrpg_object_preview:createObjectPreview(vehicle, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
		windowRender = guiCreateWindow(582*w, 194*h, 427*w, 224*h, "", false, false)
		guiWindowSetMovable(windowRender, false)
		guiWindowSetSizable(windowRender, false) 
		guiSetAlpha(windowRender, 0)
		local projPosX, projPosY = guiGetPosition(windowRender,true)
		local projSizeX, projSizeY = guiGetSize(windowRender, true)
		exports.nrpg_object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
	else
		if isElement(vehicle) then destroyElement(vehicle) end
		if isElement(myObject) then destroyElement(myObject) end
		if isElement(windowRender) then destroyElement(windowRender) end
	end
end

addEvent("clientPlayerInfo", true)
addEventHandler("clientPlayerInfo", root, function(table)
	playerInfo.player = table

	for i,v in ipairs(table) do
		playerInfo.saveCode = v.code
		playerInfo.actualPass = v.pass
	end
end)

addEvent("clientVehicleInfo", true)
addEventHandler("clientVehicleInfo", root, function(table)
	playerInfo.vehicles = table
end)

addEvent("clientFriendInfo", true)
addEventHandler("clientFriendInfo", root, function(table)
	playerInfo.friends = table
end)

addEvent("showClientDiscordInfo", true)
addEventHandler("showClientDiscordInfo", root, function(table)
	playerInfo.discord = table
end)

addEvent("clientSerialAction", true)
addEventHandler("clientSerialAction", root, function(actionType, arg1, arg2)
	if actionType == "add" then

	elseif actionType == "delete" then
		
	elseif actionType == "show" then
		playerInfo.serials = arg1
	end
end)

addEvent("reloadTables", true)
addEventHandler("reloadTables", root, function(plr)
	triggerServerEvent("showFriendsInfo", plr)
    triggerServerEvent("showInvitesInfo", plr)
	triggerServerEvent("showInvitesInfoSend", plr)

	if main.selectedFriend ~= nil then
		triggerServerEvent("showFriendMessages", plr, main.selectedFriend)
	end

	loadAllFriendsAvatars()
end)

addEvent("loadMessages", true)
addEventHandler("loadMessages", root, function(plr, uid)
	triggerServerEvent("showFriendMessages", plr, uid)
end)

addEvent("clientInviteInfo", true)
addEventHandler("clientInviteInfo", root, function(table)
	playerInfo.friends_request = table
end)

addEvent("clientInviteInfoSend", true)
addEventHandler("clientInviteInfoSend", root, function(table)
	playerInfo.friends_request_send = table
end)

addEvent("clientChatInfo", true)
addEventHandler("clientChatInfo", root, function(table, chatNick, chatEmoji, chatUnreadMessages)
	if table == nil then table = {} end
	chat.messages = fromJSON(table)
	chat.settings = {

		emoji = chatEmoji or "like_icon",
		nick = chatNick or nil,
		unread = chatUnreadMessages or 0,

	}
	main.loadState = false
end)

function convertNumber(amount) 
    local formatted = amount 
    while true do   
      formatted, ss = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (ss==0) then 
        break 
      end 
    end 
    return formatted 
end

index = 0    
linecount = nil
scrollCount = nil
windowheight = nil
scrollLimit = 0

visiblefactor = nil
visiblefactor = nil
barheight = nil
position = nil