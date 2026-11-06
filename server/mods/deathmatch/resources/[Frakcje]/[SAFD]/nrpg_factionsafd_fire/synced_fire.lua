local fireModel = 2023
local fires = {}
addEvent("onFireExtinguished",true)
addEvent("onFireCreate",true)


local function isFireNearby(x,y,z)	-- todo d,i
  local cs=createColSphere(x,y,z,3)
  local obiekty=getElementsWithinColShape(cs, "object")
  destroyElement(cs)
  for i,v in ipairs(obiekty) do
	  if (getElementModel(v)==fireModel) then return true end
  end
  return false
end

function createFire(x,y,z,d,i)
	if (isFireNearby(x,y,z,d,i)) then return nil end
	local fireElem = createObject(fireModel,x,y,z-1)
	setElementCollisionsEnabled(fireElem,false)
	local col = createColSphere(x,y,z,2)
	setElementParent(col, fireElem)
	setElementData(fireElem, "ts", getTickCount(), false)
	setElementData(fireElem,"fire:Endvalue",math.random(40,80)) 
	--local blip = createBlipAttachedTo ( fireElem, 0, 2, 0, 0, 0, 255, 0, 275.0, root )
	fires[fireElem] = {fireElem,col,blip}
	addEventHandler("onColShapeHit",col,setFire)
	if (d) then
	  setElementDimension(fireElem, d)
	  setElementDimension(col, d)
	end
	if (i) then
	  setElementInterior(fireElem, i)
	  setElementInterior(col, i)
	end
	return fireElem
end

function setFire(elem,dim)
	if not dim then return end
	if not elem or not isElement(elem) then return end
	if getElementType(elem) == "player" then
		setPedOnFire(elem,true)
	end
end

function setFire(elem,dim)
	if not dim then return end
	if not elem or not isElement(elem) then return end
	if getElementType(elem) == "vehicle" then
		setElementHealth(elem,299)
	end
end

function fireExtinguished(fireElem) 
    if (not fires[fireElem]) then return end
    local firedValue = getElementData(fireElem,"fire:Endvalue")
    setElementData(fireElem,"fire:Endvalue",firedValue-math.random(3,30))  
    if firedValue <= 0 then
    destroyElement(fires[fireElem][1])
	if isElement(fires[fireElem][3]) then
		destroyElement(fires[fireElem][3])
	end
	money = math.random(1500000,3000000)
	givePlayerMoney(client, money)
	exports.nrpg_interface:showPlayerNotification(client,'Pomyślnie ugaszono ogień, otrzymujesz '..money..' PLN', 'success')
    fires[fireElem] = nil
	triggerEvent("onFireExtinguished",client,client)
    end
end
addEvent("fireExtinguished",true)
addEventHandler("fireExtinguished",root,fireExtinguished)



addEventHandler("onDebugMessage", getRootElement(), 
function(message, level, file, line)
if file == "synced_fire" then
cancelEvent()
end
end)

local fireLocations =
{
	-- san fierro
{-1993.0974121094, -189.85552978516, 35.593448638916},
{-1991.9359130859, -132.30461120605, 35.368717193604},
{-1990.1938476563, -20.103487014771, 35.119827270508},
{-1989.9926757813, 38.475124359131, 31.6647605896},
{-1964.7806396484, 74.851554870605, 27.6875},
{-1971.5363769531, -80.755157470703, 35.27702331543},
{-2086.7180175781, 43.447074890137, 35.310306549072},
{-2134.4641113281, 157.31080627441, 35.315235137939},
{-2130.1052246094, 164.27424621582, 35.332504272461},
{-2277.2084960938, 227.07641601563, 35.313316345215},
{-2276.228515625, 252.65008544922, 35.3203125},
{-2362.7534179688, 127.28999328613, 35.3125},
{-2393.9919433594, 51.831665039063, 35.189086914063},
{-2436.1884765625, 168.14538574219, 35.1328125},
{-2037.5251464844, 581.41851806641, 35.644416809082},
{-2025.4533691406, 613.24682617188, 38.449089050293},
{-1872.8386230469, 578.03698730469, 35.635070800781},
{-2265.58, -419.17, 59.48},
{-2265.43, -417.08, 58.62},
{-2263.62, -418.82, 58.03},
{-2264.55, -416.23, 57.73},
{-2265.94, -417.79, 59.21},
{-2261.11, -418.56, 56.61},
{-2070.85, 310.09, 42.26},
{-2071.40, 309.44, 41.99},
{-2073.75, 309.99, 42.26},
{-2069.89, 309.38, 40.90},
--SanFiero KINGS
{-2071.81, 308.97, 41.99},
{-2072.82, 309.09, 41.99},
{-2073.75, 309.20, 41.99},
{-2074.92, 309.33, 41.99},
{-2076.19, 309.40, 41.99},
{-2077.97, 309.33, 41.99},
{-2068.71, 310.83, 41.99},
{-2071.73, 310.66, 41.99},
{-2073.71, 310.70, 41.99},
{-2075.40, 310.63, 41.99},
{-2076.98, 310.52, 41.99},
-- Pożar mały Esolande North
{-1820.52, 1400.61, 7.19},
{-1818.79, 1404.35, 7.19},
{-1815.69, 1403.63, 7.19},
{-1813.01, 1400.73, 7.19},
{-1816.15, 1399.76, 7.19},
{-1817.78, 1398.11, 7.19},
-- Pożar Duży Colton Heights
 {-2077.73, 1294.89, 11.14},
 {-2079.53, 1293.79, 11.72},
 {-2082.43, 1291.32, 12.63},
 {-2084.61, 1293.10, 12.77},
 {-2084.36, 1296.39, 12.25},
 {-2081.97, 1299.63, 11.13},
 {-2078.19, 1301.05, 10.17},
 {-2086.85, 1303.01, 11.48},
 {-2090.48, 1299.09, 12.93},
 {-2093.08, 1293.59, 14.20},
        
       --San Fierro
{-1722.78, 366.44, 9.01},
{-1726.62, 369.79, 9.29},
{-1734.82, 370.13, 9.76},
{-1738.48, 370.50, 9.66},
{-1746.81, 362.45, 9.86},
{-1748.23, 352.69, 9.20},
{-1630.20, 1268.23, 7.05},
{-1621.46, 1275.07, 7.05},
{-1615.18, 1274.99, 7.05},
{-1607.56, 1267.41, 7.05},
{-1603.85, 1255.16, 7.04},
{-1603.59, 1243.87, 7.05},
{-1578.15, 640.01, 7.50},
{-1578.91, 631.67, 7.54},
{-1582.71, 621.58, 7.94},
{-1593.91, 629.97, 9.88},
{-1609.23, 637.14, 9.33},
{-1590.59, 642.60, 8.48},
{-1601.42, 642.95, 9.16},
{-1587.94, 627.53, 8.80},
{-1720.39, 358.68, 8.33},
{-2403.06, -103.57, 35.32},
{-2392.95, -92.30, 35.32},
{-1728.56, 1373.08, 7.05},
{-1729.27, 1385.52, 7.05},
{-1717.17, 1385.23, 7.05},
{-1726.66, 1366.56, 7.05},
{-1620.97, 1266.96, 7.05},
{-2389.44, -121.45, 35.32},
{-2400.83, -126.37, 35.32},
{-1939.48, -685.09, 24.59},
{-1939.25, -679.97, 24.59},
{-1939.47, -672.96, 24.59},
{-1939.64, -667.57, 24.59},
{-1939.62, -663.75, 24.59},
{-1939.76, -658.66, 24.59},
{-1939.90, -654.27, 24.60},
{-1939.81, -650.46, 24.60},
{-1940.15, -645.21, 24.60},
{-1940.30, -640.49, 24.60},
{-1940.43, -637.31, 24.60},
{-1940.56, -632.03, 24.60},
{-1940.61, -626.41, 24.60},
{-1940.66, -622.14, 24.60},
{-1940.90, -617.08, 24.60},
{-1941.17, -611.30, 24.60},
{-1941.46, -605.32, 24.59},
{-1916.03, -262.60, 27.40},
{-1911.32, -262.83, 27.42},
{-1905.08, -262.54, 27.36},
{-1899.11, -262.70, 27.38},
{-1893.43, -262.64, 27.37},
{-1891.51, -257.91, 26.67},
{-1895.97, -257.37, 26.59},
{-1900.55, -257.23, 26.57},
{-1905.44, -256.82, 26.58},
{-1910.53, -256.75, 26.64},
{-1913.81, -256.72, 26.66},
{-1994.66, -55.04, 35.31},
{-1985.64, -53.51, 35.32},
{-1979.12, -51.86, 35.32},
{-1972.62, -51.88, 35.32},
{-1971.97, -42.44, 35.32},
{-1972.66, -37.19, 35.32},
{-1973.33, -32.26, 35.32},
{-1973.06, -24.33, 35.32},
{-1972.54, -17.07, 35.32},
{-1971.95, -12.76, 35.32},
{-1971.41, -7.85, 35.30},
{-1971.61, -2.86, 35.06},
{-1971.60, 4.07, 34.57},
{-1970.24, 12.13, 33.82},
{-1987.50, 329.36, 35.15},
{-1978.28, 328.02, 35.08},
{-1970.89, 327.68, 34.99},
{-1961.96, 327.28, 34.32},
{-1955.64, 327.06, 33.87},
{-1956.08, 319.84, 34.43},
{-1961.42, 315.46, 34.77},
{-1966.61, 314.83, 35.00},
{-1974.55, 314.33, 35.14},  

        -- SannFierro
{-2770.22, 444.87, 4.42},
{-2763.10, 442.98, 4.38},
{-2753.79, 444.05, 4.33},
{-2751.20, 437.68, 4.33},
{-2753.99, 428.30, 4.34},
{-2757.50, 425.95, 4.37},
{-2762.37, 425.74, 4.43},
{-2765.87, 428.36, 4.46},
{-2769.72, 431.02, 4.49},
{-2777.61, 434.35, 4.50},
{-2787.74, 434.64, 4.49},
{-2796.38, 435.82, 4.48},
{-2800.09, 435.34, 4.48},
{-2811.23, 431.77, 4.50},
{-2812.50, 428.07, 4.50},
{-2813.64, 419.94, 4.51},

	-- bluberry
{66.94401550293, -191.13243103027, 1.5274934768677},
{-70.177963256836, -177.96604919434, 2.1849503517151},
{-73.686622619629, -127.36696624756, 3.1171875},
{-62.28014755249, -63.131038665771, 3.1171875},
{-32.243049621582, 20.386737823486, 3.1171875},
{-68.422584533691, 172.3709564209, 2.8732318878174},
{-216.40924072266, 255.70947265625, 11.929285049438},
{-165.95629882813, -22.711132049561, 3.1171875},
{-190.5514831543, -30.266206741333, 3.1171875},
}
 
function unpackFires ()
    return unpack ( fireLocations [ math.random ( #fireLocations ) ] )
end
 
function scriptCreateFire()
      local x, y, z = unpackFires() 
      fire = createFire( x, y, z)
end
setTimer(scriptCreateFire, 10000 * 5, 0)


local function extinguishExpiredFires()
  for i,v in ipairs(getElementsByType("object", resourceRoot)) do
    local ts=getElementData(v,"ts")
    if (ts and getTickCount()-ts<1000*3600*6) then
    destroyElement(fires[fireElem][1])
	destroyElement(fires[fireElem][3])
    fires[fireElem] = nil
    end
  end
end
setTimer(extinguishExpiredFires, 1000*3600, 0)


function isFireFighter()
local result = false
	for i,element in ipairs(getElementsByType("player")) do
		if (getElementData(element,"player:faction") == "SAFD")then
			result = true
		end
   end
return result
end