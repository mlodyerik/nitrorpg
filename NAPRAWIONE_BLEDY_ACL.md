# 🔧 NAPRAWIONE BŁĘDY ACL I KONFIGURACJI

## Data naprawy: 2026-11-06

---

## ❌ ZNALEZIONE BŁĘDY:

### 1. **ACL.XML - Błędne nazwy zasobów**
```xml
<!-- ŹLE: -->
<object name="resource.[Serwer]/nrpg_autostart" />
<object name="resource.[Serwer]/nrpg_db" />

<!-- DOBRZE: -->
<object name="resource.nrpg_autostart" />
<object name="resource.nrpg_db" />
```

**Problem:** W MTA nazwy zasobów w ACL to zawsze `resource.nazwa_zasobu` - BEZ FOLDERÓW!

**Skutek:** Access denied przy próbie uruchomienia zasobów przez nrpg_autostart

---

### 2. **MTASERVER.CONF - Błędny wpis resource**
```xml
<!-- ŹLE: -->
<resource src="[Serwer]/nrpg_autostart" startup="1" protected="1"/>

<!-- DOBRZE: -->
<resource src="nrpg_autostart" startup="1" protected="1"/>
```

**Problem:** W mtaserver.conf używamy tylko nazwy zasobu, nie pełnej ścieżki z folderem!

**Skutek:** Serwer nie mógł znaleźć zasobu autostart

---

### 3. **NRPG_AUTOSTART/META.XML - Brak type="server"**
```xml
<!-- ŹLE: -->
<meta>
    <script src="server.lua"/>
</meta>

<!-- DOBRZE: -->
<meta>
    <info author="NitroRPG" version="2.0" name="Autostart System" type="script" />
    <script src="server.lua" type="server"/>
</meta>
```

**Problem:** Skrypty serwerowe powinny mieć `type="server"`

**Skutek:** Potencjalne problemy z wykrywaniem typu skryptu

---

## ✅ CO ZOSTAŁO NAPRAWIONE:

1. **acl.xml** - usunięto `[Serwer]/` z wszystkich nazw zasobów (10 wpisów)
2. **mtaserver.conf** - naprawiono nazwę zasobu autostart
3. **nrpg_autostart/meta.xml** - dodano type="server" i info

---

## 📋 ZASADY MTA:

### Nazwy zasobów w różnych miejscach:

| Plik | Format | Przykład |
|------|--------|----------|
| **ACL** | `resource.nazwa` | `resource.nrpg_autostart` |
| **mtaserver.conf** | `nazwa` | `nrpg_autostart` |
| **Lua getResourceFromName()** | `"nazwa"` | `getResourceFromName("nrpg_autostart")` |
| **Struktura folderów** | `[Folder]/nazwa` | `[Serwer]/nrpg_autostart` |

**WAŻNE:** Foldery `[Serwer]`, `[Admin]` itp. to tylko organizacja plików - w konfiguracji używamy TYLKO nazw zasobów!

---

## 🚀 CO DALEJ:

1. Pobierz zmiany z GitHuba (skrypt `UPDATE_SERWERA_POWERSHELL.bat`)
2. Zrestartuj serwer MTA
3. Sprawdź logi - powinno być:
   ```
   ✓ Uruchomione: 200+ zasobów
   ```

---

## 📊 STATYSTYKI:

- ✅ Sprawdzonych plików ACL: 1
- ✅ Sprawdzonych meta.xml: 213
- ✅ Znalezionych błędów XML: 0
- ✅ Naprawionych błędów ACL: 10
- ✅ Naprawionych błędów mtaserver.conf: 1
- ✅ Naprawionych meta.xml: 1

---

## ⚠️ OSTRZEŻENIA NA PRZYSZŁOŚĆ:

- **NIGDY** nie używaj `[Folder]/nazwa` w ACL
- **NIGDY** nie używaj `[Folder]/nazwa` w mtaserver.conf
- **NIGDY** nie używaj `[Folder]/nazwa` w getResourceFromName()
- **ZAWSZE** używaj tylko czystej nazwy zasobu w konfiguracji
- Foldery są tylko dla organizacji plików na dysku!

---

## 🔗 Commity:

- `37c81da` - Fix ACL: usunięto foldery z nazw zasobów
- `50cb8e4` - Fix mtaserver.conf i meta.xml
