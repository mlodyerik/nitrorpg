function NowaAnkieta (thePlayer,cmd,...)
    local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) 
     if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
             
                                                     AllArgumenty = {...}
                                                     TrescAnkiety = table.concat(AllArgumenty, " ")
                    outputChatBox("  ", getRootElement(), 0, 0, 0)
                    outputChatBox("#007aff(ⓘ) #FFFFFFWystartowała nowa ankieta!", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#007aff(ⓘ) #FFFFFFPytanie brzmi: #06B200"..TrescAnkiety.."?", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#06B200(✔) #FFFFFFAby zagłosować pozytywnie wpisz #06B200/tak", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#bf0101(✖) #FFFFFFNatomiast aby głosować negatywnie wpisz #bf0101/nie", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#007aff(ⓘ) #FFFFFFGłosowanie jest anonimowe, a wyniki ukażą się za 30 sekund!", getRootElement(), 255, 255, 255, true)
                    outputChatBox("  ", getRootElement(), 0, 0, 0)
                    
                        addCommandHandler("tak", POZYTYWNIE)
                        addCommandHandler("nie", NEGATYWNIE)

                                                                    GlosyNaNIE = 0
                                                                    GlosyNaTAK = 0
                                                                    GraczeGlosujacy = 0

                        for i, gracz in ipairs(getElementsByType("player")) do
                                setElementData(gracz, "MozeGlosowac", true)
                        end
                    TimerZakoncz = setTimer(ZakonczAnkiete, 1000*30*1,1)
                    TimerPrzypomnienie = setTimer(Przypomnienie, 1000*15*1/2,1)

    else

        outputChatBox("#bf0101(✖) #FFFFFFOdmowa dostępu!!!", thePlayer, 255, 255, 255, true)

    end

end

addCommandHandler("ankieta", NowaAnkieta)

function Przypomnienie()

    outputChatBox("  ", getRootElement(), 0, 0, 0)
    outputChatBox("#007aff(ⓘ) #FFFFFFAnkieta dobiegnie końca za 15 sekund!", getRootElement(), 255, 255, 255, true)
    outputChatBox("  ", getRootElement(), 0, 0, 0)
    
end


function POZYTYWNIE(glosujacy,cmd)

    if getElementData(glosujacy, "MozeGlosowac") then

            GlosyNaTAK = GlosyNaTAK + 1
            GraczeGlosujacy = GraczeGlosujacy + 1
            setElementData(glosujacy, "MozeGlosowac", false)
            outputChatBox("#06B200(✔) #FFFFFFZagłosowałeś(aś) na #06B200TAK!",glosujacy,255,255,255,true)

            else

            outputChatBox("#007aff(ⓘ) #FFFFFFJuż głosowałeś(aś) w tej ankiecie!",glosujacy,255,255,255,true)

    end

end


function NEGATYWNIE(glosujacy,cmd)

    if getElementData(glosujacy, "MozeGlosowac") then

            GlosyNaNIE = GlosyNaNIE + 1
            GraczeGlosujacy = GraczeGlosujacy + 1
            setElementData(glosujacy, "MozeGlosowac", false)
            outputChatBox("#06B200(✔) #FFFFFFZagłosowałeś(aś) na #bf0101NIE!",glosujacy,255,255,255,true)

            else

            outputChatBox("#007aff(ⓘ) #FFFFFFJuż głosowałeś(aś) w tej ankiecie!",glosujacy,255,255,255,true)

    end

end

function ZakonczAnkiete()

        removeCommandHandler("tak",POZYTYWNIE)
        removeCommandHandler("nie",NEGATYWNIE)

                    outputChatBox("  ", getRootElement(), 0, 0, 0)
                    outputChatBox("#007aff(ⓘ) #FFFFFFAnkieta dobiegła końca!", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#007aff(ⓘ) #FFFFFFPytanie brzmiało: "..TrescAnkiety.."?", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#06B200(✔) #FFFFFFOddano "..GlosyNaTAK.. " głos/y/ów na #06B200TAK", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#bf0101(✖) #FFFFFFOddano "..GlosyNaNIE.. " głos/y/ów na #bf0101NIE", getRootElement(), 255, 255, 255, true)
                    outputChatBox("#007aff(ⓘ) #FFFFFFW głosowaniu wzieło udział #06B200"..GraczeGlosujacy.."  #FFFFFFgracz/y!", getRootElement(), 255, 255, 255, true)

                                    if GlosyNaTAK>GlosyNaNIE then
                                            outputChatBox("#06B200(✔) #FFFFFFWynik: Więcej osób zagłosowało na #06B200TAK",getRootElement(),255,255,255,true)
                                    elseif GlosyNaTAK<GlosyNaNIE then
                                            outputChatBox("#bf0101(✖) #FFFFFFWynik: Więcej osób zagłosowało na #bf0101NIE",getRootElement(),255,255,255,true)
                                    elseif GlosyNaNIE==GlosyNaTAK then
                                            outputChatBox("#007aff(ⓘ) #FFFFFFWynik: Żadna opcja nie uzyskała przewagi 1 głosu!",getRootElement(),255,255,255,true)
                                    end

                    outputChatBox("  ", getRootElement(), 0, 0, 0)
end

function AnulujAnkiete(thePlayer)

    local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) 

        if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then

            outputChatBox("#bf0101(✖) #FFFFFFAnkieta została anulowana!!!", getRootElement(), 255, 255, 255, true)
            killTimer(TimerZakoncz)
            killTimer(TimerPrzypomnienie)
            removeCommandHandler("nie",NEGATYWNIE)
            removeCommandHandler("tak",POZYTYWNIE)

        else

            outputChatBox("* Odmowa dostępu!!!", thePlayer, 255, 0, 0)

    end

end

addCommandHandler("ankieta.anuluj", AnulujAnkiete)

function PomocAnkieta(thePlayer)

outputChatBox("  ", thePlayer, 0, 0, 0)
outputChatBox("* /ankieta -- Tworzy nową ankiete.", thePlayer, 255, 0, 0)
outputChatBox("* Użycie: /ankieta.stworz [pytanie] | Znak zapytania jest dodawany automatycznie ", thePlayer, 255, 0, 0)
outputChatBox("* /ankieta.anuluj -- Anuluje obecna ankiete ", thePlayer, 255, 0, 0)
outputChatBox("* /ankieta.pomoc -- Wyświetla wszystkie możliwe komendy odnośnie ankiety ", thePlayer, 255, 0, 0)
outputChatBox("  ", thePlayer, 0, 0, 0)

end

addCommandHandler("ankieta.pomoc", PomocAnkieta)