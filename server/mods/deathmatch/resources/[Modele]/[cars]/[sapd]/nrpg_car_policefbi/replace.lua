txd = engineLoadTXD ( "fbiranch.txd" )
dff = engineLoadDFF ( "fbiranch.dff" )

engineImportTXD ( txd, 490  )
engineReplaceModel ( dff, 490  )