local slothbot = exports["slothbot"]

local bot = {}
local botRespawnInfo = {}

local bots = {

    {2366.61, -1645.75, 13.55},
    {2329.58, -1683.94, 13.61},
    {2511.90, -1649.93, 14.09},
    {2511.29, -1692.14, 13.50},
    {2449.06, -1644.00, 13.74},
    {2153.47, -1813.46, 13.55},
    {2228.70, -1282.13, 25.37},
    {2186.58, -1239.02, 23.98},
    {2169.16, -1423.16, 23.98},
    {2139.85, -1206.56, 23.96},

}

local levelWeapons = {

    [1] = {

        {1},
        {4},
        {5},
        {7},

    },

    [2] = {

        {24},
        {28},
        {8},
        {9},

    },

    [3] = {

        {29},
        {32},
        {26},
        {26},

    },

    [4] = {

        {27},
        {30},
        {31},
        {33},

    }

}

local randomSkins = {105, 106, 107, 102, 103, 104, 108, 109, 110, 247, 248, 254}


function onResourceStart()
    for i, v in ipairs(bots) do
        local randomSkin = math.random(1, #randomSkins)
        local randomSkin = randomSkins[randomSkin]
        local botLevel = math.random(1,4)
        local botGun = math.random(1, #levelWeapons[botLevel])
        local botGun = levelWeapons[botLevel][botGun][1]
        bot[i] = slothbot:spawnBot(v[1], v[2], v[3], 0, randomSkin, 0, 0, false, botGun, "waiting", false)
        setElementData(bot[i], "bot:id", i)
        setElementData(bot[i], "bot:level", botLevel)
        setElementData(bot[i], "bot:botRespawnInfo", {v[1], v[2], v[3], randomSkin, botLevel, i, botGun})
    end
end
onResourceStart()

function botDeath(ammo, killer, weapon, bodypart)
	if getElementData(source, "bot:id") then
        local botID = tonumber(getElementData(source, "bot:id"))
        local botLevel = getElementData(source, "bot:level")
        botRespawnInfo[botID] = getElementData(source, "bot:botRespawnInfo")
        bot[botID] = nil

        local playerRespekt = math.random(1,2) + math.random(1, botLevel)
        local organizationRespekt = math.random(1,2) + math.random(1, botLevel * 2)
        local randomMoney = math.random(100000, 250000)

        if getElementData(killer, "player:organization") then
		    exports.nrpg_interface:showPlayerNotification(killer, 'Zabito bota [LVL: '..botLevel..'], otrzymujesz: '..playerRespekt..' pkt. respektu, twoja organizacja otrzymuje: '..organizationRespekt..' pkt. respektu', 'success', 15000)
            exports["nrpg_db"]:dbSet("UPDATE pystories_organizacje_info SET punkty=punkty+? WHERE nazwa=?", organizationRespekt, getElementData(killer, "player:organization"))	
        else
            exports.nrpg_interface:showPlayerNotification(killer, 'Zabito bota [LVL: '..botLevel..'], otrzymujesz: '..playerRespekt..' pkt. respektu', 'success', 15000)
        end
        givePlayerMoney(killer, randomMoney)
        exports.nrpg_interface:showPlayerNotification(killer, 'Przeciwnik posiadał przy sobie portfel, okradasz go i otrzymujesz '..convertNumber(randomMoney)..' PLN', 'info', 15000)
        exports["nrpg_db"]:dbSet("UPDATE pystories_users SET respekt=respekt+? WHERE id=?", playerRespekt, getElementData(killer, "player:sid"))	

        setTimer( function()
            if botRespawnInfo[botID] ~= nil then
                local randomSkin = botRespawnInfo[botID][4] or 105
                local botLevel = botRespawnInfo[botID][5] or 1
                local botGun = botRespawnInfo[botID][7] or 1
                bot[botID] = slothbot:spawnBot(botRespawnInfo[botID][1], botRespawnInfo[botID][2], botRespawnInfo[botID][3], 0, randomSkin, 0, 0, false, botGun, "waiting", false)
                setElementData(bot[botID], "bot:id", botRespawnInfo[botID][6])
                setElementData(bot[botID], "bot:level", botLevel)
                setElementData(bot[botID], "bot:botRespawnInfo", {botRespawnInfo[botID][1], botRespawnInfo[botID][2], botRespawnInfo[botID][3], randomSkin, botLevel, botID, botGun})
                botRespawnInfo[botID] = nil
            end
        end, 15000, 1)
    end
end
addEventHandler("onPedWasted", getRootElement(), botDeath)

function convertNumber(amount) 
    local formatted = amount 
    while true do   
      formatted, ss = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
      if (ss==0) then 
        break 
      end 
    end 
    return formatted 
end