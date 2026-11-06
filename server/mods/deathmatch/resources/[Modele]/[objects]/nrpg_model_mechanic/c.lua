addEventHandler("onClientResourceStart", resourceRoot, function()

    EngineTXD("files/mechanik.txd"):import(3902)
    EngineCOL("files/mechanik.col"):replace(3902)
    EngineDFF("files/mechanik.dff"):replace(3902)
end)