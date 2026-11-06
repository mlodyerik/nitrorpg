--[[
Autor znaku STOP oraz ZAKAZ WJAZDU: BezCenzury
Autor reszty znaków: Nieletni
]]


-------- STOP

local col = engineLoadCOL ( "kolizja/STOP.col", 3380 )
engineReplaceCOL ( col, 3380 )
local txd = engineLoadTXD ( "tekstury/STOP.txd", 3380 )
engineImportTXD ( txd, 3380 )
local dff = engineLoadDFF ( "model/STOP.dff", 3380 )
engineReplaceModel ( dff, 3380 )
