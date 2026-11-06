
    
    txd = engineLoadTXD ( "interior.txd" )
	col = engineLoadCOL ( "interior.col" )
    dff = engineLoadDFF ( "interior.dff" )
	
    engineImportTXD ( txd, 13657  )
    engineReplaceCOL ( col, 13657  )
    engineReplaceModel ( dff, 13657  )

    setOcclusionsEnabled ( false )
