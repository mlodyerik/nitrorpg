typy={
[837]=-.5,
[835]=1,
[847]=1,
[684]=-.6,
}

typy2={837,835,847,684}

local drzewa = {
	--{-2389.83, -56.22, 35.32, 3},
	--{-2409.40, 24.48, 35.20, 5},
	--{-2328.93, 26.65, 35.32, 4},
	--{-2077.65, 46.14, 34.39, 5},
	--{-1993.86, 73.87, 27.88, 5},
	--{-1813.76, -287.14, 24.30, 4},
	--{-1598.20, -460.59, 6.15, 2},
	--{-1938.79, -605.55, 24.59, 3},
	--{-1938.83, -739.90, 32.23, 3},
	--{-2007.65, -993.79, 32.17, 3},
        --{-2026.33, 485.02, 35.17},
        --{-2026.33, 485.02, 35.17},
        --{-2024.96, 405.02, 35.17},
        --{-2024.96, 405.02, 35.17},
        --{-2024.96, 405.02, 35.17},
        --{-2024.96, 405.02, 35.17},
        --{-1991.27, -37.77, 35.30},
        --{-1991.27, -37.77, 35.30},
        --{-1991.27, -37.77, 35.30},
        --{-1991.27, -37.77, 35.30},
        --{-2226.67, -203.06, 35.37},
        --{-2226.67, -203.06, 35.37},
        --{-2226.67, -203.06, 35.37},
        --{-2381.85, -184.18, 35.32},
        --{-2381.85, -184.18, 35.32},
        --{-2381.85, -184.18, 35.32},
        --{-2381.85, -184.18, 35.32},
        --{-2388.96, -52.89, 35.32},
        --{-2348.20, -7.58, 35.31},
        --{-2388.96, -52.89, 35.32},
        --{-2348.20, -7.58, 35.31},
        --{-2388.96, -52.89, 35.32},
        --{-2348.20, -7.58, 35.31},
        --{-2388.96, -52.89, 35.32},
        --{-2348.20, -7.58, 35.31},
        --{-2388.96, -52.89, 35.32},



}

function zniszczDrzewo(drzewo)
	if isElement(drzewo) then
		destroyElement(drzewo)
		if getElementData(client,"player:faction") == "SAFD" then
			givePlayerMoney(client,35000000)
			exports.nrpg_interface:showPlayerNotification(client, "Drzewo ścięte! Otrzymujesz 3,500,000 PLN", "success")
		end
	end
end
addEvent("SAFD:Zniszczdrzewo",true)
addEventHandler("SAFD:Zniszczdrzewo",resourceRoot,zniszczDrzewo)

function stworzDrzewo(id,x,y,z,rx,ry,rz)
	obj=createObject(id,x,y,z+0.20,rx,ry,rz)
	setElementData(resourceRoot,"objj",obj)
	setElementData(obj,"health",math.random(2500,3000))
	return obj
end

function ilePracownikow()
	ile=1
		for i,v in ipairs(getElementsByType("player")) do 
			if getElementData(v,"player:faction") == "SAFD" then
			ile=ile+1
			end
		end
	return ile
end

function spawnDrzewo(x,y,z,ilosc)
	if ilosc>2 then
		odl=ilosc/6
	else
		odl=ilosc/4
	end
	for i=1,ilosc do
		plusx,plusy=math.random(-odl,odl),math.random(	-odl,odl)
		drzewotyp=typy2[math.random(#typy2)]
		drzewoupdown=typy[drzewotyp]
		stworzDrzewo(drzewotyp,x+plusx,y+plusy,z+drzewoupdown,0,0,math.random(1,360))
	end
end
spawnDrzewo(0,0,5,8)

function autospawn()
if ilePracownikow() < 1 then return end
	for i,v in pairs(drzewa) do
		spawnDrzewo(v[1],v[2],v[3],v[4])
	end
end
autospawn()
setTimer(autospawn, 60000*60*24, 0) --co 24 h