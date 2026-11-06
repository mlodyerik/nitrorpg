local replace = {
	[8594] = "floor_1",
	[8593] = "floor_2",
	[8087] = "floor_3",
	[8081] = "wall_1",
	[8082] = "wall_2",
	[8083] = "wall_3",
	[8084] = "wall_4",
	[8085] = "wall_5",
	[8086] = "wall_6",
	[8595] = "wall_7",
	[16747] = "pod_suf_biale",
	[16746] = "pod_suf_dyw",
	[16745] = "pod_suf_dyw2",
	[16744] = "pod_suf_pan",
	[16743] = "pod_suf_pan2",
	[16742] = "pod_suf_plytki",
	[16741] = "pod_suf_plytki2",
	[16740] = "pod_suf_plytki3",
	[10229] = "sciana_biala",
	[10230] = "sciana_blekitna",
	[10231] = "sciana_zielona",
	[10228] = "sciana_kremowa",
	[10227] = "sciana_drzwi_biala",
	[16739] = "sciana_drzwi_blekitna",
	[16738] = "sciana_drzwi_zielona",
	[2028] = "devone",
	[1719] = "devps",
	[1429] = "hqtv1",
	[14772] = "lowtv1",
	[1809] = "mhifi1",
	[2225] = "mhifi2",
	[2227] = "mhifi3",
	[1781] = "mtv1",
	[1750] = "mtv2",
	[1749] = "mtv3",
	[1751] = "mtv4",
	[1792] = "protv1",
	[1791] = "protv2",
	[2344] = "tvrem",
	[8981] = "pumpkin",
	[2014] = "kruton9000",
	[2015] = "ramp",
	[2016] = "welder",
	[2018] = "dev_tool",
	[2019] = "dev_tool2",
	[2020] = "dev_tool3",
	[2021] = "tire",
	[2022] = "tire2",
	[1630] = "tools",
	[18000] = "choinka",
	[1942] = "prezenty",
	[1943] = "skarpety",
	[9590] = "greenscreen",
	[1310] = "first_backpack",
	[328] = "second_backpack",
	[2054] = "first_cap",
	[2052] = "second_cap",
	[2203] = "pot_one",
	[2194] = "pot_two",
	[1516] = "garden_table",
	[2777] = "garden_chair",
	[2190] = "macbook",
	[14820] = "dj1",
	[1964] = "klawiatura_mysz",
	[2882] = "monitor",
	[1840] = "speaker",
	[2006] = "podest",
	[1841] = "speaker2",
	[3067] = "podnosnik_maly",
	[1958] = "podnosnik_duzy",
	[1784] = "pc",
	[3964] = "toolkit",
	[3963] = "toolbox",
	[2025] = "automat_sprunk",
	[3193] = "automat2",
	[1657] = "drukarka",
	[1658] = "kopierer",
	[1671] = "modern_chairr",
	[2402] = "backpack_vice",
	[2256] = "modern_frame",
	[2211] = "szafka1",
	[3051] = "dev_elevator",
	[13360] = "dev_elevatord",
	[962] = "dev_elevatorb",
	[330] = "ifruitx",
	[2210] = "kitchen1",
	[1316] = "kitchen2",
	[1317] = "kitchen3",
	[1944] = "kitchen4",
	[1945] = "kitchen5",
	[14728] = "shelf_h",
	[2617] = "sofa_h",
	[1707] = "sofa2_h",
	[2834] = "dywan1_h",
	[2847] = "dywan2_h",
	[2835] = "dywan3_h",
	[2836] = "dywan4_h",
	[1839] = "tv_h",
	[3921] = "fotel_h",
	[2122] = "fotel2_h",
	[2013] = "rtv1_h",
	[2017] = "rtv2_h",
	[2287] = "obraz1_h",
	[2285] = "obraz2_h",
	[2284] = "obraz3_h",
	[2282] = "obraz4_h",
	[2283] = "obraz5_h",
	[2263] = "obraz6_h",
	[2250] = "grass1_h",
	[2249] = "grass2_h",
	[2247] = "grass3_h",
	[2085] = "tablek_h",
	[2086] = "chairk_h",
	[16353] = "book_h",
	[2331] = "shelf2_h",
	[2585] = "shelf3_h",
	[1700] = "bed_h",
	[2097] = "bath_h",
	[14480] = "sinkb_h",
	[2521] = "toilet_h",
	[14494] = "heater_h",
	[14481] = "accessoriesb_h",
	[14806] = "speaker_h",
	[1562] = "sofa3_h",
	[1826] = "modern_desk_h",
	[1491] = "modern_doors_h",
	[2123] = "chairk2_h",
	[2592] = "tables_h",
	[14556] = "wardrobe_h",
	-- Od wersji 1.2 - Furniture update
	[8969] = "Armchair",
	[8608] = "Bar_chair",
	[8607] = "Bath",
	[8596] = "BBQ",
	[7862] = "Bed", -- z szafką
	[7649] = "Bedside_table",
	[7648] = "Bookshelf",
	[7647] = "Ceiling_lamp",
	[7646] = "Console1",
	[7645] = "Console2",
	[7644] = "Couch",
	[7643] = "Dining_chair",
	[7642] = "Dining_table",
	[7641] = "High_cabinet",
	[7640] = "High_corner",
	[7639] = "High_cupboard",
	[7638] = "High_oven",
	[7637] = "High_washer",
	[7609] = "Kitchen_island",
	[7608] = "Lamp",
	[7607] = "Low_cabinet",
	[7598] = "Low_corner",
	[7578] = "Low_cupboard",
	[7577] = "Low_oven",
	[7576] = "Low_washer",
	[7575] = "Monitor2",
	[7574] = "Notebook",
	[7573] = "Office_chair",
	[7572] = "Office_desk",
	[7571] = "Outside_bench",
	[7570] = "Outside_table",
	[7569] = "PC2",
	[7568] = "Plant",
	[7567] = "Sink",
	[7566] = "Towel_holder",
	[7565] = "Tv",
	[7564] = "TvStand_1",
	[7563] = "Wall_lamp",
	[7562] = "Wardrobe",
	-- Od wersji 1.3 - Furniture update v2
	[7543] = "chillidogs",
	[7542] = "noodle",
	[7541] = "woodhouse",
	[955] = "sprunk",
	[5764] = "sirens",
	[18472] = "Cross1",
	[18471] = "MetalFork1",
	[18470] = "MetalKnife1",
	[18448] = "SweetsSaucepan1",
	[18215] = "SweetsSaucepan2",
	[18214] = "SweetsBed1",
	[18213] = "Radiator1",
	[18212] = "SauceBottle1",
	[18211] = "SauceBottle2",
	[18210] = "FireplaceSurround1",
	[18209] = "Fireplace1",
	[18208] = "WRockingHorse1",
	[18207] = "WRockingChair1",
	[18206] = "MedicCase1",
	[18205] = "MCoffeeMachine1",
}
local shaders = {}
local textures = {}
local originalTXD = engineLoadTXD("data/models/textures.txd")

for k,v in pairs(replace) do
	if k ~= 955 then
		removeWorldModel(k, 9999, 0, 0, 0)
	end
	if fileExists("data/models/" .. v .. ".txd") then
		engineImportTXD(engineLoadTXD("data/models/" .. v .. ".txd"), k)
	else
		engineImportTXD(originalTXD, k)
	end
	if fileExists("data/models/" .. v .. ".dff") then
		engineReplaceModel(engineLoadDFF("data/models/" .. v .. ".dff"), k)
	end
	if fileExists("data/models/" .. v .. ".col") then
		engineReplaceCOL(engineLoadCOL("data/models/" .. v .. ".col"), k)
	end
end

function createTextureForObject(object, textureid)
	if not shaders[object] then
		shaders[object] = {}
	end
	if not shaders[object][textureid] then
		shaders[object][textureid] = dxCreateShader("shader.fx")
	end
end

function setObjectTexture(object, texture, textureid)
	if not textures[texture] then
		textures[texture] = dxCreateTexture("data/images/" .. texture .. ".jpg")
	end
	createTextureForObject(object, textureid)
	dxSetShaderValue(shaders[object][textureid], "PdTexture", textures[texture])
	dxSetShaderValue(shaders[object][textureid], "PdBrightness", 1)
	engineApplyShaderToWorldTexture(shaders[object][textureid], textureid, object)
end

local loadedObjects = {}

function reloadObjectTextures(target)
	if not loadedObjects[target] then
		if getElementData(target, "aTexture") then
			setObjectTexture(target, getElementData(target, "aTexture"), "a")
		end
		if getElementData(target, "bTexture") then
			setObjectTexture(target, getElementData(target, "bTexture"), "b")
		end
		loadedObjects[target] = true
	end
end

function reloadObjectsTextures(target)
	if not target then
		for k,v in pairs(getElementsByType("object")) do
			reloadObjectTextures(v)
		end
	else
		reloadObjectTextures(target)
	end
end
addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "object" then
		reloadObjectsTextures(source)
	end
end)

addEventHandler("onClientElementDataChange", root, function(theKey, oldValue, newValue)
	if source and getElementType(source) == "object" then
		if theKey == "aTexture" then
			setObjectTexture(source, newValue, "a")
			loadedObjects[source] = true
		elseif theKey == "bTexture" then
			setObjectTexture(source, newValue, "b")
			loadedObjects[source] = true
		end
	end
end)