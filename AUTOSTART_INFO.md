# 🚀 SYSTEM AUTOSTART - NitroRPG

**Data:** 6 listopada 2026  
**Status:** ✅ AKTYWNY

---

## 📖 CO TO JEST AUTOSTART?

**Autostart** to inteligentny system automatycznego uruchamiania wszystkich zasobów serwera NitroRPG.

### ✅ Zalety:

1. **Prostsza konfiguracja** - w `mtaserver.conf` jest tylko JEDEN zasób
2. **Automatyczne zarządzanie** - nie musisz ręcznie dodawać każdego nowego zasobu
3. **Inteligentna kolejność** - krytyczne zasoby startują w odpowiedniej kolejności
4. **Łatwiejsza konserwacja** - dodanie nowego zasobu = automatyczny start
5. **Bezpieczeństwo** - autostart ma specjalne uprawnienia ACL

---

## 📋 JAK TO DZIAŁA?

### 1. mtaserver.conf
```xml
<!-- TYLKO JEDEN ZASÓB! -->
<resource src="[Serwer]/nrpg_autostart" startup="1" protected="1"/>
```

### 2. nrpg_autostart automatycznie:

**FAZA 1: Zasoby krytyczne (w tej kolejności)**
```
1. [Serwer]/nrpg_db     → Baza danych
2. [Serwer]/DB          → Baza danych 2
3. [Serwer]/DB2         → Baza danych 3
4. [Serwer]/nrpg_core   → Rdzeń systemu
5. [Serwer]/nrpg_lib    → Biblioteki
6. [Serwer]/nrpg_newlogin → System logowania
```

**FAZA 2: Pozostałe zasoby (automatycznie)**
```
Wszystkie zasoby zawierające:
- "nrpg"
- "community"
- "map"
- "mod_"
- "shader_"
- "gps"
- "slothbot"
- "discord"
- "obiekty"
- "tuning"
```

---

## 🔒 UPRAWNIENIA ACL

Autostart ma specjalną grupę ACL z pełnymi uprawnieniami:

```xml
<group name="NitroRPG_Autostart">
   <acl name="AutostartACL" />
   <object name="resource.[Serwer]/nrpg_autostart" />
</group>
```

### Uprawnienia AutostartACL:
- ✅ `function.startResource` - uruchamianie zasobów
- ✅ `function.stopResource` - zatrzymywanie zasobów
- ✅ `function.restartResource` - restart zasobów
- ✅ `function.getResources` - listowanie zasobów
- ✅ `function.getResourceState` - sprawdzanie stanu
- ✅ Wszystkie funkcje pomocnicze

---

## 📁 PLIKI

### 1. Główny skrypt autostart
**Lokalizacja:** `server/mods/deathmatch/resources/[Serwer]/nrpg_autostart/server.lua`

**Funkcje:**
- `startResourcesSafely()` - główna funkcja startująca zasoby
- `shouldAutoStart(resourceName)` - sprawdza czy zasób powinien startować
- `isResourceExcluded(resourceName)` - sprawdza wykluczenia

### 2. Meta autostart
**Lokalizacja:** `server/mods/deathmatch/resources/[Serwer]/nrpg_autostart/meta.xml`

### 3. Konfiguracja ACL
**Lokalizacja:** `server/mods/deathmatch/acl.xml`

---

## ➕ JAK DODAĆ NOWY ZASÓB?

### Metoda 1: Automatyczna (zalecana)

Jeśli nazwa zasobu zawiera: `nrpg`, `community`, `map`, `mod_`, `shader_`, `gps`, `slothbot`, `discord`, `obiekty`, `tuning`

**Wystarczy go utworzyć - automatycznie się uruchomi!**

```bash
# Przykład
mkdir server/mods/deathmatch/resources/[Serwer]/nrpg_mojnowyzasob
# Gotowe! Autostart uruchomi go przy starcie serwera
```

### Metoda 2: Dodanie do listy krytycznych

Jeśli zasób MUSI startować jako pierwszy (np. nowa baza danych):

1. Edytuj: `server/mods/deathmatch/resources/[Serwer]/nrpg_autostart/server.lua`
2. Dodaj do tablicy `startupOrder`:

```lua
local startupOrder = {
    "[Serwer]/nrpg_db",
    "[Serwer]/DB",
    "[Serwer]/DB2",
    "[Serwer]/nrpg_mojkrytycznyzasob",  -- DODAJ TUTAJ
    "[Serwer]/nrpg_core",
    ...
}
```

### Metoda 3: Dodanie nowego wzorca

Jeśli masz całą kategorię zasobów (np. wszystkie "pvp_"):

1. Edytuj: `server/mods/deathmatch/resources/[Serwer]/nrpg_autostart/server.lua`
2. Dodaj do tablicy `autoStartPatterns`:

```lua
local autoStartPatterns = {
    "nrpg",
    "community",
    "map",
    "pvp_",  -- DODAJ TUTAJ
    ...
}
```

---

## ❌ JAK WYKLUCZYĆ ZASÓB?

Jeśli chcesz aby zasób NIE startował automatycznie:

1. Edytuj: `server/mods/deathmatch/resources/[Serwer]/nrpg_autostart/server.lua`
2. Dodaj do tablicy `excludedResources`:

```lua
local excludedResources = {
    "nrpg_autostart",
    "nrpg_testowy",  -- DODAJ TUTAJ
}
```

---

## 🔍 LOGI I DEBUGGING

Autostart wyświetla szczegółowe logi przy starcie:

```
============================================
NITRORPG AUTOSTART inicjalizacja...
============================================
[FAZA 1] Uruchamianie zasobów krytycznych...
✓ [KRYTYCZNY] [Serwer]/nrpg_db uruchomiony
✓ [KRYTYCZNY] [Serwer]/DB uruchomiony
✓ [KRYTYCZNY] [Serwer]/DB2 uruchomiony
✓ [KRYTYCZNY] [Serwer]/nrpg_core uruchomiony
✓ [KRYTYCZNY] [Serwer]/nrpg_lib uruchomiony
✓ [KRYTYCZNY] [Serwer]/nrpg_newlogin uruchomiony
[FAZA 2] Uruchamianie pozostałych zasobów...
✓ nrpg_interface uruchomiony
✓ nrpg_hud uruchomiony
... (wszystkie zasoby)
============================================
NITRORPG AUTOSTART - Podsumowanie:
✓ Uruchomione: 204 zasobów
✗ Błędy: 0 zasobów
• Pominięte: 1 zasobów
============================================
Serwer NitroRPG gotowy!
```

**Sprawdzanie logów:**
```bash
tail -f server/mods/deathmatch/logs/server.log | grep AUTOSTART
```

---

## ⚙️ KONFIGURACJA

### Zmiana opóźnień

W `server.lua` możesz zmienić opóźnienia dla stabilności:

```lua
-- Opóźnienie przed fazą 1
setTimer(startResourcesSafely, 500, 1)  -- 500ms

-- Opóźnienie przed fazą 2
end, 2000, 1)  -- 2000ms (2 sekundy)

-- Opóźnienie przed podsumowaniem
end, 1000, 1)  -- 1000ms (1 sekunda)
```

### Dodanie własnych funkcji

Możesz dodać własne funkcje sprawdzające:

```lua
function isTestResource(resourceName)
    return string.find(resourceName, "test") ~= nil
end

function shouldAutoStart(resourceName)
    if isTestResource(resourceName) then
        return false  -- Nie startuj zasobów testowych
    end
    -- ... reszta kodu
end
```

---

## 🔄 PORÓWNANIE

### PRZED (stara metoda):
```xml
<resource src="[Serwer]/nrpg_db" startup="1" protected="1"/>
<resource src="[Serwer]/DB" startup="1" protected="1"/>
<resource src="[Serwer]/DB2" startup="1" protected="1"/>
<resource src="[Serwer]/nrpg_core" startup="1" protected="1"/>
<resource src="[Serwer]/nrpg_lib" startup="1" protected="1"/>
<resource src="[Serwer]/nrpg_newlogin" startup="1" protected="1"/>
<resource src="[Serwer]/nrpg_interface" startup="1" protected="0"/>
... (200+ linii)
```

**Problemy:**
- ❌ 200+ linii konfiguracji
- ❌ Trzeba ręcznie dodawać każdy zasób
- ❌ Łatwo o błędy
- ❌ Trudne zarządzanie

### PO (nowa metoda):
```xml
<resource src="[Serwer]/nrpg_autostart" startup="1" protected="1"/>
```

**Zalety:**
- ✅ 1 linia konfiguracji
- ✅ Automatyczne dodawanie zasobów
- ✅ Inteligentne zarządzanie
- ✅ Łatwa konserwacja

---

## 🚨 TROUBLESHOOTING

### Problem: Zasób nie startuje automatycznie

**Rozwiązanie:**
1. Sprawdź czy nazwa zasobu zawiera wzorzec z `autoStartPatterns`
2. Sprawdź czy zasób nie jest w `excludedResources`
3. Sprawdź logi autostart

### Problem: Błąd uprawień przy starcie

**Rozwiązanie:**
1. Sprawdź czy `acl.xml` ma grupę `NitroRPG_Autostart`
2. Zrestartuj serwer aby załadować nowe ACL
3. Sprawdź logi ACL

### Problem: Zasoby startują w złej kolejności

**Rozwiązanie:**
1. Dodaj zasób do `startupOrder` jeśli jest krytyczny
2. Zwiększ opóźnienie między fazami (zmień `2000` na `3000`)

### Problem: Autostart sam się nie uruchamia

**Rozwiązanie:**
1. Sprawdź czy w `mtaserver.conf` jest: `<resource src="[Serwer]/nrpg_autostart" startup="1" protected="1"/>`
2. Sprawdź czy folder `[Serwer]/nrpg_autostart` istnieje
3. Sprawdź czy `meta.xml` w autostart jest poprawny

---

## 📊 STATYSTYKI

```
Zasoby przed:        205 linii w mtaserver.conf
Zasoby po:           1 linia w mtaserver.conf
Oszczędność:         204 linie (-99.5%)
Czas startu:         ~5-7 sekund (wszystkie zasoby)
Uprawnienia ACL:     12 funkcji
```

---

## 🔗 POWIĄZANE PLIKI

- `mtaserver.conf` - Główna konfiguracja (zawiera tylko autostart)
- `acl.xml` - Uprawnienia dla autostart
- `[Serwer]/nrpg_autostart/server.lua` - Logika autostart
- `[Serwer]/nrpg_autostart/meta.xml` - Meta autostart

---

## 📝 NOTATKI

- **Nie usuwaj autostart z ACL!** - Ma specjalne uprawnienia
- **Chroniony zasób** - `protected="1"` zapobiega zatrzymaniu
- **Backup tworzony automatycznie** - przy każdej zmianie mtaserver.conf

---

## ✅ CHECKLIST

- [x] Autostart skonfigurowany
- [x] ACL zaktualizowany
- [x] mtaserver.conf uproszczony (1 zasób)
- [x] Backup utworzony
- [x] Dokumentacja dostępna
- [x] Wszystko commitnięte na git

---

**Autorzy:** Kiro AI Assistant  
**Data utworzenia:** 6 listopada 2026  
**Wersja:** 1.0  
**Status:** ✅ PRODUCTION READY
