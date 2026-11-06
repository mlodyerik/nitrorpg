local zoom = exports["nrpg_interface"]:getInterfaceZoom()

main = {

    ["textures"] = {

        ["sunPromienie"] = dxCreateTexture("img/promienie.png"),
        ["sunSrodek"] = dxCreateTexture("img/srodek.png"),
        ["cloud"] = dxCreateTexture("img/cloud.png"),

    },

    weatherName = nil,
    weatherDesc = nil,
    alphaUI = 0,
    sunRotation = 0,

}

main.weatherGUI = function()
    main.sunRotation = main.sunRotation + 1
    dxDrawText(main.weatherName, 930/zoom, 45/zoom, 200/zoom, 50/zoom, tocolor(255, 255, 255, main.alphaUI), 1, exports["nrpg_interface"]:getGUIFont("money12"), "left", "center")
    dxDrawText(main.weatherDesc, 930/zoom, 65/zoom, 200/zoom, 50/zoom, tocolor(255, 255, 255, main.alphaUI), 1, exports["nrpg_interface"]:getGUIFont("light10"), "left", "top")
    dxDrawImage(830/zoom, 25/zoom, 100/zoom, 90/zoom, main["textures"]["sunSrodek"], 0, 0, 0, tocolor(255, 255, 255, main.alphaUI))
    dxDrawImage(830/zoom, 25/zoom, 100/zoom, 90/zoom, main["textures"]["sunPromienie"], main.sunRotation, 0, 0, tocolor(255, 255, 255, main.alphaUI))

    if main.weatherName == "Burza" then
        dxDrawImage(862/zoom, 46/zoom, 135/zoom, 60/zoom, main["textures"]["cloud"], 0, 0, 0, tocolor(75, 75, 75, main.alphaUI))
    elseif main.weatherName == "Pochmurnie" then
        dxDrawImage(862/zoom, 46/zoom, 135/zoom, 60/zoom, main["textures"]["cloud"], 0, 0, 0, tocolor(155, 155, 155, main.alphaUI))
    end
end


addEvent("showChangeWeather", true)
addEventHandler("showChangeWeather", resourceRoot, function(id, name, desc)
    if not isEventHandlerAdded("onClientRender", root, main.weatherGUI) then
        addEventHandler("onClientRender", root, main.weatherGUI)
        main.weatherName = name
        main.weatherDesc = desc
        createAnimation(0, 255, 'Linear', 1500, function(value) main.alphaUI = value end)
        
        timer = setTimer(function()
        createAnimation(255, 0, 'Linear', 1500, function(value) main.alphaUI = value end)
        if isTimer(timer) then killTimer(timer) end

            timer = setTimer(function()
                removeEventHandler("onClientRender", root, main.weatherGUI)
                if isTimer(timer) then killTimer(timer) end
            end, 2000, 1)

        end, 10000, 1)
    end
end)