# 🔧 ROZWIĄZYWANIE PROBLEMÓW - NitroRPG

## 🎯 Szybki przewodnik naprawy

Ten dokument zawiera rozwiązania wszystkich znanych problemów z serwerem NitroRPG.

---

## 🚨 Problem #1: Panel użytkownika (F5) nie zamyka się

### Objawy:
- Po wciśnięciu F5 panel się otwiera
- Nie można zamknąć panelu przyciskiem F5
- Kursor pozostaje na ekranie
- Nie można grać

### ✅ Rozwiązanie:

**Metoda 1: Użyj klawisza ESC**
```
Wciśnij ESC → panel się zamknie
```

**Metoda 2: Komenda konsoli**
1. Wciśnij **F8** (otwiera konsolę)
2. Wpisz: `/closepanel`
3. Wciśnij **Enter**

**Metoda 3: Restart zasobu**
```
/restart nrpg_userpanel
```

### 📝 Szczegóły:
Zobacz plik `NAPRAWA_PANELU.md` - zawiera pełną dokumentację naprawy.

### ⚙️ Przyczyna:
Oryginalny kod blokował zamykanie panelu podczas otwierania paczek (`main.rolling == true`) i nie miał obsługi klawisza ESC.

---

## 🚨 Problem #2: Błąd SQL "Table doesn't exist"

### Objawy:
```
WARNING: dbPoll failed; Table 'nitrorpg.aj' doesn't exist
```
Błąd powtarza się co 10 sekund w logach serwera.

### ✅ Rozwiązanie:

**Krok 1: Dodaj brakujące tabele**
1. Otwórz phpMyAdmin: `http://localhost/phpmyadmin`
2. Wybierz bazę `nitrorpg`
3. Przejdź do zakładki **"SQL"**
4. Otwórz plik `database/UPDATE_add_missing_tables.sql`
5. Skopiuj całą zawartość i wklej do phpMyAdmin
6. Kliknij **"Wykonaj"**

**Krok 2: Zrestartuj serwer**
```
quit
```
Następnie uruchom ponownie `MTA Server.exe`

### 📝 Szczegóły:
Zobacz plik `NAPRAWA_BRAKUJACYCH_TABEL.md` - zawiera pełną dokumentację brakujących tabel (aj, pystories_organizacje_info, pystories_marihuana, lss_domy).

### ⚙️ Przyczyna:
W bazie danych brakowało 4 tabel używanych przez różne systemy serwera (Admin Jail, Organizacje, Marihuana, Legacy domy).

---

## 🚨 Problem #3: Błąd SQL "Unknown column 'date'"

### Objawy:
```
ERROR: [MySQL] Error (1054): Unknown column 'date' in 'where clause'
ERROR: [MySQL] Error (1054): Unknown column 'owner_name' in 'field list'
ERROR: [MySQL] Error (1054): Unknown column 'interiorSize' in 'field list'
```

### ✅ Rozwiązanie:

**Krok 1: Wykonaj skrypt UPDATE**
1. Otwórz phpMyAdmin: `http://localhost/phpmyadmin`
2. Wybierz bazę `nitrorpg`
3. Przejdź do zakładki **SQL**
4. Otwórz plik `database/UPDATE_fix_missing_columns.sql`
5. Skopiuj zawartość i wklej do phpMyAdmin
6. Kliknij **Wykonaj**

**Krok 2: Zweryfikuj kolumny**
```sql
SHOW COLUMNS FROM pystories_houses;
```
Powinny być kolumny: `owner_name`, `interiorSize`, `date`

### 📝 Szczegóły:
Zobacz plik `NAPRAWA_BAZY.md` - zawiera pełną dokumentację naprawy bazy danych.

### ⚙️ Przyczyna:
Tabela `pystories_houses` była niepełna - brakowało 3 kolumn używanych przez skrypty PHP.

---

## 🚨 Problem #4: Błąd ACL "Line 343: Error reading end tag"

### Objawy:
```
ERROR: Error parsing acl.xml - Line 343: Error reading end tag
```

### ✅ Rozwiązanie:

**Ten problem jest już naprawiony w repozytorium!**

Jeśli nadal występuje:
1. Usuń plik `server/mods/deathmatch/acl.xml`
2. Skopiuj naprawiony plik z repozytorium
3. Zrestartuj serwer

### ⚙️ Przyczyna:
Nieprawidłowa struktura XML - grupa `DevACL` nie była zamknięta przed dodaniem nowych sekcji.

---

## 🚨 Problem #5: Duplicate column name 'owner_name'

### Objawy:
```
#1060 - Duplicate column name 'owner_name'
```
Podczas wykonywania skryptu UPDATE.

### ✅ Rozwiązanie:

**Użyj zaktualizowanego skryptu UPDATE v1.2**

Nowa wersja sprawdza czy kolumna już istnieje przed dodaniem:
```sql
-- Sprawdza w information_schema czy kolumna istnieje
WHERE TABLE_SCHEMA = 'nitrorpg' 
AND TABLE_NAME = 'pystories_houses' 
AND COLUMN_NAME = 'owner_name'
```

**Jeśli błąd występuje:**
1. Sprawdź którą wersję UPDATE masz
2. Użyj pliku `database/UPDATE_fix_missing_columns.sql` (v1.2)
3. Ten plik automatycznie pomija istniejące kolumny

### 📝 Szczegóły:
Zobacz plik `NAPRAWA_BAZY.md` sekcja "Wersja 1.2".

---

## 🚨 Problem #6: Serwer nie startuje

### Objawy:
- Okno konsoli MTA Server się zamyka
- Błąd "Failed to load resource"
- Serwer crashuje przy starcie

### ✅ Rozwiązanie:

**Krok 1: Sprawdź logi**
```
server/mods/deathmatch/logs/server.log
```

**Krok 2: Najczęstsze przyczyny**

| Błąd | Rozwiązanie |
|------|-------------|
| `Can't connect to MySQL server` | Sprawdź czy XAMPP MySQL działa |
| `Access denied for user 'root'` | Sprawdź hasło w `nrpg_db/s_db.lua` |
| `Unknown database 'nitrorpg'` | Utwórz bazę danych (zobacz INSTALL.md) |
| `Resource 'nrpg_db' failed` | Sprawdź połączenie w `[Serwer]/nrpg_db/s_db.lua` |
| `Failed to parse acl.xml` | ACL naprawiony - pobierz nową wersję z repo |

**Krok 3: Zweryfikuj konfigurację**
```lua
-- server/mods/deathmatch/resources/[Serwer]/nrpg_db/s_db.lua
dbConnection = dbConnect("mysql", "dbname=nitrorpg;host=127.0.0.1;port=3306;charset=utf8mb4", "root", "")
```

**Krok 4: Testuj połączenie z bazą**
1. Otwórz XAMPP Control Panel
2. Sprawdź czy MySQL jest uruchomiony (zielony)
3. Otwórz phpMyAdmin: `http://localhost/phpmyadmin`
4. Sprawdź czy baza `nitrorpg` istnieje

---

## 🚨 Problem #7: Zasoby nie ładują się

### Objawy:
- Serwer startuje ale niektóre funkcje nie działają
- Brak pojazdów / domów / prac
- Błędy w konsoli: "call: failed to call"

### ✅ Rozwiązanie:

**Krok 1: Sprawdź mtaserver.conf**
```xml
<config>
    <resource src="nrpg_db" startup="1" protected="1"/>
    <resource src="DB" startup="1" protected="1"/>
    <resource src="DB2" startup="1" protected="1"/>
    <!-- ... wszystkie inne zasoby -->
</config>
```

**Krok 2: Restart wszystkich zasobów**
```
/refresh
/restart all
```

**Krok 3: Sprawdź ACL**
Plik `acl.xml` musi zawierać grupy:
- `NitroRPG_Database` (dbConnect, dbQuery, dbExec)
- `NitroRPG_Core` (general.http, function.*)
- `NitroRPG_Factions` (dbQuery, function.callRemote)

---

## 🚨 Problem #8: Discord bot nie działa

### Objawy:
- Brak integracji z Discordem
- Błąd "Can't connect to Discord"
- Komendy Discord nie działają

### ✅ Rozwiązanie:

**Krok 1: Sprawdź konfigurację**
```xml
<!-- server/mods/deathmatch/resources/[DC]/discord/config.xml -->
<config>
    <token>YOUR_DISCORD_BOT_TOKEN</token>
    <guild>YOUR_GUILD_ID</guild>
</config>
```

**Krok 2: Uzyskaj token bota**
1. Idź do: https://discord.com/developers/applications
2. Utwórz nową aplikację
3. Przejdź do sekcji **Bot**
4. Kliknij **Copy** przy **Token**
5. Wklej token do `config.xml`

**Krok 3: Zaproś bota na serwer**
1. W Developer Portal przejdź do **OAuth2 → URL Generator**
2. Zaznacz scope: **bot**
3. Zaznacz permissions: **Administrator**
4. Skopiuj wygenerowany link i otwórz w przeglądarce
5. Wybierz swój serwer Discord

**Krok 4: Restart zasobu**
```
/restart discord
/restart discord-events
```

---

## 🚨 Problem #9: Gracze nie mogą się zalogować

### Objawy:
- Panel logowania nie pokazuje się
- Błąd "Invalid serial"
- Nie można utworzyć konta

### ✅ Rozwiązanie:

**Krok 1: Sprawdź tabelę użytkowników**
```sql
SELECT * FROM pystories_users LIMIT 1;
```

**Krok 2: Sprawdź serial gracza**
W konsoli serwera powinieneś widzieć:
```
[INFO] Player connected: NickGracza (Serial: XXXXXX)
```

**Krok 3: Zweryfikuj zasób logowania**
```
/restart nrpg_login
/restart nrpg_db
```

**Krok 4: Ręczne dodanie konta (testowe)**
```sql
INSERT INTO pystories_users (login, pass, email, register_serial, money, bank_money, skin, lvl) 
VALUES ('testuser', MD5('testpass'), 'test@test.pl', 'YOUR_SERIAL', 5000, 10000, 0, 1);
```

---

## 📞 Pomoc techniczna

### 📁 Gdzie szukać błędów:

1. **Logi serwera**: `server/mods/deathmatch/logs/server.log`
2. **Logi MySQL**: Sprawdź logi w konsoli serwera (czerwony tekst)
3. **Logi zasobów**: `server/mods/deathmatch/logs/resources/`

### 🔍 Jak czytać błędy:

**Przykład błędu SQL:**
```
ERROR: [MySQL] Error (1054): Unknown column 'date' in 'where clause'
Query: SELECT * FROM pystories_houses WHERE date > '2024-01-01'
```
- **1054** = numer błędu MySQL (nieznana kolumna)
- **'date'** = brakująca kolumna
- **Query** = zapytanie SQL które wywołało błąd

**Rozwiązanie**: Dodaj brakującą kolumnę przez skrypt UPDATE.

---

### 📋 Checklist przed uruchomieniem serwera:

- [ ] XAMPP zainstalowany i MySQL uruchomiony
- [ ] Baza danych `nitrorpg` utworzona (utf8mb4_unicode_ci)
- [ ] Wykonany skrypt `database/nitrorpg.sql`
- [ ] Wykonany skrypt `database/UPDATE_fix_missing_columns.sql`
- [ ] Połączenia DB skonfigurowane (127.0.0.1, root, pusty pass)
- [ ] Plik `mtaserver.conf` zawiera wszystkie zasoby
- [ ] Plik `acl.xml` jest naprawiony (bez błędu Line 343)
- [ ] Porty 22003 i 22005 są wolne
- [ ] Token Discord Bot skonfigurowany (opcjonalnie)

---

### 📚 Pełna dokumentacja:

| Plik | Opis |
|------|------|
| `INSTALL.md` | Pełna instrukcja instalacji od zera |
| `README.md` | Opis projektu i systemy serwera |
| `RAPORT_PRZYGOTOWANIA.md` | Szczegółowa analiza 213 zasobów |
| `NAPRAWA_BAZY.md` | Naprawa problemów z MySQL |
| `NAPRAWA_PANELU.md` | Naprawa panelu użytkownika (F5) |
| `ROZWIAZYWANIE_PROBLEMOW.md` | Ten plik - szybkie rozwiązania |

---

## ⚡ Szybkie komendy

### W grze (F8 konsola):
```
/closepanel          - Zamknij panel użytkownika
/restart [zasób]     - Restart zasobu
/refresh             - Odśwież listę zasobów
/debugscript 3       - Włącz szczegółowe logi błędów
```

### Na serwerze:
```
quit                 - Zatrzymaj serwer
```

### W MySQL (phpMyAdmin):
```sql
SHOW TABLES;                              - Lista tabel
SHOW COLUMNS FROM pystories_users;        - Struktura tabeli
SELECT COUNT(*) FROM pystories_users;     - Liczba użytkowników
TRUNCATE TABLE pystories_users;           - Wyczyść tabelę (OSTROŻNIE!)
```

---

**Ostatnia aktualizacja**: 06 listopada 2026  
**Wersja**: 1.0  
**Status**: ✅ Wszystkie problemy udokumentowane

**Autor**: Kiro AI  
**Repozytorium**: https://github.com/mlodyerik/nitrorpg
