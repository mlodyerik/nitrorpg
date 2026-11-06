-- ============================================================================
-- NitroRPG - Dodanie brakujących tabel
-- Wersja: 1.3
-- Data: 2026-11-06
-- ============================================================================
-- Ten skrypt dodaje wszystkie brakujące tabele wykryte w logach serwera
-- ============================================================================

USE `nitrorpg`;

-- ============================================================================
-- TABELA: aj (Admin Jail - Więzienie administracyjne)
-- Przechowuje informacje o karach więzienia nakładanych przez administratorów/policję
-- ============================================================================

CREATE TABLE IF NOT EXISTS `aj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Serial MTA gracza',
  `Termin` datetime NOT NULL COMMENT 'Data zakończenia kary',
  `Cela` int(11) NOT NULL DEFAULT 1 COMMENT 'Numer celi',
  `Powod` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Powód uwięzienia',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data nałożenia kary',
  PRIMARY KEY (`id`),
  KEY `Serial` (`Serial`),
  KEY `Termin` (`Termin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Więzienie administracyjne (Admin Jail)';

-- ============================================================================
-- TABELA: pystories_organizacje_info  
-- Przechowuje informacje o nielegalnych organizacjach graczy
-- ============================================================================

CREATE TABLE IF NOT EXISTS `pystories_organizacje_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nazwa organizacji',
  `zalozyciel` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nick założyciela',
  `zalozyciel_sid` int(11) NOT NULL COMMENT 'SID założyciela',
  `data_zalozenia` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data założenia organizacji',
  `punkty` int(11) NOT NULL DEFAULT 0 COMMENT 'Punkty respektu organizacji',
  `kasa` int(11) NOT NULL DEFAULT 0 COMMENT 'Wspólny budżet organizacji',
  `spawn_pos` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Pozycja spawnu: x,y,z',
  `spawn_interior` int(11) NOT NULL DEFAULT 0 COMMENT 'Interior spawnu',
  `spawn_dimension` int(11) NOT NULL DEFAULT 0 COMMENT 'Dimension spawnu',
  `opis` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Opis organizacji',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=aktywna, 0=nieaktywna',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nazwa` (`nazwa`),
  KEY `zalozyciel_sid` (`zalozyciel_sid`),
  KEY `punkty` (`punkty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Informacje o organizacjach graczy';

-- ============================================================================
-- TABELA: pystories_marihuana
-- Przechowuje informacje o sadzonkach marihuany zasadzonych przez graczy
-- ============================================================================

CREATE TABLE IF NOT EXISTS `pystories_marihuana` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL COMMENT 'SID gracza który zasadził',
  `pos_x` float NOT NULL COMMENT 'Pozycja X',
  `pos_y` float NOT NULL COMMENT 'Pozycja Y',
  `pos_z` float NOT NULL COMMENT 'Pozycja Z',
  `czas_posadzenia` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Kiedy zasadzono',
  `czas_zbioru` datetime NOT NULL COMMENT 'Kiedy można zebrać',
  `zebrana` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=rośnie, 1=zebrana',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `zebrana` (`zebrana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Sadzonki marihuany';

-- ============================================================================
-- TABELA: lss_domy (Legacy - stary system domów)
-- Może być używana przez stare skrypty administracyjne
-- ============================================================================

CREATE TABLE IF NOT EXISTS `lss_domy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descr` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Mieszkanie' COMMENT 'Opis domu',
  `i` int(11) NOT NULL DEFAULT 0,
  `vwe` int(11) NOT NULL DEFAULT 0,
  `drzwi` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Pozycja drzwi x,y,z',
  `punkt_wyjscia` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Punkt wyjścia x,y,z',
  `interiorid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID interioru',
  `koszt` int(11) NOT NULL DEFAULT 1000 COMMENT 'Koszt domu',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=aktywny, 0=nieaktywny',
  `owner_sid` int(11) DEFAULT NULL COMMENT 'SID właściciela',
  PRIMARY KEY (`id`),
  KEY `owner_sid` (`owner_sid`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Legacy - stary system domów';

-- ============================================================================
-- Koniec skryptu
-- ============================================================================

SELECT 'Dodano brakujące tabele: aj, pystories_organizacje_info, pystories_marihuana, lss_domy' AS Info;
