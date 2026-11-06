	availableTuningMarkers = {
	--X, Y, Z, Vehicle Rotation (Use /markerpos to get perfect position and rotation (The command in sourceC.lua last row))
	{-2680.50, 235.99, 4.34, 90, 0, 0},
	{-2680.50, 245.15, 4.34, 90, 0, 0},
	{1098.09, 1765.20, 10.83, -90, 0, 0},
	{1098.43, 1756.45, 10.83, -90, 0, 0},
        {-1152.31, -459.09, 14.15, -90, 0, 0},
}



tuningMenu = {
	[1] = {
		["categoryName"] = getLocalizedText("menu.optical"),
		["availableUpgrades"] = {}, -- automatic getting optical upgrades to selected category
		["subMenu"] = {
			[1] = {["categoryName"] = getLocalizedText("menu.optical.frontBumper"), ["upgradeSlot"] = 14, ["tuningPrice"] = 50000, ["cameraSettings"] = {"bump_front_dummy", 130, 10, 6}},
			[2] = {["categoryName"] = getLocalizedText("menu.optical.rearBumper"), ["upgradeSlot"] = 15, ["tuningPrice"] = 50000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[3] = {["categoryName"] = getLocalizedText("menu.optical.hood"), ["upgradeSlot"] = 0, ["tuningPrice"] = 150000},
			[4] = {["categoryName"] = getLocalizedText("menu.optical.exhaust"), ["upgradeSlot"] = 13, ["tuningPrice"] = 75000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[5] = {["categoryName"] = getLocalizedText("menu.optical.spoiler"), ["upgradeSlot"] = 2, ["tuningPrice"] = 100000, ["cameraSettings"] = {"boot_dummy", -65, 3, 8}},
			[6] = {["categoryName"] = getLocalizedText("menu.optical.wheels"), ["upgradeSlot"] = 12, ["tuningPrice"] = 50000},
			[7] = {["categoryName"] = getLocalizedText("menu.optical.sideSkirt"), ["upgradeSlot"] = 3, ["tuningPrice"] = 5000, ["cameraSettings"] = {"ug_wing_right", 65, 3, 4}},
			[8] = {["categoryName"] = getLocalizedText("menu.optical.roofScoop"), ["upgradeSlot"] = 7, ["tuningPrice"] = 20000},
			[9] = {["categoryName"] = getLocalizedText("menu.optical.hidraulics"), ["upgradeSlot"] = 9, ["tuningPrice"] = 500000},
		}
	},	
	[2] = {
		["categoryName"] = getLocalizedText("menu.color"),
		["subMenu"] = {
					[5] = {["categoryName"] = getLocalizedText("Kolor świateł"), ["upgradeSlot"] = 18, ["tuningPrice"] = 5000000, ["tuningData"] = "headlight"},
				}
	}
}

function getMainCategoryIDByName(name)
	if name then
		for categoryID, row in ipairs(tuningMenu) do
			if name == row["categoryName"] then
				return categoryID
			end
		end
	end
	
	return -1
end