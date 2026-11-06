local sw,sh = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()

local sx, sy = guiGetScreenSize()
local w, h = (sx/1366),(sy/768)
local zoom = 1
if sx < 1920 then
    zoom = math.min(2, 1920 / sx)
end

function hidePlayerWarning()
    playerWarning=false
end

getLib = exports.nrpg_lib

interface = {

    backgroundRectangle = getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(15, 15, 25, 255)),
	backgroundRectangle2 = getLib:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(30, 30, 45, 255)),

}

fontData = {

	scale = 7,
	minScale = 7,
	maxScale = 12,

}

function changeFontSize(k, ks)
	if getElementData(localPlayer, "player:admin") then
		if k  == "num_sub" then
			if fontData.scale > fontData.minScale then
				fontData.scale = fontData.scale - 1
			end
		elseif k == "num_add" then
			if fontData.maxScale >= fontData.scale then
				fontData.scale = fontData.scale + 1
			end
		end
	end
end
bindKey("num_sub", "down", changeFontSize)
bindKey("num_add", "down", changeFontSize)

addEventHandler("onClientRender", root, function()
	if not getElementData(localPlayer, "player:sid") then return end
    if (playerWarning) then
		dxDrawImage(181*w, 140*h, 1005*w, 489*h, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 200))
        dxDrawText("OSTRZEŻENIE", 180*w, 139*h, 1186*w, 179*h, tocolor(245, 0, 0, 255), 1.00, exports.nrpg_interface:getGUIFont("money15"), "center", "center", false, false, false, false, false)
        dxDrawText(playerWarning, 181*w, 215*h, 1186*w, 572*h, tocolor(255, 255, 255, 255), 1.00, exports.nrpg_interface:getGUIFont("money10"), "center", "center", false, true, false, false, false)
        dxDrawText("OTRZYMAŁEŚ/AŚ OSTRZEŻENIE", 181*w, 589*h, 1187*w, 629*h, tocolor(245, 0, 0, 255), 1.00, exports.nrpg_interface:getGUIFont("money12"), "center", "center", false, false, false, false, false)
       return
    end
end)

addEvent("onPlayerWarningReceived", true)
addEventHandler("onPlayerWarningReceived", root, function(tresc)
    if source==localPlayer then
        playerWarning=tresc
        setTimer(hidePlayerWarning, 7000, 1)
        setTimer(playSoundFrontEnd, 300, 10, 5)
    end
end)

for k,v in ipairs ( getElementsByType ( "object" ) ) do
	if getElementData ( v, "sciana:raportow" ) then
		scianaplaczu = v
	end
	if getElementData(v,"sciana:text") then
		scianatekstu = v
	end
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
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


local xtext=nil
local xtype=1
local gameView={"Logi Serwerowe:"}
local sx,sy=guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
local renderingPos = 0

function renderingInfo()
	if not getElementData(localPlayer, "player:sid") then return end
	dxDrawImage(screenW/2-375/zoom, 25/zoom, 750/zoom, 75/zoom, interface.backgroundRectangle2, 0, 0, 0, tocolor(255, 255, 255, renderingPos))
	if xtype == "warning" then
		dxDrawImage(screenW/2-355/zoom, 36/zoom, 50/zoom, 50/zoom, "images/warning.png", 0, 0, 0, tocolor(255, 255, 255, renderingPos))
	elseif xtype == "walizka" then
		dxDrawImage(screenW/2-355/zoom, 36/zoom, 50/zoom, 50/zoom, "images/walizka.png", 0, 0, 0, tocolor(255, 255, 255, renderingPos))
	else
		dxDrawImage(screenW/2-355/zoom, 36/zoom, 50/zoom, 50/zoom, "images/punish.png", 0, 0, 0, tocolor(255, 255, 255, renderingPos))
	end
	dxDrawText(xtext:gsub("#%x%x%x%x%x%x",""), screenW/2-285/zoom, 45/zoom, 750/zoom, 75/zoom, tocolor(200, 200, 255, renderingPos), 1/zoom, exports.nrpg_interface:getGUIFont("money10"), "left", "center", false, false)
end

function raporcik()
	if getElementData(localPlayer, "player:raps") then
	if not getElementData(localPlayer,"player:admin") then return end
	local tt={}
	reportView=getElementData(scianaplaczu,"sciana:raportow")
	for i,c in ipairs(reportView) do
		if c[1] then table.insert(tt,c[1]) end
	end
	concat=table.concat(tt, "\n")
	dxDrawText(concat:gsub("#%x%x%x%x%x%x",""), sx*(698)/1024, sy*(278)/768, sx*(1014.5)/1024, sy*(496.5)/768, tocolor(0, 0, 0, 255), 1.0, exports.nrpg_interface:getGUIFont("money"..fontData.scale..""), "right", "top", false, true, false, true)
	dxDrawText(concat, sx*(698)/1024, sy*(278)/768, sx*(1014)/1024, sy*(496)/768, tocolor(255, 255, 255, 255), 1.0, exports.nrpg_interface:getGUIFont("money"..fontData.scale..""), "right", "top", false, true, false, true)
end
end
addEventHandler("onClientRender", root, raporcik)

addEvent("admin:addText", true)
addEventHandler("admin:addText", root, function(text)
	table.insert(gameView, text)	
	if #gameView > 15 then
		table.remove(gameView, 2)
	end
end)

function raporcik2()
	if getElementData(localPlayer, "player:logs") then
	if not getElementData(localPlayer,"player:admin") then return end
	local tt={}
	reportView=getElementData(scianatekstu,"sciana:text")
	for i,c in ipairs(reportView) do
		if c[1] then table.insert(tt,c[1]) end
	end
	concat=table.concat(tt, "\n")
	dxDrawText(concat:gsub("#%x%x%x%x%x%x",""), sx*(10.5)/1024, sy*(279.5)/768, sx*(326+2)/1024, sy*(497+2)/768, tocolor(0, 0, 0, 255), 1.0, exports.nrpg_interface:getGUIFont("money"..fontData.scale..""), "left", "top", false, true, false, true)
	dxDrawText(concat, sx*(10)/1024, sy*(279)/768, sx*(326)/1024, sy*(497)/768, tocolor(255, 255, 255, 255), 1.0, exports.nrpg_interface:getGUIFont("money"..fontData.scale..""), "left", "top", false, true, false, true)
end
end
addEventHandler("onClientRender", root, raporcik2)

function renderingInfo2()
        dxDrawLine((screenW * 0.0000) - 1, (screenH * -0.1367) - 1, (screenW * 0.0000) - 1, screenH * 0.0586, tocolor(0, 101, 254, 255), 1, false)
        dxDrawLine(screenW * 1.0000, (screenH * -0.1367) - 1, (screenW * 0.0000) - 1, (screenH * -0.1367) - 1, tocolor(0, 101, 254, 255), 1, false)
        dxDrawLine((screenW * 0.0000) - 1, screenH * 0.0573, screenW * 1.0000, screenH * 0.0573, tocolor(0, 101, 254, 255), 1, false)
        dxDrawLine(screenW * 1.0000, screenH * 0.0586, screenW * 1.0000, (screenH * -0.1367) - 1, tocolor(0, 101, 254, 255), 1, false)
        dxDrawRectangle(screenW * 0.0000, screenH * -0.1380, screenW * 1.0000, screenH * 0.1953, tocolor(0, 0, 0, 255), false)
        dxDrawText("Ogloszenie od administracji: "..xtext2:gsub("#%x%x%x%x%x%x","").."", screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 0.0573, tocolor(31, 168, 255, 255), 1.00, dxfont0_8, "center", "center", false, false, true, false, false)
end

addEvent("admin:rendering", true)
addEventHandler("admin:rendering", root, function(text,type)
	if not type then type = 1 end
	xtext = text
	xtype = type

	outputConsole(" ", root)
	outputConsole(xtext, root)
	outputConsole(" ", root)
	
	if isEventHandlerAdded("onClientRender",root,renderingInfo) then
		removeEventHandler ( "onClientRender", root, renderingInfo)
	end

	addEventHandler("onClientRender", root, renderingInfo)
	createAnimation(0, 255, 'Linear', 1000, function(value) renderingPos = value end)

	setTimer(function()
		createAnimation(renderingPos, 0, 'Linear', 1000, function(value) renderingPos = value end)
	end, 8500, 1)
	
	setTimer(function()
		removeEventHandler("onClientRender", root, renderingInfo)
	end, 10000, 1)
end)

addEvent("admin:ogl", true)
addEventHandler("admin:ogl", root, function(text)
	xtext2=text
	if isEventHandlerAdded("onClientRender",root,renderingInfo2) then
		removeEventHandler ( "onClientRender", root, renderingInfo2)
	end
	addEventHandler("onClientRender", root, renderingInfo2)
	setTimer(function()
		removeEventHandler("onClientRender", root, renderingInfo2)
	end, 10000, 1)
end)


function cmd_admins(plr)
  	local zarzad={}
  	local root={}
  	local admin={}
  	local moderator={}
  	local supkipionaski={}
  	for i,v in ipairs(getElementsByType("player")) do
	local adminer = getElementData(v,"player:id")

  		if (getElementData(v,"player:level") == 4) then
	  		local t
	  		local login=getElementData(v,"player:admin")
	  		if (login) then
				t="#c9c9c9("..getElementData(v,"id")..")#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","")..""
				table.insert(zarzad,t)
			end
	  	end

		if (getElementData(v,"player:level") == 3) then
	  		local t
	  		local login=getElementData(v,"player:admin")
	  		if (login) then
				t="#c9c9c9("..getElementData(v,"id")..")#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","")..""
				table.insert(root,t)
	  		end
		end

		if (getElementData(v,"player:level") == 2) then
			local t
			local login=getElementData(v,"player:admin")
	  		if (login) then
				t="#c9c9c9("..getElementData(v,"id")..")#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","")..""
				table.insert(admin,t)
	  		end
		end

		if (getElementData(v,"player:level") == 1) then
			local t
			local login=getElementData(v,"player:admin")
			if (login) then
		  		t="#c9c9c9("..getElementData(v,"id")..")#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","")..""
		  		table.insert(supkipionaski,t)
			end
	  	end
	end
	outputChatBox(" ", 136, 0, 0, true)
	outputChatBox(" ", 136, 0, 0, true)

  	outputChatBox("Zarząd:", 136, 0, 0, true)
  	if (#zarzad>0) then
    	outputChatBox("- " .. table.concat(zarzad,", "), 255, 255, 255, true)
  	else
		outputChatBox("#c9c9c9- Offline", 255, 255, 255, true)
  	end

  	outputChatBox("Administrator RCON:", 255, 150, 0)
  	if (#root>0) then
    	outputChatBox("- " .. table.concat(root,", "), 255, 255, 255, true)
  	else
		outputChatBox("#c9c9c9- Offline", 255, 255, 255, true)
  	end
  
  	outputChatBox("Administrator:", 255, 0, 4)
  	if (#admin>0) then
    	outputChatBox("- " .. table.concat(admin,", "), 255, 255, 255, true)
  	else
		outputChatBox("#c9c9c9- Offline", 255, 255, 255, true)
  	end

  	outputChatBox("Support:", 2, 160, 0)
  	if (#supkipionaski>0) then
    	outputChatBox("- " .. table.concat(supkipionaski,", "), 255, 255, 255, true)
  	else
		outputChatBox("#c9c9c9- Offline", 255, 255, 255, true)
  	end
	outputChatBox(" ", 136, 0, 0, true)
	outputChatBox("- Łączna ilość administracji online: #ffe600"..(#zarzad+#root+#admin+#supkipionaski), 245, 245, 245, true)
	outputChatBox(" ", 136, 0, 0, true)
end
addCommandHandler("admins", cmd_admins, false, false)
addCommandHandler("ekipa", cmd_admins, false, false)
addCommandHandler("admini", cmd_admins, false, false)