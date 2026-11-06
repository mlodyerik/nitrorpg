local SQL

local function connect()
	-- Konfiguracja lokalnego połączenia MySQL (XAMPP)
	-- Host: 127.0.0.1, Port: 3306, User: root, Pass: (puste), Database: nitrorpg
	SQL = dbConnect( "mysql", "dbname=nitrorpg;host=127.0.0.1;port=3306", "root", "", "share=1;charset=utf8mb4" )
              
	if (not SQL) then
		outputServerLog("[DB2] BRAK POLACZENIA Z BAZA DANYCH! Sprawdź czy XAMPP MySQL jest uruchomiony.")
	else
		outputServerLog("[DB2] POLACZONO POMYSLNIE z bazą nitrorpg!")
		zapytanie("SET NAMES utf8mb4;")
	end

end

addEventHandler("onResourceStart",resourceRoot, connect)

function pobierzTabeleWynikow(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	return rows
end

function pobierzWyniki(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	if not rows then return nil end
	return rows[1]
end

function zapytanie(...)
	local h=dbQuery(SQL,...)
	local result,numrows=dbPoll(h,-1)
	return numrows
end

function fetchRows(query)
	local result=mysql_query(SQL,query)
	if (not result) then return nil end
	local tabela={}

	while true do
    	local row = mysql_fetch_row(result)
	    if (not row) then break end
	    table.insert(tabela,row)
	end
	mysql_free_result(result)
	return tabela
end