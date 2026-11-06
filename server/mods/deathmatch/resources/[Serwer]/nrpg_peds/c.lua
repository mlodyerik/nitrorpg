main = {

    peds = {

        {"Basia", "Witam w przebieralni", 91, 1542.17, -626.11, 453.30, 0, 0, 270, 0, 2137},

    },

    cachePeds = {},

}

for i,v in ipairs(main.peds) do
    main.cachePeds[i] = createPed(v[3], v[4], v[5], v[6])
    setElementRotation(main.cachePeds[i], v[7], v[8], v[9], "default", true)
    setElementInterior(main.cachePeds[i], v[10])
    setElementDimension(main.cachePeds[i], v[11])
    setElementFrozen(main.cachePeds[i], true)

    setElementData(main.cachePeds[i], "ped:customData", {name=v[1], desc=v[2]})
    setPedStat(main.cachePeds[i], 21, 1000 )
end

addEventHandler("onClientRender", root, function()
    local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix()
      px, py, pz = math.floor(px), math.floor(py), math.floor(pz)

      for klucz, v in ipairs(main.cachePeds) do
         tx, ty, tz = getPedBonePosition(v,8)
         dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz);
         setElementHealth(v, 100)
         if dist < 10.0 then
            if getElementAlpha(v) ~= 0 then
               local sx, sy, sz = getPedBonePosition( v, 8 )
               local x, y = getScreenFromWorldPosition( sx, sy, sz + 0.55 )
               if x then 

                    x = math.max(2, x)
                    y = math.max(2, y)

                    local pedData = getElementData(v, "ped:customData")
                    dxDrawText('('..klucz..') '..pedData.name:gsub('#%x%x%x%x%x%x',''), x+1, y+1, x+1, y+1, tocolor(0, 0, 0, 255), 1, exports.nrpg_interface:getGUIFont("money10"), 'center', 'center', false,false,false,true,true)
                    dxDrawText('#C6C6C6('..klucz..')#ffffff '..pedData.name:gsub('#%x%x%x%x%x%x',''), x, y, x, y, tocolor(255, 255, 255, 255), 1, exports.nrpg_interface:getGUIFont("money10"), 'center', 'center', false,false,false,true,true)

                    dxDrawText(pedData.desc, x+1, y+39, x+1, y+1, tocolor(0, 0, 0, 255), 0.55, exports.nrpg_interface:getGUIFont("normal15"), 'center', 'center', false,false,false,true,true)
                    dxDrawText(pedData.desc, x, y+38, x, y, tocolor(255, 175, 0, 255), 0.55, exports.nrpg_interface:getGUIFont("normal15"), 'center', 'center', false,false,false,true,true)
               end
            end
        end
    end
end)