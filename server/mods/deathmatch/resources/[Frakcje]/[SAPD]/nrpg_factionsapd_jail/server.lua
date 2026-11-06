local cub = createColCuboid(4572.47, 369.31, 5384.90, 4.80, 19.07, 1.90)
local strefa = createColCuboid(4572.47, 369.31, 5384.90, 4.80, 19.07, 1.90)

	function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function u(e)
getElementData(e, "player:sid")
end


local x,y,z = 4617.77, 373.44, 5392.20
local function wypusc(plr)
setElementDimension(plr,0)
setElementInterior(plr,0)
setElementPosition(plr,x,y,z)
exports.nrpg_interface:showPlayerNotification(plr, "Twój czas upłynął. Zostajesz wypuszczony z więzienia.", "success")
setElementData(plr, "player:jail", false)
end

function getPlayerName2(plr)
if not plr then return end
return getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
end

local function sprawdz(plr)
if not plr then return end
if not getElementData(plr,"player:sid") then return end
local x = exports['nrpg_db']:dbGet("SELECT * FROM aj WHERE Serial=?",getPlayerSerial(plr))
if not x or #x < 1 then return end
local x2=exports['nrpg_db']:dbGet("SELECT Termin FROM aj WHERE Serial=? and Termin < NOW()",getPlayerSerial(plr))
if x2 and #x2 > 0 then
exports['nrpg_db']:dbSet("DELETE FROM aj WHERE Serial=?", getPlayerSerial(plr))
wypusc(plr)
return end
if isElementWithinColShape(plr, cub) then return end
setElementPosition(plr,4574.94, 370.87, 5385.90)
setElementDimension(plr, 0)
setElementInterior(plr, 0)
end

local function sprawdzczas(plr)
if not plr then return end
if not getElementData(plr,"player:sid") then return end
local x = exports['nrpg_db']:dbGet("SELECT * FROM aj WHERE Serial=?",getPlayerSerial(plr))
if not x or #x < 1 then return end
local x2=exports['nrpg_db']:dbGet("SELECT Termin FROM aj WHERE Serial=? and Termin < NOW()",getPlayerSerial(plr))
if x2 and #x2 > 0 then
exports['nrpg_db']:dbSet("DELETE FROM aj WHERE Serial=?", getPlayerSerial(plr))
wypusc(plr)
return end
exports.nrpg_interface:showPlayerNotification(plr, "Zostałeś aresztowany. Powód: "..x[1].Powod.."\nCzas: "..x[1].Termin.."", "info",1,60000)
end

function uwiez(plr,cmd,cel,ile,typ, ...)
	if getElementData(plr, "player:faction")=="SAPD" then
		if not cel or not ile or not typ or not ... then
		exports.nrpg_interface:showPlayerNotification(plr, "Poprawne użycie: /jail <gracz/ID> <czas> <m/h> <powód>", "info")
		return
	end
	if not isElementWithinColShape(plr, strefa) then exports.nrpg_interface:showPlayerNotification(plr, "Aby aresztować gracza podejdź pod drzwi więzienia", "info") return end
	local target=exports["nrpg_core"]:findPlayer(plr,cel)
	if not target then
		exports.nrpg_interface:showPlayerNotification(plr, "Nie znaleziono podanego gracza.", "error")
		return
	end
	local powod = table.concat({...}, " ")
    x1,x2,x3 = getElementPosition(plr)
    y1,y2,y3 = getElementPosition(target)
    dystans = getDistanceBetweenPoints3D(x1,x2,x3,y1,y2,y3)
    if dystans > 20.0 then exports.nrpg_interface:showPlayerNotification(plr, "Podany gracz jest za daleko.", "error") return end
	if typ=="m" or typ=="h" then
		if typ=="m"then
			exports["nrpg_db"]:dbSet("INSERT INTO aj (Serial,Termin,Cela,Powod) VALUES (?,NOW() + INTERVAL ?? minute,??,?)", getPlayerSerial(target), ile, 1, powod)
			exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie aresztowano gracza: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." Powód: "..powod.." Czas: "..ile.." minut/e/y", "success",1,25000)
			setElementData(target, "player:jail", true)
			local desc = "[#FF0000Więzienie#ffffff] Gracz: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został uwięziony przez Funkcjonariusza: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..". Powód uwięzienia: "..powod..", Czas: "..ile.." min"
			triggerEvent("admin:addText", resourceRoot, desc)
			triggerEvent("admin:logs", root, desc)
			outputServerLog(desc)
			sprawdz(plr)
		end
		if typ=="h" then
			exports["nrpg_db"]:dbSet("INSERT INTO aj (Serial,Termin,Cela,Powod) VALUES (?,NOW() + INTERVAL ?? hour,??,?)", getPlayerSerial(target), ile, 1, powod)		
			exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie aresztowano gracza: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." Powód: "..powod.." Czas: "..ile.." godzin/e/y", "success",1,25000)
			setElementData(target, "player:jail", true)
			local desc = "[#FF0000Więzienie#ffffff] Gracz: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został uwięziony przez Funkcjonariusza: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..". Powód uwięzienia: "..powod..", Czas: "..ile.." h"
			triggerEvent("admin:addText", resourceRoot, desc)
			triggerEvent("admin:logs", root, desc)
			outputServerLog(desc)
			sprawdz(plr)
	end
end
	sprawdz(plr)
	sprawdzczas(plr)
	end
end
addCommandHandler("jail", uwiez)

function unaj(plr,cmd,cel)
if getElementData(plr, "player:faction")=="SAPD" then
	if not cel then
			exports.nrpg_interface:showPlayerNotification(plr, "Poprawne użycie:\n/wypusc <gracz/ID>", "error")		
		return
	end
	if not isElementWithinColShape(plr, strefa) then exports.nrpg_interface:showPlayerNotification(plr, "Aby wypuścic gracza podejdź pod drzwi więzienia", "info") return end
	local target=exports["nrpg_core"]:findPlayer(plr,cel)
	if not target then
		exports.nrpg_interface:showPlayerNotification(plr, "Nie znaleziono podanego gracza.", "error")		
		return
	end
	local jebnijsie=exports['nrpg_db']:dbGet("SELECT Termin FROM aj WHERE Serial=? and Termin > NOW()",getPlayerSerial(target))
	if jebnijsie and #jebnijsie <= 0 then outputChatBox("* Ten gracz nie jest w więzieniu! ("..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..")", plr,255,255,255, true) return end
	exports['nrpg_db']:dbSet("DELETE FROM aj WHERE Serial=?", getPlayerSerial(target))
	exports.nrpg_interface:showPlayerNotification(plr, "Pomyślnie wypuszczono gracza: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."", "success")	
	setElementData(target, "player:jail", false)
	local desc = "[#18FF00Więzienie#ffffff] Gracz: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został wypuszczony przez Funkcjonariusza: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..""
	triggerEvent("admin:addText", resourceRoot, desc)
	triggerEvent("admin:logs", root, desc)
	outputServerLog(desc)
	sprawdz(target)
	wypusc(target)
end
end
addCommandHandler("wypusc", unaj)

setTimer(function()
for _,p in pairs(getElementsByType("player")) do
sprawdz(p)
end
end,10000,0)

function spawn()
local x=exports['nrpg_db']:dbGet("SELECT Termin FROM aj WHERE Serial=? and Termin > NOW()",getPlayerSerial(source))
if x and #x <= 0 then return end
sprawdzczas(source)
end
addEventHandler("onPlayerSpawn", getRootElement(), spawn)
