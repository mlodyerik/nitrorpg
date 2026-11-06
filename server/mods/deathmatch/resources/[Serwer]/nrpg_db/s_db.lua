-- Settings - Konfiguracja lokalnego XAMPP
DBHandler=nil
DBName="nitrorpg"
DBUser="root"
DBPass=""
DBHost="127.0.0.1"
DBPort="3306"

-- Functions
function dbSet(...)
	if not {...} then return end
	if not DBHandler then
		outputDebugString("[nrpg_db] Brak połączenia z bazą danych!", 1)
		return false
	end
	local query=dbExec(DBHandler, ...)
	return query
end

function dbGet(...)
	if not {...} then return end
	if not DBHandler then
		outputDebugString("[nrpg_db] Brak połączenia z bazą danych!", 1)
		return nil
	end
	local query=dbQuery(DBHandler, ...)
	if not query then
		outputDebugString("[nrpg_db] Błąd zapytania: " .. tostring(({...})[1]), 1)
		return nil
	end
	local result=dbPoll(query, -1)
	return result
end

addEventHandler("onResourceStart", resourceRoot, function()
	-- Połączenie z lokalną bazą MySQL (XAMPP)
	-- Host: 127.0.0.1, Port: 3306, User: root, Pass: (puste), Database: nitrorpg
	DBHandler = dbConnect( "mysql", "dbname=" .. DBName .. ";host=" .. DBHost .. ";port=" .. DBPort, DBUser, DBPass, "share=1;charset=utf8mb4" )
	if DBHandler then
		outputDebugString("[nrpg_db] ✓ Połączono z bazą MySQL: " .. DBName, 3)
		dbExec(DBHandler, "SET NAMES utf8mb4")
	else
		outputDebugString("[nrpg_db] ✗ Nie można połączyć z bazą MySQL! Sprawdź XAMPP.", 1)
		outputDebugString("[nrpg_db] Konfiguracja: " .. DBHost .. ":" .. DBPort .. " / " .. DBName, 1)
	end
end)