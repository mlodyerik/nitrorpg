function setLevel( player, level )
	setElementData( player, "player:lvl", level )
end

function setExp( player, level )
	setElementData( player, "player:exp", level )
end

function getLevel( player )
	return getElementData( player, "player:lvl" )
end

function addExp( player, exp )
	triggerClientEvent ( player, "addExpC", player, exp )
end

function getExp( player )
	return getElementData( player, "player:exp" )
end