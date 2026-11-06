screen = Vector2(guiGetScreenSize());
zoom = 1920/screen.x;
dots_state = 0;
startTime = getTickCount();
endTime = startTime + 4000;
local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local sW, sH = screenW/1440, screenH/900

function myszka(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

local sx, sy = guiGetScreenSize()
local px, py = (sx/1920),(sy/1080)
local k = 1
local n = 6
local m = 6
local gui1 = false
local skiny = {

    { 71, "Cadet", 0 },
	{ 284, "Police Officer", 0 },
	{ 280, "Sergeant", 0 },
	{ 281, "Detective", 0 },
	{ 282, "Gang Unit (GU)", 0 },
	{ 285, "SWAT", 0 },
	{ 286, "Command Staff", 0 },
	{ 288, "Executive Staff", 0 },
    { 283, "Police Officerka (Kobieta)", 0 },

}

main = {

    lib = exports.nrpg_lib,
    
}

local interface = {

    backgroundRectangle = main.lib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 25, 255)),
    buttonRectangle = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(25, 25, 35, 255)),
    buttonSkins = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(70, 168, 50)),
    backButton = main.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 0, 0, 155)),

}

function gui()
    if gui1 == true then
        dxDrawImage(655*px, 245*py, 600*px, 550*py, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Przebieralnia - San Andreas Police Department", 795*px, 105*py, 1118*px, 477*py, tocolor(100, 100, 200, 255), 0.95, exports.nrpg_interface:getGUIFont("money12"), "center", "center", false, false, false, false, false)
        if myszka(805*px, 720*py, 300*px, 45*py) then
            dxDrawImage(805*px, 720*py, 300*px, 45*py, interface.backButton, 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Anuluj", 795*px, 1009*py, 1118*px, 477*py, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money9"), "center", "center", false, false, false, false, false)
        else
            dxDrawImage(805*px, 720*py, 300*px, 45*py, interface.backButton, 0, 0, 0, tocolor(255, 255, 255, 220), false)
            dxDrawText("Anuluj", 795*px, 1009*py, 1118*px, 477*py, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money9"), "center", "center", false, false, false, false, false)
        end

    local x = 0
    for i,v in pairs(skiny) do
        if i >= k and i <= n then 
            x = x + 1
            local offsetY = (sH*50)*(x-1)
            local offsetY2 = (sH*100)*(x-1)
            if myszka(805*px, 335*py+offsetY, 300*px, 50*py) then
                dxDrawImage(805*px, 335*py+offsetY, 300*px, 50*py, interface.buttonSkins, 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(805*px, 335*py+offsetY, 300*px, 50*py, interface.buttonSkins, 0, 0, 0, tocolor(255, 255, 255, 220), false)
            end
                dxDrawText(v[2] , 1220*px, 103*py+offsetY2, 690*px, 618*py, tocolor(255, 255, 255, 255), 1.0, exports.nrpg_interface:getGUIFont("money9"), "center", "center", false, false, false, false, false)
            end
        end
    end
end

local marker = createMarker(4603.61, 359.97, 5391.20, "cylinder", 1.2, 255, 255, 0, 55)
setElementDimension(marker, 0)
setElementInterior(marker, 0)
setElementData(marker, "marker:text", "PRZEBIERALNIA\nSAN ANDREAS POLICE DEPARTMENT")


addEventHandler("onClientMarkerHit", marker, function(gracz)
    if gracz ~= localPlayer then return end
    if getPedOccupiedVehicle(localPlayer) then return end
    if getElementData(localPlayer, "player:faction") == "SAPD" then 
    addEventHandler("onClientRender", root, gui)
    gui1 = true
    showCursor(true)
    end
end)

addEventHandler("onClientClick", root, function(b, s)
    if b ~= "state" and s ~= "down" then return end
    local x = 0
    if skiny then
        local x = 0
        for i,v in pairs(skiny) do
            if i >= k and i <= n then 
                x = x + 1
                local offsetY = (sH*50)*(x-1)
                local offsetY2 = (sH*120)*(x-1)
                if myszka(805*px, 335*py+offsetY, 300*px, 45*py) and gui1 == true then 
                    exports.nrpg_interface:showPlayerNotification("Pomyślnie zmieniono twój ubiór", "success")
                    triggerServerEvent("ChangePlayerSkin1", localPlayer, tonumber(v[1]))
                end
            end
        end
        if myszka(805*px, 720*py, 300*px, 45*py) and gui1 == true then 
            removeEventHandler("onClientRender", root, gui)
            gui1 = false
            showCursor(false)
        end
    end
end)

bindKey("mouse_wheel_down", "both", function()
    if gui1 == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if gui1 == true then
        scrollDown()
    end
end)

function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #skiny then return end
    k = k+1
    n = n+1
end