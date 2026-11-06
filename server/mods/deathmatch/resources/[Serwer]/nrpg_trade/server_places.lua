local places = {
    
}

for i,v in ipairs(places) do 
    local cuboid = createColSphere(v.x,v.y,v.z,v.sphereSize)
    local marker = createMarker(v.x, v.y, v.z-1, "cylinder", 1.25, 255, 255, 0, 55)
    setElementData(marker,'marker:text','(/trade <id>)')
    setElementData(cuboid, 'tradePlace', true)

    setElementInterior(marker, v.int)
	setElementDimension(marker, v.dim)
    setElementInterior(cuboid, v.int)
	setElementDimension(cuboid, v.dim)
end


function isElementWithinAColShape(element)
    if element or isElement(element)then
       for _,colshape in ipairs(getElementsByType("colshape"))do
      if isElementWithinColShape(element,colshape) and getElementData(colshape,'tradePlace') then
         return colshape
      end
    end
    end
    return false
 end


addLog = function(plr, plr2, type, text, ew)
    if ew == 1 then
        local outputLog = ""..type.." - "..text:gsub('#%x%x%x%x%x%x', '')
        local outputLog2 = "[**"..type.."**] - "..text:gsub('#%x%x%x%x%x%x', '')
        if outputLog then
            triggerEvent("admin:addText", resourceRoot, outputLog)
            outputServerLog(outputLog)
            exports['nrpg_discord']:connectWeb(outputLog2:gsub("#%x%x%x%x%x%x",""), "Giełda")
        end
    else
        local outputLog = ""..type.." - ["..getElementData(plr, "id").."] "..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '').." > ["..getElementData(plr2, "id").."] "..getPlayerName(plr2):gsub('#%x%x%x%x%x%x', '')..": "..text:gsub('#%x%x%x%x%x%x', '')
        local outputLog2 = "[**"..type.."**] [**"..getElementData(plr, "id").."**] **"..getPlayerName(plr):gsub('#%x%x%x%x%x%x', '').."** > ["..getElementData(plr2, "id").."] "..getPlayerName(plr2):gsub('#%x%x%x%x%x%x', '')..": "..text:gsub('#%x%x%x%x%x%x', '')
        if outputLog then
            triggerEvent("admin:addText", resourceRoot, outputLog)
            outputServerLog(outputLog)
            exports['nrpg_discord']:connectWeb(outputLog2:gsub("#%x%x%x%x%x%x",""), "Giełda")
        end
    end
end


startTrade = function(player1,player2)
    local object = createObject(1,0,0,-100)
    setElementCollisionsEnabled(object,false)
    setElementAlpha(object,0)
    --table.insert(objects, {obiekt=object,plr1={player1},plr2={player2},plr1Items={},plr2Items={}})
    setElementData(object,'object_trade_data',{obiekt=object,plr1=player1,plr2=player2,plr1Items={ {false,false,false},{false,false,false},{false,false,false},{false,false,false},{false,false,false} },plr2Items={ {false,false,false},{false,false,false},{false,false,false},{false,false,false},{false,false,false} },plr1Accept=false,plr2Accept=false})
    triggerClientEvent(player1,'openTradeGui',player1,object,1)
    triggerClientEvent(player2,'openTradeGui',player2,object,2)
    setElementData(player1,'inTrade',true)
    setElementData(player2,'inTrade',true)

    addEventHandler('onPlayerLeave',player1,function()
        destroyElement(object)
    end)

    addEventHandler('onPlayerLeave',player2,function()
        destroyElement(object)
    end)
end 





endTradeWithAcceptation = function(object)
    local objectElData = getElementData(object,'object_trade_data')
    local player1 = objectElData.plr1 
    local player2 = objectElData.plr2





    for i,v in ipairs(objectElData.plr1Items) do 
        if v[1] == 'money' then
            takePlayerMoney(player1, v[2])
            givePlayerMoney(player2, v[2])
            exports.nrpg_interface:showPlayerNotification(player2, 'Otrzymałeś: '..v[2]..' PLN.', "info")
            exports.nrpg_interface:showPlayerNotification(player1, 'Przelałeś: '..v[2]..' PLN.', "info")
            addLog(player1, player2, "#7EFF00WYMIANA#FFFFFF", "(Gotówka) "..v[2].." PLN")
        end 


        if v[1] == 'bankMoney' then 
            exports['nrpg_db']:dbSet('update pystories_users set bank_money=bank_money-? where id=?',v[2],getElementData(player1,'player:sid'))
            exports['nrpg_db']:dbSet('update pystories_users set bank_money=bank_money+? where id=?',v[2],getElementData(player2,'player:sid'))
            exports.nrpg_interface:showPlayerNotification(player2, 'Otrzymałeś: '..v[2]..' PLN przelewu na konto.', "info")
            exports.nrpg_interface:showPlayerNotification(player1, 'Przelałeś: '..v[2]..' PLN pieniędzy na konto gracza.', "info")
            addLog(player1, player2, "#7EFF00WYMIANA#FFFFFF", "(Przelew) "..v[2].." PLN")
        end 


        if v[1] == 'car' then 
            for k,va in ipairs(getElementsByType('vehicle')) do 
                if getElementData(va,'vehicle:id') == v[2] then  
                    exports['nrpg_vehicles']:onParkVehicle(va)
                end
            end 


            exports['nrpg_db']:dbSet('update pystories_vehicles set ownedPlayer=? where id=?',getElementData(player2,'player:sid'),v[2])
            exports.nrpg_interface:showPlayerNotification(player2, 'Pojazd: '..v[3]..' (ID:'..v[2]..') znajdziesz od teraz w swojej przechowalni.', "info")
            exports.nrpg_interface:showPlayerNotification(player1, 'Oddałeś pojazd: '..v[3]..' (ID:'..v[2]..') na wymianę.', "info")
            addLog(player1, player2, "#7EFF00WYMIANA#FFFFFF", "(Pojazd) "..v[3].." [ID: "..v[2].."]")
        end 
    end





    for i,v in ipairs(objectElData.plr2Items) do 
        if v[1] == 'money' then 
            takePlayerMoney(player2, v[2])
            givePlayerMoney(player1, v[2])
            exports.nrpg_interface:showPlayerNotification(player1, 'Otrzymałeś: '..v[2]..' PLN.', "info")
            exports.nrpg_interface:showPlayerNotification(player2, 'Przelałeś: '..v[2]..' PLN.', "info")
            addLog(player2, player1, "#7EFF00WYMIANA#FFFFFF", "(Gotówka) "..v[2].." PLN")
        end 


        if v[1] == 'bankMoney' then 
            exports['nrpg_db']:dbSet('update pystories_users set bank_money=bank_money-? where id=?',v[2],getElementData(player2,'player:sid'))
            exports['nrpg_db']:dbSet('update pystories_users set bank_money=bank_money+? where id=?',v[2],getElementData(player1,'player:sid'))
            exports.nrpg_interface:showPlayerNotification(player1, 'Otrzymałeś: '..v[2]..' PLN przelewu na konto.', "info")
            exports.nrpg_interface:showPlayerNotification(player2, 'Przelałeś: '..v[2]..' PLN pieniędzy na konto gracza.', "info")
            addLog(player2, player1, "#7EFF00WYMIANA#FFFFFF", "(Przelew) "..v[2].." PLN")
        end 


        if v[1] == 'car' then 
            for k,va in ipairs(getElementsByType('vehicle')) do 
                if getElementData(va,'vehicle:id') == v[2] then  
                    exports['nrpg_vehicles']:onParkVehicle(va)
                end 
            end 


            exports['nrpg_db']:dbSet('update pystories_vehicles set ownedPlayer=? where id=?',getElementData(player1,'player:sid'),v[2])
            exports.nrpg_interface:showPlayerNotification(player1, 'Pojazd: '..v[3]..' (ID:'..v[2]..') znajdziesz od teraz w swojej przechowalni.', "info")
            exports.nrpg_interface:showPlayerNotification(player2, 'Oddałeś pojazd: '..v[3]..' (ID:'..v[2]..') na wymianę.', "info")
            addLog(player2, player1, "#7EFF00WYMIANA#FFFFFF", "(Pojazd) "..v[3].." [ID: "..v[2].."]")
        end 
    end


    triggerClientEvent(player1,'closeTradeGui',player1)
    triggerClientEvent(player2,'closeTradeGui',player2)
    setElementData(player1,'inTrade',false)
    setElementData(player2,'inTrade',false)
    destroyElement(object)
end





addEvent('acceptTrade',true)
addEventHandler('acceptTrade',root,function(object,player)
    if player == 1 then
        local objectElData = getElementData(object,'object_trade_data')
        objectElData.plr1Accept = not objectElData.plr1Accept
        setElementData(object,'object_trade_data',objectElData)
    elseif player == 2 then 
        local objectElData = getElementData(object,'object_trade_data')
        objectElData.plr2Accept = not objectElData.plr2Accept
        setElementData(object,'object_trade_data',objectElData)
    end 


    local objectElData = getElementData(object,'object_trade_data')
    if objectElData.plr1Accept and objectElData.plr2Accept then
        endTradeWithAcceptation(object)
    end 
end)





addEvent('cancelTrade',true)
addEventHandler('cancelTrade',root,function(object,player)
    local dataObject = getElementData(object,'object_trade_data')
    triggerClientEvent(dataObject.plr1,'closeTradeGui',dataObject.plr1)
    triggerClientEvent(dataObject.plr2,'closeTradeGui',dataObject.plr2)
    setElementData(dataObject.plr1,'inTrade',false)
    setElementData(dataObject.plr2,'inTrade',false)
    destroyElement(object)
end)





getPlayerLastItemSlot = function(player,playerNumber,object)
    if player and playerNumber then 
        if playerNumber == 1 then 
            local eData = getElementData(object,'object_trade_data')
            if not eData.plr1Items[1][1] then 
                return 1
            end 


            if not eData.plr1Items[2][1] then 
                return 2
            end 
            if not eData.plr1Items[3][1] then 
                return 3
            end
            if not eData.plr1Items[4][1] then 
                return 4
            end
            if not eData.plr1Items[5][1] then 
                return 5
            end 
        elseif playerNumber == 2 then 

            local eData = getElementData(object,'object_trade_data')
            if not eData.plr2Items[1][1] then 
                return 1
            end
            if not eData.plr2Items[2][1] then 
                return 2
            end 
            if not eData.plr2Items[3][1] then 
                return 3
            end 
            if not eData.plr2Items[4][1] then 
                return 4
            end 
            if not eData.plr2Items[5][1] then 
                return 5
            end 
        end 
    end 
end





addEvent('trade_addCar',true)


addEventHandler('trade_addCar',root,function(object,player,carUID)


    local query = exports['nrpg_db']:dbGet('SELECT * FROM pystories_vehicles WHERE ownedPlayer=? AND id=?',getElementData(source,'player:sid'),carUID)


    if query[1] and #query[1] >= 0 then 





        local objData = getElementData(object,'object_trade_data')





        if player == 1 then 





            if objData.plr1Items[1][1] == 'car' and objData.plr1Items[1][2] == carUID then return end 


            if objData.plr1Items[2][1] == 'car' and objData.plr1Items[2][2] == carUID then return end 


            if objData.plr1Items[3][1] == 'car' and objData.plr1Items[1][2] == carUID then return end 


            if objData.plr1Items[4][1] == 'car' and objData.plr1Items[1][2] == carUID then return end 


            if objData.plr1Items[5][1] == 'car' and objData.plr1Items[1][2] == carUID then return end 





            local slot = getPlayerLastItemSlot(source,player,object)





            objData.plr1Items[slot][1] = 'car'


            objData.plr1Items[slot][2] = carUID


            objData.plr1Items[slot][3] = exports["nrpg_vehicles"]:changeName(getVehicleNameFromModel(query[1].model))


            setElementData(object,'object_trade_data',objData)


            





        elseif player == 2 then 





            if objData.plr2Items[1][1] == 'car' and objData.plr2Items[1][2] == carUID then return end 


            if objData.plr2Items[2][1] == 'car' and objData.plr2Items[2][2] == carUID then return end 


            if objData.plr2Items[3][1] == 'car' and objData.plr2Items[1][2] == carUID then return end 


            if objData.plr2Items[4][1] == 'car' and objData.plr2Items[1][2] == carUID then return end 


            if objData.plr2Items[5][1] == 'car' and objData.plr2Items[1][2] == carUID then return end 





            local slot = getPlayerLastItemSlot(source,player,object)





            objData.plr2Items[slot][1] = 'car'


            objData.plr2Items[slot][2] = carUID


            objData.plr2Items[slot][3] = getVehicleNameFromModel(query[1].model)


            setElementData(object,'object_trade_data',objData)





        end 





    else 





        exports.nrpg_interface:showPlayerNotification(source, "Nie jesteś właścicielem tego pojazdu!", "error")





    end 


end)





addEvent('trade_addMoney',true)


addEventHandler('trade_addMoney',root,function(object,player,count)    





    if getPlayerMoney(source) < count then 


        exports.nrpg_interface:showPlayerNotification(source, "Nie posiadasz tyle gotówki", "error")


        return 


    end 





    if count <= 0 then return end 





    local objData = getElementData(object,'object_trade_data')





    if player == 1 then 





        if objData.plr1Items[1][1] == 'money' then 





            if objData.plr1Items[1][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr1Items[1][2] = objData.plr1Items[1][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[2][1] == 'money' then 





            if objData.plr1Items[2][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr1Items[2][2] = objData.plr1Items[2][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[3][1] == 'money' then 





            if objData.plr1Items[3][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr1Items[3][2] = objData.plr1Items[3][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[4][1] == 'money' then 





            if objData.plr1Items[4][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr1Items[4][2] = objData.plr1Items[4][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[5][1] == 'money' then 





            if objData.plr1Items[5][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr1Items[5][2] = objData.plr1Items[5][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        local slot = getPlayerLastItemSlot(source,player,object)





        objData.plr1Items[slot][1] = 'money'


        objData.plr1Items[slot][2] = count


        setElementData(object,'object_trade_data',objData)





        





    elseif player == 2 then 





        if objData.plr2Items[1][1] == 'money' then 





            if plr2Items[1][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr2Items[1][2] = objData.plr2Items[1][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[2][1] == 'money' then 





            if objData.plr2Items[2][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr2Items[2][2] = objData.plr2Items[2][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[3][1] == 'money' then 





            if objData.plr2Items[3][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr2Items[3][2] = objData.plr2Items[3][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[4][1] == 'money' then 





            if objData.plr2Items[4][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr2Items[4][2] = objData.plr2Items[4][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[5][1] == 'money' then 





            if objData.plr2Items[5][2] + count > getPlayerMoney(source) then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz", "error")


                return 


            end 





            objData.plr2Items[5][2] = objData.plr2Items[5][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        local slot = getPlayerLastItemSlot(source,player,object)





        objData.plr2Items[slot][1] = 'money'


        objData.plr2Items[slot][2] = count


        setElementData(object,'object_trade_data',objData)





    end 





end)





addEvent('trade_addBankmoney',true)


addEventHandler('trade_addBankmoney',root,function(object,player,count)    





    local query = exports['nrpg_db']:dbGet('select bank_money from pystories_users where id=?',getElementData(source,'player:sid'))





    if count <= 0 then return end 





    if query[1].bank_money < count then 


        exports.nrpg_interface:showPlayerNotification(source, "Nie posiadasz takiej gotówki w banku", "error")


        return 


    end 





    local objData = getElementData(object,'object_trade_data')





    if player == 1 then 





        if objData.plr1Items[1][1] == 'bankMoney' then 





            if objData.plr1Items[1][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr1Items[1][2] = objData.plr1Items[1][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[2][1] == 'bankMoney' then 





            if objData.plr1Items[2][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr1Items[2][2] = objData.plr1Items[2][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[3][1] == 'bankMoney' then 





            if objData.plr1Items[3][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr1Items[3][2] = objData.plr1Items[3][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[4][1] == 'bankMoney' then 





            if objData.plr1Items[4][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr1Items[4][2] = objData.plr1Items[4][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr1Items[5][1] == 'bankMoney' then 





            if objData.plr1Items[5][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr1Items[5][2] = objData.plr1Items[5][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        local slot = getPlayerLastItemSlot(source,player,object)





        objData.plr1Items[slot][1] = 'bankMoney'


        objData.plr1Items[slot][2] = count


        setElementData(object,'object_trade_data',objData)





        





    elseif player == 2 then 





        if objData.plr2Items[1][1] == 'bankMoney' then 





            if plr2Items[1][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr2Items[1][2] = objData.plr2Items[1][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[2][1] == 'bankMoney' then 





            if objData.plr2Items[2][2] + count >query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr2Items[2][2] = objData.plr2Items[2][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[3][1] == 'bankMoney' then 





            if objData.plr2Items[3][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr2Items[3][2] = objData.plr2Items[3][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[4][1] == 'bankMoney' then 





            if objData.plr2Items[4][2] + count > query[1].bank_money then 


                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")


                return 


            end 





            objData.plr2Items[4][2] = objData.plr2Items[4][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        if objData.plr2Items[5][1] == 'bankMoney' then 





            if objData.plr2Items[5][2] + count > query[1].bank_money then 

                exports.nrpg_interface:showPlayerNotification(source, "Nie możesz dodać więcej pieniędzy niż posiadasz w banku", "error")

                return 


            end 





            objData.plr2Items[5][2] = objData.plr2Items[5][2] + count


            setElementData(object,'object_trade_data',objData)


            return


        end 





        local slot = getPlayerLastItemSlot(source,player,object)





        objData.plr2Items[slot][1] = 'bankMoney'


        objData.plr2Items[slot][2] = count


        setElementData(object,'object_trade_data',objData)





    end 





end)








addCommandHandler('trade',function(playerSource,commandName,playerTarget)

    if exports["nrpg_antycheat"]:checkAccount(playerSource) == true then return end

    if not isElementWithinAColShape(playerSource) then 

        exports.nrpg_interface:showPlayerNotification(playerSource, "Nie jesteś w strefie wymian", "error")

        return 


    end 





    local foundPlayer = exports['nrpg_core']:findPlayer(playerSource,playerTarget)





    setElementData(foundPlayer,'inTrade',false)


    setElementData(playerSource,'inTrade',false)





    if foundPlayer == playerSource then 
        return 
    end 

    if not isElementWithinAColShape(foundPlayer) then 
        return 
    end 

    if getElementData(playerSource, 'inTrade') then
        return 
    end 

    if getElementData(foundPlayer, 'inTrade') then 
        exports.nrpg_interface:showPlayerNotification(playerSource, "Ten gracz jest w trakcie wymiany", "error")
        return 
    end 
    startTrade(playerSource, foundPlayer)
    addLog(playerSource, foundPlayer, "#7EFF00WYMIANA - START#FFFFFF", "Gracz "..getPlayerName(playerSource):gsub("#%x%x%x%x%x%x", "").." rozpoczyna wymianę z graczem "..getPlayerName(foundPlayer):gsub("#%x%x%x%x%x%x", "").."", 1)
end)