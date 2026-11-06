# NitroRPG - Serwer Roleplay dla MTA:SA

**Wersja:** 1.0  
**Data przygotowania:** 2026-11-06  
**Kompatybilność:** MTA:SA 1.5.9+, MySQL 5.7+/MariaDB 10.3+  

---

## 📋 Opis projektu

NitroRPG to kompletny serwer Roleplay dla Multi Theft Auto: San Andreas (MTA:SA) z rozbudowanymi systemami RPG, frakcjami, pracami, pojazdami i ekonomią.

Projekt został przygotowany do uruchomienia lokalnie na Windows z wykorzystaniem XAMPP (MySQL/MariaDB).

---

## 🚀 Szybki start

### Wymagania
- **Windows 7/8/10/11** (64-bit)
- **XAMPP 8.0+** (MySQL/MariaDB)
- **MTA:SA Client** (do gry)
- **4 GB RAM** (zalecane 8 GB)
- **5 GB wolnego miejsca**

### Instalacja - 5 kroków

1. **Zainstaluj XAMPP** i uruchom MySQL
2. **Utwórz bazę danych** `nitrorpg` w phpMyAdmin
3. **Zaimportuj** plik `database/nitrorpg.sql`
4. **Uruchom** `start-nitrorpg.bat` lub `server/MTA Server.exe`
5. **Połącz się** z adresem `127.0.0.1:22003` w kliencie MTA:SA

📖 **Szczegółowa instrukcja:** Przeczytaj plik [INSTALL.md](INSTALL.md)

---

## 📁 Struktura projektu

```
nitrorpg/
├── database/
│   └── nitrorpg.sql              # Pełna struktura bazy danych (20+ tabel)
├── server/
│   ├── MTA Server.exe            # Główny plik serwera
│   └── mods/deathmatch/
│       ├── mtaserver.conf        # Konfiguracja serwera
│       ├── acl.xml               # Uprawnienia ACL
│       └── resources/            # 213 zasobów NitroRPG
│           ├── [Serwer]/         # Główne systemy serwera
│           ├── [Frakcje]/        # Systemy frakcji (SAPD, SAFD, SARA)
│           ├── [Organizacje]/    # Systemy organizacji
│           ├── [Prace]/          # Systemy prac
│           ├── [Mapy]/           # Mapy Los Santos
│           ├── [Modele]/         # Modele 3D (pojazdy, obiekty, skiny)
│           ├── [Shaders]/        # Shadery graficzne
│           ├── [Tuning]/         # Systemy tuningu
│           ├── [DC]/             # Integracja Discord
│           ├── [Deathmatch]/     # Systemy DM
│           └── gps/              # System GPS
├── INSTALL.md                     # Szczegółowa instrukcja instalacji
├── README.md                      # Ten plik
└── start-nitrorpg.bat            # Skrypt uruchamiający serwer
```

---

## 🗄️ Baza danych

Projekt zawiera pełną strukturę bazy danych MySQL odtworzoną na podstawie analizy wszystkich 213 zasobów.

### Główne tabele:

- **pystories_users** - Konta graczy
- **pystories_vehicles** - Pojazdy graczy
- **pystories_ekwipunek** - Ekwipunek graczy
- **pystories_factions** - Członkostwo we frakcjach
- **pystories_organizacje** - Członkostwo w organizacjach
- **pystories_houses** - System domów/nieruchomości
- **pystories_ban** - System banów
- **pystories_punish** - System kar (mute, jail)
- **pystories_friends** - System znajomych
- **pystories_admins** - Administratorzy serwera
- **pystories_settings** - Ustawienia graczy
- **pystories_vehicles_parking** - Historia parkingów
- **discord_connect** - Połączenia Discord

...i wiele innych! (pełna lista w `database/nitrorpg.sql`)

---

## 🎮 Systemy gry

### 👥 Systemy gracza
- ✅ Rejestracja i logowanie
- ✅ System poziomów i doświadczenia
- ✅ Statystyki gracza (godziny, pieniądze, respekt)
- ✅ Panel użytkownika
- ✅ System znajomych
- ✅ System czatu prywatnego
- ✅ Awatary (integracja Discord)

### 🚗 Systemy pojazdów
- ✅ Kupno/sprzedaż pojazdów
- ✅ System tuningu (neon, felgi, paintjob)
- ✅ Tankowanie i stan paliwa
- ✅ Przebieg pojazdu
- ✅ Parkowanie pojazdów
- ✅ Wymiana silników i cylindrów
- ✅ Rejestracje pojazdów
- ✅ System rent (wynajem)

### 🏠 Systemy ekonomiczne
- ✅ Bankomaty (ATM)
- ✅ Sklepy 24h
- ✅ System domów i nieruchomości
- ✅ Builder domów (umeblowanie)
- ✅ System wynajmu
- ✅ Handel między graczami

### 👮 Frakcje
- ✅ **SAPD** (San Andreas Police Department) - Policja
  - Kajdanki, aresztowanie, mandaty
  - Taser, magazynek broni
  - Kod radiowy
  - System raportów
- ✅ **SAFD** (San Andreas Fire Department) - Straż pożarna
  - System pożarów
  - Drabina strażacka
  - Usuwanie drzew
  - Torba R1
- ✅ **SARA** (San Andreas Road Administration) - Zarząd drogowy
  - Holowanie pojazdów
  - Blokada kół
  - Parking policyjny

### 💼 Prace
- ✅ Kierowca autobusu (PKS)
- ✅ Taksówkarz
- ✅ Kurier
- ✅ Magazynier
- ✅ Śmieciarz
- ✅ Drwal
- ✅ Rolnik (farmer)
- ✅ Mechanik
- ✅ Elektryk
- ✅ Spawacz (welder)
- ✅ Car jacker

### 🏢 Organizacje
- ✅ Tworzenie organizacji
- ✅ System rang
- ✅ Panel organizacji
- ✅ Spawn organizacji
- ✅ System marihuany (uprawy)

### 🛠️ Systemy użytkowe
- ✅ GPS i radar
- ✅ System map
- ✅ Interakcje z obiektami
- ✅ System drzwi
- ✅ Wnętrza (interiors)
- ✅ Markery
- ✅ 3D tekst
- ✅ System animacji
- ✅ Ubrania i skiny

### 🎵 Multimedia
- ✅ Radio w pojazdach
- ✅ Voice chat
- ✅ System stereo (własne linki)

### 🔒 Administracja
- ✅ Panel administracyjny
- ✅ System banów i kar
- ✅ System mute
- ✅ System teleportacji
- ✅ Zarządzanie zasobami
- ✅ Whitelist serwera
- ✅ Antycheat
- ✅ System raportów

### 🎨 Grafika
- ✅ Shadery (HQ Lights, Vehicle, Neons, Car)
- ✅ ENB
- ✅ Niestandardowe modele pojazdów
- ✅ Niestandardowe obiekty
- ✅ Niestandardowe skiny

---

## ⚙️ Konfiguracja

### Połączenie z bazą danych

Konfiguracja znajduje się w 3 głównych plikach:

1. **`resources/[Serwer]/nrpg_db/s_db.lua`** - Główne połączenie
2. **`resources/[Serwer]/DB/sql.lua`** - Alternatywne połączenie
3. **`resources/[Serwer]/DB2/sql.lua`** - Drugie alternatywne połączenie

Domyślnie skonfigurowane na lokalne XAMPP:
```lua
Host: 127.0.0.1
Port: 3306
User: root
Password: (puste)
Database: nitrorpg
```

### Konfiguracja serwera (mtaserver.conf)

Główne ustawienia:
- **Nazwa serwera:** NitroRPG - Serwer Roleplay
- **Port:** 22003 (UDP)
- **HTTP Port:** 22005 (TCP)
- **Maksymalna liczba graczy:** 32 (można zmienić)
- **Gamemode:** Roleplay (domyślne gamemodes MTA są wyłączone)

### Uprawnienia ACL (acl.xml)

Zdefiniowane grupy:
- **Everyone** - Domyślne uprawnienia dla wszystkich
- **NitroRPG_Database** - Uprawnienia dla zasobów bazy danych
- **NitroRPG_Core** - Uprawnienia dla rdzenia systemu
- **NitroRPG_Factions** - Uprawnienia dla frakcji
- **Admin** - Pełne uprawnienia administratora
- **Moderator** - Uprawnienia moderatora
- **SuperModerator** - Uprawnienia super moderatora

---

## 🔧 Rozwiązywanie problemów

### Serwer nie może połączyć się z bazą

**Objawy:** W logach serwera: `[nrpg_db] ✗ Nie można połączyć z bazą MySQL!`

**Rozwiązanie:**
1. Sprawdź czy MySQL w XAMPP jest uruchomiony (zielony status w Control Panel)
2. Sprawdź czy baza `nitrorpg` istnieje w phpMyAdmin
3. Sprawdź czy XAMPP używa domyślnego portu 3306
4. Zrestartuj XAMPP i serwer MTA:SA

### Zasoby nie uruchamiają się

**Objawy:** Błędy w `scripts.log` typu `[ERROR] resource xyz failed to start`

**Rozwiązanie:**
1. Sprawdź czy wszystkie zależne zasoby są uruchomione
2. Sprawdź kolejność uruchamiania w `mtaserver.conf`
3. Sprawdź uprawnienia ACL dla danego zasobu
4. Sprawdź czy wszystkie pliki zasobu istnieją

### Gracze nie mogą się zarejestrować

**Objawy:** Brak reakcji po kliknięciu przycisku rejestracji

**Rozwiązanie:**
1. Sprawdź czy zasób `nrpg_newlogin` jest uruchomiony
2. Sprawdź czy baza danych jest dostępna
3. Sprawdź logi serwera pod kątem błędów SQL
4. Sprawdź czy tabela `pystories_users` istnieje

### Pojazdy nie zapisują się

**Objawy:** Po restarcie serwera pojazdy znikają

**Rozwiązanie:**
1. Sprawdź czy zasób `nrpg_vehicles` jest uruchomiony
2. Sprawdź czy tabela `pystories_vehicles` istnieje
3. Sprawdź logi SQL pod kątem błędów INSERT/UPDATE
4. Sprawdź czy funkcja `onSaveVehicle` działa prawidłowo

---

## 📊 Statystyki projektu

- **Liczba zasobów:** 213
- **Liczba tabel SQL:** 20+
- **Liczba linii kodu Lua:** ~50,000+
- **Liczba skryptów:** 500+
- **Systemy frakcji:** 3 (SAPD, SAFD, SARA)
- **Systemy prac:** 11+
- **Niestandardowe modele:** 20+
- **Shadery:** 9

---

## 🤝 Wsparcie i kontakt

### Dokumentacja MTA:SA
- **Wiki:** https://wiki.multitheftauto.com/
- **Forum:** https://forum.multitheftauto.com/
- **Discord MTA:** https://discord.gg/mtasa

### XAMPP
- **Dokumentacja:** https://www.apachefriends.org/docs/

### Zgłaszanie błędów
Jeśli znalazłeś błąd:
1. Sprawdź logi serwera (`server.log`, `scripts.log`)
2. Sprawdź czy baza danych jest poprawnie zaimportowana
3. Sprawdź czy wszystkie wymagane zasoby są uruchomione
4. Zgłoś problem z pełnymi logami

---

## 📝 Licencja

Projekt NitroRPG jest dystrybuowany "tak jak jest" (AS-IS) bez żadnych gwarancji.

**Zawartość projektu:**
- Skrypty Lua: Autorzy poszczególnych zasobów (zobacz komentarze w plikach)
- MTA:SA Server: Multi Theft Auto Team
- GTA:SA: Rockstar Games

---

## 🙏 Podziękowania

- **Multi Theft Auto Team** - Za stworzenie MTA:SA
- **Autorzy zasobów** - Za wszystkie skrypty i systemy NitroRPG
- **Rockstar Games** - Za GTA:SA

---

## ⚠️ Uwagi prawne

- Grand Theft Auto: San Andreas jest własnością Rockstar Games
- Multi Theft Auto: San Andreas jest niezależnym projektem
- Ten projekt jest niekomercyjny i służy edukacyjnym/rozrywkowym celom
- Używaj na własną odpowiedzialność

---

**Miłej zabawy na serwerze NitroRPG!** 🎮🚗💨

---

*Dokument stworzony automatycznie: 2026-11-06*  
*Wersja dokumentacji: 1.0*
