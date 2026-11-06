skiny={71,285,286,281,284,280,282,288,283,}

local function replaceSkin(i)
    txd = engineLoadTXD ( i..".txd" )
    engineImportTXD ( txd, i)
    dff = engineLoadDFF ( i..".dff", i )
    engineReplaceModel ( dff, i )

end


for i,v in ipairs(skiny) do
	replaceSkin(v)
end
