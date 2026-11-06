addEvent( "utworzKolczatke", true )
addEventHandler( "utworzKolczatke", resourceRoot,
function(x, y, z, rx, ry, rz)
local veh = getPedOccupiedVehicle(client)
	if not veh then
		if getElementData(client,'player:faction') and getElementData(client,'player:faction')=='SAPD' then
				if getElementData(client, "kolczatka") == false or getElementData(client, "kolczatka") == nil then
					local dim = getElementDimension(client)
					local int = getElementInterior(client)
					local kolczatka = createObject(2899, x, y, z+0.1, rx, ry, rz)
					setElementInterior(kolczatka, int)
					setElementDimension(kolczatka, dim)
					setPedAnimation(client, "BOMBER", "BOM_plant", 3000, false, false, false)
					setTimer(setPedAnimation, 2000, 1, client)
					outputChatBox("#ffff00Ⓘ #FFFFFFKolczatka ustawiona.", client, 255, 255, 0, true)
					setElementData(kolczatka, "kolczatka:Policja", true)
					setElementData(kolczatka,"kolczatka:czyja", getPlayerName(client))
					setElementData(client, "kolczatka", true)
				else
					outputChatBox("✘ #FFFFFFMożesz postawić tylko jedną kolczatke.", client, 255, 0, 0, true)
				end
		end
	else
		outputChatBox("✘ #FFFFFFMusisz znajdować się poza pojazdem.", client, 255, 0, 0, true)
	end
end)

function usunkolczatki(plr)
	if getElementData(plr,'player:faction') and getElementData(plr,'player:faction')=='SAPD' then
		for i,v in ipairs(getElementsByType( "object" ), getResourceRootElement(getThisResource())) do
			if getElementModel(v) == 2899 then
				if getElementData(v,"kolczatka:czyja") == getPlayerName(plr) then
					destroyElement(v)
				end
			end
		end
		setElementData(plr, "kolczatka", false)
		outputChatBox("#ffff00Ⓘ #FFFFFFUsunąleś kolczatke.", plr, 255, 255, 0, true)
	end
end
addCommandHandler("usun.kolczatke", usunkolczatki)

addEventHandler("onPlayerQuit", root,
function()
	usunkolczatki(source)
end)

addEvent( "przebijOpone", true )
addEventHandler( "przebijOpone", root,
function(veh, o1, o2, o3, o4)
setVehicleWheelStates(veh, o1, o2, o3, o4)
end)


