local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1920
local minZoom = 2

if sx < baseX then
  zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
	open = false,

	x = (sx-700/zoom)/2,
	y = (sy-400/zoom)/2,
	width = 700/zoom,
	height = 400/zoom,

	font = dxCreateFont("files/font.ttf", 14),
	fontB = dxCreateFont("files/font.ttf", 16),
	fontX = dxCreateFont("files/font.ttf", 18),
}

function render()
	dxDrawRectangle(guiInfo.x, guiInfo.y, guiInfo.width, guiInfo.height, tocolor(15, 15, 35, 255))
	dxDrawRectangle(guiInfo.x, guiInfo.y + 50/zoom, guiInfo.width, 2, tocolor(255, 255, 0, 255))

  dxDrawText(guiInfo.houseInfo.name.." (ID: "..guiInfo.houseInfo.id..")", guiInfo.x, guiInfo.y + 10/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")

	if isCursorInPosition(guiInfo.x+guiInfo.width-30/zoom, guiInfo.y, 30/zoom, 30/zoom) then
		dxDrawRectangle(guiInfo.x+guiInfo.width-30/zoom, guiInfo.y, 30/zoom, 30/zoom, tocolor(140, 13, 16, 255))
		dxDrawText("x", guiInfo.x+guiInfo.width-31/zoom, guiInfo.y, guiInfo.x+guiInfo.width, guiInfo.y+26/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontX, "center", "center")
	else
		dxDrawRectangle(guiInfo.x+guiInfo.width-30/zoom, guiInfo.y, 30/zoom, 30/zoom, tocolor(80, 13, 16, 255))
		dxDrawText("x", guiInfo.x+guiInfo.width-31/zoom, guiInfo.y, guiInfo.x+guiInfo.width, guiInfo.y+26/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontX, "center", "center")
	end

  if guiInfo.houseMenu == "menu" then
  	dxDrawText("Właściciel:   "..(tonumber(guiInfo.houseInfo.owner) == 0 and "Brak" or guiInfo.houseInfo.ownerName), guiInfo.x, guiInfo.y + 68/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")
  	dxDrawText("Koszt:   "..guiInfo.houseInfo.price.." PLN/dzień", guiInfo.x, guiInfo.y + 98/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")
  	dxDrawText("Wielkość:   "..guiInfo.houseInfo.size.."x"..guiInfo.houseInfo.size, guiInfo.x, guiInfo.y + 128/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")
  	dxDrawText("Ważny do:   "..guiInfo.houseInfo.date, guiInfo.x, guiInfo.y + 158/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")

    if isCursorInPosition(guiInfo.x + 85/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom) then
      dxDrawImage(guiInfo.x + 85/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/enter.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 85/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/enter.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if isCursorInPosition(guiInfo.x + 290/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom) then
      dxDrawImage(guiInfo.x + 290/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/buy.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 290/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/buy.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if localPlayer:getData("player:sid") ~= guiInfo.houseInfo.owner then
      dxDrawImage(guiInfo.x + 495/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/settings.png", 0, 0, 0, tocolor(100, 100, 100, 255))
    else
      if isCursorInPosition(guiInfo.x + 495/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom) then
        dxDrawImage(guiInfo.x + 495/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/settings.png", 0, 0, 0, tocolor(255, 255, 0, 255))
      else
        dxDrawImage(guiInfo.x + 495/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom, "files/images/settings.png", 0, 0, 0, tocolor(200, 200, 200, 255))
      end
    end

  elseif guiInfo.houseMenu == "settings" then
    dxDrawText("Opcje domu:", guiInfo.x, guiInfo.y + 68/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")

    if isCursorInPosition(guiInfo.x + 85/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom) then
      dxDrawImage(guiInfo.x + 85/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom, guiInfo.houseInfo.locked == 1 and "files/images/locked.png" or "files/images/unlocked.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 85/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom, guiInfo.houseInfo.locked == 1 and "files/images/locked.png" or "files/images/unlocked.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if isCursorInPosition(guiInfo.x + 290/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom) then
      dxDrawImage(guiInfo.x + 290/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom, "files/images/rent.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 290/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom, "files/images/rent.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if isCursorInPosition(guiInfo.x + 495/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom) then
      dxDrawImage(guiInfo.x + 495/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom, "files/images/edit.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 495/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom, "files/images/edit.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if isCursorInPosition(guiInfo.x + 318/zoom, guiInfo.y + 320/zoom, 64/zoom, 64/zoom) then
      dxDrawImage(guiInfo.x + 314/zoom, guiInfo.y + 320/zoom, 67/zoom, 64/zoom, "files/images/back.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 314/zoom, guiInfo.y + 320/zoom, 67/zoom, 64/zoom, "files/images/back.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end

    dxDrawText("Zamknij/Otwórz", guiInfo.x + 85/zoom, guiInfo.y + 270/zoom, guiInfo.x + 205/zoom, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")
    dxDrawText("Edytuj członków", guiInfo.x + 290/zoom, guiInfo.y + 270/zoom, guiInfo.x + 410/zoom, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")
    dxDrawText("Edytuj wnętrze", guiInfo.x + 495/zoom, guiInfo.y + 270/zoom, guiInfo.x + 615/zoom, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")

  elseif guiInfo.houseMenu == "buy" then
    dxDrawText("Płatność za dom:", guiInfo.x, guiInfo.y + 68/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")
    dxDrawText("Koszt: "..guiInfo.houseInfo.price.." PLN/dzień", guiInfo.x, guiInfo.y + 105/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "top")

    if tonumber(guiGetText(guiInfo.houseBuyTime)) ~= nil then
      dxDrawText("Do zapłaty: "..tonumber(guiGetText(guiInfo.houseBuyTime)) * tonumber(guiInfo.houseInfo.price)..' PLN', guiInfo.x, guiInfo.y + 270/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "top")
    else
      dxDrawText("Do zapłaty: 0 PLN", guiInfo.x, guiInfo.y + 270/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "top")
    end

    if isCursorInPosition(guiInfo.x + 318/zoom, guiInfo.y + 320/zoom, 64/zoom, 64/zoom) then
      dxDrawImage(guiInfo.x + 314/zoom, guiInfo.y + 320/zoom, 67/zoom, 64/zoom, "files/images/back.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 314/zoom, guiInfo.y + 320/zoom, 67/zoom, 64/zoom, "files/images/back.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if isCursorInPosition(guiInfo.x + 250/zoom, guiInfo.y + 220/zoom, 200/zoom, 40/zoom) then
      dxDrawRectangle(guiInfo.x + 250/zoom, guiInfo.y + 220/zoom, 200/zoom, 40/zoom, tocolor(30, 30, 65, 255))
    else
      dxDrawRectangle(guiInfo.x + 250/zoom, guiInfo.y + 220/zoom, 200/zoom, 40/zoom, tocolor(20, 20, 45, 255))
    end
    dxDrawText("Zapłać", guiInfo.x + 250/zoom, guiInfo.y + 220/zoom, guiInfo.x + 450/zoom, guiInfo.y + 260/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "center")

  elseif guiInfo.houseMenu == "rent" then
    dxDrawText("Współlokatorzy:", guiInfo.x, guiInfo.y + 68/zoom, guiInfo.x+guiInfo.width, guiInfo.y+guiInfo.height, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.fontB, "center", "top")

    local k = 0
    local row = 0
    for i=1, 6 do
      if i == guiInfo.houseMenuSelected then
        dxDrawRectangle(guiInfo.x+33/zoom + 333/zoom*row, guiInfo.y + 108/zoom + 45/zoom*k, 300/zoom, 40/zoom, tocolor(30, 30, 65, 255))
      else
        dxDrawRectangle(guiInfo.x+33/zoom + 333/zoom*row, guiInfo.y + 108/zoom + 45/zoom*k, 300/zoom, 40/zoom, tocolor(20, 20, 45, 255))
      end
      dxDrawText(guiInfo.houseInfo.rent[i] and guiInfo.houseInfo.rent[i] or "Brak", guiInfo.x+33/zoom + 333/zoom*row, guiInfo.y + 108/zoom + 45/zoom*k, guiInfo.x+333/zoom + 333/zoom*row, guiInfo.y + 148/zoom + 45/zoom*k, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "center")
      k = k + 1
      if k == 3 then
        row = row + 1
        k = 0
      end
    end

    if isCursorInPosition(guiInfo.x + 318/zoom, guiInfo.y + 320/zoom, 64/zoom, 64/zoom) then
      dxDrawImage(guiInfo.x + 314/zoom, guiInfo.y + 320/zoom, 67/zoom, 64/zoom, "files/images/back.png", 0, 0, 0, tocolor(255, 255, 0, 255))
    else
      dxDrawImage(guiInfo.x + 314/zoom, guiInfo.y + 320/zoom, 67/zoom, 64/zoom, "files/images/back.png", 0, 0, 0, tocolor(200, 200, 200, 255))
    end
    if isCursorInPosition(guiInfo.x+366/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom) then
      dxDrawRectangle(guiInfo.x+366/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom, tocolor(30, 30, 65, 255))
    else
      dxDrawRectangle(guiInfo.x+366/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom, tocolor(20, 20, 45, 255))
    end
    if isCursorInPosition(guiInfo.x+521/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom) then
      dxDrawRectangle(guiInfo.x+521/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom, tocolor(30, 30, 65, 255))
    else
      dxDrawRectangle(guiInfo.x+521/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom, tocolor(20, 20, 45, 255))
    end
    dxDrawText("Dodaj", guiInfo.x+366/zoom, guiInfo.y + 263/zoom, guiInfo.x+511/zoom, guiInfo.y + 303/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "center")
    dxDrawText("Usuń", guiInfo.x+521/zoom, guiInfo.y + 263/zoom, guiInfo.x+666/zoom, guiInfo.y + 303/zoom, tocolor(255, 255, 255, 255), 1/zoom, guiInfo.font, "center", "center")
    end
end


function click(btn, state)
	if btn == "left" and state == "down" then
		if isCursorInPosition(guiInfo.x+guiInfo.width-30/zoom, guiInfo.y, 30/zoom, 30/zoom) then
			closeGui()

    elseif isCursorInPosition(guiInfo.x + 85/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom) and guiInfo.houseMenu == "menu" then
      triggerServerEvent("playerEnterHome", resourceRoot, localPlayer, guiInfo.houseInfo)

    elseif isCursorInPosition(guiInfo.x + 495/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom) and guiInfo.houseMenu == "menu" then
      if localPlayer:getData("player:sid") ~= guiInfo.houseInfo.owner then return end
      guiInfo.houseMenu = "settings"

    elseif isCursorInPosition(guiInfo.x + 290/zoom, guiInfo.y + guiInfo.height - 160/zoom, 120/zoom, 120/zoom) and guiInfo.houseMenu == "menu" then
      guiInfo.houseMenu = "buy"
      guiSetVisible(guiInfo.houseBuyTime,true)

    elseif isCursorInPosition(guiInfo.x + 318/zoom, guiInfo.y + 320/zoom, 64/zoom, 64/zoom) and guiInfo.houseMenu == "buy" then
      guiInfo.houseMenu = "menu"
      guiSetVisible(guiInfo.houseBuyTime,false)

    elseif isCursorInPosition(guiInfo.x + 318/zoom, guiInfo.y + 320/zoom, 64/zoom, 64/zoom) and guiInfo.houseMenu == "rent" then
      guiInfo.houseMenu = "settings"
      guiSetVisible(guiInfo.houseNewPlayer,false)
      guiInfo.houseMenuSelected = 0

    elseif isCursorInPosition(guiInfo.x + 318/zoom, guiInfo.y + 320/zoom, 64/zoom, 64/zoom) and guiInfo.houseMenu == "settings" then
      guiInfo.houseMenu = "menu"

    elseif isCursorInPosition(guiInfo.x + 85/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom) and guiInfo.houseMenu == "settings" then
      triggerServerEvent("playerCloseHome", resourceRoot, localPlayer, guiInfo.houseInfo)

    elseif isCursorInPosition(guiInfo.x + 495/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom) and guiInfo.houseMenu == "settings" then
      triggerServerEvent("playerEditHome", resourceRoot, localPlayer, guiInfo.houseInfo)

    elseif isCursorInPosition(guiInfo.x + 290/zoom, guiInfo.y + 140/zoom, 120/zoom, 120/zoom) and guiInfo.houseMenu == "settings" then
      guiInfo.houseMenu = "rent"
      guiSetVisible(guiInfo.houseNewPlayer,true)

    elseif isCursorInPosition(guiInfo.x + 250/zoom, guiInfo.y + 220/zoom, 200/zoom, 40/zoom) and guiInfo.houseMenu == "buy" then
      local money = getPlayerMoney(localPlayer)
      if tonumber(guiGetText(guiInfo.houseBuyTime)) ~= nil and tonumber(guiGetText(guiInfo.houseBuyTime)) >= 1 then
        if money >= tonumber(guiGetText(guiInfo.houseBuyTime)) * guiInfo.houseInfo.price then
          triggerServerEvent("playerPayForHome", resourceRoot, localPlayer, guiInfo.houseInfo, tonumber(guiGetText(guiInfo.houseBuyTime)) * tonumber(guiInfo.houseInfo.price), guiGetText(guiInfo.houseBuyTime))
        else
          exports.nrpg_interface:showPlayerNotification('Nie posiadasz tyle pieniędzy', 'error')
        end
      else
      end

    elseif isCursorInPosition(guiInfo.x+366/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom) then
      triggerServerEvent("playerAddPlayerToRentHome", resourceRoot, localPlayer, guiInfo.houseInfo, guiGetText(guiInfo.houseNewPlayer))

    elseif isCursorInPosition(guiInfo.x+521/zoom, guiInfo.y + 263/zoom, 145/zoom, 40/zoom) then
      if guiInfo.houseMenuSelected == 0 then return end
      triggerServerEvent("playerRemovePlayerFromRentHome", resourceRoot, localPlayer, guiInfo.houseInfo, guiInfo.houseMenuSelected)

    elseif guiInfo.houseMenu == "rent" then
      local k = 0
      local row = 0
      for i=1, 6 do
        if isCursorInPosition(guiInfo.x+33/zoom + 333/zoom*row, guiInfo.y + 108/zoom + 45/zoom*k, 300/zoom, 40/zoom) then
          if i == guiInfo.houseMenuSelected then
            guiInfo.houseMenuSelected = 0
          else
            guiInfo.houseMenuSelected = i
          end
          break
        end
        k = k + 1
        if k == 3 then
          row = row + 1
          k = 0
        end
      end

		end
	end
end

localPlayer:setData("user:blockOpen", false)
function openGui(info)
	if guiInfo.open then return end
  if localPlayer:getData("user:blockOpen") == true then return end
  localPlayer:setData("user:blockOpen", true)

	guiInfo.open = true
	guiInfo.houseInfo = info
  guiInfo.houseBuyTime = guiCreateEdit(guiInfo.x + 250/zoom, guiInfo.y + 170/zoom, 200/zoom, 40/zoom,'Ilość dni',false)
  guiSetVisible(guiInfo.houseBuyTime,false)
  guiInfo.houseNewPlayer = guiCreateEdit(guiInfo.x + 33/zoom, guiInfo.y + 263/zoom, 300/zoom, 40/zoom ,"ID gracza",false)
  guiSetVisible(guiInfo.houseNewPlayer,false)

  guiInfo.houseMenu = "menu"
  guiInfo.houseMenuSelected = 0

	addEventHandler("onClientRender", root, render)
	addEventHandler("onClientClick", root, click)
	showCursor(true)
end
addEvent("openHouseGuiInfo", true)
addEventHandler("openHouseGuiInfo", root, openGui)


function closeGui()
	if not guiInfo.open then return end
  localPlayer:setData("user:blockOpen", nil)

	guiInfo.open = false
  if isElement(guiInfo.houseBuyTime) then guiInfo.houseBuyTime:destroy() end
  if isElement(guiInfo.houseNewPlayer) then guiInfo.houseNewPlayer:destroy() end

	removeEventHandler("onClientRender", root, render)
	removeEventHandler("onClientClick", root, click)
	showCursor(false)
end
addEvent("closeHouseGuiInfo", true)
addEventHandler("closeHouseGuiInfo", root, closeGui)


function updateDataGui(info)
	if not guiInfo.open then return end
	guiInfo.houseInfo = info
end
addEvent("updateHouseGuiInfo", true)
addEventHandler("updateHouseGuiInfo", root, updateDataGui)



function isCursorInPosition(psx,psy,pssx,pssy)
  if not isCursorShowing() then return end
  cx,cy=getCursorPosition()
  cx,cy=cx*sx,cy*sy
  if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
  	return true,cx,cy
  else
    return false
  end
end


bindKey( 'k', 'both', function( key, keyState )
	if keyState == 'down' then
		for k, v in ipairs ( getElementsByType( 'marker', resourceRoot ) ) do
			local dom=getElementData(v,"house:data")
			if (dom and dom.owner ~= 0) then
				createBlipAttachedTo( v, 32, 2, 255,0,0,255,100,500 );
			else
				createBlipAttachedTo( v, 31, 2, 255,0,0,255,100,500 );
			end
		end
	else
		for k, v in ipairs( getElementsByType( 'blip', getResourceRootElement() ) ) do
			destroyElement(v)
		end
	end

end)
