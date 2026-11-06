
    
    txd = engineLoadTXD ( "license_int.txd" )
	col = engineLoadCOL ( "license_int.col" )
    dff = engineLoadDFF ( "license_int.dff" )
	
    engineImportTXD ( txd, 1857  )
    engineReplaceCOL ( col, 1857  )
    engineReplaceModel ( dff, 1857  )

    setOcclusionsEnabled ( false )
