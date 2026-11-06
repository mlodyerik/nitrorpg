function lista_styli ( commandName )
    local jakistyl = getPedWalkingStyle(localPlayer)
    if jakistyl > 128 then
        if jakistyl < 130 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9Kobieta", 0, 144, 255, true)
        end

    elseif jakistyl > 127 then
        if jakistyl < 129 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9SWAT", 0, 144, 255, true)
        end
    elseif jakistyl > 120 then
        if jakistyl < 122 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("* #FFFFFFAktualny styl chodzenia: #B9B9B9Gang", 0, 144, 255, true)
        end
    elseif jakistyl > 68 then
        if jakistyl < 70 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9Skradanie", 0, 144, 255, true)
        end
    elseif jakistyl > 59 then
        if jakistyl < 61 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9Uzbrojony", 0, 144, 255, true)
        end
    elseif jakistyl > 124 then
        if jakistyl < 126 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9Sportowiec", 0, 144, 255, true)
        end
    elseif jakistyl > 136 then
        if jakistyl < 138 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("#★ FFFFFFAktualny styl chodzenia: #B9B9B9Starsza Pani", 0, 144, 255, true)
        end
    elseif jakistyl > 126 then
        if jakistyl < 128 then
            outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
			outputChatBox("")
            outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9Niewidomy", 0, 144, 255, true)
        end
    else
        outputChatBox("#00FF00● #FFFFFFStyle chodzenia dostępne na serwerze:", 255, 255, 0, true)
		outputChatBox("")
        outputChatBox("★ #FFFFFFAktualny styl chodzenia: #B9B9B9Domyślny", 0, 144, 255, true)
    end
    outputChatBox("")
	outputChatBox("#00FF00● #FFFFFF/styl.0 - styl #B9B9B9Domyślny", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.1 - styl #B9B9B9SWAT", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.2 - styl #B9B9B9Kobieta", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.3 - styl #B9B9B9Gang", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.4 - styl #B9B9B9Skradanie", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.5 - styl #B9B9B9Uzbrojony", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.6 - styl #B9B9B9Sportowiec", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.7 - styl #B9B9B9Starsza Pani", 255, 255, 0, true)
	outputChatBox("#00FF00● #FFFFFF/styl.8 - styl #B9B9B9Niewidomy", 255, 255, 0, true)

end	

--style

function laska( commandName )
    setPedWalkingStyle(localPlayer,129) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Kobieta", 255, 255, 0, true)
end
function swat( commandName )
    setPedWalkingStyle(localPlayer,128) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9SWAT", 255, 255, 0, true)
end
function cj( commandName )
    setPedWalkingStyle(localPlayer,0) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Domyślny", 255, 255, 0, true)
end
function gang( commandName )
    setPedWalkingStyle(localPlayer,121) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Gang", 255, 255, 0, true)
end
function alaninja( commandName )
    setPedWalkingStyle(localPlayer,69) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Skradanie", 255, 255, 0, true)
end
function uzbrojony( commandName )
    setPedWalkingStyle(localPlayer,60) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Uzbrojony", 255, 255, 0, true)
end
function sportowiec( commandName )
    setPedWalkingStyle(localPlayer,125) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Sportowiec", 255, 255, 0, true)
end
function starebabsko( commandName )
    setPedWalkingStyle(localPlayer,137) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Starsza Pani", 255, 255, 0, true)
end
function niewidomy( commandName )
    setPedWalkingStyle(localPlayer,127) 
    outputChatBox ("★ #FFFFFFPomyślnie ustawiłeś(aś) styl chodzenia na: #B9B9B9Siewidomy", 255, 255, 0, true)
end
addCommandHandler("styl.8", niewidomy)
addCommandHandler("styl.7", starebabsko)
addCommandHandler("styl.6", sportowiec)
addCommandHandler("styl.5", uzbrojony)
addCommandHandler("styl.4", alaninja)
addCommandHandler("styl.3", gang)
addCommandHandler("styl.2", laska)
addCommandHandler("styl.1", swat)
addCommandHandler("styl.0", cj)
addCommandHandler("style", lista_styli)