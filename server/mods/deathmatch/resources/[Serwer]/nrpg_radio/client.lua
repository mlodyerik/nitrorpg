local table_muza = {

    {-2681.36, -5.22, 6.13},
    {-2537.62, -28.60, 16.48},
    {-1876.05, 821.22, 35.18},
    {-1954.62, -865.83, 32.23},
    {1007.50, -1434.46, 13.55},
    {1479.49, -1697.41, 13.48},
    {1964.55, 2175.78, 10.82},
    {3298.25, -424.06, 573.75},
    {1106.17, -1748.70, 17.00},

}

sound = {}

function play() 
    for i,v in ipairs(table_muza) do
        sound[i] = playSound3D("https://s3.slotex.pl/shoutcast/7382/stream?sid=1", v[1], v[2], v[3], true)
        setSoundMaxDistance(sound[i], 150)
        setSoundVolume(sound[i], 0.15)
    end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource () ), play )



function switchSBlurShader(el_data_key, new_data)
    if (el_data_key == "player:3dmusic") then
        if getElementData(localPlayer, el_data_key) then
		    for i,v in ipairs(table_muza) do
                setSoundVolume(sound[i], 0)
            end
	    else
		    for i,v in ipairs(table_muza) do
                setSoundVolume(sound[i], 0.75)
            end
	    end
    end
end
addEventHandler("onClientElementDataChange", root, switchSBlurShader)