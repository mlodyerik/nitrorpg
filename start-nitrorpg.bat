@echo off
title NitroRPG Server Starter
color 0A
echo.
echo ========================================
echo      NITRORPG SERVER STARTER
echo ========================================
echo.

REM Sprawdzenie czy XAMPP MySQL jest uruchomiony
echo [1/3] Sprawdzanie polaczenia z MySQL...
netstat -an | findstr "3306" >nul
if %errorlevel% equ 0 (
    echo [OK] MySQL jest uruchomiony na porcie 3306
) else (
    echo [BLAD] MySQL nie dziala na porcie 3306!
    echo.
    echo ROZWIAZANIE:
    echo 1. Uruchom XAMPP Control Panel
    echo 2. Kliknij START przy MySQL
    echo 3. Poczekaj az MySQL sie uruchomi
    echo 4. Uruchom ponownie ten skrypt
    echo.
    pause
    exit /b 1
)

echo.
echo [2/3] Sprawdzanie bazy danych...
REM Tutaj mozna dodac sprawdzenie czy baza istnieje, ale wymaga mysql cli

echo [INFO] Upewnij sie ze:
echo   - Baza 'nitrorpg' istnieje w phpMyAdmin
echo   - Plik database/nitrorpg.sql zostal zaimportowany
echo.

echo [3/3] Uruchamianie serwera MTA:SA...
echo.
echo ========================================
echo  Serwer MTA:SA zostanie uruchomiony
echo ========================================
echo.
echo Jesli widzisz komunikaty:
echo   [nrpg_db] V Polaczono z baza MySQL: nitrorpg
echo   [DB] POLACZONO POMYSLNIE z baza nitrorpg!
echo.
echo To znaczy ze wszystko dziala poprawnie!
echo.
echo Nacisnij dowolny klawisz aby uruchomic serwer...
pause >nul

REM Przejscie do folderu serwera
cd /d "%~dp0server"

REM Uruchomienie serwera MTA:SA
echo.
echo Uruchamianie...
echo.
start "NitroRPG Server" "MTA Server.exe"

echo.
echo ========================================
echo Serwer zostal uruchomiony!
echo ========================================
echo.
echo Jesli chcesz zobaczyc konsole serwera,
echo sprawdz nowe okno "NitroRPG Server"
echo.
echo Aby polaczyc sie z serwerem:
echo 1. Uruchom MTA:SA (klient)
echo 2. Przejdz do "Play Multiplayer"
echo 3. Wpisz adres: 127.0.0.1:22003
echo.
echo Lub znajdz serwer "NitroRPG - Serwer Roleplay"
echo na liscie LAN.
echo.
echo Milej zabawy!
echo.
pause
