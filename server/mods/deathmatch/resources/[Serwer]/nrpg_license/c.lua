local screenW, screenH = guiGetScreenSize()
local w, h = screenW/1366, screenH/768

local sw,sh = guiGetScreenSize()
local zoom = 1
if sw < 1366 then
    zoom = math.min(2, 1366 / sw)
end

local licences = {	
	{1009.19, -1556.77, 29.90},
	{1009.44, -1559.70, 29.90},
	{1007.50, -1559.78, 29.90},
	{1005.38, -1559.78, 29.90},
	{1007.67, -1556.91, 29.90},
	{1005.55, -1556.91, 29.90},
}


for _, v in ipairs(licences) do
		local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 0.85, 255, 255, 0, 25)
		setElementDimension(marker, 2137)
		setElementData(marker, "marker:text", "Zdawanie prawa jazdy")
end

local questions_b = {
	{question="Czy jeśli nie zapniesz pasa bezpieczeństwa możesz\nkierować pojazdem?", git="Nie"},
	{question="Czy musisz posiadać gaśnicę w swoim pojeżdzie?", git="Tak"},
	{question="Czy pędząc 200 km/h możesz potrącić teściową?", git="Nie"},
	{question="Czy możesz poruszać się pojazdem nie posiadając\nprawa jazdy?", git="Nie"},
	{question="Czy jeśli uczestniczyłeś/aś w wypadku samochodowym\nmasz prawo usuwać jego skutki?", git="Nie"},
	{question="Czy kierowca ma obowiązek posiadania\napteczki pierwszej pomocy w samochodzie?", git="Tak"},
	{question="Czy wolno Ci holować pojazd, którym kieruje\nosoba po użyciu alkoholu?", git="Nie"},
	{question="Czy wolno zatrzymać Ci pojazd, tuż za przejazdem kolejowym?", git="Nie"},
	{question="Czy możesz nagle zawrócić na autostradzie?", git="Nie"},
}
local question_b = 1
local punkty_b = 0

local questions_c = {
	{question="Czy poduszka powietrzna spełni swoją funkcję\nw czasie wypadku, jeżeli nie zapniesz pasów bezpieczeństwa?", git="Nie"},
	{question="Czy cofając masz obowiązek zachować szczególną ostrożność?", git="Tak"},
	{question="Czy masz obowiązek odpowiednio sygnalizować postój\nuszkodzonego pojazdu na powierzchni wyłączonej z ruchu?", git="Tak"},
	{question="Czy możesz nagle zawrócić na autostradzie?", git="Nie"},
	{question="Czy tylko kierowca jest zobowiązany do zapięcia\npasów bezpieczeństwa podczas jazdy?", git="Nie"},
	{question="Czy masz prawo zabezpieczyć miejsce wypadku\ndo którego dojechałeś, ustawiając odpowiednio swój\nsamochód i włączając światła awaryjne?", git="Tak"},
	{question="Czy wolno Ci holować pojazd, którym kieruje\nosoba po użyciu alkoholu?", git="Nie"},
	{question="Czy kierowca ma obowiązek posiadania\napteczki pierwszej pomocy w samochodzie?", git="Nie"},
	{question="Czy do manewru zawracania używamy takiej samej sygnalizacji\n(kierunkowskazów) jak w przypadku manewru skręcania?", git="Tak"},
}
local question_c = 1
local punkty_c = 0

local questions_a = {
	{question="Czy możesz wykonywać różne akrobacje na motocyklu\njadąc autostradą?", git="Nie"},
	{question="Czy cofając masz obowiązek zachować szczególną ostrożność?", git="Tak"},
	{question="Czy masz obowiązek odpowiednio sygnalizować postój\nuszkodzonego pojazdu na powierzchni wyłączonej z ruchu?", git="Tak"},
	{question="Czy możesz nagle zawrócić na autostradzie?", git="Nie"},
	{question="Czy jeśli jedziesz 100 km/h możesz potrącić teściową", git="Nie"},
	{question="Czy masz prawo zabezpieczyć miejsce wypadku\ndo którego dojechałeś, ustawiając odpowiednio swój\nsamochód i włączając światła awaryjne?", git="Tak"},
	{question="Czy wolno Ci holować pojazd, którym kieruje\nosoba po użyciu alkoholu?", git="Nie"},
	{question="Czy kierowca ma obowiązek posiadania\napteczki pierwszej pomocy w samochodzie?", git="Nie"},
	{question="Czy do manewru zawracania używamy takiej samej sygnalizacji\n(kierunkowskazów) jak w przypadku manewru skręcania?", git="Tak"},
}

local question_a = 1
local punkty_a = 0

windows = {
	main = false,
	questionKatB = false,
	questionKatC = false,
	questionKatA = false,
	questionKatL = false,
}

animations = {
	alpha220= 0,
	alpha255 = 0,
	alpha255 = 0,
}

local kurs = ""

local punkt = 1
local marker = false
local blip = false

addEventHandler("onClientMarkerHit", resourceRoot, function(plr)
	if plr ~= localPlayer then return end
	main.toggleGUI = true
	windows.questionKatB = false
	windows.questionKatC = false
	windows.questionKatA = false
	windows.questionKatL = false
	main.actualCategory = nil
	main.actualPage = "Główna"
	showCursor(true)
	guiSetVisible(tak, false)
	guiSetVisible(nie, false)
	guiCheckBoxSetSelected(tak, false)
	guiCheckBoxSetSelected(nie, false)
	addEventHandler("onClientRender", root, main.renderGUI)
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(plr)
	if plr ~= localPlayer then return end
	main.toggleGUI = false
	windows.questionKatB = false
	windows.questionKatC = false
	windows.questionKatA = false
	windows.questionKatL = false
	main.actualCategory = nil
	main.actualPage = "Główna"
	guiSetVisible(tak, false)
	guiSetVisible(nie, false)
	guiCheckBoxSetSelected(tak, false)
	guiCheckBoxSetSelected(nie, false)
	showCursor(false)
	removeEventHandler("onClientRender", root, main.renderGUI)
end)

tak = guiCreateCheckBox(730*w, 450*h, 262*w, 27*h, "Tak", false, false)
nie = guiCreateCheckBox(820*w, 450*h, 262*w, 27*h, "Nie", false, false) 
guiSetVisible(tak, false)
guiSetVisible(nie, false)

addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == tak then
		if guiCheckBoxGetSelected(nie) == true then
			guiCheckBoxSetSelected(nie, false)
		end
	elseif source == nie then
		if guiCheckBoxGetSelected(tak) == true then
			guiCheckBoxSetSelected(tak, false)
		end
	end
end)


main = {

	getLib = exports.nrpg_lib,
	toggleGUI = false,
	actualPage = "Główna",
	actualCategory = nil,

}

interface = {

	backgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(35, 35, 35, 255)),
    backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(255, 175, 0, 255)),
    shapeRectangle = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(45, 45, 45, 255)),
    shapeButtonRectangle = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(100, 100, 100, 40)),
    addRectangle = main.getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(0, 155, 0, 255)),
    invitesRectangle = main.getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(152, 3, 252, 255)),
	statusRectangle = main.getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(252, 115, 3, 255)),
    scrollRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 100, 255)),
    scrollRectangle2 = main.getLib:dgsCreateRoundRect({{3,false},{3,false},{3,false},{3,false}},tocolor(255, 175, 0, 255)),
    chatRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(155, 200, 200, 200)),
	friendAcceptRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(0, 144, 255, 255)),
    friendDeleteRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 0, 0, 255)),
    customButton = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(30, 30, 50, 255)),
    customButton2 = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(80, 80, 160, 255)),
    vehicleRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(75, 75, 75, 255)),
    caseRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 255, 255, 255)),
    itemRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 255, 255, 255)),

}

menu = {

    {"Główna", "Informacje nt. prawa jazdy", "Tutaj dowiesz się co i jak"},
	{"Zdawanie", "Zdaj prawo jazdy!", "Wybierz kategorię i zdaj prawo jazdy!"},
	{"Zamknij", "Zamknij panel", "Zamyka panel kurwa ten"},

}

licenses = {

    [1] = {

        cost = 0,
        name = "A",

    },

    [2] = {

        cost = 0,
        name = "B",

    },

    [3] = {

        cost = 0,
        name = "C",

    }

}

local kmenu = 1
local nmenu = 6
local mmenu = 6

main.renderGUI = function()   
	dxDrawImage(336*w, 190*h, 694*w, 410*h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(337*w, 191*h, 692*w, 408*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(344*w, 205*h, 218*w, 59*h, interface.shapeRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(344*w, 280*h, 218*w, 305*h, interface.shapeRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(570*w, 205*h, 450*w, 380*h, interface.shapeRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

	dxDrawImage(570*w, 205*h, 450*w, 45*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

    exports["nrpg_avatars"]:dxCreateAvatar(350*w, 210*h, 50*w, 50*h, 255)

    dxDrawText(getPlayerName(localPlayer), 412*w, 213*h, 536*w, 234*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
    dxDrawText("Zdawanie prawa jazdy", 412*w, 234*h, 536*w, 255*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)

	x = 0
    for i,v in ipairs(menu) do
        if i >= kmenu and i <= nmenu then 
            x = x + 1
            local offsetY = math.floor(50*h)*(x-1)
            local offsetY2 = offsetY*2

            if main.actualPage == v[1] then
				dxDrawText(v[1], 577*w, 205*h, 816*w, 228*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
    			dxDrawText(v[3], 577*w, 228*h, 816*w, 251*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)

                dxDrawImage(348*w, (285*h)+offsetY, 210*w, 45*h, interface.shapeButtonRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText(v[1], 360*w, (284*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                dxDrawText(v[2], 360*w, (308*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
            elseif isMouseIn(348*w, (285*h)+offsetY, 210*w, 45*h) and actualPage ~= v[1] then
                dxDrawImage(348*w, (285*h)+offsetY, 210*w, 45*h, interface.shapeButtonRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText(v[1], 360*w, (284*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 165), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                dxDrawText(v[2], 360*w, (308*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 185), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
            else
                dxDrawImage(348*w, (285*h)+offsetY, 210*w, 45*h, interface.shapeButtonRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
                dxDrawText(v[1], 360*w, (284*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 185), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                dxDrawText(v[2], 360*w, (308*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
            end
        end
    end


	if main.actualPage == "Główna" then
		dxDrawText("Witaj drogi graczu, z nami zdasz swoje prawo jazdy!\n\nNa początek najlepiej zdać sobie kat. B ponieważ z tą kategorią możesz\nprowadzić większość pojazdów, możesz także zdać kat. B, dzięki której możesz\npracować np. na lawetach.\n\nKażda kategoria posiada swój zestaw pytań udzielenie odpowiedzi na\n3/4 tych pytań wiąże się z zdanym testem, wtedy nastąpi przeniesienie na drogę\ngdzie musisz zdać egzamin teorytyczny, po jego zdaniu\nmożesz cieszyć się swoim prawem jazdy!", 579*w, 261*h, 1010*w, 571*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "center", false, false, false, false, false)
	end
	
	if main.actualPage == "Zdawanie" then
		x_license = 0
        for i, v in ipairs(licenses) do
            x_license = x_license + 1
            packOffset = (107*w)*(x_license-1)
            packOffset2 = packOffset*2
            
			if main.actualCategory == v.name then
				dxDrawImage(585*w+packOffset, 268*h, 100*w, 100*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                dxDrawImage(585*w+packOffset, 268*h, 100*w, 80*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 110), false)
				dxDrawImage(602*w+packOffset, 282*h, 65*w, 65*h, "img/category_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			elseif isMouseIn(585*w+packOffset, 268*h, 100*w, 100*h) then
                dxDrawImage(585*w+packOffset, 268*h, 100*w, 100*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 90), false)
                dxDrawImage(585*w+packOffset, 268*h, 100*w, 80*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
				dxDrawImage(602*w+packOffset, 282*h, 65*w, 65*h, "img/category_icon.png", 0, 0, 0, tocolor(255, 175, 0, 200), false)
            else
                dxDrawImage(585*w+packOffset, 268*h, 100*w, 100*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 65), false)
                dxDrawImage(585*w+packOffset, 268*h, 100*w, 80*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)
				dxDrawImage(602*w+packOffset, 282*h, 65*w, 65*h, "img/category_icon.png", 0, 0, 0, tocolor(255, 175, 0, 155), false)
            end
			
			dxDrawText(v.cost.." PLN", 658*w, 273*h, 679*w+packOffset, 296*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "top", false, false, true, false, false)
            dxDrawText(v.name, 970*w+packOffset2, 615*h, 300*w, 100*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
        end
		
		if windows.questionKatA == true then
			dxDrawText(questions_a[question_a].question, 586*w, 350*h, 1010*w, 483*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
			exports["nrpg_buttons"]:dxCreateButton("Dalej", 720*w, 509*h, 152*w, 44*h, 1, {65, 200, 65, 255})
		end
	
		if windows.questionKatB == true then
			dxDrawText(questions_b[question_b].question, 586*w, 417*h, 1010*w, 483*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
			exports["nrpg_buttons"]:dxCreateButton("Dalej", 720*w, 509*h, 152*w, 44*h, 1, {65, 200, 65, 255})
		end
		
		
		if windows.questionKatC == true then
			dxDrawText(questions_c[question_c].question, 586*w, 417*h, 1010*w, 483*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
			exports["nrpg_buttons"]:dxCreateButton("Dalej", 720*w, 509*h, 152*w, 44*h, 1, {65, 200, 65, 255})
		end
	end
end


addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "up" then
		if main.toggleGUI == true then

			x_license = 0
        	for i, v in ipairs(licenses) do
            	x_license = x_license + 1
            	packOffset = (107*w)*(x_license-1)
            	packOffset2 = packOffset*2

				if isMouseIn(585*w+packOffset, 268*h, 100*w, 100*h) and windows.questionKatA == false and windows.questionKatB == false and windows.questionKatC == false then
					if v.name == "A" then
						if getElementData(localPlayer, "player:license:pjA") == 1 then
								exports.nrpg_interface:showPlayerNotification("Posiadasz już prawo jazdy kategorii A.", "error", 15000)
							return
						end

						windows.questionKatA = true
						windows.questionKatB = false
						windows.questionKatC = false
						main.actualCategory = v.name
						guiSetVisible(tak, true)
						guiSetVisible(nie, true)
					elseif v.name == "B" then
						if getElementData(localPlayer, "player:license:pjB") == 1 then
								exports.nrpg_interface:showPlayerNotification("Posiadasz już prawo jazdy kategorii B.", "error", 15000)
							return
						end

						windows.questionKatB = true
						windows.questionKatC = false
						windows.questionKatA = false
						main.actualCategory = v.name
						guiSetVisible(tak, true)
						guiSetVisible(nie, true)
					elseif v.name == "C" then
						if getElementData(localPlayer, "player:license:pjC") == 1 then
								exports.nrpg_interface:showPlayerNotification("Posiadasz już prawo jazdy kategorii C.", "error", 15000)
							return 
						end

						windows.questionKatC = true
						windows.questionKatA = false
						windows.questionKatB = false
						main.actualCategory = v.name
						guiSetVisible(tak, true)
						guiSetVisible(nie, true)
					end
				end
        	end

			if isMouseIn(858*w, 509*h, 152*w, 44*h) and main.actualPage == "Zdawanie" then
				if windows.questionKatA == true then
					if windows.questionKatA == true then
						odpowiedz = "?"
					end
					if guiCheckBoxGetSelected(tak) == true then
						odpowiedz = "Tak"
					elseif guiCheckBoxGetSelected(nie) == true then
						odpowiedz = "Nie"
					end
		
					if not guiCheckBoxGetSelected(tak) and not guiCheckBoxGetSelected(nie) then
							exports.nrpg_interface:showPlayerNotification("Najpierw wybierz odpowiedź.", "error", 15000)
						return
					end
		
					if odpowiedz == questions_a[question_a].git then
						punkty_a = punkty_a+1
					end
			
					if not questions_a[question_a+1] then
						if punkty_a >= #questions_a-2 then
							exports.nrpg_interface:showPlayerNotification("Uzyskałeś/aś wynik: "..punkty_a.."/"..#questions_a.." punktów i zdałeś egzamin teoretyczny.", "success", 15000)
							exports.nrpg_interface:showPlayerNotification("Teraz zdaj egzamin praktyczny aby otrzymać wybraną licencje.", "info", 15000)
							question_a = 1
							punkty_a = 0
							setElementInterior(localPlayer, 0)
							triggerServerEvent("license:do", resourceRoot, localPlayer, "A")
						else
							exports.nrpg_interface:showPlayerNotification("Uzyskałeś/aś wynik: "..punkty_a.."/"..#questions_a.." punktów i nie udało ci się zdać egzaminu teortycznego.", "error", 15000)
							question_a = 1
							punkty_a = 0
						end
						question_a = 1
						removeEventHandler("onClientRender", root, main.renderGUI)
						showCursor(false)
						guiSetVisible(tak, false)
						guiSetVisible(nie, false)
						windows.main = false
						windows.questionKatB = false
						windows.questionKatC = false
						windows.questionKatA = false
						main.actualCategory = nil
					else
						question_a = question_a+1
						guiCheckBoxSetSelected(tak, false)
						guiCheckBoxSetSelected(nie, false)
					end	
				elseif windows.questionKatB == true then
					if windows.questionKatB == true then
						odpowiedz = "?"
					end
					if guiCheckBoxGetSelected(tak) == true then
						odpowiedz = "Tak"
					elseif guiCheckBoxGetSelected(nie) == true then
						odpowiedz = "Nie"
					end
		
					if not guiCheckBoxGetSelected(tak) and not guiCheckBoxGetSelected(nie) then
							exports.nrpg_interface:showPlayerNotification("Najpierw wybierz odpowiedź.", "error", 15000)
						return
					end
		
					if odpowiedz == questions_b[question_b].git then
						punkty_b = punkty_b+1
					end
				
					if not questions_b[question_b+1] then
						if punkty_b >= #questions_b-2 then
							exports.nrpg_interface:showPlayerNotification("Uzyskałeś/aś wynik: "..punkty_b.."/"..#questions_b.." punktów i zdałeś egzamin teoretyczny.", "success", 15000)
							exports.nrpg_interface:showPlayerNotification("Teraz zdaj egzamin praktyczny aby otrzymać wybraną licencje.", "info", 15000)
							question_b = 1
							punkty_b = 0
							setElementInterior(localPlayer, 0)
							triggerServerEvent("license:do", resourceRoot, localPlayer, "B")
						else
							exports.nrpg_interface:showPlayerNotification("Uzyskałeś/aś wynik: "..punkty_b.."/"..#questions_b.." punktów i nie udało ci się zdać egzaminu teortycznego.", "error", 15000)
							question_b = 1
							punkty_b = 0
						end
						question_b = 1
						removeEventHandler("onClientRender", root, main.renderGUI)
						showCursor(false)
						guiSetVisible(tak, false)
						guiSetVisible(nie, false)
						windows.main = false
						windows.questionKatB = false
						windows.questionKatC = false
						windows.questionKatA = false
						main.actualCategory = nil
					else
						question_b = question_b+1
						guiCheckBoxSetSelected(tak, false)
						guiCheckBoxSetSelected(nie, false)
					end	
				elseif windows.questionKatC == true then
					if windows.questionKatC == true then
						odpowiedz = "?"
					end
					if guiCheckBoxGetSelected(tak) == true then
						odpowiedz = "Tak"
					elseif guiCheckBoxGetSelected(nie) == true then
						odpowiedz = "Nie"
					end
		
					if not guiCheckBoxGetSelected(tak) and not guiCheckBoxGetSelected(nie) then
							exports.nrpg_interface:showPlayerNotification("Najpierw wybierz odpowiedź.", "error", 15000)
						return
					end
		
					if odpowiedz == questions_c[question_c].git then
						punkty_c = punkty_c+1
					end
				
					if not questions_c[question_c+1] then
						if punkty_c >= #questions_c-2 then
							exports.nrpg_interface:showPlayerNotification("Uzyskałeś/aś wynik: "..punkty_c.."/"..#questions_c.." punktów i zdałeś egzamin teoretyczny.", "success", 15000)
							exports.nrpg_interface:showPlayerNotification("Teraz zdaj egzamin praktyczny aby otrzymać wybraną licencje.", "info", 15000)
							question_c = 1
							punkty_c = 0
							setElementInterior(localPlayer, 0)
							triggerServerEvent("license:do", resourceRoot, localPlayer, "C")
						else
							exports.nrpg_interface:showPlayerNotification("Uzyskałeś/aś wynik: "..punkty_c.."/"..#questions_c.." punktów i nie udało ci się zdać egzaminu teortycznego.", "error", 15000)
							question_c = 1
							punkty_c = 0
						end
		
						question_c = 1
						removeEventHandler("onClientRender", root, main.renderGUI)
						showCursor(false)
						guiSetVisible(tak, false)
						guiSetVisible(nie, false)
						windows.main = false
						windows.questionKatB = false
						windows.questionKatC = false
						windows.questionKatA = false
						main.actualCategory = nil
					else
						question_c = question_c+1
						guiCheckBoxSetSelected(tak, false)
						guiCheckBoxSetSelected(nie, false)
					end	
				end
			end

			x = 0
            for i,v in ipairs(menu) do
                if i >= kmenu and i <= nmenu then 
                	x = x + 1
                	local offsetY = math.floor(50*h)*(x-1)
                	local offsetY2 = offsetY*2

                	if isMouseIn(348*w, (285*h)+offsetY, 210*w, 45*h) then
							if v[1] == "Zamknij" then
								main.toggleGUI = false
								windows.questionKatB = false
								windows.questionKatC = false
								windows.questionKatA = false
								windows.questionKatL = false
								main.actualCategory = nil
								main.actualPage = "Główna"
								guiSetVisible(tak, false)
								guiSetVisible(nie, false)
								guiCheckBoxSetSelected(tak, false)
								guiCheckBoxSetSelected(nie, false)
								showCursor(false)
								removeEventHandler("onClientRender", root, main.renderGUI)
							else
								if windows.questionKatA == false and windows.questionKatB == false and windows.questionKatC == false then
								main.actualPage = v[1]
							end
						end
                	end
				end
            end
		end
	end
end)

local licenseBlip
local licenseTarget
local licenseMarker
local licenseVehicle
local licenseCategory

local categoryPositions={
	["B"]={
		{-2047.12, -95.16, 35.17},
{-2021.61, -72.56, 35.17},
{-2008.18, -164.80, 35.71},
{-2006.64, -236.85, 35.71},
{-1925.21, -241.18, 25.56},
{-1815.54, -238.93, 18.23},
{-1796.71, -134.74, 5.94},
{-1797.28, -34.31, 15.14},
{-1807.06, 158.35, 14.96},
{-1752.94, 319.86, 7.03},
{-1844.64, 412.55, 17.02},
{-1834.24, 523.71, 32.69},
{-1894.26, 589.89, 34.97},
{-1985.39, 609.14, 35.02},
{-2045.41, 570.30, 35.02},
{-2146.20, 543.70, 35.02},
{-2148.01, 425.08, 35.02},
{-2148.46, 295.38, 35.17},
{-2148.63, 219.42, 35.17},
{-2150.90, 148.03, 35.17},
{-2170.01, 47.91, 35.17},
{-2169.96, -55.23, 35.17},
{-2117.21, -72.56, 35.17},
{-2053.23, -73.14, 35.17},
{-2029.16, -96.28, 35.16},

	},
	["C"]={
		{-2047.12, -95.16, 35.17},
{-2021.61, -72.56, 35.17},
{-2008.18, -164.80, 35.71},
{-2006.64, -236.85, 35.71},
{-1925.21, -241.18, 25.56},
{-1815.54, -238.93, 18.23},
{-1796.71, -134.74, 5.94},
{-1797.28, -34.31, 15.14},
{-1807.06, 158.35, 14.96},
{-1752.94, 319.86, 7.03},
{-1844.64, 412.55, 17.02},
{-1834.24, 523.71, 32.69},
{-1894.26, 589.89, 34.97},
{-1985.39, 609.14, 35.02},
{-2045.41, 570.30, 35.02},
{-2146.20, 543.70, 35.02},
{-2148.01, 425.08, 35.02},
{-2148.46, 295.38, 35.17},
{-2148.63, 219.42, 35.17},
{-2150.90, 148.03, 35.17},
{-2170.01, 47.91, 35.17},
{-2169.96, -55.23, 35.17},
{-2117.21, -72.56, 35.17},
{-2053.23, -73.14, 35.17},
{-2029.16, -96.28, 35.16},
	},
	["A"]={
		{-2047.12, -95.16, 35.17},
{-2021.61, -72.56, 35.17},
{-2008.18, -164.80, 35.71},
{-2006.64, -236.85, 35.71},
{-1925.21, -241.18, 25.56},
{-1815.54, -238.93, 18.23},
{-1796.71, -134.74, 5.94},
{-1797.28, -34.31, 15.14},
{-1807.06, 158.35, 14.96},
{-1752.94, 319.86, 7.03},
{-1844.64, 412.55, 17.02},
{-1834.24, 523.71, 32.69},
{-1894.26, 589.89, 34.97},
{-1985.39, 609.14, 35.02},
{-2045.41, 570.30, 35.02},
{-2146.20, 543.70, 35.02},
{-2148.01, 425.08, 35.02},
{-2148.46, 295.38, 35.17},
{-2148.63, 219.42, 35.17},
{-2150.90, 148.03, 35.17},
{-2170.01, 47.91, 35.17},
{-2169.96, -55.23, 35.17},
{-2117.21, -72.56, 35.17},
{-2053.23, -73.14, 35.17},
{-2029.16, -96.28, 35.16},
	},
}

function finishLicense(value)
	if isElement(licenseMarker) and licenseMarker then
		destroyElement(licenseMarker)
		licenseMarker=nil
	end
	if isElement(licenseBlip) and licenseBlip then
		destroyElement(licenseBlip)
		licenseBlip=nil
	end
	if value == true then
		licenseCategory=nil
		licenseVehicle=nil
		licenseMarker=nil
		licenseTarget=nil
		licenseBlip=nil
	end

	setTimer(function()
		setElementPosition(localPlayer, -2436.04, 750.88, 35.17)
	end, 200, 1)
end
addEvent("license:finish",true)
addEventHandler("license:finish", resourceRoot, finishLicense)

function showMarker()
	local pos=categoryPositions[licenseCategory][licenseTarget]
	licenseMarker=createMarker(pos[1], pos[2], pos[3]-1, "cylinder", 5, 255, 255, 0, 255)
	licenseBlip=createBlip(pos[1], pos[2], pos[3], 41)
	if categoryPositions[licenseCategory][licenseTarget+1] then
  		e=categoryPositions[licenseCategory][licenseTarget+1]
		setMarkerTarget(licenseMarker, e[1], e[2], e[3])
	end
	addEventHandler("onClientMarkerHit", licenseMarker, function(el,md)
		if not md or el~=localPlayer then return end
		if not getPedOccupiedVehicle(el) then return end
		local veh = getPedOccupiedVehicle(el)
		if licenseTarget < #categoryPositions[licenseCategory] then			
			finishLicense(false)
			licenseTarget=licenseTarget+1
			showMarker()
			showMessage(licenseTarget)
		else
			triggerServerEvent("license:vehdel", resourceRoot, licenseVehicle)
			setElementData(localPlayer,"player:license:pj"..licenseCategory, 1)
			exports.nrpg_interface:showPlayerNotification("Zdałeś prawo jazdy kat. "..licenseCategory.."", "success", 15000)
			finishLicense(true)
		end
	end)
end

addEvent("license:start",true)
addEventHandler("license:start", resourceRoot, function(category,vehicle)
	licenseTarget=1
	licenseBlip=nil
	licenseMarker=nil
	licenseCategory=category
	licenseVehicle=vehicle
	showMarker()
end)

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

addEvent("kolizjaPojazd", true)
addEventHandler("kolizjaPojazd", root, function(v)
    for i,licensePojazd in ipairs(getElementsByType("vehicle")) do
        setElementCollidableWith(licensePojazd, v, false)
    end
    for i,licenseGracz in ipairs(getElementsByType("player")) do
        setElementCollidableWith(licenseGracz, v, false)
    end
end)
