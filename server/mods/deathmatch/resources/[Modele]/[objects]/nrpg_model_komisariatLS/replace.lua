
col = engineLoadCOL("SAPDHQ.col")
txd = engineLoadTXD("SAPDHQ.txd")
txd2 = engineLoadTXD("roads_lawn.txd")
dff = engineLoadDFF("SAPDHQ.dff")
dff2 = engineLoadDFF("road_lawn06.dff")
dff3 = engineLoadDFF("road_lawn26.dff")
 
engineReplaceCOL(col, 5708)
engineImportTXD(txd, 5708)
engineImportTXD(txd2, 5994, 5794)
engineReplaceModel(dff, 5708, true)
engineReplaceModel(dff2, 5794, true)
engineReplaceModel(dff3, 5994, true)