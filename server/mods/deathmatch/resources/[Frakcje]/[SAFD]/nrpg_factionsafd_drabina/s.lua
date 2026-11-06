

local drabina = {} 
local polozyl = {} 


local isPSP=(
function(plr)
    if getElementData(plr,"player:faction")=="SAPD" or getElementData(plr,"player:faction")=="SAFD" then
        return true
    end
        return false
    end
)
--[[
local isOSP=(
	function(plr)
		if getElementData(plr,"SAPD:ranga") and getElementData(plr,"SAPD:sluzba") then
			return true
		end
		return false
	end
)]]

--komendy;drabina,polozdrabine,usundrabine,zlozdrabine
---- drabina duza (id: 1437)
---- drabina mala (id: 1428)


function funkcje(plr,cmd) 
    local x,y,z = getElementPosition(plr) 
    local rx, ry, rz = getElementRotation(plr)

    if isPSP(plr) or isOSP(plr) then 

    if (cmd=="znak.stop") then 

        if drabina[plr] then 
        outputChatBox("✘ #FFFFFFMasz już drabinę.", plr, 255, 0, 0, true)
            return false
        end
        drabina[plr]=createObject(3380,x,y,z+30) 
        exports['bone_attach']:attachElementToBone(drabina[plr],plr,7,0,0,0.15,180,95,70)
        outputChatBox ("✔ #FFFFFFBierzesz drabinę.",plr, 0, 255, 0, true)
        toggleControl(plr,"sprint", false)
        toggleControl(plr, "jump", false)

    elseif (cmd=="poloz.znak") then 

        if drabina[plr] then 
            exports['bone_attach']:detachElementFromBone(drabina[plr]) 
            destroyElement(drabina[plr])
            drabina[plr]=createObject(3380, x, y, z, rx30, ry, rz)
            outputChatBox("Ⓘ #FFFFFFStawiasz drabinę.", plr, 255,255,0, true)
            polozyl[plr]=true
            toggleControl(plr,"sprint", true)
            toggleControl(plr, "jump", true)
        end 

    elseif (cmd=="usundrabine") then 

        if drabina[plr] then 
            destroyElement(drabina[plr])
            outputChatBox("Ⓘ #FFFFFFUsuwasz drabinę.", plr, 255,255,0, true)
            drabina[plr]=false
            toggleControl(plr,"sprint", true)
            toggleControl(plr, "jump", true)
        end 
    
    elseif (cmd=="zlozdrabine") then 

        if drabina[plr] and polozyl[plr] then 
            local x1, y1, z1 = getElementPosition(drabina[plr])
            if getDistanceBetweenPoints3D (x,y,z,x1,y1,z1) < 2 then 
                destroyElement(drabina[plr]) 
                drabina[plr]=createObject(3380, x,y,z)
                exports['bone_attach']:attachElementToBone(drabina[plr],plr,11,0,0,0.35,0,0,0)
                outputChatBox ("✔ #FFFFFFBierzesz drabinę.",plr, 0, 255, 0, true)
                polozyl[plr]=false
                toggleControl(plr,"sprint", true)
                toggleControl(plr, "jump", true)
            else 
            outputChatBox("Ⓘ #FFFFFFStań bliżej drabiny.", plr, 255,255,0, true)
            end
        end 

    end
end
end

addCommandHandler("znak.stop", funkcje)
addCommandHandler("poloz.znak", funkcje)
addCommandHandler("usun.znak", funkcje)

        