-- ============================================================================
-- NitroRPG Database Update - Naprawa brakujących kolumn
-- Data: 2026-11-06
-- Wersja: 1.2
-- ============================================================================
-- Ten skrypt dodaje brakujące kolumny do istniejących tabel
-- Uruchom go TYLKO jeśli już zaimportowałeś nitrorpg.sql i masz błędy
-- Skrypt jest bezpieczny - sprawdza czy kolumny już istnieją
-- ============================================================================

USE `nitrorpg`;

-- Naprawa tabeli pystories_houses - dodanie brakujących kolumn (jeśli nie istnieją)

-- Dodaj owner_name jeśli nie istnieje
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'nitrorpg' 
AND TABLE_NAME = 'pystories_houses' 
AND COLUMN_NAME = 'owner_name';

SET @query = IF(@col_exists = 0, 
    'ALTER TABLE `pystories_houses` ADD COLUMN `owner_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `owner`',
    'SELECT "Kolumna owner_name już istnieje" as Info');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Dodaj interiorSize jeśli nie istnieje
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'nitrorpg' 
AND TABLE_NAME = 'pystories_houses' 
AND COLUMN_NAME = 'interiorSize';

SET @query = IF(@col_exists = 0, 
    'ALTER TABLE `pystories_houses` ADD COLUMN `interiorSize` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT "small" AFTER `dimension`',
    'SELECT "Kolumna interiorSize już istnieje" as Info');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Dodaj date jeśli nie istnieje
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'nitrorpg' 
AND TABLE_NAME = 'pystories_houses' 
AND COLUMN_NAME = 'date';

SET @query = IF(@col_exists = 0, 
    'ALTER TABLE `pystories_houses` ADD COLUMN `date` datetime DEFAULT NULL AFTER `rent`',
    'SELECT "Kolumna date już istnieje" as Info');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Dodaj indeks na date jeśli nie istnieje
SET @index_exists = 0;
SELECT COUNT(*) INTO @index_exists 
FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = 'nitrorpg' 
AND TABLE_NAME = 'pystories_houses' 
AND INDEX_NAME = 'date';

SET @query = IF(@index_exists = 0, 
    'ALTER TABLE `pystories_houses` ADD KEY `date` (`date`)',
    'SELECT "Indeks date już istnieje" as Info');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Komunikat końcowy
SELECT 'Sprawdzanie i naprawa struktury zakończona!' as STATUS;
