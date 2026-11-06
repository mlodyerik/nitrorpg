																																																																																																	--[[
#Autor: ReDsKill <redskill.tyb@wp.pl)
#Nazwa skryptu: ST_organization_panel
#Zakaz używania kodu bez mojej zgody.
																																																																							]]--
local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local windowPos = {x=math.floor(screenW/2-1050/zoom/2), y=math.floor(screenH/2-750/zoom/2), w=math.floor(1050/zoom), h=math.floor(750/zoom)}
local crossPos = {x=math.floor(screenW/2-1030/zoom/2), y=math.floor(screenH/2+670/zoom/2), w=math.floor(32/zoom), h=math.floor(32/zoom)}

show_statistic = {}
select_user = {}

local k = 1
local n = 14
local m = 14

local n2 = 19

local n3 = 13
local m3 = 13

tick = getTickCount()

windows = {
	background = false,
	main = false,
	users = false,
	selectUser = false,
}

textures = {
	cross = dxCreateTexture(':nrpg_interface/img/cross.png'),
}

function window()	
	local x, y, w, h = windowPos.x, windowPos.y, math.floor(362/zoom), math.floor(204/zoom)
		
		dxDrawRectangle(windowPos.x, windowPos.y, windowPos.w, windowPos.h, tocolor(45,45,85,250), false)
		dxDrawRectangle(windowPos.x, windowPos.y, windowPos.w-math.floor(900/zoom), windowPos.h, tocolor(30,30,60,240), false)
		dxDrawRectangle(windowPos.x+math.floor(145/zoom), windowPos.y, windowPos.w-math.floor(1045/zoom), windowPos.h, tocolor(255, 255, 0,230), false)
		
		if isMouseIn(windowPos.x, windowPos.y, windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) then
			dxDrawRectangle(windowPos.x, windowPos.y, windowPos.w-math.floor(910/zoom), math.floor(50/zoom), tocolor(50,50,100,240), false)
		end
		
		if isMouseIn(windowPos.x, windowPos.y+math.floor(50/zoom), windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) then
			dxDrawRectangle(windowPos.x, windowPos.y+math.floor(50/zoom), windowPos.w-math.floor(910/zoom), math.floor(50/zoom), tocolor(50,50,100,240), false)
		end
		
		dxDrawText('INFORMACJE', x+math.floor(6/zoom), y-math.floor(150/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light17'), 'left', 'center', false, false, false, false, false)
		dxDrawText('CZŁONKOWIE', x+math.floor(6/zoom), y-math.floor(50/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light17'), 'left', 'center', false, false, false, false, false)
		
		if isMouseIn(crossPos.x, crossPos.y, crossPos.w, crossPos.h) then
			dxDrawImage(crossPos.x-math.floor(1/zoom), crossPos.y-math.floor(1/zoom), crossPos.w+math.floor(2/zoom), crossPos.h+math.floor(2/zoom), textures.cross, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(crossPos.x, crossPos.y, crossPos.w, crossPos.h, textures.cross, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		
	if windows.main == true then
		dxDrawText('FRAKCJA', x+math.floor(840/zoom), y-math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money26'), 'center', 'center', false, false, false, false, false)
		dxDrawText('NAZWA:', x+math.floor(390/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
		dxDrawText(organizationName, x+math.floor(670/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
		dxDrawText('ILOŚĆ OSÓB:', x+math.floor(390/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light24'), 'left', 'center', false, false, false, false, false)
		dxDrawText(#show_statistic..' / 50', x+math.floor(670/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
	end

	if windows.users == true then
		dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(700/zoom), tocolor(35,35,75,230), false)
		dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(690/zoom), windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(690/zoom), tocolor(35,35,75,230), false)
		xY = 0
		dxDrawText('NICK', x+math.floor(160/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light21'), 'left', 'center', false, false, false, false, false)
		dxDrawText('RANGA', x+math.floor(530/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light21'), 'left', 'center', false, false, false, false, false)
		dxDrawText('DODANY', x, y-math.floor(153/zoom), x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light21'), 'right', 'center', false, false, false, false, false)
		exports['nrpg_buttons']:dxCreateButton("Dodaj", windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 255)
		for i,v in ipairs(show_statistic) do
			if i >= k and i <= n3 then 
				xY = xY + 1
				local offsetY = math.floor(50/zoom)*(xY-1)
				local offsetYTEXT = math.floor(100/zoom)*(xY-1)
				local rank = v["rank"]
				if getElementData(localPlayer,'player:faction') == 'SAPD' then
					if rank == 11 then rank = "Chief of Police" 
					elseif rank == 10 then rank = "Assistan Chief of Police" 
					elseif rank == 9 then rank = "Deputy Chief" 
					elseif rank == 8 then rank = "Captain" 
					elseif rank == 7 then rank = "Detective"
					elseif rank == 6 then rank = "Sergeant"
					elseif rank == 5 then rank = "Police Officer III+I"
					elseif rank == 4 then rank = "Police Officer III" 
					elseif rank == 3 then rank = "Police Officer II" 
					elseif rank == 2 then rank = "Police Officer I" 
					elseif rank == 1 then rank = "Cadet" 
					end
					dxDrawText(rank, x+math.floor(530/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				elseif getElementData(localPlayer,'player:faction') == 'SAFD' then
					if rank == 11 then rank = "Fire Chief" 
					elseif rank == 10 then rank = "Deputy Chief" 
					elseif rank == 9 then rank = "Assistance Of Deputy Chief" 
					elseif rank == 8 then rank = "Battalion Chief" 
					elseif rank == 7 then rank = "Captain" 
					elseif rank == 6 then rank = "Lieutenant" 
					elseif rank == 5 then rank = "Enginer" 
					elseif rank == 4 then rank = "FireFighter Class III" 
					elseif rank == 3 then rank = "FireFighter Class II" 
					elseif rank == 2 then rank = "FireFighter Class I" 
					elseif rank == 1 then rank = "Candidate" 
					end
					dxDrawText(rank, x+math.floor(530/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				elseif getElementData(localPlayer,'player:faction') == 'SARA' then
					if rank == 11 then rank = "Główny Inżynier" 
					elseif rank == 10 then rank = "Zastępca Głównego Inżyniera" 
					elseif rank == 9 then rank = "Zastępca Inspektora" 
					elseif rank == 8 then rank = "Główny Operator" 
					elseif rank == 7 then rank = "Operator"
					elseif rank == 6 then rank = "Doświadczony Specjalista"
					elseif rank == 5 then rank = "Specjalista"
					elseif rank == 4 then rank = "Doświadczony Budowlany"
					elseif rank == 3 then rank = "Budowlany"
					elseif rank == 2 then rank = "Pracownik"
					elseif rank == 1 then rank = "Adept"
					end
					dxDrawText(rank, x+math.floor(530/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				elseif getElementData(localPlayer,'player:faction') == 'TAXI' then
					if rank == 11 then rank = "Szef" 
					elseif rank == 10 then rank = "Zastępca szefa" 
					elseif rank == 9 then rank = "Menadżer" 
					elseif rank == 8 then rank = "Zastępca menadżera" 
					elseif rank == 7 then rank = "Transport V.I.P"
					elseif rank == 6 then rank = "Transport Lotniczy"
					elseif rank == 5 then rank = "Doświadczony kierowca"
					elseif rank == 4 then rank = "Wykwalifikowany kierowca"
					elseif rank == 3 then rank = "Starszy kierowca"
					elseif rank == 2 then rank = "Kierowca"
					elseif rank == 1 then rank = "Adept"
					end
					dxDrawText(rank, x+math.floor(530/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				end
				
				if isMouseIn(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(710/zoom)) then
					dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(700/zoom), tocolor(160, 160, 160, 20), false)
				end
				
				dxDrawText(v['nick'], x+math.floor(160/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				dxDrawText(v['actived'], x, y-math.floor(55/zoom)+offsetYTEXT, x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'right', 'center', false, false, false, false, false)
			end
		end
	end
	
	if windows.selectUser == true then
		dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(690/zoom), windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(690/zoom), tocolor(35,35,75,230), false)
		exports['nrpg_buttons']:dxCreateButton("Awansuj", windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 1)
		exports['nrpg_buttons']:dxCreateButton("Degraduj", windowPos.x+math.floor(670/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 2)
		exports['nrpg_buttons']:dxCreateButton("Wyrzuć", windowPos.x+math.floor(470/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 3)
		for i, v in ipairs(select_user) do
				local rank = v["rank"]
				
				if getElementData(localPlayer,'player:faction') == 'SAPD' then
					if rank == 11 then rank = "Chief of Police" 
					elseif rank == 10 then rank = "Assistan Chief of Police" 
					elseif rank == 9 then rank = "Deputy Chief" 
					elseif rank == 8 then rank = "Detective II" 
					elseif rank == 7 then rank = "Detective I"
					elseif rank == 6 then rank = "Sergeant II"
					elseif rank == 5 then rank = "Sergeant I"
					elseif rank == 4 then rank = "Police Officer III" 
					elseif rank == 3 then rank = "Police Officer II" 
					elseif rank == 2 then rank = "Police Officer I" 
					elseif rank == 1 then rank = "Cadet" 
					end
					dxDrawText(rank, x+math.floor(600/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
				elseif getElementData(localPlayer,'player:faction') == 'SAFD' then
					if rank == 11 then rank = "Generał Brygadier" 
					elseif rank == 10 then rank = "Nadbrygadier" 
					elseif rank == 9 then rank = "Brygadier" 
					elseif rank == 8 then rank = "Kapitan" 
					elseif rank == 7 then rank = "Aspirant" 
					elseif rank == 6 then rank = "Ogniomistrz" 
					elseif rank == 5 then rank = "Starszy Sekcyjny" 
					elseif rank == 4 then rank = "Sekcyjny" 
					elseif rank == 3 then rank = "Starszy Strażak" 
					elseif rank == 2 then rank = "Strażak" 
					elseif rank == 1 then rank = "Podchorąży" 
					end
					dxDrawText(rank, x+math.floor(600/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
				elseif getElementData(localPlayer,'player:faction') == 'SARA' then
					if rank == 11 then rank = "Główny Inżynier" 
					elseif rank == 10 then rank = "Zastępca Głównego Inżyniera" 
					elseif rank == 9 then rank = "Zastępca Inspektora" 
					elseif rank == 8 then rank = "Główny Operator" 
					elseif rank == 7 then rank = "Operator"
					elseif rank == 6 then rank = "Doświadczony Specjalista"
					elseif rank == 5 then rank = "Specjalista"
					elseif rank == 4 then rank = "Doświadczony Budowlany"
					elseif rank == 3 then rank = "Budowlany"
					elseif rank == 2 then rank = "Pracownik"
					elseif rank == 1 then rank = "Adept"
					end
					dxDrawText(rank, x+math.floor(600/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
				elseif getElementData(localPlayer,'player:faction') == 'TAXI' then
					if rank == 11 then rank = "Szef" 
					elseif rank == 10 then rank = "Zastępca szefa" 
					elseif rank == 9 then rank = "Menadżer" 
					elseif rank == 8 then rank = "Zastępca menadżera" 
					elseif rank == 7 then rank = "Transport V.I.P"
					elseif rank == 6 then rank = "Transport Lotniczy"
					elseif rank == 5 then rank = "Doświadczony kierowca"
					elseif rank == 4 then rank = "Wykwalifikowany kierowca"
					elseif rank == 3 then rank = "Starszy kierowca"
					elseif rank == 2 then rank = "Kierowca"
					elseif rank == 1 then rank = "Adept"
					end
					dxDrawText(rank, x+math.floor(530/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				end
		
			dxDrawText('INFORMACJE O UŻYTKOWNIKU', x+math.floor(790/zoom), y-math.floor(140/zoom), x+w, y+h, tocolor(230, 230, 230, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light24'), 'center', 'center', false, false, false, false, false)
			dxDrawText('NICK:', x+math.floor(360/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['nick'], x+math.floor(600/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('RANGA:', x+math.floor(360/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('PRZYJĘTY:', x+math.floor(360/zoom), y+math.floor(240/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['actived'], x+math.floor(600/zoom), y+math.floor(240/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('UID:', x+math.floor(360/zoom), y+math.floor(340/zoom), x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['uid'], x+math.floor(600/zoom), y+math.floor(340/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
		end
	end
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
		--WYBÓR GRACZA--
		if windows.background == true and windows.users == true then
			local xY = 0
			for i, v in ipairs(show_statistic) do
				if i >= k and i <= n3 then 
					xY = xY + 1
					local offsetY = math.floor(50/zoom)*(xY-1)
					if isMouseIn(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(700/zoom)) and windows.users == true and windows.selectUser == false then
						triggerServerEvent("selectUserFaction", localPlayer, v["uid"])
						windows.selectUser = true
						windows.main = false
						windows.users = false
						exports['nrpg_interface']:destroyCustomEditbox('addUser')
					end
				end
			end
		end
	
		--PRZYCISK INFORMACJI
		if isMouseIn(windowPos.x, windowPos.y, windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) and windows.background == true and windows.main == false then
			windows.users = false
			windows.main = true
			windows.selectUser = false
			triggerServerEvent("showGuiFractionsPanel", localPlayer)
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
		
		--PRZYCISK UCZESTNIKÓW--
		elseif isMouseIn(windowPos.x, windowPos.y+math.floor(50/zoom), windowPos.w-math.floor(900/zoom), math.floor(50/zoom)) and windows.background == true and windows.users == false then
			windows.users = true
			windows.main = false
			windows.selectUser = false
			triggerServerEvent("showGuiFractionsPanel", localPlayer)
			exports['nrpg_interface']:createCustomEditbox('addUser', 'Wprowadź UID', windowPos.x+math.floor(650/zoom), windowPos.y+math.floor(695/zoom), math.floor(200/zoom), math.floor(50/zoom), false, "")
			
		--PRZYCISK DODAWANIA UŻYTKOWNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.users == true then
			player_uid_add = exports['nrpg_interface']:getCustomEditboxText('addUser')
			if player_uid_add:len() < 1 then
				exports.nrpg_interface:showPlayerNotification("Wprowadź UID", "error", 15000)
			return end
			triggerServerEvent("ev",resourceRoot, "addUserOrganization", player_uid_add, organizationName)	
			triggerServerEvent("showGuiFractionsPanel", localPlayer)			
		--PRZYCISK AWANSOWANIA UŻYTKOWNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.selectUser == true then
			for i, v in ipairs(select_user) do
				triggerServerEvent("ev",resourceRoot, "advanceUserOrganization", v["uid"])
				triggerServerEvent("selectUserFaction", localPlayer, v["uid"])
			end
		--PRZYCISK DEGRADOWANIA UŻYTKOWNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(670/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.selectUser == true then
			for i, v in ipairs(select_user) do
				triggerServerEvent("ev",resourceRoot, "degradeUserOrganization", v["uid"])
				triggerServerEvent("selectUserFaction", localPlayer, v["uid"])
			end
		--PRZYCISK WYRZUCENIA UCZESTNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(470/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.selectUser == true then
			for i, v in ipairs(select_user) do
				triggerServerEvent("ev",resourceRoot, "removeUserOrganization", v["uid"])
			end
			triggerServerEvent("showGuiFractionsPanel", localPlayer)
			windows.main = false
			windows.selectUser = false
			windows.users = true
			exports['nrpg_interface']:createCustomEditbox('addUser', 'Wprowadź UID', windowPos.x+math.floor(650/zoom), windowPos.y+math.floor(695/zoom), math.floor(200/zoom), math.floor(50/zoom), false, "")
		
		--PRZYCISK ZAMKNIĘCIA--
		elseif isMouseIn(crossPos.x, crossPos.y, crossPos.w, crossPos.h) and windows.background == true then
			removeEventHandler("onClientRender", root, window)
			windows.background = false
			windows.main = false
			windows.users = false
			windows.selectUser = false
			showCursor(false)
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
		end
	end
end)

addEvent("showGuiFaction", true)
addEventHandler("showGuiFaction", resourceRoot, function(fid,result)
		organizationName = fid
		addEventHandler("onClientRender", root, window)
		triggerServerEvent("showGuiFractionsPanel", localPlayer)
		windows.background = true
		windows.main = true
		windows.users = false
		windows.selectUser = false
		showCursor(true,false)
end)

addEvent("showGuiFractionsPanelClient", true)
addEventHandler("showGuiFractionsPanelClient", root, function(table)
  show_statistic = table
end)

addEvent("selectUserFactionClient", true)
addEventHandler("selectUserFactionClient", root, function(table)
  select_user = table
end)

bindKey("mouse_wheel_down", "both", function()
	if windows.users == true then
		scrollUp2()
    end
end)

bindKey("mouse_wheel_up", "both", function()
	if windows.users == true then
		scrollDown2()
    end
end)

function scrollDown2()
	if n3 == m3 then return end
	k = k-1
	n3 = n3-1
end

function scrollUp2()
	if n3 >= #show_statistic then return end
	k = k+1
	n3 = n3+1
end 

function przecinek(xd)
	local left,num,right = string.match(xd,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function isMouseIn ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end