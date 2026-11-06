local showtime = tonumber(get("chatbubbles.DefaultTime"))
local characteraddition = tonumber(get("chatbubbles.PerCharacterAddition"))
local maxbubbles = get("chatbubbles.MaxBubbles")
if maxbubbles == "false" then maxbubbles = false else maxbubbles = tonumber(maxbubbles) end
local hideown = get("chatbubbles.HideOwn")
if hideown == "true" then hideown = true else hideown = false end