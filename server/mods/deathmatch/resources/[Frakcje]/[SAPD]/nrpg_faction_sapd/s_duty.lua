function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function isPlayerInSAPDFaction(plr)
	local sid=getElementData(plr,'player:sid')
	if not sid then return end

    local result=exports["nrpg_db"]:dbGet("SELECT * FROM pystories_users WHERE id=?", getElementData(plr, "player:sid"))
	if result[1].register_serial ~= getPlayerSerial(plr) then
        outputChatBox("✘ #ffffffW związku z zmianą numeru seryjnego MTA ta opcja jest zablokowana, jeśli chcesz ją odblokować wejdź na nasz teamspeak3: nitrorpg - Strefa pomocy.", plr, 255, 0, 0,true)
		return false
	end

	local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SAPD", sid)
	if result[1] then
		return true
	else
		return false
	end
end

function rozpocznijSAPD(el)
    if isPlayerInSAPDFaction(el) then
      if not getElementData(el, 'player:faction') then
        exports['nrpg_faction_core']:rozpocznijnaliczanie(el)
        setElementData(el,'player:faction', 'SAPD')
        local rank = exports['nrpg_faction_core']:getPlayerFactionRank(el, 'SAPD')
        setElementData(el, "player:rank", rank)
        local actualSkin = getElementModel(el)
        setElementData(el, "player:factionskin", actualSkin)
        outputChatBox("✓#ffffff Rozpocząłeś/aś służbe w SAPD.", el, 0, 255, 0, true)
        exports['nrpg_discord']:connectWeb("**"..getPlayerName(el):gsub("#%x%x%x%x%x%x","").."** rozpoczyna służbę we frakcji **SAPD**.", "logi_sapd") 
        toggleControl(el, "fire", true)
        toggleControl(el, "aim_weapon", true)
        setPedStat(el, 78, 1000)
        setPedStat(el, 70, 1000)
          else
        exports['nrpg_faction_core']:zatrzymajnaliczanie(el)
        setElementData(el, 'player:faction', false)
        setElementData(el, "player:rank", false)
        local actualSkin = getElementData(el, "player:factionskin") or 0
        setElementModel(el, actualSkin)
        outputChatBox("✓#ffffff Zakończyłeś/aś służbe w SAPD.", el, 0, 255, 0, true)
        exports['nrpg_discord']:connectWeb("**"..getPlayerName(el):gsub("#%x%x%x%x%x%x","").."** zakończył służbę we frakcji **SAPD**.", "logi_sapd") 
        toggleControl(el, "fire", false)
        toggleControl(el, "aim_weapon", false)
        takeAllWeapons(el)
      end
      else
      outputChatBox('✘#ffffff Nie jesteś zatrudniony/a w tej frakcji.', el, 255, 0, 0, true)
    end
end
    


local startMarker = createMarker(4616.60, 369.18, 5391.20, "cylinder", 2, 255, 255, 0, 55)
setElementData(startMarker, "marker:text", "ROZPOCZĘCIE SŁUŻBY\nSAN ANDREAS POLICE DEPARTMENT")
setElementDimension(startMarker, 0)
setElementInterior(startMarker, 0)
addEventHandler("onMarkerHit", startMarker, rozpocznijSAPD)

function pacholek(source,command)
    if getElementData(source,'player:faction') and getElementData(source,'player:faction')=='SAPD' then
        local rbs = getElementData(source,'player:rbs') or {}  
        local x,y,z = getElementPosition(source)   
        local rotX,rotY,rotZ = getElementRotation(source)
		local ob = createObject(1238,x,y,z-0.65,0,0,rotZ)
        setElementFrozen(ob,true)
        table.insert(rbs,ob )
        setTimer(function() if isElement(ob) then destroyElement(ob) end end,60000 * 20,1)                
        outputChatBox('#06B200✔ #FFFFFFPomyślnie ustawiono pachołek. ID: '..#rbs,source,255,255,255,true)
        setElementData(source,'player:rbs',rbs)
        setElementData(ob,'obiekt', true)
        setElementData(ob,'obiect:create', getPlayerName(source))  
		setElementInterior(ob, getElementInterior(source))
        setElementDimension(ob, getElementDimension(source))   
    end
end

function barierka(source,command)
    if getElementData(source,'player:faction') and getElementData(source,'player:faction')=='SAPD' then
        local rbs = getElementData(source,'player:rbs') or {}    
        local x,y,z = getElementPosition(source)   
        local rotX,rotY,rotZ = getElementRotation(source)  
        local obj = createObject(1228, x,y,z-0.65,0,0,rotZ)
        table.insert(rbs,obj )
        setTimer(function() if isElement(obj) then destroyElement(obj) end end,60000 * 20,1)  
        setElementFrozen(obj,true)
        outputChatBox('#06B200✔ #FFFFFFPomyślnie ustawiono barierkę. ID: '..#rbs,source,255,255,0, true)
        setElementData(source,'player:rbs',rbs)
        setElementData(obj,'obiekt', true)
        setElementData(obj, 'obiect:create', getPlayerName(source))    
        setElementInterior(obj, getElementInterior(source))
        setElementDimension(obj, getElementDimension(source))   
    end
end

function barierka2(source,command)
    if getElementData(source,'player:faction') and getElementData(source,'player:faction')=='SAPD' then
        local rbs = getElementData(source,'player:rbs') or {}    
        local x,y,z = getElementPosition(source)   
        local rotX,rotY,rotZ = getElementRotation(source)  
        local obj = createObject(1424, x,y,z-0.45,0,0,rotZ)
        table.insert(rbs,obj )
        setTimer(function() if isElement(obj) then destroyElement(obj) end end,60000 * 20,1)  
        setElementFrozen(obj,true)
        outputChatBox('#06B200(✔ #FFFFFFPomyślnie ustawiono barierkę. ID: '..#rbs,source,255,255,0, true)
        setElementData(source,'player:rbs',rbs)
        setElementData(obj,'obiekt', true)
        setElementData(obj, 'obiect:create', getPlayerName(source))    
        setElementInterior(obj, getElementInterior(source))
        setElementDimension(obj, getElementDimension(source))   
    end
end
	
	
addCommandHandler('ustaw',function(source,cmd,arg)
    if not arg then outputChatBox("#007affⓘ #FFFFFFPoprawne użycie: #007aff/ustaw [pacholek / barierka / barierka2]",source,255,255,255,true) return end
    if getElementData(source,'player:faction') and getElementData(source,'player:faction')=='SAPD' then
        if arg == "pacholek" then
			pacholek(source)
        elseif arg == "barierka" then
			barierka(source)
            elseif arg == "barierka2" then
        barierka2(source)
        end
    end
end)

addCommandHandler('usun',function(source,cmd,arg,arg2)
    if not arg then outputChatBox("#007affⓘ #FFFFFFPoprawne użycie: #007aff/usun [blokady/blokade]",source,255,255,255,true) return end
    if getElementData(source,'player:faction') and getElementData(source,'player:faction')=='SAPD' then
        if arg == "blokady" then
			blokady(source)
        elseif arg == "blokade" then
			if not arg2 then outputChatBox("#007affⓘ #FFFFFFProszę wpisać ID blokady.",source,255,255,255,true) return end
			blokade(source,arg2)
        end
    end
end)

function blokady(plr)
    if getElementData(plr,'player:rbs') then
		for key, value in ipairs(getElementData(plr,'player:rbs')) do
			if isElement(value) then
				destroyElement(value)
			end
		end
		outputChatBox('#06B200✔ #FFFFFFPomyślnie usunięto blokady.',plr,255,255,255,true)
		removeElementData(plr,'player:rbs')
    end
end

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,'player:rbs') then
		for key, value in ipairs(getElementData(source,'player:rbs')) do
			if isElement(value) then
				destroyElement(value)
			end
		end
	end
end)

function blokade(plr,value)
    if value then
		local rbs = {}  
		for key, v in ipairs(getElementData(plr,'player:rbs')) do
			if isElement(v) and key == tonumber(value) then
				destroyElement(v)
				outputChatBox('#06B200✔ #FFFFFFPomyślnie usunięto Blokadę ID: '..key,plr,255,255,0,true)
				else
				table.insert(rbs,v)
			end
			setElementData(plr,'player:rbs',rbs)
		end
		else
    end
end