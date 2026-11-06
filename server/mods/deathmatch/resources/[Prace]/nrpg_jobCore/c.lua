sx, sy = guiGetScreenSize()
toggleTip = false
toggleWindow = true

local zoom = 1 
if sx < 1920 then
	zoom = math.min(2, 1920/sx)
end

interface = {

    background = exports.nrpg_lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(35, 35, 35, 255)),
    colorBackground = exports.nrpg_lib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(255, 175, 0, 255)),

    keyBackground = exports.nrpg_lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(65, 65, 65, 255)),

}


function isMouseIn(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function renderTip()
    if toggleWindow == false then return end

    dxDrawImage(sx/2 - 320/zoom, sy-175/zoom, 650/zoom, 155/zoom, interface.colorBackground)
    dxDrawImage(sx/2 - 319/zoom, sy-174/zoom, 648/zoom, 153/zoom, interface.background)


    dxDrawText("Magazynier", sx/2 - 305/zoom, sy-140/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money12'), "left", "bottom", false, false, false, true, false)
    dxDrawText("Praca dorywcza", sx/2 - 305/zoom, sy-140/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('light11'), "left", "top", false, false, false, true, false)

    dxDrawText("Czas pracy", sx/2 - 225/zoom, sy-90/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money11'), "center", "bottom", false, false, false, true, false)
    dxDrawText("1 godz. 12 min.", sx/2 - 225/zoom, sy-90/zoom, nil, nil, tocolor(75, 195, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

    dxDrawText("Aktualnie zarobione pieniądze", sx/2, sy-90/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money11'), "center", "bottom", false, false, false, true, false)
    dxDrawText("10,000 PLN", sx/2, sy-90/zoom, nil, nil, tocolor(75, 255, 75, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

    dxDrawText("Aktualny cel", sx/2 + 225/zoom, sy-90/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money11'), "center", "bottom", false, false, false, true, false)
    dxDrawText("Odnieś skrzynie na regał", sx/2 + 225/zoom, sy-90/zoom, nil, nil, tocolor(255, 175, 0, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

    dxDrawImage(sx/2 - 145/zoom, sy-60/zoom, 30/zoom, 30/zoom, interface.keyBackground)
    dxDrawText("F2", sx/2 - 130/zoom, sy-45/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "center", "center", false, false, false, true, false)
    dxDrawText("Kliknij #ffaf00F2#ffffff aby zamknąć panel informacyjny", sx/2 - 100/zoom, sy-45/zoom, nil, nil, tocolor(255, 255, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont('money10'), "left", "center", false, false, false, true, false)
end

function switchWindow()
    if toggleWindow == true then 
        toggleWindow = false 
    else 
        toggleWindow = true 
    end
end

function toggleJobTip(jobName, state)
    if state == true then
        addEventHandler("onClientRender", root, renderTip)
        bindKey("f2", "down", switchWindow)
    else
        removeEventHandler("onClientRender", root, renderTip)
        unbindKey("f2", "down", switchWindow)
    end
    toggleTip = state
end