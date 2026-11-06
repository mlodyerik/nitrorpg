@echo off
chcp 65001 >nul
color 0A
title NitroRPG - Automatyczna Aktualizacja z GitHuba

echo.
echo ═══════════════════════════════════════════════════════════════
echo            NITRORPG - AUTOMATYCZNA AKTUALIZACJA
echo ═══════════════════════════════════════════════════════════════
echo.

REM ================================================================
REM KONFIGURACJA - Zmień na swoje ścieżki!
REM ================================================================

REM Folder gdzie jest Twój serwer (ZMIEŃ NA SWOJĄ ŚCIEŻKĘ!)
set "SERWER_FOLDER=C:\MojeServery\NitroRPG"

REM URL repozytorium GitHub
set "GITHUB_URL=https://github.com/mlodyerik/nitrorpg.git"

REM Folder na backupy
set "BACKUP_FOLDER=%SERWER_FOLDER%\BACKUPY"

REM ================================================================

echo [1/6] Sprawdzanie czy Git jest zainstalowany...
git --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ BŁĄD: Git nie jest zainstalowany!
    echo.
    echo Pobierz Git ze strony: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)
echo ✓ Git zainstalowany

echo.
echo [2/6] Sprawdzanie folderu serwera...
if not exist "%SERWER_FOLDER%" (
    echo.
    echo ❌ BŁĄD: Folder serwera nie istnieje!
    echo    Folder: %SERWER_FOLDER%
    echo.
    echo Zmień ścieżkę w pliku UPDATE_SERWERA.bat (linia 17)
    echo.
    pause
    exit /b 1
)
echo ✓ Folder znaleziony: %SERWER_FOLDER%

cd /d "%SERWER_FOLDER%"

echo.
echo [3/6] Sprawdzanie czy to repozytorium Git...
if not exist ".git" (
    echo.
    echo ⚠️  To NIE jest repozytorium Git. Inicjalizuję...
    echo.
    
    REM Inicjalizacja Git w istniejącym folderze
    git init
    git remote add origin %GITHUB_URL%
    git fetch origin
    
    echo.
    echo ⚠️  UWAGA: Czy chcesz nadpisać lokalne pliki plikami z GitHuba?
    echo    [T] Tak - nadpisz moje pliki (zalecane jeśli nie miałeś lokalnych zmian)
    echo    [N] Nie - anuluj
    echo.
    choice /C TN /N /M "Wybierz [T/N]: "
    
    if errorlevel 2 (
        echo.
        echo ❌ Anulowano.
        pause
        exit /b 0
    )
    
    echo.
    echo Pobieram pliki z GitHuba...
    git reset --hard origin/main
    
    echo.
    echo ✓ Repozytorium zainicjalizowane!
) else (
    echo ✓ To jest repozytorium Git
)

echo.
echo [4/6] Tworzenie backupu przed aktualizacją...

REM Utwórz folder na backupy jeśli nie istnieje
if not exist "%BACKUP_FOLDER%" mkdir "%BACKUP_FOLDER%"

REM Nazwa backupu z datą i godziną
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%b%%a)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set "BACKUP_NAME=backup_%mydate%_%mytime:.=%"

REM Kopiuj tylko ważne pliki (nie całe binaria)
echo Tworzę backup: %BACKUP_NAME%
if not exist "%BACKUP_FOLDER%\%BACKUP_NAME%" mkdir "%BACKUP_FOLDER%\%BACKUP_NAME%"

REM Backup mtaserver.conf
if exist "server\mods\deathmatch\mtaserver.conf" (
    xcopy "server\mods\deathmatch\mtaserver.conf" "%BACKUP_FOLDER%\%BACKUP_NAME%\" /Y /Q >nul
    echo   ✓ mtaserver.conf
)

REM Backup acl.xml
if exist "server\mods\deathmatch\acl.xml" (
    xcopy "server\mods\deathmatch\acl.xml" "%BACKUP_FOLDER%\%BACKUP_NAME%\" /Y /Q >nul
    echo   ✓ acl.xml
)

REM Backup autostart
if exist "server\mods\deathmatch\resources\[Serwer]\nrpg_autostart\server.lua" (
    if not exist "%BACKUP_FOLDER%\%BACKUP_NAME%\autostart" mkdir "%BACKUP_FOLDER%\%BACKUP_NAME%\autostart"
    xcopy "server\mods\deathmatch\resources\[Serwer]\nrpg_autostart\*.*" "%BACKUP_FOLDER%\%BACKUP_NAME%\autostart\" /Y /Q >nul
    echo   ✓ nrpg_autostart
)

echo ✓ Backup utworzony: %BACKUP_FOLDER%\%BACKUP_NAME%

echo.
echo [5/6] Sprawdzanie czy są nowe aktualizacje na GitHubie...

REM Pobierz info o zmianach
git fetch origin main

REM Sprawdź czy są różnice
git diff --quiet HEAD origin/main
if errorlevel 1 (
    echo.
    echo ✓ Znaleziono nowe aktualizacje!
    echo.
    
    REM Pokaż co się zmieni
    echo ═══════════════════════════════════════════════════════════════
    echo CO NOWEGO:
    echo ═══════════════════════════════════════════════════════════════
    git log HEAD..origin/main --pretty=format:"  • %%s" --abbrev-commit
    echo.
    echo ═══════════════════════════════════════════════════════════════
    echo.
    
    echo Zmienione pliki:
    git diff --name-status HEAD origin/main
    echo.
    
    echo ⚠️  Czy chcesz zainstalować te aktualizacje?
    echo    [T] Tak - aktualizuj
    echo    [N] Nie - anuluj
    echo.
    choice /C TN /N /M "Wybierz [T/N]: "
    
    if errorlevel 2 (
        echo.
        echo ❌ Aktualizacja anulowana.
        pause
        exit /b 0
    )
    
    echo.
    echo [6/6] Instalowanie aktualizacji...
    
    REM Zapisz lokalne zmiany (jeśli są)
    git stash push -m "Auto-backup przed aktualizacją %mydate%_%mytime%" >nul 2>&1
    
    REM Pobierz i zastosuj zmiany
    git pull origin main
    
    if errorlevel 1 (
        echo.
        echo ❌ Wystąpił błąd podczas aktualizacji!
        echo.
        echo Możesz przywrócić backup z: %BACKUP_FOLDER%\%BACKUP_NAME%
        echo.
        pause
        exit /b 1
    )
    
    echo.
    echo ═══════════════════════════════════════════════════════════════
    echo             ✓ AKTUALIZACJA ZAKOŃCZONA POMYŚLNIE!
    echo ═══════════════════════════════════════════════════════════════
    echo.
    echo ✓ Wszystkie pliki zaktualizowane
    echo ✓ Backup dostępny w: %BACKUP_FOLDER%\%BACKUP_NAME%
    echo.
    echo ZMIANY:
    git log -1 --pretty=format:"  • Commit: %%h%%n  • Autor: %%an%%n  • Data: %%ad%%n  • Opis: %%s%%n"
    echo.
    echo ═══════════════════════════════════════════════════════════════
    
) else (
    echo.
    echo ✓ Masz już najnowszą wersję!
    echo   Brak aktualizacji do pobrania.
    echo.
)

echo.
echo [GOTOWE] Naciśnij dowolny klawisz aby zamknąć...
pause >nul
