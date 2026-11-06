
    
    txd = engineLoadTXD ( "safd2.txd" )
	col = engineLoadCOL ( "safd2.col" )
    dff = engineLoadDFF ( "safd2.dff" )
	
    engineImportTXD ( txd, 6133  )
    engineReplaceCOL ( col, 6133  )
    engineReplaceModel ( dff, 6133, true  )

    setOcclusionsEnabled ( false )
