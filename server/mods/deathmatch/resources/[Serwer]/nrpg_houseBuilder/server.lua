function interiorsSaveAndPay(plr, homeID, toPay, builded, walls, floor)
  local money = getPlayerMoney(plr)
  if money < toPay then
    outputChatBox("Nie posiadasz wystarczającej ilości pieniędzy",plr)
    return
  end

  local querryCheckHome = exports['nrpg_db']:dbGet("SELECT name FROM `pystories_houses` WHERE `owner` = ? AND `id` = ?", getElementData(plr,'player:sid'), homeID)
  if querryCheckHome and #querryCheckHome > 0 then

    local querrySaveHome = exports['nrpg_db']:dbSet(string.format("UPDATE pystories_houses SET interiorObjects = '%s', interiorWalls = '%s', interiorFloor = '%s' WHERE id=%d", builded, walls, floor, homeID))
    if takePlayerMoney(plr, toPay) then
      triggerClientEvent(plr, "interiorSavedSuccesfull", plr)
      outputChatBox('Dom został pomyślnie zapisany',plr)
    end

  else
    outputChatBox('Błąd #01',plr)
  end
end
addEvent("interiorsSaveAndPay", true)
addEventHandler("interiorsSaveAndPay", root, interiorsSaveAndPay)


function setPlayerInteriorPos(plr, posExit)
  plr:setPosition(tonumber(posExit[1]), tonumber(posExit[2]), tonumber(posExit[3]))
  plr:setInterior(tonumber(posExit[4]))
  plr:setDimension(tonumber(posExit[5]))
  plr:setRotation(0, 0, 270)
end
addEvent("setPlayerInteriorPos", true)
addEventHandler("setPlayerInteriorPos", root, setPlayerInteriorPos)
