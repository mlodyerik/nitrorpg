local torby = {}

addCommandHandler("torbar1",function(plr,cmd)
if torby[plr] then return end
if not getElementData(plr,"player:faction") then return end
local x,y,z = getElementPosition(plr)
local torba = createObject(1550,x,y,z)
exports.nrpg_interface:showPlayerNotification(plr, 'Wyciągnąłeś/aś torbę R1', 'info')
setElementCollisionsEnabled(torba, false)
exports["bone_attach"]:attachElementToBone(torba, plr, 12,-0.05,-0.05,0.20,0,170,90)
setObjectScale(torba, 0.75)
torby[plr] = torba
end)

function usuntorbe(plr)
if not plr then return end
local torba = torby[plr]
if torba then
if isElement(torba) then
if exports["bone_attach"]:isElementAttachedToBone(torba) then exports["bone_attach"]:detachElementFromBone(torba) end
destroyElement(torba)
end
torby[plr] = nil
end
end


addEventHandler("onPlayerQuit", root, function()
local torba = torby[source]
if torba then
if isElement(torba) then
if exports["bone_attach"]:isElementAttachedToBone(torba) then exports["bone_attach"]:detachElementFromBone(torba) end
destroyElement(torba)
end
torby[source] = nil
end
end)


addCommandHandler("r1.odstaw",function(plr,cmd)
if not getElementData(plr,"player:faction") then return end
if torby[plr] then
usuntorbe(plr)
exports.nrpg_interface:showPlayerNotification(plr, 'Oddajesz torbę', 'info')
return end
end)


addCommandHandler("r1.postaw",function(plr,cmd)
if not getElementData(plr,"player:faction") then return end
local veh = getPedOccupiedVehicle(plr)
if veh then return end
local torba = torby[plr]
if not torba then exports.nrpg_interface:showPlayerNotification(plr, 'Nie posiadasz torby R1', 'error') return end
if not isElement(torba) then exports.nrpg_interface:showPlayerNotification(plr, 'Nie posiadasz torby R1', 'error') return end
if exports["bone_attach"]:isElementAttachedToBone(torba) then 
exports["bone_attach"]:detachElementFromBone(torba) 
setElementCollisionsEnabled(torba, false)
local x,y,z = getElementPosition(plr)
setElementPosition(torba, x, y, z-0.82)
local rz = getElementRotation(torba)
setElementRotation(torba, 0, 0, rz)
else
local x, y, z = getElementPosition(plr)
local x2, y2, z2 = getElementPosition(torba)
local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
if distance > 5 then exports.nrpg_interface:showPlayerNotification(plr, 'Podejdź do torby', 'error') return end
exports["bone_attach"]:attachElementToBone(torba, plr, 12, -0.05, -0.05, 0.20, 0, 170, 90)
end
end)