local SQL

local function connect()
	SQL = dbConnect( "mysql", "dbname=db_82027;host=137.74.6.118", "db_82027", "wzojUO9VH6oL", "share=1" )
              
	if (not SQL) then
		outputServerLog("BRAK POLACZENIA Z BAZA DANYCH!")
	else
		zapytanie("SET NAMES utf8;")
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