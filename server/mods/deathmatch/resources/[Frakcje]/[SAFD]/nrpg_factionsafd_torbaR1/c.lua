local model = 1550

txd = engineLoadTXD("r1.txd")
engineImportTXD(txd, model)

dff = engineLoadDFF("r1.dff")
engineReplaceModel(dff, model)