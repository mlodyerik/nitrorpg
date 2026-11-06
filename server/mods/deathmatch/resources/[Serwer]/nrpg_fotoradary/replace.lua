--[[
Object's created by Bolek. 2015 ©
]]

txd = engineLoadTXD ("foto.txd")
engineImportTXD ( txd, 16101 )
dff = engineLoadDFF ( "foto.dff")
engineReplaceModel ( dff, 16101 )