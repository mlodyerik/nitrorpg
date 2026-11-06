main = {

    getLib = exports.nrpg_lib,
    actualPage = "Główna",
    selectedVehicle = nil,
    settingsPage = "main",
    soundMessage = nil,
    toggleGUI = false,
    wiadomosc = true,
    graphicCard = "",
    graphicMemory = "",
    verifyIcon = 275,
    verifyIconAlpha = 255,
    drawSelectEmoji = false,
    activePacks = false,
    selectedPack = nil,
    rolling = false,
    rollingEnd = false,
    rollEnd = 0,
    selectedPremium = nil,
    premiumInformation = nil,
    selectedPackCost = 0,

}

mojeW, mojeH = 1366, 768
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)
tick = nil
tickPaczki = getTickCount(  )

zoom = 1
if sW < 1366 then
    zoom = math.min(2, 1366 / sW)
end

local Last = getTickCount()
local timer = 2000

local Last2 = getTickCount()
local timer2 = 300

local Last3 = getTickCount()
local timer3 = 1000

local Last4 = getTickCount()
local timer4 = 1000

local Last5 = getTickCount()
local timer5 = 1000

scrollPos = 0
scrollOffset = 40*h

local kv = 1
local nv = 7
local mv = 7

local k2 = 1
local n2 = 6
local m2 = 6

local k3 = 1
local n3 = 5
local m3 = 5

local k4 = 1
local n4 = 6
local m4 = 6

local k5 = 1
local n5 = 6
local m5 = 6

local k6 = 1
local n6 = 10
local m6 = 10

local kp = 1
local np = 7
local mp = 7

local ks = 1
local ns = 3
local ms = 3

local kmenu = 1
local nmenu = 6
local mmenu = 6

local kpaczki = 1
local npaczki = 12
local mpaczki = 12

local rot = 0


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
    messageRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(15, 15, 15, 255)),
    friendAcceptRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(0, 144, 255, 255)),
    friendDeleteRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 0, 0, 255)),
    customButton = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(30, 30, 50, 255)),
    customButton2 = main.getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(80, 80, 160, 255)),
    vehicleRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(75, 75, 75, 255)),
    caseRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 255, 255, 255)),
    itemRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 255, 255, 255)),

}

menu = {

    {"Główna", "icons/user_icon.png", "Informacje o twoim koncie"},
    {"Pojazdy", "icons/car2_icon.png", "Lista pojazdów"},
    {"Diamond", "icons/diamond_icon.png", "Zakup konta diamond"},
    {"Paczki", "icons/pack_icon.png", "Otwórz i spróbuj szczęscia"},
    --{"Nieruchomości", "icons/home_icon.png", "Zarządzaj swoimi domkami"},
    {"Znajomi", "icons/friend_icon.png", "Dodaj znajomych i graj"},
    {"Ustawienia", "icons/settings_icon.png", "Grafika, zabezpieczenia, discord"},

}

settings = {

	{"shader:shadow", "Cienie (SSAQ)", "Ustawienie to włącza cienie rodem z ENB - Wymaga mocnego komputera"},
	{"shader:blur", "Rozmycie", "Otoczenie staje się rozmyte"},
	{"shader:colors", "Kolory", "Polepsza jakość kolorów kosztem wydajności"},
	{"shader:detail", "Detale", "Polepsza wygląd tekstur"},
	{"shader:car", "Odbicia", 'Odbicia na karoserii wszystkich pojazdów'},
	{"shader:sky", "Niebo", "Polepsza wygląd nieba"},
	{"shader:water", "Woda", "Realistyczna woda, podobna do tej z GTA 4"},
	{"shader:render", "Zwiększ pole widzenia", "Zwiększa odległość rysowania obiektów"},
	{"shader:snow", "Śnieg", "Klimat zimowy? Prosze bardzo!"},
	{"player:showfps", "Licznik FPS", "Pokazuje licznik klatek na sekunde"},
    {"player:chatbubbles", "Dymki czatu", "Pokazuje dymki czatu"},
    {"player:customradar", "Niestandardowy radar", "Pokazuje niestandardowy radar oraz nową mape pod F11"},
    {"player:statusrp", "Status RP", "Włącz jeśli chcesz odgrywać RolePlay (Odgrywanie obowiązkowe)"},
	{"notshowhud", "Ukryj hud", "Ukrywa interfejs serwerowy"},


}


playerInfo = {

    loaded = false,
    saveCode = nil,
    actualPass = nil,
    player = {},
    vehicles = {},
    friends = {},
    discord = {},
    serials = {},
    friends_request = {},
    friends_request_send = {},
    packs = {},
    packsLoading = false,

}

main.loadPlayerInfo = function()
    playerInfo.nick = string.gsub(getPlayerName(localPlayer), "#%x%x%x%x%x%x", "")
    playerInfo.sid = getElementData(localPlayer, "player:sid")
    playerInfo.serial = getPlayerSerial(localPlayer)
    playerInfo.organizacja = getElementData(localPlayer, "player:organization") or "Brak"
    playerInfo.money = getPlayerMoney(localPlayer)
    playerInfo.skin = getElementModel(localPlayer)
    playerInfo.time = getElementData(localPlayer, "player:hours") or 0
    playerInfo.workTime = getElementData(localPlayer, "player:workinjob") or 0
    playerInfo.bankMoney = 0
    playerInfo.premium = "Brak"
    playerInfo.premiumInfo = ""

    playerInfo.loaded = true
    if playerInfo.loaded == true then
        return true
    else
        return false
    end
end

discordInfo = {}
checkbox = {}
packRoll = {}
rollPosition = 0
rollTime = 5000

store = {

    {"1 Klucz do paczek", 400, "keys", 1},
    {"5 Kluczy do paczek", 2000, "keys", 5},
    {"10 Kluczy do paczek", 4000, "keys", 10},
    
    {"Diamond 1 dzień", 400, "premium+", 1},
    {"Diamond 2 dni", 600, "premium+", 2},
    {"Diamond 3 dni", 800, "premium+", 3},
    {"Diamond 7 dni", 1200, "premium+", 7},
    {"Diamond 14 dni", 2000, "premium+", 14},
    {"Diamond 31 dni", 4000, "premium+", 31},
    {"Diamond 60 dni", 7800, "premium+", 31},

}

packs = {

    [1] = {

        cost = 1,
        name = "Opium Pack",
        color = {55, 155, 255},
        drop = {

            [1] = {"Manana", "car", 410, {0, 144, 255}},
            [2] = {"500,000 PLN", "money", 500000, {165, 82, 255}},
            [3] = {"800,000 PLN", "money", 800000, {255, 25, 255}},
            [4] = {"600 PP", "points", 600, {255, 0, 0}},
            [5] = {"30,000,000 PLN", "money", 30000000, {255, 255, 0}},

        },

    },

    [2] = {

        cost = 1,
        name = "Pinky Pack",
        color = {255, 55, 255},
        drop = {

            [1] = {"Nic", "empty", nil, {125, 125, 125}},
            [2] = {"Walton", "car", 478, {0, 144, 255}},
            [3] = {"8,500,000 PLN", "money", 8500000, {165, 82, 255}},
            [4] = {"1000 PP", "points", 1000, {255, 0, 0}},
            [5] = {"50,000,000 PLN", "money", 50000000, {255, 255, 0}},

        },

    },

    [3] = {

        cost = 2,
        name = "Hell Pack",
        color = {255, 55, 100},
        drop = {

            [1] = {"Faggio", "motorbike", 462, {0, 144, 255}},
            [2] = {"200 PP", "points", 200, {165, 82, 255}},
            [3] = {"5,000,000 PLN", "money", 5000000, {255, 25, 255}},
            [4] = {"Mr. Whoopee", "car", 423, {255, 0, 0}},
            [5] = {"Corvette", "car", 429, {255, 255, 0}},

        },

    },

    [4] = {

        cost = 1,
        name = "Money Pack",
        color = {55, 255, 55},
        drop = {

            [1] = {"250,000 PLN", "money", 250000, {0, 144, 255}},
            [2] = {"500,000 PLN", "money", 500000, {165, 82, 255}},
            [3] = {"25,000,000 PLN", "money", 25000000, {255, 25, 255}},
            [4] = {"75,000,000 PLN", "money", 75000000, {255, 0, 0}},
            [5] = {"90,000,000 PLN", "money", 90000000, {255, 255, 0}},

        },

    },

    [5] = {

        cost = 5,
        name = "Unique Pack",
        color = {255, 255, 55},
        drop = {

            [1] = {"10,000,000 PLN", "money", 10000000, {0, 144, 255}},
            [2] = {"Tesla Model S", "car", 550, {165, 82, 255}},
            [3] = {"Wózek golfowy", "car", 457	, {255, 25, 255}},
            [4] = {"McLaren P1", "car", 506, {255, 0, 0}},
            [5] = {"Szczuromobil", "car", 583, {255, 255, 0}},

        },

    },

    [6] = {

        cost = 4,
        name = "Premium Pack",
        color = {255, 15, 55},
        drop = {

            [1] = {"200 PP", "points", 200, {0, 144, 255}},
            [2] = {"10,000,000 PLN", "money", 10000000, {165, 82, 255}},
            [3] = {"Wózek golfowy", "car", 457	, {255, 25, 255}},
            [4] = {"2000 PP", "points", 2000, {255, 0, 0}},
            [5] = {"BMW e36", "car", 533, {255, 255, 0}},

        },

    },

    [7] = {

        cost = 4,
        name = "Points Pack",
        color = {100, 155, 25},
        drop = {

            [1] = {"200 PP", "points", 200, {0, 144, 255}},
            [2] = {"300 PP", "points", 300, {165, 82, 255}},
            [3] = {"400 PP", "points", 400	, {255, 25, 255}},
            [4] = {"2000 PP", "points", 2000, {255, 0, 0}},
            [5] = {"7500 PP", "points", 7500, {255, 255, 0}},

        },

    },

}

mainTarget = dxCreateRenderTarget(450*2*w, 380*2*h, true)
packTarget = dxCreateRenderTarget(421*2*w, 100*2*h, true)

main.renderDashboard = function()
    dxDrawImage(336*w, 190*h, 694*w, 410*h, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(337*w, 191*h, 692*w, 408*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(344*w, 205*h, 218*w, 59*h, interface.shapeRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(344*w, 280*h, 218*w, 305*h, interface.shapeRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(570*w, 205*h, 450*w, 380*h, interface.shapeRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    exports["nrpg_avatars"]:dxCreateAvatar(350*w, 210*h, 50*w, 50*h, 255)

    dxDrawText(playerInfo.nick, 412*w, 213*h, 536*w, 234*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
    dxDrawText("SID: "..playerInfo.sid, 412*w, 234*h, 536*w, 255*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
    x = 0
    for i,v in ipairs(menu) do
        if i >= kmenu and i <= nmenu then 
            x = x + 1
            local offsetY = math.floor(50*h)*(x-1)
            local offsetY2 = offsetY*2

            if main.actualPage == v[1] then
                dxDrawImage(348*w, (285*h)+offsetY, 198*w, 45*h, interface.shapeButtonRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawImage(352*w, (289*h)+offsetY, 35*w, 35*h, v[2], 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText(v[1], 390*w, (284*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                dxDrawText(v[3], 390*w, (308*h)+offsetY2, 554*w, 321*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
            elseif isMouseIn(348*w, (285*h)+offsetY, 198*w, 45*h) and actualPage ~= v[1] then
                dxDrawImage(348*w, (285*h)+offsetY, 198*w, 45*h, interface.shapeButtonRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawImage(352*w, (289*h)+offsetY, 35*w, 35*h, v[2], 0, 0, 0, tocolor(255, 255, 255, 165), false)
                dxDrawText(v[1], 390*w, (284*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 165), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                dxDrawText(v[3], 390*w, (308*h)+offsetY2, 554*w, 321*h, tocolor(200, 200, 200, 185), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
            else
                dxDrawImage(348*w, (285*h)+offsetY, 198*w, 45*h, interface.shapeButtonRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
                dxDrawImage(352*w, (289*h)+offsetY, 35*w, 35*h, v[2], 0, 0, 0, tocolor(255, 255, 255, 185), false)
                dxDrawText(v[1], 390*w, (284*h)+offsetY2, 554*w, 321*h, tocolor(255, 255, 255, 185), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                dxDrawText(v[3], 390*w, (308*h)+offsetY2, 554*w, 321*h, tocolor(200, 200, 200, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
            end
        end
    end
    drawScrollbar(menu, 551*w, 285*h, 295*h, 15*h, mmenu, kmenu)

    if main.actualPage == 'Główna' then
        local scroll = scrollPos * scrollOffset
        local scroll2 = (scrollPos * scrollOffset) * 2
        local scroll3 = (scrollPos * scrollOffset) / 3.5

        for i,v in ipairs(playerInfo.player) do
            playerInfo.bankMoney = v.bank_money
        end

        if getElementData(localPlayer, "player:premiumplus") then
            playerInfo.premium = "Diamond"
            playerInfo.premiumInfo = getElementData(localPlayer, "player:premiumplusdate") or "0000:00:00"
        elseif getElementData(localPlayer, "player:premium") then
            playerInfo.premium = "Premium"
            playerInfo.premiumInfo = getElementData(localPlayer, "player:premiumdate") or "0000:00:00"
        else
            playerInfo.premium = "Brak"
            playerInfo.premiumInfo = "Brak"
        end

        dxSetRenderTarget(mainTarget, true)
            dxDrawImage(150*w, (130*h)-scroll, 600*w, 170*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 225), false)
            dxDrawImage(150*w, (430*h)-scroll, 600*w, 170*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 225), false)
            dxDrawImage(150*w, (730*h)-scroll, 600*w, 170*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 225), false)
            dxDrawText("INFORMACJE GŁÓWNE", 450*w, -(20*h)-scroll2, 450*w, 200*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("bold23"), "center", "center", false, false, false, false, false)
            dxDrawText("SID:\nNick:\nOrganizacja:", 1100*w, (200*h)-scroll2, 450*w, 200*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "right", "center", false, false, false, false, false)
            dxDrawText(playerInfo.sid.."\n"..playerInfo.nick.."\n"..playerInfo.organizacja, 455*w, (200*h)-scroll2, 300*w, 200*h, tocolor(255, 255, 255, 225), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "left", "center", false, false, false, false, false)

            dxDrawText("MAJĄTEK", 450*w, (580*h)-scroll2, 450*w, 200*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("bold23"), "center", "center", false, false, false, false, false)
            dxDrawText("Portfel:\nBankomat:", 1100*w, (800*h)-scroll2, 450*w, 200*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "right", "center", false, false, false, false, false)
            dxDrawText(convertNumber(playerInfo.money).." PLN\n"..convertNumber(playerInfo.bankMoney).." PLN", 455*w, (800*h)-scroll2, 300*w, 200*h, tocolor(255, 255, 255, 225), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "left", "center", false, false, false, false, false)

            dxDrawText("INNE", 450*w, (1175*h)-scroll2, 450*w, 200*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("bold23"), "center", "center", false, false, false, false, false)
            dxDrawText("Minuty we frakcji:\nPrzegrany czas:\nID Skina:\nTyp konta:\nUsługa ważna do:", 1100*w, (1400*h)-scroll2, 450*w, 200*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "right", "center", false, false, false, false, false)
            dxDrawText(secondsToClock(playerInfo.workTime).."\n"..secondsToClock(playerInfo.time).."\n"..playerInfo.skin.."\n"..playerInfo.premium.."\n"..playerInfo.premiumInfo, 455*w, (1400*h)-scroll2, 300*w, 200*h, tocolor(255, 255, 255, 225), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "left", "center", false, false, false, false, false)
        dxSetRenderTarget()

        dxDrawImage(570*w, 205*h, 450*w, 380*h, mainTarget, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end

    if main.actualPage == "Pojazdy" then
            x = 0
            if playerInfo.vehicles and #playerInfo.vehicles > 0 then 
                for i,v in ipairs(playerInfo.vehicles) do
                    if i >= kv and i <= nv then 
                        x = x + 1
                        local offsetY = (52*h)*(x-1)
                        local offsetY2 = offsetY*2
                        local model = exports["nrpg_vehicles"]:changeName((getVehicleNameFromModel(v["model"])))

                        if v.parking == 1 then
							selectedCarLozalize = "Przechowalnia pojazdów"
						elseif v.police == 1 then
							selectedCarLozalize = "Parking policyjny"
						else
							for k,p in ipairs(getElementsByType("vehicle")) do
								local id = getElementData(p, "vehicle:id")
								if id and id == v.id then
									local x,y,z = getElementPosition(p)
									selectedCarLozalize = getZoneName(x,y,z,true)..", "..getZoneName(x,y,z,false)
								end
							end
						end

                        if v.lpg == 1 then
                            dodatek_lpg = " (LPG: "..v.fuellpg.."/100 L)"
                        else
                            dodatek_lpg = ""
                        end

                        if main.selectedVehicle == v.id then
                            local vehicle = findCar(v.id)

                            if isElement(myObject) then
                                if getKeyState("mouse1") == true and isMouseIn(581*w, 209*h, 426*w, 171*h) then
                                    local cursor = getCursorPosition()
                                    rot = (cursor+582*w)*1000
                                end
                                exports.nrpg_object_preview:setRotation(myObject, 0, 0, rot)
                            end

                            dxDrawImage(579*w, 400*h, 433*w, 175*h, interface.vehicleRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                            dxDrawText(model, 579*w, 399*h, 1011*w, 429*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, false, false)
                            dxDrawText("ID: "..v.id.."\nPrzebieg: "..v.mileage.." KM\nPojemność silnika: "..v.silnik.." dm3\nPoziom paliwa: "..v.fuel.."/"..v.bak.." L"..dodatek_lpg.."\nLokalizacja: "..selectedCarLozalize.."", 579*w, 429*h, 1011*w, 573*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, false, false)

                            if isMouseIn(589*w, 409*h, 20*w, 23*h) then
                                dxDrawImage(579*w, 405*h, 40*w, 40*h, "icons/target.png", 0, 0, 0, tocolor(175, 175, 175, 175), false)
                            else
                                dxDrawImage(579*w, 405*h, 40*w, 40*h, "icons/target.png", 0, 0, 0, tocolor(175, 175, 175, 225), false)
                            end
                            dxDrawText("Namierz", 613*w, 415*h, 705*w, 428*h, tocolor(225, 225, 225, 200), 1.00, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)

                            if vehicle then
                                if isVehicleLocked(vehicle) then
                                    close_name = "Otwórz pojazd"
                                else
                                    close_name = "Zamknij pojazd"
                                end

                                if getVehicleOverrideLights(vehicle) ~= 2 then
                                    light_name = "Zapal światła"
                                else
                                    light_name = "Zgaś światła"
                                end


                                people_name = "Wyrzuć pasażerów"
                            else
                                people_name = "Wyrzuć pasażerów"
                                light_name = "Zapal światła"
                                close_name = "Otwórz pojazd"
                            end

                            if not vehicle then
                                dxDrawImage(610*w, 502*h, 52*w, 50*h, "icons/close_icon.png", 0, 0, 0, tocolor(200, 200, 200, 55), false)
                                dxDrawText(close_name, 589*w, 548*h, 683*w, 570*h, tocolor(200, 200, 200, 55), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                dxDrawImage(768*w, 502*h, 52*w, 50*h, "icons/light_icon.png", 0, 0, 0, tocolor(200, 200, 200, 55), false)
                                dxDrawText(light_name, 748*w, 548*h, 842*w, 570*h, tocolor(200, 200, 200, 55), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                            else
                                if isMouseIn(610*w, 502*h, 52*w, 50*h) then
                                    dxDrawImage(610*w, 502*h, 52*w, 50*h, "icons/close_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                                    dxDrawText(close_name, 589*w, 548*h, 683*w, 570*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                else
                                    dxDrawImage(610*w, 502*h, 52*w, 50*h, "icons/close_icon.png", 0, 0, 0, tocolor(200, 200, 200, 185), false)
                                    dxDrawText(close_name, 589*w, 548*h, 683*w, 570*h, tocolor(200, 200, 200, 185), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                end

                                if isMouseIn(768*w, 502*h, 52*w, 50*h) then
                                    dxDrawImage(768*w, 502*h, 52*w, 50*h, "icons/light_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                                    dxDrawText(light_name, 748*w, 548*h, 842*w, 570*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                else
                                    dxDrawImage(768*w, 502*h, 52*w, 50*h, "icons/light_icon.png", 0, 0, 0, tocolor(200, 200, 200, 185), false)
                                    dxDrawText(light_name, 748*w, 548*h, 842*w, 570*h, tocolor(200, 200, 200, 185), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                end
                            end

                            local number = 0
                            if vehicle then
                                local passagers = getVehicleOccupants(vehicle)
                                
                                for i,v in ipairs(passagers) do
                                    if v ~= localPlayer then
                                        number=number+1
                                    end
                                end
                            else
                                number = 0
                            end

                            if number == 0 then
                                dxDrawImage(930*w, 502*h, 52*w, 50*h, "icons/friend_icon.png", 0, 0, 0, tocolor(200, 200, 200, 55), false)
                                dxDrawText(people_name, 1070*w, 548*h, 842*w, 570*h, tocolor(200, 200, 200, 55), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                            else
                                if isMouseIn(930*w, 502*h, 52*w, 50*h) then
                                    dxDrawImage(930*w, 502*h, 52*w, 50*h, "icons/friend_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                                    dxDrawText(people_name, 1070*w, 548*h, 842*w, 570*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                else
                                    dxDrawImage(930*w, 502*h, 52*w, 50*h, "icons/friend_icon.png", 0, 0, 0, tocolor(200, 200, 200, 185), false)
                                    dxDrawText(people_name, 1070*w, 548*h, 842*w, 570*h, tocolor(200, 200, 200, 185), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                                end
                            end
                        elseif main.selectedVehicle == nil then
                            if isMouseIn(586*w, 215*h+offsetY, 420*w, 50*h) then
                                dxDrawImage(586*w, 215*h+offsetY, 420*w, 50*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 90), false)
                                dxDrawImage(595*w, 216*h+offsetY, 45*w, 45*h, "icons/veh_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                                dxDrawText("ID: "..v.id, 650*w, (365*h+offsetY2), 135*w, 100*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "center", false, false, false, false, false)
                                dxDrawText(model..", "..v.silnik.." dm3 - "..selectedCarLozalize, 650*w, (390*h+offsetY2), 135*w, 100*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                            else
                                dxDrawImage(586*w, 215*h+offsetY, 420*w, 50*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
                                dxDrawImage(595*w, 216*h+offsetY, 45*w, 45*h, "icons/veh_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                                dxDrawText("ID: "..v.id, 650*w, (365*h+offsetY2), 135*w, 100*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "center", false, false, false, false, false)
                                dxDrawText(model..", "..v.silnik.." dm3 - "..selectedCarLozalize, 650*w, (390*h+offsetY2), 135*w, 100*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
                            end
                        end
                    end
                end
            end

            if main.selectedVehicle == nil then
            drawScrollbar(playerInfo.vehicles, 1008*w, 215*h, 362*h, 15*h, mv, kv)
        end
    end

    if main.actualPage == "Diamond" then
        dxDrawImage(570*w, 205*h, 450*w, 45*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
        dxDrawText("Konto diamond", 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
        dxDrawText("Zakup konto premium już teraz i zyskaj bonusy!", 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
        dxDrawImage(575*w, 260*h, 440*w, 195*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

        x_premium = 0
        for i,v in ipairs(store) do
            if i >= kp and i <= np then 
                x_premium = x_premium + 1
                premiumOffset = (25*h)*(x_premium-1)
                premiumOffsetText = premiumOffset*2

                if v[3] == "premium" then
                    thePremiumColor = {255, 255, 0}
                elseif v[3] == "premium+" then
                    thePremiumColor = {25, 175, 255}
                elseif v[3] == "freepremium" then
                    thePremiumColor = {155, 255, 155}
                elseif v[3] == "keys" then
                    thePremiumColor = {255, 155, 155}
                end

                if main.selectedPremium == i then
                    dxDrawImage(582*w, 270*h+premiumOffset, 414*w, 25*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 95), false)
                    dxDrawImage(585*w, 271*h+premiumOffset, 24*w, 24*h, ":nrpg_userpanel/icons/diamond_icon.png", 0, 0, 0, tocolor(thePremiumColor[1], thePremiumColor[2], thePremiumColor[3], 255), false)
                    dxDrawText(v[1], 613*w, 270*h+premiumOffsetText, 991*w, 295*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                elseif isMouseIn(582*w, 270*h+premiumOffset, 414*w, 25*h) then
                    dxDrawImage(582*w, 270*h+premiumOffset, 414*w, 25*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 80), false)
                    dxDrawImage(585*w, 271*h+premiumOffset, 24*w, 24*h, ":nrpg_userpanel/icons/diamond_icon.png", 0, 0, 0, tocolor(thePremiumColor[1], thePremiumColor[2], thePremiumColor[3], 175), false)
                    dxDrawText(v[1], 613*w, 270*h+premiumOffsetText, 991*w, 295*h, tocolor(255, 255, 255, 175), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                else    
                    dxDrawImage(582*w, 270*h+premiumOffset, 414*w, 25*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                    dxDrawImage(585*w, 271*h+premiumOffset, 24*w, 24*h, ":nrpg_userpanel/icons/diamond_icon.png", 0, 0, 0, tocolor(thePremiumColor[1], thePremiumColor[2], thePremiumColor[3], 145), false)
                    dxDrawText(v[1], 613*w, 270*h+premiumOffsetText, 991*w, 295*h, tocolor(255, 255, 255, 145), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                end
            end
        end

        if main.premiumInformation ~= nil then
            if main.premiumInformation[3] == "freepremium" then
                dxDrawText("INFORMACJE", 576*w, 461*h, 1015*w, 491*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
                dxDrawText("#b3b3b3Wybrana oferta: #00b020"..main.premiumInformation[1].."\n#b3b3b3Usługa jest jednorazowa oraz darmowa", 576*w, 491*h, 1015*w, 528*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, true, false)
                exports["nrpg_buttons"]:dxCreateButton("Odbierz", 736*w, 538*h, 120*w, 37*h, 1, {25, 255, 25, 255})
            else
                dxDrawText("INFORMACJE", 576*w, 461*h, 1015*w, 491*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
                dxDrawText("#b3b3b3Wybrana oferta: #00b020"..main.premiumInformation[1].."\n#b3b3b3Cena wynosi #00b020"..main.premiumInformation[2].."#b3b3b3 punktów premium\nTy posiadasz #00b020"..(getElementData(localPlayer, "player:pp") or 0).."#b3b3b3 punktów premium", 576*w, 491*h, 1015*w, 528*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, true, false)
                exports["nrpg_buttons"]:dxCreateButton("Zakup", 736*w, 538*h, 120*w, 37*h, 1, {25, 255, 25, 255})
            end
        else
            dxDrawText("INFORMACJE", 576*w, 461*h, 1015*w, 491*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
            dxDrawText("#b3b3b3Wybierz ofertę aby wyświetlić więcej informacji", 576*w, 491*h, 1015*w, 528*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, true, false)           
        end
        drawScrollbar(store, 1002*w, 270*h, 175*h, 15*h, mp, kp)
    end

    if main.actualPage == "Paczki" then
        dxDrawImage(570*w, 205*h, 450*w, 45*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
        if main.selectedPack == nil then
            dxDrawText("Paczki", 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Wybierz paczkę, którą chcesz otworzyć", 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)

            x_pack = 0
            for i, v in ipairs(packs) do
                x_pack = x_pack + 1

                if i > 4 then
                    packOffsetDown = (107*h)*(1)
                    packOffsetDown2 = packOffsetDown*2
                    packOffset = (107*w)*((x_pack-4)-1)
                    packOffset2 = packOffset*2
                else
                    packOffsetDown = 0
                    packOffsetDown2 = 0
                    packOffset = (107*w)*(x_pack-1)
                    packOffset2 = packOffset*2
                end
            
                if isMouseIn(585*w+packOffset, 268*h+packOffsetDown, 100*w, 100*h) then
                    dxDrawImage(585*w+packOffset, 268*h+packOffsetDown, 100*w, 100*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 90), false)
                    dxDrawImage(585*w+packOffset, 268*h+packOffsetDown, 100*w, 80*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
                    dxDrawImage(602*w+packOffset, 282*h+packOffsetDown, 65*w, 65*h, "icons/pack_icon.png", 0, 0, 0, tocolor(v.color[1], v.color[2], v.color[3], 200), false)
                else
                    dxDrawImage(585*w+packOffset, 268*h+packOffsetDown, 100*w, 100*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 65), false)
                    dxDrawImage(585*w+packOffset, 268*h+packOffsetDown, 100*w, 80*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)
                    dxDrawImage(602*w+packOffset, 282*h+packOffsetDown, 65*w, 65*h, "icons/pack_icon.png", 0, 0, 0, tocolor(v.color[1], v.color[2], v.color[3], 175), false)
                end
                dxDrawText(v.cost.." Klucz/y", 658*w, 273*h+packOffsetDown, 679*w+packOffset, 296*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "top", false, false, true, false, false)
                dxDrawText(v.name, 970*w+packOffset2, 615*h+packOffsetDown2, 300*w, 100*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
            end
        else
            dxDrawText(packs[main.selectedPack].name, 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Aby otworzyć te paczkę musisz posiadać "..main.selectedPackCost.." klucz/y, posiadasz ich "..(getElementData(localPlayer, "player:keys") or 0).."", 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)

            dxDrawImage(585*w, 268*h, 421*w, 100*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)


            dxDrawImage(580*w, 420*h, 431*w, 157*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)
            dxDrawText("Lista wygranych:", 585*w, 770*h, 300*w, 100*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, false, false, false, false)

            if main.rolling == true then
                exports["nrpg_buttons"]:dxCreateButton("Wróć", 631*w, 375*h, 161*w, 30*h, 1, {200, 65, 65, 55})
                exports["nrpg_buttons"]:dxCreateButton("Otwórz paczkę", 800*w, 375*h, 161*w, 30*h, 2,{65, 200, 65, 55})
            elseif main.rollingEnd == true then
                exports["nrpg_buttons"]:dxCreateButton("Wróć", 631*w, 375*h, 161*w, 30*h, 1, {200, 65, 65})
                exports["nrpg_buttons"]:dxCreateButton("Kontynuuj", 800*w, 375*h, 161*w, 30*h, 2, {0, 144, 255})
            else
                exports["nrpg_buttons"]:dxCreateButton("Wróć", 631*w, 375*h, 161*w, 30*h, 1, {200, 65, 65})
                exports["nrpg_buttons"]:dxCreateButton("Otwórz paczkę", 800*w, 375*h, 161*w, 30*h, 2, {65, 200, 65})
            end
        
            if tick ~= nil then
                rollPosition = interpolateBetween(0, 0, 0, (-5000-(main.rollEnd))*w, 0, 0, (getTickCount() - tick)/(rollTime), "OutQuad")
                rollTickTime = interpolateBetween(200, 0, 0, 150, 0, 0, (getTickCount() - tick)/(rollTime), "OutQuad")

                if getTickCount(  ) - tickPaczki > rollTickTime then
                    if kpaczki > 20 then
    
                    else
                        tickPaczki = getTickCount(  )
                        kpaczki = kpaczki + 1
                        npaczki = npaczki + 1
                    end
                end
            elseif tick == nil then
                rollPosition = 0
            end

            dxSetRenderTarget(packTarget, true)
            for i, v in ipairs(packRoll) do
                if i >= kpaczki and i <= npaczki then 
                    rollDistance = (200*w)*(i-1)
                    theColor = v[4]
                    iconAlpha = 0
                    main.getLib:dgsRoundRectSetColor(interface.caseRectangle, tocolor(theColor[1], theColor[2], theColor[3], 255))

                    if isScreenElementInPosition(380*w+rollDistance+rollPosition, 269*h, 200*w, 200*h, 795*w, 268*h, 1*w, 100*h) then
                        dxDrawImage(0*w+rollDistance+rollPosition, 0*h, 200*w, 200*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
                        dxDrawImage(0*w+rollDistance+rollPosition, -39*h, 200*w, 200*h, "icons/packshadow_icon.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 255), false)
                        dxDrawImage(0*w+rollDistance+rollPosition, -139*h, 200*w, 300*h, "icons/packshadow_icon.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 255), false)
                        dxDrawImage(0*w+rollDistance+rollPosition, 160*h, 200*w, 40*h, interface.caseRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
                        iconAlpha = 0
                    else
                        dxDrawImage(0*w+rollDistance+rollPosition, 0*h, 200*w, 200*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 175), false)
                        dxDrawImage(0*w+rollDistance+rollPosition, -39*h, 200*w, 200*h, "icons/packshadow_icon.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 225), false)
                        dxDrawImage(0*w+rollDistance+rollPosition, -139*h, 200*w, 300*h, "icons/packshadow_icon.png", 0, 0, 0, tocolor(theColor[1], theColor[2], theColor[3], 225), false)
                        dxDrawImage(0*w+rollDistance+rollPosition, 160*h, 200*w, 40*h, interface.caseRectangle, 0, 0, 0, tocolor(255, 255, 255, 175), false)
                        iconAlpha = 15
                    end

                    if v[2] == "money" then
                        dxDrawImage(52*w+rollDistance+rollPosition, 35*h, 100*w, 100*h, "icons/money_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255-iconAlpha), false)
                    elseif v[2] == "car" then
                        dxDrawImage(35*w+rollDistance+rollPosition, 25*h, 125*w, 125*h, "icons/car2_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255-iconAlpha), false)
                    elseif v[2] == "points" then
                        dxDrawImage(50*w+rollDistance+rollPosition, 35*h, 100*w, 100*h, "icons/diamond_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255-iconAlpha), false)
                    elseif v[2] == "empty" then
                        dxDrawImage(50*w+rollDistance+rollPosition, 35*h, 100*w, 100*h, "icons/empty_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255-iconAlpha), false)
                    elseif v[2] == "motorbike" then
                        dxDrawImage(50*w+rollDistance+rollPosition, 35*h, 100*w, 100*h, "icons/motorbike_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255-iconAlpha), false)
                    end
                    dxDrawText(v[1], 0*w+(rollDistance*2)+(rollPosition*2), 317*h, 200*w, 40*h, tocolor(255, 255, 255, 255-iconAlpha), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "center", false, false, false, false, false)
                end
            end
            dxSetRenderTarget()
            dxDrawImage(585*w, 268*h, 421*w, 100*h, packTarget, 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(585*w, 268*h, 421*w, 100*h, "icons/pack_background.png", 0, 0, 0, tocolor(0, 0, 0, 155), false)
            dxDrawRectangle(795*w, 268*h, 1*w, 100*h, tocolor(255, 175, 0, 100), false)

            x_drops = 0
            for i, v in ipairs(packs[main.selectedPack].drop) do
                x_drops = x_drops + 1
                dropsDown = (25*h)*(x_drops-1)
                dropsDownText = dropsDown*2
                itemColor = v[4]

                main.getLib:dgsRoundRectSetColor(interface.itemRectangle, tocolor(itemColor[1], itemColor[2], itemColor[3], 255))

                dxDrawImage(585*w, 445*h+dropsDown, 421*w, 25*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
                dxDrawImage(585*w, 445*h+dropsDown, 20*w, 25*h, interface.itemRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
                dxDrawText(i, 892*w, 815*h+dropsDownText, 300*w, 100*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                dxDrawText(v[1], 610*w, 815*h+dropsDownText, 300*w, 100*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "center", false, false, false, false, false)
            end
        end
    end

    if main.actualPage == "Ustawienia" then
        if main.settingsPage == "main" then
            settings_background = 255
            discord_background = 255
            security_background = 255

            if isMouseIn(640*w, 220*h, 315*w, 115*h) then
                settings_background = 200
            else
                settings_background = 255
            end

            if isMouseIn(640*w, 340*h, 315*w, 115*h) then
                discord_background = 200
            else
                discord_background = 255
            end

            if isMouseIn(640*w, 460*h, 315*w, 115*h) then
                security_background = 200
            else
                security_background = 255
            end

            dxDrawImage(640*w, 218*h, 315*w, 115*h, "icons/settings_background.png", 0, 0, 0, tocolor(255, 255, 255, settings_background), false)
            dxDrawText("Ustawienia graficzne", 650*w, 223*h, 781*w, 305*h, tocolor(255, 255, 255, settings_background), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Polepsz wygląd gry", 650*w, 305*h, 781*w, 351*h, tocolor(200, 200, 200, settings_background), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "top", false, false, false, false, false)

            dxDrawImage(640*w, 338*h, 315*w, 115*h, "icons/discord_background.png", 0, 0, 0, tocolor(255, 255, 255, discord_background), false)
            dxDrawText("Discord", 650*w, 393*h, 781*w, 425*h, tocolor(255, 255, 255, discord_background), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Połącz swoje konto z naszym serwerem discord", 650*w, 425*h, 781*w, 350*h, tocolor(200, 200, 200, discord_background), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "top", false, false, false, false, false)

            dxDrawImage(640*w, 458*h, 315*w, 115*h, "icons/security_background.png", 0, 0, 0, tocolor(255, 255, 255, security_background), false)
            dxDrawText("Zabezpieczenia", 650*w, 393*h, 781*w, 545*h, tocolor(255, 255, 255, security_background), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Zabezpiecz swoje konto", 650*w, 545*h, 781*w, 350*h, tocolor(200, 200, 200, security_background), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "top", false, false, false, false, false)
        elseif main.settingsPage == "Discord" then
            dxDrawImage(570*w, 205*h, 450*w, 45*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
            dxDrawText("Synchronizacja discord", 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Połącz swoje konto już teraz!", 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)

            if #playerInfo.discord > 0 then
                for i, v in ipairs(playerInfo.discord) do
                    discordInfo = {

                        used = v.discordconnected,
                        code = v.kod,
                        uid = v.id,

                    }
                end

                if discordInfo.used == "Nie" then
                    dxDrawImage(579*w, 261*h, 66*w, 62*h, ":nrpg_userpanel/icons/discord_icon.png", 0, 0, 0, tocolor(255, 55, 55, 255), false)
                    dxDrawText("Status połączenia", 655*w, 261*h, 794*w, 294*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, false, false)
                    dxDrawText("Rozłączony", 655*w, 294*h, 794*w, 323*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
                    dxDrawText("Łączenie:", 800*w, 345*h, 1015*w, 376*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, false, false)
                    dxDrawText("Aby połączyć konto użyj przycisku 'skopiuj'\na następnie w wiadomości prywatnej:\n#8787e1.polacz "..discordInfo.code.."", 800*w, 376*h, 1015*w, 459*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light9"), "left", "top", false, false, false, true, false)    
                else
                    dxDrawImage(579*w, 261*h, 66*w, 62*h, ":nrpg_userpanel/icons/discord_icon.png", 0, 0, 0, tocolor(55, 255, 55, 255), false)
                    dxDrawText("Status połączenia", 655*w, 261*h, 794*w, 294*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, false, false)
                    dxDrawText("Połączony", 655*w, 294*h, 794*w, 323*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
                end

                dxDrawText("Co zyskujesz:", 579*w, 345*h, 794*w, 376*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, false, false)
                dxDrawText("▪ Dostęp do unikalnych komend bota\n▪ Zarządzanie kontem z poziomu bota\n▪ Avatar z discorda w grze", 579*w, 376*h, 794*w, 429*h, tocolor(110, 110, 168, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light9"), "left", "top", false, false, false, false, false)
            end
            exports["nrpg_buttons"]:dxCreateButton("Skopiuj kod synchronizacji", 800*w, 275*h, 210*w, 33*h, 1, {130, 145, 235})

        elseif main.settingsPage == "Grafika" then
            dxDrawImage(570*w, 205*h, 450*w, 45*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
            dxDrawText("Ustawienia graficzne", 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
            dxDrawText("Twoja karta graficzna: "..main.graphicCard, 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            dxDrawText("Pamięć video", 816*w, 205*h, 1011*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "right", "bottom", false, false, false, false, false)
            dxDrawText(main.graphicMemory.." MB", 816*w, 228*h, 1011*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "top", false, false, false, false, false)

            x_settings = 0
            for i,v in ipairs(settings) do
                if i >= k4 and i <= n4 then 
                    x_settings = x_settings + 1
                    local offsetY = (50*h)*(x_settings-1)
                    local offsetY2 = offsetY*2

                    if getElementData(localPlayer, v[1]) then
                        dxDrawImage(576*w, 268*h+offsetY, 427*w, 50*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
                        dxDrawImage(576*w, 268*h+offsetY, 427*w, 50*h, interface.addRectangle, 0, 0, 0, tocolor(255, 255, 255, 15), false)
                        check_state = 255
                    else
                        dxDrawImage(576*w, 268*h+offsetY, 427*w, 50*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 75), false)
                        dxDrawImage(576*w, 268*h+offsetY, 427*w, 50*h, interface.friendDeleteRectangle, 0, 0, 0, tocolor(255, 255, 255, 15), false)
                        check_state = 0
                    end

                    if isMouseIn(966*w, 277*h+offsetY, 28*w, 28*h) then
                        dxDrawImage(966*w, 277*h+offsetY, 28*w, 28*h, "icons/checkbox_empty.png", 0, 0, 0, tocolor(200, 200, 200, 200), false)
                    else
                        dxDrawImage(966*w, 277*h+offsetY, 28*w, 28*h, "icons/checkbox_empty.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                    end
                    dxDrawImage(966*w, 277*h+offsetY, 28*w, 28*h, "icons/checkbox_clicked.png", 0, 0, 0, tocolor(200, 200, 200, (checkbox[i] or check_state)), false)
                    
                    dxDrawText(v[2], 585*w, 272*h, 1007*w, 292*h+offsetY, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "bottom", false, false, false, false, false)
                    dxDrawText(v[3], 585*w, 292*h+offsetY, 1007*w, 304*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
                end
            end
            drawScrollbar(settings, 1007*w, 268*h, 300*h, 15*h, m4, k4)

        elseif main.settingsPage == "Zabezpieczenia" then
            dxDrawImage(570*w, 205*h, 450*w, 45*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

            if main.securityPage == "Verify" then
                dxDrawText("Weryfikacja tożsamości", 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
                dxDrawText("Aby potwierdzić, że jesteś właścicielem konta wpisz kod zabezpieczający", 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
                dxDrawImage(722*w, main.verifyIcon*h, 155*w, 155*h, "icons/verify_icon.png", 0, 0, 0, tocolor(120, 120, 174, 255), false)
                exports["nrpg_buttons"]:dxCreateButton("Dalej", 815*w, 495*h, 94*w, 28*h, 1, {130, 145, 235})
            elseif main.securityPage == "Main" then
                dxDrawText("Zabezpieczenia", 577*w, 205*h, 816*w, 228*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, false, false)
                dxDrawText("Zarządzaj swoim kontem", 577*w, 228*h, 816*w, 251*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)

                exports["nrpg_buttons"]:dxCreateButton("Zmień nick", 575*w, 295*h, 145*w, 32*h, 1, {255, 175, 0}, "light")
                exports["nrpg_buttons"]:dxCreateButton("Zmień hasło", 725*w, 365*h, 200*w, 32*h, 2, {255, 175, 0}, "light")
                exports["nrpg_buttons"]:dxCreateButton("Dodaj serial", 915*w, 460*h, 100*w, 32*h, 3, {255, 175, 0}, "light")

                dxDrawImage(575*w, 520*h, 440*w, 60*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                dxDrawText("Lista przypisanych seriali do konta", 580*w, 935*h, 440*w, 85*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money9"), "left", "center", false, false, false, false, false)

                local xS = 0
                for i, v in ipairs(playerInfo.serials) do
                    if i >= ks and i <= ns then 
                        xS = xS + 1
                        local offsetY = (35*h)*(xS-1)
                        dxDrawImage(577*w, 524*h+(offsetY/2), 426*w, 15*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                        dxDrawText(v, 580*w, 980*h+offsetY, 440*w, 85*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                    end
                end
                drawScrollbar(playerInfo.serials, 1005*w, 524*h, 50*h, 15*h, ms, ks)
            end
        end
    end


    if main.actualPage == "Znajomi" then
        dxDrawImage(579*w, 218*h, 431*w, 43*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)
        dxDrawImage(579*w, 335*h, 136*w, 236*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 45), false)
        dxDrawImage(725*w, 272*h, 285*w, 299*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 25), false)
        dxDrawText("Znajomi", 587*w, 223*h, 746*w, 240*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
        totalFriends = 0
        for i,v in ipairs(playerInfo.friends) do
            for _, plr in ipairs(getElementsByType("player")) do
                if getElementData(plr, "player:sid") == v.friendsid then
                    totalFriends = totalFriends+1
                end
            end
        end

        x_frie = 0
        for i,v in ipairs(playerInfo.friends) do
            if i >= k3 and i <= n3 then 
                x_frie = x_frie + 1
                local offsetY = (38*h)*(x_frie-1)
                local offsetY2 = offsetY*2

                if main.selectedFriend == v.friendsid then
                    dxDrawImage(583*w, 366*h+offsetY, 128*w, 36*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
                else
                    if isMouseIn(583*w, 366*h+offsetY, 128*w, 36*h) then
                        dxDrawImage(583*w, 366*h+offsetY, 128*w, 36*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                    else
                        dxDrawImage(583*w, 366*h+offsetY, 128*w, 36*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                    end
                end
                
                if string.len(v.nick) >= 15 then
                    dxDrawText(string.sub(v.nick, 1, 15).."...", 590*w, 366*h, 711*w, 385*h+offsetY, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
                else
                    dxDrawText(v.nick, 590*w, 366*h, 711*w, 385*h+offsetY, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
                end
                

                local status = checkStatus(v.friendsid)
                if status then
                    if getElementData(status, "player:sid") == v.friendsid then
                        dodatek = "#00ba06●"
                    else
                        dodatek = "#ba0000●"
                    end

                    if getElementData(status, "player:chat") == getElementData(localPlayer, "player:sid") then
                        if isPlayerTyping(status) then
                            status = "Pisze..."
                        else
                            if getElementData(status, "player:sid") == v.friendsid then
                                status = "Online"
                            else
                                status = "Offline"
                            end
                        end
                    else
                        if getElementData(status, "player:sid") == v.friendsid then
                            status = "Online"
                        else
                            status = "Offline"
                        end
                    end
                else
                    status = "Offline"
                    dodatek = "#ba0000●"
                end

                dxDrawText(dodatek.."#ffffff "..status, 590*w, 385*h+offsetY, 711*w, 404*h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, true, false)

            end
        end
        
        dxDrawText("Aktywni znajomi: "..totalFriends.."/"..#playerInfo.friends.."", 587*w, 240*h, 746*w, 258*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
        dxDrawText("Lista znajomych", 581*w, 405*h, 714*w, 295*h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
        
        if isMouseIn(915*w, 223*h, 90*w, 30*h) then
            dxDrawImage(915*w, 223*h, 90*w, 30*h, interface.addRectangle, 0, 0, 0, tocolor(255, 255, 255, 145), false)dxDrawImage(915*w, 223*h, 90*w, 30*h, interface.addRectangle, 0, 0, 0, tocolor(255, 255, 255, 145), false)
            dxDrawText("ZAPROŚ", 913*w, 221*h, 1006*w, 255*h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
        else
            dxDrawImage(915*w, 223*h, 90*w, 30*h, interface.addRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
            dxDrawText("ZAPROŚ", 913*w, 221*h, 1006*w, 255*h, tocolor(255, 255, 255, 225), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
        end

        if isMouseIn(579*w, 272*h, 136*w, 28*h) then
            dxDrawImage(579*w, 272*h, 136*w, 28*h, interface.invitesRectangle, 0, 0, 0, tocolor(255, 255, 255, 145), false)
        else
            dxDrawImage(579*w, 272*h, 136*w, 28*h, interface.invitesRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
        end
        dxDrawText("Zaproszenia przychodzące", 581*w, 275*h, 714*w, 295*h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "center", false, false, false, false, false)

        if isMouseIn(579*w, 303*h, 136*w, 28*h) then
            dxDrawImage(579*w, 303*h, 136*w, 28*h, interface.statusRectangle, 0, 0, 0, tocolor(255, 255, 255, 145), false)
        else
            dxDrawImage(579*w, 303*h, 136*w, 28*h, interface.statusRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
        end
        dxDrawText("Zaproszenia wychodzące", 581*w, 339*h, 714*w, 295*h, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "center", false, false, false, false, false)

        if main.friendsPage == "Zaproszenia przychodzące" then
            dxDrawImage(725*w, 272*h, 285*w, 40*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
            dxDrawText("Zaproszenia do grona znajomych", 734*w, 274*h, 873*w, 292*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
            
            req_count = #playerInfo.friends_request

            if req_count == 1 then
                dxDrawText(req_count.." zaproszenie", 734*w, 292*h, 873*w, 310*h, tocolor(175, 175, 175, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            elseif req_count == 2 or req_count == 3 or req_count == 4 then
                dxDrawText(req_count.." zaproszenia", 734*w, 292*h, 873*w, 310*h, tocolor(175, 175, 175, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            else
                dxDrawText(req_count.." zaproszeń", 734*w, 292*h, 873*w, 310*h, tocolor(175, 175, 175, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)              
            end

            x_req = 0
            for i,v in ipairs(playerInfo.friends_request) do
                if i >= k2 and i <= n2 then 
                    x_req = x_req + 1
                    local offsetY = (42*h)*(x_req-1)
                    local offsetY2 = offsetY*2

                    dxDrawImage(730*w, 317*h+offsetY, 274*w, 40*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 35), false)

                    if isMouseIn(875*w, 324*h+offsetY, 60*w, 25*h) then
                        dxDrawImage(875*w, 324*h+offsetY, 60*w, 25*h, interface.friendAcceptRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        dxDrawText("Akceptuj", 869*w, 328*h+offsetY2, 940*w, 346*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                    else
                        dxDrawImage(875*w, 324*h+offsetY, 60*w, 25*h, interface.friendAcceptRectangle, 0, 0, 0, tocolor(255, 255, 255, 185), false)
                        dxDrawText("Akceptuj", 869*w, 328*h+offsetY2, 940*w, 346*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                    end

                    if isMouseIn(940*w, 324*h+offsetY, 60*w, 25*h) then
                        dxDrawImage(940*w, 324*h+offsetY, 60*w, 25*h, interface.friendDeleteRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        dxDrawText("Odrzuć", 947*w, 328*h+offsetY2, 994*w, 346*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                    else
                        dxDrawImage(940*w, 324*h+offsetY, 60*w, 25*h, interface.friendDeleteRectangle, 0, 0, 0, tocolor(255, 255, 255, 185), false)
                        dxDrawText("Odrzuć", 947*w, 328*h+offsetY2, 994*w, 346*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                    end


                    dxDrawText(""..v.inviteNick.."", 738*w, 311*h, 872*w, 338*h+offsetY, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
                    dxDrawText("Zaproszenie przychodzące", 738*w, 335*h+offsetY, 870*w, 361*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
                end
            end
            if 1 > #playerInfo.friends_request then
                dxDrawImage(794*w, 325*h, 155*w, 165*h, "icons/invite_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                dxDrawText("Brak zaproszeń", 789*w, 488*h, 944*w, 493*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "center", "bottom", false, false, false, false, false)
                dxDrawText("Nie masz żadnych nowych zaproszeń\ndo grona znajomych", 789*w, 493*h, 944*w, 498*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, false, false)
            end

            elseif main.friendsPage == "Zaproszenia wychodzące" then
            dxDrawImage(725*w, 272*h, 285*w, 40*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
            dxDrawText("Wysłane zaproszenia", 734*w, 274*h, 873*w, 292*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
            
            req_count = #playerInfo.friends_request_send

            if req_count == 1 then
                dxDrawText(req_count.." zaproszenie", 734*w, 292*h, 873*w, 310*h, tocolor(175, 175, 175, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            elseif req_count == 2 or req_count == 3 or req_count == 4 then
                dxDrawText(req_count.." zaproszenia", 734*w, 292*h, 873*w, 310*h, tocolor(175, 175, 175, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
            else
                dxDrawText(req_count.." zaproszeń", 734*w, 292*h, 873*w, 310*h, tocolor(175, 175, 175, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)              
            end

            x_req2 = 0
            for i,v in ipairs(playerInfo.friends_request_send) do
                if i >= k5 and i <= n5 then 
                    x_req2 = x_req2 + 1
                    local offsetY = (42*h)*(x_req2-1)
                    local offsetY2 = offsetY*2

                    dxDrawImage(730*w, 317*h+offsetY, 274*w, 40*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 35), false)

                    if isMouseIn(940*w, 324*h+offsetY, 60*w, 25*h) then
                        dxDrawImage(940*w, 324*h+offsetY, 60*w, 25*h, interface.friendDeleteRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        dxDrawText("Anuluj", 947*w, 328*h+offsetY2, 994*w, 346*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                    else
                        dxDrawImage(940*w, 324*h+offsetY, 60*w, 25*h, interface.friendDeleteRectangle, 0, 0, 0, tocolor(255, 255, 255, 185), false)
                        dxDrawText("Anuluj", 947*w, 328*h+offsetY2, 994*w, 346*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "center", "center", false, false, false, false, false)
                    end


                    dxDrawText(""..v.friendNick.."", 738*w, 311*h, 872*w, 338*h+offsetY, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
                    dxDrawText("Zaproszenie wychodzące", 738*w, 335*h+offsetY, 870*w, 361*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "top", false, false, false, false, false)
                end
            end
            if 1 > #playerInfo.friends_request_send then
                dxDrawImage(794*w, 325*h, 155*w, 165*h, "icons/invite_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                dxDrawText("Brak zaproszeń", 789*w, 488*h, 944*w, 493*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "center", "bottom", false, false, false, false, false)
                dxDrawText("Nie wysłano żadnych zaproszeń", 789*w, 493*h, 944*w, 498*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, false, false)
            end
        end
        if main.selectedFriend ~= nil and main.friendsPage == "Czat" then
            dxDrawImage(725*w, 272*h, 285*w, 40*h, interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
     
            local status_user = checkStatus(main.selectedFriend)
            local dots = ""
            if status_user then
                if getElementData(status_user, "player:sid") == main.selectedFriend then
                    user_dodatek = "#00ba06●"
                else
                    user_dodatek = "#ba0000●"
                end

                if getElementData(status_user, "player:chat") == getElementData(localPlayer, "player:sid") then
                    if isPlayerTyping(status_user) then
                        dots = "..."
                        status_user = "Online"
                    else
                        if getElementData(status_user, "player:sid") == main.selectedFriend then
                            status_user = "Online"
                        else
                            status_user = "Offline"
                        end
                    end
                else
                    if getElementData(status_user, "player:sid") == main.selectedFriend then
                        status_user = "Online"
                    else
                        status_user = "Offline"
                    end
                end
            else
                dots = ""
                status_user = "Offline"
                user_dodatek = "#ba0000●"
            end
            
            dxDrawText(main.selectedFriendNick..""..dots, 764*w, 274*h, 873*w, 298*h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money8"), "left", "bottom", false, false, false, false, false)
            drawUserAvatar(731*w, 276*h, 30*w, 30*h, main.selectedFriend, status_user)

            if isMouseIn(970*w, 278*h, 28*w, 28*h) then
                dxDrawImage(970*w, 278*h, 28*w, 28*h, "icons/delfriend_icon.png", 0, 0, 0, tocolor(155, 55, 55, 200), false)
            else
                dxDrawImage(970*w, 278*h, 28*w, 28*h, "icons/delfriend_icon.png", 0, 0, 0, tocolor(155, 55, 55, 255), false)
            end

            local message = exports["nrpg_interface"]:getCustomEditboxText('friend:chat')
            if main.wiadomosc == false then
                if string.len(message) > 0 then
                    dxDrawImage(980*w, 537*h, 20*w, 20*h, "icons/message_icon.png", 0, 0, 0, tocolor(255, 255, 255, 55), false)
                else
                    if (chat.settings.emoji or "like_icon") == "like_icon" then
                        dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(200, 200, 200, 55), false)
                    elseif (chat.settings.emoji or "like_icon") == "heart_icon" then
                        dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(255, 0, 0, 55), false)
                    else
                        dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(255, 255, 255, 55), false)
                    end
                end
            else
                if string.len(message) > 0 then
                    if isMouseIn(974*w, 532*h, 30*w, 30*h) then
                        dxDrawImage(980*w, 537*h, 20*w, 20*h, "icons/message_icon.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                    else
                        dxDrawImage(980*w, 537*h, 20*w, 20*h, "icons/message_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                    end
                else
                    if (chat.settings.emoji or "like_icon") == "like_icon" then
                        if isMouseIn(974*w, 532*h, 30*w, 30*h) then
                            dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(200, 200, 200, 200), false)
                        else
                            dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                        end
                    elseif (chat.settings.emoji or "like_icon") == "heart_icon" then
                        if isMouseIn(974*w, 532*h, 30*w, 30*h) then
                            dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(255, 0, 0, 200), false)
                        else
                            dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
                        end
                    else
                        if isMouseIn(974*w, 532*h, 30*w, 30*h) then
                            dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                        else
                            dxDrawImage(977*w, 533*h, 25*w, 25*h, "icons/"..(chat.settings.emoji or "like_icon")..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        end
                    end
                    
                end
            end

            if main.loadState == true then
                dxDrawImage(789*w, 295*h, 155*w, 180*h, "icons/messages_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                dxDrawText("Wczytywanie", 789*w, 448*h, 944*w, 473*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "center", "bottom", false, false, false, false, false)
                dxDrawText("Trwa wczytywanie konwersacji", 789*w, 473*h, 944*w, 498*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, false, false)
            elseif 1 > #chat.messages then
                dxDrawImage(789*w, 314*h, 155*w, 144*h, "icons/empty_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                dxDrawText("Pustka", 789*w, 448*h, 944*w, 473*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "center", "bottom", false, false, false, false, false)
                dxDrawText("W tej konwersacji nie ma\nżadnych wiadomości", 789*w, 473*h, 944*w, 498*h, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, false, false)
                main.drawChat()

                if Last-getTickCount() > 0 then
                    dxDrawText("Następną wiadomość możesz wysłać za "..string.format("%.2f", (Last-getTickCount())/1000).." sek.", 725*w, 569*h, 1008*w, 582*h, tocolor(175, 175, 175, 175), 1/zoom, exports.nrpg_interface:getGUIFont("light7"), "left", "top", false, false, false, false, false)
                    main.wiadomosc = false
                else
                    main.wiadomosc = true
                end

                if isPlayerTyping(localPlayer) and getKeyState("enter") == true and Last-getTickCount() < 0 then
                    if Last-getTickCount() > 0 then
                        return
                    end
                    Last = getTickCount()+timer

                    local message = exports["nrpg_interface"]:getCustomEditboxText('friend:chat')
                    local date = calcToday()
                    
                    if string.len(message) > 0 then
                        for i = 100+(#chat.messages), 2, -1 do
                            chat.messages[i] = chat.messages[i - 1]
                        end
                        chat.messages[1] = {text=message, type=getElementData(localPlayer, "player:sid"), time=date, change=false}
                        goToDown()
                        exports["nrpg_interface"]:customEditboxSetText("friend:chat", "")
                        triggerServerEvent("sendMessage", localPlayer, chat.messages, main.selectedFriend)
                    end
                end
            else
                main.drawChat()

                if Last-getTickCount() > 0 then
                    dxDrawText("Następną wiadomość możesz wysłać za "..string.format("%.2f", (Last-getTickCount())/1000).." sek.", 725*w, 569*h, 1008*w, 582*h, tocolor(175, 175, 175, 175), 1/zoom, exports.nrpg_interface:getGUIFont("light7"), "left", "top", false, false, false, false, false)
                    main.wiadomosc = false
                else
                    main.wiadomosc = true
                end

                if isPlayerTyping(localPlayer) and getKeyState("enter") == true and Last-getTickCount() < 0 then
                    if Last-getTickCount() > 0 then
                        return
                    end
                    Last = getTickCount()+timer

                    local message = exports["nrpg_interface"]:getCustomEditboxText('friend:chat')
                    local date = calcToday()

                    if string.len(message) > 0 then
                        for i = 100+(#chat.messages), 2, -1 do
                            chat.messages[i] = chat.messages[i - 1]
                        end
                        chat.messages[1] = {text=message, type=getElementData(localPlayer, "player:sid"), time=date, change=false}
                        goToDown()
                        exports["nrpg_interface"]:customEditboxSetText("friend:chat", "")
                        triggerServerEvent("sendMessage", localPlayer, chat.messages, main.selectedFriend)
                    end
                end
            end

            if main.drawSelectEmoji == true then
                dxDrawImage(731*w, 600*h, 265*w, 50*h, interface.customButton, 0, 0, 0, tocolor(255, 255, 255, 255), false)

                if isMouseIn(746*w, 610*h, 25*w, 25*h) then
                    dxDrawImage(746*w, 610*h, 25*w, 25*h, "icons/like_icon.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
                else
                    dxDrawImage(746*w, 610*h, 25*w, 25*h, "icons/like_icon.png", 0, 0, 0, tocolor(200, 200, 200, 200), false)
                end

                if isMouseIn(786*w, 610*h, 25*w, 25*h) then
                    dxDrawImage(786*w, 610*h, 25*w, 25*h, "icons/heart_icon.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
                else
                    dxDrawImage(786*w, 610*h, 25*w, 25*h, "icons/heart_icon.png", 0, 0, 0, tocolor(255, 0, 0, 200), false)
                end

                if isMouseIn(828*w, 610*h, 25*w, 25*h) then
                    dxDrawImage(828*w, 610*h, 25*w, 25*h, "icons/heartface_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(828*w, 610*h, 25*w, 25*h, "icons/heartface_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                end

                if isMouseIn(872*w, 610*h, 25*w, 25*h) then
                    dxDrawImage(872*w, 610*h, 25*w, 25*h, "icons/sunglasses_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(872*w, 610*h, 25*w, 25*h, "icons/sunglasses_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                end

                if isMouseIn(914*w, 610*h, 25*w, 25*h) then
                    dxDrawImage(914*w, 610*h, 25*w, 25*h, "icons/poop_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(914*w, 610*h, 25*w, 25*h, "icons/poop_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                end

                if isMouseIn(956*w, 610*h, 25*w, 25*h) then
                    dxDrawImage(956*w, 610*h, 25*w, 25*h, "icons/think_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(956*w, 610*h, 25*w, 25*h, "icons/think_emoji.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
                end
            end
        end
    end
end

addEventHandler("onClientClick", root, function(btn, state)
    if main.selectedFriend then
        if main.toggleGUI == true then
            if isMouseIn(974*w, 532*h, 30*w, 30*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "up" and btn == "right" then
                if main.drawSelectEmoji == true then
                    main.drawSelectEmoji = false
                else
                    local message = exports["nrpg_interface"]:getCustomEditboxText('friend:chat')
                    if 1 > string.len(message) then
                        main.drawSelectEmoji = true
                    end
                end
            end

            if isMouseIn(746*w, 610*h, 25*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "down" and btn == "left" and main.drawSelectEmoji == true then
                triggerServerEvent("editChat", localPlayer, main.selectedFriend, "emoji", "like_icon")
                main.drawSelectEmoji = false
            elseif isMouseIn(786*w, 610*h, 25*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "down" and btn == "left" and main.drawSelectEmoji == true then
                triggerServerEvent("editChat", localPlayer, main.selectedFriend, "emoji", "heart_icon")
                main.drawSelectEmoji = false
            elseif isMouseIn(828*w, 610*h, 25*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "down" and btn == "left" and main.drawSelectEmoji == true then
                triggerServerEvent("editChat", localPlayer, main.selectedFriend, "emoji", "heartface_emoji")
                main.drawSelectEmoji = false
            elseif isMouseIn(872*w, 610*h, 25*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "down" and btn == "left" and main.drawSelectEmoji == true then
                triggerServerEvent("editChat", localPlayer, main.selectedFriend, "emoji", "sunglasses_emoji")
                main.drawSelectEmoji = false
            elseif isMouseIn(914*w, 610*h, 25*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "down" and btn == "left" and main.drawSelectEmoji == true then
                triggerServerEvent("editChat", localPlayer, main.selectedFriend, "emoji", "poop_emoji")
                main.drawSelectEmoji = false
            elseif isMouseIn(956*w, 610*h, 25*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" and state == "down" and btn == "left" and main.drawSelectEmoji == true then
                triggerServerEvent("editChat", localPlayer, main.selectedFriend, "emoji", "think_emoji")
                main.drawSelectEmoji = false
            end
        end
    end
end)

local lastClick = getTickCount()
local clickTimer = 250

function checkString(text)
    if string.find(text, "%c") or string.find(text, "%p") or string.find(text, "%s") or string.find(text, "%z") then
      return false
    else
      return true
    end
end

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" then
        if lastClick-getTickCount() > 0 then
            return
        end
        lastClick = getTickCount()+clickTimer

        if main.toggleGUI == true then

            if main.actualPage == "Pojazdy" then
            x = 0
            if playerInfo.vehicles and #playerInfo.vehicles > 0 then 
                for i,v in ipairs(playerInfo.vehicles) do
                    if i >= kv and i <= nv then 
                        x = x + 1
                        local offsetY = (52*h)*(x-1)
                        local offsetY2 = offsetY*2

                        if isMouseIn(586*w, 215*h+offsetY, 420*w, 50*h) then
                            if main.selectedVehicle == nil then
                                main.selectedVehicle = v.id
                                toggleVehicle(v.model, v)
                            end
                        end
                    end
                end
            end
            end

            if main.actualPage == "Pojazdy" and main.selectedVehicle ~= nil then
                local veh = findCar(tonumber(main.selectedVehicle))

                if isMouseIn(610*w, 502*h, 52*w, 50*h) then
                    if Last3-getTickCount() > 0 then
                        return
                    end
                    Last3 = getTickCount()+timer3

                    if veh then
                        triggerServerEvent("carOperation", localPlayer, veh, "close")
                    else
                        exports.nrpg_interface:showPlayerNotification('Pojazdu nie ma na mapie', 'error')
                    end
                end

                if isMouseIn(768*w, 502*h, 52*w, 50*h) then
                    if Last4-getTickCount() > 0 then
                        return
                    end
                    Last4 = getTickCount()+timer4

                    if veh then
                        triggerServerEvent("carOperation", localPlayer, veh, "lights")
                    else
                        exports.nrpg_interface:showPlayerNotification('Pojazdu nie ma na mapie', 'error')
                    end
                end

                if isMouseIn(930*w, 502*h, 52*w, 50*h) then
                    if Last5-getTickCount() > 0 then
                        return
                    end
                    Last5 = getTickCount()+timer5

                    if veh then
                        triggerServerEvent("carOperation", localPlayer, veh, "passager")
                    else
                        exports.nrpg_interface:showPlayerNotification('Pojazdu nie ma na mapie', 'error')
                    end
                end

                if isMouseIn(589*w, 409*h, 20*w, 23*h) then
                    local veh = findCar(main.selectedVehicle)

                    if veh then
                        local x, y, z = getElementPosition(localPlayer)
                        local vehicles_player = getElementsWithinRange(x, y, z, 20, "vehicle")

                        if main.namierza then
                            return exports.nrpg_interface:showPlayerNotification('Już namierzasz jakiś pojazd!', 'error')
                        end

                        for i,v in ipairs(vehicles_player) do
                            if getElementData(v, "vehicle:id") == getElementData(veh, "vehicle:id") then
                                return exports.nrpg_interface:showPlayerNotification('Pojazd jest za blisko', 'error')
                            end
                        end

                        local x, y, z = getElementPosition(veh)
                        main.namierza = veh
                        main.carMarker = createMarker(x, y, z, "cylinder", 10, 0, 0, 0, 0)
                        main.carBlip = createBlipAttachedTo(main.carMarker, 12)
                        attachElements(main.carMarker, veh, 0, 0, 0)
                        attachElements(main.carBlip, veh, 0, 0, 0)
                        local targetInfo = exports["nrpg_vehicles"]:changeName(getVehicleName(veh))
                        setElementData(main.carBlip, "marker:point", targetInfo)
                        setElementData(main.carBlip, "point:icon", 2)

                        addEventHandler("onClientMarkerHit", main.carMarker, function(el)
                            if el == localPlayer then
                                if isElement(main.carMarker) then destroyElement(main.carMarker) end
                                if isElement(main.carBlip) then destroyElement(main.carBlip) end
                                exports.nrpg_interface:showPlayerNotification('Dotarłeś/aś do celu', 'success')
                                main.namierza = nil
                            end
                        end)
                    else
                        exports.nrpg_interface:showPlayerNotification('Pojazdu nie ma na mapie', 'error')
                    end
                end
            end

            if main.actualPage == "Ustawienia" and main.settingsPage == "Discord" then
                if isMouseIn(800*w, 275*h, 210*w, 33*h) then
                    setClipboard( (discordInfo.code or "Błąd") )
                    exports.nrpg_interface:showPlayerNotification('Kod został skopiowany do schowka', 'info')
                end
            end

            if main.actualPage == "Ustawienia" and main.settingsPage == "Grafika" then
                x_settings = 0
                for i,v in ipairs(settings) do
                    if i >= k4 and i <= n4 then 
                        x_settings = x_settings + 1
                        local offsetY = (50*h)*(x_settings-1)
                        local offsetY2 = offsetY*2

                        if isMouseIn(966*w, 277*h+offsetY, 28*w, 28*h) then
                            if Last2-getTickCount() > 0 then
                                return
                            end
                            Last2 = getTickCount()+timer2

                            if v[1] == "shader:render" then
                                if getElementData(localPlayer, v[1]) then
                                    checkbox[i] = 255
                                    setElementData(localPlayer, v[1], false)
                                    resetFarClipDistance()
                                    createAnimation(255, 0, 'Linear', 300, function(value) checkbox[i] = value end)
                                else    
                                    checkbox[i] = 0
                                    setFarClipDistance(7500)
                                    setElementData(localPlayer, v[1], true)
                                    createAnimation(0, 255, 'Linear', 300, function(value) checkbox[i] = value end)
                                end
                            else
                                if getElementData(localPlayer, v[1]) then
                                    checkbox[i] = 255
                                    setElementData(localPlayer, v[1], false)
                                    createAnimation(255, 0, 'Linear', 300, function(value) checkbox[i] = value end)
                                else    
                                    checkbox[i] = 0
                                    setElementData(localPlayer, v[1], true)
                                    createAnimation(0, 255, 'Linear', 300, function(value) checkbox[i] = value end)
                                end
                            end

                            local info = dxGetStatus( )
		                    main.graphicCard = info.VideoCardName
		                    main.graphicMemory = info.VideoMemoryFreeForMTA
                        end
                    end
                end
            end

            if main.actualPage == "Ustawienia" and main.settingsPage == "Zabezpieczenia" and main.securityPage == "Main" then
                local nick = exports["nrpg_interface"]:getCustomEditboxText('account:nick')
                local edit_pass = exports["nrpg_interface"]:getCustomEditboxText('account:password')
                local addserial = exports["nrpg_interface"]:getCustomEditboxText('account:serial')
                local pass2 = exports["nrpg_interface"]:getCustomEditboxText('account:passwordnew')
                local pass3 = exports["nrpg_interface"]:getCustomEditboxText('account:passwordnew2')


                if isMouseIn(575*w, 295*h, 145*w, 32*h) then
                    if checkString(nick) == false then
                        return exports.nrpg_interface:showPlayerNotification("Nick posiada nieprawidłowe znaki", "error")
                    end

                    if string.len(nick) < 3 then
                        return exports.nrpg_interface:showPlayerNotification("Nick powinien zawierać conajmniej 3 znaki", "error")
                    end
                    
                    if string.len(nick) > 20 then
                        return exports.nrpg_interface:showPlayerNotification("Nick powinien zawierać maksymalnie 20 znaków", "error")
                    end

                    triggerServerEvent("changeNick", localPlayer, localPlayer, nick)
                    triggerServerEvent("showPlayerInfo", localPlayer)
                end

                if isMouseIn(915*w, 460*h, 100*w, 32*h) then
                    if string.len(addserial) < 5 then
                        return exports.nrpg_interface:showPlayerNotification("Podaj serial", "error")
                    end

                    triggerServerEvent("serialAction", localPlayer, "add", addserial)
                end

                local xS = 0
                for i, v in ipairs(playerInfo.serials) do
                    if i >= ks and i <= ns then 
                        xS = xS + 1
                        local offsetY = (35*h)*(xS-1)
                        if isMouseIn(577*w, 524*h+(offsetY/2), 426*w, 15*h) then
                            triggerServerEvent("serialAction", localPlayer, "delete", v)
                        end
                    end
                end

                if isMouseIn(725*w, 365*h, 200*w, 32*h) then
                    if teaEncode(edit_pass, "redskilltojebanykretyniokradadziecinakase") == playerInfo.actualPass then
                        if string.len(pass2) < 3 then
                            return exports.nrpg_interface:showPlayerNotification("Hasło powinno zawierać conajmniej 3 znaki", "error")
                        end
                        
                        if string.len(pass2) > 15 then
                            return exports.nrpg_interface:showPlayerNotification("Hasło powinno zawierać maksymalnie 15 znaków", "error")
                        end

                        if pass3 == edit_pass then
                            return exports.nrpg_interface:showPlayerNotification("Podane hasło jest takie samo jak aktualne", "error")
                        end
                        
                        if pass3 == pass2 then
                            triggerServerEvent("changePassword", localPlayer, localPlayer, pass3)
                            triggerServerEvent("showPlayerInfo", localPlayer)
                        else
                            exports.nrpg_interface:showPlayerNotification("Podane hasła różnią się", "error")
                        end
                    else
                        exports.nrpg_interface:showPlayerNotification("Podane aktualne hasło jest błędne", "error")
                    end
                end
            end

            x_req = 0
            for i,v in ipairs(playerInfo.friends_request) do
                if i >= k2 and i <= n2 then 
                    x_req = x_req + 1
                    local offsetY = (42*h)*(x_req-1)
                    local offsetY2 = offsetY*2
                    if isMouseIn(875*w, 324*h+offsetY, 60*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Zaproszenia przychodzące" then
                        triggerServerEvent("manageInvite", localPlayer, localPlayer, "accept", v.inviteUID, v.inviteNick)

                        setTimer( function()
                            triggerServerEvent("showFriendsInfo", localPlayer)
                            triggerServerEvent("showInvitesInfo", localPlayer)

                            for _,plr in ipairs(getElementsByType("player")) do
                                if getElementData(plr, "player:sid") == v.inviteUID then
                                    triggerServerEvent("showFriendsInfo", plr)
                                    triggerServerEvent("showInvitesInfo", plr)
                                end
                            end
                        end, 500, 1)
                    elseif isMouseIn(940*w, 324*h+offsetY, 60*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Zaproszenia przychodzące" then
                        triggerServerEvent("manageInvite", localPlayer, localPlayer, "delete", v.inviteUID, v.inviteNick)

                        setTimer( function()
                            triggerServerEvent("showFriendsInfo", localPlayer)
                            triggerServerEvent("showInvitesInfo", localPlayer)

                            for _,plr in ipairs(getElementsByType("player")) do
                                if getElementData(plr, "player:sid") == v.inviteUID then
                                    triggerServerEvent("showFriendsInfo", plr)
                                    triggerServerEvent("showInvitesInfo", plr)
                                end
                            end
                        end, 500, 1)
                    end
                end
            end

            x_req2 = 0
            for i,v in ipairs(playerInfo.friends_request_send) do
                if i >= k5 and i <= n5 then 
                    x_req2 = x_req2 + 1
                    local offsetY = (42*h)*(x_req2-1)
                    local offsetY2 = offsetY*2
                    if isMouseIn(940*w, 324*h+offsetY, 60*w, 25*h) and main.actualPage == "Znajomi" and main.friendsPage == "Zaproszenia wychodzące" then
                        triggerServerEvent("manageInvite", localPlayer, localPlayer, "delete_send", v.friendUID, v.friendNick)

                        setTimer( function()
                            triggerServerEvent("showInvitesInfoSend", localPlayer)
                        end, 500, 1)
                    end
                end
            end


            x_frie = 0
            for i,v in ipairs(playerInfo.friends) do
                if i >= k3 and i <= n3 then 
                    x_frie = x_frie + 1
                    local offsetY = (38*h)*(x_frie-1)
                    local offsetY2 = offsetY*2
                    if isMouseIn(583*w, 366*h+offsetY, 128*w, 36*h) and main.actualPage == "Znajomi" and main.selectedFriend ~= v.friendsid then
                        main.selectedFriend = v.friendsid
                        main.selectedFriendNick = v.nick
                        main.friendsPage = "Czat"
                        main.loadState = true
                        chat.messages = {}
                        goToDown()
                        setElementData(localPlayer, "player:chat", main.selectedFriend)
                        exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                        exports["nrpg_interface"]:createCustomEditbox('friend:chat', 'Wpisz treść wiadomości...', 731*w, 530*h, 240*w, 36*h, false, "", false, {85, 85, 85})
                        triggerServerEvent("showFriendMessages", localPlayer, v.friendsid)
                    end
                end
            end

            if isMouseIn(640*w, 218*h, 315*w, 115*h) and main.actualPage == "Ustawienia" and main.settingsPage == "main" then
                exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                main.settingsPage = "Grafika"
            elseif isMouseIn(640*w, 338*h, 315*w, 115*h) and main.actualPage == "Ustawienia" and main.settingsPage == "main" then
                exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                triggerServerEvent("showDiscordData", localPlayer)
                main.settingsPage = "Discord"
            elseif isMouseIn(640*w, 458*h, 315*w, 115*h) and main.actualPage == "Ustawienia" and main.settingsPage == "main" then
                exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                main.securityPage = "Main"
                main.settingsPage = "Zabezpieczenia"
                triggerServerEvent("serialAction", localPlayer, "show")
                exports['nrpg_interface']:createCustomEditbox('account:nick', 'Wprowadź nowy nick', 575*w, 260*h, 145*w, 32*h, false, "", false, {75, 75, 75})
                exports['nrpg_interface']:createCustomEditbox('account:serial', 'Wprowadź serial', 575*w, 460*h, 340*w, 32*h, false, "", false, {75, 75, 75})
                exports['nrpg_interface']:createCustomEditbox('account:password', 'Wprowadź aktualne hasło', 725*w, 260*h, 285*w, 32*h, true, "",  false, {75, 75, 75})
                exports['nrpg_interface']:createCustomEditbox('account:passwordnew', 'Wprowadź nowe hasło', 725*w, 295*h, 285*w, 32*h, true, "",  false, {75, 75, 75})
                exports['nrpg_interface']:createCustomEditbox('account:passwordnew2', 'Wprowadź nowe hasło ponownie', 725*w, 330*h, 285*w, 32*h, true, "",  false, {75, 75, 75})
            end

            if isMouseIn(915*w, 223*h, 90*w, 30*h) and main.actualPage == "Znajomi" then
                local request = exports['nrpg_interface']:getCustomEditboxText('friend:request')
                if string.len(request) > 0 then
                    triggerServerEvent("sendRequest", localPlayer, localPlayer, request)
                else
                    exports.nrpg_interface:showPlayerNotification('Wprowadź SID', 'error')
                end
            end

            if isMouseIn(579*w, 272*h, 136*w, 28*h) and main.actualPage == "Znajomi" then
                exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                main.friendsPage = "Zaproszenia przychodzące"
                main.selectedFriend = nil
                main.selectedFriendNick = nil
                triggerServerEvent("showInvitesInfo", localPlayer)
            elseif isMouseIn(579*w, 303*h, 136*w, 28*h) and main.actualPage == "Znajomi" then
                exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                main.friendsPage = "Zaproszenia wychodzące"
                triggerServerEvent("showInvitesInfoSend", localPlayer)
                main.selectedFriend = nil
                main.selectedFriendNick = nil
            end

            if isMouseIn(970*w, 278*h, 28*w, 28*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" then
                exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                main.friendsPage = "Zaproszenia przychodzące"
                triggerServerEvent("deleteFriend", localPlayer, main.selectedFriend, main.selectedFriendNick)
                main.selectedFriend = nil
                main.selectedFriendNick = nil
                triggerServerEvent("showInvitesInfo", localPlayer)

                setTimer( function()
                    triggerServerEvent("showFriendsInfo", localPlayer)
                end, 500, 1)
            end

            if isMouseIn(974*w, 532*h, 30*w, 30*h) and main.actualPage == "Znajomi" and main.friendsPage == "Czat" then
                if Last-getTickCount() > 0 then
                    return
                end
                Last = getTickCount()+timer

                main.drawSelectEmoji = false
                local message = exports["nrpg_interface"]:getCustomEditboxText('friend:chat')
                local date = calcToday()
                if string.len(message) > 0 then
                    for i = 100+(#chat.messages), 2, -1 do
                        chat.messages[i] = chat.messages[i - 1]
                    end
                    chat.messages[1] = {text=message, type=getElementData(localPlayer, "player:sid"), time=date, change=false}
                    goToDown()
                    exports["nrpg_interface"]:customEditboxSetText("friend:chat", "")
                    triggerServerEvent("sendMessage", localPlayer, chat.messages, main.selectedFriend)
                else
                    for i = 100+(#chat.messages), 2, -1 do
                        chat.messages[i] = chat.messages[i - 1]
                    end
                    chat.messages[1] = {text=(chat.settings.emoji or "like_icon"), type=getElementData(localPlayer, "player:sid"), time=date, change=false}
                    goToDown()
                    exports["nrpg_interface"]:customEditboxSetText("friend:chat", "")
                    triggerServerEvent("sendMessage", localPlayer, chat.messages, main.selectedFriend)
                end
            end

            if main.actualPage == "Paczki" and main.selectedPack == nil then
                tick = nil
                x_pack = 0
                for i, v in ipairs(packs) do
                    x_pack = x_pack + 1

                    if i > 4 then
                        packOffsetDown = (107*h)*(1)
                        packOffsetDown2 = packOffsetDown*2
                        packOffset = (107*w)*((x_pack-4)-1)
                        packOffset2 = packOffset*2
                    else
                        packOffsetDown = 0
                        packOffsetDown2 = 0
                        packOffset = (107*w)*(x_pack-1)
                        packOffset2 = packOffset*2
                    end
            
                    if isMouseIn(585*w+packOffset, 268*h+packOffsetDown, 100*w, 100*h) then
                        main.selectedPack = i
                        main.selectedPackCost = packs[main.selectedPack].cost
                        packRoll = {}

                        kpaczki = 1
                        npaczki = 12
                        mpaczki = 12
                        tickPaczki = getTickCount()
                            
                        for i = 1, 30 do
                            local randomize = math.random(90, 100)
                            local randomWin = math.random(1, randomize)
                            if randomWin >= 1 and randomWin <= 50 then
                                random = 1
                            elseif randomWin >= 51 and randomWin <= 84 then
                                random = 2
                            elseif randomWin >= 85 and randomWin <= 94 then
                                random = 3
                            elseif randomWin >= 95 and randomWin <= 98 then
                                random = 4
                            elseif randomWin >= 99 and randomWin <= 100 then
                                random = 5
                            end
                            table.insert(packRoll, {packs[main.selectedPack].drop[random][1], packs[main.selectedPack].drop[random][2], packs[main.selectedPack].drop[random][3], packs[main.selectedPack].drop[random][4]})
                        end
                    end
                end

            elseif main.actualPage == "Paczki" and main.selectedPack ~= nil and main.rolling == false then
                if isMouseIn(631*w, 375*h, 161*w, 30*h) then
                    main.selectedPack = nil
                    main.rolling = false
                    main.rollingEnd = false
                    kpaczki = 1
                    npaczki = 12
                    mpaczki = 12
                elseif isMouseIn(800*w, 375*h, 161*w, 30*h) and main.rollingEnd == true then
                    packRoll = {}
                    main.rolling = false
                    main.rollingEnd = false
                    tick = nil
                    kpaczki = 1
                    npaczki = 12
                    mpaczki = 12
                        
                    for i = 1, 30 do
                        local randomize = math.random(90, 100)
                        local randomWin = math.random(1, randomize)
                        if randomWin >= 1 and randomWin <= 50 then
                            random = 1
                        elseif randomWin >= 51 and randomWin <= 84 then
                            random = 2
                        elseif randomWin >= 85 and randomWin <= 94 then
                            random = 3
                        elseif randomWin >= 95 and randomWin <= 98 then
                            random = 4
                        elseif randomWin >= 99 and randomWin <= 100 then
                            random = 5
                        end
                        table.insert(packRoll, {packs[main.selectedPack].drop[random][1], packs[main.selectedPack].drop[random][2], packs[main.selectedPack].drop[random][3], packs[main.selectedPack].drop[random][4]})
                    end
                elseif isMouseIn(800*w, 375*h, 161*w, 30*h) and main.rollingEnd == false then
                    if main.selectedPackCost > getElementData(localPlayer, "player:keys") then exports.nrpg_interface:showPlayerNotification('Nie posiadasz wystarczającej ilości kluczy', 'error') return end

                    local actualPoints = getElementData(localPlayer, "player:keys") or 0
    			    setElementData(localPlayer, "player:keys", actualPoints-main.selectedPackCost)

                    if 1 > #packRoll then
                        for i = 1, 30 do
                            local randomize = math.random(90, 100)
                            local randomWin = math.random(1, randomize)
                            if randomWin >= 1 and randomWin <= 50 then
                                random = 1
                            elseif randomWin >= 51 and randomWin <= 84 then
                                random = 2
                            elseif randomWin >= 85 and randomWin <= 94 then
                                random = 3
                            elseif randomWin >= 95 and randomWin <= 98 then
                                random = 4
                            elseif randomWin >= 99 and randomWin <= 100 then
                                random = 5
                            end
                            table.insert(packRoll, {packs[main.selectedPack].drop[random][1], packs[main.selectedPack].drop[random][2], packs[main.selectedPack].drop[random][3], packs[main.selectedPack].drop[random][4]})
                        end
                    end

                    main.rollEnd = math.random(5, 175)
                    main.rolling = true
                    tick = getTickCount(  )

                    setTimer( function()
                        main.rolling = false
                        main.rollingEnd = true
                      --  print(packRoll[28][1])
                        triggerServerEvent("givePlayerReward", localPlayer, localPlayer, packRoll[28][1], packRoll[28][2], packRoll[28][3], packRoll[28][4])  
                    end, rollTime+50, 1)
                end
            end

            if main.actualPage == "Diamond" then

                if isMouseIn(736*w, 538*h, 120*w, 37*h) and main.premiumInformation ~= nil then
                    local offert, cost, type, value = main.premiumInformation[1], main.premiumInformation[2], main.premiumInformation[3], main.premiumInformation[4]

                    if tonumber(getElementData(localPlayer, "player:pp")) >= cost then
                        if type == "freepremium" then
                            triggerServerEvent("buyFreePremium", localPlayer, localPlayer, main.premiumInformation)
                        elseif type == "keys" then
                            triggerServerEvent("buyKeys", localPlayer, localPlayer, main.premiumInformation)
                        else
                            triggerServerEvent("buyPremium", localPlayer, localPlayer, main.premiumInformation)
                        end
                    else
                        exports.nrpg_interface:showPlayerNotification('Nie posiadasz wystarczającej ilości punktów premium', 'error')
                    end
                end
                
                x_premium = 0
                for i,v in ipairs(store) do
                    if i >= kp and i <= np then 
                        x_premium = x_premium + 1
                        premiumOffset = (25*h)*(x_premium-1)
                        premiumOffsetText = premiumOffset*2


                        if isMouseIn(582*w, 270*h+premiumOffset, 414*w, 25*h) then
                            main.selectedPremium = i
                            main.premiumInformation = {v[1], v[2], v[3], v[4]}
                        end
                    end
                end
            end
            

            x = 0
            for i,v in ipairs(menu) do
                if i >= kmenu and i <= nmenu then 
                x = x + 1
                local offsetY = math.floor(50*h)*(x-1)
                local offsetY2 = offsetY*2

                if isMouseIn(348*w, (285*h)+offsetY, 198*w, 45*h) and main.rolling == false then
                    if v[1] == "Paczki" then 
                       -- if main.activePacks == false then
                        --    return exports.nrpg_interface:showPlayerNotification('Ta zakładka jest aktualnie wyłączona, spróbuj ponownie później.', 'error')
                        --end
                    end
                    main.selectedPack = nil
                    main.rolling = false
                    main.rollingEnd = false
                    main.actualPage = v[1]
                    main.selectedVehicle = nil
                    main.drawSelectEmoji = false
                    main.selectedPremium = nil
                    main.premiumInformation = nil
                    toggleVehicle(false)
                    scrollPos = 0
                    exports['nrpg_interface']:destroyCustomEditbox('friend:request')
                    exports["nrpg_interface"]:destroyCustomEditbox('friend:chat')
                    exports["nrpg_interface"]:destroyCustomEditbox('verify:account')
                    exports["nrpg_interface"]:destroyCustomEditbox('account:nick')
                    exports["nrpg_interface"]:destroyCustomEditbox('account:serial')
                    exports["nrpg_interface"]:destroyCustomEditbox('account:password')
                    exports["nrpg_interface"]:destroyCustomEditbox('account:passwordnew')
                    exports["nrpg_interface"]:destroyCustomEditbox('account:passwordnew2')
                    if v[1] == "Pojazdy" then
                        triggerServerEvent("showVehicleInfo", localPlayer)
                        k=0
                    end
                    if v[1] == "Ustawienia" then
                        main.settingsPage = "main"
                    end
                    if v[1] == "Znajomi" then
                        triggerServerEvent("showFriendsInfo", localPlayer)
                        triggerServerEvent("showInvitesInfo", localPlayer)
                        main.selectedFriend = nil
                        main.selectedFriendNick = nil
                        exports['nrpg_interface']:createCustomEditbox('friend:request', 'Wprowadź SID...', 785*w, 223*h, 125*w, 32*h, false, "", false, {25, 25, 25})
                        main.friendsPage = "Zaproszenia przychodzące"
                        goToDown()
                    end
                end
                end
            end
        end
    end
end)


bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage ~= "Główna" or not isMouseIn(570*w, 205*h, 450*w, 380*h) then return end
    if scrollPos > 0.01 then
    scrollPos = scrollPos - 0.5
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage ~= "Główna" or not isMouseIn(570*w, 205*h, 450*w, 380*h) then return end
    if scrollPos >= 5 then return end
    scrollPos = scrollPos + 0.5
end)


bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage == "Pojazdy" and main.selectedVehicle == nil and isMouseIn(570*w, 205*h, 450*w, 380*h) then
        if nv == mv then return end

        kv=kv-1
        nv=nv-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage == "Pojazdy" and main.selectedVehicle == nil and isMouseIn(570*w, 205*h, 450*w, 380*h) then
        if nv >= #playerInfo.vehicles then return end    

        kv=kv+1
        nv=nv+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage == "Znajomi" and isMouseIn(579*w, 335*h, 136*w, 236*h) then
        if n3 == m3 then return end

        k3=k3-1
        n3=n3-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage == "Znajomi" and isMouseIn(579*w, 335*h, 136*w, 236*h) then
        if n3 >= #playerInfo.friends then return end    

        k3=k3+1
        n3=n3+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(725*w, 272*h, 285*w, 299*h) and main.friendsPage == "Zaproszenia przychodzące" and main.actualPage == "Znajomi" then
        if n2 == m2 then return end

        k2=k2-1
        n2=n2-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(725*w, 272*h, 285*w, 299*h) and main.friendsPage == "Zaproszenia przychodzące" and main.actualPage == "Znajomi" then
        if n2 >= #playerInfo.friends_request then return end

        k2=k2+1
        n2=n2+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage == "Ustawienia" and main.settingsPage == "Grafika" and isMouseIn(570*w, 205*h, 450*w, 380*h) then
        if n4 == m4 then return end

        k4=k4-1
        n4=n4-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if main.actualPage == "Ustawienia" and main.settingsPage == "Grafika" and isMouseIn(570*w, 205*h, 450*w, 380*h) then
        if n4 >= #settings then return end

        k4=k4+1
        n4=n4+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(725*w, 272*h, 285*w, 299*h) and main.friendsPage == "Zaproszenia wychodzące" and main.actualPage == "Znajomi" then
        if n5 == m5 then return end

        k5=k5-1
        n5=n5-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(725*w, 272*h, 285*w, 299*h) and main.friendsPage == "Zaproszenia wychodzące" and main.actualPage == "Znajomi" then
        if n5 >= #playerInfo.friends_request_send then return end

        k5=k5+1
        n5=n5+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(575*w, 260*h, 440*w, 195*h) and main.actualPage == "Diamond" then
        if np == mp then return end

        kp=kp-1
        np=np-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(575*w, 260*h, 440*w, 195*h) and main.actualPage == "Diamond" then
        if np >= #store then return end

        kp=kp+1
        np=np+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(344*w, 280*h, 218*w, 305*h) then
        if nmenu == mmenu then return end

        kmenu=kmenu-1
        nmenu=nmenu-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(344*w, 280*h, 218*w, 305*h) then
        if nmenu >= #menu then return end

        kmenu=kmenu+1
        nmenu=nmenu+1
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(575*w, 520*h, 440*w, 60*h) then
        if ns == ms then return end

        ks=ks-1
        ns=ns-1
    end
end)

bindKey("mouse_wheel_down", "down", function()
    if main.toggleGUI ~= true then return end
    if isMouseIn(575*w, 520*h, 440*w, 60*h) then
        if ns >= #playerInfo.serials then return end

        ks=ks+1
        ns=ns+1
    end
end)


