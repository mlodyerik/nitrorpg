sw,sh = guiGetScreenSize()

local zoom = 1
local baseX = 1280
local minZoom = 2
if sw < baseX then
  zoom = math.min(minZoom, baseX/sw)
end

local guiInfo = {}
guiInfo.modelsID = {
  wall = 1866,
  floor = 1868,
  doors = 1867,
}

guiInfo.shaders = {
  builded = {},
  buildedTextures = {},
}

guiInfo.positionCamera = {
  [1] = 97,
  [2] = 100,
  [3] = 103,
}

guiInfo.builderDetails = {
  floorSize = 3,
  wallHeight = 3,
}

function interiorLoadObjects(int, idHome, homeBuilded, posExit, posTP, oryginalWalls, oryginalFloor)
  setWeather(1)
  local intSize = {int^2, int, int/2}

  posExit = split(posExit, ",")
  guiInfo.uidHome = idHome
  guiInfo.markerExitTP = split(posTP, ",")

  guiInfo.posXldefL = posExit[1]
  guiInfo.posYldefL = posExit[2]
  guiInfo.posZldefL = posExit[3]

  guiInfo.posXl = guiInfo.posXldefL
  guiInfo.posYl = guiInfo.posYldefL
  guiInfo.posZl = guiInfo.posZldefL

  guiInfo.rot = 270
  guiInfo.floor = 1

  oryginalFloor = fromJSON(oryginalFloor) and fromJSON(oryginalFloor) or {}

  guiInfo.skeleton = {}
  local posNext = Vector3(guiInfo.posXldefL - guiInfo.builderDetails.floorSize*intSize[3], guiInfo.posYldefL - guiInfo.builderDetails.floorSize*intSize[3], guiInfo.posZldefL)
  local row = 1
  local obj = 0

  guiInfo.skeleton[1] = Object(guiInfo.modelsID.floor, posNext.x, posNext.y + guiInfo.builderDetails.floorSize*obj, guiInfo.posZldefL, 0, 0, 0)
  guiInfo.skeleton[1]:setInterior(posExit[4])
  guiInfo.skeleton[1]:setDimension(posExit[5])

  if type(oryginalFloor) == "table" then
    if oryginalFloor[1] then changeTexture(guiInfo.skeleton[1], oryginalFloor[1][1], oryginalFloor[1][2]) end
    if oryginalFloor[1] then guiInfo.skeleton[1]:setData("builder:textures", {oryginalFloor[1][1], oryginalFloor[1][2]}) end
  end

  for i=2, intSize[1]+1 do
    if obj == intSize[2] then
      row = row + 1
      obj = 0
    end
    guiInfo.skeleton[i] = Object(guiInfo.modelsID.floor, posNext.x + guiInfo.builderDetails.floorSize*row, posNext.y + guiInfo.builderDetails.floorSize*obj, guiInfo.posZldefL, 0, 0, 0)
    guiInfo.skeleton[i]:setInterior(posExit[4])
    guiInfo.skeleton[i]:setDimension(posExit[5])
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
  local obj = 1
  local row = 1
  oryginalWalls = fromJSON(oryginalWalls) and fromJSON(oryginalWalls) or {}

  for i=1, intSize[2]*4 do
    if obj == intSize[2] then
      row = row + 1
      obj = 0
    end
    local dataWall = loadBuildWallDataLoad(row, obj, intSize[2])

    if not dataWall then break end
    guiInfo.skeletonWalls[i] = Object(guiInfo.modelsID.wall, posNext.x + dataWall[1], posNext.y + dataWall[2], guiInfo.posZldefL + guiInfo.builderDetails.wallHeight/2, 0, 0, dataWall[3])
    guiInfo.skeletonWalls[i]:setInterior(posExit[4])
    guiInfo.skeletonWalls[i]:setDimension(posExit[5])
    obj = obj + 1

    if oryginalWalls[i] then
      changeTexture(guiInfo.skeletonWalls[i], oryginalWalls[i][1], oryginalWalls[i][2])
      guiInfo.skeletonWalls[i]:setData("builder:textures", {oryginalWalls[i][1], oryginalWalls[i][2]})
    end
  end
  buildEntrenceLoad(posNext.x, posNext.y + guiInfo.builderDetails.floorSize*obj, guiInfo.posZldefL, posExit[4], posExit[5], oryginalWalls)


  guiInfo.defPosForPlayer = {posNext.x, posNext.y, guiInfo.posZldefL + 1}
  --localPlayer:setPosition(posNext.x, posNext.y, guiInfo.posZldefL + 1)

  triggerServerEvent("setPlayerInteriorPos", localPlayer, localPlayer, {posNext.x, posNext.y, guiInfo.posZldefL + 1, posExit[4], posExit[5]})

  guiInfo.markerExit = Marker(posNext.x, posNext.y, guiInfo.posZldefL+0.1, "cylinder", 1, 255, 255, 0, 55)
  guiInfo.markerExit:setInterior(posExit[4])
  guiInfo.markerExit:setDimension(posExit[5])

  addEventHandler("onClientMarkerHit", guiInfo.markerExit, enter)
  addEventHandler("onClientMarkerLeave", guiInfo.markerExit, leave)


  guiInfo.roof = {}
  local posNext = Vector3(guiInfo.posXldefL - guiInfo.builderDetails.floorSize*intSize[3], guiInfo.posYldefL - guiInfo.builderDetails.floorSize*intSize[3], guiInfo.posZldefL + guiInfo.builderDetails.wallHeight)
  local row = 1
  local obj = 0

  guiInfo.roof[0] = Object(guiInfo.modelsID.floor, posNext.x, posNext.y + guiInfo.builderDetails.floorSize*obj, posNext.z, 0, 0, 0)
  guiInfo.roof[0]:setInterior(posExit[4])
  guiInfo.roof[0]:setDimension(posExit[5])

  for i=1, intSize[1] do
    if obj == intSize[2] then
      row = row + 1
      obj = 0
    end
    guiInfo.roof[i] = Object(guiInfo.modelsID.floor, posNext.x + guiInfo.builderDetails.floorSize*row, posNext.y + guiInfo.builderDetails.floorSize*obj, posNext.z, 0, 0, 0)
    guiInfo.roof[i]:setInterior(posExit[4])
    guiInfo.roof[i]:setDimension(posExit[5])
    guiInfo.roof[i]:setRotation(180, 0, 0)
    changeTexture(guiInfo.roof[i], 179,179)
    obj = obj + 1
  end


  guiInfo.buildedObjects = {}
  if homeBuilded then
    local homeObjects = fromJSON(homeBuilded) and fromJSON(homeBuilded) or {}
    for i, v in pairs(homeObjects) do
      local obj = Object(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
      obj:setInterior(posExit[4])
      obj:setDimension(posExit[5])
      obj:setData("builder:textures", {v[8], v[9]})

      changeTexture(obj, v[8], v[9])

      table.insert(guiInfo.buildedObjects, obj)
    end
  end

  setTimer(function()
    setElementData(localPlayer,'notshowhud',false)
    showPlayerHudComponent("all",false)
    setPlayerHudComponentVisible('radar',true)
    localPlayer:setData("user:blockOpen", nil)
    toggleControl("fire", false)
    toggleControl("aim_weapon", false)
    toggleControl("vehicle_fire", false)
    toggleControl("vehicle_secondary_fire", false)
  end, 100, 1)

end
addEvent("interiorLoadObjects", true)
addEventHandler("interiorLoadObjects", root, interiorLoadObjects)


function closeInteriorLoader()
  if isElement(guiInfo.markerExit) then guiInfo.markerExit:destroy() end

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
    localPlayer:setData("user:blockOpen", nil)
    setElementData(localPlayer,'notshowhud',false)
    showPlayerHudComponent("all",false)
    setPlayerHudComponentVisible('radar',true)
  end, 100, 1)
end


function enter(hitPlayer)
  if hitPlayer ~= localPlayer then return end
  bindKey("e", "down", exit)
  exports.nrpg_interface:showPlayerNotification('Aby wyjść nacśnij E', 'info')
end

function leave(hitPlayer)
  if hitPlayer ~= localPlayer then return end
  unbindKey("e", "down", exit)
end

function exit()
  unbindKey("e", "down", exit)

  setTimer(closeInteriorLoader, 1200, 1)

  setTimer(function()
    localPlayer:setData("user:inHome", false)
    triggerServerEvent("setPlayerInteriorPos", localPlayer, localPlayer, guiInfo.markerExitTP)
  end, 2200, 1)

  setTimer(function()
    localPlayer:setData("player:positionOnQuit", false)
  end, 3000, 1)
end
addEvent("removePlayerFromBuildedInterior", true)
addEventHandler("removePlayerFromBuildedInterior", root, exit)

---- FUNCTIONS ----
function loadBuildWallDataLoad(row, obj, size)
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

function buildEntrenceLoad(x, y, z, int, dim, oryginalWalls)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.wall, x, y + guiInfo.builderDetails.floorSize/2, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 0)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(int)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setDimension(dim)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end

  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.wall, x - guiInfo.builderDetails.floorSize/2, y, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 90)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(int)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setDimension(dim)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end

  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.wall, x, y - guiInfo.builderDetails.floorSize/2, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 180)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(int)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setDimension(dim)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end

  guiInfo.skeletonWalls[#guiInfo.skeletonWalls + 1] = Object(guiInfo.modelsID.doors, x + guiInfo.builderDetails.floorSize/2, y, z + guiInfo.builderDetails.wallHeight/2, 0, 0, 90)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setInterior(int)
  guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setDimension(dim)
  if oryginalWalls[#guiInfo.skeletonWalls] then
    changeTexture(guiInfo.skeletonWalls[#guiInfo.skeletonWalls], oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2])
    guiInfo.skeletonWalls[#guiInfo.skeletonWalls]:setData("builder:textures", {oryginalWalls[#guiInfo.skeletonWalls][1], oryginalWalls[#guiInfo.skeletonWalls][2]})
  end
end
