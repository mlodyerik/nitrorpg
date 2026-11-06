-- Pierwotny właściciel i twórca kodu: ReftiXD; reftixd@wp.pl
-- Całkowity zakaz usuwania autora skryptu!
-- Zakaz używania / edycji skrytpu bez wcześniejszej zgody ze strony właściciela.
-- Całkowity zakaz wykorzystywania całego lub fragmentów skryptu.
-- W przypadku złamania powyzszych zasad sprawa zostanie skierowana do sądu pod zażutem: Naruszenia majątkowych praw autorskich.
-- Pierwotnie pełne prawo do używania tego skrytpu posiada tylko ReftiXD.



------------------------------]]PRZEBIERALNIA[[------------------------------

marker1 = createMarker( 1002.18, -1555.45, 29.90, 'cylinder', 1.2, 0, 0, 255, 0)
door1 = createObject ( 3089, 1003.3298950195, -1555.4228515625, 30.228399276733, 0, 0, 180 )
setElementDimension( door1, 2137)

function onMarkerHit1 (hitPlayer, matchingDimension)
moveObject ( door1, 1000, 1004.8497924805, -1555.4228515625, 30.228399276733)
end

function onMarkerLeave1 (thePlayer)
moveObject ( door1, 1000, 1003.3298950195, -1555.4228515625, 30.228399276733)
end

addEventHandler ( "onMarkerLeave", marker1, onMarkerLeave1 )
addEventHandler ( "onMarkerHit", marker1, onMarkerHit1 )

-----------------------------------------------------------------------------

marker2 = createMarker( 996.81, -1557.77, 29.90, 'cylinder', 1.2, 0, 0, 255, 0)
door2 = createObject ( 3089, 997.70001220703, -1557.7758789062, 30.228399276733, 0, 0, 180 )
setElementDimension( door2, 2137)

function onMarkerHit2 (hitPlayer, matchingDimension)
moveObject ( door2, 1000, 999.25469970703, -1557.7758789062, 30.228399276733)
end

function onMarkerLeave2 (thePlayer)
moveObject ( door2, 1000, 997.70001220703, -1557.7758789062, 30.228399276733)
end

addEventHandler ( "onMarkerLeave", marker2, onMarkerLeave2 )
addEventHandler ( "onMarkerHit", marker2, onMarkerHit2 )