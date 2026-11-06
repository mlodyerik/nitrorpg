chat = {

    messages = {},
    settings = {},

}

links = {

    ['https://'] = true,

}

zoom = 1
if sW < 1366 then
    zoom = math.min(2, 1366 / sW)
end

local k = 1
local n = 7
local m = 7

main.drawChat = function()
    x = 0
    for u, v in ipairs(chat.messages) do
        if u >= k and u <= n then 
            x = x + 1

            local offsetY = (-30*h)*(x+1)
            local offsetY2 = offsetY*2

            if v.change ~= false then
                dxDrawText("("..v.time..") "..v.text, 740*w, 635*h+offsetY2, 992*w, 500*h, tocolor(200, 200, 255, 200), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "center", "center", false, false, false, false, false)
            else
                if v.text == "like_icon" then
                    if v.type == getElementData(localPlayer, "player:sid") then
                        dxDrawImage(975*w, 555*h+offsetY, 25*w, 25*h, "icons/like_icon.png", 0, 0, 0, tocolor(155, 155, 255, 255), false)
                        dxDrawText(v.time or "", 850*w, 635*h+offsetY2, 972*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "center", false, false, false, false, false)
                    else
                        dxDrawImage(735*w, 555*h+offsetY, 25*w, 25*h, "icons/like_icon.png", 0, 0, 0, tocolor(155, 155, 255, 255), false)
                        dxDrawText(v.time or "", 765*w, 635*h+offsetY2, 995*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                    end
                elseif v.text == "heart_icon" then
                    if v.type == getElementData(localPlayer, "player:sid") then
                        dxDrawImage(975*w, 555*h+offsetY, 25*w, 25*h, "icons/heart_icon.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
                        dxDrawText(v.time or "", 850*w, 635*h+offsetY2, 972*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "center", false, false, false, false, false)
                    else
                        dxDrawImage(735*w, 555*h+offsetY, 25*w, 25*h, "icons/heart_icon.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
                        dxDrawText(v.time or "", 765*w, 635*h+offsetY2, 995*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                    end
                elseif v.text == "sunglasses_emoji" or v.text == "think_emoji" or v.text == "heartface_emoji" or v.text == "poop_emoji" then
                    if v.type == getElementData(localPlayer, "player:sid") then
                        dxDrawImage(975*w, 555*h+offsetY, 25*w, 25*h, "icons/"..(v.text or "like_icon")..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        dxDrawText(v.time or "", 850*w, 635*h+offsetY2, 972*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "center", false, false, false, false, false)
                    else
                        dxDrawImage(735*w, 555*h+offsetY, 25*w, 25*h, "icons/"..(v.text or "like_icon")..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        dxDrawText(v.time or "", 765*w, 635*h+offsetY2, 995*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                    end 
                else
                    if v.type == getElementData(localPlayer, "player:sid") then
                        local width = dxGetTextWidth(v.text:gsub("#%x%x%x%x%x%x", ""), 1/zoom, exports.nrpg_interface:getGUIFont("light8"))
                        width = width + 10/zoom
                        dxDrawImage(1000*w, 555*h+offsetY, (-width), 25*h, interface.messageRectangle, 0, 0, 0, tocolor(255, 255, 255, 100), false)
                        dxDrawText(v.text, 1250*w, 635*h+offsetY2, 995.5*w, 500*h, tocolor(245, 245, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "center", false, false, false, false, false)
                        dxDrawText(v.time or "", 1250*w, 635*h+offsetY2, 995*w-width, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "right", "center", false, false, false, false, false)
                    else
                        local width = dxGetTextWidth(v.text:gsub("#%x%x%x%x%x%x", ""), 1/zoom, exports.nrpg_interface:getGUIFont("light8"))
                        width = width + 10/zoom
                        dxDrawImage(735*w, 555*h+offsetY, (width), 25*h, interface.messageRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
                        dxDrawText(v.text, 741*w, 635*h+offsetY2, 995*w, 500*h, tocolor(245, 245, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                        dxDrawText(v.time or "", 740*w+(width), 635*h+offsetY2, 995*w, 500*h, tocolor(255, 255, 255, 175), 0.7/zoom, exports.nrpg_interface:getGUIFont("light8"), "left", "center", false, false, false, false, false)
                    end
                end
            end
        end
    end
end

addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" then
        if main.toggleGUI == true and main.friendsPage == "Czat" then
            x22 = 0
            for u, v in ipairs(chat.messages) do
                if u >= k and u <= n then 
                    x22 = x22 + 1
                    local offsetY = (-30*h)*(x22+1)
                    local offsetY2 = offsetY*2

                    if v.type == getElementData(localPlayer, "player:sid") then
                        local width = dxGetTextWidth(v.text:gsub("#%x%x%x%x%x%x", ""), 1/zoom, exports.nrpg_interface:getGUIFont("light8"))
                        width = width + 10/zoom

                        if isMouseIn(1000*w, 555*h+offsetY, (-width), 25*h) and foundString(v.text) then
                            setClipboard( v.text )
                            exports.nrpg_interface:showPlayerNotification('Skopiowano link', 'info')
                        end
                    else
                        local width = dxGetTextWidth(v.text:gsub("#%x%x%x%x%x%x", ""), 1/zoom, exports.nrpg_interface:getGUIFont("light8"))
                        width = width + 10/zoom

                        if isMouseIn(735*w, 555*h+offsetY, (width), 25*h) and foundString(v.text) then
                            setClipboard( v.text )
                            exports.nrpg_interface:showPlayerNotification('Skopiowano link', 'info')
                        end
                    end
                end
            end
        end
    end
end)

function foundString(string)
    for i, v in pairs(links) do
        while string:lower():find(i:lower(), 1, true) do
            local start, end_ = string:lower():find(i:lower(), 1, true)
            local found = string:sub(start, end_)
            if found then
                return true
            else
                return false
            end
        end
    end
end

function goToDown()
    k = 1
    n = 7
    m = 7
end

bindKey("mouse_wheel_down", "both", function()
    if isMouseIn(725*w, 272*h, 285*w, 299*h) and main.friendsPage == "Czat" then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if isMouseIn(725*w, 272*h, 285*w, 299*h) and main.friendsPage == "Czat" then
        scrollDown()
    end
end)


function scrollDown()
    if n >= #chat.messages then return end
    k = k+1
    n = n+1
end

function scrollUp()
    if n == m then return end
    k = k-1
    n = n-1
end