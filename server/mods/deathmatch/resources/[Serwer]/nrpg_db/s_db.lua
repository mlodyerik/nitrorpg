-- Settings
DBHandler=nil
DBName="db_53990"
DBUser="db_53990"
DBPass="swittiji"
DBHost="51.83.172.143"

-- Functions
function dbSet(...)
	if not {...} then return end
	local query=dbExec(DBHandler, ...)
	return query
end

function dbGet(...)
	if not {...} then return end
	local query=dbQuery(DBHandler, ...)
	local result=dbPoll(query, -1)
	return result
end

addEventHandler("onResourceStart", resourceRoot, function()
	DBHandler = dbConnect( "mysql", "dbname=db_74567;host=137.74.6.118", "db_74567", "ce4yw9w4", "share=1" )
	if DBHandler then
		outputDebugString("* Connect to server MYSQL...")
	else
		outputDebugString("* No Connecting to server MYSQL..")
	end
end)