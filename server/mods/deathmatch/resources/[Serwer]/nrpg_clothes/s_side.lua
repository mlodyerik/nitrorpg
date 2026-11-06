local koszulki = {
{"tshirtilovels", "tshirt", 0}, 
{"field", "field", 0}, 
{"tshirterisorn", "tshirt", 0}, 
{"tshirtblunts", "tshirt", 0}, 
{"coach", "coach", 0},
{"hoodyarockstar", "hoodya", 0}, 
}

local spodnie = {
{"worktrgrey", "worktr", 2}, 
{"tracktrgang", "tracktr", 2},
{"bbshortwht", "boxingshort", 2}, 
{"tracktrpro", "tracktr", 2}, 
{"denimsred", "jeans", 2}, 
{"denimsgang", "jeans", 2}, 
}

local boty = {
{"sandalsock", "flipflop", 3}, 
{"hitop", "bask1", 3},
{"sneakerprowht", "sneaker", 3}, 
{"bask2heatwht", "bask1", 3}, 
{"bask2heatband", "bask1", 3}, 
{"bask1eris", "bask1", 3}, 
}

function setCJClothes()
local losowanko = math.random(1, #koszulki)
local losowanko = math.random(1, #spodnie)
local losowanko = math.random(1, #boty)
    addPedClothes(source, koszulki[losowanko][1], koszulki[losowanko][2], 0)
    addPedClothes(source, spodnie[losowanko][1], spodnie[losowanko][2], 2)
    addPedClothes(source, boty[losowanko][1], boty[losowanko][2], 3)
end 
addEventHandler("onPlayerJoin", getRootElement(), setCJClothes)