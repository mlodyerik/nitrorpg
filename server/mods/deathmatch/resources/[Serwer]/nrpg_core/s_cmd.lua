function onPrivateMessage(plr, cmd, target, ...)
    if not (getElementData(plr, "player:sid")) then return end
    if not target or not {...} then
        outputChatBox('* Użyj /pm <nick/ID> <treść>', plr)
        return
    end

    if getElementData(plr, 'mute:player') then
      return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
    end

    local text=table.concat({...}, ' ')
    local target=findPlayer(plr, target)
    if not target then
        outputChatBox("✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
        return
    end
    if not (getElementData(target, "player:sid")) then
        outputChatBox("✘#ffffff Gracz nie jest zalogowany.", plr, 255, 0, 0, true)
    return end
    
    local pmoff=getElementData(target,"pmoff")
    if (pmoff) then
        outputChatBox("✘#ffffff "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." nie akceptuje wiadomości prywatnych.", plr, 255, 0, 0, true)
        if (type(pmoff)=="string") then
            outputChatBox("* Powód: " .. pmoff, plr)
        end
    return
    end

    if getElementData(plr,"pmoff") then
      outputChatBox("✘#ffffff Posiadasz wyłączone wiadomości prywatne. Ta osoba nie będzie mogła Ci odpisać.", plr, 255, 0, 0, true)
    end
    
    if getElementData(target, "mute:player") then
        outputChatBox("✘#ffffff Ten gracz jest wyciszony, nie odpisze Ci!", plr, 255, 0, 0, true)
    end

  if adSpammer(text) then
    if not getElementData(plr, "player:owner") then
    cancelEvent()
    triggerClientEvent(root, "admin:rendering", root, "["..getElementData(plr,"id").."] "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." został(a) wyrzucony(a) z serwera. Powód: Reklama")
    kickPlayer(plr, "Reklamowanie")
    end
    return end

  outputChatBox("#ffffff>>#ffffff #EEB124"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." ["..getElementData(target,"id").."]#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", plr, 175, 0, 0, true)
    outputChatBox("#ffffff<<#ffffff #FFC437"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." ["..getElementData(plr,"id").."]#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", target, 175, 0, 0, true)
    playSoundFrontEnd(target, 12)

  if not getElementData(target, "blokada:re:czas") then
    if target then
      setElementData(target, "blokada:re:czas", true)
      if getElementData(target, "blokada:re:czas") then setTimer(setElementData, 25000, 1, target, "blokada:re:czas", false) end
    end
  end


  local pm_text=('#FFE300PM#ffffff - [%d] %s (SID: #FFE300%d#ffffff) » [%d] %s (SID: #FFE300%d#ffffff): %s'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), text)
  local pm_text2=('[**PM**] [**%d**] **%s** (SID: %d) » [**%d**] **%s** (SID: %d): %s'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), text)
  triggerEvent("admin:logs", root, pm_text:gsub("#%x%x%x%x%x%x",""))
  outputServerLog(pm_text:gsub("#%x%x%x%x%x%x",""))
  triggerEvent("admin:addText", resourceRoot, pm_text)
  exports['nrpg_discord']:connectWeb(pm_text2:gsub("#%x%x%x%x%x%x",""), "PW")

  setElementData(plr, "pm:partner", target)
  setElementData(target, "pm:partner", plr)
end
addCommandHandler('pm', onPrivateMessage)

function privateMessageReply(plr, commandName, ...)
  local text = table.concat({...}, " "):gsub("#%x%x%x%x%x%x","")
  local text = text:gsub("#(%w%w)(%w%w)(%w%w)", "")
  local target = getElementData(plr, "pm:partner")
  if target and isElement(target) then

    
    if not getElementData(target, "blokada:re:czas") then
    if target then
      setElementData(target, "blokada:re:czas", true)
      if getElementData(target, "blokada:re:czas") then setTimer(setElementData, 25000, 1, target, "blokada:re:czas", false) end
    end
  end

  if getElementData(plr, 'mute:player') then
		return exports.nrpg_interface:showPlayerNotification(plr, "Jesteś wyciszony/a", "error")
	end

    local pmoff=getElementData(target,"pmoff")
    if (pmoff) then
    outputChatBox("✘#ffffff "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." nie akceptuje wiadomości prywatnych.", plr, 255, 0, 0, true)
    if (type(pmoff)=="string") then
      outputChatBox("* Powód: " .. pmoff, plr)
    end
    return
    end

    if getElementData(plr,"pmoff") then
      outputChatBox("✘#ffffff Posiadasz wyłączone wiadomości prywatne. Ta osoba nie będzie mogła Ci odpisać.", plr, 255, 0, 0, true)
    end
  
  if getElementData(target, "mute:player") then
    outputChatBox("✘#ffffff Ten gracz jest wyciszony, nie odpisze Ci!", plr, 255, 0, 0, true)
  end

    if adSpammer(text) then
    if not getElementData(plr, "player:owner") then
    cancelEvent()
    triggerClientEvent(root, "admin:rendering", root, "["..getElementData(plr,"id").."] "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." został(a) wyrzucony(a) z serwera. Powód: Reklama")
    kickPlayer(plr, "Reklamowanie")
    end
    return end

  outputChatBox("#ffffff>>#ffffff #EEB124"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." ["..getElementData(target,"id").."]#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", plr, 175, 0, 0, true)
  outputChatBox("#ffffff<<#ffffff #FFC437"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." ["..getElementData(plr,"id").."]#ffffff: "..text:gsub("#%x%x%x%x%x%x","").."", target, 175, 0, 0, true)
  playSoundFrontEnd(target, 12)

  local pm_text=('#FFE300PM#ffffff - [%d] %s (SID: #FFE300%d#ffffff) » [%d] %s (SID: #FFE300%d#ffffff): %s'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), text)
  local pm_text2=('[**PM**] [**%d**] **%s** (SID: %d) » [**%d**] **%s** (SID: %d): %s'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), text)
  triggerEvent("admin:logs", root, pm_text:gsub("#%x%x%x%x%x%x",""))
  outputServerLog(pm_text:gsub("#%x%x%x%x%x%x",""))
  triggerEvent("admin:addText", resourceRoot, pm_text)
  exports['nrpg_discord']:connectWeb(pm_text2:gsub("#%x%x%x%x%x%x",""), "PW")

    setElementData(plr,"pm:partner",target)
    setElementData(target,"pm:partner",plr)
  else
    outputChatBox("✘#ffffff Ten gracz wyszedł z gry!", plr, 255, 0, 0, true)
  end
end
addCommandHandler("re", privateMessageReply)

 addCommandHandler("pmon", function(plr,cmd)
   removeElementData(plr,"pmoff")
   outputChatBox("✔#ffffff wyłączone wiadomości prywatne", plr, 0, 255, 0, true)
   return
   end)

   addCommandHandler("pmoff", function(plr,cmd,...)
   local powod=table.concat({...}, ' ')
   if (not powod or string.len(powod)<2) then powod=true end
   setElementData(plr, "pmoff", powod)
   outputChatBox('✘ #ffffffNie akceptujesz wiadomości prywatnych', plr, 255, 0, 0, true)
   return
   end)

function onTransferMoney(plr, cmd, target, value)
    if not target or not tonumber(value) then
        outputChatBox('✘ #ffffffPoprawne użycie: /dajkase <nick/ID> <kwota>', plr, 255, 0, 0, true)
        return
    end

    if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end
		

    value=string.match(value, "%d*")
    value=tonumber(value)

    local target=findPlayer(plr, target)
    if not target then
    outputChatBox("✘ #ffffffNie znaleziono podanego gracza.", plr, 255, 0, 0,true)
        return
    end
  if not (getElementData(target, "player:sid")) then
     outputChatBox("✘ #ffffffPodany gracz nie jest zalogowany.", plr, 255, 0, 0,true)
  return end
    if getPlayerMoney(plr) < value then
    outputChatBox("✘ #ffffffNie posiadasz wystarczających środków przy sobie.", plr, 255, 0, 0,true)
        return
    end
    if value == 0 or value < 0 then
    outputChatBox("✘ #ffffffPodano nie prawidłową wartość.", plr, 255, 0, 0,true)
        return
    end

    takePlayerMoney(plr, value)
    givePlayerMoney(target ,value)

    outputChatBox("#30FF00✔ Przekazałeś/aś #ffffff"..value.." PLN#30FF00 dla gracza #ffffff"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."#30FF00.", plr,  0, 255, 0, true)
    outputChatBox("#30FF00✔ Otrzymałeś/aś #ffffff"..value.." PLN#30FF00 od gracza #ffffff"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#30FF00.", target,  0, 255, 0, true)

    local transfer_text=('#1EBB04PRZELEW#ffffff - [#1EBB04%d#ffffff] %s (SID: #1EBB04%d#ffffff) >> [#1EBB04%d#ffffff] %s (SID: #1EBB04%d#ffffff): #1EBB04%s#ffffff'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), value)
    local transfer_text2=('[**PRZELEW**] [**%d**] **%s** (SID: %d) >> [**%d**] **%s** (SID: %d): **%s**'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), value)
    triggerEvent("admin:addText", resourceRoot, transfer_text)
    triggerEvent("admin:logs", root, transfer_text:gsub("#%x%x%x%x%x%x",""))
    outputServerLog(transfer_text:gsub("#%x%x%x%x%x%x",""))
    exports['nrpg_discord']:connectWeb(transfer_text2:gsub("#%x%x%x%x%x%x",""), "Przelewy")
end
addCommandHandler('dajkase', onTransferMoney)
addCommandHandler('zaplac', onTransferMoney)

function onTransferMoneyPrzelew(plr, cmd, target, value)
    if not target or not tonumber(value) then
        outputChatBox("✘#ffffff Użycie: /przelej [Nick/ID] [Przelewana kwota]", plr, 255, 0, 0, true)
        return
    end

    if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end

    value=string.match(value, "%d*")
    value=tonumber(value)
    local target=findPlayer(plr,target)

    if not target then
        outputChatBox("✘#ffffff Nie znaleziono takiego gracza", plr, 255, 0, 0, true)
        return
    end

    if not (getElementData(target, "player:logged") == true) then
       outputChatBox("✘#ffffff Gracz nie jest zalogowany", plr, 255, 0, 0, true)
    return end
    
    if value == 0 or value < 0 then
        outputChatBox("✘#ffffff Podano złą wartość", plr, 255, 0, 0, true)
        return
    end
    local check = exports["DB2"]:pobierzWyniki("SELECT `bank_money` FROM `pystories_users` WHERE id="..tonumber(getElementData(plr, "player:sid")).." LIMIT 1")

    check.bank_money=tonumber(check.bank_money)
    if (check.bank_money<math.abs(value)) then
            outputChatBox("✘#ffffff Nie posiadasz środków na koncie!", plr, 255, 0, 0, true)
        return
    end
    exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money+"..math.abs(tonumber(value)).." WHERE id="..tonumber(getElementData(target, "player:sid")).." LIMIT 1")
    exports["DB2"]:zapytanie("UPDATE pystories_users SET bank_money=bank_money-"..math.abs(tonumber(value)).." WHERE id="..tonumber(getElementData(plr, "player:sid")).." LIMIT 1")

    outputChatBox("#30FF00✔ Przelano #ffffff"..value.." PLN#30FF00 dla gracza #ffffff"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."#30FF00.", plr,  0, 255, 0, true)
    outputChatBox("#30FF00✔ Otrzymałeś/aś przelew o wysokości #ffffff"..value.." PLN#30FF00 od gracza #ffffff"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#30FF00.", target,  0, 255, 0, true)
    
    local transfer_text=('#00FFFCPRZELEW-BANKOWY#ffffff - [%d]%s (SID: %d) >> [%d]%s (SID: %d): %s'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), value)
    local transfer_text2=('[**PRZELEW-BANKOWY**] [**%d**] **%s** (SID: %d) >> [**%d**] **%s** (SID: %d): **%s**'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), value)
    triggerEvent("admin:addText", resourceRoot, transfer_text)
    triggerEvent("admin:logs", root, transfer_text)
    outputServerLog(transfer_text)
    exports['nrpg_discord']:connectWeb(transfer_text2:gsub("#%x%x%x%x%x%x",""), "Przelewy")
end
addCommandHandler('przelej', onTransferMoneyPrzelew)

function podarujSerce(plr, cmd, target)
  if not target then
      outputChatBox("✘#ffffff Użycie: /serce <nick/id>", plr, 255, 0, 0, true)
    return
  end

  local target = findPlayer(plr,target)
  
  if target == plr then return end
  if not target then
      outputChatBox("✘#ffffff Nie znaleziono takiego gracza", plr, 255, 0, 0, true)
    return
  end

  outputChatBox(" ", plr,  255, 0, 0, true)
  outputChatBox("❤#ffffff Podarowano serce", plr,  255, 0, 0, true)
  outputChatBox(" ", plr,  255, 0, 0, true)

  outputChatBox(" ", target, 255, 0, 0, true)
  outputChatBox("❤#ffffff "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." podarował/a Ci serce!", target, 255, 0, 0, true)
  outputChatBox(" ", target, 255, 0, 0, true)
end
--addCommandHandler('serce', podarujSerce)

function przelewPP(plr, cmd, target, value)
if not getElementData(plr, "player:sid") then return end

    if exports["nrpg_antycheat"]:checkAccount(plr) == true then return end

    if not target then
      outputChatBox('✘ #ffffff/dajpp <nick/id> <ilość>', plr, 255, 0, 0, true)
    return
    end

    local target=findPlayer(plr, target)
    if not target then
    outputChatBox("✘#ffffff Nie znaleziono podanego gracza.", plr, 255, 0, 0, true)
    return
    end

    if not tonumber(value) then return end
    if tonumber(value) < 1 then return end
    if getElementData(target, "player:sid") == getElementData(plr, "player:sid") then return end
    if tonumber(value) > getElementData(plr, "player:pp")  then return end

    outputChatBox("#30FF00✔#ffffff Przekazałeś/aś #F0FF00"..value.." Punktów premium#ffffff dla gracza #F0FF00"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."#ffffff.", plr,  0, 255, 0, true)
    outputChatBox("#30FF00✔#ffffff Otrzymałeś/aś #F0FF00"..value.." Punktów premium#ffffff od gracza #F0FF00"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."#ffffff.", target,  0, 255, 0, true)


    local transfer_text=('#1EBB04PRZELEW-PP#ffffff - [#1EBB04%d#ffffff] %s (SID: #1EBB04%d#ffffff) >> [#1EBB04%d#ffffff] %s (SID: #1EBB04%d#ffffff): #1EBB04%s#ffffff'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), value)
    local transfer_text2=('[**PRZELEW-PP**] [**%d**] **%s** (SID: %d) >> [**%d**] **%s** (SID: %d): **%s**'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:sid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:sid"), value)
    triggerEvent("admin:addText", resourceRoot, transfer_text)
    triggerEvent("admin:logs", root, transfer_text:gsub("#%x%x%x%x%x%x",""))
    exports['nrpg_discord']:connectWeb(transfer_text2:gsub("#%x%x%x%x%x%x",""), "Przelewy")

    local pp_plr = getElementData(plr, "player:pp")
    local pp_target = getElementData(target, "player:pp")

    setElementData(plr, "player:pp", pp_plr-value)
    setElementData(target, "player:pp", pp_target+value)
end
addCommandHandler('dajpp', przelewPP)


function convertNumber ( number )  
    local formatted = number  
    while true do      
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
        if ( k==0 ) then      
            break   
        end  
    end  
    return formatted
end

addEventHandler("onPlayerCommand", root, function(command)

if command == "register" then cancelEvent() return end
if (not getElementData(source, "player:level") == 4) then
if command == "tex" then cancelEvent() return end
end
if command == "crun" then cancelEvent() return end
if command == "srun" then cancelEvent() return end
if command == "msg" then cancelEvent() return end
if command == "Toggle" then return end
if command == "Next" then  return end
if command == "Previous" then  return end
if command == "say" then  return end
end
)

function adSpammer(ip)
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