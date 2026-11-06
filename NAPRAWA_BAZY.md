# NAPRAWA BŁĘDÓW BAZY DANYCH

## Problemy które naprawiamy

Jeśli podczas uruchamiania serwera widzisz błędy:
```
WARNING: [Server]\nrpg_db\s_db.lua:31: dbPoll failed; Unknown column 'date' in 'where clause'
```

To znaczy że w Twojej bazie brakuje niektórych kolumn.

---

## ROZWIĄZANIE

### Jeśli JESZCZE NIE zaimportowałeś bazy:

**Po prostu zaimportuj najnowszy plik:**
```
database/nitrorpg.sql
```

Ten plik zawiera już wszystkie poprawki.

---

### Jeśli JUŻ zaimportowałeś starą wersję bazy:

**Musisz zaktualizować strukturę tabel:**

#### Krok 1: Otwórz phpMyAdmin
```
http://localhost/phpmyadmin
```

#### Krok 2: Wybierz bazę
Kliknij na **nitrorpg** w lewym menu

#### Krok 3: Przejdź do zakładki SQL
Kliknij zakładkę **"SQL"** u góry

#### Krok 4: Wklej kod naprawczy
Skopiuj i wklej zawartość pliku:
```
database/UPDATE_fix_missing_columns.sql
```

LUB wklej bezpośrednio ten kod:
```sql
USE `nitrorpg`;

ALTER TABLE `pystories_houses` 
ADD COLUMN `owner_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `owner`,
ADD COLUMN `interiorSize` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'small' AFTER `dimension`,
ADD COLUMN `date` datetime DEFAULT NULL AFTER `rent`,
ADD KEY `date` (`date`);
```

#### Krok 5: Wykonaj zapytanie
Kliknij **"Wykonaj"** na dole strony

#### Krok 6: Sprawdź wynik
Powinieneś zobaczyć komunikat:
```
Twoje polecenie SQL zostało pomyślnie wykonane.
```

---

## Weryfikacja

### Sprawdź czy kolumny zostały dodane:

1. W phpMyAdmin otwórz tabelę **pystories_houses**
2. Kliknij zakładkę **"Struktura"**
3. Sprawdź czy widzisz te kolumny:
   - ✅ `owner_name` (varchar)
   - ✅ `interiorSize` (varchar)
   - ✅ `date` (datetime)

### Uruchom ponownie serwer:

1. Zamknij serwer MTA:SA (jeśli działa)
2. Uruchom ponownie: `start-nitrorpg.bat` lub `server/MTA Server.exe`
3. Sprawdź logi - **nie powinno być już błędów** o kolumnie `date`

---

## Co zostało naprawione?

### Tabela: pystories_houses

**Dodane kolumny:**

1. **owner_name** (varchar 128)
   - Przechowuje nazwę właściciela domu
   - Używane przez system domów do wyświetlania

2. **interiorSize** (varchar 32)
   - Rozmiar wnętrza: small / medium / large
   - Używane przez system buildera domów
   - Domyślna wartość: 'small'

3. **date** (datetime)
   - Data wygaśnięcia wynajmu
   - Używane przez system automatycznego sprawdzania wygasłych wynajmów
   - Może być NULL (brak wynajmu)

4. **Indeks na kolumnie date**
   - Przyspiesza zapytania sprawdzające wygasłe wynajmy
   - `WHERE date < NOW()`

---

## Dlaczego to było potrzebne?

Podczas odtwarzania struktury bazy danych na podstawie kodu źródłowego, pierwotnie pominąłem niektóre kolumny używane przez system domów. Te kolumny są używane przez zasób `nrpg_houseSystem` i bez nich serwer generował błędy SQL.

---

## Dodatkowe informacje

### Skąd wziął się błąd?

Kod w pliku `nrpg_houseSystem/s.lua` odwołuje się do kolumn:
```lua
date = v["date"],
ownerName = v["owner_name"],
size = v["interiorSize"],
```

Ale oryginalna struktura SQL nie zawierała tych kolumn.

### Czy mogą być inne brakujące kolumny?

Jeśli widzisz inne błędy typu "Unknown column" - zgłoś je! 

W projekcie jest 213 zasobów, więc mogą być inne podobne problemy.

---

## Pomoc

Jeśli nadal masz problemy:

1. **Sprawdź logi serwera:**
   - `server/mods/deathmatch/logs/server.log`
   - `server/mods/deathmatch/logs/scripts.log`

2. **Sprawdź w phpMyAdmin:**
   - Czy baza `nitrorpg` istnieje
   - Czy wszystkie 21 tabel jest utworzonych
   - Czy struktura tabeli `pystories_houses` ma wszystkie kolumny

3. **Jeśli nic nie pomaga:**
   - Usuń bazę `nitrorpg` w phpMyAdmin
   - Utwórz nową pustą bazę `nitrorpg`
   - Zaimportuj najnowszy `database/nitrorpg.sql`

---

**Data aktualizacji:** 2026-11-06  
**Wersja:** 1.1  
**Status:** Naprawione i przetestowane
