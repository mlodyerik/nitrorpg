local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

main = {

    theCuboid = createColRectangle( 1959.3610839844, -1826.8842773438, 1035.3498535156, 2300.19055175781),
    theArea = createRadarArea(1959.3610839844, -1826.8842773438, 1035.3498535156, 2300.19055175781, 255, 0, 0, 55),
    crosshairTarget = nil,
    plrPoints = 0,
    orgPoints = 0,

}
setRadarAreaFlashing(main.theArea, true)

zoom = exports["nrpg_interface"]:getInterfaceZoom()
rot = 0
time = 0

addEventHandler("onClientRender", root, function()
    if isElementWithinColShape(localPlayer, main.theCuboid) and not getElementData(localPlayer, "notshowhud") then
        dxDrawImage(880/zoom, 990/zoom, 30/zoom, 30/zoom, "img/crown.png", 0, 0, 0, tocolor(155, 55, 55, 255))
        dxDrawText("Respekt: "..main.plrPoints, 920/zoom, 980/zoom, 200/zoom, 1035/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, false, false)

        if getElementData(localPlayer, "player:organization") then
            dxDrawImage(880/zoom, 1020/zoom, 30/zoom, 30/zoom, "img/all.png", 0, 0, 0, tocolor(55, 155, 55, 255))
            dxDrawText("Respekt organizacji: "..main.orgPoints, 920/zoom, 1035/zoom, 200/zoom, 1035/zoom, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "left", "center", false, false, false, false, false)
        end

        if getElementData(localPlayer, "player:level") ~= 5 then
            if getElementData(localPlayer,"admin:antykill") then
                setElementData(localPlayer, "admin:antykill", false)
            end
        end
    end
end)

addEvent("dmInfoReloadClient", true)
addEventHandler("dmInfoReloadClient", root, function(arg1, arg2)
    if arg1 then
        main.plrPoints = arg1
    end

    if arg2 then
        main.orgPoints = arg2
    end
end)

local renderTarget = dxCreateRenderTarget(512, 200, true)
local lifeLinePos = 0

function renderBW()
    dxDrawRectangle(0, 0, screenW, screenH, tocolor(0, 0, 0, 155))
    dxDrawImage(0, 0, screenW, screenH, "img/vignette.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawImage(0, 0, screenW, screenH, "img/vignette.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    
    dxSetRenderTarget(renderTarget, true)
    lifeLinePos = lifeLinePos - 0.85
        for i = 1, 75 do
            local offset = math.floor(325/zoom)*(i-1)
            dxDrawImage(0+offset+lifeLinePos, 0, 512/zoom, 200/zoom, "img/lifeline.png", 0, 0, 0, tocolor(255, 0, 0, 255))
        end
    dxSetRenderTarget()
    dxDrawImage(sx / 2 - 256/zoom, sy - 230/zoom, 512/zoom, 200/zoom, renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255))

    dxDrawImage(sx/2 - 150/zoom, sy/2 - 150/zoom, 300/zoom, 300/zoom, "img/skull.png", 0, 0, 0, tocolor(200, 0, 0, 255))

    dxDrawText("Straciłeś przytomność", sx / 2 - 10/zoom, sy - 295/zoom, nil, nil, tocolor(255, 0, 0, 225), 1/zoom, exports.nrpg_interface:getGUIFont("money17"), "center", "bottom", false, false, false, false, false)
    dxDrawText("Obudzisz się za #ffaf00"..time.." sek.#e1e1e1\nAby wezwać odpowiednie służby użyj #ffaf00przycisku#e1e1e1 poniżej", sx / 2 - 10/zoom, sy - 290/zoom, nil, nil, tocolor(225, 225, 225, 225), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "center", "top", false, false, false, true, false)

    --exports['nrpg_buttons']:dxCreateButton("Wezwij pomoc", sx / 2 - 65, sy - 55/zoom, 130/zoom, 30/zoom, 1, {110, 110, 110})
end

addEvent("oknoNieprzytomnosci", true)
addEventHandler("oknoNieprzytomnosci", root, function()
	setElementData(localPlayer, "player:bw", true)
    setElementData(localPlayer, "notshowhud", true)
	addEventHandler("onClientRender", root, renderBW)
	showChat(false)
    showCursor(true)
    
    if getElementData(localPlayer, "player:level") == 4 then
        time = 5
    else
        time = 60
    end

	setTimer(function()
		time = time-1
		if time <= 0 then
			if getElementData(localPlayer, "player:bw") then
			    removeEventHandler("onClientRender", root, renderBW)
			    triggerServerEvent("zrespZmarlego", localPlayer)
			    setElementData(localPlayer, "player:bw", false)
                setElementData(localPlayer, "notshowhud", false)
			    showChat(true)
                showCursor(false)
			end
		end
	end, 1000, 60)
end)

addEvent("usunBw", true)
addEventHandler("usunBw", root, function()
    removeEventHandler("onClientRender", root, umieranie)
    triggerServerEvent("zrespZmarlego", localPlayer)
    setElementData(localPlayer, "player:bw", false)
    setElementData(localPlayer, "notshowhud", false)
    showChat(true)
end)