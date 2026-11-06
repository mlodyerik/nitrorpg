
    
    txd = engineLoadTXD ( "magazyn_int.txd" )
	col = engineLoadCOL ( "magazyn_int.col" )
    dff = engineLoadDFF ( "magazyn_int.dff" )
	
    engineImportTXD ( txd, 1859  )
    engineReplaceCOL ( col, 1859  )
    engineReplaceModel ( dff, 1859  )

    setOcclusionsEnabled ( false )
