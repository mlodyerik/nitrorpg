# INSTRUKCJA INSTALACJI SERWERA NITRORPG

## Wymagania systemowe

- **System operacyjny**: Windows 7/8/10/11 (64-bit)
- **XAMPP**: Wersja 8.0+ (zawiera MySQL/MariaDB, Apache, phpMyAdmin)
- **MTA:SA Server**: Wersja 1.5.9+ (znajduje się w tym repozytorium)
- **Wolne miejsce na dysku**: Minimum 5 GB
- **RAM**: Minimum 4 GB (zalecane 8 GB)
- **Porty**: 22003 (UDP), 22005 (TCP) - muszą być wolne

---

## KROK 1: Instalacja XAMPP

### 1.1. Pobierz XAMPP

Pobierz XAMPP dla Windows ze strony:  
https://www.apachefriends.org/download.html

Zalecana wersja: **XAMPP 8.0 lub nowsza**

### 1.2. Zainstaluj XAMPP

1. Uruchom pobrany instalator
2. Wybierz komponenty do instalacji (wymagane: **Apache**, **MySQL**, **phpMyAdmin**)
3. Wybierz ścieżkę instalacji (np. `C:\xampp`)
4. Dokończ instalację

### 1.3. Uruchom XAMPP Control Panel

1. Otwórz **XAMPP Control Panel**
2. Uruchom moduł **MySQL** (kliknij przycisk **Start**)
3. Opcjonalnie uruchom **Apache** jeśli chcesz korzystać z phpMyAdmin
4. Sprawdź czy MySQL działa (powinien wyświetlać się zielony status)

---

## KROK 2: Utworzenie bazy danych

### 2.1. Otwórz phpMyAdmin

1. W przeglądarce otwórz: `http://localhost/phpmyadmin`
2. Zaloguj się (domyślnie: użytkownik **root**, hasło **puste**)

### 2.2. Utwórz bazę danych

1. Kliknij **"Nowa"** w lewym menu
2. Nazwa bazy danych: **`nitrorpg`**
3. Kodowanie: **`utf8mb4_unicode_ci`**
4. Kliknij **"Utwórz"**

### 2.3. Importuj strukturę bazy danych

1. Wybierz bazę **nitrorpg** z lewego menu
2. Kliknij zakładkę **"Import"** u góry
3. Kliknij **"Wybierz plik"**
4. Przejdź do folderu NitroRPG i wybierz plik:  
   **`database/nitrorpg.sql`**
5. Kliknij **"Wykonaj"** na dole strony
6. Poczekaj na zakończenie importu
7. Sprawdź czy tabele zostały utworzone (powinno być 20+ tabel)

**WAŻNE**: Jeśli zobaczysz komunikat "Import zakończony pomyślnie", wszystko jest OK!

---

## KROK 3: Konfiguracja połączenia z bazą danych

Połączenie z bazą danych zostało już skonfigurowane automatycznie!

Wszystkie zasoby NitroRPG łączą się z lokalną bazą MySQL przy użyciu następujących ustawień:

```
Host: 127.0.0.1
Port: 3306
User: root
Password: (puste)
Database: nitrorpg
```

**Nie musisz nic zmieniać** jeśli używasz standardowej instalacji XAMPP.

### Jeśli masz inne hasło do MySQL:

Jeśli zmieniłeś hasło root w MySQL, musisz zaktualizować 3 pliki:

1. `server/mods/deathmatch/resources/[Serwer]/nrpg_db/s_db.lua` - zmień wartość `DBPass=""`
2. `server/mods/deathmatch/resources/[Serwer]/DB/sql.lua` - zmień hasło w `dbConnect`
3. `server/mods/deathmatch/resources/[Serwer]/DB2/sql.lua` - zmień hasło w `dbConnect`

---

## KROK 4: Uruchomienie serwera MTA:SA

### 4.1. Przejdź do folderu serwera

Otwórz folder:
```
nitrorpg/server/
```

### 4.2. Uruchom serwer

Kliknij dwukrotnie na plik:
```
MTA Server.exe
```

### 4.3. Sprawdź uruchomienie

W oknie konsoli serwera powinny pojawić się komunikaty:

```
[nrpg_db] ✓ Połączono z bazą MySQL: nitrorpg
[DB] POLACZONO POMYSLNIE z bazą nitrorpg!
[DB2] POLACZONO POMYSLNIE z bazą nitrorpg!
```

Jeśli widzisz te komunikaty - **połączenie z bazą działa prawidłowo!**

### 4.4. Możliwe błędy

**Błąd: "BRAK POLACZENIA Z BAZA DANYCH!"**

Rozwiązanie:
1. Sprawdź czy MySQL w XAMPP jest uruchomiony (zielony status)
2. Sprawdź czy baza `nitrorpg` istnieje w phpMyAdmin
3. Sprawdź czy XAMPP używa portu 3306 (domyślny)
4. Zrestartuj XAMPP i ponownie uruchom serwer

**Błąd: "Server port is already in use"**

Rozwiązanie:
1. Inny program używa portu 22003
2. Zamknij inne serwery MTA:SA
3. Zmień port w `mtaserver.conf` (opcjonalne)

---

## KROK 5: Połączenie z serwerem jako gracz

### 5.1. Uruchom MTA:SA Client

1. Uruchom **MTA:SA** (klient gry)
2. Przejdź do **"Play Multiplayer"**
3. Kliknij **"Quick Connect"** lub **"Browse servers"**

### 5.2. Połącz się z lokalnym serwerem

W polu adresu wpisz:
```
127.0.0.1:22003
```

lub znajdź serwer **"NitroRPG - Serwer Roleplay"** na liście LAN.

### 5.3. Zarejestruj konto

1. Po połączeniu zobaczysz panel logowania
2. Kliknij **"Rejestracja"**
3. Podaj:
   - **Login** (nazwa użytkownika)
   - **Hasło**
   - **E-mail**
4. Kliknij **"Zarejestruj"**
5. Po rejestracji zaloguj się podając login i hasło

---

## KROK 6: Nadanie uprawnień administratora

### 6.1. Dodaj administratora przez phpMyAdmin

1. Otwórz phpMyAdmin: `http://localhost/phpmyadmin`
2. Wybierz bazę **nitrorpg**
3. Znajdź tabelę **`pystories_users`** i kliknij na nią
4. Znajdź swoje konto (szukaj po loginie)
5. Skopiuj wartość z kolumny **`id`** (np. `1`)
6. Przejdź do tabeli **`pystories_admins`**
7. Kliknij **"Wstaw"** (Insert)
8. Wypełnij pola:
   - **uid**: Twoje ID użytkownika (np. `1`)
   - **serial**: Twój serial MTA (znajdziesz w logach serwera lub `/serial` w grze)
   - **date**: Twój login
   - **level**: `5` (najwyższy poziom admina)
9. Kliknij **"Wykonaj"**

### 6.2. Komendy administratora w grze

Po zalogowaniu jako admin możesz używać komend:

```
/apanel - Panel administracyjny
/admins - Lista adminów online
/aduty - Wejdź/Wyjdź z trybu admin
/goto [id] - Teleportuj się do gracza
/gethere [id] - Sprowadź gracza do siebie
/sethp [id] [hp] - Ustaw HP gracza
/setmoney [id] [kwota] - Ustaw pieniądze gracza
/kick [id] [powód] - Wyrzuć gracza
/ban [id] [czas] [powód] - Zbanuj gracza
```

I wiele więcej! Sprawdź panel admina w grze.

---

## KROK 7: Konfiguracja Discord (opcjonalne)

Serwer posiada integrację z Discordem, ale wymaga konfiguracji webhooków.

### 7.1. Utwórz webhook Discord

1. Przejdź do ustawień swojego serwera Discord
2. Webhooks → Nowy webhook
3. Skopiuj URL webhooka

### 7.2. Skonfiguruj webhook w zasobach

Edytuj plik:
```
server/mods/deathmatch/resources/[DC]/discord/config.xml
```

Wklej URL webhooka w odpowiednim miejscu.

**WAŻNE**: Jeśli nie skonfigurujesz Discord, serwer będzie działał normalnie, ale powiadomienia Discord nie będą wysyłane.

---

## KROK 8: Testowanie systemów

### 8.1. Systemy do przetestowania

Po zalogowaniu sprawdź czy działają:

✅ **Panel użytkownika** - `/panel`  
✅ **System pojazdów** - Kup pojazd w salonie  
✅ **System prac** - Podejdź do markera pracy  
✅ **System frakcji** - Sprawdź menu frakcji (jeśli jesteś członkiem)  
✅ **System domów** - Kup dom w ofercie  
✅ **System ATM** - Podejdź do bankomatu  
✅ **System licencji** - Idź do urzędu  
✅ **System tuningu** - Idź do warsztatu tuningowego  

### 8.2. Sprawdzenie logów

Sprawdź logi serwera w folderze:
```
server/mods/deathmatch/logs/
```

Szczególnie:
- **`server.log`** - główny log serwera
- **`scripts.log`** - błędy skryptów Lua

Jeśli widzisz błędy typu:
```
[ERROR] Table 'nitrorpg.pystories_xyz' doesn't exist
```

Sprawdź czy zaimportowałeś plik SQL poprawnie (KROK 2.3).

---

## KROK 9: Rozwiązywanie problemów

### Problem: Nie mogę się zarejestrować

**Rozwiązanie**:
1. Sprawdź czy XAMPP MySQL działa
2. Sprawdź logi serwera - czy połączenie z bazą jest aktywne
3. Sprawdź czy tabela `pystories_users` istnieje

### Problem: Po zalogowaniu nic się nie dzieje

**Rozwiązanie**:
1. Sprawdź czy zasób `nrpg_newlogin` jest uruchomiony
2. Sprawdź czy zasób `nrpg_core` jest uruchomiony
3. Sprawdź logi błędów skryptów (`scripts.log`)

### Problem: Pojazdy nie zapisują się

**Rozwiązanie**:
1. Sprawdź czy tabela `pystories_vehicles` istnieje
2. Sprawdź czy zasób `nrpg_vehicles` jest uruchomiony
3. Sprawdź uprawnienia ACL dla zasobów

### Problem: Brakuje modeli/tekstur

**Rozwiązanie**:
1. Sprawdź czy wszystkie zasoby z folderów `[Modele]` są uruchomione
2. Poczekaj na pełne pobranie zasobów przez klienta
3. Sprawdź czy klient MTA jest zaktualizowany

### Problem: Błędy w logach typu "exports:nrpg_db:dbGet"

**Rozwiązanie**:
1. Sprawdź czy zasób `nrpg_db` jest uruchomiony PRZED innymi zasobami
2. Sprawdź kolejność zasobów w `mtaserver.conf`
3. Zrestartuj serwer

---

## KROK 10: Backup i bezpieczeństwo

### 10.1. Backup bazy danych

**Zalecamy regularne backupy bazy!**

Przez phpMyAdmin:
1. Wybierz bazę `nitrorpg`
2. Kliknij **"Eksportuj"**
3. Wybierz format **SQL**
4. Kliknij **"Wykonaj"**
5. Zapisz plik w bezpiecznym miejscu

### 10.2. Backup plików serwera

Skopiuj cały folder `nitrorpg/` w bezpieczne miejsce.

### 10.3. Hasło MySQL

**Dla bezpieczeństwa produkcyjnego** ustaw hasło dla użytkownika root MySQL:

1. Otwórz phpMyAdmin
2. Przejdź do zakładki **"Konta użytkowników"**
3. Edytuj użytkownika **root**
4. Ustaw hasło
5. **Pamiętaj zaktualizować hasło w plikach konfiguracyjnych serwera!** (patrz KROK 3)

---

## Dodatkowe informacje

### Serwer publiczny w Internecie

Jeśli chcesz udostępnić serwer publicznie:

1. **Przekieruj porty** na routerze:
   - Port **22003** (UDP) - główny port gry
   - Port **22126** (UDP) - ASE (lista serwerów)
   - Port **22005** (TCP) - HTTP

2. **Zmień IP w bazie** na publiczne IP (jeśli baza jest na innym serwerze)

3. **Ustaw hasło MySQL** (KROK 10.3)

4. **Włącz firewall** i zabezpiecz serwer

---

## Kontakt i wsparcie

### Przydatne linki

- **MTA:SA Wiki**: https://wiki.multitheftauto.com/
- **MTA:SA Forum**: https://forum.multitheftauto.com/
- **XAMPP Documentation**: https://www.apachefriends.org/docs

### Zgłaszanie błędów

Jeśli znajdziesz błąd:
1. Sprawdź logi serwera (`server.log`, `scripts.log`)
2. Sprawdź czy baza danych jest poprawnie zaimportowana
3. Sprawdź czy wszystkie wymagane zasoby są uruchomione

---

## Podsumowanie

Po wykonaniu wszystkich kroków powinieneś mieć:

✅ Działający serwer MTA:SA NitroRPG  
✅ Połączenie z bazą danych MySQL (XAMPP)  
✅ Możliwość rejestracji i logowania graczy  
✅ Wszystkie systemy RPG gotowe do użycia  
✅ Panel administracyjny (po nadaniu uprawnień)  

**Miłej zabawy na serwerze NitroRPG!** 🎮🚗

---

*Dokument stworzony: 2026-11-06*  
*Wersja: 1.0*  
*Kompatybilność: MTA:SA 1.5.9+, MySQL 5.7+, MariaDB 10.3+*


---

## 📚 Dodatkowa dokumentacja

W repozytorium znajdują się następujące pliki dokumentacji:

- **`INSTALL.md`** (ten plik) - Pełna instrukcja instalacji serwera
- **`README.md`** - Ogólny opis projektu i systemy serwera
- **`RAPORT_PRZYGOTOWANIA.md`** - Szczegółowy raport przygotowania serwera (analiza 213 zasobów)
- **`NAPRAWA_BAZY.md`** - Instrukcja naprawy problemów z bazą danych (brakujące kolumny)
- **`NAPRAWA_PANELU.md`** - ⚠️ WAŻNE: Naprawa problemu z zawieszonym panelem użytkownika (F5)

### Najczęstsze problemy:

1. **Panel użytkownika (F5) nie zamyka się** → Zobacz `NAPRAWA_PANELU.md`
2. **Błędy SQL "Unknown column"** → Zobacz `NAPRAWA_BAZY.md`
3. **Serwer nie startuje** → Sprawdź `server/mods/deathmatch/logs/`
4. **Błąd "Line 343: Error reading end tag"** → ACL już naprawiony w repozytorium

---

**Powodzenia z uruchomieniem serwera NitroRPG! 🎮**
