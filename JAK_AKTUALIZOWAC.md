# 🔄 JAK AUTOMATYCZNIE AKTUALIZOWAĆ SERWER

## 🎯 Najprościej - 3 kroki:

### 1️⃣ Pobierz plik `UPDATE_SERWERA.bat` z GitHuba
https://github.com/mlodyerik/nitrorpg/blob/main/UPDATE_SERWERA.bat

### 2️⃣ Kliknij prawym i "Edytuj" (lub otwórz w Notatniku)
Zmień linię **17**:
```batch
set "SERWER_FOLDER=C:\MojeServery\NitroRPG"
```
Na swoją ścieżkę, np:
```batch
set "SERWER_FOLDER=D:\Serwery\nitrorpg"
```

### 3️⃣ Zapisz i uruchom podwójnym kliknięciem!

---

## ✨ Co robi skrypt automatycznie:

✅ **Sprawdza** czy są nowe aktualizacje na GitHubie  
✅ **Pokazuje** co się zmieni (lista plików)  
✅ **Robi backup** ważnych plików przed aktualizacją  
✅ **Aktualizuje** wszystkie pliki automatycznie  
✅ **Nie nadpisuje** Twoich lokalnych zmian (zapisuje je)  

---

## 🎬 Jak to wygląda:

```
═══════════════════════════════════════════════════════════════
            NITRORPG - AUTOMATYCZNA AKTUALIZACJA
═══════════════════════════════════════════════════════════════

[1/6] Sprawdzanie czy Git jest zainstalowany...
✓ Git zainstalowany

[2/6] Sprawdzanie folderu serwera...
✓ Folder znaleziony: C:\MojeServery\NitroRPG

[3/6] Sprawdzanie czy to repozytorium Git...
✓ To jest repozytorium Git

[4/6] Tworzenie backupu przed aktualizacją...
  ✓ mtaserver.conf
  ✓ acl.xml
  ✓ nrpg_autostart
✓ Backup utworzony: C:\MojeServery\NitroRPG\BACKUPY\backup_20261106_1530

[5/6] Sprawdzanie czy są nowe aktualizacje na GitHubie...
✓ Znaleziono nowe aktualizacje!

═══════════════════════════════════════════════════════════════
CO NOWEGO:
═══════════════════════════════════════════════════════════════
  • 🚀 Feat: Implementacja systemu AUTOSTART
  • 🔧 Fix: Naprawiono wszystkie błędy XML
═══════════════════════════════════════════════════════════════

Zmienione pliki:
M       server/mods/deathmatch/mtaserver.conf
M       server/mods/deathmatch/acl.xml
A       AUTOSTART_INFO.md

⚠️  Czy chcesz zainstalować te aktualizacje?
   [T] Tak - aktualizuj
   [N] Nie - anuluj

Wybierz [T/N]: T

[6/6] Instalowanie aktualizacji...

═══════════════════════════════════════════════════════════════
             ✓ AKTUALIZACJA ZAKOŃCZONA POMYŚLNIE!
═══════════════════════════════════════════════════════════════

✓ Wszystkie pliki zaktualizowane
✓ Backup dostępny w: C:\MojeServery\NitroRPG\BACKUPY\backup_20261106_1530

ZMIANY:
  • Commit: 9371701
  • Autor: Kiro AI
  • Data: Wed Nov 6 15:55:00 2026
  • Opis: 🚀 Feat: Implementacja systemu AUTOSTART

═══════════════════════════════════════════════════════════════

[GOTOWE] Naciśnij dowolny klawisz aby zamknąć...
```

---

## 📋 Wymagania:

### ✅ Git musi być zainstalowany
**Jeśli nie masz Gita:**

1. Pobierz: https://git-scm.com/download/win
2. Zainstaluj (klikaj "Next" wszędzie)
3. Uruchom skrypt ponownie

### ✅ Musisz mieć dostęp do Internetu
Skrypt łączy się z GitHubem po aktualizacje.

---

## 🔒 Backupy

Każda aktualizacja tworzy automatyczny backup w:
```
TwojSerwer\BACKUPY\backup_DATA_GODZINA\
```

**Zawiera:**
- `mtaserver.conf`
- `acl.xml`  
- Cały folder `nrpg_autostart`

**Przywracanie backupu:**
1. Otwórz folder `BACKUPY`
2. Wybierz odpowiednią datę
3. Skopiuj pliki z powrotem do serwera

---

## ❓ Troubleshooting

### Problem: "Git nie jest zainstalowany"
**Rozwiązanie:** Pobierz Git z https://git-scm.com/download/win

### Problem: "Folder serwera nie istnieje"
**Rozwiązanie:** Zmień ścieżkę w linii 17 na właściwą

### Problem: "To NIE jest repozytorium Git"
**Rozwiązanie:** Skrypt automatycznie to naprawi - potwierdź naciskając **T**

### Problem: Konflikt plików
**Rozwiązanie:** Skrypt automatycznie zapisze Twoje zmiany w `git stash`

---

## 🎓 Pro Tips

### 🚀 Szybszy update bez potwierdzenia
Dodaj na końcu linii w skrypcie (linia 17):
```batch
set "AUTO_UPDATE=1"
```

### 📁 Zmień folder backupów
Zmień linię 23:
```batch
set "BACKUP_FOLDER=D:\MojeBackupy"
```

### 🔔 Sprawdzaj aktualizacje codziennie
Dodaj skrypt do **Harmonogramu zadań Windows**:
1. Otwórz "Harmonogram zadań"
2. Utwórz zadanie podstawowe
3. Wskaż `UPDATE_SERWERA.bat`
4. Ustaw codziennie o 12:00

---

## 📞 Pomoc

**Problem z aktualizacją?**
1. Sprawdź czy Git jest zainstalowany: `git --version` w CMD
2. Sprawdź czy folder istnieje
3. Zobacz logi w folderze `BACKUPY`

**GitHub:** https://github.com/mlodyerik/nitrorpg

---

## ✅ Checklist pierwszego użycia:

- [ ] Pobrałem `UPDATE_SERWERA.bat` z GitHuba
- [ ] Zmieniłem ścieżkę w linii 17
- [ ] Zainstalowałem Git (jeśli nie miałem)
- [ ] Uruchomiłem skrypt
- [ ] Działa! 🎉

---

**Ostatnia aktualizacja:** 6 listopada 2026  
**Wersja skryptu:** 1.0
