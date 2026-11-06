if getElementData(localPlayer, "player:sid") ~= 1 then return end

local main = {}
local zoom = 1
local sW, sH = guiGetScreenSize()
if sW < 1920 then
    zoom = math.min(2, 1920 / sW)
end

main = {

    getLib = exports.nrpg_lib,
    tab = nil,
    tireIcon = dxCreateTexture("img/tire.png"),

}

interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 25, 255)),
    backgroundRectangle2 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(25, 25, 45, 255)),
    backgroundRectangle3 = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(100, 100, 200, 255)),
    buttonRectangle = main.getLib:dgsCreateRoundRect({{12,false},{12,false},{12,false},{12,false}},tocolor(100, 100, 200, 255)),
    backgroundKeyRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(55, 55, 115, 255)),
    keyRectangle = main.getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(75, 75, 155, 255)),

}

x_1 = nil
x_2 = nil
x_3 = nil
x_4 = nil

main.renderUI = function()
    local veh = getPedOccupiedVehicle(localPlayer)
    local fL, rL, fR, rR = getVehicleWheelStates(veh)

    if fL == 1 then
        x_1 = "Uszkodzona" 
    elseif fL == 0 then 
        x_1 = "Sprawna"
    end
        
    if rL == 1 then
        x_2 = "Uszkodzona" 
    elseif rL == 0 then
        x_2 = "Sprawna"
    end
        
     if fR == 1 then
        x_3 = "Uszkodzona" 
    elseif fR == 0 then
        x_3 = "Sprawna"
    end
        
    if rR == 1 then
        x_4 = "Uszkodzona" 
    elseif rR == 0 then
        x_4 = "Sprawna" 
    end

    dxDrawImage(500/zoom, 245/zoom, 890/zoom, 580/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(510/zoom, 255/zoom, 870/zoom, 560/zoom, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    dxDrawText("Wulkanizacja", 600/zoom, 5/zoom, 1280/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "center", false, true) 
    dxDrawText("Koszt nowego zestawu opon wynosi: 5,000,000 PLN", 600/zoom, 55/zoom, 1280/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "center", "center", false, true) 

    dxDrawImage(555/zoom, 435/zoom, 775/zoom, 205/zoom, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

    dxDrawImage(585/zoom, 455/zoom, 100/zoom, 100/zoom, main.tireIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Prawy przód", 100/zoom, 600/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, true) 
    dxDrawText(x_3, 100/zoom, 640/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "center", "center", false, true) 

    dxDrawImage(785/zoom, 455/zoom, 100/zoom, 100/zoom, main.tireIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Lewy przód", 505/zoom, 600/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, true) 
    dxDrawText(x_1, 505/zoom, 640/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "center", "center", false, true) 

    dxDrawImage(985/zoom, 455/zoom, 100/zoom, 100/zoom, main.tireIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Prawy tył", 900/zoom, 600/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, true) 
    dxDrawText(x_2, 900/zoom, 640/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "center", "center", false, true) 

    dxDrawImage(1185/zoom, 455/zoom, 100/zoom, 100/zoom, main.tireIcon, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Lewy tył", 1305/zoom, 600/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money11"), "center", "center", false, true) 
    dxDrawText(x_4, 1305/zoom, 640/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light11"), "center", "center", false, true) 


    exports['nrpg_buttons']:dxCreateButton("Zakup nowy zestaw opon", 555/zoom, 655/zoom, 200/zoom, 30/zoom, 1, {55, 155, 55}, "light") 
    exports['nrpg_buttons']:dxCreateButton("Zamknij", 555/zoom, 690/zoom, 200/zoom, 30/zoom, 2, {155, 55, 55}, "light") 

    dxDrawText("Twój pojazd: Passat 1.9 TDI", 770/zoom, 775/zoom, 1170/zoom, 560/zoom, tocolor(155, 155, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, true) 
end
addEventHandler("onClientRender", root, main.renderUI)