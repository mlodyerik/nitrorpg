# ================================================================
# NITRORPG - Automatyczna Aktualizacja (PowerShell)
# ================================================================

$Host.UI.RawUI.WindowTitle = "NitroRPG - Automatyczna Aktualizacja"

Write-Host ""
Write-Host "================================================================" -ForegroundColor Green
Write-Host "         NITRORPG - AUTOMATYCZNA AKTUALIZACJA" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green
Write-Host ""

# ================================================================
# KONFIGURACJA - Zmień na swoje ścieżki!
# ================================================================

# Folder gdzie jest Twój serwer (ZMIEŃ NA SWOJĄ ŚCIEŻKĘ!)
$SERWER_FOLDER = "C:\WpJeSerwery\NitroRPG"

# URL repozytorium GitHub
$GITHUB_URL = "https://github.com/mlodyerik/nitrorpg.git"

# Folder na backupy
$BACKUP_FOLDER = Join-Path $SERWER_FOLDER "BACKUPY"

# ================================================================

Write-Host "[1/6] Sprawdzanie czy Git jest zainstalowany..." -ForegroundColor Yellow

# Sprawdź czy git jest dostępny
try {
    $gitVersion = git --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Git zainstalowany: $gitVersion" -ForegroundColor Green
    } else {
        throw "Git nie działa"
    }
} catch {
    Write-Host ""
    Write-Host "❌ BŁĄD: Git nie jest zainstalowany lub niedostępny!" -ForegroundColor Red
    Write-Host ""
    Write-Host "ROZWIĄZANIE:" -ForegroundColor Yellow
    Write-Host "1. Sprawdź czy Git jest zainstalowany:" -ForegroundColor White
    Write-Host "   - Otwórz Panel sterowania → Programy → Git" -ForegroundColor White
    Write-Host ""
    Write-Host "2. Jeśli NIE jest zainstalowany:" -ForegroundColor White
    Write-Host "   - Pobierz ze strony: https://git-scm.com/download/win" -ForegroundColor White
    Write-Host "   - Zainstaluj (klikaj Next wszędzie)" -ForegroundColor White
    Write-Host "   - Zaznacz opcję: Add Git to PATH" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3. Jeśli JUŻ jest zainstalowany:" -ForegroundColor White
    Write-Host "   - Zrestartuj komputer" -ForegroundColor White
    Write-Host "   - Lub dodaj Git do PATH ręcznie" -ForegroundColor White
    Write-Host ""
    Write-Host "Lokalizacja Git (zwykle):" -ForegroundColor Yellow
    Write-Host "   C:\Program Files\Git\cmd" -ForegroundColor White
    Write-Host ""
    Read-Host "Naciśnij Enter aby zamknąć"
    exit 1
}

Write-Host ""
Write-Host "[2/6] Sprawdzanie folderu serwera..." -ForegroundColor Yellow

if (-not (Test-Path $SERWER_FOLDER)) {
    Write-Host ""
    Write-Host "❌ BŁĄD: Folder serwera nie istnieje!" -ForegroundColor Red
    Write-Host "   Folder: $SERWER_FOLDER" -ForegroundColor White
    Write-Host ""
    Write-Host "Zmień ścieżkę w pliku UPDATE_SERWERA.ps1 (linia 18)" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Naciśnij Enter aby zamknąć"
    exit 1
}

Write-Host "✓ Folder znaleziony: $SERWER_FOLDER" -ForegroundColor Green

Set-Location $SERWER_FOLDER

Write-Host ""
Write-Host "[3/6] Sprawdzanie czy to repozytorium Git..." -ForegroundColor Yellow

if (-not (Test-Path ".git")) {
    Write-Host ""
    Write-Host "⚠️  To NIE jest repozytorium Git. Inicjalizuję..." -ForegroundColor Yellow
    Write-Host ""
    
    # Inicjalizacja Git w istniejącym folderze
    git init
    git remote add origin $GITHUB_URL
    git fetch origin
    
    Write-Host ""
    Write-Host "⚠️  UWAGA: Czy chcesz nadpisać lokalne pliki plikami z GitHuba?" -ForegroundColor Yellow
    Write-Host "   [T] Tak - nadpisz moje pliki (zalecane jeśli nie miałeś lokalnych zmian)" -ForegroundColor White
    Write-Host "   [N] Nie - anuluj" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Wybierz [T/N]"
    
    if ($choice -ne "T" -and $choice -ne "t") {
        Write-Host ""
        Write-Host "❌ Anulowano." -ForegroundColor Red
        Read-Host "Naciśnij Enter aby zamknąć"
        exit 0
    }
    
    Write-Host ""
    Write-Host "Pobieram pliki z GitHuba..." -ForegroundColor Yellow
    git reset --hard origin/main
    
    Write-Host ""
    Write-Host "✓ Repozytorium zainicjalizowane!" -ForegroundColor Green
} else {
    Write-Host "✓ To jest repozytorium Git" -ForegroundColor Green
}

Write-Host ""
Write-Host "[4/6] Tworzenie backupu przed aktualizacją..." -ForegroundColor Yellow

# Utwórz folder na backupy jeśli nie istnieje
if (-not (Test-Path $BACKUP_FOLDER)) {
    New-Item -ItemType Directory -Path $BACKUP_FOLDER | Out-Null
}

# Nazwa backupu z datą i godziną
$timestamp = Get-Date -Format "yyyyMMdd_HHmm"
$BACKUP_NAME = "backup_$timestamp"
$BACKUP_PATH = Join-Path $BACKUP_FOLDER $BACKUP_NAME

New-Item -ItemType Directory -Path $BACKUP_PATH | Out-Null

Write-Host "Tworzę backup: $BACKUP_NAME" -ForegroundColor Cyan

# Backup mtaserver.conf
$mtaConfig = Join-Path $SERWER_FOLDER "server\mods\deathmatch\mtaserver.conf"
if (Test-Path $mtaConfig) {
    Copy-Item $mtaConfig $BACKUP_PATH
    Write-Host "  ✓ mtaserver.conf" -ForegroundColor Green
}

# Backup acl.xml
$aclFile = Join-Path $SERWER_FOLDER "server\mods\deathmatch\acl.xml"
if (Test-Path $aclFile) {
    Copy-Item $aclFile $BACKUP_PATH
    Write-Host "  ✓ acl.xml" -ForegroundColor Green
}

# Backup autostart
$autostartPath = Join-Path $SERWER_FOLDER "server\mods\deathmatch\resources\[Serwer]\nrpg_autostart"
if (Test-Path $autostartPath) {
    $autostartBackup = Join-Path $BACKUP_PATH "autostart"
    Copy-Item $autostartPath $autostartBackup -Recurse
    Write-Host "  ✓ nrpg_autostart" -ForegroundColor Green
}

Write-Host "✓ Backup utworzony: $BACKUP_PATH" -ForegroundColor Green

Write-Host ""
Write-Host "[5/6] Sprawdzanie czy są nowe aktualizacje na GitHubie..." -ForegroundColor Yellow

# Pobierz info o zmianach
git fetch origin main 2>&1 | Out-Null

# Sprawdź czy są różnice
$diff = git diff --quiet HEAD origin/main 2>&1
$hasDiff = $LASTEXITCODE -ne 0

if ($hasDiff) {
    Write-Host ""
    Write-Host "✓ Znaleziono nowe aktualizacje!" -ForegroundColor Green
    Write-Host ""
    
    # Pokaż co się zmieni
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host "CO NOWEGO:" -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Cyan
    $commits = git log HEAD..origin/main --pretty=format:"  • %s" --abbrev-commit
    $commits | ForEach-Object { Write-Host $_ -ForegroundColor White }
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Zmienione pliki:" -ForegroundColor Yellow
    git diff --name-status HEAD origin/main
    Write-Host ""
    
    Write-Host "⚠️  Czy chcesz zainstalować te aktualizacje?" -ForegroundColor Yellow
    Write-Host "   [T] Tak - aktualizuj" -ForegroundColor White
    Write-Host "   [N] Nie - anuluj" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Wybierz [T/N]"
    
    if ($choice -ne "T" -and $choice -ne "t") {
        Write-Host ""
        Write-Host "❌ Aktualizacja anulowana." -ForegroundColor Red
        Read-Host "Naciśnij Enter aby zamknąć"
        exit 0
    }
    
    Write-Host ""
    Write-Host "[6/6] Instalowanie aktualizacji..." -ForegroundColor Yellow
    
    # Zapisz lokalne zmiany (jeśli są)
    git stash push -m "Auto-backup przed aktualizacją $timestamp" 2>&1 | Out-Null
    
    # Pobierz i zastosuj zmiany
    git pull origin main
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "❌ Wystąpił błąd podczas aktualizacji!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Możesz przywrócić backup z: $BACKUP_PATH" -ForegroundColor Yellow
        Write-Host ""
        Read-Host "Naciśnij Enter aby zamknąć"
        exit 1
    }
    
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host "          ✓ AKTUALIZACJA ZAKOŃCZONA POMYŚLNIE!" -ForegroundColor Green
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "✓ Wszystkie pliki zaktualizowane" -ForegroundColor Green
    Write-Host "✓ Backup dostępny w: $BACKUP_PATH" -ForegroundColor Green
    Write-Host ""
    Write-Host "ZMIANY:" -ForegroundColor Cyan
    $lastCommit = git log -1 --pretty=format:"  • Commit: %h%n  • Autor: %an%n  • Data: %ad%n  • Opis: %s%n"
    Write-Host $lastCommit -ForegroundColor White
    Write-Host "================================================================" -ForegroundColor Green
    
} else {
    Write-Host ""
    Write-Host "✓ Masz już najnowszą wersję!" -ForegroundColor Green
    Write-Host "  Brak aktualizacji do pobrania." -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Write-Host "[GOTOWE] Naciśnij Enter aby zamknąć..." -ForegroundColor Cyan
Read-Host
