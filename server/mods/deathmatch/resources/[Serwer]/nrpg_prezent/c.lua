addEventHandler("onClientResourceStart", resourceRoot, function()

    EngineTXD("files/prezent.txd"):import(1241)
    EngineDFF("files/prezent.dff"):replace(1241)
end)