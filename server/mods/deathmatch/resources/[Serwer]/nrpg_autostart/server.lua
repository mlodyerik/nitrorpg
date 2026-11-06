-- ============================================================================
-- NITRORPG AUTOSTART SYSTEM
-- Automatyczne uruchamianie wszystkich zasobów serwera
-- ============================================================================

local startupOrder = {
    -- Krytyczne zasoby - bazy danych (PIERWSZEŃSTWO)
    "nrpg_db",
    "DB",
    "DB2",
    
    -- Core system
    "nrpg_core",
    "nrpg_lib",
    
    -- Login system
    "nrpg_newlogin",
}

-- Wzorce zasobów do automatycznego uruchamiania
local autoStartPatterns = {
    "nrpg",
    "community",
    "map",
    "mod_",
    "shader_",
    "gps",
    "slothbot",
    "discord",
    "obiekty",
    "tuning"
}

-- Zasoby wyłączone z autostartu (jeśli są problematyczne)
local excludedResources = {
    "nrpg_autostart", -- Nie startuj samego siebie!
}

local startedCount = 0
local failedCount = 0
local excludedCount = 0

function isResourceExcluded(resourceName)
    for _, excluded in ipairs(excludedResources) do
        if resourceName == excluded then
            return true
        end
    end
    return false
end

function shouldAutoStart(resourceName)
    -- Sprawdź czy zasób jest wykluczony
    if isResourceExcluded(resourceName) then
        return false
    end
    
    -- Sprawdź wzorce
    for _, pattern in ipairs(autoStartPatterns) do
        if string.find(resourceName, pattern) then
            return true
        end
    end
    
    return false
end

function startResourcesSafely()
    outputDebugString("============================================", 3)
    outputDebugString("NITRORPG AUTOSTART - Rozpoczynam ładowanie zasobów", 3)
    outputDebugString("============================================", 3)
    
    -- FAZA 1: Zasoby krytyczne w określonej kolejności
    outputDebugString("[FAZA 1] Uruchamianie zasobów krytycznych...", 3)
    for _, resourcePath in ipairs(startupOrder) do
        local resource = getResourceFromName(resourcePath)
        if resource then
            local state = getResourceState(resource)
            if state ~= "running" then
                if startResource(resource, true) then
                    outputDebugString("✓ [KRYTYCZNY] " .. resourcePath .. " uruchomiony", 3)
                    startedCount = startedCount + 1
                else
                    outputDebugString("✗ [BŁĄD] Nie można uruchomić: " .. resourcePath, 1)
                    failedCount = failedCount + 1
                end
                -- Małe opóźnienie dla stabilności
                setTimer(function() end, 100, 1)
            else
                outputDebugString("• [KRYTYCZNY] " .. resourcePath .. " już działa", 3)
            end
        else
            outputDebugString("⚠ [OSTRZEŻENIE] Nie znaleziono zasobu: " .. resourcePath, 2)
        end
    end
    
    -- Opóźnienie przed fazą 2
    setTimer(function()
        -- FAZA 2: Pozostałe zasoby automatycznie
        outputDebugString("[FAZA 2] Uruchamianie pozostałych zasobów...", 3)
        
        local allResources = getResources()
        for _, resource in ipairs(allResources) do
            local resourceName = getResourceName(resource)
            local state = getResourceState(resource)
            
            if state ~= "running" and shouldAutoStart(resourceName) then
                if startResource(resource, true) then
                    outputDebugString("✓ " .. resourceName .. " uruchomiony", 3)
                    startedCount = startedCount + 1
                else
                    outputDebugString("✗ Błąd uruchamiania: " .. resourceName, 1)
                    failedCount = failedCount + 1
                end
            elseif isResourceExcluded(resourceName) then
                excludedCount = excludedCount + 1
            end
        end
        
        -- Podsumowanie
        setTimer(function()
            outputDebugString("============================================", 3)
            outputDebugString("NITRORPG AUTOSTART - Podsumowanie:", 3)
            outputDebugString("✓ Uruchomione: " .. startedCount .. " zasobów", 3)
            if failedCount > 0 then
                outputDebugString("✗ Błędy: " .. failedCount .. " zasobów", 1)
            end
            outputDebugString("• Pominięte: " .. excludedCount .. " zasobów", 3)
            outputDebugString("============================================", 3)
            outputDebugString("Serwer NitroRPG gotowy!", 3)
        end, 1000, 1)
        
    end, 2000, 1) -- 2 sekundy opóźnienia po krytycznych zasobach
end

-- Uruchom przy starcie autostart
addEventHandler("onResourceStart", resourceRoot, function()
    outputDebugString("============================================", 3)
    outputDebugString("NITRORPG AUTOSTART inicjalizacja...", 3)
    outputDebugString("============================================", 3)
    
    -- Małe opóźnienie dla stabilności
    setTimer(startResourcesSafely, 500, 1)
end)