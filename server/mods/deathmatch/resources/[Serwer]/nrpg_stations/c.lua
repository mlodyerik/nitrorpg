getLib = exports.nrpg_lib

local screenW, screenH = guiGetScreenSize()
local zoom = 1
if screenW < 1920 then
    zoom = math.min(2, 1920 / screenW)
end

main = {

    cost = {

        ["Diesel"] = 0,
        ["Benzyna"] = 0,
        ["LPG"] = 0,
        ["Elektryczny"] = 0,

    },

    settings = {

        ["Darmowe"] = false,
        ["Wybrane"] = "Brak",
        ["Zaplata"] = 0,
        ["Zatankowane"] = 0,

    },

    interface = {

        lpgIcon = dxCreateTexture("img/lpg.png"),
        dieselIcon = dxCreateTexture("img/diesel.png"),
        benzynaIcon = dxCreateTexture("img/benzyna.png"),
        bateriaIcon = dxCreateTexture("img/bateria.png"),
        stationLogo = dxCreateTexture("img/logostation.png"),
        backgroundRectangle = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(45, 45, 45, 255)),
        backgroundRectangle2 = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(175, 175, 175, 255)),
        backgroundRectangle3 = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(255, 175, 0, 255)),
        progressBar = getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(85, 85, 85, 255)),
        progressBar2 = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(55, 55, 55, 255)),
        progressBar3 = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(55, 155, 55, 255)),
        cancelButton = getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(155, 55, 55, 255)),
        buyButton = getLib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(55, 155, 55, 255)),
    
    },

}

positions = {

    {615.30, 1689.79, 6.99}, --Bone County
	{618.67, 1685.07, 6.99, "lpg"}, --Bone County
	{611.81, 1694.76, 6.99, "lpg"}, --Bone County
	{622.31, 1680.13, 6.99}, --Bone County
	{608.07, 1699.68, 6.99}, --Bone County
	{604.95, 1704.77, 6.99, "lpg"}, --Bone County
	{2114.96, 928.34, 10.82}, --Las Venturas, The Strip
	{2114.96, 922.47, 10.82, "lpg"}, --Las Venturas, The Strip
	{2114.96, 917.5, 10.82}, --Las Venturas, The Strip
	{2115.96, 911.85, 10.82, "lpg"}, --Las Venturas, The Strip
	{2210.49, 2474.69, 10.82}, --Las Venturas, The Emerald Isle
	{2204.9, 2474.69, 10.82, "lpg"}, --Las Venturas, The Emerald Isle
	{2199.7, 2474.69, 10.82, "lpg"}, --Las Venturas, The Emerald Isle
	{2194.1, 2474.69, 10.82}, --Las Venturas, The Emerald Isle
	{2639.92, 1114.6, 10.82, "lpg"}, --Las Venturas, Come-A-Lot
	{2639.92, 1108.9, 10.82}, --Las Venturas, Come-A-Lot
	{2639.92, 1103.8, 10.82}, --Las Venturas, Come-A-Lot
	{2639.92, 1098.1, 10.82, "lpg"}, --Las Venturas, Come-A-Lot
	{389.62, 2532.33, 16.54}, --Opuszczone lotnisko
	{331.46, 2547.72, 16.80}, --Opuszczone lotnisko
	{297.99, 2546.05, 16.82}, --Opuszczone lotnisko
	{3149.05, -816.1, 11.00, "lpg"}, --Wyspa Los Santos
	{3154.9, -816.1, 11.00}, --Wyspa Los Santos
	{1938.8, -1772.65, 13.38}, --Los Santos, Idlewood
    {1944.48, -1772.65, 13.39, "lpg"}, --Los Santos, Idlewood
	{-93.76, -1175.28, 2.26}, --Flint County 
	{-88.65, -1163.31, 2.24, "lpg"}, --Flint County 
	{1380.68, 457.22, 19.97}, --Montgomery
	{1383.17, 462.1, 20.13}, --Montgomery
	{658.92, -559.57, 16.34}, --Dillimore
	{658.92, -570.27, 16.34}, --Dillimore
	--{-2023.52, 156.67, 28.84}, --Doherty
	--{-2029.71, 157.25, 28.84, "lpg"}, --Doherty
	{-1681.50, 405.89, 7.18}, --San Fierro, Easter Basin
	{-1668.04, 419.07, 7.18}, --San Fierro, Easter Basin
	{-1675.00, 412.56, 7.18, "lpg"}, --San Fierro, Easter Basin
	{-1677.31, 400.61, 7.18}, --San Fierro, Easter Basin
	{-1670.24, 407.56, 7.18, "lpg"}, --San Fierro, Easter Basin
	{-1663.21, 414.23, 7.18}, --San Fierro, Easter Basin
	{-1674.14, 426.05, 7.18}, --San Fierro, Easter Basin
	{-1681.44, 418.83, 7.18, "lpg"}, --San Fierro, Easter Basin
	{-1688.05, 412.01, 7.18}, --San Fierro, Easter Basin
	{1596.20, 2207.70, 10.82}, --Las Venturas, Redsands West
	{1596.20, 2201.65, 10.82, "lpg"}, --Las Venturas, Redsands West
	{1596.20, 2196.30, 10.82, "lpg"}, --Las Venturas, Redsands West
	{1596.20, 2190.92, 10.82}, --Las Venturas, Redsands West

}

main.drawProgressbar = function(progress)
    dxDrawImage(750/zoom, 720/zoom, 550/zoom, 25/zoom, main.interface.progressBar, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(755/zoom, 725/zoom, 540/zoom, 15/zoom, main.interface.progressBar2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(755/zoom, 725/zoom, 540/zoom*(progress/100), 15/zoom, main.interface.progressBar3, 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

main.renderStation = function()
    dxDrawImage(450/zoom, 275/zoom, 1000/zoom, 570/zoom, main.interface.backgroundRectangle3, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(452/zoom, 277/zoom, 996/zoom, 566/zoom, main.interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    local veh = getPedOccupiedVehicle(localPlayer)

    dxDrawText("Wybrany typ: #fffb2b"..main.settings["Wybrane"].."#e1e1e1\nCena za litr: #ffb638"..convertNumber((main.cost[main.settings["Wybrane"]] or 0)).." PLN".."\n#e1e1e1Do zapłaty: #ff6969"..convertNumber(main.settings["Zaplata"]).." PLN", 755/zoom, 450/zoom, 500/zoom, 705/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "left", "bottom", false, false, false, true, false)
    dxDrawText("Typ silnika: #f9ff3d"..exports["nrpg_vehicleAddons"]:getVehicleEngine(veh), 750/zoom, 450/zoom, 1290/zoom, 705/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "right", "bottom", false, false, false, true, false)
    
    if main.settings["Wybrane"] == "Brak" then
        actualFuel = 0
        actualBak = 0
        dxDrawText("Napełnienie baku:#1aff00\n"..math.floor(main.settings["Zatankowane"]).."/"..actualBak.." L", 750/zoom, 450/zoom, 1290/zoom, 705/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
    elseif main.settings["Wybrane"] == "Elektryczny" then
        actualFuel = getElementData(veh, "vehicle:fuel") or 0
        actualBak = 100
        dxDrawText("Poziom naładowania baterii:#1aff00\n"..math.floor(main.settings["Zatankowane"]).."/"..actualBak.." %", 750/zoom, 450/zoom, 1290/zoom, 705/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
    elseif main.settings["Wybrane"] == "LPG" then
        actualFuel = getElementData(veh, "vehicle:fuellpg") or 0
        actualBak = 100
        dxDrawText("Napełnienie butli:#1aff00\n"..math.floor(main.settings["Zatankowane"]).."/"..actualBak.." L", 750/zoom, 450/zoom, 1290/zoom, 705/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
    else
        actualFuel = getElementData(veh, "vehicle:fuel") or 0
        actualBak = getElementData(veh, "vehicle:bak") or 25
        dxDrawText("Napełnienie baku:#1aff00\n"..math.floor(main.settings["Zatankowane"]).."/"..actualBak.." L", 750/zoom, 450/zoom, 1290/zoom, 705/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)
    end

    dxDrawText("Przytrzymaj #00b3ffspację#e1e1e1 aby rozpocząć\n#7bff63tankowanie pojazdu", 750/zoom, 450/zoom, 1290/zoom, 785/zoom, tocolor(225, 225, 225, 225), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, false, true, false)

    if main.settings["Zatankowane"] < 2 then 
        progressBarActual = 0
    else
        progressBarActual = main.settings["Zatankowane"]
    end
    
    main.drawProgressbar(progressBarActual)

    if main.settings["Wybrane"] ~= "Brak" then
        if isMouseIn(750/zoom, 755/zoom, 125/zoom, 25/zoom) then
            dxDrawImage(750/zoom, 755/zoom, 125/zoom, 25/zoom, main.interface.buyButton, 0, 0, 0, tocolor(255, 255, 255, 175), false)
            dxDrawText("Zapłać", 815/zoom, 770/zoom, nil, nil, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        else
            dxDrawImage(750/zoom, 755/zoom, 125/zoom, 25/zoom, main.interface.buyButton, 0, 0, 0, tocolor(255, 255, 255, 200), false)
            dxDrawText("Zapłać", 815/zoom, 770/zoom, nil, nil, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        end
    else
        dxDrawImage(750/zoom, 755/zoom, 125/zoom, 25/zoom, main.interface.buyButton, 0, 0, 0, tocolor(255, 255, 255, 155), false)
        dxDrawText("Zapłać", 815/zoom, 770/zoom, nil, nil, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
    end
 
    if main.settings["Wybrane"] == "Brak" then
        dxDrawImage(452/zoom, 277/zoom, 996/zoom, 566/zoom, main.interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 155), false)
    else
        if main.settings["Wybrane"] == "LPG" then
            eldataKey = "vehicle:fuellpg"
        else
            eldataKey = "vehicle:fuel"
        end

        if getKeyState("space") == true then
            if main.settings["Zatankowane"] >= actualBak then
                main.settings["Zatankowane"] = actualBak
            else
                main.settings["Zatankowane"] = main.settings["Zatankowane"] + 0.1
                main.settings["Zaplata"] = main.settings["Zaplata"] + math.floor((main.cost[main.settings["Wybrane"]]/10))
            end
        end
    end

    if isMouseIn(490/zoom, 320/zoom, 100/zoom, 100/zoom) then
        dxDrawImage(490/zoom, 320/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 75), false)
        dxDrawImage(520/zoom, 345/zoom, 45/zoom, 45/zoom, main.interface.lpgIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("LPG", 980/zoom, 570/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za litr:", 980/zoom, 680/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["LPG"]).." PLN", 980/zoom, 710/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    else
        dxDrawImage(490/zoom, 320/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)
        dxDrawImage(520/zoom, 345/zoom, 45/zoom, 45/zoom, main.interface.lpgIcon, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText("LPG", 980/zoom, 570/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za litr:", 980/zoom, 680/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["LPG"]).." PLN", 980/zoom, 710/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    end

    if isMouseIn(490/zoom, 435/zoom, 100/zoom, 100/zoom) then
        dxDrawImage(490/zoom, 435/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 75), false)
        dxDrawImage(520/zoom, 460/zoom, 40/zoom, 40/zoom, main.interface.dieselIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Diesel", 980/zoom, 800/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za litr:", 980/zoom, 910/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["Diesel"]).." PLN", 980/zoom, 940/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    else
        dxDrawImage(490/zoom, 435/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)
        dxDrawImage(520/zoom, 460/zoom, 40/zoom, 40/zoom, main.interface.dieselIcon, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText("Diesel", 980/zoom, 800/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za litr:", 980/zoom, 910/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["Diesel"]).." PLN", 980/zoom, 940/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    end

    if isMouseIn(490/zoom, 550/zoom, 100/zoom, 100/zoom) then
        dxDrawImage(490/zoom, 550/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 75), false)
        dxDrawImage(520/zoom, 572/zoom, 40/zoom, 40/zoom, main.interface.benzynaIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Benzyna", 980/zoom, 1030/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za litr:", 980/zoom, 1140/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["Benzyna"]).." PLN", 980/zoom, 1170/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    else
        dxDrawImage(490/zoom, 550/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)
        dxDrawImage(520/zoom, 572/zoom, 40/zoom, 40/zoom, main.interface.benzynaIcon, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText("Benzyna", 980/zoom, 1030/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za litr:", 980/zoom, 1140/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["Benzyna"]).." PLN", 980/zoom, 1170/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    end

    if isMouseIn(490/zoom, 665/zoom, 100/zoom, 100/zoom) then
        dxDrawImage(490/zoom, 665/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 75), false)
        dxDrawImage(522/zoom, 690/zoom, 35/zoom, 35/zoom, main.interface.bateriaIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Ładowanie", 980/zoom, 1260/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za 1%:", 980/zoom, 1370/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["Elektryczny"]).." PLN", 980/zoom, 1400/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 200), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    else
        dxDrawImage(490/zoom, 665/zoom, 100/zoom, 100/zoom, main.interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)
        dxDrawImage(522/zoom, 690/zoom, 35/zoom, 35/zoom, main.interface.bateriaIcon, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText("Ładowanie", 980/zoom, 1260/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
        dxDrawText("Cena za 1%:", 980/zoom, 1370/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 155), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
        dxDrawText(convertNumber(main.cost["Elektryczny"]).." PLN", 980/zoom, 1400/zoom, 100/zoom, 100/zoom, tocolor(155, 255, 155, 155), 1, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, false, false, true, false)
    end

    if isMouseIn(490/zoom, 775/zoom, 100/zoom, 25/zoom) then
        dxDrawImage(490/zoom, 775/zoom, 100/zoom, 25/zoom, main.interface.cancelButton, 0, 0, 0, tocolor(255, 255, 255, 175), false)
        dxDrawText("Zamknij okno", 980/zoom, 1475/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 175), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
    else
        dxDrawImage(490/zoom, 775/zoom, 100/zoom, 25/zoom, main.interface.cancelButton, 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText("Zamknij okno", 980/zoom, 1475/zoom, 100/zoom, 100/zoom, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("light10"), "center", "center", false, false, false, true, false)
    end
    
    
    dxDrawImage(850/zoom, 295/zoom, 350/zoom, 350/zoom, main.interface.stationLogo, 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

addEventHandler("onClientClick", root, function(button, state)
    if button == "left" and state == "up" and main.settings["GUI"] == true then
        if isMouseIn(490/zoom, 320/zoom, 100/zoom, 100/zoom) then
            if not getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:lpg") then exports.nrpg_interface:showPlayerNotification("Nie posiadasz butli LPG w pojeździe", "error") return end
            main.settings["Zatankowane"] = getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:fuellpg")
            main.settings["Zaplata"] = 0
            main.settings["Wybrane"] = "LPG"
        elseif isMouseIn(490/zoom, 435/zoom, 100/zoom, 100/zoom) then
            if exports["nrpg_vehicleAddons"]:getVehicleEngine(getPedOccupiedVehicle(localPlayer)) ~= "Diesel" then exports.nrpg_interface:showPlayerNotification("Nie możesz zatankować tego paliwa do tego pojazdu", "error") return end
            main.settings["Zatankowane"] = getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:fuel")
            main.settings["Zaplata"] = 0
            main.settings["Wybrane"] = "Diesel"
        elseif isMouseIn(490/zoom, 550/zoom, 100/zoom, 100/zoom) then
            if exports["nrpg_vehicleAddons"]:getVehicleEngine(getPedOccupiedVehicle(localPlayer)) ~= "Benzynowy" then exports.nrpg_interface:showPlayerNotification("Nie możesz zatankować tego paliwa do tego pojazdu", "error") return end
            main.settings["Zatankowane"] = getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:fuel")
            main.settings["Zaplata"] = 0
            main.settings["Wybrane"] = "Benzyna"
        elseif isMouseIn(490/zoom, 665/zoom, 100/zoom, 100/zoom) then
            if exports["nrpg_vehicleAddons"]:getVehicleEngine(getPedOccupiedVehicle(localPlayer)) ~= "Elektryczny" then exports.nrpg_interface:showPlayerNotification("Nie posiadasz baterii w pojeździe", "error") return end
            main.settings["Zatankowane"] = getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:fuel")
            main.settings["Zaplata"] = 0
            main.settings["Wybrane"] = "Elektryczny"
        elseif isMouseIn(750/zoom, 755/zoom, 125/zoom, 25/zoom) and main.settings["Wybrane"] ~= "Brak" and tonumber(main.settings["Zaplata"]) > 0 then
            if getPlayerMoney(localPlayer) > main.settings["Zaplata"] then
                if main.settings["Wybrane"] == "LPG" then
                    eldataKey = "vehicle:fuellpg"
                else
                    eldataKey = "vehicle:fuel"
                end
                setElementData(getPedOccupiedVehicle(localPlayer), eldataKey, main.settings["Zatankowane"])
                triggerServerEvent("takePlayerMoney", localPlayer, main.settings["Zaplata"])

                main.settings["Zaplata"] = 0
            else
                exports.nrpg_interface:showPlayerNotification("Nie masz tyle pieniędzy", "error")
            end
        elseif isMouseIn(490/zoom, 775/zoom, 100/zoom, 25/zoom) then
            removeEventHandler("onClientRender", root, main.renderStation)
            showCursor(false)
            main.settings["GUI"] = false
            main.settings["Zatankowane"] = 0
            main.settings["Zaplata"] = 0
            main.settings["Wybrane"] = "Brak"
        end
    end
end)

addEvent("getPetrolCost", true)
addEventHandler("getPetrolCost", root, function(type)
    if main.settings["Darmowe"] == true then
        main.cost["Diesel"] = 0
        main.cost["LPG"] = 0
        main.cost["Benzyna"] = 0
        main.cost["Elektryczny"] = 0
    else
        if getElementData(localPlayer, "player:premiumplus") then
            main.cost["Diesel"] = math.floor(type.Diesel/2)
            main.cost["LPG"] = math.floor(type.LPG/2)
            main.cost["Benzyna"] = math.floor(type.Benzyna/2)
            main.cost["Elektryczny"] = math.floor(type.Elektryczny/2)
        else
            main.cost["Diesel"] = type.Diesel
            main.cost["LPG"] = type.LPG
            main.cost["Benzyna"] = type.Benzyna
            main.cost["Elektryczny"] = type.Elektryczny
        end
    end
end)

function openGUI(el)
    if el == localPlayer then
        if not getPedOccupiedVehicle(localPlayer) then return end
        addEventHandler("onClientRender", root, main.renderStation)
        showCursor(true)
        main.settings["GUI"] = true
        main.settings["Zatankowane"] = 0
        main.settings["Zaplata"] = 0
        main.settings["Wybrane"] = "Brak"
        triggerServerEvent("getPetrolCostServer", localPlayer)
    end
end

function closeGUI(el)
    if el == localPlayer then
        if not getPedOccupiedVehicle(localPlayer) then return end
        removeEventHandler("onClientRender", root, main.renderStation)
        showCursor(false)
        main.settings["GUI"] = false
        main.settings["Zatankowane"] = 0
        main.settings["Zaplata"] = 0
        main.settings["Wybrane"] = "Brak"
    end
end

for i,v in ipairs(positions) do
    local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 4.25, 255, 175, 0, 185)
    setElementData(marker, "marker:text", "Stacja Paliw")
    setElementData(marker, "marker:icon", "station")
    setElementData(marker, "marker:downtext", "Zapraszamy na tankowanie")
    createBlipAttachedTo(marker, 56, 2, 255, 0, 0, 255, 1, 275)

    addEventHandler("onClientMarkerHit", marker, openGUI)
    addEventHandler("onClientMarkerLeave", marker, closeGUI)
end

function isMouseIn(x, y, width, height)
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

function convertNumber(amount) 
	local formatted = amount 
		while true do   
			formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
			
			if (k==0) then 
				break 
	  		end 
		end 
	return formatted 
end

local time=getTickCount()
local isBike={[509]=true,[481]=true,[510]=true}

local function naliczaj(veh)
	if getTickCount()-time>5000 then
		time = getTickCount()
		local fuel = getElementData(veh, "vehicle:fuel") or 0
		local mileage = getElementData(veh,"vehicle:mileage") or 0
		if not getElementData(veh, "vehicle:id") then return end
		local vx,vy,vz = getElementVelocity(veh)
		local spd=((vx^2 + vy^2 + vz^2)^(0.5)/2)
		if spd > 0 then
			fuel = fuel-(spd*2)/3
			setElementData(veh, "vehicle:fuel", fuel)
			mileage = mileage+(spd)
			setElementData(veh, "vehicle:mileage", mileage)
		end
	end
end

local function naliczajLPG(veh)
	if getTickCount()-time>5000 then
		time = getTickCount()
		local fuel = getElementData(veh, "vehicle:fuellpg") or 0
		local mileage = getElementData(veh,"vehicle:mileage") or 0
		if not getElementData(veh, "vehicle:id") then return end
		local vx,vy,vz = getElementVelocity(veh)
		local spd=((vx^2 + vy^2 + vz^2)^(0.5)/2)
		if spd > 0 then
			fuel = fuel-(spd*2)/3
			setElementData(veh, "vehicle:fuellpg", fuel)
			mileage = mileage+(spd)
			setElementData(veh, "vehicle:mileage", mileage)
		end
	end
end

addEventHandler("onClientRender", root, function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	if isBike[getElementModel(vehicle)] then return end
	if not getVehicleEngineState(vehicle) then return end
	if not getElementData(vehicle, "vehicle:id") then return end
	if getElementData(vehicle, "vehicle:togglelpg") then
		if getElementData(vehicle,"vehicle:fuellpg") and getElementData(vehicle,"vehicle:fuellpg") or getElementData(vehicle,"vehicle:mileage") and getElementData(vehicle,"vehicle:mileage") then
			naliczajLPG(vehicle)
			if getElementData(vehicle,"vehicle:fuellpg") < 1 then
				setVehicleEngineState(vehicle, false)
			end
		end
	else
		if getElementData(vehicle,"vehicle:fuel") and getElementData(vehicle,"vehicle:fuel") or getElementData(vehicle,"vehicle:mileage") and getElementData(vehicle,"vehicle:mileage") then
			naliczaj(vehicle)
			if getElementData(vehicle,"vehicle:fuel")<1 then
				setVehicleEngineState(vehicle, false)
			end
		end
	end
end)
