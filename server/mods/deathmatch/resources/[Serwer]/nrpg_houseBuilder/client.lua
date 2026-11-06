local sw,sh = guiGetScreenSize()

local zoom = 1
local zoomLegend = 1
local baseX = 1280
local minZoom = 2
if sw < baseX then
  zoom = math.min(minZoom, baseX/sw)
end
if sw < 1600 then
  zoomLegend = math.min(minZoom, 1600/sw)
end

local textures = {
  ["walls"] = {"208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271","272","273","274","275","276","277","278","279","280","281","282","283","284","285","286","287","288","289","290","291","292","293","294","295","296","297","298","299","300","301","302","303","304","305","306","307","308","309","310","311","312","313","314","315","316","317","318","319","320","321","322"},
  ["floor"] = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","125","126","127","128","129","130","131","132","133","134","135","137","138","139","140","141","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207"},
}

local guiInfo = {}
guiInfo.fonts = {
  normal = dxCreateFont("files/font.ttf", 14),
  big = dxCreateFont("files/font.ttf", 18),
}

guiInfo.shaders = {
  builded = {},
  buildedTextures = {},
}

guiInfo.modelsID = {
  wall = 1866,
  floor = 1868,
  doors = 1867,
}

guiInfo.howManyToShow = math.floor((sw-60)/140/zoom)
guiInfo.spaceLeft = (sw - guiInfo.howManyToShow*140/zoom)/2

guiInfo.positionCamera = {
  [1] = 3,
  [2] = 6,
  [3] = 9,
}

guiInfo.cameraDetails = {
  depth = 30,
  depth_min = 10,
  depth_max = 30,
  height = 23,
  height_min = 3,
  height_max = 23,
}

guiInfo.builderDetails = {
  floorSize = 3,
  wallHeight = 3,
}

guiInfo.furniture = {
  rotation = 1,
  rotations = {
    [1] = {0, 0, guiInfo.builderDetails.floorSize/2},
    [2] = {270, guiInfo.builderDetails.floorSize/2, 0},
    [3] = {180, 0, -guiInfo.builderDetails.floorSize/2},
    [4] = {90, -guiInfo.builderDetails.floorSize/2, 0},
  },
}

guiInfo.defaultOptions = {
  {"files/icons/buildWall.png", "Wstaw ścianę", "build", 1, 0},
  {"files/icons/doors.png", "Wstaw drzwi", "build", 2, 0},
}

guiInfo.selectMenuOpenList = {
  {"Drzwi", "files/icons/doors_s.png", {
    {"files/icons/doors.png", "Szmaragdowa zieleń", "furniture", 1492, 212},
    {"files/icons/doors.png", "Czarny dąb", "furniture", 1502, 280},
    {"files/icons/doors.png", "Stalowy bolaj", "furniture", 1523, 226},
    {"files/icons/doors.png", "Wysłużone", "furniture", 1499, 268},
    {"files/icons/doors.png", "Młoda wiśnia", "furniture", 1494, 236},
    {"files/icons/doors.png", "Ciemne kakao", "furniture", 1491, 248},
    {"files/icons/doors.png", "Orzechowe", "furniture", 14638, 248},
  }},
 
  {"Biurka", "files/icons/desk_s.png", {
    {"files/icons/desk.png", "Biurko BOSS", "furniture", 2206, 520},
    {"files/icons/desk.png", "Komplet biurowy", "furniture", 2308, 340},
    {"files/icons/desk.png", "Biurko Quercus", "furniture", 2205, 320},
    {"files/icons/desk.png", "Jasna brzoza", "furniture", 1963, 230},
    {"files/icons/desk.png", "Zdana matura", "furniture", 2180, 290},
    {"files/icons/desk.png", "Podwójne szafki", "furniture", 2169, 390},
    {"files/icons/desk.png", "Komplet z szafką", "furniture", 2171, 380},
    {"files/icons/desk.png", "Biurko SCHOOL", "furniture", 2173, 320},
    {"files/icons/desk.png", "Informatyk", "furniture", 2009, 300},
    {"files/icons/desk.png", "Biurko z komputerem", "furniture", 2008, 300},
    {"files/icons/desk.png", "Biurko z szkła", "furniture", 2209, 300},
    {"files/icons/desk.png", "Ława", "furniture", 2118, 300},
    {"files/icons/desk.png", "Ława 2", "furniture", 2112, 300},
    {"files/icons/desk.png", "Ława 3", "furniture", 2111, 300},
    {"files/icons/desk.png", "Do jadalni", "furniture", 2030, 300},
 
  }},
 
  {"Stoły", "files/icons/table_s.png", {
    {"files/icons/table.png", "Pizza time", "furniture", 2644, 330},
    {"files/icons/table.png", "Coffee time", "furniture", 2370, 280},
    {"files/icons/table.png", "Stół billardowy", "furniture", 2964, 1000},
    {"files/icons/table.png", "Stolik na prasę", "furniture", 2319, 296},
    {"files/icons/table.png", "Mały i okrągły", "furniture", 1820, 316},
    {"files/icons/table.png", "Twoja wola", "furniture", 1814, 400},
    {"files/icons/table.png", "Świąteczne marzenie", "furniture", 2357, 630},
    {"files/icons/table.png", "Komplet Espresso", "furniture", 2571, 860},
    {"files/icons/table.png", "Stolik RTV", "furniture", 2346, 300},
    {"files/icons/table.png", "Czarny dąb", "furniture", 2315, 390},
    {"files/icons/table.png", "Dębowy raj", "furniture", 2321, 390},
    {"files/icons/table.png", "Na Donuta", "furniture", 2747, 450},
    {"files/icons/table.png", "Mały Donut", "furniture", 2635, 230},
    {"files/icons/table.png", "Czerwona rozkosz", "furniture", 2762, 390},
    {"files/icons/table.png", "Mała różyczka", "furniture", 2763, 220},
  }},
 
  {"Krzesła", "files/icons/chair_s.png", {
    {"files/icons/chair.png", "Rodzinnie", "furniture", 1825, 540},
    {"files/icons/chair.png", "Miłe poczekanie", "furniture", 2079, 100},
    {"files/icons/chair.png", "Pyszny obiad", "furniture", 2636, 120},
    {"files/icons/chair.png", "Krzesło biurowe", "furniture", 2356, 180},
    {"files/icons/chair.png", "Krzesło MAFIA", "furniture", 1714, 220},
    {"files/icons/chair.png", "Czerwony plastik", "furniture", 2121, 90},
    {"files/icons/chair.png", "Krzesło rodzinne", "furniture", 1811, 140},
    {"files/icons/chair.png", "Krzesło barowe", "furniture", 1716, 160},
    {"files/icons/chair.png", "Czerwony drink", "furniture", 2125, 160},
    {"files/icons/chair.png", "Na dywaniku", "furniture", 1724, 130},
    {"files/icons/chair.png", "Czarne krzesło", "furniture", 2079, 320},
    {"files/icons/chair.png", "Uroczyste krzesło", "furniture", 2123, 130},
    {"files/icons/chair.png", "Fotel bujany", "furniture", 2096, 200},
    {"files/icons/chair.png", "Milutki fotel", "furniture", 1735, 150},
    {"files/icons/chair.png", "Kanapa niebieska", "furniture", 1768, 150},
    {"files/icons/chair.png", "Kokon", "furniture", 2295, 150},
    {"files/icons/chair.png", "Fotel", "furniture", 2291, 150},
    {"files/icons/chair.png", "Tapczan", "furniture", 1746, 150},
    {"files/icons/chair.png", "Fotel 2", "furniture", 1759, 150},
  }},
 
  {"Szafki", "files/icons/board_s.png", {
    {"files/icons/chair.png", "Szafa", "furniture", 2167, 412},
    {"files/icons/chair.png", "Szafa zamknięta", "furniture", 1417, 412},
    {"files/icons/chair.png", "Szafa otwarta", "furniture", 14556, 412},
    {"files/icons/chair.png", "Biblioteczka Kujon", "furniture", 2161, 584},
    {"files/icons/chair.png", "Regał z książkami", "furniture", 1742, 584},
    {"files/icons/chair.png", "Meblościanka", "furniture", 2204, 584},
    {"files/icons/chair.png", "Niebieska szafka", "furniture", 2191, 560},
    {"files/icons/chair.png", "Do sypialni", "furniture", 2573, 560},
    {"files/icons/chair.png", "Szafka na buty", "furniture", 2385, 560},
    {"files/icons/chair.png", "Szafka pocztowa", "furniture", 2197, 420},
    {"files/icons/chair.png", "Szafka na dokumenty", "furniture", 2007, 630},
    {"files/icons/chair.png", "Komoda BOSS", "furniture", 2164, 865},
    {"files/icons/chair.png", "Szafka kuchenna", "furniture", 2163, 513},
    {"files/icons/chair.png", "Tablet", "furniture", 2162, 490},
    {"files/icons/chair.png", "Dwa w jednym", "furniture", 2200, 646},
    {"files/icons/chair.png", "Dla informatyka", "furniture", 2199, 598},
  }},
 
  {"AGD i RTV", "files/icons/AGD_s.png", {
    {"files/icons/chair.png", "Drukarka", "furniture", 2201, 468},
    {"files/icons/chair.png", "Drukarka 2", "furniture", 2186, 1800},
    {"files/icons/chair.png", "Kserokopiarka", "furniture", 2202, 830},
    {"files/icons/chair.png", "Telewizor kineskopowy", "furniture", 1518, 1180},
    {"files/icons/chair.png", "Telewizor", "furniture", 1781, 1295},
    {"files/icons/chair.png", "Telewizor ZABYTEK", "furniture", 14772, 910},
    {"files/icons/chair.png", "Telewizor instruktażowy", "furniture", 14532, 1495},
    {"files/icons/chair.png", "Telewizor zabudowany", "furniture", 2296, 1800},
    {"files/icons/chair.png", "Głośnik", "furniture", 1840, 1800},
    {"files/icons/chair.png", "Głośnik 2", "furniture", 2231, 1800},
    {"files/icons/chair.png", "Radio", "furniture", 2102, 1800},
    {"files/icons/chair.png", "Stary Telewizor z głośnikami", "furniture", 14806, 1800},
    {"files/icons/chair.png", "Radio", "furniture", 2102, 1800},
    {"files/icons/chair.png", "Konsola", "furniture", 2028, 1800},
 
  }},
 
  {"Łazienka", "files/icons/bath_s.png", {
    {"files/icons/chair.png", "Umywalka", "furniture", 2515, 300},
    {"files/icons/chair.png", "Umywalka 2", "furniture", 2518, 300},
    {"files/icons/chair.png", "Wanna", "furniture", 2526, 662},
    {"files/icons/chair.png", "Suszarka do rąk", "furniture", 2742, 480},
   {"files/icons/chair.png", "Prysznic", "furniture", 2527, 630},
   {"files/icons/chair.png", "Prysznic 2", "furniture", 2517, 630},
   {"files/icons/chair.png", "Toaleta z ręcznikiem", "furniture", 2528, 389},
   {"files/icons/chair.png", "Toaleta KĄCIK", "furniture", 2521, 420},
   {"files/icons/chair.png", "Toaleta BOSS", "furniture", 2525, 480},
   {"files/icons/chair.png", "Toaleta", "furniture", 2738, 480},
   {"files/icons/chair.png", "Pralka 1", "furniture", 2303, 480},
   {"files/icons/chair.png", "Pralka 2", "furniture", 2337, 480},
   {"files/icons/chair.png", "Pralka 3", "furniture", 2018, 480},
   {"files/icons/chair.png", "Pralka 4", "furniture", 1208, 480},
   {"files/icons/chair.png", "Wiadro z mopem", "furniture", 1778, 480},
   {"files/icons/chair.png", "Mop", "furniture", 2712, 480},
 }},
 
 {"Kuchnia", "files/icons/kitchen_s.png", {
   {"files/icons/chair.png", "Szafka ze zlewem", "furniture", 2132, 400},
   {"files/icons/chair.png", "Maszyna do napojów", "furniture", 2500, 680},
   {"files/icons/chair.png", "Naczynia", "furniture", 2865, 140},
   {"files/icons/chair.png", "Brudne naczynia", "furniture", 2850, 120},
   {"files/icons/chair.png", "Kuchenka gazowa", "furniture", 2017, 120},
   {"files/icons/chair.png", "Kuchenka gazowa 2", "furniture", 2294, 120},
   {"files/icons/chair.png", "Mikrofala", "furniture", 2149, 120},
   {"files/icons/chair.png", "Zlew", "furniture", 2150, 120},
   {"files/icons/chair.png", "Zlew z szafką", "furniture", 2130, 120},
   {"files/icons/chair.png", "Szafka kuchenna", "furniture", 2133, 120},
   {"files/icons/chair.png", "Regał czerwony", "furniture", 2128, 120},
   {"files/icons/chair.png", "Regał biały", "furniture", 2141, 120},
   {"files/icons/chair.png", "Blat biały", "furniture", 2152, 120},
   {"files/icons/chair.png", "Lodówka duża", "furniture", 2127, 120},
 }},
 
 {"Obrazy", "files/icons/kitchen_s.png", {
   {"files/icons/chair.png", "Obraz 1", "furniture", 2289, 400},
    {"files/icons/chair.png", "Obraz 2", "furniture", 2288, 680},
    {"files/icons/chair.png", "Obraz 3", "furniture", 2286, 140},
    {"files/icons/chair.png", "Obraz 4", "furniture", 2285, 120},
    {"files/icons/chair.png", "Obraz 5", "furniture", 2284, 120},
    {"files/icons/chair.png", "Obraz 6", "furniture", 2281, 120},
    {"files/icons/chair.png", "Obraz 7", "furniture", 2279, 120},
    {"files/icons/chair.png", "Obraz 8", "furniture", 2278, 120},
    {"files/icons/chair.png", "Obraz 9", "furniture", 2277, 120},
   {"files/icons/chair.png", "Obraz 10", "furniture", 2266, 120},
   {"files/icons/chair.png", "Obraz 11", "furniture", 2256, 120},
 }},
 
 {"Różne", "files/icons/other_s.png", {
   {"files/icons/chair.png", "Dla spragnionych", "furniture", 1808, 368},
   {"files/icons/chair.png", "Ochłoda", "furniture", 2002, 392},
 }},
}

guiInfo.renderGuiList = {}


function renderInfo()
  dxDrawText("Aby zakończyć tryb testowania kliknij ENTER", 53/zoom, sh-171/zoom, 87/zoom, sh-131/zoom, tocolor(0, 0, 0, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)
  dxDrawText("Aby zakończyć tryb testowania kliknij #FFF600ENTER", 52/zoom, sh-170/zoom, 86/zoom, sh-130/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)
end

function render()
  dxDrawImage(0, 0, 304/zoomLegend, 480/zoomLegend,'files/icons/legend/legend.png')
  moveCamera()
  gui()

  local k = 0
  for i=0, (guiInfo.interiorSize[2]*2+1) do
    local pos = guiInfo.defPosForPlayer
    if i >= guiInfo.interiorSize[2]+1 then
      dxDrawLine3D(pos[1], pos[2] - guiInfo.builderDetails.floorSize*0.5 + guiInfo.builderDetails.floorSize*k, pos[3]-0.96, pos[1]+(guiInfo.interiorSize[2]+1)*guiInfo.builderDetails.floorSize, pos[2] - guiInfo.builderDetails.floorSize*0.5 + guiInfo.builderDetails.floorSize*k, pos[3]-0.96, tocolor(20, 255, 20, 255), 2)
      k = k + 1
    else
      dxDrawLine3D(pos[1] + guiInfo.builderDetails.floorSize/2 + guiInfo.builderDetails.floorSize*i, pos[2] - guiInfo.builderDetails.floorSize, pos[3]-0.96, pos[1] + guiInfo.builderDetails.floorSize/2 + guiInfo.builderDetails.floorSize*i, pos[2]+(guiInfo.interiorSize[2])*guiInfo.builderDetails.floorSize, pos[3]-0.96, tocolor(20, 255, 20, 255), 2)
    end

  end

  if guiInfo.testingByPlayer then return end

  if guiInfo.mouse then
    local screenX,screenY,_,_,_ = getCursorPosition()
    if type(screenX) == "number" then
      local rotAdd = (screenX - guiInfo.screenX)*360
      guiInfo.rot = guiInfo.rot + rotAdd
      guiInfo.screenX = screenX
    end
  elseif guiInfo.mouseLeft then
    local screenX,screenY,_,_,_ = getCursorPosition()
    if type(screenY) == "number" then
      local zAdd = (screenY - guiInfo.screenY)*20
      guiInfo.cameraDetails.height = math.max(math.min(guiInfo.cameraDetails.height + zAdd, guiInfo.cameraDetails.height_max), guiInfo.cameraDetails.height_min)
      guiInfo.cameraDetails.depth = math.max(math.min(guiInfo.cameraDetails.depth + zAdd, guiInfo.cameraDetails.depth_max), guiInfo.cameraDetails.depth_min)
      guiInfo.screenY = screenY
    end
  end

  if guiInfo.editingElement and isElement(guiInfo.editingElement) then
    moveObject()
    if guiInfo.editingElementCanTextureChange then renderTexutring() end
    if guiInfo.editingElementCanChangePos then drawPositionLines(guiInfo.editingElement) end

    local objPos = Vector3(guiInfo.editingElement:getPosition())
    local x, y = getPointFromDistanceRotation(objPos.x, objPos.y, guiInfo.cameraDetails.depth/3, guiInfo.rot)
    Camera.setMatrix(x, y, objPos.z+guiInfo.cameraDetails.height/3, objPos.x, objPos.y, objPos.z+0.5)
    return
  end

  local x, y = getPointFromDistanceRotation(guiInfo.posX, guiInfo.posY, guiInfo.cameraDetails.depth, guiInfo.rot)
  Camera.setMatrix(x, y, guiInfo.posZ+guiInfo.positionCamera[guiInfo.floor] + guiInfo.cameraDetails.height, guiInfo.posX, guiInfo.posY, guiInfo.posZ+guiInfo.positionCamera[guiInfo.floor])

  if guiInfo.buildingWall and isElement(guiInfo.buildingWall) then
    local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
    local px, py, pz = getCameraMatrix()
    local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, false, false, true, true, false, false, false, guiInfo.buildingWall)
    if hit and isElement(elementHit) and elementHit:getData("builder:type") == "floor" then
      local posObj = Vector3(elementHit:getPosition())
      local rot = guiInfo.furniture.rotations[guiInfo.furniture.rotation]
      guiInfo.buildingWall:setPosition(posObj.x + rot[2], posObj.y + rot[3], posObj.z + guiInfo.builderDetails.wallHeight/2)
      guiInfo.buildingWall:setRotation(0, 0, rot[1])
    end

  elseif guiInfo.buildingFurniture and isElement(guiInfo.buildingFurniture) then
    drawPositionLines(guiInfo.buildingFurniture)

    local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
    local px, py, pz = getCameraMatrix()
    local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, false, false, true, true, false, false, false, guiInfo.buildingFurniture)
    if hit and isElement(elementHit) then --and elementHit:getData("builder:type") == "floor" then
      if getKeyState("arrow_u") then guiInfo.buildingObjectZ = guiInfo.buildingObjectZ+0.005 end
      if getKeyState("arrow_d") then guiInfo.buildingObjectZ = guiInfo.buildingObjectZ-0.005 end

      if getKeyState("arrow_l") then guiInfo.rotFurniture = guiInfo.rotFurniture+0.3 end
      if getKeyState("arrow_r") then guiInfo.rotFurniture = guiInfo.rotFurniture-0.3 end


      if guiInfo.renderGuiType == "Drzwi" then
        if elementHit:getModel() == guiInfo.modelsID.doors then
          local posObj = Vector3(elementHit:getPosition())
          local rotObj = Vector3(elementHit:getRotation())
          if rotObj.z > -1 and rotObj.z < 1 then
            guiInfo.buildingFurniture:setPosition(posObj.x-0.78, posObj.y-0.02, posObj.z-1.5)
            guiInfo.buildingFurniture:setRotation(0, 0, 0)
          elseif rotObj.z > 89 and rotObj.z < 91 then
            guiInfo.buildingFurniture:setPosition(posObj.x+0.02, posObj.y-0.78, posObj.z-1.5)
            guiInfo.buildingFurniture:setRotation(0, 0, 90)
          elseif rotObj.z > 179 and rotObj.z < 181 then
            guiInfo.buildingFurniture:setPosition(posObj.x+0.78, posObj.y+0.02, posObj.z-1.5)
            guiInfo.buildingFurniture:setRotation(0, 0, 180)
          elseif rotObj.z > 269 and rotObj.z < 271 then
            guiInfo.buildingFurniture:setPosition(posObj.x-0.02, posObj.y+0.78, posObj.z-1.5)
            guiInfo.buildingFurniture:setRotation(0, 0, 270)
          end
        else
          guiInfo.buildingFurniture:setPosition(x, y, z+guiInfo.buildingObjectZ)
          guiInfo.buildingFurniture:setRotation(0, 0, guiInfo.rotFurniture)
        end
      else
        guiInfo.buildingFurniture:setPosition(x, y, z+guiInfo.buildingObjectZ)
        guiInfo.buildingFurniture:setRotation(0, 0, guiInfo.rotFurniture)
      end
    end

  end
end

function click(btn, state)
  if btn == "left" and state == "down" then
    if guiInfo.saveInteriorAccept then
      if isMouseInPosition((sw-400/zoom)/2 + 10/zoom, (sh+210/zoom)/2-50/zoom, 180/zoom, 40/zoom) then
        guiInfo.saveInteriorAccept = false

      elseif isMouseInPosition((sw+400/zoom)/2 - 190/zoom, (sh+210/zoom)/2-50/zoom, 180/zoom, 40/zoom) then
        saveBuildInterior()
      end
      return
    end

    local posFirst = sh - 170/zoom - #guiInfo.selectMenuOpenList * 44/zoom

    if isMouseInPosition(10/zoom, sh-166/zoom, 92/zoom, 32/zoom) then
      guiInfo.optionsMenuOpen = not guiInfo.optionsMenuOpen
      if isElement(guiInfo.buildingWall) then guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false end
      return

    elseif isMouseInPosition(0, sh-296/zoom, 180/zoom, 32/zoom) and guiInfo.optionsMenuOpen then
      saveBuildInterior()
      return

    elseif isMouseInPosition(0, sh-254/zoom, 180/zoom, 32/zoom) and guiInfo.optionsMenuOpen then
      setPlayerTestingInterior()
      return

    elseif isMouseInPosition(0, sh-212/zoom, 180/zoom, 32/zoom) and guiInfo.optionsMenuOpen then
      closeInteriorBuilder()
      return

    elseif isMouseInPosition(375/zoom, sh-166/zoom, 160/zoom, 32/zoom) then
      guiInfo.selectMenuOpen = not guiInfo.selectMenuOpen
      return

    elseif isMouseInPosition(160/zoom, sh-166/zoom, 160/zoom, 32/zoom) then
      if isElement(guiInfo.buildingWall) then guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false end
      if isElement(guiInfo.buildingFurniture) then guiInfo.buildingFurniture:destroy(); guiInfo.buildingFurniture = false end
      if guiInfo.renderGuiList == guiInfo.defaultOptions then guiInfo.renderGuiList = {} return end
      guiInfo.renderGuiList = guiInfo.defaultOptions
      return

    elseif isMouseInPosition(0, sh-170/zoom, sw, 170/zoom) then
      local k = 0
      for i, v in pairs(guiInfo.renderGuiList) do
        if isMouseInPosition(guiInfo.spaceLeft + 140/zoom*(k), sh-125/zoom, 80/zoom, 80/zoom) then
          useOptionForBuilder(guiInfo.renderGuiList[guiInfo.menuScroll+k][3], guiInfo.renderGuiList[guiInfo.menuScroll+k][4], guiInfo.renderGuiList[guiInfo.menuScroll+k][5])
          guiInfo.buildingData = v
          break
        end
        k = k + 1
      end

    elseif isMouseInPosition(365/zoom, posFirst, 180/zoom, 44/zoom*(#guiInfo.selectMenuOpenList)) and guiInfo.selectMenuOpen then
      if #guiInfo.selectMenuOpenList > 0 then
        for i, v in pairs(guiInfo.selectMenuOpenList) do
          if isMouseInPosition(365/zoom, posFirst + 44/zoom*(i-1), 180/zoom, 44/zoom) then
            if isElement(guiInfo.buildingWall) then guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false end
            if isElement(guiInfo.buildingFurniture) then guiInfo.buildingFurniture:destroy(); guiInfo.buildingFurniture = false end
            if guiInfo.renderGuiList == v[3] then guiInfo.renderGuiList = {} return end
            guiInfo.renderGuiType = v[1]
            guiInfo.renderGuiList = v[3]
            guiInfo.menuScroll = 1
            break
          end
        end
      end

    elseif isMouseInPosition(sw-320/zoom, (sh-540/zoom)/2, 320/zoom, 540/zoom) and guiInfo.editingElementCanTextureChange then
      if isMouseInPosition(sw-320/zoom + 72/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom) then
        if guiInfo.textureType == "walls" then guiInfo.selectedTextureEditing = 1 end

      elseif isMouseInPosition(sw-320/zoom + 174/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom) then
        if guiInfo.textureType == "walls" then guiInfo.selectedTextureEditing = 2 end

      else
        local k = 1
        local row = 0
        for i, v in pairs(textures[guiInfo.textureType]) do
          if row < 4 then
            if textures[guiInfo.textureType][guiInfo.texturesScroll+i] then
              if fileExists("files/textures/"..textures[guiInfo.textureType][guiInfo.texturesScroll+i]..".jpg") then
                if isMouseInPosition(sw-308/zoom + 102/zoom*(k-1), (sh-270/zoom)/2 + 102/zoom*row, 90/zoom, 90/zoom) then
                  local text = guiInfo.editingElement:getData("builder:textures") and guiInfo.editingElement:getData("builder:textures") or {"", ""}
                  text[guiInfo.selectedTextureEditing] = textures[guiInfo.textureType][guiInfo.texturesScroll+i]

                  changeTexture(guiInfo.editingElement, text[1], text[2])
                  guiInfo.editingElement:setData("builder:textures", text)
                  break
                end

                if k == 3 then
                  k = 0
                  row = row + 1
                end
                k = k + 1
              end
            end
          end
        end

      end


    elseif guiInfo.buildingWall and isElement(guiInfo.buildingWall) then
      local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
      local px, py, pz = getCameraMatrix()
      local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, false, false, true, true, false, false, false, guiInfo.buildingWall)
      if hit then
        if elementHit:getData("builder:type") == "floor" then
        local posObj = Vector3(elementHit:getPosition())
        local rot = guiInfo.furniture.rotations[guiInfo.furniture.rotation]

        if guiInfo.buildingData[4] == 1 or guiInfo.buildingData[4] == 2 then

          local canPlace = true
          local posB = Vector3(guiInfo.buildingWall:getPosition())
          for i, v in pairs(guiInfo.buildedObjects) do
            local pos = Vector3(v:getPosition())
            if pos.x == posB.x and pos.y == posB.y and pos.z == posB.z then
              canPlace = false
            end
          end
          if not canPlace then return end
          local wall = Object(getElementModel(guiInfo.buildingWall), posObj.x + rot[2], posObj.y + rot[3], posObj.z + guiInfo.builderDetails.wallHeight/2)
          wall:setRotation(0, 0, rot[1])
          wall:setInterior(99)
          table.insert(guiInfo.buildedObjects, wall)

          wall:setData("builder:price", guiInfo.buildingData[5]*100)
          guiInfo.toPay = guiInfo.toPay + guiInfo.buildingData[5]*100
        end

        elseif guiInfo.buildingData[4] == 3 then
          local isElement = false
          local posB = Vector3(guiInfo.buildingWall:getPosition())
          for i, v in pairs(guiInfo.buildedObjects) do
            local pos = Vector3(v:getPosition())
            if pos.x == posB.x and pos.y == posB.y and pos.z == posB.z then
              isElement = i
            end
          end
          if not isElement then return end
          guiInfo.buildedObjects[isElement]:destroy()
          table.remove(guiInfo.buildedObjects, isElement)

          guiInfo.toPay = guiInfo.toPay + guiInfo.buildingData[5]*100
        end
      end

    elseif guiInfo.buildingFurniture and isElement(guiInfo.buildingFurniture) then
      local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
      local px, py, pz = getCameraMatrix()
      local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, false, false, true, true, false, false, false, guiInfo.buildingFurniture)

      if not hit or not isElement(elementHit) then return end
      --if elementHit:getData("builder:type") == "floor" then
        local posObj = Vector3(guiInfo.buildingFurniture:getPosition())
        local posRot = Vector3(guiInfo.buildingFurniture:getRotation())
        local furniture = Object(getElementModel(guiInfo.buildingFurniture), posObj.x, posObj.y, posObj.z)
        furniture:setRotation(0, 0, posRot.z)
        furniture:setInterior(99)
        furniture:setCollisionsEnabled(true)
        table.insert(guiInfo.buildedObjects, furniture)

        furniture:setData("builder:price", guiInfo.buildingData[5]*100)
        guiInfo.toPay = guiInfo.toPay + guiInfo.buildingData[5]*100
    --  end


    elseif not guiInfo.buildingFurniture and not isElement(guiInfo.buildingFurniture) and not guiInfo.buildingWall and not isElement(guiInfo.buildingWall) then
      local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
      local px, py, pz = getCameraMatrix()
      local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, false, false, true, true, false, false, false)
      if hit then
        for i, v in pairs(guiInfo.buildedObjects) do
          if v == elementHit then
            guiInfo.editingElement = elementHit
            guiInfo.editingElementPositionDefault = Vector3(elementHit:getPosition())
            guiInfo.editingElementRotationDefault = Vector3(elementHit:getRotation())

            local modelID = elementHit:getModel()

            if modelID == guiInfo.modelsID.wall or modelID == guiInfo.modelsID.floor or modelID == guiInfo.modelsID.doors then
              guiInfo.editingElementCanChangePos = false
              guiInfo.editingElementCanTextureChange = true
              guiInfo.textureType = modelID == guiInfo.modelsID.floor and "floor" or "walls"
              if guiInfo.texturesScroll + 9 > #textures[guiInfo.textureType] then guiInfo.texturesScroll = 0 end
              guiInfo.selectedTextureEditing = 1
            else
              guiInfo.editingElementCanChangePos = true
              guiInfo.editingElementCanTextureChange = false
            end

            break
          end
        end

        for i, v in pairs(guiInfo.skeletonWalls) do
          if v == elementHit then
            guiInfo.editingElement = elementHit
            guiInfo.editingElementPositionDefault = Vector3(elementHit:getPosition())
            guiInfo.editingElementRotationDefault = Vector3(elementHit:getRotation())

            local modelID = elementHit:getModel()
            guiInfo.editingElementCanChangePos = false
            guiInfo.editingElementCanTextureChange = true
            guiInfo.textureType = modelID == guiInfo.modelsID.floor and "floor" or "walls"
            if guiInfo.texturesScroll + 9 > #textures[guiInfo.textureType] then guiInfo.texturesScroll = 0 end
            guiInfo.selectedTextureEditing = 1
            break
          end
        end

        for i, v in pairs(guiInfo.skeleton) do
          if v == elementHit then
            guiInfo.editingElement = elementHit
            guiInfo.editingElementPositionDefault = Vector3(elementHit:getPosition())
            guiInfo.editingElementRotationDefault = Vector3(elementHit:getRotation())

            local modelID = elementHit:getModel()
            guiInfo.editingElementCanChangePos = false
            guiInfo.editingElementCanTextureChange = true
            guiInfo.textureType = modelID == guiInfo.modelsID.floor and "floor" or "walls"
            if guiInfo.texturesScroll + 9 > #textures[guiInfo.textureType] then guiInfo.texturesScroll = 0 end
            guiInfo.selectedTextureEditing = 1
            break
          end
        end

      end
    end
  end
end

function key(btn, state)
  if btn == "mouse2" then
    if state then
      guiInfo.mouse = true
      screenX,screenY,_,_,_ = getCursorPosition()
      guiInfo.screenX = screenX
    else
      screenX,screenY,_,_,_ = getCursorPosition()
      guiInfo.mouse = false
      guiInfo.screenX = screenX
    end

  elseif btn == "mouse_wheel_up" then
    if state then
      if isMouseInPosition(0, sh-130/zoom, sw, 130/zoom) then
        if (guiInfo.menuScroll+guiInfo.howManyToShow) >= #guiInfo.renderGuiList then return end
        guiInfo.menuScroll = guiInfo.menuScroll + 1

      elseif isMouseInPosition(sw-320/zoom, (sh-540/zoom)/2, 320/zoom, 500/zoom) and guiInfo.editingElementCanTextureChange then
        if guiInfo.texturesScroll == 0 then return end
        guiInfo.texturesScroll = guiInfo.texturesScroll - 3

      else
        local zAdd = 1
        guiInfo.cameraDetails.height = math.max(math.min(guiInfo.cameraDetails.height + zAdd, guiInfo.cameraDetails.height_max), guiInfo.cameraDetails.height_min)
        guiInfo.cameraDetails.depth = math.max(math.min(guiInfo.cameraDetails.depth + zAdd, guiInfo.cameraDetails.depth_max), guiInfo.cameraDetails.depth_min)
      end
    end
  elseif btn == "mouse_wheel_down" then
    if state then
      if isMouseInPosition(0, sh-130/zoom, sw, 130/zoom) then
        if guiInfo.menuScroll <= 1 then return end
        guiInfo.menuScroll = guiInfo.menuScroll - 1

      elseif isMouseInPosition(sw-320/zoom, (sh-540/zoom)/2, 320/zoom, 500/zoom) and guiInfo.editingElementCanTextureChange then
        if guiInfo.texturesScroll + 13 > #textures[guiInfo.textureType] then return end
        guiInfo.texturesScroll = guiInfo.texturesScroll + 3

      else
        local zAdd = -1
        guiInfo.cameraDetails.height = math.max(math.min(guiInfo.cameraDetails.height + zAdd, guiInfo.cameraDetails.height_max), guiInfo.cameraDetails.height_min)
        guiInfo.cameraDetails.depth = math.max(math.min(guiInfo.cameraDetails.depth + zAdd, guiInfo.cameraDetails.depth_max), guiInfo.cameraDetails.depth_min)
      end
    end

  elseif btn == "enter" then
    if guiInfo.testingByPlayer then
      setPlayerTestingInterior()

    elseif guiInfo.editingElement then
      guiInfo.editingElement = false
    end

  elseif btn == "delete" and state and isElement(guiInfo.editingElement) then
    local price = guiInfo.editingElement:getData("builder:price")
    if price then
      guiInfo.toPay = guiInfo.toPay - price
    end

    local posB = Vector3(guiInfo.editingElement:getPosition())
    local isElement = false
    for i, v in pairs(guiInfo.buildedObjects) do
      local pos = Vector3(v:getPosition())
      if pos.x == posB.x and pos.y == posB.y and pos.z == posB.z then
        isElement = i
        break
      end
    end
    if not isElement then return end
    guiInfo.buildedObjects[isElement]:destroy()
    table.remove(guiInfo.buildedObjects, isElement)

  elseif btn == "backspace" then
    if guiInfo.editingElement then
      local posDef = guiInfo.editingElementPositionDefault
      local rotDef = guiInfo.editingElementRotationDefault
      guiInfo.editingElement:setPosition(posDef.x, posDef.y, posDef.z)
      guiInfo.editingElement:setRotation(rotDef.x, rotDef.y, rotDef.z)

      guiInfo.editingElement = false
    end
  end

  if btn == "r" and state then
    guiInfo.furniture.rotation = guiInfo.furniture.rotation + 1
    if guiInfo.furniture.rotation > #guiInfo.furniture.rotations then guiInfo.furniture.rotation = 1 end
  end
end

function przecinek(liczba)  
  local format = liczba  
  while true do      
      format, k = string.gsub(format, "^(-?%d+)(%d%d%d)", '%1,%2')    
      if ( k==0 ) then      
          break  
      end  
  end  
  return format
end

function gui()
  dxDrawRectangle(0, sh-170/zoom, sw, 40/zoom, tocolor(15, 15, 35, 255))
  dxDrawRectangle(0, sh-130/zoom, sw, 130/zoom, tocolor(30, 30, 65, 255))
  dxDrawText('Do zapłaty: #F6FF00'..przecinek(guiInfo.toPay/100)..'PLN'..'#ffffff | '.. 'Pieniądze: #F6FF00'..przecinek(guiInfo.moneyPlayer/100)..'PLN', sw-240/zoom, sh-170/zoom, sw-20/zoom, sh-130/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "right", "center", false, false, false, true)

  --dxDrawRectangle(375/zoom, sh-166/zoom, 160/zoom, 32/zoom, tocolor(255, 255, 255, 255)) -- do testowania wielkości przycisku
  dxDrawImage(10/zoom, sh-166/zoom, 32/zoom, 32/zoom, "files/icons/options.png", 0, 0, 0, tocolor(255, 255, 255, 255))
  dxDrawText("Opcje", 52/zoom, sh-170/zoom, 86/zoom, sh-130/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)

  dxDrawImage(160/zoom, sh-166/zoom, 32/zoom, 32/zoom, "files/icons/build.png", 0, 0, 0, tocolor(255, 255, 255, 255))
  dxDrawText("Projektowanie", 202/zoom, sh-170/zoom, 222/zoom, sh-130/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)

  dxDrawImage(375/zoom, sh-166/zoom, 32/zoom, 32/zoom, "files/icons/build.png", 0, 0, 0, tocolor(255, 255, 255, 255))
  dxDrawText("Urządzanie", 417/zoom, sh-170/zoom, 467/zoom, sh-130/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)

  if guiInfo.optionsMenuOpen then
    dxDrawRectangle(0, sh-306/zoom, 180/zoom, 136/zoom, tocolor(15, 15, 35, 255))
    dxDrawImage(10/zoom, sh-296/zoom, 32/zoom, 32/zoom, "files/icons/save.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawImage(10/zoom, sh-254/zoom, 32/zoom, 32/zoom, "files/icons/people.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawImage(10/zoom, sh-212/zoom, 32/zoom, 32/zoom, "files/icons/exit.png", 0, 0, 0, tocolor(255, 255, 255, 255))

    dxDrawText("Zapisz", 52/zoom, sh-296/zoom, 42/zoom, sh-264/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)
    dxDrawText("Przetestuj", 52/zoom, sh-254/zoom, 42/zoom, sh-222/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)
    dxDrawText("Zamknij edytor", 52/zoom, sh-212/zoom, 42/zoom, sh-180/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center", false, false, false, true)
  end

  if guiInfo.selectMenuOpen then
    if #guiInfo.selectMenuOpenList > 0 then
      local posFirst = sh - 170/zoom - #guiInfo.selectMenuOpenList * 44/zoom
      for i, v in pairs(guiInfo.selectMenuOpenList) do
        dxDrawRectangle(365, posFirst + 44/zoom*(i-1), 180/zoom, 44/zoom, tocolor(15, 15, 35, 255))
        dxDrawImage(375/zoom, posFirst + 6/zoom + 44/zoom*(i-1), 32/zoom, 32/zoom, v[2], 0, 0, 0, tocolor(255, 255, 255, 255))
        dxDrawText(v[1], 417/zoom, posFirst + 44/zoom*(i-1), 427 + 118/zoom, posFirst + 44/zoom*i, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "left", "center")
      end
    end
  end

  if guiInfo.saveInteriorAccept then
    dxDrawRectangle((sw-400/zoom)/2, (sh-210/zoom)/2, 400/zoom, 210/zoom, tocolor(15, 15, 35, 255))
    dxDrawText("Czy jesteś pewny, że chcesz wprowadzić aktualne zmiany?", (sw-390/zoom)/2, (sh-200/zoom)/2, (sw+390/zoom)/2, (sh+210/zoom)/2, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.big, "center", "top", true, true, false, false)
    dxDrawText("Koszt wprowadzenia zmian wynosi: #F6FF00\n"..przecinek(guiInfo.toPay/100)..'PLN', (sw-400/zoom)/2, (sh-180/zoom)/2, (sw+400/zoom)/2, (sh+210/zoom)/2, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "center", "center", false, false, false, true)

    dxDrawRectangle((sw-400/zoom)/2 + 10/zoom, (sh+210/zoom)/2-50/zoom, 180/zoom, 40/zoom, tocolor(50, 50, 105, 200))
    dxDrawRectangle((sw+400/zoom)/2 - 190/zoom, (sh+210/zoom)/2-50/zoom, 180/zoom, 40/zoom, tocolor(50, 50, 105, 200))
    --dxDrawRectangle(0, sh-130/zoom, sw, 130/zoom, tocolor(30, 30, 65, 255))
    dxDrawText("Odrzuć", (sw-400/zoom)/2 + 10/zoom, (sh+210/zoom)/2-50/zoom, (sw-400/zoom)/2 + 190/zoom, (sh+210/zoom)/2-10/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.big, "center", "center", true, true, false, false)
    dxDrawText("Akceptuj", (sw+400/zoom)/2 - 190/zoom, (sh+210/zoom)/2-50/zoom, (sw+400/zoom)/2 - 10/zoom, (sh+210/zoom)/2-10/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.big, "center", "center", true, true, false, false)
  end

  if #guiInfo.renderGuiList > 0 then
    local k = 0
    for i, v in pairs(guiInfo.renderGuiList) do
      if k < guiInfo.howManyToShow then
        if fileExists("files/icons/objects/"..guiInfo.renderGuiList[guiInfo.menuScroll+k][4]..".png") then
          dxDrawImage(guiInfo.spaceLeft + 140/zoom*(k), sh-125/zoom, 80/zoom, 80/zoom, "files/icons/objects/"..guiInfo.renderGuiList[guiInfo.menuScroll+k][4]..".png", 0, 0, 0, tocolor(255, 255, 255, 255))
        else
          dxDrawImage(guiInfo.spaceLeft + 140/zoom*(k), sh-125/zoom, 80/zoom, 80/zoom, guiInfo.renderGuiList[guiInfo.menuScroll+k][1], 0, 0, 0, tocolor(255, 255, 255, 255))
        end
        dxDrawText("PLN "..guiInfo.renderGuiList[guiInfo.menuScroll+k][5], guiInfo.spaceLeft + 140/zoom*(k), sh-50/zoom, guiInfo.spaceLeft + 80/zoom + 140/zoom*(k), sh, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "center", "center", true, true)

        if isMouseInPosition(guiInfo.spaceLeft + 140/zoom*(k), sh-125/zoom, 80/zoom, 80/zoom) then
          if isCursorShowing( ) then
            local sx, sy = guiGetScreenSize ( )
            local cx, cy = getCursorPosition ( )
            local cx, cy = ( cx * sx ), ( cy * sy )
            dxDrawRectangle(cx, cy-40/zoom, 200/zoom, 40/zoom, tocolor(40, 40, 85, 255), true)
            dxDrawRectangle(cx, cy, 200/zoom, 2/zoom, tocolor(255, 255, 0, 255), true)
            dxDrawText(guiInfo.renderGuiList[guiInfo.menuScroll+k][2], cx, cy-40/zoom, cx+200/zoom, cy, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "center", "center", true, true, true)
          end
        end
      end
      k = k + 1
    end
  end

end

function renderTexutring()
  dxDrawRectangle(sw-320/zoom, (sh-540/zoom)/2, 320/zoom, 540/zoom, tocolor(30, 30, 65, 255))
  dxDrawText("Wybierz texturę", sw-320/zoom, (sh-520/zoom)/2, sw, (sh-540/zoom)/2, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fonts.normal, "center", "top")

  --dxDrawRectangle(sw-320/zoom + 12 + 60, (sh-450/zoom)/2, 80/zoom, 80/zoom, tocolor(255, 255, 255, 255))
  --dxDrawRectangle(sw-320/zoom + 24 + 60 + 90, (sh-450/zoom)/2, 80/zoom, 80/zoom, tocolor(255, 255, 255, 255))
  --dxDrawRectangle(sw-320/zoom + 36 + 180, (sh-410/zoom)/2, 90/zoom, 90/zoom, tocolor(255, 255, 255, 255))
  local actTextures = guiInfo.editingElement:getData("builder:textures") and guiInfo.editingElement:getData("builder:textures") or {"", ""}
  if guiInfo.textureType == "walls" then
    if actTextures[1] == "" then dxDrawImage(sw-320/zoom + 72/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, "files/textures/wall1.png", 0, 0, 0,  tocolor(255, 255, 255, 255)) else dxDrawImage(sw-320/zoom + 72/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, "files/textures/"..actTextures[1]..".jpg", 0, 0, 0,  tocolor(255, 255, 255, 255)) end
    if actTextures[2] == "" then dxDrawImage(sw-320/zoom + 174/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, "files/textures/wall2.png", 0, 0, 0,  tocolor(255, 255, 255, 255)) else dxDrawImage(sw-320/zoom + 174/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, "files/textures/"..actTextures[2]..".jpg", 0, 0, 0,  tocolor(255, 255, 255, 255)) end

    if guiInfo.selectedTextureEditing == 1 then dxDrawBorder(sw-320/zoom + 72/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, 2/zoom, tocolor(255, 255, 255, 255))
    elseif guiInfo.selectedTextureEditing == 2 then dxDrawBorder(sw-320/zoom + 174/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, 2/zoom, tocolor(255, 255, 255, 255))
    end
  elseif guiInfo.textureType == "floor" then
    if actTextures[1] == "" then dxDrawImage(sw-320/zoom + 122/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, "files/textures/floor.png", 0, 0, 0,  tocolor(255, 255, 255, 255)) else dxDrawImage(sw-320/zoom + 122/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, "files/textures/"..actTextures[1]..".jpg", 0, 0, 0,  tocolor(255, 255, 255, 255)) end
    dxDrawBorder(sw-320/zoom + 122/zoom, (sh-450/zoom)/2, 80/zoom, 80/zoom, 2/zoom, tocolor(255, 255, 255, 255))
  end


  local k = 1
  local row = 0
  for i, v in pairs(textures[guiInfo.textureType]) do
    if row < 4 then
      if textures[guiInfo.textureType][guiInfo.texturesScroll+i] then
        if fileExists("files/textures/"..textures[guiInfo.textureType][guiInfo.texturesScroll+i]..".jpg") then
          dxDrawImage(sw-308/zoom + 102/zoom*(k-1), (sh-270/zoom)/2 + 102/zoom*row, 90/zoom, 90/zoom, "files/textures/"..textures[guiInfo.textureType][guiInfo.texturesScroll+i]..".jpg", 0, 0, 0,  tocolor(255, 255, 255, 255))

          if k == 3 then
            k = 0
            row = row + 1
          end
          k = k + 1
        end
      end
    end
  end
end



function useOptionForBuilder(type, val, money)
  if guiInfo.saveInteriorAccept then return end
  if type == "build" then
    if isElement(guiInfo.buildingFurniture) then guiInfo.buildingFurniture:destroy(); guiInfo.buildingFurniture = false end
    if isElement(guiInfo.buildingWall) then
      if val == 1 and guiInfo.modelsID.wall == guiInfo.buildingWall:getModel() then
        guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false
        return
      elseif val == 2 and guiInfo.modelsID.doors == guiInfo.buildingWall:getModel() then
        guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false
        return
      elseif val == 3 and guiInfo.modelsID.wall == guiInfo.buildingWall:getModel() then
        guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false
        return
      end
      guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false
    end

    if val == 1 then
      guiInfo.buildingWall = Object(guiInfo.modelsID.wall, guiInfo.posXdef, guiInfo.posYdef, guiInfo.posZdef + guiInfo.positionCamera[guiInfo.floor]+500)
      guiInfo.buildingWall:setInterior(99)

    elseif val == 2 then
      guiInfo.buildingWall = Object(guiInfo.modelsID.doors, guiInfo.posXdef, guiInfo.posYdef, guiInfo.posZdef + guiInfo.positionCamera[guiInfo.floor]+500)
      guiInfo.buildingWall:setInterior(99)

    elseif val == 3 then
      guiInfo.buildingWall = Object(guiInfo.modelsID.wall, guiInfo.posXdef, guiInfo.posYdef, guiInfo.posZdef + guiInfo.positionCamera[guiInfo.floor]+500)
      guiInfo.buildingWall:setInterior(99)
  end

  elseif type == "furniture" then
    if isElement(guiInfo.buildingWall) then guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false end
    if isElement(guiInfo.buildingFurniture) then
      if guiInfo.buildingFurniture:getModel() == val then
        if isElement(guiInfo.buildingFurniture) then guiInfo.buildingFurniture:destroy(); guiInfo.buildingFurniture = false end
        return

      else
        if isElement(guiInfo.buildingFurniture) then guiInfo.buildingFurniture:destroy(); guiInfo.buildingFurniture = false end
      end
    end


    guiInfo.buildingFurniture = Object(val, guiInfo.posXdef, guiInfo.posYdef, guiInfo.posZdef + guiInfo.positionCamera[guiInfo.floor]+500)
    guiInfo.buildingFurniture:setInterior(99)

    if guiInfo.renderGuiType == "Krzesła" or guiInfo.renderGuiType == "AGD i RTV" then
      guiInfo.buildingObjectZ = 0.3
    else
      guiInfo.buildingObjectZ = 0
    end
  end
end


function openInteriorBuilder(int, idHome, homeBuilded, homePos, oryginalWalls, oryginalFloor, exitPOS)
  setTimer(function()
    setWeather(1)
    local intSize = {int^2, int, int/2}
    posExit = split(homePos, ",")

    guiInfo.uidHome = idHome

    guiInfo.moneyPlayer = getPlayerMoney(localPlayer)
    guiInfo.toPay = 0
    guiInfo.furniture.rotation = 1
    guiInfo.openedMenu = 1
    guiInfo.menuScroll = 1
    guiInfo.texturesScroll = 0

    guiInfo.optionsMenuOpen = false
    guiInfo.selectMenuOpen = false
    guiInfo.testingByPlayer = false
    guiInfo.interiorSize = intSize
    guiInfo.rotFurniture = 0
    guiInfo.exitPOS = split(exitPOS, ",")

    guiInfo.saveInteriorAccept = false

    guiInfo.renderGuiList = {}


    guiInfo.posXdef = posExit[1]
    guiInfo.posYdef = posExit[2]
    guiInfo.posZdef = posExit[3]

    guiInfo.posX = guiInfo.posXdef
    guiInfo.posY = guiInfo.posYdef
    guiInfo.posZ = guiInfo.posZdef

    guiInfo.rot = 270
    guiInfo.floor = 1
    setElementData(localPlayer,'notshowhud',true)
    showPlayerHudComponent("all",false)
    localPlayer:setData("user:blockOpen", true)
    localPlayer:setInterior(99)
    localPlayer:setRotation(0, 0, 270)


    oryginalFloor = fromJSON(oryginalFloor) and fromJSON(oryginalFloor) or {}

    guiInfo.skeleton = {}
    local posNext = Vector3(guiInfo.posX - guiInfo.builderDetails.floorSize*intSize[3], guiInfo.posY - guiInfo.builderDetails.floorSize*intSize[3], guiInfo.posZdef)
    local row = 1
    local obj = 0

    guiInfo.skeleton[1] = Object(guiInfo.modelsID.floor, posNext.x, posNext.y + guiInfo.builderDetails.floorSize*obj, guiInfo.posZdef, 0, 0, 0)
    guiInfo.skeleton[1]:setInterior(99)

    if type(oryginalFloor) == "table" then
      if oryginalFloor[1] then changeTexture(guiInfo.skeleton[1], oryginalFloor[1][1], oryginalFloor[1][2]) end
      if oryginalFloor[1] then guiInfo.skeleton[1]:setData("builder:textures", {oryginalFloor[1][1], oryginalFloor[1][2]}) end
    end

    for i=2, intSize[1]+1 do
      if obj == intSize[2] then
        row = row + 1
        obj = 0
      end
      guiInfo.skeleton[i] = Object(guiInfo.modelsID.floor, posNext.x + guiInfo.builderDetails.floorSize*row, posNext.y + guiInfo.builderDetails.floorSize*obj, guiInfo.posZdef, 0, 0, 0)
      guiInfo.skeleton[i]:setInterior(99)
      guiInfo.skeleton[i]:setData("builder:type", "floor")

      if type(oryginalFloor) == "table" then
        if oryginalFloor[i] then
          changeTexture(guiInfo.skeleton[i], oryginalFloor[i][1], oryginalFloor[i][2])
          guiInfo.skeleton[i]:setData("builder:textures", {oryginalFloor[i][1], oryginalFloor[i][2]})
        end
      end
      obj = obj + 1
    end


    guiInfo.skeletonWalls = {}
    local max = 0
    local obj = 1
    local row = 1
    oryginalWalls = fromJSON(oryginalWalls) and fromJSON(oryginalWalls) or {}

    for i=1, intSize[2]*4 do
      if obj == intSize[2] then
        row = row + 1
        obj = 0
      end
      local dataWall = loadBuildWallData(row, obj, intSize[2])

      if not dataWall then break end
      guiInfo.skeletonWalls[i] = Object(guiInfo.modelsID.wall, posNext.x + dataWall[1], posNext.y + dataWall[2], guiInfo.posZdef + guiInfo.builderDetails.wallHeight/2, 0, 0, dataWall[3])
      guiInfo.skeletonWalls[i]:setInterior(99)
      obj = obj + 1

      if type(oryginalWalls) == "table" then
        if oryginalWalls[i] then
          changeTexture(guiInfo.skeletonWalls[i], oryginalWalls[i][1], oryginalWalls[i][2])
          guiInfo.skeletonWalls[i]:setData("builder:textures", {oryginalWalls[i][1], oryginalWalls[i][2]})
        end
      end

      max = i
    end
    buildEntrence(posNext.x, posNext.y + guiInfo.builderDetails.floorSize*obj, guiInfo.posZdef, oryginalWalls, max)
    guiInfo.visibleWalls = true

    guiInfo.defPosForPlayer = {posNext.x, posNext.y, guiInfo.posZdef + 1}
    localPlayer:setPosition(posNext.x, posNext.y, guiInfo.posZdef + 1.1)
    showCursor(true)
    showChat(false)


    guiInfo.buildedObjects = {}
    if homeBuilded then
      local homeObjects = fromJSON(homeBuilded)
      if type(homeObjects) == "table" then
        for i, v in pairs(homeObjects) do
          local obj = Object(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
          obj:setInterior(99)
          obj:setData("builder:textures", {v[8], v[9]})
          obj:setCollisionsEnabled(true)

          changeTexture(obj, v[8], v[9])

          table.insert(guiInfo.buildedObjects, obj)
        end
      end
    end


    setTimer(function()
      addEventHandler("onClientRender", root, render)
      addEventHandler("onClientClick", root, click)
      addEventHandler("onClientKey", root, key)
    end, 3000, 1)
  end, 1000, 1)
end
addEvent("interiorsBuilderOpen", true)
addEventHandler("interiorsBuilderOpen", root, openInteriorBuilder)


function closeInteriorBuilder()

  setTimer(function()
    if isElement(guiInfo.buildingWall) then guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false end
    if isElement(guiInfo.buildingFurniture) then guiInfo.buildingFurniture:destroy(); guiInfo.buildingFurniture = false end

    removeEventHandler("onClientRender", root, render)
    removeEventHandler("onClientRender", root, renderInfo)
    removeEventHandler("onClientClick", root, click)
    removeEventHandler("onClientKey", root, key)
    localPlayer:setInterior(0)
    localPlayer:setPosition(guiInfo.exitPOS[1], guiInfo.exitPOS[2], guiInfo.exitPOS[3])

    setCameraTarget(localPlayer)

    showCursor(false)
    showChat(true)

    for i, v in pairs(guiInfo.skeletonWalls) do
      if isElement(v) then v:destroy() end
    end
    for i, v in pairs(guiInfo.skeleton) do
      if isElement(v) then v:destroy() end
    end
    for i, v in pairs(guiInfo.buildedObjects) do
      if isElement(v) then v:destroy() end
    end
    if guiInfo.roof then
      for i, v in pairs(guiInfo.roof) do
        if isElement(v) then v:destroy() end
      end
    end
    for i, v in pairs(guiInfo.shaders.builded) do
      if isElement(v[1]) then v[1]:destroy() end
      if isElement(v[2]) then v[2]:destroy() end
    end

    setTimer(function()
      setElementData(localPlayer,'notshowhud',false)
      showPlayerHudComponent("all",false)
      showPlayerHudComponent("radar",true)
      localPlayer:setData("user:blockOpen", nil)

      localPlayer:setData("player:positionOnQuit", false)
    end, 100, 1)
  end, 1000, 1)
end


function changeTexture(obj, txt1, txt2)
  local textName = getTextName(obj)
  if type(textName) == "table" then
    if not guiInfo.shaders.builded[obj] then guiInfo.shaders.builded[obj] = {dxCreateShader( "files/shaders/replace.fx"), dxCreateShader( "files/shaders/replace.fx")} end
    if txt1 ~= "" then
      if not guiInfo.shaders.buildedTextures[txt1] then guiInfo.shaders.buildedTextures[txt1] = dxCreateTexture("files/textures/"..txt1..".jpg", "dxt1", true, "clamp") end
      guiInfo.shaders.builded[obj][1]:setValue("gTexture", guiInfo.shaders.buildedTextures[txt1])
      guiInfo.shaders.builded[obj][1]:applyToWorldTexture(textName[1], obj)
    end

    if txt2 ~= "" then
      if not guiInfo.shaders.buildedTextures[txt2] then guiInfo.shaders.buildedTextures[txt2] = dxCreateTexture("files/textures/"..txt2..".jpg", "dxt1", true, "clamp") end
      guiInfo.shaders.builded[obj][2]:setValue("gTexture", guiInfo.shaders.buildedTextures[txt2])
      guiInfo.shaders.builded[obj][2]:applyToWorldTexture(textName[2], obj)
    end
  end
end


function saveBuildInterior()
  if not guiInfo.saveInteriorAccept then
    guiInfo.saveInteriorAccept = true

  elseif guiInfo.saveInteriorAccept then
    local money = getPlayerMoney(localPlayer)
    if money < guiInfo.toPay then
      exports.nrpg_interface:showPlayerNotification('Nie posiadasz tyle pieniędzy', 'error')
      return
    end

    local buildedTable = {}
    for i, v in pairs(guiInfo.buildedObjects) do
      local pos = Vector3(v:getPosition())
      local rot = Vector3(v:getRotation())
      local textures = v:getData("builder:textures") and v:getData("builder:textures") or {"", ""}
      table.insert(buildedTable, {v:getModel(), pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, textures[1], textures[2]})
    end

    local buildedWalls = {}
    for i, v in pairs(guiInfo.skeletonWalls) do
      local textures = v:getData("builder:textures") and v:getData("builder:textures") or {"", ""}
      table.insert(buildedWalls, {textures[1], textures[2]})
    end

    local buildedFloor = {}
    for i, v in pairs(guiInfo.skeleton) do
      local textures = v:getData("builder:textures") and v:getData("builder:textures") or {"", ""}
      table.insert(buildedFloor, {textures[1], textures[2]})
    end

    local buildedObjectsJSON = toJSON(buildedTable)
    local wallsToJSON = toJSON(buildedWalls)
    local floorToJSON = toJSON(buildedFloor)
    triggerServerEvent("interiorsSaveAndPay", root, localPlayer, guiInfo.uidHome, guiInfo.toPay, buildedObjectsJSON, wallsToJSON, floorToJSON)

  end
end


function setPlayerTestingInterior()
  if guiInfo.testingByPlayer then
    guiInfo.testingByPlayer = false
    setElementData(localPlayer,'notshowhud',true)
    showPlayerHudComponent("all",false)
    localPlayer:setInterior(99)
    localPlayer:setRotation(0, 0, 270)

    addEventHandler("onClientRender", root, render)
    removeEventHandler("onClientRender", root, renderInfo)
    addEventHandler("onClientClick", root, click)
    showCursor(true)

    localPlayer:setPosition(guiInfo.defPosForPlayer[1], guiInfo.defPosForPlayer[2], guiInfo.defPosForPlayer[3])

    for i, v in pairs(guiInfo.roof) do
      if isElement(v) then v:destroy() end
    end

    if not guiInfo.visibleWalls then
      for i, v in pairs(guiInfo.skeletonWalls) do
        if isElement(v) then v:setAlpha(0) end
      end
    end

  else
    if isElement(guiInfo.buildingWall) then guiInfo.buildingWall:destroy(); guiInfo.buildingWall = false end

    guiInfo.roof = {}
    local posNext = Vector3(guiInfo.posXdef - guiInfo.builderDetails.floorSize*guiInfo.interiorSize[3], guiInfo.posYdef - guiInfo.builderDetails.floorSize*guiInfo.interiorSize[3], guiInfo.posZdef + guiInfo.builderDetails.wallHeight)
    local row = 1
    local obj = 0

    guiInfo.roof[0] = Object(guiInfo.modelsID.floor, posNext.x, posNext.y + guiInfo.builderDetails.floorSize*obj, posNext.z, 0, 0, 0)
    guiInfo.roof[0]:setInterior(99)

    for i=1, guiInfo.interiorSize[1] do
      if obj == guiInfo.interiorSize[2] then
        row = row + 1
        obj = 0
      end
      guiInfo.roof[i] = Object(guiInfo.modelsID.floor, posNext.x + guiInfo.builderDetails.floorSize*row, posNext.y + guiInfo.builderDetails.floorSize*obj, posNext.z, 0, 0, 0)
      guiInfo.roof[i]:setInterior(99)
      changeTexture(guiInfo.roof[i],179,179)
      obj = obj + 1
    end

    setTimer(function()
      setCameraTarget(localPlayer)
      guiInfo.testingByPlayer = true

      guiInfo.optionsMenuOpen = false
      guiInfo.selectMenuOpen = false
      showPlayerHudComponent("all",false)
      addEventHandler("onClientRender", root, renderInfo)
      removeEventHandler("onClientRender", root, render)
      removeEventHandler("onClientClick", root, click)
      showCursor(false)
    end, 50, 1)

    if not guiInfo.visibleWalls then
      for i, v in pairs(guiInfo.skeletonWalls) do
        if isElement(v) then v:setAlpha(255) end
      end
    end
  end
end


function interiorSavedSuccesfull()
  guiInfo.saveInteriorAccept = false
  guiInfo.toPay = 0


  for i, v in pairs(guiInfo.buildedObjects) do
    v:setData("builder:price", false)
  end

  guiInfo.moneyPlayer = getPlayerMoney(localPlayer)
end
addEvent("interiorSavedSuccesfull", true)
addEventHandler("interiorSavedSuccesfull", root, interiorSavedSuccesfull)


---- FUNCTIONS ----
function loadBuildWallData(row, obj, size)
  if row == 1 then
    return {guiInfo.builderDetails.floorSize/2, guiInfo.builderDetails.floorSize * obj, 90}
  elseif row == 2 then
    return {guiInfo.builderDetails.floorSize * (obj+1), guiInfo.builderDetails.floorSize * size - guiInfo.builderDetails.floorSize/2, 0}
  elseif row == 3 then
    return {guiInfo.builderDetails.floorSize * size + guiInfo.builderDetails.floorSize/2, guiInfo.builderDetails.floorSize * (obj), 270}
  elseif row == 4 then
    return {guiInfo.builderDetails.floorSize * (obj+1), -(guiInfo.builderDetails.floorSize/2), 180}
  end
end

function buildEntrence(x, y, z, oryginalWalls)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.wall, x, y + guiInfo.builderDetails.floorSize/2, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 0)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(99)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end

  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.wall, x - guiInfo.builderDetails.floorSize/2, y, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 90)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(99)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end

  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.wall, x, y - guiInfo.builderDetails.floorSize/2, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 180)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(99)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end

  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.doors, x + guiInfo.builderDetails.floorSize/2, y, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 90)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(99)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end
end

function moveCamera()
  if isElement(guiInfo.editingElement) then return end
  local cx,cy,cz,ctx,cty,ctz = getCameraMatrix()
  ctx,cty = ctx-cx,cty-cy
  local timeslice = 0.1
  local mult = timeslice/math.sqrt(ctx*ctx+cty*cty)
  ctx,cty = ctx*mult,cty*mult
  if getKeyState("w") then guiInfo.posX,guiInfo.posY = guiInfo.posX+ctx,guiInfo.posY+cty end
  if getKeyState("s") then guiInfo.posX,guiInfo.posY = guiInfo.posX-ctx,guiInfo.posY-cty end
  if getKeyState("a") then guiInfo.posX,guiInfo.posY = guiInfo.posX-cty,guiInfo.posY+ctx end
  if getKeyState("d") then guiInfo.posX,guiInfo.posY = guiInfo.posX+cty,guiInfo.posY-ctx end
end

function moveObject()
  if not guiInfo.editingElement or not isElement(guiInfo.editingElement) then return end
  if not guiInfo.editingElementCanChangePos then return end
  local posObj = Vector3(guiInfo.editingElement:getPosition())
  local rotObj = Vector3(guiInfo.editingElement:getRotation())
  local cx,cy,cz,ctx,cty,ctz = getCameraMatrix()
  ctx,cty = ctx-cx,cty-cy
  local timeslice = 0.02
  local mult = timeslice/math.sqrt(ctx*ctx+cty*cty)
  ctx,cty = ctx*mult,cty*mult
  if getKeyState("w") then posObj.x,posObj.y = posObj.x+ctx,posObj.y+cty end
  if getKeyState("s") then posObj.x,posObj.y = posObj.x-ctx,posObj.y-cty end
  if getKeyState("a") then posObj.x,posObj.y = posObj.x-cty,posObj.y+ctx end
  if getKeyState("d") then posObj.x,posObj.y = posObj.x+cty,posObj.y-ctx end
  if getKeyState("arrow_u") then posObj.z = posObj.z+0.005 end
  if getKeyState("arrow_d") then posObj.z = posObj.z-0.005 end

  if getKeyState("arrow_l") then rotObj.z = rotObj.z+0.3 end
  if getKeyState("arrow_r") then rotObj.z = rotObj.z-0.3 end

  guiInfo.editingElement:setPosition(posObj.x, posObj.y, posObj.z)
  guiInfo.editingElement:setRotation(rotObj.x, rotObj.y, rotObj.z)
end







function getTextName(obj)
  local model = obj:getModel()
  if model == guiInfo.modelsID.wall then
    return {"wall1", "wall2"}
  elseif model == guiInfo.modelsID.floor then
    return {"floor", "wall2"} -- zmienić!
  elseif model == guiInfo.modelsID.doors then
    return {"wall1", "wall2"}

  else
    return false
  end
end


---- UTILS ----
function drawPositionLines(element)
  local pos = Vector3(element:getPosition())
  dxDrawLine3D(pos, pos.x+1.5, pos.y, pos.z, tocolor(255, 0, 0, 255), 2)
  dxDrawLine3D(pos, pos.x, pos.y+1.5, pos.z, tocolor(0, 255, 0, 255), 2)
  dxDrawLine3D(pos, pos.x, pos.y, pos.z+1.5, tocolor(0, 0, 255, 255), 2)
end


function dxDrawBorder(x, y, w, h, size, color)
	size = size or 2;

	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end


function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end