NOTIFICATION_TIME = 6000 -- domyślny czas notyfikacji 
NOTIFICATION_LIMIT = 5
NOTIFICATION_CATEGORIES = {
	["info"] = {25, 175, 255},
	["error"] = {200, 55, 55},
	["success"] = {55, 200, 55},
	["money"] = {255, 255, 0},
	["message"] = {200, 55, 200},
}

local screenW, screenH = guiGetScreenSize()
-- pozycje 
local zoom = exports.nrpg_interface:getInterfaceZoom()
local notificationPos= {x=screenW, y=10, w=math.floor(552/zoom), h=math.floor(92/zoom)}
notificationPos.x = notificationPos.x - notificationPos.w - math.floor(25/zoom)

main = {

	getLib = exports.nrpg_lib

}

interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(35, 35, 35, 255)),
	backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(100, 100, 100, 255)),

}

-- zmienne 
local textures = {}
local notifications = {}
local visibleNotifications = 0 

function addNotification(text, category, time, customCategory)
	if type(text) == "string" and NOTIFICATION_CATEGORIES[category] then 
		if visibleNotifications+1 > NOTIFICATION_LIMIT then 
			for k, v in ipairs(notifications) do 
				if not v.hidden then 
					v.hidden = true
					break
				end 
			end
		end 
		

		icon = textures[category]


		outputConsole(" ")
    	outputConsole("["..(category or "info").."] "..text:gsub("#%x%x%x%x%x%x", ""))
    	outputConsole(" ")
		
		local allowSound = true
		local customCat = nil

		if customCategory then
			customCat = customCategory
		else
			customCat = nil
		end
		
		if allowSound then 
			if fileExists("sounds/"..tostring(category)..".mp3") then
				local snd = playSound("sounds/"..tostring(category)..".mp3", false)
				setSoundVolume(snd, 0.7)
			end
		end
		
		table.insert(notifications, {text=text, category=category, offsetX=notificationPos.w*2, offsetY=175/zoom, posX=0, icon=icon, alpha=255, customCategory=customCat})
		if #notifications > 1 then
			for k, v in ipairs(notifications) do 
				if v.offsetY_anim then 
					finishAnimation(v.offsetY_anim)
				end
			end 
			
			for k, v in ipairs(notifications) do
				if k < #notifications then
					local offsetY = v.offsetY
					local notification = k
					v.offsetY_anim = createAnimation(0, notificationPos.h, "InOutQuad", 300, function(progress)
						notifications[notification].offsetY = offsetY+progress
					end)
				end
			end
		end
		
		local notification = #notifications
		createAnimation(notificationPos.w*2, 0, "InOutQuad", 500, function(progress)
			notifications[notification].offsetX = progress
		end)
		
		createAnimation(math.floor(537/zoom), 0, "InOutQuad", time or 6000, function(value1) 
			notifications[notification].posX = value1 
		end)

		createAnimation(math.floor(40/zoom), 0, "InOutQuad", time or 6000, function(value1) 
			notifications[notification].alpha = value1 
		end)
		
		setTimer(deleteNotification, time or 6000, 1, notification)
		
		return notification
	end
end 
addEvent("onClientAddNotification", true)
addEventHandler("onClientAddNotification", resourceRoot, addNotification)

function deleteNotification(id)
	if notifications[id] and not notifications[id].hiding and not notifications[id].hidden then 
		notifications[id].hiding = true
		createAnimation(0, notificationPos.w*2, "InOutQuad", 1000, function(progress)
			notifications[id].offsetX = progress
		end)
		
		createAnimation(255, 0, "InOutQuad", 1000, 
			function(progress)
			end,
			
			function()
				notifications[id].hidden = true
			end
		)
		
	end
end 

function showPlayerNotification(...)
	return addNotification(...)
end

addEventHandler("onClientRender", root, function()
	local hidden = 0
	visibleNotifications = 0
	
	for k, notification in ipairs(notifications) do 
		if notification.hidden then 
			hidden = hidden+1
		else 
			visibleNotifications = visibleNotifications+1
			local offsetX, offsetY = notification.offsetX, notification.offsetY
			local color = NOTIFICATION_CATEGORIES[notification.category]

			dxDrawImage(notificationPos.x+offsetX, notificationPos.y+offsetY, notificationPos.w, notificationPos.h-math.floor(10/zoom), interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), true)
			dxDrawImage(notificationPos.x+offsetX+1, notificationPos.y+offsetY+1, notificationPos.w-2, notificationPos.h-math.floor(10/zoom)-2, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), true)
			dxDrawRectangle(notificationPos.x+math.floor(72/zoom)+offsetX, notificationPos.y+math.floor(22/zoom)+offsetY, math.floor(2/zoom), math.floor(40/zoom), tocolor(100, 100, 100, 255), true)
			dxDrawRectangle(notificationPos.x+math.floor(72/zoom)+offsetX, notificationPos.y+math.floor(22/zoom)+offsetY, math.floor(2/zoom), notification.alpha, tocolor(color[1], color[2], color[3], 255), true)
			

			if notification.customCategory then
				notiCat = notification.customCategory
			else
				if notification.category == "error" then
					notiCat = "Błąd"
				elseif notification.category == "success" then
					notiCat = "Sukces"
				elseif notification.category == "info" then
					notiCat = "Informacja"
				elseif notification.category == "money" then
					notiCat = "Gotówka"
				elseif notification.category == "message" then
					notiCat = "Wiadomość"
				else
					notiCat = ""
				end
			end

			local x, y, w, h = math.floor(notificationPos.x+offsetX+notificationPos.w*0.2), math.floor(notificationPos.y+offsetY-math.floor(10/zoom)), math.floor(notificationPos.w*0.75), notificationPos.y+notificationPos.h
			dxDrawText(notiCat, x-math.floor(20/zoom), y+math.floor(52/zoom), nil, nil, tocolor(color[1], color[2], color[3], 255), 1, exports.nrpg_interface:getGUIFont("money12"), "left", "bottom", false, true, true)
			dxDrawText(notification.text:gsub("#%x%x%x%x%x%x", ""), x-math.floor(20/zoom), y+math.floor(50/zoom), nil, nil, tocolor(195, 195, 195, 225), 1, exports.nrpg_interface:getGUIFont("light10"), "left", "top", false, true, true)
			if notification.icon then
				dxDrawImage(notificationPos.x+offsetX+math.floor(15/zoom), notificationPos.y+offsetY+math.floor((notificationPos.h*0.35)/2), math.floor(notificationPos.h*0.55), math.floor(notificationPos.h*0.55), notification.icon, 0, 0, 0, tocolor(color[1], color[2], color[3], 255), true)
			end
		end
	end
	
	if hidden == #notifications then 
		notifications = {}
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	textures.info = dxCreateTexture("img/notifications/info.png")
	textures.error = dxCreateTexture("img/notifications/error.png")
	textures.money = dxCreateTexture("img/notifications/money.png")
	textures.success = dxCreateTexture("img/notifications/success.png")
	textures.message = dxCreateTexture("img/notifications/message.png")
end)