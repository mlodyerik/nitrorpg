txd = engineLoadTXD ( "copcarla.txd" )
dff = engineLoadDFF ( "copcarla.dff" )

engineImportTXD ( txd, 596  )
engineReplaceModel ( dff, 596  )