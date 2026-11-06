-- ============================================================================
-- NitroRPG Database Update - Naprawa brakujących kolumn
-- Data: 2026-11-06
-- Wersja: 1.1
-- ============================================================================
-- Ten skrypt dodaje brakujące kolumny do istniejących tabel
-- Uruchom go TYLKO jeśli już zaimportowałeś nitrorpg.sql i masz błędy
-- ============================================================================

USE `nitrorpg`;

-- Naprawa tabeli pystories_houses - dodanie brakujących kolumn
ALTER TABLE `pystories_houses` 
ADD COLUMN `owner_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `owner`,
ADD COLUMN `interiorSize` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'small' AFTER `dimension`,
ADD COLUMN `date` datetime DEFAULT NULL AFTER `rent`,
ADD KEY `date` (`date`);

-- Komunikat
SELECT 'Brakujące kolumny zostały dodane pomyślnie!' as STATUS;
