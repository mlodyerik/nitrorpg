local wiadomki = {

    {"Potrzebujesz pomocy lub ktoś ci przeszkadza w rozgrywce? Napisz zgłoszenie do administracji: #bfbfbf/report <id/nick> <treść>"},
    {"Punkty premium możesz zakupić u #bfbfbfTheNoobisty, ReftiXD."},
    {"Nie wiesz jak zacząć? Zobacz poradnik w panelu pomocy #bfbfbf(F1)"},

}

function wiadomkaCzas()
   losujWiadomke = math.random(1, #wiadomki)
   outputChatBox(" ", getRootElement(), 158, 155, 220, true)
   outputChatBox("◌ #ffffff "..wiadomki[losujWiadomke][1].."", getRootElement(), 255, 175, 0, true)
   outputChatBox(" ", getRootElement(), 158, 155, 220, true)
   outputServerLog('» '..wiadomki[losujWiadomke][1]..'')
end
wiadomkaCzas()
setTimer(wiadomkaCzas, 6000*15, 0)