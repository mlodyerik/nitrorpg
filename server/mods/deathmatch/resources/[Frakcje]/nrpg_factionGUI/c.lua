local screenW, screenH = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local windowPos = {x=math.floor(screenW/2+950/zoom/2), y=math.floor(screenH/2-573/zoom/2), w=math.floor(1000/zoom), h=math.floor(573/zoom)}
local main = {

    factions = {

        ["SAPD"] = "#3657ffSan Andreas Police Department#ffffff",
        ["SARA"] = "#ff7e1cSan Andreas Road Assistance#ffffff",
        ["SAFD"] = "#ff1c1cSan Andreas Fire Department#ffffff",

    },

    playerFaction = nil,
    playerFactionRank = nil,
    workinjob = nil,
    workTime = 0,
    tick = getTickCount(),

}

main.renderDuty = function()
    if main.playerFaction then
        local x, y, w, h = windowPos.x, windowPos.y, math.floor(480/zoom), math.floor(805/zoom)
        
        if (getTickCount() - main.tick) >= (1000) then
            main.workTime = main.workTime + 1
            main.tick = getTickCount()
        end
        
         main.workinjob = secondsToClock(main.workTime)

        dxDrawText("Służba ("..main.workinjob..")\n"..main.factions[main.playerFaction]:gsub("#%x%x%x%x%x%x", ""), x+math.floor(520/zoom), y, x+w+1, y+h+1, tocolor(0, 0, 0, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money11'), 'right', 'bottom', false, false, false, true, false)
        dxDrawText("Służba ("..main.workinjob..")\n"..main.factions[main.playerFaction], x+math.floor(520/zoom), y, x+w, y+h, tocolor(255, 255, 255, 255), 1/zoom, exports.nrpg_interface:getGUIFont('money11'), 'right', 'bottom', false, false, false, true, false)
    end
end

main.checkDuty = function(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and (theKey == "player:faction") and source == localPlayer then
        if newValue ~= false then
            addEventHandler("onClientRender", root, main.renderDuty)
            main.playerFaction = newValue
            main.playerFactionRank = (getElementData(source, "player:rank") or 0)
            main.workinjob = nil
            main.workTime = 0
        else
            removeEventHandler("onClientRender", root, main.renderDuty)
            main.playerFaction = nil
            main.playerFactionRank = nil
            main.workinjob = nil
            main.workTime = 0
        end
    end
end
addEventHandler("onClientElementDataChange", root, main.checkDuty)

function secondsToClock(seconds)
	seconds = seconds or 0
	if seconds <= 0 then
		return "00:00"
	else
		hours = string.format("%02.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
		return ""..mins..":"..secs
	end
end