local main = {

    getLib = exports.nrpg_lib,

}

local sW,sH = guiGetScreenSize()
local zoom = 1
if sW < 1920 then
    zoom = math.min(2, 1920 / sW)
end

local k = 1
local n = 8
local m = 8

local interface = {

    backgroundRectangle = main.getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 30, 255)),
    shadowRectangle = main.getLib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(25, 25, 45, 255)),
    shadowRectangle2 = main.getLib:dgsCreateRoundRect({{0,false},{0,false},{15,false},{15,false}},tocolor(60, 60, 110, 255)),
    buttonRectangle = main.getLib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(40, 40, 70, 255)),

    categoryRectangle1 = main.getLib:dgsCreateRoundRect({{0,false},{0,false},{0,false},{15,false}},tocolor(60, 60, 110, 255)),
    categoryRectangle2 = main.getLib:dgsCreateRoundRect({{0,false},{0,false},{0,false},{0,false}},tocolor(60, 60, 110, 255)),

    scrollbarRectangle = main.getLib:dgsCreateRoundRect({{2,false},{2,false},{2,false},{2,false}},tocolor(100, 100, 200, 255)),

}

local textures = {

    star = dxCreateTexture("star.png"),
    star2 = dxCreateTexture("star2.png"),
    stop = dxCreateTexture("stop.png"),
    play = dxCreateTexture("play.png"),
    trash = dxCreateTexture("trash.png"),

}

local songs = {}
local actualPage = "Wszystkie"
local stereo = {}
local play = nil
local actualSong = "Brak"
local stereoPanel = false
local tick = getTickCount()
local soundDataTime = {}
local soundDataTime2 = {}
local animation = nil

addEventHandler("onClientRender", root, function()
local veh = getPedOccupiedVehicle(localPlayer)
    if veh then
        if stereo[veh] ~= nil then
            local soundTime = getSoundLength(stereo[veh]) 
            if (getTickCount() - tick) >= (5) and soundTime then
                if not soundDataTime[veh] then soundDataTime[veh] = 0 end
                if not soundDataTime2[veh] then soundDataTime2[veh] = 0 end
                    
                soundDataTime[veh] = soundDataTime[veh] + 0.01
                soundDataTime2[veh] = soundDataTime2[veh] + 0.01
    
                tick = getTickCount()
    
                if math.floor(soundDataTime[veh]) > math.floor((soundTime or 0)) then
                    soundDataTime[veh] = 0
                    soundDataTime2[veh] = 0
                end
            end
        end
    end
end)

function drawStereo()
    dxDrawImage(500/zoom, 250/zoom, 950/zoom, 600/zoom, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(520/zoom, 350/zoom, 905/zoom, 470/zoom, interface.shadowRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(520/zoom, 795/zoom, 905/zoom, 35/zoom, interface.shadowRectangle2, 0, 0, 0, tocolor(255, 255, 255, 155), false)


    if isMouseIn(520/zoom, 795/zoom, 200/zoom, 35/zoom) then
        dxDrawImage(520/zoom, 795/zoom, 200/zoom, 35/zoom, interface.categoryRectangle1, 0, 0, 0, tocolor(255, 255, 255, 175), false)
        dxDrawText("Ulubione", 590/zoom, 1590/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, false, false, false, false)
    else
        dxDrawImage(520/zoom, 795/zoom, 200/zoom, 35/zoom, interface.categoryRectangle1, 0, 0, 0, tocolor(255, 255, 255, 125), false)
        dxDrawText("Ulubione", 590/zoom, 1590/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, false, false, false, false)
    end

    if isMouseIn(722/zoom, 795/zoom, 200/zoom, 35/zoom) then
        dxDrawImage(722/zoom, 795/zoom, 200/zoom, 35/zoom, interface.categoryRectangle2, 0, 0, 0, tocolor(255, 255, 255, 175), false)
        dxDrawText("Wszystkie", 790/zoom, 1590/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, false, false, false, false)
    else
        dxDrawImage(722/zoom, 795/zoom, 200/zoom, 35/zoom, interface.categoryRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
        dxDrawText("Wszystkie", 790/zoom, 1590/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, false, false, false, false)
    end

    dxDrawText("Aktualnie odtwarzane: "..actualSong, 790/zoom, 1588/zoom, 1405/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "right", "center", false, false, false, false, false)
    
    local veh = getPedOccupiedVehicle(localPlayer)
    if veh then
        if stereo[veh] and actualSong ~= "Brak" then
            local soundTime = getSoundLength (stereo[veh]) 
            if soundTime then
                dxDrawImage(735/zoom, 319/zoom, 650/zoom, 8/zoom, interface.scrollbarRectangle, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                dxDrawImage(735/zoom, 319/zoom, 650/zoom*(soundDataTime2[veh] or 0)/(soundTime or 0), 8/zoom, interface.scrollbarRectangle, 0, 0, 0, tocolor(255, 255, 255, 175), false)

                dxDrawText(secondsToClock(soundDataTime[veh]), 735/zoom, 637/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
                dxDrawText(secondsToClock((soundTime or 0)), 1360/zoom, 637/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
            end
        else
            dxDrawImage(735/zoom, 319/zoom, 650/zoom, 8/zoom, interface.scrollbarRectangle, 0, 0, 0, tocolor(255, 255, 255, 100), false)

            dxDrawText("0:00", 735/zoom, 637/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
            dxDrawText("0:00", 1360/zoom, 637/zoom, 200/zoom, 35/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
        end
    end

    exports["nrpg_buttons"]:dxCreateButton("Dodaj utwór", 520/zoom, 310/zoom, 175/zoom, 28/zoom, 1, {50, 50, 100}, "light")

    x = 0
    for i,v in ipairs(songs) do
        if i >= k and i <= n then 
        x = x + 1
        local offsetY = (55/zoom)*(x-1)
        local offsetY2 = (offsetY*2)


        if isMouseIn(520/zoom, 350/zoom+offsetY, 905/zoom, 55/zoom) then
            dxDrawImage(520/zoom, 350/zoom+offsetY, 905/zoom, 55/zoom, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 200), false)
            dxDrawText(v.nazwa, 585/zoom, 686/zoom+offsetY2, 905/zoom, 50/zoom, tocolor(200, 200, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "left", "center", false, false, false, false, false)
            if string.len(v.link) >= 100 then
                dxDrawText(string.sub(v.link, 1, 100).."...", 585/zoom, 722/zoom+offsetY2, 905/zoom, 50/zoom, tocolor(200, 200, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
            else
                dxDrawText(v.link, 585/zoom, 722/zoom+offsetY2, 905/zoom, 50/zoom, tocolor(200, 200, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
            end
        else
            dxDrawImage(520/zoom, 350/zoom+offsetY, 905/zoom, 55/zoom, interface.buttonRectangle, 0, 0, 0, tocolor(255, 255, 255, 190), false)
            dxDrawText(v.nazwa, 585/zoom, 686/zoom+offsetY2, 905/zoom, 50/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("money12"), "left", "center", false, false, false, false, false)
            if string.len(v.link) >= 50 then
                dxDrawText(string.sub(v.link, 1, 50).."...", 585/zoom, 722/zoom+offsetY2, 905/zoom, 50/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
            else
                dxDrawText(v.link, 585/zoom, 722/zoom+offsetY2, 905/zoom, 50/zoom, tocolor(200, 200, 255, 155), 1/zoom, exports.nrpg_interface:getGUIFont("light10"), "left", "center", false, false, false, false, false)
            end
        end

        if v.ulubione == 1 then
            dxDrawImage(535/zoom, 358/zoom+offsetY, 35/zoom, 35/zoom, textures.star2, 0, 0, 0, tocolor(200, 200, 255, 200), false)
        else
            dxDrawImage(535/zoom, 358/zoom+offsetY, 35/zoom, 35/zoom, textures.star, 0, 0, 0, tocolor(200, 200, 255, 200), false)
        end

        if play == i then
            dxDrawImage(1375/zoom, 368/zoom+offsetY, 20/zoom, 20/zoom, textures.stop, 0, 0, 0, tocolor(200, 200, 255, 200), false)
        else
            dxDrawImage(1375/zoom, 368/zoom+offsetY, 20/zoom, 20/zoom, textures.play, 0, 0, 0, tocolor(200, 200, 255, 200), false)
        end

        if isMouseIn(1332/zoom, 363/zoom+offsetY, 30/zoom, 30/zoom) then
            dxDrawImage(1332/zoom, 363/zoom+offsetY, 30/zoom, 30/zoom, textures.trash, 0, 0, 0, tocolor(200, 200, 255, 175), false)
        else
            dxDrawImage(1332/zoom, 363/zoom+offsetY, 30/zoom, 30/zoom, textures.trash, 0, 0, 0, tocolor(200, 200, 255, 200), false)
        end
        end
    end
    drawScrollbar(songs, 1430/zoom, 350/zoom, 475/zoom, m, k)
end

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" and stereoPanel == true then
        x = 0
        for i,v in ipairs(songs) do
            if i >= k and i <= n then 
            x = x + 1
            local offsetY = (55/zoom)*(x-1)
            local offsetY2 = (offsetY*2)

            if isMouseIn(535/zoom, 358/zoom+offsetY, 35/zoom, 35/zoom) then
                if v.ulubione == 0 then
                    triggerServerEvent("stereo:toggleFavourite", localPlayer, v.id, true)
                else
                    triggerServerEvent("stereo:toggleFavourite", localPlayer, v.id, false)
                end
            end

            if isMouseIn(1332/zoom, 363/zoom+offsetY, 30/zoom, 30/zoom) then
                triggerServerEvent("stereo:deleteMusic", localPlayer, v.id)
            end

            if isMouseIn(1375/zoom, 368/zoom+offsetY, 20/zoom, 20/zoom) then
                local veh = getPedOccupiedVehicle(localPlayer)

                if veh then
                    if play ~= i then
                        play = nil
                        actualSong = "Brak"
                        setElementData(veh, "vehicle:stereo", false)
                        play = i
                        actualSong = v.nazwa
                        setElementData(veh, "vehicle:link", tostring(v.link))
                        setElementData(veh, "vehicle:stereo", true)
                    elseif play == nil then
                        play = i
                        actualSong = v.nazwa
                        setElementData(veh, "vehicle:link", tostring(v.link))
                        setElementData(veh, "vehicle:stereo", true)
                    elseif stereo[source] == nil then
                        play = nil
                        actualSong = "Brak"
                        setElementData(veh, "vehicle:link", nil)
                        setElementData(veh, "vehicle:stereo", false)
                    end
                end
            end
        end
        end

        if isMouseIn(520/zoom, 310/zoom, 175/zoom, 28/zoom) then
            local link = exports["nrpg_interface"]:getCustomEditboxText('stereo:link')
            local name = exports["nrpg_interface"]:getCustomEditboxText('stereo:name')
            local veh = getPedOccupiedVehicle(localPlayer)

            if veh then
                if string.len(link) > 5 and string.len(name) > 0 then
                    triggerServerEvent("stereo:addMusic", localPlayer, link, name)
                else
                    exports.nrpg_interface:showPlayerNotification('Wprowadź skonwertowany link, polecamy stronę foow.org', 'error')
                end
            end
        end

        if isMouseIn(520/zoom, 795/zoom, 200/zoom, 35/zoom) then
            if actualPage ~= "Ulubione" then
                actualPage = "Ulubione"

                triggerServerEvent("reloadStereo", localPlayer)
            end
        elseif isMouseIn(722/zoom, 795/zoom, 200/zoom, 35/zoom) then
            if actualPage ~= "Wszystkie" then
                actualPage = "Wszystkie"

                triggerServerEvent("reloadStereo", localPlayer)
            end
        end
    end
end)

addEventHandler("onClientElementDataChange", root, function(data,_)
	if getElementType(source) ~= "vehicle" then return end
        if data == "vehicle:stereo" then
        local data_tog = getElementData(source, data)
        if data_tog == true then
		    stereo[source] = playSound3D((getElementData(source,"vehicle:link") or ""), 0, 0, 0, true)
		    setSoundVolume(stereo[source], 0.45)
		    setSoundEffectEnabled(stereo[source], "compressor", true)
		    setSoundMaxDistance(stereo[source], 50)
		    setElementDimension(stereo[source], getElementDimension(source))
		    setElementInterior(stereo[source], getElementInterior(source))
		    attachElements(stereo[source], source)
        else
	        if stereo[source] then
	            stopSound(stereo[source])
                soundDataTime[source] = 0
                soundDataTime2[source] = 0

                stereo[source] = nil
            end 
        end
    end
end)

function secondsToClock(seconds)
	seconds = seconds or 0
	seconds = seconds*60
	if seconds <= 0 then
		return "0:00"
	else
		hours = math.floor(seconds/3600)
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
		return ""..hours..":"..mins
	end
end

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) ~= "vehicle" then return end
	if not stereo[source] then
		local data_tog = getElementData(source,"vehicle:stereo")
		if data_tog == true then
			stereo[source] = playSound3D((getElementData(source,"vehicle:link") or ""), 0, 0, 0)
			setSoundVolume(stereo[source], 0.45)
			setSoundEffectEnabled(stereo[source], "compressor",true)
			setSoundMaxDistance(stereo[source], 50)
			setElementDimension(stereo[source], getElementDimension(source))
			setElementInterior(stereo[source], getElementInterior(source))
			attachElements(stereo[source], source)
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		local data_tog = getElementData(source, "vehicle:stereo")
		if data_tog == true then
		    if stereo[source] then
		        stopSound(stereo[source])
                soundDataTime[source] = 0
                soundDataTime2[source] = 0

                stereo[source] = nil
            end
        end
	end
end)

function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*sW,cy*sH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

bindKey("mouse_wheel_down", "both", function()
    if stereoPanel == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if stereoPanel == true then
        scrollDown()
    end
end)

function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #songs then return end
    k = k+1
    n = n+1
end

addEvent("reloadStereo:c", true)
addEventHandler("reloadStereo:c", root, function(tabelka)
    if actualPage == "Wszystkie" then
        songs = tabelka
    else
        songs = {}
        for i,v in ipairs(tabelka) do
            if v.ulubione == 1 then
                table.insert(songs, v)
            end
        end
    end

    k = 1
    n = 8
    m = 8
end)

function drawScrollbar(table, x, y, height, m_, k_)
    dxDrawImage(x, y, 5, height, interface.scrollbarRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

	if #table > m_ then
    	local scrollbarHeight = height/#table

   		if k_ == 1 then 
        	scrollbarPos = y
    	elseif k_ > 0 then 
        	scrollbarPos = ((k_)*scrollbarHeight)+y
    	end

    	if #table <= m_ then 
        	scrollbarHeight = height
    	end
		
		dxDrawImage(x, scrollbarPos, 5, scrollbarHeight*(m_-1), interface.scrollbarRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
    else
        dxDrawImage(x, y, 5, height, interface.scrollbarRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

function toggleStereo(toggleType)
    if toggleType == true then
        if stereoPanel == true then return end

        triggerServerEvent("reloadStereo", localPlayer)
        exports["nrpg_interface"]:destroyCustomEditbox('stereo:link')
        exports['nrpg_interface']:createCustomEditbox('stereo:link', 'Wprowadź link...', 520/zoom, 270/zoom, 450/zoom, 35/zoom, false, "", false, {50, 50, 100})
        exports["nrpg_interface"]:destroyCustomEditbox('stereo:name')
        exports['nrpg_interface']:createCustomEditbox('stereo:name', 'Wprowadź nazwę...', 975/zoom, 270/zoom, 450/zoom, 35/zoom, false, "", false, {50, 50, 100})
        addEventHandler("onClientRender", root, drawStereo)
        stereoPanel = true
        showCursor(true)
        exports.nrpg_interface:showPlayerNotification('Aby zamknąć panel kliknij backspace', 'info')
    elseif toggleType == false then
        removeEventHandler("onClientRender", root, drawStereo)
        exports["nrpg_interface"]:destroyCustomEditbox('stereo:name')
        exports["nrpg_interface"]:destroyCustomEditbox('stereo:link')
        stereoPanel = false
        showCursor(false)
    end
end

function closePanel()
    if stereoPanel == true then
        toggleStereo(false)
    end
end

function restoreBind()
    bindKey("backspace", "down", closePanel)
end
addEventHandler("onClientRestore", root, restoreBind)
bindKey("backspace", "down", closePanel)