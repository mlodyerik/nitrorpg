setWeather(11)

main = {

    ["weathers"] = {

        {0, "Bardzo słonecznie", "Pogoda zmienia się na bardzo słoneczną\nniebo się przejaśnia."},

        {20, "Bardzo Pochmurnie", "Na niebie pojawiają się chmury\njest ryzyko powstania burzy."},

        {8, "Pochmurnie", "Na niebie pojawiają się chmury\njest ryzyko powstania burzy."},
        
        {1, "Słonecznie", "Pogoda zmienia się na słoneczną\nwidać pojedyńcze chmury."},

        {16, "Burza", "Na niebie pojawiają się chmury\njest ryzyko powstania burzy."},

        {11, "Słonecznie", "Pogoda zmienia się na słoneczną\nwidać pojedyńcze chmury."},

    },

    toggleWeather = createElement( "weather", 997 ),

}

main.randomizeWeather = function()
    local randomPogoda = math.random(1, #main["weathers"])

    if main["weathers"][randomPogoda][1] == getElementData(main.toggleWeather, "weatherID") then main.randomizeWeather() return end

    setWeatherBlended(main["weathers"][randomPogoda][1])
    setElementData(main.toggleWeather, "weatherID", main["weathers"][randomPogoda][1])

    triggerClientEvent(root, "showChangeWeather", resourceRoot, main["weathers"][randomPogoda][1], main["weathers"][randomPogoda][2], main["weathers"][randomPogoda][3])
end

function setupResource()
    setTimer( function()
	    main.timerPogoda = setTimer( function()
            main.randomizeWeather()
        end, 60000*60, 0)

        main.randomizeWeather()
    end, 1000, 1)
end
