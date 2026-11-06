-- Pierwotny właściciel i twórca kodu: ReftiXD; reftixd@wp.pl
-- Całkowity zakaz usuwania autora skryptu!
-- Zakaz używania / edycji skrytpu bez wcześniejszej zgody ze strony właściciela.
-- Całkowity zakaz wykorzystywania całego lub fragmentów skryptu.
-- W przypadku złamania powyzszych zasad sprawa zostanie skierowana do sądu pod zażutem: Naruszenia majątkowych praw autorskich.
-- Pierwotnie pełne prawo do używania tego skrytpu posiada tylko ReftiXD.



------------------------------]]SAFD[[------------------------------

function isPlayerInSAFDFaction(plr)
    local sid=getElementData(plr, 'player:sid')
    if not sid then return end

    local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SAFD", sid)
    if result [1] then
        return true
    else
        return false
    end
end

--]
--GŁÓWNE DRZWI
--]

marker1 = createMarker( 1706.17725, -1784.82739, 12.0, 'cylinder', 3.0, 0, 0, 255, 0)
door1 = createObject ( 3089, 1707.8199462891, -1785.3000488281, 13.89999961853, 0, 0, 180 )
door2 = createObject ( 3089, 1704.7430419922, -1785.3000488281, 13.89999961853, 0, 0, 0 )
setObjectScale (door1, 1.05)
setObjectScale (door2, 1.05)

function onMarkerHit1  (hitPlayer, matchingDimension)
if isPlayerInSAFDFaction(hitPlayer) then
moveObject ( door1, 1000, 1708.9000244141, -1785.3000488281, 13.89999961853)
moveObject ( door2, 1000, 1703.6999511719, -1785.3000488281, 13.89999961853)
end
end

function onMarkerLeave1 (thePlayer)
moveObject ( door1, 1000, 1707.8199462891, -1785.3000488281, 13.89999961853)
moveObject ( door2, 1000, 1704.7430419922, -1785.3000488281, 13.89999961853)
end

addEventHandler ( "onMarkerLeave", marker1, onMarkerLeave1 )
addEventHandler ( "onMarkerHit", marker1, onMarkerHit1 )



--]
--DRZWI NA GARAŻE
--]

marker2 = createMarker( 1735.27222, -1785.45190, 13.58907, 'cylinder', 3.0, 0, 0, 255, 0)
door3 = createObject ( 3089, 1736.9139404297, -1785.2800292969, 13.89999961853, 0, 0, 180 )
door4 = createObject ( 3089, 1733.9000244141, -1785.2800292969, 13.89999961853, 0, 0, 0 )
setObjectScale (door3, 1.009)
setObjectScale (door4, 1.009)

function onMarkerHit2  (hitPlayer, matchingDimension)
if isPlayerInSAFDFaction(hitPlayer) then
moveObject ( door3, 1000, 1738.45, -1785.2800292969, 13.89999961853)
moveObject ( door4, 1000, 1732.37, -1785.2800292969, 13.89999961853)
end
end

function onMarkerLeave2 (thePlayer)
moveObject ( door3, 1000, 1736.9139404297, -1785.2800292969, 13.89999961853)
moveObject ( door4, 1000, 1733.9000488281, -1785.2800292969, 13.89999961853)
end

addEventHandler ( "onMarkerLeave", marker2, onMarkerLeave2 )
addEventHandler ( "onMarkerHit", marker2, onMarkerHit2 )

--]
--DRZWI DO POKOJU ZARZĄDU
--]

marker3 = createMarker( 1724.09973, -1793.06726, 12.58907, 'cylinder', 2.0, 0, 0, 255, 0)
door5 = createObject ( 3089, 1724.1999511719, -1792.3020019531, 13.89999961853, 0, 0, -90 )
setObjectScale (door5, 1.03)

function onMarkerHit3  (hitPlayer, matchingDimension)
if isPlayerInSAFDFaction(hitPlayer) then
moveObject ( door5, 1000, 1724.1999511719, -1790.8000488281, 13.89999961853)
end
end

function onMarkerLeave3 (thePlayer)
moveObject ( door5, 1000, 1724.1999511719, -1792.3020019531, 13.89999961853)
end

addEventHandler ( "onMarkerLeave", marker3, onMarkerLeave3 )
addEventHandler ( "onMarkerHit", marker3, onMarkerHit3 )


--]
--DRZWI DO ROZPOCZĘCIA SŁUŻBY
--]

marker4 = createMarker( 1712.55237, -1793.57251, 12.58907, 'cylinder', 2.0, 0, 0, 255, 0 )
door6 = createObject ( 3089, 1713.3000488281, -1793.5600585938, 13.89999961853, 0, 0, 180 )
setObjectScale (door6, 1.01)

function onMarkerHit4  (hitPlayer, matchingDimension)
if isPlayerInSAFDFaction(hitPlayer) then
moveObject ( door6, 1000, 1714.83, -1793.5600585938, 13.89999961853 )
end
end

function onMarkerLeave4 (thePlayer)
moveObject ( door6, 1000, 1713.3000488281, -1793.5600585938, 13.89999961853 )
end

addEventHandler ( "onMarkerLeave", marker4, onMarkerLeave4 )
addEventHandler ( "onMarkerHit", marker4, onMarkerHit4 )

------------------------------]]SAPD[[------------------------------

function isPlayerInSAPDFaction(plr)
    local sid=getElementData(plr, 'player:sid')
    if not sid then return end

    local result=exports['nrpg_db']:dbGet('SELECT 1 FROM pystories_factions WHERE faction=? AND uid=? LIMIT 1;', "SAPD", sid)
    if result [1] then
        return true
    else
        return false
    end
end

--]
--DRZWI DO ROZPOCZĘCIA SŁUŻBY
--]

marker5 = createMarker( 4614.48145, 370.51291, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door7 = createObject ( 3089, 4613.7255859375, 370.60870361328, 5392.3701171875, 0, 0, 0 )

function onMarkerHit5  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door7, 1000, 4612.2758789062, 370.60870361328, 5392.3701171875 )
end
end


function onMarkerLeave5 (thePlayer)
moveObject ( door7, 1000, 4613.7255859375, 370.60870361328, 5392.3701171875 )
end

addEventHandler ( "onMarkerLeave", marker5, onMarkerLeave5 )
addEventHandler ( "onMarkerHit", marker5, onMarkerHit5 )

--]
--DRZWI DO PRZEBIERLANI
--]

marker6 = createMarker( 4607.08984, 368.26492, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door8 = createObject ( 3089, 4608.5859375, 368.41409301758, 5392.3994140625, 0, 0, 180 )
door9 = createObject ( 3089, 4605.6005859375, 368.4137878418, 5392.3994140625, 0, 0, 0 )

function onMarkerHit6  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door8, 1000, 4610.0473632812, 368.41409301758, 5392.3994140625 )
moveObject ( door9, 1000, 4604.0991210938, 368.4137878418, 5392.3994140625 )
end
end


function onMarkerLeave6 (thePlayer)
moveObject ( door8, 1000, 4608.5859375, 368.41409301758, 5392.3994140625 )
moveObject ( door9, 1000, 4605.6005859375, 368.4137878418, 5392.3994140625 )
end

addEventHandler ( "onMarkerLeave", marker6, onMarkerLeave6 )
addEventHandler ( "onMarkerHit", marker6, onMarkerHit6 )

--]
--DRZWI DO SALI SPOTKAN
--]

marker7 = createMarker( 4592.96631, 368.13544, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door10 = createObject ( 3089, 4594.4755859375, 368.10391235352, 5392.369140625, 0, 0, 180 )
door11 = createObject ( 3089, 4591.4926757812, 368.10348510742, 5392.369140625, 0, 0, 0 )

function onMarkerHit7  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door10, 1000, 4595.9790039062, 368.10391235352, 5392.369140625 )
moveObject ( door11, 1000, 4590.0771484375, 368.10348510742, 5392.369140625 )
end
end


function onMarkerLeave7 (thePlayer)
moveObject ( door10, 1000, 4594.4755859375, 368.10391235352, 5392.369140625 )
moveObject ( door11, 1000, 4591.4926757812, 368.10348510742, 5392.369140625 )
end

addEventHandler ( "onMarkerLeave", marker7, onMarkerLeave7 )
addEventHandler ( "onMarkerHit", marker7, onMarkerHit7 )

--]
--DRZWI DO SALI PRZESŁUCHAŃ
--]

marker8 = createMarker( 4593.59277, 378.33359, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door12 = createObject ( 3089, 4592.8095703125, 378.3883972168, 5392.3774414062, 0, 0, 0 )

function onMarkerHit8  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door12, 1000, 4591.3041992188, 378.3883972168, 5392.3774414062 )
end
end


function onMarkerLeave8 (thePlayer)
moveObject ( door12, 1000, 4592.8095703125, 378.3883972168, 5392.3774414062 )
end

addEventHandler ( "onMarkerLeave", marker8, onMarkerLeave8 )
addEventHandler ( "onMarkerHit", marker8, onMarkerHit8 )

--]
--DRZWI DO SALI PRZESŁUCHAŃ V2
--]

marker9 = createMarker( 4596.81787, 380.44843, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door13 = createObject ( 3089, 4596.8891601562, 379.71090698242, 5392.3901367188, 0, 0, 90 )

function onMarkerHit9  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door13, 1000, 4596.8891601562, 378.25729370117, 5392.3901367188 )
end
end


function onMarkerLeave9 (thePlayer)
moveObject ( door13, 1000, 4596.8891601562, 379.71090698242, 5392.3901367188 )
end

addEventHandler ( "onMarkerLeave", marker9, onMarkerLeave9 )
addEventHandler ( "onMarkerHit", marker9, onMarkerHit9 )

--]
--DRZWI DO POKOJU LIDERA
--]

marker10 = createMarker( 4605.79443, 378.28766, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door14 = createObject ( 3089, 4604.3037109375, 378.41360473633, 5392.3813476562, 0, 0, 0 )
door15 = createObject ( 3089, 4607.2885742188, 378.41360473633, 5392.3813476562, 0, 0, 180 )

function onMarkerHit10  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door14, 1000, 4602.8061523438, 378.41360473633, 5392.3813476562 )
moveObject ( door15, 1000, 4608.7900390625, 378.41360473633, 5392.3813476562 )
end
end


function onMarkerLeave10 (thePlayer)
moveObject ( door14, 1000, 4604.3037109375, 378.41360473633, 5392.3813476562 )
moveObject ( door15, 1000, 4607.2885742188, 378.41360473633, 5392.3813476562 )
end

addEventHandler ( "onMarkerLeave", marker10, onMarkerLeave10 )
addEventHandler ( "onMarkerHit", marker10, onMarkerHit10 )

--]
--DRZWI GŁÓWNE
--]

marker11 = createMarker( 4611.42285, 373.40332, 5392.19678, 'cylinder', 1, 0, 0, 255, 0)
door16 = createObject ( 3089, 4611.4150390625, 372.68798828125, 5392.345703125, 0, 0, 90 )

function onMarkerHit11  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door16, 1000, 4611.4150390625, 371.25650024414, 5392.345703125 )
end
end


function onMarkerLeave11 (thePlayer)
moveObject ( door16, 1000, 4611.4150390625, 372.68798828125, 5392.345703125 )
end

addEventHandler ( "onMarkerLeave", marker11, onMarkerLeave11 )
addEventHandler ( "onMarkerHit", marker11, onMarkerHit11 )

--]
--DRZWI WIEZIENIE PRZESŁUCHANIE
--]

marker12 = createMarker( 4580.15674, 357.95337, 5385.89697, 'cylinder', 1, 0, 0, 255, 0)
door17 = createObject ( 3089, 4579.462890625, 357.90289306641, 5386.158203125, 0, 0, 0 )

function onMarkerHit12  (hitPlayer, matchingDimension)
if isPlayerInSAPDFaction(hitPlayer) then
moveObject ( door17, 1000, 4577.9614257812, 357.90289306641, 5386.158203125 )
end
end


function onMarkerLeave12 (thePlayer)
moveObject ( door17, 1000, 4579.462890625, 357.90289306641, 5386.158203125 )
end

addEventHandler ( "onMarkerLeave", marker12, onMarkerLeave12 )
addEventHandler ( "onMarkerHit", marker12, onMarkerHit12 )