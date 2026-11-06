local tasmy={}

function isGuardian(plr)
  local lvl=getElementData(plr,"ranga") or 0
  if not tonumber(lvl) or lvl<3 then return false end
  return true
end

local isMundurowy=(
	function(plr)
		if getElementData(plr, "player:faction") then
			return true
		end
		return false
	end
)

addCommandHandler("tasma",
	function(plr)
		if not getElementData(plr,"player:sid") then return end
		if not isMundurowy(plr) then return end
		if isPedInVehicle(plr) then
			exports.nrpg_interface:showPlayerNotification(plr,'Najpierw wyjdź z auta.', 'error')
			return
		end
		if not isGuardian(plr) then
			if (getElementInterior(plr)~=0) or (getElementDimension(plr)~=0) then
				exports.nrpg_interface:showPlayerNotification(plr,'Taśmy można używać tylko na dimensionie i interiorze 0', 'error')
				return
			end
		end
		local z_t=nil
		for i,v in ipairs(tasmy) do
			if v.plr then
				if (v.plr==plr) then
					z_t=true
				end
			end
		end
		if z_t then
			exports.nrpg_interface:showPlayerNotification(plr,'Nie posiadasz więcej taśmy.', 'error')
			return
		end
		local x,y,z=getElementPosition(plr)
		local stojak=createObject(16737, x,y,z-1.7)
		setElementCollisionsEnabled(stojak,false)
		setObjectScale(stojak,0)
		setElementData(stojak,"owner:stojaka",plr)
		if not getElementData(plr,"policja:tasma") then
			triggerClientEvent(root, "evc", resourceRoot, "tasma", plr,stojak,x,y,z)
			setElementData(plr,"policja:tasma",true)
		else
			triggerClientEvent(root,"evc",resourceRoot,"przetnij_tasme",plr,stojak,x,y,z)
		end
	end
)

addCommandHandler("zakoncztasme", function(plr)
	if not getElementData(plr,"player:sid") then return end
	if not isMundurowy(plr) then return end
	triggerClientEvent(root,"evc",resourceRoot,"zakoncz_tasme",plr)
end)

usun_z_tabeli=(
	function(plr)
		for i,v in ipairs(tasmy) do
			if (v.plr==plr) then
				table.remove(tasmy,i)
				break
			end
		end
		local z_p=nil
		for i,v in ipairs(tasmy) do
			if (v.plr==plr) then
				z_p=true
			end
		end
		if z_p then
			usun_z_tabeli(plr)
		end
	end
)

usunTasme=(
	function(plr)
		for i,v in ipairs(tasmy) do
			if (v.plr==plr) then
				if v.strefa and isElement(v.strefa) then
					destroyElement(v.strefa)
				end
				if v.stojak and isElement(v.stojak) then
					destroyElement(v.stojak)
				end
			end
		end
		local obiekty=getElementsByType("object",resourceRoot)
		if (#obiekty>0) then
			for i,v in ipairs(obiekty) do
				if (getElementData(v,"owner:stojaka")==plr) then
					destroyElement(v)
				end
			end
		end
		usun_z_tabeli(plr)
		removeElementData(plr,"policja:tasma")
		triggerClientEvent(root,"evc",resourceRoot,"pobierz_tasmy",tasmy,plr)
	end
)

addCommandHandler("usuntasme",
	function(plr)
		if getElementData(plr,"policja:tasma") then
			usunTasme(plr)
		end
	end
)

addEventHandler("onPlayerWasted",root,
	function()
		if getElementData(source,"policja:tasma") then
			usunTasme(source)
		end
	end
)

addEventHandler("onPlayerQuit",root,
	function()
		if getElementData(source,"policja:tasma") then
			usunTasme(source)
		end
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function()
		for i,v in ipairs(getElementsByType("player")) do
			if isMundurowy(v) then
				if getElementData(v,"policja:tasma") then
					removeElementData(v,"policja:tasma")
				end
			end
		end
	end
)

addEvent("ev",true)
addEventHandler("ev",resourceRoot,
	function(ev,arg1)
		if (ev=="zakoncz_tasme") then
			--local tasmy=arg1
			local tasmy_clienta=arg1
			local koordy={}
			--for i,v in ipairs(tasmy) do
			--	if (v.plr==client) then
			--		table.insert(tasmy_clienta,{poczatek={v.poczatek[1],v.poczatek[2],v.poczatek[3]},koniec={v.koniec[1],v.koniec[2],v.koniec[3]},plr=client})
			--	end
			--end
			for i,v in ipairs(tasmy_clienta) do
				table.insert(koordy,v.poczatek[1])
				table.insert(koordy,v.poczatek[2])
				if (i==(#tasmy_clienta-1)) then
					table.insert(koordy,v.koniec[1])
					table.insert(koordy,v.koniec[2])
				end
			end
			--outputChatBox(#koordy)
			local strefa=createColPolygon(unpack(koordy))
			for i,v in ipairs(tasmy_clienta) do
				table.insert(tasmy,{poczatek={v.poczatek[1],v.poczatek[2],v.poczatek[3]},koniec={v.koniec[1],v.koniec[2],v.koniec[3]},plr=v.plr,strefa=strefa,stojak=v.stojak})
			end
			tasmy_clienta={}
			koordy={}
		end
	end
)

addEventHandler("onElementDataChange", root,  -- czyli onPlayerLogin
	function(name, oldvalue)
		if (name=="player:sid") and not oldvalue then
			if (getElementType(source)=="player") then
				triggerClientEvent(source,"evc",resourceRoot,"pobierz_tasmy",tasmy)
			end
		end
	end
)

addEventHandler("onVehicleExit",root,
	function(plr)
		if (#tasmy==0) then
			return
		end
		if isMundurowy(plr) or isGuardian(plr) then
			return
		end
		local veh=source
		if not veh or not isElement(veh) then
			return
		end
		local strefy=getElementsByType("colshape",resourceRoot)
		local px,py,pz=getElementPosition(veh)
		if not veh or not isElement(veh) then
			return
		end
		setTimer(function(plr,veh,px,py,pz)
			for i,v in ipairs(strefy) do
				if plr and isElement(plr) then
					if veh and isElement(veh) then
						if not isElementWithinColShape(veh,v) then
							if isElementWithinColShape(plr,v) then
								setElementPosition(plr,px,py,pz+1)
							end
						end
					end
				end
			end
		end,500,1,plr,veh,px,py,pz)
	end
)