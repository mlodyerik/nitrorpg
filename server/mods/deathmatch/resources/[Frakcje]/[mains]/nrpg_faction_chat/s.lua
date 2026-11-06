function globalMessage(plr, cmd, ...)
	local frakcja = getElementData(plr,'player:faction')
	if not frakcja then
		return
	end
	local msg = table.concat ( { ... }, " " )
	local admins=getElementsByType('player')
	for i,v in pairs(admins) do
	local pfrakcje = getElementData(v,'player:faction')
		if frakcja == pfrakcje then 
			outputChatBox("#EAFF00[Frakcja]#ffffff (#EAFF00"..getElementData(plr,"id").."#ffffff) "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..": "..msg:gsub("#%x%x%x%x%x%x",""), v, 0, 144, 255, true)
		end
	end
	local q = string.format("#EAFF00Frakcja#ffffff - (#EAFF00"..getElementData(plr,"player:faction").."#ffffff) "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..": "..msg:gsub("#%x%x%x%x%x%x","").."")
	triggerEvent("admin:addText", resourceRoot, q)
	outputServerLog(q:gsub("#%x%x%x%x%x%x",""))
end
addCommandHandler("frakcja", globalMessage)


function globalMessage(plr, cmd, ...)
	local frakcja=getElementData(plr,'player:faction')
	if not frakcja then
		return
	end
	local msg = table.concat ( { ... }, " " )
	local admins=getElementsByType('player')
	for i,v in pairs(admins) do
	local pfrakcje=getElementData(v,'player:faction')
		if pfrakcje and pfrakcje ~= false then
			outputChatBox("#00FF5A[Krótkofalówka]#ffffff (#00FF5A"..getElementData(plr,"player:faction").."#ffffff) "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..": "..msg:gsub("#%x%x%x%x%x%x",""), v, 0, 255, 50, true)
		end
	end
	local q = string.format("#00FF5AKrótkofalówka#ffffff - (#00FF5A"..getElementData(plr,"player:faction").."#ffffff) "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..": "..msg:gsub("#%x%x%x%x%x%x","").."")
			triggerEvent("admin:addText", resourceRoot, q)
			outputServerLog(q:gsub("#%x%x%x%x%x%x",""))
end
addCommandHandler("krótkofalówka", globalMessage)

addEventHandler("onResourceStart", root, function() 
local players=getElementsByType('player')
for _, p in pairs(players) do
bindKey(p, "y", "down", "chatbox", "frakcja")
bindKey(p, "u", "down", "chatbox", "krótkofalówka")
end
end)

addEventHandler( "onPlayerSpawn", getRootElement(),
    function (_)
	bindKey(source, "y", "down", "chatbox", "frakcja")
	bindKey(source, "u", "down", "chatbox", "krótkofalówka")
end)






