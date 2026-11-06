local webhooks = { -- Weebhooki

	
	{"Czaty", "Czaty", "https://discord.com/api/webhooks/816254246394658837/jkcyQ_CUDDG1w2V1mAxAl6M7knhCpYdZTFVMgRNcRVVRknt1Zw-wFgOIQaPLmh_GQMQR"},
	{"Przelewy", "Przelewy", "https://discord.com/api/webhooks/816254141134274581/9obnxi0gNOO_VGb3MnuELgNyb2VUoupa5DNc2VSCgLrmGSZ9drE3RS2uSEeO2-Xtn2Fc"},
	{"PW", "PW", "https://discord.com/api/webhooks/816254432164446280/NntkzFsHkyAzvtInxmOweEpJR8eSWvpGEOT_WhweCn5N9ayOoFZIKS-IKJoSZhsBp8O-"},
	{"Reporty", "Reporty", "https://discord.com/api/webhooks/816253976545591308/wScEd_l9dLJbSZuyCt3tcWWAP1QmCSAs1j4T9ADDNUdBx9q0YW_WVnv8Qjew8ze9_R33"},
	{"Logowania", "Logowania", "https://discord.com/api/webhooks/816254875418624030/FN-M52xuWAb1pE3k1YbsLQ02STd9Po4AuOVeAGnx2x1QFVofenD5rO2OZ7mVxogAFzu6"},
	{"Giełda", "Giełda", "https://discord.com/api/webhooks/816254772892926013/w4L_7ngbb-FLT6lhveMCqtA5VgINUbl82bIeToVtJ9noIjms3JuT_4BTZQLr0X6woB8j"},
	{"Salon", "Salon", "https://discord.com/api/webhooks/816254689040662529/huCI8Pr2JwIkGE3KhgChyfTWnRDsWS_xxd1b1o3mqaOqdBzYQEPX1LpShPwsx_2kyGId"},
        {"logi_sapd", "logi_sapd", "https://discord.com/api/webhooks/884152059409100800/mIo9jJ3pKZwyTNQwpKfqNfFR86ZW7pbWv8sLuD1FoPmK3yx1QvYK1PFUPJdKaQoTrtal"},        
		{"logi_sara", "logi_sara", "https://discord.com/api/webhooks/884152059409100800/mIo9jJ3pKZwyTNQwpKfqNfFR86ZW7pbWv8sLuD1FoPmK3yx1QvYK1PFUPJdKaQoTrtal"},
        {"logi_safd", "logi_safd", "https://discord.com/api/webhooks/884152059409100800/mIo9jJ3pKZwyTNQwpKfqNfFR86ZW7pbWv8sLuD1FoPmK3yx1QvYK1PFUPJdKaQoTrtal"},
	{"kary-adm", "kary-adm", "https://discord.com/api/webhooks/816253645405683732/C_priDdcSld2DyYritr9G3omgX4c28zz1PFTSYdw2dW-joL7PvwUvFSfMf7lAy73PExy"},
	{"Komendy", "Komendy", "https://discord.com/api/webhooks/816254998261399582/eqZ_dFsTKlSyXhZowTa2Lkt6CQl8NrgFqI_47N9xEG7V4vvxqH-jPtqqvrdJro3HiuK-"},
	{"Wymiany", "Wymiany", "https://discord.com/api/webhooks/824935055733424159/IC4eJmkvyGt2Po8rVEhRP7c7cNww5Mut_-S6lHeQFhfLoY4hDA1B5OYIwbUdaP5_eIPt"},
        {"ParkingPoli", "ParkingPoli", "https://discord.com/api/webhooks/884151915443802112/gUN-zV80IX2xtO8-DCaOeCxlgcnmWLvL0KRRt8Oortia50Q_DhE4t2puG_hCkDvjf4fu"},

	
	
}

function connectWeb(message, user) -- Wiadomosc fetchRemote
	for k, v in pairs(webhooks) do
		if user == v[1] then
			local czas1 = getTimestamp()
			local czas2 = getRealTime(czas1)
			local czas3 = getRealTime()
			local formattedDate = string.format("%02d.%02d.%02d", czas2.monthday, czas2.month+1, czas2.year+1900)
			local formattedTime = string.format("%02d:%02d", czas3.hour, czas3.minute+2)
	
			local sendOptions = {
				formFields = {
					username = (user == v[1]) and v[2],
					content = "["..formattedDate.." - "..formattedTime.."]  -  "..message,
				},
				method = "POST"
			}
			fetchRemote(v[3], sendOptions, function() end)
		end
	end
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end