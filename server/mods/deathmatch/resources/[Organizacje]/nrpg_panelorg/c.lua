local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local windowPos = {x=math.floor(screenW/2-1050/zoom/2), y=math.floor(screenH/2-750/zoom/2), w=math.floor(1050/zoom), h=math.floor(750/zoom)}
local crossPos = {x=math.floor(screenW/2-1030/zoom/2), y=math.floor(screenH/2+670/zoom/2), w=math.floor(32/zoom), h=math.floor(32/zoom)}

show_statistic = {}
select_user = {}
show_vehicles = {}
show_info = {}
show_atm_logs = {}

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
	vehicles = false,
	funds = false,
	message = false,
}

local getLib = exports.nrpg_lib

interface = {

    backgroundRectangle = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 25, 255)),
    scrollRectangle = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 200, 255)),

}

textures = {
	cross = dxCreateTexture(':nrpg_interface/img/cross.png'),
}

function window()	
	local x, y, w, h = windowPos.x, windowPos.y, math.floor(362/zoom), math.floor(204/zoom)

		

		dxDrawImage(windowPos.x-math.floor(5/zoom), windowPos.y-math.floor(5/zoom), windowPos.w+math.floor(10/zoom), windowPos.h+math.floor(10/zoom), interface.backgroundRectangle, 0, 0, 0, tocolor(200, 200, 255, 255), false)
		
		if isMouseIn(windowPos.x, windowPos.y, windowPos.w-math.floor(907/zoom), math.floor(50/zoom)) then
			dxDrawText('OGÓLNE', x+math.floor(6/zoom), y-math.floor(150/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), 'left', 'center', false, false, false, false, false)
		else
			dxDrawText('OGÓLNE', x+math.floor(6/zoom), y-math.floor(150/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light14'), 'left', 'center', false, false, false, false, false)
		end
		
		if isMouseIn(windowPos.x, windowPos.y+math.floor(50/zoom), windowPos.w-math.floor(907/zoom), math.floor(50/zoom)) then
			dxDrawText('GRACZE', x+math.floor(6/zoom), y-math.floor(50/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), 'left', 'center', false, false, false, false, false)
		else
			dxDrawText('GRACZE', x+math.floor(6/zoom), y-math.floor(50/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light14'), 'left', 'center', false, false, false, false, false)			
		end
		
		if isMouseIn(windowPos.x, windowPos.y+math.floor(100/zoom), windowPos.w-math.floor(907/zoom), math.floor(50/zoom)) then
			dxDrawText('POJAZDY', x+math.floor(6/zoom), y+math.floor(50/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), 'left', 'center', false, false, false, false, false)
		else
			dxDrawText('POJAZDY', x+math.floor(6/zoom), y+math.floor(50/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light14'), 'left', 'center', false, false, false, false, false)
		end
		
		if isMouseIn(windowPos.x, windowPos.y+math.floor(150/zoom), windowPos.w-math.floor(907/zoom), math.floor(50/zoom)) then
			dxDrawText('MAJĄTEK', x+math.floor(6/zoom), y+math.floor(150/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), 'left', 'center', false, false, false, false, false)
		else
			dxDrawText('MAJĄTEK', x+math.floor(6/zoom), y+math.floor(150/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light14'), 'left', 'center', false, false, false, false, false)
		end
		
		if isMouseIn(windowPos.x, windowPos.y+math.floor(200/zoom), windowPos.w-math.floor(907/zoom), math.floor(50/zoom)) then
			dxDrawText('WIADOMOŚĆ', x+math.floor(6/zoom), y+math.floor(250/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), 'left', 'center', false, false, false, false, false)
		else
			dxDrawText('WIADOMOŚĆ', x+math.floor(6/zoom), y+math.floor(250/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light14'), 'left', 'center', false, false, false, false, false)
		end

		if isMouseIn(windowPos.x, windowPos.y+math.floor(250/zoom), windowPos.w-math.floor(907/zoom), math.floor(50/zoom)) then
			dxDrawText('RANGI', x+math.floor(6/zoom), y+math.floor(350/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money14'), 'left', 'center', false, false, false, false, false)
		else
			dxDrawText('RANGI', x+math.floor(6/zoom), y+math.floor(350/zoom), x+w, y+h, tocolor(220, 220, 220, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light14'), 'left', 'center', false, false, false, false, false)
		end
		
	if windows.main == true then
		dxDrawText('ORGANIZACJA', x+math.floor(840/zoom), y-math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money30'), 'center', 'center', false, false, false, false, false)
		dxDrawText('NAZWA:', x+math.floor(390/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
		dxDrawText(organizationName, x+math.floor(670/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
		dxDrawText('CZŁONKOWIE:', x+math.floor(390/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
		dxDrawText(#show_statistic..' / 50', x+math.floor(670/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
		for i,v in ipairs(show_info) do
			dxDrawText('ZAŁOŻYCIEL:', x+math.floor(390/zoom), y+math.floor(240/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['zalozyciel'], x+math.floor(670/zoom), y+math.floor(240/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('DATA UTWORZENIA:', x+math.floor(390/zoom), y+math.floor(340/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['utworzona'], x+math.floor(670/zoom), y+math.floor(340/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('STAN KONTA:', x+math.floor(390/zoom), y+math.floor(440/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
			dxDrawText(przecinek(v['kasa'])..' PLN', x+math.floor(670/zoom), y+math.floor(440/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('ZABÓJSTWA:', x+math.floor(390/zoom), y+math.floor(540/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
			dxDrawText(przecinek(v['kille'] or 0)..'', x+math.floor(670/zoom), y+math.floor(540/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('ZGONY:', x+math.floor(390/zoom), y+math.floor(640/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
			dxDrawText(przecinek(v['zgony'] or 0)..'', x+math.floor(670/zoom), y+math.floor(640/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('REPUTACJA:', x+math.floor(390/zoom), y+math.floor(740/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'left', 'center', false, false, false, false, false)
			dxDrawText(przecinek(v['punkty'] or 0)..'', x+math.floor(670/zoom), y+math.floor(740/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			
			dxDrawText('WIADOMOŚĆ OD LIDERA', x+math.floor(840/zoom), y+math.floor(960/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money19'), 'center', 'center', false, false, false, false, false)
			dxDrawText(v['wiadomosc'], x+math.floor(840/zoom), y+math.floor(1030/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light20'), 'center', 'center', false, false, false, false, false)
		end
	end

	if windows.users == true then
		xY = 0
		dxDrawText('NICK', x+math.floor(160/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'left', 'center', false, false, false, false, false)
		dxDrawText('RANGA', x+math.floor(530/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'left', 'center', false, false, false, false, false)
		dxDrawText('AKTYWNOŚĆ', x, y-math.floor(153/zoom), x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'right', 'center', false, false, false, false, false)
		exports['nrpg_buttons']:dxCreateButton("Dodaj", windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 255, {55, 155, 55})
		for i,v in ipairs(show_statistic) do
			if i >= k and i <= n3 then 
				xY = xY + 1
				local offsetY = math.floor(50/zoom)*(xY-1)
				local offsetYTEXT = math.floor(100/zoom)*(xY-1)
				
				if tonumber(v.rank) == 5 then ranka = v.rank_5
				elseif tonumber(v.rank) == 4 then ranka = v.rank_4
				elseif tonumber(v.rank) == 3 then ranka = v.rank_3
				elseif tonumber(v.rank) == 2 then ranka = v.rank_2
				elseif tonumber(v.rank) == 1 then ranka = v.rank_1
				end
				
				if isMouseIn(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(710/zoom)) then
					dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(700/zoom), tocolor(100, 100, 200, 25), false)
				end
				
				--dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(700/zoom), tocolor(100, 100, 200, 25), false)
				
				dxDrawText(v['login'], x+math.floor(160/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				dxDrawText(ranka, x+math.floor(530/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				dxDrawText(v['aktywny'], x, y-math.floor(55/zoom)+offsetYTEXT, x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'right', 'center', false, false, false, false, false)
			end
		end
	end
	
	if windows.selectUser == true then
		exports['nrpg_buttons']:dxCreateButton("Awansuj", windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 1, {55, 155, 55})
		exports['nrpg_buttons']:dxCreateButton("Degraduj", windowPos.x+math.floor(670/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 2, {155, 155, 55})
		exports['nrpg_buttons']:dxCreateButton("Wyrzuć", windowPos.x+math.floor(470/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 3, {155, 55, 55})
		for i, v in ipairs(select_user) do


				if tonumber(v.rank) == 5 then ranka = v.rank_5
				elseif tonumber(v.rank) == 4 then ranka = v.rank_4
				elseif tonumber(v.rank) == 3 then ranka = v.rank_3
				elseif tonumber(v.rank) == 2 then ranka = v.rank_2
				elseif tonumber(v.rank) == 1 then ranka = v.rank_1
				end
		
			dxDrawText('INFORMACJE O UŻYTKOWNIKU', x+math.floor(790/zoom), y-math.floor(140/zoom), x+w, y+h, tocolor(230, 230, 230, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light24'), 'center', 'center', false, false, false, false, false)
			dxDrawText('NICK:', x+math.floor(360/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money18'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['login'], x+math.floor(600/zoom), y+math.floor(40/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('RANGA:', x+math.floor(360/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money18'), 'left', 'center', false, false, false, false, false)
			dxDrawText(ranka, x+math.floor(600/zoom), y+math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('AKTYWNOŚĆ:', x+math.floor(360/zoom), y+math.floor(240/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money18'), 'left', 'center', false, false, false, false, false)
			dxDrawText(v['aktywny'], x+math.floor(600/zoom), y+math.floor(240/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
			dxDrawText('WPŁACIŁ:', x+math.floor(360/zoom), y+math.floor(340/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money18'), 'left', 'center', false, false, false, false, false)
			dxDrawText(przecinek(v['wplacil']..' PLN'), x+math.floor(600/zoom), y+math.floor(340/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light22'), 'left', 'center', false, false, false, false, false)
		end
	end
	
	if windows.vehicles == true then
		dxDrawText('ID', x+math.floor(160/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'left', 'center', false, false, false, false, false)
		dxDrawText('MODEL', x+math.floor(260/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'left', 'center', false, false, false, false, false)
		dxDrawText('SID WŁAŚCICIELA', x+math.floor(730/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'center', 'center', false, false, false, false, false)
		dxDrawText('LOKALIZACJA', x, y-math.floor(153/zoom), x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'right', 'center', false, false, false, false, false)
		xY = 0
		for i,v in ipairs(show_vehicles) do
			if i >= k and i <= n then 
				xY = xY + 1
				local offsetY = math.floor(50/zoom)*(xY-1)
				local offsetYTEXT = math.floor(100/zoom)*(xY-1)
				
				if tonumber(v["parking"]) == 1 then
					location1 = "Przechowalnia pojazdów"
				elseif v["police"] == 1 then
					location1 = "Parking policyjny"
				else
					for k,p in ipairs(getElementsByType("vehicle")) do
						local id = getElementData(p, "vehicle:id")
						if id and id == v["id"] then
							local x,y,z = getElementPosition(p)
							location1 = getZoneName(x,y,z,true)..", "..getZoneName(x,y,z,false)
						end
					end
				end
				
				if isMouseIn(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(710/zoom)) then
					dxDrawRectangle(windowPos.x+math.floor(150/zoom), windowPos.y+math.floor(50/zoom) + offsetY, windowPos.w-math.floor(150/zoom), windowPos.h-math.floor(700/zoom), tocolor(100, 100, 200, 25), false)
				end
				
				local model = exports.nrpg_vehicles:changeName((getVehicleNameFromModel(v["model"])))
				
				dxDrawText(v['id'], x+math.floor(160/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				dxDrawText(model, x+math.floor(260/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'left', 'center', false, false, false, false, false)
				dxDrawText(v['ownedPlayer'], x+math.floor(730/zoom), y-math.floor(55/zoom)+offsetYTEXT, x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'center', 'center', false, false, false, false, false)
				dxDrawText(location1, x, y-math.floor(55/zoom)+offsetYTEXT, x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light19'), 'right', 'center', false, false, false, false, false)
			end
		end
	end
	
	if windows.funds == true then
		dxDrawText('NICK', x+math.floor(160/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'left', 'center', false, false, false, false, false)
		dxDrawText('TYP', x+math.floor(780/zoom), y-math.floor(153/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'center', 'center', false, false, false, false, false)
		dxDrawText('KWOTA', x, y-math.floor(153/zoom), x+w+math.floor(675/zoom), y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money17'), 'right', 'center', false, false, false, false, false)
		exports['nrpg_buttons']:dxCreateButton("Wpłać", windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 1, {55, 155, 55})
		exports['nrpg_buttons']:dxCreateButton("Wypłać", windowPos.x+math.floor(460/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom), 2, {155, 155, 55})
		xY = 0
		for i,v in ipairs(show_atm_logs) do
			if i >= k and i <= n2 then
				xY = xY + 1
				local offsetY = math.floor(66/zoom)*(xY-1)
				
				local ile = v["ile"]
				local typ = v["typ"]
				
				if typ == "Wplata" then typ = "Wpłata" 
				elseif typ == "Wyplata" then typ = "Wypłata"   
				end
				
				if typ == "Wpłata" then ile = "#03fc28+"..przecinek(ile).." PLN" 
				elseif typ == "Wypłata" then ile = "#fc0303"..przecinek(ile).." PLN"   
				end
				
				dxDrawText(v['nick'], x+math.floor(160/zoom), y-math.floor(60/zoom)+offsetY, x+w, y+h, tocolor(230, 230, 230, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light18'), 'left', 'center', false, false, false, false, false)
				dxDrawText(typ, x+math.floor(780/zoom), y-math.floor(60/zoom)+offsetY, x+w, y+h, tocolor(230, 230, 230, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light18'), 'center', 'center', false, false, false, false, false)
				dxDrawText(ile, x, y-math.floor(55/zoom)+offsetY, x+w+math.floor(675/zoom), y+h, tocolor(230, 230, 230, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light18'), 'right', 'center', false, false, false, true, false)
			end
		end
		for i,v in ipairs(show_info) do
			dxDrawText('FUNDUSZE:', x+math.floor(160/zoom), y+math.floor(1240/zoom), x+w, y+h, tocolor(230, 230, 230, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light17'), 'left', 'center', false, false, false, false, false)
			dxDrawText(przecinek(v['kasa'])..' PLN', x+math.floor(290/zoom), y+math.floor(1240/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light17'), 'left', 'center', false, false, false, false, false)
		end
	end
	if windows.message == true then
		dxDrawText('DODAWANIE WIADOMOŚCI', x+math.floor(820/zoom), y-math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money30'), 'center', 'center', false, false, false, false, false)
		dxDrawText('WPISZ WIADOMOŚĆ DO KAŻDEGO CZŁONKA ORGANIZACJI', x+math.floor(840/zoom), y+math.floor(260/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light20'), 'center', 'center', false, false, false, false, false)
		exports['nrpg_buttons']:dxCreateButton("Ustaw", windowPos.x+math.floor(490/zoom), windowPos.y+math.floor(395/zoom), math.floor(170/zoom), math.floor(50/zoom), 1, {25, 144, 255})
	end
	if windows.ranks == true then
		dxDrawText('ZMIANA RANG', x+math.floor(820/zoom), y-math.floor(140/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money30'), 'center', 'center', false, false, false, false, false)
		dxDrawText('USTAW CUSTOMOWĄ NAZWĘ RANGI', x+math.floor(820/zoom), y-math.floor(70/zoom), x+w, y+h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light20'), 'center', 'center', false, false, false, false, false)

			exports['nrpg_buttons']:dxCreateButton("Ustaw", windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(200/zoom), math.floor(150/zoom), math.floor(50/zoom), 1, {55, 155, 55})
			exports['nrpg_buttons']:dxCreateButton("Ustaw", windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(260/zoom), math.floor(150/zoom), math.floor(50/zoom), 2, {55, 155, 55})
			exports['nrpg_buttons']:dxCreateButton("Ustaw", windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(320/zoom), math.floor(150/zoom), math.floor(50/zoom), 3, {55, 155, 55})
			exports['nrpg_buttons']:dxCreateButton("Ustaw", windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(380/zoom), math.floor(150/zoom), math.floor(50/zoom), 4, {55, 155, 55})
			exports['nrpg_buttons']:dxCreateButton("Ustaw", windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(440/zoom), math.floor(150/zoom), math.floor(50/zoom), 5, {55, 155, 55})

			dxDrawText('ABY ZMIENIĆ RANGĘ WPISZ W OKNIE NAZWĘ RANGI\nA NASTĘPNIE KLIKNIJ USTAW', x+math.floor(840/zoom), y+math.floor(1000/zoom), x+w, y+h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont('light20'), 'center', 'center', false, false, false, false, false)

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
						triggerServerEvent("selectUserOrganization", localPlayer, v["uid"])
						windows.selectUser = true
						windows.main = false
						windows.users = false
						windows.funds = false
						windows.message = false
						windows.ranks = false
						exports['nrpg_interface']:destroyCustomEditbox('addUser')
						exports['nrpg_interface']:destroyCustomEditbox('amount')
						exports['nrpg_interface']:destroyCustomEditbox('addMessage')
						exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
						exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
						exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
						exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
						exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
					end
				end
			end
		end
	
		--PRZYCISK INFORMACJI
		if isMouseIn(windowPos.x, windowPos.y, windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) and windows.background == true and windows.main == false then
			windows.users = false
			windows.main = true
			windows.selectUser = false
			windows.vehicles = false
			windows.funds = false
			windows.message = false
			windows.ranks = false
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			exports['nrpg_interface']:destroyCustomEditbox('addMessage')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
		
		--PRZYCISK UCZESTNIKÓW--
		elseif isMouseIn(windowPos.x, windowPos.y+math.floor(50/zoom), windowPos.w-math.floor(900/zoom), math.floor(50/zoom)) and windows.background == true and windows.users == false then
			windows.users = true
			windows.main = false
			windows.selectUser = false
			windows.vehicles = false
			windows.funds = false
			windows.message = false
			windows.ranks = false
			triggerServerEvent("showGuiOrganization", localPlayer)
			exports['nrpg_interface']:createCustomEditbox('addUser', 'Wprowadź login', windowPos.x+math.floor(650/zoom), windowPos.y+math.floor(695/zoom), math.floor(200/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			exports['nrpg_interface']:destroyCustomEditbox('addMessage')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
			
		--PRZYCISK POJAZDÓW--
		elseif isMouseIn(windowPos.x, windowPos.y+math.floor(100/zoom), windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) and windows.background == true and windows.vehicles == false then
			windows.users = false
			windows.main = false
			windows.selectUser = false
			windows.vehicles = true
			windows.funds = false
			windows.message = false
			windows.ranks = false
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showVehiclesOrganization", localPlayer)
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			exports['nrpg_interface']:destroyCustomEditbox('addMessage')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
			
		--PRZYCISK FUNDUSZY--
		elseif isMouseIn(windowPos.x, windowPos.y+math.floor(150/zoom), windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) and windows.background == true and windows.funds == false then
			windows.users = false
			windows.main = false
			windows.selectUser = false
			windows.vehicles = false
			windows.funds = true
			windows.message = false
			windows.ranks = false
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)
			exports['nrpg_interface']:createCustomEditbox('amount', 'Wprowadź kwotę', windowPos.x+math.floor(650/zoom), windowPos.y+math.floor(695/zoom), math.floor(200/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
			exports['nrpg_interface']:destroyCustomEditbox('addMessage')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
			
		--PRZYCISK LIDERA--
		elseif isMouseIn(windowPos.x, windowPos.y+math.floor(200/zoom), windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) and windows.background == true and windows.message == false then
			windows.users = false
			windows.main = false
			windows.selectUser = false
			windows.vehicles = false
			windows.funds = false
			windows.message = true
			windows.ranks = false
			exports['nrpg_interface']:createCustomEditbox('addMessage', 'Wprowadź wiadomość', windowPos.x+math.floor(270/zoom), windowPos.y+math.floor(295/zoom), math.floor(620/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
		--PRZYCISK RANG--
		elseif isMouseIn(windowPos.x, windowPos.y+math.floor(250/zoom), windowPos.w-math.floor(905/zoom), math.floor(50/zoom)) and windows.background == true and windows.ranks == false then
			windows.users = false
			windows.main = false
			windows.selectUser = false
			windows.vehicles = false
			windows.funds = false
			windows.message = false
			windows.ranks = true


			exports['nrpg_interface']:destroyCustomEditbox('addUser')
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			exports['nrpg_interface']:destroyCustomEditbox('addMessage')

			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')

			for i, v in ipairs(show_statistic) do	

			ranka_1 = v.rank_1
			ranka_2 = v.rank_2
			ranka_3 = v.rank_3
			ranka_4 = v.rank_4
			ranka_5 = v.rank_5
			end

			exports['nrpg_interface']:createCustomEditbox('editRank_1', ""..ranka_1.."", windowPos.x+math.floor(175/zoom), windowPos.y+math.floor(200/zoom), math.floor(150/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:createCustomEditbox('editRank_2', ""..ranka_2.."", windowPos.x+math.floor(175/zoom), windowPos.y+math.floor(260/zoom), math.floor(150/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:createCustomEditbox('editRank_3', ""..ranka_3.."", windowPos.x+math.floor(175/zoom), windowPos.y+math.floor(320/zoom), math.floor(150/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:createCustomEditbox('editRank_4', ""..ranka_4.."", windowPos.x+math.floor(175/zoom), windowPos.y+math.floor(380/zoom), math.floor(150/zoom), math.floor(50/zoom), false, "")
			exports['nrpg_interface']:createCustomEditbox('editRank_5', ""..ranka_5.."", windowPos.x+math.floor(175/zoom), windowPos.y+math.floor(440/zoom), math.floor(150/zoom), math.floor(50/zoom), false, "")


		--PRZYCISK DODAWANIA WIADOMOŚĆI--
		elseif isMouseIn(windowPos.x+math.floor(490/zoom), windowPos.y+math.floor(395/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.message == true then
			message = exports['nrpg_interface']:getCustomEditboxText('addMessage')
			if message:len() < 1 or message:len() > 70 then
				exports.nrpg_interface:showPlayerNotification("Wiadomość powinna zawierać do 70 znaków!", "error", 15000)
			return end
			triggerServerEvent("ev",resourceRoot, "addLiderMessageOrganization", message)
		
		elseif isMouseIn(windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(200/zoom), math.floor(150/zoom), math.floor(50/zoom)) and windows.background == true and windows.ranks == true then
			newrank = exports['nrpg_interface']:getCustomEditboxText('editRank_1')
			if newrank:len() < 3 or newrank:len() > 10 then
				exports.nrpg_interface:showPlayerNotification("Nazwa rangi powinna zawierać od 3\ndo 10 znaków", "error", 15000)
			return end
			triggerServerEvent("ev", resourceRoot, "changeRankName", 1, newrank)
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)


		elseif isMouseIn(windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(260/zoom), math.floor(150/zoom), math.floor(50/zoom)) and windows.background == true and windows.ranks == true then
			newrank = exports['nrpg_interface']:getCustomEditboxText('editRank_2')
			if newrank:len() < 3 or newrank:len() > 10 then
				exports.nrpg_interface:showPlayerNotification("Nazwa rangi powinna zawierać od 3\ndo 10 znaków", "error", 15000)
			return end
			triggerServerEvent("ev", resourceRoot, "changeRankName", 2, newrank)
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)

		elseif isMouseIn(windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(320/zoom), math.floor(150/zoom), math.floor(50/zoom)) and windows.background == true and windows.ranks == true then
			newrank = exports['nrpg_interface']:getCustomEditboxText('editRank_3')
			if newrank:len() < 3 or newrank:len() > 10 then
				exports.nrpg_interface:showPlayerNotification("Nazwa rangi powinna zawierać od 3\ndo 10 znaków", "error", 15000)
			return end
			triggerServerEvent("ev", resourceRoot, "changeRankName", 3, newrank)
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)

		elseif isMouseIn(windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(380/zoom), math.floor(150/zoom), math.floor(50/zoom)) and windows.background == true and windows.ranks == true then
			newrank = exports['nrpg_interface']:getCustomEditboxText('editRank_4')
			if newrank:len() < 3 or newrank:len() > 10 then
				exports.nrpg_interface:showPlayerNotification("Nazwa rangi powinna zawierać od 3\ndo 10 znaków", "error", 15000)
			return end
			triggerServerEvent("ev", resourceRoot, "changeRankName", 4, newrank)
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)

		elseif isMouseIn(windowPos.x+math.floor(350/zoom), windowPos.y+math.floor(440/zoom), math.floor(150/zoom), math.floor(50/zoom)) and windows.background == true and windows.ranks == true then
			newrank = exports['nrpg_interface']:getCustomEditboxText('editRank_5')
			if newrank:len() < 3 or newrank:len() > 10 then
				exports.nrpg_interface:showPlayerNotification("Nazwa rangi powinna zawierać od 3\ndo 10 znaków", "error", 15000)
			return end
			triggerServerEvent("ev", resourceRoot, "changeRankName", 5, newrank)
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)

		--PRZYCISK WPŁACENIA FUNDUSZY--
		elseif isMouseIn(windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.funds == true then
            local amount1 = exports['nrpg_interface']:getCustomEditboxText('amount')
			if amount1:len() < 1 then
				exports.nrpg_interface:showPlayerNotification("Wprowadź kwotę!!", "error", 15000)
			return end
            if not amount1 then return end
            local amount = math.floor(amount1)
            if not amount or amount<1 then return end
            if amount > getPlayerMoney() then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error") return end
			triggerServerEvent("ev",resourceRoot, "amtOperationOrganization", amount)
			triggerServerEvent("showAtmOperactionOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)
			windows.main = true
			windows.funds = false
			exports['nrpg_interface']:destroyCustomEditbox('amount')
		--PRZYCISK WYPŁACENIA FUNDUSZY--
		elseif isMouseIn(windowPos.x+math.floor(460/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.funds == true then
            local amount1 = exports['nrpg_interface']:getCustomEditboxText('amount')
			if amount1:len() < 1 then
				exports.nrpg_interface:showPlayerNotification("Wprowadź kwotę!!", "error", 15000)
			return end
            if not amount1 then return end
            local amount=math.floor(amount1)
            if not amount or amount < 1 then return end
            if getPlayerMoney() + amount > 99999999 then return end
			triggerServerEvent("ev",resourceRoot, "amtOperationOrganization", -amount)
			triggerServerEvent("showAtmOperactionOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)
			windows.main = true
			windows.funds = false
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			
		--PRZYCISK DODAWANIA UŻYTKOWNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.users == true then
			player_nickAdd = exports['nrpg_interface']:getCustomEditboxText('addUser')
			triggerServerEvent("ev",resourceRoot, "addUserOrganization", player_nickAdd, organizationName)			
		--PRZYCISK AWANSOWANIA UŻYTKOWNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(870/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.selectUser == true then
			for i, v in ipairs(select_user) do
				triggerServerEvent("ev",resourceRoot, "advanceUserOrganization", v["uid"])
				triggerServerEvent("selectUserOrganization", localPlayer, v["uid"])
			end
		--PRZYCISK DEGRADOWANIA UŻYTKOWNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(670/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.selectUser == true then
			for i, v in ipairs(select_user) do
				triggerServerEvent("ev",resourceRoot, "degradeUserOrganization", v["uid"])
				triggerServerEvent("selectUserOrganization", localPlayer, v["uid"])
			end
		--PRZYCISK WYRZUCENIA UCZESTNIKÓW--
		elseif isMouseIn(windowPos.x+math.floor(470/zoom), windowPos.y+math.floor(695/zoom), math.floor(170/zoom), math.floor(50/zoom)) and windows.background == true and windows.selectUser == true then
			for i, v in ipairs(select_user) do
				triggerServerEvent("ev",resourceRoot, "removeUserOrganization", v["uid"])
			end
			triggerServerEvent("showGuiOrganization", localPlayer)
			windows.main = false
			windows.selectUser = false
			windows.users = true
			windows.vehicles = false
			windows.funds = false
		end
	end
end)

bindKey("f4","down", function()
	if getElementData(localPlayer,"player:organization") then
		if windows.background == false then		
			organizationName = getElementData(localPlayer,"player:organization")
			addEventHandler("onClientRender", root, window)
			triggerServerEvent("ev",resourceRoot, "lastaktywny")
			triggerServerEvent("showGuiOrganization", localPlayer)
			triggerServerEvent("showGuiOrganizationInfo", localPlayer)
			triggerServerEvent("showVehiclesOrganization", localPlayer)
			triggerServerEvent("showAtmOperactionOrganization", localPlayer)
			windows.background = true
			windows.main = true
			windows.users = false
			windows.selectUser = false
			windows.vehicles = false
			windows.funds = false
			windows.message = false
			windows.ranks = false
			showCursor(true,false)
			showChat(false)
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
			--exports['nrpg_interface']:createCustomEditbox('addMessage', 'Wprowadź wiadomość', windowPos.x+math.floor(270/zoom), windowPos.y+math.floor(295/zoom), math.floor(620/zoom), math.floor(50/zoom), false, "")
		else
			removeEventHandler("onClientRender", root, window)
			windows.background = false
			windows.main = false
			windows.ranks = falses
			windows.users = false
			windows.selectUser = false
			showCursor(false)
			showChat(true)
			windows.vehicles = false
			windows.funds = false
			windows.message = false
			exports['nrpg_interface']:destroyCustomEditbox('addMessage')
			exports['nrpg_interface']:destroyCustomEditbox('addUser')
			exports['nrpg_interface']:destroyCustomEditbox('amount')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_1')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_2')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_3')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_4')
			exports['nrpg_interface']:destroyCustomEditbox('editRank_5')
		end
	end
end)

addEvent("showGuiOrganizationClient", true)
addEventHandler("showGuiOrganizationClient", root, function(table)
  show_statistic = table
end)

addEvent("selectUserOrganizationClient", true)
addEventHandler("selectUserOrganizationClient", root, function(table)
  select_user = table
end)

addEvent("showVehiclesOrganizationClient", true)
addEventHandler("showVehiclesOrganizationClient", root, function(table)
  show_vehicles = table
end)

addEvent("showGuiOrganizationInfoClient", true)
addEventHandler("showGuiOrganizationInfoClient", root, function(table)
  show_info = table
end)

addEvent("showAtmOperactionOrganizationClient", true)
addEventHandler("showAtmOperactionOrganizationClient", root, function(table)
  show_atm_logs = table
end)

bindKey("mouse_wheel_down", "both", function()
    if windows.vehicles == true then
        scrollUp()
	elseif windows.users == true then
		scrollUp2()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if windows.vehicles == true then
        scrollDown()
	elseif windows.users == true then
		scrollDown2()
    end
end)



function scrollDown()
	if n == m then return end
	k = k-1
	n = n-1
end

function scrollUp()
	if n >= #show_vehicles then return end
	k = k+1
	n = n+1
end

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