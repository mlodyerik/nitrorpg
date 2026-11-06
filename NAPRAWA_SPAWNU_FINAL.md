# 🔧 FINALNA NAPRAWA SYSTEMU SPAWNU

## Data: 2026-11-06

---

## ❌ PROBLEMY:

### 1. **Czarny ekran po spawnie**
- Po wyborze spawnu widać tylko czarny ekran
- Gracz jest zespawnowany ale nie widzi nic
- Radar działa, nick się pokazuje ale brak obrazu

### 2. **Bugująca kamera (wcześniej)**
- Kamera nad ziemią (widok z nieba)
- Nie można sterować postacią
- Gracz "wisi" w powietrzu

---

## 🔍 PRZYCZYNY:

### Problem 1: Błędna kolejność fadeCamera (NAPRAWIONE wcześniej)
W `nrpg_core/s_main.lua`:
```lua
-- ŹLE:
fadeCamera(source, true)  -- Włączenie kamery
spawnPlayer(...)          -- Spawn gracza
```
Kamera się włączała PRZED spawnem gracza → widok z nieba

### Problem 2: Brak fadeCamera po stronie klienta
W `nrpg_newlogin/c_login.lua` w funkcji `login.spawnPlayer()`:
```lua
-- BRAKOWAŁO:
fadeCamera(true, 1.0)
setCameraTarget(localPlayer)
```

---

## ✅ ROZWIĄZANIE:

### 1. Serwer (`nrpg_core/s_main.lua`):
```lua
addEvent("core:spawnPlayer", true)
addEventHandler("core:spawnPlayer", root, function()
	local pos=getElementData(source,"player:spawn")
	if not pos then return end
	
	-- Spawn gracza
	spawnPlayer(source, pos[1], pos[2], pos[3])
	setElementDimension(source, pos[5] or 0)
	setElementInterior(source, pos[4] or 0)
	setCameraTarget(source, source)
	
	-- Fade in kamery
	fadeCamera(source, true, 1.0)
	
	toggleControl(source,"fire", false)
	toggleControl(source,"aim_weapon", false)
	loadPlayerData(source)
end)
```

### 2. Klient (`nrpg_newlogin/c_login.lua`):
```lua
login.spawnPlayer = function()
    -- ... czyszczenie UI ...
    
    resetFarClipDistance()
    
    -- NAPRAWIONE: Dodano fadeCamera po stronie klienta!
    fadeCamera(true, 1.0)
    setCameraTarget(localPlayer)

    -- ... reszta kodu ...
    
    triggerServerEvent("core:spawnPlayer", localPlayer)
end
```

---

## 📋 KOLEJNOŚĆ DZIAŁANIA (poprawna):

1. **Klient:** Gracz wybiera spawn w menu
2. **Klient:** `login.spawnPlayer()` wywołane
3. **Klient:** Usuwa UI logowania
4. **Klient:** `fadeCamera(true)` + `setCameraTarget(localPlayer)` ← **NOWE!**
5. **Klient → Serwer:** Trigger `core:spawnPlayer`
6. **Serwer:** `spawnPlayer()` - tworzy gracza w świecie
7. **Serwer:** Ustawia dimension i interior
8. **Serwer:** `setCameraTarget(source, source)` - ustawia kamerę na gracza
9. **Serwer:** `fadeCamera(source, true)` - upewnia się że kamera widoczna
10. **Serwer:** Ładuje dane gracza

---

## 🎯 WYNIK:

- ✅ Gracz widzi postać po spawnie
- ✅ Kamera prawidłowo ustawiona
- ✅ Można sterować postacią
- ✅ Brak czarnego ekranu
- ✅ Brak widoku z nieba

---

## 📦 Commity:

- `77cb7ee` - Pierwsza próba naprawy (z timerem)
- `3b8b03a` - Uproszczenie (usunięto timer)
- `815d951` - **FINALNA NAPRAWA** - dodano fadeCamera po stronie klienta

---

## ⚠️ UWAGI:

- fadeCamera i setCameraTarget muszą być zarówno po stronie **klienta** jak i **serwera**
- spawnPlayer ZAWSZE przed fadeCamera
- setCameraTarget po spawnPlayer
