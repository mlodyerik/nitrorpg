local licz = {} 


function isPlayerInPoliceFaction(plr)
 local sid=getElementData(plr,'player:sid')
 if not sid then return end

 local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SAPD", sid)
 if result[1] then
  return true
 else
  return false
 end
end


function isPlayerInSafdFaction(plr)
 local sid=getElementData(plr,'player:sid')
 if not sid then return end

 local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SAFD", sid)
 if result[1] then
  return true
 else
  return false
 end
end

function isPlayerInSaraFaction(plr)
 local sid=getElementData(plr,'player:sid')
 if not sid then return end

 local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SARA", sid)
 if result[1] then
  return true
 else
  return false
 end
end

function isPlayerInTaxiFaction(plr)
 local sid=getElementData(plr,'player:sid')
 if not sid then return end
   
local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "TAXI", sid)
if result[1] then
	return true
 else
	 return false
 end
end

function naliczanie(el)
	if isElement(el) then
   local x = getElementData(el,"player:workinjob") or 0
   setElementData(el,"player:workinjob",x+1)
   else
	if isTimer(licz[el]) then
	killTimer(licz[el])
	licz[el] = nil
	end
   end
end

function es2(el)
if getElementData(el, "player:faction", true) then
    outputChatBox("#1aff00✔#ffffff Przeszedłeś(aś) na chwilową przerwę we frakcji.", el, 0, 0, 0, true)
	local jakafrakcja = getElementData(el, "player:faction")
	local jakaranga = getElementData(el, "player:rank")
    exports['nrpg_faction_core']:zatrzymajnaliczanie(el)
    setElementData(el, 'player:faction', false)
	setElementData(el,"player:rank",false)
    local desc = "[S2] Gracz: "..getPlayerName(el):gsub("#%x%x%x%x%x%x","").." przeszedł na chwilową przerwę we frakcji."
    triggerEvent("admin:addText", root, desc)
    triggerEvent("admin:logs", root, desc)
    setElementData(el, "player:s2", true)
    end
end

function es3(el)
if getElementData(el, "player:s2",true) and isPlayerInPoliceFaction(el) then
      outputChatBox("#1aff00✔#ffffff Wróciłeś(aś) z chwilowej przerwy we frakcji.", el, 0, 0, 0, true)
      exports['nrpg_faction_core']:rozpocznijnaliczanie(el)
		setElementData(el, "player:faction", "SAPD")
		local rank = exports['nrpg_faction_core']:getPlayerFactionRank(el, "SAPD")
		setElementData(el,"player:rank",rank)
		setElementData(el,"last:nick",getPlayerName(el))
		setElementData(el,"last:color",tostring(getPlayerNametagColor(el)))
		local desc = "[S3] Gracz: "..getPlayerName(el):gsub("#%x%x%x%x%x%x","").." wrócił z chwilowej przerwy we frakcji."
		triggerEvent("admin:logs", root, desc)
		triggerEvent("admin:addText", root, desc)
		outputServerLog(desc)
		local sid=getElementData(el,"player:sid")
		exports['nrpg_db']:dbSet('UPDATE pystories_factions set actived=NOW() WHERE faction=? AND uid=? LIMIT 1;', SAPD, sid)
        setElementData(el, "player:s2", false)
		
	elseif getElementData(el, "player:s2", true) and isPlayerInSafdFaction(el) then
		outputChatBox("#1aff00✔#ffffff Wróciłeś z chwilowej przerwy we frakcji.", el, 0, 0, 0, true)
        exports['nrpg_faction_core']:rozpocznijnaliczanie(el)
		setElementData(el, "player:faction", "SAFD")
		local rank = exports['nrpg_faction_core']:getPlayerFactionRank(el, "SAFD")
		setElementData(el,"player:rank",rank)
		setPedStat(el,78,1000)
		setPedStat(el,70,1000)
		setElementData(el,"last:nick",getPlayerName(el))
		setElementData(el,"last:color",tostring(getPlayerNametagColor(el)))
		local desc = "[S3] Gracz: "..getPlayerName(el):gsub("#%x%x%x%x%x%x","").." wrócił z chwilowej przerwy we frakcji."
		triggerEvent("admin:logs", root, desc)
		triggerEvent("admin:addText", root, desc)
		outputServerLog(desc)
		local sid=getElementData(el,"player:sid")
		exports['nrpg_db']:dbSet('UPDATE pystories_factions set actived=NOW() WHERE faction=? AND uid=? LIMIT 1;', SAFD, sid)
        setElementData(el, "player:s2", false)

	elseif getElementData(el, "player:s2", true) and isPlayerInSaraFaction(el) then
		outputChatBox("#1aff00✔#ffffff Wróciłeś z chwilowej przerwy we frakcji.", el, 0, 0, 0, true)
        exports['nrpg_faction_core']:rozpocznijnaliczanie(el)
		setElementData(el, "player:faction", "SARA") 
		local rank = exports['nrpg_faction_core']:getPlayerFactionRank(el, "SARA")
		setElementData(el,"player:rank",rank)
		setPedStat(el,78,1000)
		setPedStat(el,70,1000)
		setElementData(el,"last:nick",getPlayerName(el))
		setElementData(el,"last:color",tostring(getPlayerNametagColor(el)))
		local desc = "[S3] Gracz: "..getPlayerName(el):gsub("#%x%x%x%x%x%x","").." wrócił z chwilowej przerwy we frakcji."
		triggerEvent("admin:logs", root, desc)
		triggerEvent("admin:addText", root, desc)
		outputServerLog(desc)
		local sid=getElementData(el,"player:sid")
		exports['nrpg_db']:dbSet('UPDATE pystories_factions set actived=NOW() WHERE faction=? AND uid=? LIMIT 1;', SARA, sid)
        setElementData(el, "player:s2", false)

	elseif getElementData(el, "player:s2", true) and isPlayerInTaxiFaction(el) then
		outputChatBox("#1aff00✔#ffffff Wróciłeś z chwilowej przerwy we frakcji.", el, 0, 0, 0, true)
        exports['nrpg_faction_core']:rozpocznijnaliczanie(el)
		setElementData(el, "player:faction", "TAXI") 
		local rank = exports['nrpg_faction_core']:getPlayerFactionRank(el, "TAXI")
		setElementData(el,"player:rank",rank)
		setPedStat(el,78,1000)
		setPedStat(el,70,1000)
		setElementData(el,"last:nick",getPlayerName(el))
		setElementData(el,"last:color",tostring(getPlayerNametagColor(el)))
		local desc = "[S3] Gracz: "..getPlayerName(el):gsub("#%x%x%x%x%x%x","").." wrócił z chwilowej przerwy we frakcji."
		triggerEvent("admin:logs", root, desc)
		triggerEvent("admin:addText", root, desc)
		outputServerLog(desc)
		local sid=getElementData(el,"player:sid")
		exports['nrpg_db']:dbSet('UPDATE pystories_factions set actived=NOW() WHERE faction=? AND uid=? LIMIT 1;', TAXI, sid)
        setElementData(el, "player:s2", false)
		end
end


addCommandHandler("s3", es3)
addCommandHandler("s2", es2)