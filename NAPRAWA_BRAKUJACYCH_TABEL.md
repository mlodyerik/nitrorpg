# 🔧 NAPRAWA BRAKUJĄCYCH TABEL W BAZIE DANYCH

## ❌ Problem

Logi serwera pokazują błąd:
```
WARNING: [Serwer]\nrpg_db\s_db.lua:31: dbPoll failed; Table 'nitrorpg.aj' doesn't exist
```

Ten błąd powtarza się **co 10 sekund** i oznacza że w bazie danych brakuje kilku tabel.

---

## 📊 Brakujące tabele

W bazie danych `nitrorpg` brakowało **4 tabel**:

| Tabela | Przeznaczenie | Używana przez |
|--------|---------------|---------------|
| `aj` | **Admin Jail** - Więzienie administracyjne | Frakcja SAPD, system kar |
| `pystories_organizacje_info` | Informacje o organizacjach graczy | Strefa DM, system organizacji |
| `pystories_marihuana` | Sadzonki marihuany zasadzone przez graczy | Organizacje, praca marihuany |
| `lss_domy` | Legacy - stary system domów | Komendy administracyjne |

---

## ✅ ROZWIĄZANIE - Metoda 1: Pełna baza (ZALECANE)

Jeśli **NIE masz jeszcze żadnych danych** w bazie:

### 1. Usuń starą bazę

W phpMyAdmin:
- Wybierz bazę `nitrorpg` z lewego menu
- Kliknij zakładkę **"Operacje"**
- Kliknij **"Usuń bazę"** (lub **Wyczyść**)
- Potwierdź

### 2. Zaimportuj pełną bazę z nowymi tabelami

1. W phpMyAdmin kliknij **"Nowa"** (lewy panel)
2. Nazwa: `nitrorpg`
3. Kodowanie: `utf8mb4_unicode_ci`
4. Kliknij **"Utwórz"**

5. Wybierz bazę `nitrorpg`
6. Kliknij zakładkę **"Import"**
7. Wybierz plik: `database/nitrorpg.sql` (zaktualizowany plik)
8. Kliknij **"Wykonaj"**

✅ Baza zawiera teraz **25 tabel** (21 starych + 4 nowe)

---

## ✅ ROZWIĄZANIE - Metoda 2: UPDATE (jeśli masz już dane)

Jeśli **masz już użytkowników/pojazdy** w bazie i nie chcesz ich stracić:

### 1. Wykonaj skrypt UPDATE

1. Otwórz phpMyAdmin: `http://localhost/phpmyadmin`
2. Wybierz bazę `nitrorpg` z lewego menu
3. Kliknij zakładkę **"SQL"** u góry
4. Otwórz plik `database/UPDATE_add_missing_tables.sql` w Notatniku
5. Skopiuj **CAŁĄ zawartość** (Ctrl+A, Ctrl+C)
6. Wklej w pole SQL w phpMyAdmin (Ctrl+V)
7. Kliknij **"Wykonaj"** na dole

✅ Dodane zostały 4 brakujące tabele, stare dane **nie zostały utracone**.

---

## 🧪 Weryfikacja

### Sprawdź czy tabele zostały dodane:

1. W phpMyAdmin wybierz bazę `nitrorpg`
2. W lewym panelu powinny być widoczne **25 tabel**:

**Stare tabele (21)**:
- pystories_users
- pystories_vehicles
- pystories_houses
- pystories_ekwipunek
- pystories_faction
- pystories_faction_ranks
- pystories_faction_members
- pystories_faction_garage
- pystories_faction_logs
- pystories_whitelist
- pystories_friends
- pystories_invites
- pystories_messages
- pystories_bans
- pystories_logs
- pystories_organizations
- pystories_organization_members
- pystories_organization_ranks
- pystories_skins
- pystories_mandates
- pystories_reports

**Nowe tabele (4)**:
- ✅ `aj` (Admin Jail)
- ✅ `pystories_organizacje_info` (Organizacje)
- ✅ `pystories_marihuana` (Sadzonki)
- ✅ `lss_domy` (Legacy domy)

### Sprawdź strukturę tabeli `aj`:

W phpMyAdmin:
1. Kliknij na tabelę `aj`
2. Zakładka **"Struktura"**
3. Powinny być kolumny:
   - `id` (PRIMARY KEY)
   - `Serial` (varchar 64)
   - `Termin` (datetime)
   - `Cela` (int)
   - `Powod` (text)
   - `created_at` (datetime)

---

## 🚀 Restart serwera

Po dodaniu tabel **MUSISZ zrestartować serwer MTA**:

1. Wpisz w konsoli serwera: `quit`
2. Uruchom ponownie `MTA Server.exe`

**LUB** w konsoli serwera:
```
restart nrpg_db
restart nrpg_factionsapd_jail
restart nrpg_jobMarihuana
```

---

## ✅ Weryfikacja w logach

Po restarcie serwera **NIE powinien** już wyświetlać błędu:
```
WARNING: dbPoll failed; Table 'nitrorpg.aj' doesn't exist
```

Zamiast tego powinno być:
```
INFO: [nrpg_db] ✓ Połączono z bazą MySQL: nitrorpg
INFO: [DB] POLACZONO POMYSLNIE z bazą nitrorpg!
Server started and is ready to accept connections!
```

✅ **Brak błędów = problem rozwiązany!**

---

## 📝 Co robi każda tabela?

### `aj` (Admin Jail)
- Przechowuje kary więzienia nakładane przez policję/administratorów
- Frakcja SAPD używa komendy `/jail <gracz> <czas> <m/h> <powód>`
- System automatycznie sprawdza co 10 sekund czy gracz powinien być zwolniony

**Przykładowe dane**:
```sql
INSERT INTO aj (Serial, Termin, Cela, Powod) 
VALUES ('ABCD1234EFGH5678', '2026-11-06 16:00:00', 1, 'Złamanie zasad RP');
```

### `pystories_organizacje_info`
- Przechowuje informacje o nielegalnych organizacjach graczy
- Strefa DM używa tej tabeli do naliczania punktów respektu
- Punkty organizacji rosną gdy członkowie zabijają przeciwników

**Przykładowe dane**:
```sql
INSERT INTO pystories_organizacje_info (nazwa, zalozyciel, zalozyciel_sid, punkty) 
VALUES ('Grove Street', 'CJ_Player', 123, 500);
```

### `pystories_marihuana`
- Przechowuje informacje o sadzonkach marihuany
- Gracze sadzą rośliny używając przedmiotu "Nasiona marihuany"
- Po określonym czasie mogą zebrać plon

**Przykładowe dane**:
```sql
INSERT INTO pystories_marihuana (sid, pos_x, pos_y, pos_z, czas_zbioru, zebrana) 
VALUES (123, 2450.5, -1680.2, 13.5, '2026-11-06 17:00:00', 0);
```

### `lss_domy` (Legacy)
- Stary system domów
- Używany przez komendy administracyjne `/adddom` i `/adddomek`
- Prawdopodobnie został zastąpiony przez `pystories_houses` ale skrypty admin nadal go używają

---

## 🔍 Diagnostyka

### Jeśli błąd nadal występuje:

1. **Sprawdź nazwę bazy**:
   ```sql
   SELECT DATABASE();
   ```
   Powinno pokazać: `nitrorpg`

2. **Sprawdź czy tabela istnieje**:
   ```sql
   SHOW TABLES LIKE 'aj';
   ```
   Powinno pokazać: `aj`

3. **Sprawdź strukturę**:
   ```sql
   DESCRIBE aj;
   ```
   Powinno pokazać wszystkie kolumny

4. **Sprawdź połączenie w kodzie**:
   ```lua
   -- Plik: server/mods/deathmatch/resources/[Serwer]/nrpg_db/s_db.lua
   DBName="nitrorpg"  -- Musi być "nitrorpg"
   DBHost="127.0.0.1" -- Lokalny XAMPP
   DBUser="root"      -- Użytkownik
   DBPass=""          -- Puste hasło
   ```

---

## 📂 Pliki w tym repozytorium

| Plik | Opis |
|------|------|
| `database/nitrorpg.sql` | **Pełna baza danych** z wszystkimi 25 tabelami |
| `database/UPDATE_add_missing_tables.sql` | **Skrypt UPDATE** - dodaje tylko 4 brakujące tabele |
| `database/UPDATE_fix_missing_columns.sql` | Dodaje brakujące kolumny w pystories_houses |
| `NAPRAWA_BRAKUJACYCH_TABEL.md` | **Ten plik** - instrukcja naprawy |

---

## ✅ Podsumowanie

**Problem**: Serwer zgłaszał błąd `Table 'nitrorpg.aj' doesn't exist` co 10 sekund

**Przyczyna**: W bazie danych brakowało 4 tabel używanych przez różne systemy serwera

**Rozwiązanie**: 
1. Wykonaj skrypt `UPDATE_add_missing_tables.sql` w phpMyAdmin
2. Zrestartuj serwer MTA
3. Sprawdź logi - nie powinno być już błędów

**Czas naprawy**: ~2 minuty

---

**Ostatnia aktualizacja**: 06 listopada 2026  
**Wersja bazy**: 1.3  
**Status**: ✅ Problem rozwiązany - wszystkie tabele dodane
