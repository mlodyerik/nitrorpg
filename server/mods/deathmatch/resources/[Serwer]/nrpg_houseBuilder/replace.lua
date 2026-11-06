--BOCHA.
function ChangeObjectModel (id,filename)
    if id and filename then
        if id == 1868 or id == 1866 or id == 1867 then
            fileExists(filename..".txd")
            txd = engineLoadTXD("files/model/build.txd")
            engineImportTXD(txd, id)
        end            
        if fileExists(filename..".dff") then
            dff = engineLoadDFF( filename..".dff", 0 )
            engineReplaceModel( dff, id )
        end     
        if fileExists(filename..".col") then
            col = engineLoadCOL( filename..".col" )
            engineReplaceCOL( col, id )
        end         
        engineSetModelLODDistance(id,500)
    end
end
    ChangeObjectModel(1868, 'files/model/floor')
    ChangeObjectModel(1866, 'files/model/wall')
    ChangeObjectModel(1867, 'files/model/wall_door')