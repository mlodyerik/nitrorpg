local sx, sy = guiGetScreenSize()
local px, py = (sx/1920),(sy/1080)

local guixd = false
local statystykiPracownik = false
local informacje = false
local pracownicyAll = false
local nadawaniekar = false
local logi_hajsu = false
wlaczonexddd = false

local normal27 = dxCreateFont("font/normal.ttf", 27)
local normal25 = dxCreateFont("font/normal.ttf", 25)
local normal22 = dxCreateFont("font/normal.ttf", 22)
local normal19 = dxCreateFont("font/normal.ttf", 19)
local normal18 = dxCreateFont("font/normal.ttf", 18)
local normal14 = dxCreateFont("font/normal.ttf", 14)

local light25 = dxCreateFont("font/light.ttf", 25)
local light23 = dxCreateFont("font/light.ttf", 23)
local light21 = dxCreateFont("font/light.ttf", 21)
local light19 = dxCreateFont("font/light.ttf", 19)
local light15 = dxCreateFont("font/light.ttf", 15)

local gtav = dxCreateFont("font/gtav.ttf", 30)

local k2 = 1
local n2 = 14
local m2 = 14

local n3 = 15
local m3 = 15

local pracownicy_tabelka = {}
local wybranyAdmin = {}
local gracze_tabelka = {}
local pojazdy_tabelka_mapa = {}
local pojazdy_tabelka = {}
local polaczone_konta = 0

pojazdy_text = "Ładowanie..."
zarejestrowani_text = "Ładowanie..."

function gui()
	dxDrawRectangle(250*px, 90*py, 1430*px, 850*py, tocolor(30, 30, 50, 250), false)
	dxDrawRectangle(547*px, 90*py, 5*px, 850*py, tocolor(20, 20, 40, 250), false)
	
	dxDrawRectangle(550*px, 90*py, 1130*px, 850*py, tocolor(10, 10, 20, 225), false)
	
	shadowText("NitroRPG", 315*px, 120*py, 416*px, 174*py, tocolor(255, 255, 255, 255), 1*px, gtav, "left", "center", false, false, false, false, false)

	if inMousein(250*px, 195*py, 297*px, 60*py) then
		dxDrawRectangle(250*px, 195*py, 297*px, 60*py, tocolor(70, 70, 100, 115), false)
	end
	dxDrawText("Administracja", 270*px, 277*py, 416*px, 174*py, tocolor(230, 230, 230, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		
	if inMousein(250*px, 258*py, 297*px, 60*py) then
		dxDrawRectangle(250*px, 258*py, 297*px, 60*py, tocolor(70, 70, 100, 115), false)	
	end
	dxDrawText("Serwer", 270*px, 400*py, 416*px, 174*py, tocolor(230, 230, 230, 255), 1*px, light21, "left", "center", false, false, false, false, false)
	
	if inMousein(250*px, 321*py, 297*px, 60*py) then
		dxDrawRectangle(250*px, 321*py, 297*px, 60*py, tocolor(70, 70, 100, 115), false)
	end
	dxDrawText("Nadawanie kar", 270*px, 523*py, 416*px, 174*py, tocolor(230, 230, 230, 255), 1*px, light21, "left", "center", false, false, false, false, false)

	dxDrawImage(260*px, 900*py, 30*px, 30*py, ":nrpg_interface/img/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if informacje == true then
	local gracze = {}
	local gracz = getElementsByType("player")
	for i,v in ipairs(gracz) do
		if v ~= localPlayer then
			table.insert(gracze, v)
		end
	end

		dxDrawText("Informacje o serwerze", 1400*px,  -140*py, 779*px, 396*py, tocolor(220, 220, 220, 255), 1*px, normal25, "center", "center", false, false, false, false, false)
		dxDrawText("Ilość administracji", 850*px,  170*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText(#pracownicy_tabelka, 1220*px,  170*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		--shadowText("Ilość administracji: "..#pracownicy_tabelka.."", 1400*px,  170*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, normal22, "center", "center", false, false, false, false, false)
		--shadowText("Graczy online: "..(#gracze+1).."", 1400*px,  250*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, normal22, "center", "center", false, false, false, false, false)
		dxDrawText("Graczy online", 850*px,  290*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText((#gracze+1), 1220*px,  290*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText("Zarejestrowanych kont", 850*px,  410*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText(zarejestrowani_text, 1220*px,  410*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText("Połączone konta", 850*px,  530*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText(polaczone_konta, 1220*px,  530*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText("Pojazdy na mapie", 850*px,  650*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		dxDrawText(pojazdy_text, 1220*px, 650*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		--shadowText(zarejestrowani_text, 1400*px,  330*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, normal22, "center", "center", false, false, false, false, false)
		--shadowText(pojazdy_text, 1400*px,  410*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, normal22, "center", "center", false, false, false, false, false)

		--shadowText("Ilość zarejestrowanych kont: "..#gracze_tabelka.."", 1400*px,  330*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, normal22, "center", "center", false, false, false, false, false)
		--shadowText("Pojazdy: "..#pojazdy_tabelka.."", 1400*px,  410*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, normal22, "center", "center", false, false, false, false, false)
	end
	if pracownicyAll == true then 
		local x2 = 0 
		dxDrawRectangle(550*px, 90*py, 1130*px, 70*py, tocolor(50, 50, 70, 70), false)
		dxDrawRectangle(550*px, 156*py, 1130*px, 4*py, tocolor(255, 255, 0, 155), false)
		
		dxDrawRectangle(550*px, 880*py, 1130*px, 60*py, tocolor(50, 50, 70, 70), false)
		
	   dxDrawText("NICK", 575*px,  -145*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light21, "left", "center", false, false, false, false, false)
	   dxDrawText("REPORTY", 850*px,  -145*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light21, "left", "center", false, false, false, false, false)
	   dxDrawText("RANGA", 1130*px,  -145*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light21, "left", "center", false, false, false, false, false)
	   dxDrawText("DATA PRZYJĘCIA", 1350*px,  -145*py, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light21, "left", "center", false, false, false, false, false)
	   dxDrawText("Ilość administracji: "..#pracownicy_tabelka.."", 575*px,  1426*py, 779*px, 396*py, tocolor(220, 220, 220, 255), 1*px, light19, "left", "center", false, false, false, false, false)
	   for i,v in ipairs(pracownicy_tabelka) do
			local level = v["level"]
			if level == 5 then level = "Owner" 
			elseif level == 4 then level = "Administrator RCON" 
			elseif level == 3 then level = "Administrator" 
			elseif level == 2 then level = "Moderator" 
			elseif level == 1 then level = "Support" 
			end
            if i >= k2 and i <= n2 then 
                x2 = x2 + 1
                local dodatekY = (51*py)*(x2-1)
                local dodatekY2 = (101.6*py)*(x2-1)	
				if inMousein(550*px, 160*py + dodatekY, 1130*px, 50*py) then
					dxDrawRectangle(550*px, 160*py + dodatekY, 1130*px, 50*py, tocolor(160, 160, 160, 20), false)
				end
				dxDrawText(v["reporty"], 850*px,  -24*py + dodatekY2, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light19, "left", "center", false, false, false, false, false)
				dxDrawText(""..v.date.."", 575*px,  -24*py + dodatekY2, 779*px, 396*py, tocolor(220, 220, 220, 255), 1*px, light19, "left", "center", false, false, false, false, false)
				dxDrawText(level, 1130*px,  -24*py + dodatekY2, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light19, "left", "center", false, false, false, false, false)
				dxDrawText(v["added"], 1350*px,  -24*py + dodatekY2, 779*px, 396*py, tocolor(255, 255, 255, 255), 1*px, light19, "left", "center", false, false, false, false, false)
			end
		end
	end
	if statystykiPracownik == true then 
	for i, v in ipairs(wybranyAdmin) do
			local level = v["level"]
			if level == 5 then level = "Owner" 
			elseif level == 4 then level = "Administrator RCON" 
			elseif level == 3 then level = "Administrator" 
			elseif level == 2 then level = "Moderator" 
			elseif level == 1 then level = "Support" 
			end
			dxDrawText(v["date"], 950*px,  -80*py, 779*px, 396*py, tocolor(245, 245, 245, 255), 1*px, normal27, "left", "center", false, false, false, false, false)
			dxDrawText("SID", 950*px,  50*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText(v["uid"], 1230*px,  50*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText("Ranga", 950*px,  140*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText(level, 1230*px,  140*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText("Data przyjęcia", 950*px,  230*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText(v["added"], 1230*px,  230*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText("Przyjęte raporty", 950*px,  320*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
			dxDrawText(v["reporty"], 1230*px,  320*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1*px, light21, "left", "center", false, false, false, false, false)
		end
	end
	
	if nadawaniekar == true then
		dxDrawText("Nadawanie kary", 1400*px,  -140*py, 779*px, 396*py, tocolor(220, 220, 220, 255), 1*px, normal25, "center", "center", false, false, false, false, false)
		exports.nrpg_buttons:dxCreateButton('MUTE', 680*px,  750*py, 250*px, 90*py, 1)
		exports.nrpg_buttons:dxCreateButton('PRAWKO', 980*px,  750*py, 250*px, 90*py, 2)
		exports.nrpg_buttons:dxCreateButton('BAN', 1280*px,  750*py, 250*px, 90*py, 3)
		exports.nrpg_buttons:dxCreateButton('PERM', 1480*px,  850*py, 180*px, 70*py, 4)
		dxDrawText("Pamiętaj by wpisać dokładne dane", 1400*px, 800*py, 779*px, 396*py, tocolor(220, 220, 220, 255), 1*px, light23, "center", "center", false, false, false, false, false)
		dxDrawText("Nadawanie kary działa tylko wtedy jeśli gracz jest offline", 1400*px, 950*py, 779*px, 396*py, tocolor(220, 220, 220, 255), 1*px, light23, "center", "center", false, false, false, false, false)
	end
end

bindKey("f6","down", function()
	if getElementData(localPlayer,"player:admin") then
		if wlaczonexddd == false then		
			triggerServerEvent("pokazPracownikowBiznes", localPlayer)
			addEventHandler("onClientRender", root, gui)
			showCursor(true)
			showChat(false)
			guixd = true
			pracownicyAll = true
			wlaczonexddd = true
			nadawaniekar = false
			mute = false
			exports['nrpg_interface']:destroyCustomEditbox('uid')
			exports['nrpg_interface']:destroyCustomEditbox('nick')
			exports['nrpg_interface']:destroyCustomEditbox('powod')
			exports['nrpg_interface']:destroyCustomEditbox('Czas')
			exports['nrpg_interface']:destroyCustomEditbox('serial')
			exports['nrpg_interface']:destroyCustomEditbox('jednostka')
		else
			removeEventHandler("onClientRender", root, gui)
			showCursor(false)
			showChat(true)
			guixd = false
			pracownicyAll = false
			wlaczonexddd = false
			informacje = false
			statystykiPracownik = false
			nadawaniekar = false
			mute = false
			exports['nrpg_interface']:destroyCustomEditbox('uid')
			exports['nrpg_interface']:destroyCustomEditbox('nick')
			exports['nrpg_interface']:destroyCustomEditbox('powod')
			exports['nrpg_interface']:destroyCustomEditbox('Czas')
			exports['nrpg_interface']:destroyCustomEditbox('serial')
			exports['nrpg_interface']:destroyCustomEditbox('jednostka')
		end
	end
end)

addEventHandler("onClientClick", root, function(btn, state, plr)
	if btn == "left" and state == "down" then
		if guixd == true and pracownicyAll == true then
			local x2 = 0
			for i, v in ipairs(pracownicy_tabelka) do
				if i >= k2 and i <= n2 then 
					x2 = x2 + 1
					local dodatekY = (51*py)*(x2-1)
					if inMousein(550*px, 160*py + dodatekY, 1130*px, 50*py) and guixd == true and pracownicyAll == true then
						if v["date"] then
							triggerServerEvent("wybranyAdmin", localPlayer, v["uid"])
							statystykiPracownik = true
							pracownicyAll = false
							informacje = false
							zamawianie = false
							magazyn = false
							nadawaniekar = false
							mute = false
						end
					end
				end
			end
		end
		
			local uid=exports['nrpg_interface']:getCustomEditboxText('uid')
			local nick=exports['nrpg_interface']:getCustomEditboxText('nick')
			local serial=exports['nrpg_interface']:getCustomEditboxText('serial')
			local powod=exports['nrpg_interface']:getCustomEditboxText('powod')
			local czas=exports['nrpg_interface']:getCustomEditboxText('Czas')
			local jednostka=exports['nrpg_interface']:getCustomEditboxText('jednostka')
		
		--INFORMACJE
		if inMousein(250*px, 258*py, 297*px, 60*py) and guixd == true and informacje == false then
			triggerServerEvent("pokazPracownikowBiznes", localPlayer)
			triggerServerEvent("graczePanelAdm", localPlayer)
			triggerServerEvent("pojazdyPrzechoPanelAdm", localPlayer)
			triggerServerEvent("pojazdyPanelAdm", localPlayer)
			triggerServerEvent("sumaKontDiscord", localPlayer)
			pojazdy_text = "Ładowanie..."
			zarejestrowani_text = "Ładowanie..."
			pracownicyAll = false
			statystykiPracownik = false
			informacje = true
			zamawianie = false
			magazyn = false
			nadawaniekar = false
			mute = false
			exports['nrpg_interface']:destroyCustomEditbox('uid')
			exports['nrpg_interface']:destroyCustomEditbox('nick')
			exports['nrpg_interface']:destroyCustomEditbox('powod')
			exports['nrpg_interface']:destroyCustomEditbox('Czas')
			exports['nrpg_interface']:destroyCustomEditbox('serial')
			exports['nrpg_interface']:destroyCustomEditbox('jednostka')
		elseif inMousein(1450*px, 820*py, 200*px, 68*py) and guixd == true and statystykiPracownik == true then
			triggerServerEvent("pokazPracownikowBiznes", localPlayer)
			pracownicyAll = true
			statystykiPracownik = false
			informacje = false
			zamawianie = false
			magazyn = false
			nadawaniekar = false
			mute = false
			exports['nrpg_interface']:destroyCustomEditbox('uid')
			exports['nrpg_interface']:destroyCustomEditbox('nick')
			exports['nrpg_interface']:destroyCustomEditbox('powod')
			exports['nrpg_interface']:destroyCustomEditbox('Czas')
			exports['nrpg_interface']:destroyCustomEditbox('serial')
			exports['nrpg_interface']:destroyCustomEditbox('jednostka')
			
		--WSZYSCY PRACOWNICY	
		elseif inMousein(250*px, 195*py, 297*px, 60*py) and guixd == true and pracownicyAll == false then
			triggerServerEvent("pokazPracownikowBiznes", localPlayer)
			pracownicyAll = true
			statystykiPracownik = false
			informacje = false
			zamawianie = false
			magazyn = false
			nadawaniekar = false
			mute = false
			exports['nrpg_interface']:destroyCustomEditbox('uid')
			exports['nrpg_interface']:destroyCustomEditbox('nick')
			exports['nrpg_interface']:destroyCustomEditbox('powod')
			exports['nrpg_interface']:destroyCustomEditbox('Czas')
			exports['nrpg_interface']:destroyCustomEditbox('serial')
			exports['nrpg_interface']:destroyCustomEditbox('jednostka')
			
			--NADAWANIE KAR--
		elseif inMousein(250*px, 321*py, 297*px, 60*py) and guixd == true and nadawaniekar == false then
			pracownicyAll = false
			statystykiPracownik = false
			informacje = false
			zamawianie = false
			magazyn = false
			nadawaniekar = true
			mute = false
			exports['nrpg_interface']:createCustomEditbox('uid', 'Wpisz SID', 880*px,  190*py, 450*px, 40*py, false, "")
			exports['nrpg_interface']:createCustomEditbox('nick', 'Wpisz nick', 880*px,  250*py, 450*px, 40*py, false, "")
			exports['nrpg_interface']:createCustomEditbox('powod', 'Powód', 880*px,  310*py, 450*px, 40*py, false, "")
			exports['nrpg_interface']:createCustomEditbox('Czas', 'Czas np. 5', 880*px,  370*py, 450*px, 40*py, false, "")
			exports['nrpg_interface']:createCustomEditbox('jednostka', 'Wpisz jednostke (m, h, d, w (miesiąc))', 880*px,  430*py, 450*px, 40*py, false, "")
			exports['nrpg_interface']:createCustomEditbox('serial', 'Serial', 880*px,  480*py, 450*px, 40*py, false, "")
			
		elseif inMousein(680*px,  750*py, 250*px, 90*py) and guixd == true and nadawaniekar == true then
			if serial:len() < 1 then return end
			if powod:len() < 1 then return end
			if jednostka:len() < 1 then return end
			if czas:len() < 1 then return end
			if nick:len() < 1 then return end
			if uid:len() < 1 then return end
			triggerServerEvent("ev",resourceRoot,"mute", serial, powod, czas, jednostka, nick, uid)
			
		elseif inMousein(980*px,  750*py, 250*px, 90*py) and guixd == true and nadawaniekar == true then
			if serial:len() < 1 then return end
			if powod:len() < 1 then return end
			if jednostka:len() < 1 then return end
			if czas:len() < 1 then return end
			if nick:len() < 1 then return end
			if uid:len() < 1 then return end
			triggerServerEvent("ev",resourceRoot,"prawko", serial, powod, czas, jednostka, nick, uid)
			
		elseif inMousein(1280*px,  750*py, 250*px, 90*py) and guixd == true and nadawaniekar == true then
			if serial:len() < 1 then return end
			if powod:len() < 1 then return end
			if jednostka:len() < 1 then return end
			if czas:len() < 1 then return end
			if nick:len() < 1 then return end
			if uid:len() < 1 then return end
			triggerServerEvent("ev",resourceRoot,"ban", serial, powod, czas, jednostka, nick, uid)
			
		elseif inMousein(1480*px,  850*py, 180*px, 70*py) and guixd == true and nadawaniekar == true then
			if serial:len() < 1 then return end
			if powod:len() < 1 then return end
			--if jednostka:len() < 1 then return end
			--if czas:len() < 1 then return end
			if nick:len() < 1 then return end
			if uid:len() < 1 then return end
			triggerServerEvent("ev",resourceRoot,"perm", serial, powod, czas, jednostka, nick, uid)
		
			--ZAMKNIECIE GUI
		elseif inMousein(260*px, 900*py, 30*px, 30*py) and guixd == true then
			removeEventHandler("onClientRender", root, gui)
			guixd = false
			pracownicyAll = false
			statystykiPracownik = false
			informacje = false
			zamawianie = false
			magazyn = false
			mute = false
			nadawaniekar = false
			showChat(true)
			showCursor(false)
			exports['nrpg_interface']:destroyCustomEditbox('uid')
			exports['nrpg_interface']:destroyCustomEditbox('nick')
			exports['nrpg_interface']:destroyCustomEditbox('powod')
			exports['nrpg_interface']:destroyCustomEditbox('Czas')
			exports['nrpg_interface']:destroyCustomEditbox('serial')
			exports['nrpg_interface']:destroyCustomEditbox('jednostka')
		end
	end
end)

addEvent("pokazPracownikowBiznesClient", true)
addEventHandler("pokazPracownikowBiznesClient", root, function(tabelka)
  pracownicy_tabelka = tabelka
end)

addEvent("graczePanelAdmClient", true)
addEventHandler("graczePanelAdmClient", root, function(tabelka)
  gracze_tabelka = tabelka
  zarejestrowani_text = ""..(#gracze_tabelka+17)..""
end)

addEvent("wybranyAdminClient", true)
addEventHandler("wybranyAdminClient", root, function(tabelka)
  wybranyAdmin = tabelka
end)

addEvent("pojazdyPanelAdmClient", true)
addEventHandler("pojazdyPanelAdmClient", root, function(tabelka)
  pojazdy_tabelka = tabelka
  pojazdy_text = ""..#pojazdy_tabelka_mapa.." / "..#pojazdy_tabelka..""
end)

addEvent("pojazdyPrzechoPanelAdmClient", true)
addEventHandler("pojazdyPrzechoPanelAdmClient", root, function(tabelka)
  pojazdy_tabelka_mapa = tabelka
end)

addEvent("sumaPolaczonychKont", true)
addEventHandler("sumaPolaczonychKont", root, function(tabelka)
  polaczone_konta = #tabelka
end)

bindKey("mouse_wheel_down", "both", function()
    if pracownicyAll == true then
        scrollUp2()
	end
end)

bindKey("mouse_wheel_up", "both", function()
    if pracownicyAll == true then
        scrollDown2()
	end
end)

function scrollDown()
    if n3 == m2 then return end
    k2 = k2-1
    n3 = n3-1
end

function scrollDown1()
    if n3 == m2 then return end
    k2 = k2-1
    n3 = n3-1
end

function scrollDown2()
    if n2 == m2 then return end
    k2 = k2-1
    n2 = n2-1
end

function scrollUp2()
    if n2 >= #pracownicy_tabelka then return end
    k2 = k2+1
    n2 = n2+1
end

function scrollDown3()
    if n3 == m2 then return end
    k2 = k2-1
    n3 = n3-1
end

function inMousein(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function sort(parametr1, parametr2)
	if isElement(parametr1) and isElement(parametr2) then
		return (getElementData(parametr1, "id") or 0) < (getElementData(parametr2, "id") or 0)
	end
end

function przecinek(xd)
	local left,num,right = string.match(xd,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+2,y+2,w,h,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end