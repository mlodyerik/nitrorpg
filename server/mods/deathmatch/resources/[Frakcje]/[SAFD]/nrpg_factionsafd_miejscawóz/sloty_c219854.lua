function getPositionFromElementOffset(element,offX,offY,offZ)
  local m = getElementMatrix ( element )  -- Get the matrix
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z                               -- Return the transformed point
end

--[[
addCommandHandler("wejdz",
	function()
		local x,y,z=getElementPosition(localPlayer)
		local offx,offy,offz=getPositionFromElementOffset(localPlayer,0,1.1,0)
		if isLineOfSightClear(x,y,z,offx,offy,offz,false,true,false,false,false) then
			outputChatBox("Stan twarza do pojazdu lub podejdz blizej."client, 255, 255, 255, true)
			return
		end
		local hit,_,_,_,veh,_,_,_,_,_,piece=processLineOfSight(x,y,z,offx,offy,offz,false,true,false,false,false)
		if not hit then
			return
		end
		if (getElementType(veh)~="vehicle") then
			return
		end
		if veh and isElement(veh) then
			if (getElementModel(veh)==407) then
				if not piece then
					return
				end
				if (piece==7) then
					piece=4
				elseif (piece==8) then
					piece=5
				else
					outputChatBox("Musisz sta� przodem do wybranych tylnych drzwi.", client, 255, 255, 255, true)

					return
				end
				triggerServerEvent("ev",resourceRoot,"wsiadz",veh,piece)
			end
		end
	end
)]]--

local wlaczony=false
local vehicle=nil

local render=(
	function()
		if not vehicle or not isElement(vehicle) then
			return
		end
		local block,anim=getPedAnimation(localPlayer)
		if (block=="truck") and ((anim=="TRUCK_closedoor_RHS") or (anim=="TRUCK_closedoor_LHS")) then
			local _,_,rz=getElementRotation(vehicle)
			setElementRotation(localPlayer,0,0,rz)
		end
	end
)


addEvent("evc",true)
addEventHandler("evc",resourceRoot,
	function(ev,arg1,arg2)
		if (ev=="wlacz_przenikanie_kamery") then
			if arg1 then
				vehicle=arg2
				if not wlaczony then
					addEventHandler("onClientRender",root,render)
					wlaczony=true
				end
				setCameraClip(true,false)
			else
				vehicle=nil
				if wlaczony then
					removeEventHandler("onClientRender",root,render)
					wlaczony=false
				end
				setCameraClip(true,true)
			end
		elseif (ev=="wejdz") then
			local x,y,z=getElementPosition(localPlayer)
			local offx,offy,offz=getPositionFromElementOffset(localPlayer,0,1.1,0)
			if isLineOfSightClear(x-2,y,z,offx,offy,offz,false,true,false,false,false) then
				--exports["es-komunikaty"]:komunikat("Błąd 'swwc84'. Zgłoś się do Kamsu")
				return
			end
			local hit,_,_,_,veh,_,_,_,_,_,piece=processLineOfSight(x,y,z,offx,offy,offz,false,true,false,false,false)
			if not hit then
				return
			end
			if (getElementType(veh)~="vehicle") then
				return
			end
			if veh and isElement(veh) then
				if (getElementModel(veh)==407) or (getElementModel(veh)==433) or (getElementModel(veh)==544) then
					if not piece then
						return
					end
					if (piece==5) then
						piece=4
					elseif (piece==6) then
						piece=5
					else
	    					outputChatBox("Musisz stac przodem do wybranych tylnych drzwi", source, 255, 255, 255, true)

						return
					end
					triggerServerEvent("ev",resourceRoot,"wsiadz",veh,piece)
				end
			end
		end
	end
)

isInWoz=(
	function(plr)
		local block,_=getPedAnimation(plr)
		local siedzi=nil
		if (block=="truck") then
			siedzi=true
		end
		return siedzi
	end
)