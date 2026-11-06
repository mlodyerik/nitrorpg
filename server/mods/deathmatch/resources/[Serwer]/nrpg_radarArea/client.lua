radarWindow = guiCreateWindow(0.6, 0.6, 0.35, 0.35, "Radar Maker", true)
ButtonA = guiCreateButton(0.05, 0.1, 0.6, 0.15, "Point A (Bottom Left Corner)", true, radarWindow)
ButtonB = guiCreateButton(0.05, 0.3, 0.6, 0.15, "Point B (Top Right Corner)", true, radarWindow)
Generate = guiCreateButton(0.67, 0.1, 0.3, 0.35, "Generate Code", true, radarWindow)
codeBox = guiCreateMemo(0.05, 0.5, 0.9, 0.4, "The code will appear here!", true, radarWindow)
guiMemoSetReadOnly(codeBox, true)
guiWindowSetSizable(radarWindow, false)
guiSetVisible(radarWindow, false)

function createArea()
	if getPlayerSerial(localPlayer) ~= "4789529C23F91124DE049851CFCDAC02" then return end
	if guiGetVisible(radarWindow) then
		guiSetVisible(radarWindow, false)
		showCursor(false, false)
	else
		guiSetVisible(radarWindow, true)
		showCursor(true, true)
	end
end
bindKey("f7", "down", createArea)

function buttonAclick()
	x,y,z = getElementPosition(localPlayer)
	outputChatBox("South West corner set to ".. x ..", ".. y)
	setElementData(localPlayer, "radar1", x)
	setElementData(localPlayer, "radar2", y)
end
addEventHandler ( "onClientGUIClick", ButtonA, buttonAclick, false )

function buttonBclick()
	x2,y2,z2 = getElementPosition(localPlayer)
	outputChatBox("North East corner set to ".. x2 ..", ".. y2)
	setElementData(localPlayer, "radar3", x2)
	setElementData(localPlayer, "radar4", y2)
end
addEventHandler ( "onClientGUIClick", ButtonB, buttonBclick, false )

function generateCode()
	radarX = x2 - x
	radarY = y2 - y
	guiSetText(codeBox, "createColRectangle( ".. x ..", ".. y ..", "..radarX..", "..radarY..")\ncreateRadarArea("..x..", "..y..", "..radarX..", "..radarY..", 0, 255, 0, 100)")
end
addEventHandler ( "onClientGUIClick", Generate, generateCode, false )