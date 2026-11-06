local txd = engineLoadTXD('kolczatka.txd') -- tekstury
engineImportTXD(txd, 2899)
local dff = engineLoadDFF('kolczatka.dff', 2899) -- model
engineReplaceModel(dff, 2899)


