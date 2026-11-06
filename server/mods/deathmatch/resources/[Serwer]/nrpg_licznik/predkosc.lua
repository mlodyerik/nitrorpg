sw, sh = guiGetScreenSize()


        
root = getRootElement()
rootElement = getResourceRootElement( getThisResource() )
uzytkownik = getLocalPlayer()
screenW, screenH = guiGetScreenSize()

skalowanie = true
c_XOffset = -45
c_YOffset = -70
c_ImageW = 400
c_ImageH = 400
c_BarW = 50
c_BarH = 50
c_BarYOffset = 70

local dxfont0_tak= dxCreateFont("tak.ttf",10)
local dxfont0_tak2= dxCreateFont("tak.ttf",10)


function getVehicleSpeed()
    if isPedInVehicle(uzytkownik) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(uzytkownik))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 130
    end
    return 0
end


addEventHandler("onClientVehicleEnter", root,
        function(thePlayer)
                if thePlayer == uzytkownik then
                        pokaz()
						licznik()
                end
        end
)

addEventHandler("onClientVehicleExit", root,
        function(thePlayer)
                if thePlayer == uzytkownik then
                        ukryj()
                end
        end
)

function okrag(liczba)
    return math.floor(liczba + 0.5)
end

function licznik()
        auto = getPedOccupiedVehicle(localPlayer)
        if auto and getVehicleController(auto) then
    if zdjecie then
        destroyElement(zdjecie)
    end
    sw, sh = guiGetScreenSize()
    local skala
    if skalowanie then
        skala = (sw/1280 + sh/720)/2
    else
        skala = 1
    end
    g_XOffset = okrag(c_XOffset*skala)
    g_YOffset = okrag(c_YOffset*skala)
    szerokosc = okrag(c_ImageW*skala)
    wysokosc = okrag(c_ImageH*skala)
    g_BarW = okrag(c_BarW*skala)
    g_BarH = okrag(c_BarH*skala)
    g_BarYOffset = okrag(c_BarYOffset*skala)
    zdjecie = guiCreateStaticImage(sw - szerokosc - g_XOffset, sh - wysokosc - g_YOffset, szerokosc, wysokosc, "licznik.png", false)
    x, y = guiGetPosition(zdjecie, false)
    guiSetVisible(zdjecie, false)
    end
end

function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
    _width = _width or 1
    dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
    dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
    dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
    return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

local sx, sy = guiGetScreenSize()
local w, h = (sx/1280),(sy/720)

local frequency = 2

function drawStrzalka()
    if isPedInVehicle(localPlayer) then
        if getElementData(localPlayer,"notshowhud") then return end
        if getElementData(localPlayer, "player:oldlicznik") then
        veh = getPedOccupiedVehicle(uzytkownik)
		local predkosc = getVehicleSpeed()
        local predkosc2 = predkosc
        local chujowe = getElementData(veh,"vehicle:mileage") or 0

        if getElementData(veh, "vehicle:licznik:rgb") then
            local curtime = getTickCount() / 1000
            r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
            g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
            b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
        else
            r, g, b = getVehicleHeadLightColor(veh)
        end
        
        if predkosc*1.4 >= 300 then predkosc2 = 300/1.4 end
        dxDrawImage(x, y, szerokosc, wysokosc, "licznik.png", 0, 0, 0, tocolor(r, g, b, 255), false)
        dxDrawImage(x, y, szerokosc, wysokosc, "strzalka.png", predkosc2, 0, 0, white, false)

        if predkosc*1.4 >= 300 then
        dxDrawText(('%01d'):format(math.floor(predkosc*1.4)).." km/h", x*2, (y/1.13)*2, szerokosc, wysokosc, tocolor(255, 255, 255, 255), 1, dxfont0_tak, "center", "center", false, false, false, false, false)
        else
        dxDrawText(('%01d'):format(math.floor(chujowe)).." km", x*2, (y/1.13)*2, szerokosc, wysokosc, tocolor(255, 255, 255, 255), 1, dxfont0_tak, "center", "center", false, false, false, false, false)
        end

        if isElementFrozen(veh) == false then
        dxDrawImage(1175*w, 621*h, 45*w, 45*h, "diody/reczny1.png")
        elseif isElementFrozen(veh) == true then
        dxDrawImage(1175*w, 621*h, 45*w, 45*h, "diody/reczny2.png")
        end
        if getElementData(veh, "vehicle:fuel") <= 10 then
        dxDrawImage(1220*w, 621*h, 45*w, 45*h, "diody/malo.png")
        elseif getElementData(veh, "vehicle:fuel") >= 10 then
        dxDrawImage(1220*w, 621*h, 45*w, 45*h, "diody/fchuj.png")
        end
        local paliwo = getElementData(veh, "vehicle:fuel")
        if paliwo >= 100 then setElementData(veh, "vehicle:fuel", 100) end
        local paliwolpg = getElementData(veh, "vehicle:fuellpg")
        if paliwolpg >= 100 then setElementData(veh, "vehicle:fuellpg", 100) end
        dxDrawRectangle(1070*w, 670*h, 185*w, 25*h, tocolor(0, 0, 0, 55), false)
        if getElementData(veh, "vehicle:togglelpg") then
            dxDrawRectangle(1070*w, 670*h, 185*w*paliwolpg/100, 25*h, tocolor(0, 255, 0, 255), false)
        else
            dxDrawRectangle(1070*w, 670*h, 185*w*paliwo/100, 25*h, tocolor(255, 255, 255, 255), false)
        end
        
        dxDrawLinedRectangle(1070*w, 670*h, 185*w, 25*h, tocolor(0, 0, 0, 255), 1, false)
    end
	end
end


isEventHandlerAdded = function( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end



function pokaz()
if isPedInVehicle(localPlayer) then
if not isEventHandlerAdded("onClientRender", root, drawStrzalka) then
    addEventHandler("onClientRender", root, drawStrzalka)
end
licznik()
end
end

function ukryj()
removeEventHandler("onClientRender", root, drawStrzalka)
licznik()
end
pokaz()