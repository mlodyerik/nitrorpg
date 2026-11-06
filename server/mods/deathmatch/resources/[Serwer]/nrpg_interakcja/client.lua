local sx, sy = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()

local interaction = {
    current = 1,
    mask = dxCreateTexture("data/mask.png"),
    shader = dxCreateShader("data/mask.fx"),
    rt = dxCreateRenderTarget(150, 500, true),
    list = {},
}

local regulations = {

    ["Regulacja zawieszenia"] = true,

}

dxSetShaderValue(interaction.shader, "sPicTexture", interaction.rt)
dxSetShaderValue(interaction.shader, "sMaskTexture", interaction.mask)

function drawIcon(k, v, y)
    v.size = (v.size or 60)
    if interaction.current == k then
        v.size = v.size + (110-v.size)*2/delta
    else
        v.size = v.size + (60-v.size)*2/delta
    end

    dxDrawImage(75-v.size/2, 250 + y - interaction.pos - v.size/2, v.size, v.size, "data/" .. v.icon .. ".png")
    return y + 125
end

addEventHandler("onClientRender", root, function()
    if not getPedOccupiedVehicle(localPlayer) then
        switchInteraction(_, false)
        return
    end

    local _y = 0
    for k,v in pairs(interaction.list) do
        if interaction.current == k then
            interaction.pos = (interaction.pos and (interaction.pos + (_y - interaction.pos)*3/delta) or _y)
        end
        _y = _y + 125
    end


    local veh = getPedOccupiedVehicle(localPlayer)
    if interaction.open and veh then
        dxSetRenderTarget(interaction.rt, true)

        --dxDrawRectangle(0, 0, 250, 500, tocolor(0, 0, 0, 155))

        local y = -_y
        for k,v in pairs(interaction.list) do
            y = drawIcon(k, v, y)
        end
        for k,v in pairs(interaction.list) do
            y = drawIcon(k, v, y)
        end
        for k,v in pairs(interaction.list) do
            y = drawIcon(k, v, y)
        end

        dxSetRenderTarget()

        dxDrawRectangle(0, 0, sx, sy, tocolor(0, 0, 0, 200))
        dxDrawImage(sx - 230/zoom,sy/2 - 250/zoom,15/zoom,500/zoom,"data/fancy-line.png", 0, 0, 0, tocolor(255, 180, 0))
        dxDrawImage(sx - 190/zoom,sy/2 - 250/zoom,150/zoom,500/zoom,interaction.shader, 0, 0, 0, tocolor(255,255,255,200))

        local text = interaction.list[interaction.current].text(veh)
        dxDrawText(text, 0, sy/2-17/zoom, sx - 270/zoom, sy/2-17/zoom, white, 1, exports.nrpg_interface:getGUIFont("money25"), "right", "center")

        if regulations[text] then
            local regulationLevel = interaction.list[interaction.current].regulation(veh)
            local regulationName = interaction.list[interaction.current].name
            local theText = regulationName.." #ffae00"..regulationLevel
            local textWidth = dxGetTextWidth(theText:gsub("#%x%x%x%x%x%x", ""), 1, exports.nrpg_interface:getGUIFont("normal17"))

            dxDrawText(theText, 0, sy/2+17/zoom, sx - 300/zoom, sy/2+17/zoom, tocolor(225, 225, 225, 255), 1, exports.nrpg_interface:getGUIFont("normal17"), "right", "center", false, false, false, true)

            if getKeyState("arrow_r") == true then
                dxDrawImage(sx - 290/zoom, sy/2 + 6/zoom, 22/zoom, 22/zoom, "data/arrow.png", 0, 0, 0, tocolor(225, 225, 225, 200))
            else
                dxDrawImage(sx - 290/zoom, sy/2 + 6/zoom, 22/zoom, 22/zoom, "data/arrow.png", 0, 0, 0, tocolor(225, 225, 225, 255))
            end

            if getKeyState("arrow_l") == true then
                dxDrawImage(sx - 332/zoom - textWidth, sy/2 + 6/zoom, 22/zoom, 22/zoom, "data/arrow.png", 180, 0, 0, tocolor(225, 225, 225, 200))
            else
                dxDrawImage(sx - 332/zoom - textWidth, sy/2 + 6/zoom, 22/zoom, 22/zoom, "data/arrow.png", 180, 0, 0, tocolor(225, 225, 225, 255))
            end
        else
            dxDrawText("Aby potwierdzić wybór wciśnij #ffae00spację#ffffff", 0, sy/2+17/zoom, sx - 270/zoom, sy/2+17/zoom, tocolor(225, 225, 225, 255), 1, exports.nrpg_interface:getGUIFont("normal17"), "right", "center", false, false, false, true)
        end
    end    
end)

function addTune(veh)
    if exports["nrpg_vehicles"]:getTuning(veh, "RH") then
        table.insert(interaction.list, {

            text = function(veh) return ("Regulacja zawieszenia") end,
            icon = "susp",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            regulation = function(veh) return (getElementData(veh, "vehicle:suspension") or 0) end,
            name = "Wysokość zawieszenia:",
            data = "vehicle:suspension",
            limits = {down=-7, up=7},
            trigger = nil,

        })
    end

    if exports["nrpg_vehicles"]:getTuning(veh, "ABS") then
        table.insert(interaction.list, {
            
            text = function(veh) return (getElementData(veh, "vehicle:toggleABS") and "Wyłącz ABS" or "Włącz ABS") end,
            icon = "abs",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "vehicleABS",

        })
    end

    if getElementData(veh, "vehicle:lpg") then
        table.insert(interaction.list, {
            
            text = function(veh) return (getElementData(veh, "vehicle:togglelpg") and "Przełącz na Benzynę" or "Przełącz na LPG") end,
            icon = "lpg",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "vehicleLPG",

        })
    end
end

function refreshList()
    interaction.list = {
        {
            text = function(veh) return (getVehicleEngineState(veh) and "Zgaś silnik" or "Uruchom silnik") end,
            icon = "motor",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "vehicleEngine",
        },

        {
            text = function(veh) return (getVehicleOverrideLights(veh) == 2 and "Zgaś światła" or "Włącz światła") end,
            icon = "headlights",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "vehicleLights",
        },

        {
            text = function(veh) return (isElementFrozen(veh) == false and "Zaciągnij ręczny" or "Spuść ręczny") end,
            icon = "brake",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "vehicleHandbrake",
        },

        {
            text = function(veh) return (isVehicleLocked(veh) and "Otwórz pojazd" or "Zamknij pojazd") end,
            icon = "doors",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "vehicleDoors",
        },

        {
            text = function(veh) return ("Wyrzuć pasażerów") end,
            icon = "kick",
            x = sx/2 - 150/zoom,
            y = sy - 80/zoom,
            trigger = "kickPassengers",
        },
    }
end

function switchInteraction(_, c)
    if c and (not getPedOccupiedVehicle(localPlayer) or getPedOccupiedVehicleSeat(localPlayer) ~= 0) then return end
    if c == "down" then
        refreshList()
        addTune(getPedOccupiedVehicle(localPlayer))
        interaction.open = true
        interaction.current = 1
        interaction.pos = false
        interaction.prev = {hud=getElementData(localPlayer, "notshowhud"), chat=isChatVisible()}
        showChat(false)
        setElementData(localPlayer, "notshowhud", true)
        bindKey("arrow_d", "down", changeDown)
        bindKey("arrow_u", "down", changeUp)
        bindKey("arrow_l", "down", regulateIT)
        bindKey("arrow_r", "down", regulateIT)
        bindKey("space", "down", selectOption)
    else
        interaction.open = false
        setElementData(localPlayer, "notshowhud", interaction.prev.hud)
        showChat(interaction.prev.chat)
        unbindKey("arrow_d", "down", changeDown)
        unbindKey("arrow_u", "down", changeUp)
        unbindKey("arrow_l", "down", regulateIT)
        unbindKey("arrow_r", "down", regulateIT)
        unbindKey("space", "down", selectOption)
    end
end
bindKey("lshift", "both", switchInteraction)

function changeUp()
    interaction.current = interaction.current - 1

    if interaction.current <= 0 then
        interaction.current = #interaction.list
        interaction.pos = interaction.pos + (#interaction.list)*125
    end
end

function changeDown()
    interaction.current = interaction.current + 1

    if interaction.current > #interaction.list then
        interaction.current = 1
        interaction.pos = interaction.pos - (#interaction.list)*125
    end
end

function regulateIT(k, ks)
    local veh = getPedOccupiedVehicle(localPlayer)
    local text = interaction.list[interaction.current].text(veh)

    if veh and regulations[text] then
        local actualRegulateData = interaction.list[interaction.current].data
        local actualRegulateLimits = interaction.list[interaction.current].limits

        if k  == "arrow_r" and ks == "down" then
            local level = getElementData(veh, actualRegulateData) or 0
            if level >= actualRegulateLimits.up then return end

            setElementData(veh, actualRegulateData, level+1)
            triggerServerEvent("suspensionRegulate", localPlayer, veh, "up")
        elseif k == "arrow_l" and ks == "down" then
            local level = getElementData(veh, actualRegulateData) or 0
            if actualRegulateLimits.down >= level then return end
            setElementData(veh, actualRegulateData, level-1)
            triggerServerEvent("suspensionRegulate", localPlayer, veh, "down")
        end
    end
end

function selectOption()
    local veh = getPedOccupiedVehicle(localPlayer)

    if veh then
        local text = interaction.list[interaction.current].text(veh)

        if not regulations[text] then
            triggerServerEvent(interaction.list[interaction.current].trigger, localPlayer, getPedOccupiedVehicle(localPlayer))
        end
    end
end

function shadowText(text, x, y, w, h, color, ...)
    for _x = -1, 1 do
        for _y = -1, 1 do
            dxDrawText(text, x+_x, y+_y, w+_x, h+_y, tocolor(0, 0, 0, 100), ...)
        end
    end
    return dxDrawText(text, x, y, w, h, color, ...)
end

addEventHandler("onClientPreRender", root, function(dt) delta = dt end)