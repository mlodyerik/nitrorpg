addEvent("ChangePlayerSkin1", true)
addEventHandler("ChangePlayerSkin1", root, function(model)
	setElementModel(source, model)
end)