# 💰 INSTRUKCJA WYMAKSOWANIA KONTA

## 🎯 Co dostaniesz:

### Pieniądze:
- 💵 Gotówka: **999,999,999 PLN** (~1 miliard)
- 🏦 Bank: **999,999,999 PLN** (~1 miliard)

### Poziom i punkty:
- 🎖️ Poziom: **100** (max)
- ⭐ EXP: **999,999**
- 🎁 Punkty Premium (PP): **999,999**
- 🏆 Punkty SRP: **999,999**
- 🔑 Klucze do skrzynek: **500**
- 👑 Respekt: **999,999**

### Prawa jazdy:
- ✅ Kategoria A (motory)
- ✅ Kategoria B (samochody)
- ✅ Kategoria C (ciężarówki)
- ✅ Kategoria L (łodzie)

### Premium:
- 💎 Premium: **Aktywne do 2030-12-31**
- 💎💎 Premium Plus: **Aktywne do 2030-12-31**

### Pojazdy (5 sztuk, wszystkie po full tuningu):
1. 🏎️ **Infernus** (411) - Czerwony metallic, neon czerwony, V12 5.0L
2. 🏎️ **Bullet** (541) - Niebieski metallic, neon niebieski, V12 6.0L
3. 🏎️ **Turismo** (451) - Złoty metallic, neon złoty, V12 5.5L
4. 🏍️ **NRG-500** (522) - Zielony metallic, neon zielony, V4 1.3L (najszybszy motor)
5. 🚗 **Sultan** (560) - Fioletowy metallic, neon fioletowy, V8 3.5L (tuning beast)

**Wszystkie auta:**
- ✅ Zdrowie: 100%
- ✅ Pełny bak
- ✅ Przebieg: 0 km
- ✅ Maksymalny silnik
- ✅ Paintjob
- ✅ Neony
- ✅ Custom kolory

### Ekwipunek:
- 📱 Telefon
- 🔑 50x Klucze do aut
- 🏥 100x Apteczki
- 🍔 100x Kanapki
- 💧 100x Woda

---

## 📋 JAK UŻYĆ:

### Krok 1: Przygotowanie
1. Otwórz plik: `WYMAKSUJ_KONTO.sql`
2. Znajdź linię (około linia 12):
   ```sql
   SET @login = 'TWOJ_LOGIN';  -- <-- ZMIEŃ TO NA SWÓJ NICK!
   ```
3. Zamień `'TWOJ_LOGIN'` na swój nick w grze, np.:
   ```sql
   SET @login = 'mlodyerik';
   ```

### Krok 2: Wykonanie w bazie danych

#### Opcja A: phpMyAdmin
1. Wejdź na phpMyAdmin
2. Wybierz bazę `nitrorpg`
3. Kliknij zakładkę **SQL**
4. Wklej **CAŁY** plik `WYMAKSUJ_KONTO.sql`
5. Kliknij **Wykonaj**

#### Opcja B: MySQL Workbench
1. Otwórz MySQL Workbench
2. Połącz się z bazą
3. Otwórz nowy SQL tab
4. Wklej **CAŁY** plik `WYMAKSUJ_KONTO.sql`
5. Kliknij **Execute** (⚡)

#### Opcja C: Linia komend
```bash
mysql -u root -p nitrorpg < WYMAKSUJ_KONTO.sql
```

### Krok 3: Sprawdzenie
Po wykonaniu SQLa zobaczysz podsumowanie:
```
✅ Konto mlodyerik zostało wymaksowane!
💰 Gotówka: 999,999,999 PLN
🏦 Bank: 999,999,999 PLN
🚗 Dodano pojazdów: 5 sztuk
📦 Przedmiotów w ekwipunku: 5 sztuk
```

### Krok 4: Przelogowanie
1. **Zrestartuj serwer MTA** (najlepiej)
   
   LUB
   
2. **Wyloguj się i zaloguj ponownie**

---

## ⚠️ UWAGI:

1. **Backup bazy!** Zawsze zrób backup przed edycją:
   ```sql
   mysqldump -u root -p nitrorpg > backup_przed_wymaksowaniem.sql
   ```

2. **Zamień nick!** Jeśli nie zmienisz `'TWOJ_LOGIN'`, skrypt NIC NIE ZROBI!

3. **Pozycja aut:** Wszystkie auta spawią się w Los Santos na pozycji `1721.98, -1706.17` (przed spawn LS). Możesz je znaleźć w swoim parkingu.

4. **Tuning:** Auta mają już zmaksowany tuning - nie musisz nic robić w warsztacie!

5. **Jeśli chcesz WIĘCEJ aut:** Skopiuj jeden z bloków `INSERT INTO pystories_vehicles` i zmień:
   - `model` - ID pojazdu (lista: https://wiki.multitheftauto.com/wiki/Vehicle_IDs)
   - `pos` - pozycję Y (`-1706.17` → `-1726.17` itd.)
   - `color` - kolory (RGB)

---

## 🚗 LISTA FAJNYCH MODELÓW AUT:

| Model | ID | Nazwa | Typ |
|-------|----|----|-----|
| 411 | Infernus | Super sportowy |
| 541 | Bullet | Super sportowy |
| 451 | Turismo | Sportowy |
| 560 | Sultan | Tuning |
| 562 | Elegy | Sportowy |
| 565 | Flash | Sportowy |
| 429 | Banshee | Sportowy |
| 522 | NRG-500 | Motor sportowy |
| 520 | Hydra | Myśliwiec |
| 519 | Shamal | Samolot prywatny |

---

## 🎨 CUSTOMIZACJA KOLORÓW:

Format: `R,G,B,R2,G2,B2,...` (3 kolory po 3 wartości RGB)

**Przykłady:**
- Czerwony metallic: `255,0,0,255,255,255,0,0,0,255,255,255`
- Niebieski metallic: `0,0,255,255,255,255,255,255,255,0,0,255`
- Czarny mat: `20,20,20,20,20,20,20,20,20,20,20,20`
- Biały perłowy: `255,255,255,240,240,255,255,255,255,255,255,255`

---

## ❓ PROBLEMY?

### "Konto nie zostało zaktualizowane"
- Sprawdź czy zmieniłeś `'TWOJ_LOGIN'` na swój nick
- Sprawdź czy nick jest DOKŁADNIE taki sam jak w grze (wielkość liter!)

### "Nie widzę aut w grze"
- Zrestartuj serwer
- Sprawdź `/mypojazdy` w grze
- Sprawdź parking

### "Nie mam pieniędzy"
- Przeloguj się
- Sprawdź w bazie czy UPDATE się wykonał:
  ```sql
  SELECT login, money, bank_money FROM pystories_users WHERE login = 'TWOJ_NICK';
  ```

---

**Powodzenia i dobrej zabawy!** 🚀🔥
