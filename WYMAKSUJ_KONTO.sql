-- ============================================================================
-- WYMAKSOWANIE KONTA - NitroRPG
-- ============================================================================
-- INSTRUKCJA:
-- 1. Zamień 'TWOJ_LOGIN' na swój nick w grze (np. 'mlodyerik')
-- 2. Wykonaj te komendy w MySQL/phpMyAdmin
-- 3. Zrestartuj serwer lub przeloguj się
-- ============================================================================

-- USTAW SWÓJ LOGIN TUTAJ:
SET @login = 'TWOJ_LOGIN';  -- <-- ZMIEŃ TO NA SWÓJ NICK!

-- ============================================================================
-- AKTUALIZACJA KONTA UŻYTKOWNIKA
-- ============================================================================

UPDATE pystories_users SET
    -- PIENIĄDZE
    money = 999999999,              -- Gotówka: ~1 miliard PLN
    bank_money = 999999999,         -- Bank: ~1 miliard PLN
    
    -- POZIOM I DOŚWIADCZENIE
    lvl = 100,                      -- Maksymalny poziom
    exp = 999999,                   -- Maxymalny exp
    hours = 9999.99,                -- Wiele godzin gry
    
    -- PUNKTY
    pp = 999999,                    -- Punkty Premium
    srp = 999999,                   -- Punkty SRP
    klucze = 500,                   -- Klucze do skrzynek
    respekt = 999999,               -- Respekt
    
    -- PRAWA JAZDY
    pjA = 1,                        -- Prawo jazdy kategoria A (motory)
    pjB = 1,                        -- Prawo jazdy kategoria B (samochody)
    pjC = 1,                        -- Prawo jazdy kategoria C (ciężarówki)
    pjL = 1,                        -- Prawo jazdy kategoria L (łodzie)
    
    -- PREMIUM
    premium = 1,                    -- Premium aktywne
    premiumdate = '2030-12-31 23:59:59',  -- Premium na zawsze
    premiumplus = 1,                -- Premium Plus aktywne
    premiumplusdate = '2030-12-31 23:59:59'  -- Premium Plus na zawsze

WHERE login = @login;

-- ============================================================================
-- DODANIE FAJNYCH SAMOCHODÓW (wymaksowany tuning)
-- ============================================================================

-- Sprawdzamy ID gracza
SET @player_id = (SELECT id FROM pystories_users WHERE login = @login LIMIT 1);

-- Samochód 1: Infernus (luksusowy sportowy)
INSERT INTO pystories_vehicles (model, pos, color, headlights, neonColor, wariant, paintjob, health, fuel, bak, mileage, silnik, cylindry, engineType, ownedPlayer, driver, parking)
VALUES (
    411,  -- Model: Infernus
    '1721.98, -1706.17, 13.50, 0, 0, 90',  -- Pozycja spawnu LS
    '255,0,0,255,255,255,0,0,0,255,255,255',  -- Kolor: Czerwony metallic
    '255,50,50',  -- Reflektory: Czerwone
    '255,0,0',    -- Neon: Czerwony
    '1,1',        -- Wariant maksymalny
    3,            -- Paintjob
    1000,         -- Zdrowie 100%
    100.00,       -- Pełny bak
    100,          -- Pojemność baku
    0.00,         -- Przebieg 0 km
    5000,         -- Silnik 5.0L
    'V12',        -- 12 cylindrów
    'Benzyna',    -- Typ silnika
    @player_id,   -- Właściciel
    @login,       -- Driver
    1             -- Parking ON
);

-- Samochód 2: Bullet (super sportowy)
INSERT INTO pystories_vehicles (model, pos, color, headlights, neonColor, wariant, paintjob, health, fuel, bak, mileage, silnik, cylindry, engineType, ownedPlayer, driver, parking)
VALUES (
    541,  -- Model: Bullet
    '1721.98, -1710.17, 13.50, 0, 0, 90',
    '0,0,255,255,255,255,255,255,255,0,0,255',  -- Kolor: Niebieski metallic
    '100,150,255',  -- Reflektory: Niebieskie
    '0,100,255',    -- Neon: Niebieski
    '1,1',
    3,
    1000,
    100.00,
    100,
    0.00,
    6000,
    'V12',
    'Benzyna',
    @player_id,
    @login,
    1
);

-- Samochód 3: Turismo (sportowy elegancki)
INSERT INTO pystories_vehicles (model, pos, color, headlights, neonColor, wariant, paintjob, health, fuel, bak, mileage, silnik, cylindry, engineType, ownedPlayer, driver, parking)
VALUES (
    451,  -- Model: Turismo
    '1721.98, -1714.17, 13.50, 0, 0, 90',
    '255,215,0,255,255,255,255,255,255,255,215,0',  -- Kolor: Złoty metallic
    '255,200,100',  -- Reflektory: Złote
    '255,215,0',    -- Neon: Złoty
    '1,1',
    3,
    1000,
    100.00,
    100,
    0.00,
    5500,
    'V12',
    'Benzyna',
    @player_id,
    @login,
    1
);

-- Samochód 4: NRG-500 (najszybszy motor)
INSERT INTO pystories_vehicles (model, pos, color, headlights, neonColor, wariant, paintjob, health, fuel, bak, mileage, silnik, cylindry, engineType, ownedPlayer, driver, parking)
VALUES (
    522,  -- Model: NRG-500
    '1721.98, -1718.17, 13.50, 0, 0, 90',
    '0,255,0,255,255,255,255,255,255,0,255,0',  -- Kolor: Zielony metallic
    '0,255,0',      -- Reflektory: Zielone
    '0,255,0',      -- Neon: Zielony
    '1,1',
    3,
    1000,
    100.00,
    50,
    0.00,
    1300,
    'V4',
    'Benzyna',
    @player_id,
    @login,
    1
);

-- Samochód 5: Sultan (tuning beast)
INSERT INTO pystories_vehicles (model, pos, color, headlights, neonColor, wariant, paintjob, health, fuel, bak, mileage, silnik, cylindry, engineType, ownedPlayer, driver, parking)
VALUES (
    560,  -- Model: Sultan
    '1721.98, -1722.17, 13.50, 0, 0, 90',
    '128,0,128,255,255,255,255,255,255,128,0,128',  -- Kolor: Fioletowy metallic
    '200,0,255',    -- Reflektory: Fioletowe
    '200,0,255',    -- Neon: Fioletowy
    '1,1',
    3,
    1000,
    100.00,
    70,
    0.00,
    3500,
    'V8',
    'Benzyna',
    @player_id,
    @login,
    1
);

-- ============================================================================
-- DODANIE PRZYDATNYCH ITEMÓW DO EKWIPUNKU
-- ============================================================================

-- Telefon
INSERT INTO pystories_ekwipunek (sid, item, type, ilosc, legal)
VALUES (@player_id, 'Telefon', 'item', 1, 'true');

-- Klucze do wszystkich aut (backup)
INSERT INTO pystories_ekwipunek (sid, item, type, ilosc, legal)
VALUES (@player_id, 'Klucze', 'key', 50, 'true');

-- Apteczki
INSERT INTO pystories_ekwipunek (sid, item, type, ilosc, legal)
VALUES (@player_id, 'Apteczka', 'medical', 100, 'true');

-- Jedzenie
INSERT INTO pystories_ekwipunek (sid, item, type, ilosc, legal)
VALUES (@player_id, 'Kanapka', 'food', 100, 'true');

-- Picie
INSERT INTO pystories_ekwipunek (sid, item, type, ilosc, legal)
VALUES (@player_id, 'Woda', 'drink', 100, 'true');

-- ============================================================================
-- PODSUMOWANIE
-- ============================================================================

SELECT CONCAT('✅ Konto ', @login, ' zostało wymaksowane!') AS Status;
SELECT CONCAT('💰 Gotówka: ', FORMAT(money, 0), ' PLN') AS Gotowka FROM pystories_users WHERE login = @login;
SELECT CONCAT('🏦 Bank: ', FORMAT(bank_money, 0), ' PLN') AS Bank FROM pystories_users WHERE login = @login;
SELECT CONCAT('🚗 Dodano pojazdów: ', COUNT(*), ' sztuk') AS Pojazdy FROM pystories_vehicles WHERE driver = @login;
SELECT CONCAT('📦 Przedmiotów w ekwipunku: ', COUNT(*), ' sztuk') AS Ekwipunek FROM pystories_ekwipunek WHERE sid = @player_id;

-- ============================================================================
-- KONIEC
-- ============================================================================
