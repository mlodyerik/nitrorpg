data = {}
data.ogloszenieFreeze = createElement("ogloszenieFreeze")

chatHex = {

	[5] = "#AC0008",
	[4] = "#ff7300",
	[3] = "#FF0000",
	[2] = "#09C600",
	[1] = "#00DDFF",
	[0] = "#ffffff",
	["Diamond"] = "#19afff",
	["Discord"] = "#fc03f0",
	["Premium"] = "#FFDE00",
	["Gracz"] = "#a3a3e3",

}

addEventHandler( "onPlayerChat", getRootElement(), function(text, type)
cancelEvent()

if string.len(text) == 0 then exports.nrpg_interface:showPlayerNotification(plr, "Podaj więcej znaków", "error"); cancelEvent() return end
if not text then return end

if not getElementData(source, "player:sid") then
	return
end
if getElementData(source, 'mute:player') then
	return exports.nrpg_interface:showPlayerNotification(source, "Jesteś wyciszony/a", "error")
end

if data.ninjaBan(text:gsub('#%x%x%x%x%x%x', '')) == true then data.reklamaKick(source) return end


if type == 0 then

local x, y, z = getElementPosition(source)
local players = getElementsWithinRange(x, y, z, 30, "player")

for i, v in ipairs(players) do
	outputChatBox(''..data.checkHex(source)..''..(getElementData(source, 'id') or 0)..''..chatHex[0]..' '..getPlayerName(source):gsub('#%x%x%x%x%x%x', '')..': '..text:gsub('#%x%x%x%x%x%x', ''), v, 255, 255, 255, true)
end

data.addLog(source, "#30FF00CZAT#ffffff", text:gsub("#%x%x%x%x%x%x",""))
triggerClientEvent("onChatbubblesMessageIncome", source, text:gsub("#%x%x%x%x%x%x",""))
elseif type == 1 then

local x, y, z = getElementPosition(source)
local players = getElementsWithinRange(x, y, z, 30, "player")

for i, v in ipairs(players) do
	outputChatBox('#FF3DDC** '..getPlayerName(source):gsub('#%x%x%x%x%x%x', '')..': '..text:gsub('#%x%x%x%x%x%x', '')..' **', v, 255, 255, 255, true)
end
data.addLog(source, "#FF00C0ME#ffffff", text:gsub("#%x%x%x%x%x%x",""))
triggerClientEvent("onChatbubblesMessageIncome", source, ""..text:gsub("#%x%x%x%x%x%x","").."", 1)
end
end)

addCommandHandler('do', function(plr, cmd, ...)

	if getElementData(plr, 'mute:player') then
		return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
	end
	
	if not getElementData(plr, "player:sid") then
		return
	end
	
	local text = table.concat({...}, ' ')
	if 1 > string.len(text) then exports.nrpg_interface:showPlayerNotification(plr, "Podaj więcej znaków", "error") return end
	if not text then return end
	
	local x, y, z = getElementPosition(plr)
	local players = getElementsWithinRange(x, y, z, 30, "player")
	
	for i,v in ipairs(players) do
		outputChatBox("(( "..text:gsub("#%x%x%x%x%x%x","").." ("..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..") ))", v, 0, 160, 255)
	end
	
	data.addLog(plr, "#0047FFDO#ffffff", text:gsub("#%x%x%x%x%x%x",""))
	triggerClientEvent("onChatbubblesMessageIncome", plr, ""..text:gsub("#%x%x%x%x%x%x","").."", 5)
end)

addCommandHandler('try', function(plr, cmd, ...)

	if getElementData(plr, 'mute:player') then
		return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
	end
	
	if not getElementData(plr, "player:sid") then
		return
	end
	
	local text = table.concat({...}, ' ')
	if 1 > string.len(text) then exports.nrpg_interface:showPlayerNotification(plr, "Podaj więcej znaków", "error") return end
	if not text then return end
	
	local x, y, z = getElementPosition(plr)
	local players = getElementsWithinRange(x, y, z, 30, "player")
	local losuj = math.random(1,2)

	if losuj == 1 then
		triggerClientEvent("onChatbubblesMessageIncome", plr, ""..text:gsub("#%x%x%x%x%x%x","").."", 3)
	else
		triggerClientEvent("onChatbubblesMessageIncome", plr, ""..text:gsub("#%x%x%x%x%x%x","").."", 2)
	end
	
	for i,v in ipairs(players) do
		if losuj == 1 then
			outputChatBox("(( "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." próbuje: "..text:gsub("#%x%x%x%x%x%x","").." ))", v, 0, 200, 0)
		else
			outputChatBox("(( "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." próbuje: "..text:gsub("#%x%x%x%x%x%x","").." ))", v, 200, 0, 0)
		end
	end
	
	data.addLog(plr, "#007EFFTRY#ffffff", text:gsub("#%x%x%x%x%x%x",""))
end)

addCommandHandler("v", function(plr, cmd, ...)
	if not getElementData(plr, "player:sid") then
		return
	end
	
	if getElementData(plr, 'mute:player') then
		return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
	end

	if getElementData(plr, "player:premiumchat") then
		return exports.nrpg_interface:showPlayerNotification(plr, "Posiadasz wyłączony czat premium", "error")
	end

	if getElementData(plr, "player:premium") or getElementData(plr, "player:premiumplus") then
	else
		return exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz konta premium", "error")
	end

	if not ... then exports.nrpg_interface:showPlayerNotification(plr, 'Użyj: /v [wiadomość]', "error") return end
	local text=table.concat({...}, " ")
	if text:len() < 1 then
	return end

	local text = table.concat ( { ... }, " " )
	if not text then return end
	for i, v in pairs(getElementsByType("player")) do
		if getElementData(v, "player:sid") then
			if not getElementData(v, "player:premiumchat:off") then
				if getElementData(v, "player:premium") or getElementData(v, "player:premiumplus") then
					outputChatBox("#FFD100(Premium) > #ffffff["..data.checkHex(plr)..""..getElementData(plr,"id").."#ffffff] "..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '').."#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", v, 255, 255, 255, true)
				end
			end
		end
	end
	data.addLog(plr, "#D2FF00PREMIUM#ffffff", text:gsub("#%x%x%x%x%x%x",""))
end)

theTimer = setTimer(function()
	for i, v in pairs(getElementsByType("player")) do
		setElementData(v, "ogloszenie:timer", false)
	end
end, 60000, 0)

addCommandHandler("d", function(plr, cmd, ...)
if not getElementData(plr, "player:sid") then
	return
end

if getElementData(plr, 'mute:player') then
	return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
end

if not getElementData(plr, "player:premiumplus") then
	return exports.nrpg_interface:showPlayerNotification(plr, "Nie posiadasz konta Diamond", "error")
end

if getElementData(plr, "player:premiumchat") then
	return exports.nrpg_interface:showPlayerNotification(plr, "Posiadasz wyłączony czat Diamond", "error")
end

if not ... then exports.nrpg_interface:showPlayerNotification(plr, 'Użyj: /d [wiadomość]', "error") return end
local text=table.concat({...}, " ")
if text:len() < 1 then
return end

local text = table.concat ( { ... }, " " )
if not text then return end
for i, v in pairs(getElementsByType("player")) do
	if getElementData(v, "player:sid") and getElementData(v, "player:premiumplus") then
		if getElementData(v, "player:admin") and not getElementData(v, "player:premiumchat:off") then
			outputChatBox("#19afff(Diamond) >#ffffff ["..data.checkHex(plr)..""..getElementData(plr,"id").."#ffffff] "..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '').."#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", v, 255, 255, 255, true)
		else
			outputChatBox("#19afff(Diamond) >#ffffff ["..getElementData(plr,"id").."] "..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '').."#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", v, 255, 255, 255, true)
		end
	end
end
	data.addLog(plr, "#0090FFDIAMOND#ffffff", text:gsub("#%x%x%x%x%x%x",""))
end)


data.reklamaKick = function(plr)
kickPlayer(plr, 'Reklama')
exports.nrpg_interface:showPlayerNotification(plr,  root, '['..getElementData(plr,'id')..']'..getPlayerName(plr):gsub('#%x%x%x%x%x%x','')..' został(a) wyrzucony(a) przez serwer, powód: Reklama')
end

data.checkHex = function(plr)
local admLevel = getElementData(plr, 'player:level')
local plrLevel = data.checkPremium(plr)

if admLevel then
	return chatHex[admLevel]
else
	return chatHex[plrLevel]
end
end

data.checkPremium = function(plr)
local premiumPlus = getElementData(plr, 'player:premiumplus')
local premium = getElementData(plr, 'player:premium')
local discord = getElementData(plr, 'player:discordbooster')
if premiumPlus then
	return "Diamond"
elseif discord then
	return "Discord"
elseif premium then
	return "Premium"
else
	return "Gracz"
end
end

data.addLog = function(plr, type, text)
local outputLog = ""..type.." - ["..getElementData(plr, "id").."] "..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '')..": "..text:gsub('#%x%x%x%x%x%x', '')
local outputLog2 = "[**"..type.."**] [**"..getElementData(plr, "id").."**] **"..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '').."**: "..text:gsub('#%x%x%x%x%x%x', '')
if outputLog then
	--exports.nrpg_interface:showPlayerNotification(plr, resourceRoot, outputLog, 1, type)
	triggerEvent("admin:addText", resourceRoot, outputLog)
	outputServerLog(outputLog)
	exports['nrpg_discord']:connectWeb(outputLog2:gsub("#%x%x%x%x%x%x",""), "Czaty")
end
end

data.ninjaBan = function(ip)
    -- must pass in a string value
    if ip == nil or type(ip) ~= "string" then
        return false
    end

    -- check for format 1.11.111.111 for ipv4
    local chunks = {ip:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
    if (#chunks == 4) then
        for _,v in pairs(chunks) do
            if (tonumber(v) < 0 or tonumber(v) > 255) then
                return false
			else
			return true
			end
        end
    else
        return false
    end

    return false
end