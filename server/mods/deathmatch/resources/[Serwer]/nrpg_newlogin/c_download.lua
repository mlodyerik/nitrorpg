--[[

    @author: TheNoobisty <thenoobisty@gmail.com>
    @resource: nrpg_login
    @description: Login Panel
    @file: c_download.lua

    @info: Zakazuje się używania bądź edycji kodu bez zgody autora w przeciwnym razie sprawa zostanie skierowana do sądu.

]]--

download = {

    clientDownloaded = 0,
    background = "img/background.jpg",
    lib = exports.nrpg_lib,

}

download.informations = {

    [1] = "AKTUALNIE POBIERANE SĄ ZASOBY SERWERA, POCZEKAJ AŻ WSZYSTKO SIĘ POBIERZE",
    [2] = "NASZ SERWER TO PSEUDOLEK, KTÓRY JEST CIĄGLE ROZWIJANY",
    [3] = "PODMIANKI / TUNING / PUNKTY PREMIUM ZAKUPISZ U WŁAŚCICIELI",
    [4] = "JEŚLI JESTEŚ NOWY/A KLIKNIJ F1 PO ZALOGOWANIU ABY OTWORZYĆ PANEL POMOCY",
    [5] = "ROZGRYWKA TOCZY SIĘ NA CAŁEJ MAPIE",
    [6] = "ZARZĄD SERWERA: PAKU, WAMPIROS, NAJBER, THENOOBISTY",
    [7] = "PRACE OZNACZONE SĄ ZNACZKIEM 'W'",
    [8] = "PRAWO JAZDY ZDASZ W URZĘDZIE",

}

randomTip = math.random(1, #download.informations)
tipAlpha = 255

interface = {

    loading = download.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 45, 255)),
    loadingtask = download.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(80, 80, 160, 255)),
    loadingpointer = download.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 200, 255)),

}

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local w, h = (sx/1366), (sy/768)
local zoom = 1
local tick = getTickCount()
local tickTip = getTickCount()
local tickText = getTickCount()
if sx < 1366 then
    zoom = math.min(2, 1366 / sx)
end


download.renderDownload = function()
    if download.drawDownloadPanel == true then
        local pos = interpolateBetween(0, 0, 0, -1000, 0, 0, (getTickCount() - tick)/60000, "SineCurve")
        dxDrawImage(pos*w, 0*h, 2851*w, 882*h, download.background, 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawRectangle(0*w, 0*h, 1366*w, 768*h, tocolor(15, 15, 25, 200), true)
        dxDrawText("POBIERANIE ZASOBÓW", 379*w, 236*h, 988*w, 363*h, tocolor(60, 60, 102, 255), 1.00, exports.nrpg_interface:getGUIFont("money25"), "center", "bottom", false, false, true, false, false)    
        
        if (getTickCount() - tickTip) >= (7500) then
            tickTip = getTickCount()
            createAnimation(tipAlpha, 0, 'Linear', 2000, function(value) tipAlpha = value end)
            
            setTimer(function()
                randomTip = math.random(1, #download.informations)
                createAnimation(tipAlpha, 255, 'Linear', 2000, function(value) tipAlpha = value end)  
            end, 2050, 1)
        end

        dxDrawText(download.informations[randomTip], 379*w, 363*h, 988*w, 490*h, tocolor(60, 60, 102, tipAlpha), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, true, false, false)

        dxDrawText("POSTĘP POBIERANIA", 553*w, 665*h, 813*w, 710*h, tocolor(169, 169, 0, 255), 1.00, exports.nrpg_interface:getGUIFont("money10"), "center", "bottom", false, false, true, false, false)
        dxDrawText(math.floor(download.clientDownloaded).."%", 553*w, 710*h, 813*w, 734*h, tocolor(169, 169, 0, 255), 1.00, exports.nrpg_interface:getGUIFont("light10"), "center", "top", false, false, true, false, false)
        local alpha = interpolateBetween(100, 0, 0, 200, 0, 0, (getTickCount() - tick)/2000, "SineCurve")

        dxDrawImage(15*w, 739*h, 1336*w, 12*h, interface.loading, 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawImage(15*w, 739*h, 1336*(download.clientDownloaded or 0)/100*w, 12*h, interface.loadingtask, 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        dxDrawImage(1336*(download.clientDownloaded or 0)/100*w, 739*h, 16*w, 12*h, interface.loadingpointer, 0, 0, 0, tocolor(255, 255, 255, 255), true)

        if (getTickCount() - tick) >= (5000) then
            if download.clientDownloaded == 0 then
                download.stopDownloadScreen()
                download.clientDownloaded = 0
            end
        end
        if download.clientDownloaded >= 100 or download.clientDownloaded == 100 then
            download.stopDownloadScreen()
            download.clientDownloaded = 0
        end
    end
end


download.loadDownloadPercent = function(downloadedSize, totalSize)
    percentage = math.min((downloadedSize / totalSize) * 100, 100)
    download.clientDownloaded = percentage
end
addEventHandler("onClientTransferBoxProgressChange", root, download.loadDownloadPercent)


download.stopDownloadScreen = function()
    removeEventHandler("onClientRender", root, download.renderDownload)
    download.drawDownloadPanel = false
    triggerEvent("openLoginPanel", localPlayer, localPlayer)
end


download.startDownload = function()
    if not getElementData(localPlayer, "player:sid") then
        setElementData(localPlayer, "notshowhud", true)
        addEventHandler("onClientRender", root, download.renderDownload)
        showChat(false)
        download.drawDownloadPanel = true
    end
end
--download.startDownload()