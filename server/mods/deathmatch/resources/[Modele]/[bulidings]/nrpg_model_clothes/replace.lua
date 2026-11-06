
    
    txd = engineLoadTXD ( "clothes_int.txd" )
	col = engineLoadCOL ( "clothes_int.col" )
    dff = engineLoadDFF ( "clothes_int.dff" )
	
    engineImportTXD ( txd, 1855  )
    engineReplaceCOL ( col, 1855  )
    engineReplaceModel ( dff, 1855  )

    setOcclusionsEnabled ( false )
