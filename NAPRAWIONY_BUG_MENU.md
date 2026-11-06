# 🔧 NAPRAWIONY BUG - Menu magazyniera pokazuje się na spawnie

## Data naprawy: 2026-11-06

---

## ❌ PROBLEM:

Po zalogowaniu i spawnie gracza **automatycznie pojawiało się menu "Magazynier" z rankingiem "Najlepsi pracownicy"** i nie dało się go zamknąć!

---

## 🔍 PRZYCZYNA:

**Skrypt `nrpg_jobMagazynier/c.lua` był NIEKOMPLETNY!**

### Co było źle:

1. **Linia 98:** `addEventHandler("onClientRender", root, drawInterface)` - menu renderowało się **ZAWSZE** od startu zasobu!
2. **Brak zmiennej kontrolującej:** Nie było `menuVisible` która określa czy menu ma być widoczne
3. **Brak obsługi markera:** Nie było `onClientMarkerHit` / `onClientMarkerLeave` - menu nie reagowało na wejście/wyjście z markera
4. **Przycisk "Zamknij okno" nie działał:** Nie było obsługi kliknięcia tego przycisku!

---

## ✅ ROZWIĄZANIE:

### 1. Dodano zmienną `data.menuVisible`:
```lua
data = {
    markerInfo = {{1773.54, -2047.99, 12.56}, "Magazynier", "Odbiór paczki"},
    jobMarker = nil,
    actualPage = "Strona główna",
    menuVisible = false, -- NAPRAWIONE: Menu nie powinno być widoczne od razu!
}
```

### 2. Dodano warunek w `drawInterface()`:
```lua
function drawInterface()
    -- NAPRAWIONE: Renderuj tylko gdy menu jest widoczne!
    if not data.menuVisible then return end
    
    -- ... reszta kodu ...
end
```

### 3. Dodano obsługę markera:
```lua
function startScript()
    data.jobMarker = createMarker(...)
    
    -- NAPRAWIONE: Dodano obsługę markera!
    addEventHandler("onClientMarkerHit", data.jobMarker, function(hitElement, matchingDimension)
        if hitElement == localPlayer and matchingDimension then
            data.menuVisible = true
            showCursor(true)
        end
    end)
    
    addEventHandler("onClientMarkerLeave", data.jobMarker, function(leaveElement, matchingDimension)
        if leaveElement == localPlayer and matchingDimension then
            data.menuVisible = false
            showCursor(false)
        end
    end)
end
```

### 4. Dodano działanie przycisku "Zamknij okno":
```lua
addEventHandler("onClientClick", root, function(btn, state)
    if btn == "left" and state == "up" then
        if not data.menuVisible then return end
        
        -- Obsługa przycisku "Zamknij okno"
        if data.actualPage == "Strona główna" then
            if isMouseIn(sx / 2 + 100/zoom, sy / 2 + 130/zoom, 248/zoom, 35/zoom) then
                data.menuVisible = false
                showCursor(false)
            end
        end
    end
end)
```

---

## 🎯 TERAZ:

- Menu pokazuje się **TYLKO** gdy gracz wejdzie w marker pracy magazyniera
- Menu znika gdy gracz wyjdzie z markera LUB kliknie "Zamknij okno"
- Kursor jest prawidłowo pokazywany/ukrywany

---

## 📦 Commit:

`6581e5c` - FIX KRYTYCZNY: Magazynier pokazywał się zawsze na spawnie!

---

## ⚠️ UWAGA:

Jeśli dalej widzisz jakieś inne menu na spawnie (np. "menu poprzedniego właściciela"), to jest to **INNY skrypt** - nie magazynier.

Możliwe lokalizacje:
- `/server/mods/deathmatch/resources/[Serwer]/nrpg_newlogin/` - system logowania
- `/server/mods/deathmatch/resources/[Serwer]/nrpg_interface/` - główny interfejs
- `/server/mods/deathmatch/resources/[admin]/` - panel admina

Jeśli dalej coś się pokazuje, zrób screena i powiedz dokładnie co tam jest napisane!
