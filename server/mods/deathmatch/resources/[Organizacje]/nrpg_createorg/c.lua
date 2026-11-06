screenW, screenH = guiGetScreenSize()
w, h = (screenW/1280),(screenH/720)

local sw,sh = guiGetScreenSize()
local zoom = 1
if sw < 1280 then
    zoom = math.min(2, 1280 / sw)
end

main = {}

local markerPoints = {


    {4112.84, 427.56, 214.30, 20, 20},


}

local getLib = exports.nrpg_lib

interface = {

    backgroundRectangle = getLib:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(15, 15, 25, 255)),
    scrollRectangle = getLib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 200, 255)),

}

main.hitpoint = function(el)
if el ~= localPlayer then return end
showCursor(true)
addEventHandler("onClientRender", root, main.drawpanel)
main.gui = true

exports['nrpg_interface']:createCustomEditbox('org:tag', 'Wpisz tag organizacji...', 566*w, 289*h, 148*w, 44*h, false, "", false, {55, 55, 100})
exports['nrpg_interface']:createCustomEditbox('org:name', 'Wpisz nazwę organizacji...', 523*w, 338*h, 235*w, 44*h, false, "", false, {55, 55, 100})
end

main.leavepoint = function(el)
if el ~= localPlayer then return end
showCursor(false)
removeEventHandler("onClientRender", root, main.drawpanel)
main.gui = false

exports['nrpg_interface']:destroyCustomEditbox('org:tag')
exports['nrpg_interface']:destroyCustomEditbox('org:name')
end

main.drawpanel = function()
dxDrawImage(408*w, 173*h, 464*w, 375*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)
dxDrawText("ZAKŁADANIE ORGANIZACJI", 408*w, 173*h, 872*w, 213*h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money13"), "center", "bottom", false, false, false, false, false)
dxDrawText("WYMAGANE 10,000,000 PLN", 408*w, 213*h, 872*w, 253*h, tocolor(200, 200, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "top", false, false, false, false, false)

exports['nrpg_buttons']:dxCreateButton("Załóż", 576*w, 458*h, 129*w, 35*h, 1, {55, 155, 55}) 
exports['nrpg_buttons']:dxCreateButton("Anuluj", 576*w, 495*h, 129*w, 35*h, 2, {25, 100, 200}) 
end

for i,v in ipairs(markerPoints) do
	local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 1.25, 255, 255, 0, 55)
	setElementData(marker, "marker:text", "Zakładanie organizacji")
    setElementInterior(marker, v[4])
    setElementDimension(marker, v[5])

	addEventHandler( "onClientMarkerHit", marker, main.hitpoint)
	addEventHandler( "onClientMarkerLeave", marker, main.leavepoint)
end

addEventHandler("onClientClick", root, function(b1,s)
if b1 ~= "state" and s ~= "down" then return end
if main.gui ~= true then return end
if isMouseIn(576*w, 458*h, 129*w, 35*h) then
local tag = exports['nrpg_interface']:getCustomEditboxText('org:tag')
local name = exports['nrpg_interface']:getCustomEditboxText('org:name')
if getElementData(localPlayer, "player:organization") then exports.nrpg_interface:showPlayerNotification("Posiadasz już organizacje", "error") return end
if 10000000 > getPlayerMoney(localPlayer) then exports.nrpg_interface:showPlayerNotification("Nie posiadasz tyle pieniędzy", "error") return end
if string.len(tag) < 2 then
exports.nrpg_interface:showPlayerNotification("Tag powinien zawierać więcej niż 2 znaki", "error")
return end
if string.len(tag) > 5 then
exports.nrpg_interface:showPlayerNotification("Tag powinien zawierać max. 5 znaków", "error")
return end
if string.len(name) < 2 then
exports.nrpg_interface:showPlayerNotification("Nazwa powinna zawierać więcej niż 2 znaki", "error")
return end
if string.len(name) > 31 then
exports.nrpg_interface:showPlayerNotification("Nazwa powinna zawierać max. 31 znaków", "error")
return end

triggerServerEvent("createOrganization", localPlayer, localPlayer, name, tag)
elseif isMouseIn(576*w, 495*h, 129*w, 35*h) then
showCursor(false)
removeEventHandler("onClientRender", root, main.drawpanel)
main.gui = false

exports['nrpg_interface']:destroyCustomEditbox('org:tag')
exports['nrpg_interface']:destroyCustomEditbox('org:name')
end
end)

function isMouseIn ( x, y, width, height )
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