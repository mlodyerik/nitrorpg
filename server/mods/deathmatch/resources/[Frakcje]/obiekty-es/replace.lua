txd = engineLoadTXD("plama.txd")
engineImportTXD(txd, 902)
dff = engineLoadDFF("plama.dff", 902)
engineReplaceModel(dff, 902)
