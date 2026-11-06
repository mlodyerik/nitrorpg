--CAR_CHAT    CAR_Sc1_BR  --animacja siedzenia

local tbl={}

local wsiadz=(
	function(veh,miejsce,door)
		setVehicleDoorOpenRatio(veh,door,1,500)
		setTimer(function()
			setVehicleDoorOpenRatio(veh,door,0,500)
		end,500,1)
	end
)

local miejsca={
	{0.7,1.4,0.3},
	{-0.7,1.4,0.3},
	{0,1.4,0.3},
}

local sprawdzCzyJestWolne=(
	function(miejsce)
		local wolne=false
		if not miejsce or not isElement(miejsce) then
			wolne=true
		elseif isElement(miejsce) then
			if (getElementType(miejsce)=="player") then
				if not isElementAttached(miejsce) then
					wolne=true
				end
			end
		end
		return wolne
	end
)

local timer={}


addCommandHandler("wejdz",
	function(plr)
	if getElementData(plr,'player:faction') == 'SAFD' then		
               local siedzi=false
		local veh=nil
		local z_v=nil
		for i,v in ipairs(tbl) do
			if (v.door1==plr) or (v.door2==plr) or (v.door3==plr) then
				siedzi=true
				veh=v.veh
				z_v=v
				break
			end
		end
		if isTimer(timer[plr]) or timer[plr] then
			return
		end
		if not siedzi then
			triggerClientEvent(plr,"evc",resourceRoot,"wejdz")
		else -- wysiadanie
			local _,_,rz=getElementRotation(veh)
			setElementRotation(plr,0,0,rz)
			local miejsce=nil
			if (plr==z_v.door1) then
				miejsce=1
			elseif (plr==z_v.door2) then
				miejsce=2
			elseif (plr==z_v.door3) then
				miejsce=3
			end
			detachElements(plr)
			setElementCollisionsEnabled(plr,true)
			if (miejsce==1) or (miejsce==2) then
				if (miejsce==1) then
					setPedAnimation(plr,"TRUCK","TRUCK_getout_LHS",-1,false)
				end
				setTimer(setVehicleDoorOpenRatio,200,1,veh,4,1,250)
				if (miejsce==2) then
					local x,y,z=getElementPosition(veh)
					local _,_,pozZ=getElementPosition(plr)
					local rrz=math.rad(rz-135)
					local px=x - (1.7 * math.sin(-rrz))
					local py=y - (1.7 * math.cos(-rrz))
					setTimer(setElementPosition,450,1,plr,px,py,pozZ)
				end
				setTimer(setPedAnimation,500,1,plr,"TRUCK","TRUCK_close_LHS",-1,false)
				timer[plr]=setTimer(function()
					setVehicleDoorOpenRatio(veh,4,0,250)
					timer[plr]=nil
				end,750,1)
			elseif (miejsce==3) then
				setPedAnimation(plr,"TRUCK","TRUCK_getout_RHS",-1,false)
				setTimer(setVehicleDoorOpenRatio,200,1,veh,5,1,250)
				setTimer(setPedAnimation,500,1,plr,"TRUCK","TRUCK_close_RHS",-1,false)
				timer[plr]=setTimer(function()
					setVehicleDoorOpenRatio(veh,5,0,250)
					timer[plr]=nil
				end,750,1)
			end
			timer[plr]=setTimer(function()
				setPedAnimation(plr)
				triggerClientEvent(plr,"evc",resourceRoot,"wlacz_przenikanie_kamery",false)
				timer[plr]=nil
				if (plr==z_v.door1) then
					z_v.door1=nil
				elseif (plr==z_v.door2) then
					z_v.door2=nil
				elseif (plr==z_v.door3) then
					z_v.door3=nil
				end
			end,1250,1)
		end
	end

addEvent("ev",true)
addEventHandler("ev",resourceRoot,
	function(ev,arg1,arg2)
		if (ev=="wsiadz") then
			local veh=arg1
			local door=arg2
			local z_p=nil
			for i,v in ipairs(tbl) do
				if (v.veh==veh) then
					z_p=v
				end
			end
			if not z_p then
				table.insert(tbl,{veh=veh})
			end
			for i,v in ipairs(tbl) do
				if (v.veh==veh) then
					z_p=v
				end
			end
			if not z_p then
				return
			end
			--local znalezione_drzwi=nil
			--if (#z_p.doors==0) then
			--	znalezione_drzwi=1
			--end
			--if not znalezione_drzwi then
			--	for i,v in ipairs(z_p.doors) do
			--		if not v or not isElement(v) then
			--			znalezione_drzwi=i
			--		end
			--		if not znalezione_drzwi and isElement(v) then
			--			if not isElementAttached(v) then
			--				znalezione_drzwi=i
			--			end
			--		end
			--		if znalezione_drzwi then
			--			break
			--		end
			--	end
			--end
			--if not znalezione_drzwi then
			--	exports["es-komunikaty"]:komunikat("Wszystkie miejsca z tyÅ‚u sÄ… zajÄ™te.",client)
			--	return
			--end
			local _,_,rz=getElementRotation(veh)
			if (door==4) then
				local wolne=sprawdzCzyJestWolne(z_p.door1)
				local miejsce=1
				if not wolne then
					wolne=sprawdzCzyJestWolne(z_p.door2)
					miejsce=2
				end
				if wolne then
					--outputChatBox(miejsce)
					setElementRotation(client,0,0,rz)
					setPedAnimation(client,"TRUCK","TRUCK_ALIGN_LHS",-1,false)
					setTimer(setPedAnimation,500,1,client,"TRUCK","TRUCK_open_LHS",-1,false)
					setTimer(setVehicleDoorOpenRatio,750,1,veh,4,1,250)
					setTimer(setPedAnimation,1000,1,client,"TRUCK","TRUCK_getin_LHS",-1,false)
					if (miejsce==1) then
						setTimer(attachElements,1250,1,client,veh,-0.7,1.9,-0.5) -- prawa strona
						z_p.door1=client
						setElementCollisionsEnabled(client,false)
					elseif (miejsce==2) then
						setTimer(attachElements,1250,1,client,veh,-0,0.0,0)
						z_p.door2=client
						setElementCollisionsEnabled(client,false)
					end
					setTimer(setPedAnimation,1500,1,client,"TRUCK","TRUCK_closedoor_LHS",-1,false)
					local gracz=client
					timer[client]=setTimer(function()
						setVehicleDoorOpenRatio(veh,4,0,250)
						timer[gracz]=nil
					end,1750,1)
					setTimer(function(client)
						triggerClientEvent(client,"evc",resourceRoot,"wlacz_przenikanie_kamery",true,veh)
					end,1000,1,client)
				else
					outputChatBox("To miejsce jest zajête.", client, 255, 255, 255, true)
				end
			elseif (door==5) then
				local wolne=sprawdzCzyJestWolne(z_p.door3)
				local miejsce=3
				if not wolne then
					wolne=sprawdzCzyJestWolne(z_p.door2)
					miejsce=2
				end
				if wolne then
					--outputChatBox(miejsce)
					setElementRotation(client,0,0,rz)
					setPedAnimation(client,"TRUCK","TRUCK_ALIGN_RHS",-1,false)
					setTimer(setPedAnimation,500,1,client,"TRUCK","TRUCK_open_RHS",-1,false)
					setTimer(setVehicleDoorOpenRatio,750,1,veh,5,1,250)
					setTimer(setPedAnimation,1000,1,client,"TRUCK","TRUCK_getin_RHS",-1,false)
					if (miejsce==3) then
						setTimer(attachElements,1250,1,client,veh,0.7,1.9,-0.5) -- lewa strona
						z_p.door3=client
						setElementCollisionsEnabled(client,false)
					elseif (miejsce==2) then
						setTimer(attachElements,1250,1,client,veh,0,1.2,0)
						z_p.door2=client
						setElementCollisionsEnabled(client,false)
					end
					setTimer(setPedAnimation,1500,1,client,"TRUCK","TRUCK_closedoor_RHS",-1,false)
					local gracz=client
					timer[client]=setTimer(function()
						setVehicleDoorOpenRatio(veh,5,0,250)
						timer[gracz]=nil
					end,1750,1)
					setTimer(function(client)
						triggerClientEvent(client,"evc",resourceRoot,"wlacz_przenikanie_kamery",true,veh)
					end,1000,1,client)
				else
					outputChatBox("To miejsce jest zajête.", client, 255, 255, 255, true)
				end
			end
		end
	end
)

local pum=(
	function(plr)
		if plr and isElement(plr) then
			detachElements(plr)
			setElementCollisionsEnabled(plr,true)
			setPedAnimation(plr)
			triggerClientEvent(plr,"evc",resourceRoot,"wlacz_przenikanie_kamery",false)
		end
	end
)

addEventHandler("onElementDestroy",root,
	function()
		local veh=source
		if (getElementType(veh)=="vehicle") then
			local z_v=nil
			for i,v in ipairs(tbl) do
				if (v.veh==veh) then
					z_v=v
				end
			end
			if not z_v then
				return
			end
			pum(z_v.door1)
			pum(z_v.door2)
			pum(z_v.door3)
			for i,v in ipairs(tbl) do
				if (v.veh==veh) then
					table.remove(tbl,i)
					break
				end
			end
		end
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function()
		for i,v in ipairs(tbl) do
			pum(v.door1)
			pum(v.door2)
			pum(v.door3)
		end
	end
)

isInWoz=(
	function(plr)
		local siedzi=nil
		for i,v in ipairs(tbl) do
			if (v.door1==plr) or (v.door2==plr) or (v.door3==plr) then
				siedzi=true
			end
		end
		return siedzi
	end
)

--local veh=createVehicle(407,-148.32,-1327.06,2.94,0,0,22.9)
--addCommandHandler("q",
--	function(plr)
--		attachElements(plr,veh,0,1.4,0.3,0,0,0)
--		setPedAnimation(plr,"CAR_CHAT","CAR_Sc1_BR",-1)
--	end
--)

--local pedowanie=nil
--addCommandHandler("q",
--	function(plr)
--		pedowanie=setPedAnimation(plr,"POLICE","crm_drgbst_01",-1,false)
--	end
--)
--addCommandHandler("q2",
--	function(plr)
--		outputChatBox(tostring(pedowanie))
--	end
end 
)
