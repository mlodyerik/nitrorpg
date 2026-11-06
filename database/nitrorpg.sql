-- ============================================================================
-- NitroRPG Database Structure
-- Odtworzone na podstawie analizy wszystkich zasobów serwera
-- Wersja: 1.0
-- Data: 2026-11-06
-- Kompatybilność: MySQL 5.7+ / MariaDB 10.3+
-- ============================================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- ============================================================================
-- DATABASE CREATION
-- ============================================================================

CREATE DATABASE IF NOT EXISTS `nitrorpg` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `nitrorpg`;

-- ============================================================================
-- TABLE: pystories_users
-- Główna tabela użytkowników - przechowuje konta graczy
-- ============================================================================

DROP TABLE IF EXISTS `pystories_users`;
CREATE TABLE `pystories_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pass` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `money` int(11) NOT NULL DEFAULT 5000,
  `bank_money` int(11) NOT NULL DEFAULT 0,
  `skin` int(11) NOT NULL DEFAULT 78,
  `lvl` int(11) NOT NULL DEFAULT 1,
  `exp` int(11) NOT NULL DEFAULT 0,
  `hours` decimal(10,2) NOT NULL DEFAULT 0.00,
  `pp` int(11) NOT NULL DEFAULT 0,
  `srp` int(11) NOT NULL DEFAULT 0,
  `klucze` int(11) NOT NULL DEFAULT 0,
  `respekt` int(11) NOT NULL DEFAULT 0,
  `mandate` int(11) NOT NULL DEFAULT 0,
  `pjA` tinyint(1) NOT NULL DEFAULT 0,
  `pjB` tinyint(1) NOT NULL DEFAULT 0,
  `pjC` tinyint(1) NOT NULL DEFAULT 0,
  `pjL` tinyint(1) NOT NULL DEFAULT 0,
  `worker` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ostatnia_pozycja` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0, 0, 3, 0, 0',
  `premium` tinyint(1) NOT NULL DEFAULT 0,
  `premiumdate` datetime DEFAULT NULL,
  `premiumplus` tinyint(1) NOT NULL DEFAULT 0,
  `premiumplusdate` datetime DEFAULT NULL,
  `changedpw` tinyint(1) NOT NULL DEFAULT 0,
  `code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seriale` text COLLATE utf8mb4_unicode_ci,
  `kod` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discordconnected` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT 'Nie',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `register_serial` (`register_serial`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_vehicles
-- Tabela pojazdów graczy
-- ============================================================================

DROP TABLE IF EXISTS `pystories_vehicles`;
CREATE TABLE `pystories_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` int(11) NOT NULL,
  `pos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0,0,3,0,0,0',
  `color` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0',
  `headlights` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '255,255,255',
  `neonColor` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '255,255,255',
  `licznikColor` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '255,255,255',
  `wariant` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '0,0',
  `paintjob` tinyint(4) NOT NULL DEFAULT 3,
  `custompj` int(11) NOT NULL DEFAULT 0,
  `plateText` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `frozen` tinyint(1) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 1000,
  `fuel` decimal(10,2) NOT NULL DEFAULT 25.00,
  `bak` int(11) NOT NULL DEFAULT 25,
  `mileage` decimal(10,2) NOT NULL DEFAULT 0.00,
  `silnik` int(11) NOT NULL DEFAULT 1600,
  `cylindry` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT 'V2',
  `engineType` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'Diesel',
  `tint` int(11) NOT NULL DEFAULT 0,
  `motyw` int(11) NOT NULL DEFAULT 0,
  `driver` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ownedPlayer` int(11) NOT NULL DEFAULT 0,
  `ownedGroup` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `rent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `parking` tinyint(1) NOT NULL DEFAULT 1,
  `police` tinyint(1) NOT NULL DEFAULT 0,
  `tp_to_parking` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tradeban` datetime DEFAULT NULL,
  `salondata` int(11) NOT NULL DEFAULT 0,
  `cena` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ownedPlayer` (`ownedPlayer`),
  KEY `parking` (`parking`),
  KEY `police` (`police`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_vehicles_parking
-- Historia parkingów pojazdów (mandat za parkowanie, odholowanie)
-- ============================================================================

DROP TABLE IF EXISTS `pystories_vehicles_parking`;
CREATE TABLE `pystories_vehicles_parking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpojazdu` int(11) NOT NULL,
  `funkcjonariusz` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rejestracja` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `powod` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cena` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idpojazdu` (`idpojazdu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_ekwipunek
-- Ekwipunek gracza (przedmioty)
-- ============================================================================

DROP TABLE IF EXISTS `pystories_ekwipunek`;
CREATE TABLE `pystories_ekwipunek` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `item` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ilosc` int(11) NOT NULL DEFAULT 1,
  `legal` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `item` (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_factions
-- Członkostwo graczy we frakcjach (SAPD, SAFD, SARA, itd.)
-- ============================================================================

DROP TABLE IF EXISTS `pystories_factions`;
CREATE TABLE `pystories_factions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `faction` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `actived` datetime DEFAULT NULL,
  `joined` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_faction` (`uid`, `faction`),
  KEY `uid` (`uid`),
  KEY `faction` (`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_organizacje
-- Członkostwo graczy w organizacjach
-- ============================================================================

DROP TABLE IF EXISTS `pystories_organizacje`;
CREATE TABLE `pystories_organizacje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `aktywny` date DEFAULT NULL,
  `dolaczyl` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_organizacje_info
-- Informacje o organizacjach
-- ============================================================================

DROP TABLE IF EXISTS `pystories_organizacje_info`;
CREATE TABLE `pystories_organizacje_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zalozyciel` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `utworzona` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `punkty` int(11) NOT NULL DEFAULT 0,
  `spawn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0,0,3,0,0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nazwa` (`nazwa`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_houses
-- System domów/nieruchomości
-- ============================================================================

DROP TABLE IF EXISTS `pystories_houses`;
CREATE TABLE `pystories_houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `pos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `dimension` int(11) NOT NULL DEFAULT 0,
  `interiorObjects` text COLLATE utf8mb4_unicode_ci,
  `interiorWalls` text COLLATE utf8mb4_unicode_ci,
  `interiorFloor` text COLLATE utf8mb4_unicode_ci,
  `rent` text COLLATE utf8mb4_unicode_ci,
  `locked` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_ban
-- System banów
-- ============================================================================

DROP TABLE IF EXISTS `pystories_ban`;
CREATE TABLE `pystories_ban` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `nick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nadawca` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ban',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `serial` (`serial`),
  KEY `active` (`active`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_punish
-- System kar (mute, jail, itp.)
-- ============================================================================

DROP TABLE IF EXISTS `pystories_punish`;
CREATE TABLE `pystories_punish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `serial` (`serial`),
  KEY `type` (`type`),
  KEY `active` (`active`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_friends
-- System znajomych
-- ============================================================================

DROP TABLE IF EXISTS `pystories_friends`;
CREATE TABLE `pystories_friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `friendsid` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `friendsid` (`friendsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_invites
-- Zaproszenia do znajomych
-- ============================================================================

DROP TABLE IF EXISTS `pystories_invites`;
CREATE TABLE `pystories_invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `friendUID` int(11) NOT NULL,
  `friendNick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inviteUID` int(11) NOT NULL,
  `inviteNick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `friendUID` (`friendUID`),
  KEY `inviteUID` (`inviteUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_chat
-- Historia czatu między graczami
-- ============================================================================

DROP TABLE IF EXISTS `pystories_chat`;
CREATE TABLE `pystories_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `friendsid` int(11) NOT NULL,
  `chatID` int(11) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `emoji` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `friendsid` (`friendsid`),
  KEY `chatID` (`chatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_admins
-- Lista administratorów
-- ============================================================================

DROP TABLE IF EXISTS `pystories_admins`;
CREATE TABLE `pystories_admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `reporty` int(11) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`),
  KEY `uid` (`uid`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_settings
-- Ustawienia graczy
-- ============================================================================

DROP TABLE IF EXISTS `pystories_settings`;
CREATE TABLE `pystories_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_components
-- Komponenty pojazdów (tuning)
-- ============================================================================

DROP TABLE IF EXISTS `pystories_components`;
CREATE TABLE `pystories_components` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `color` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '255, 255, 255',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_whitelist
-- Whitelist serwera
-- ============================================================================

DROP TABLE IF EXISTS `pystories_whitelist`;
CREATE TABLE `pystories_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_aktualizacje
-- System aktualizacji/newsów
-- ============================================================================

DROP TABLE IF EXISTS `pystories_aktualizacje`;
CREATE TABLE `pystories_aktualizacje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dodal` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `typ` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aktualizacja` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_marihuana
-- System upraw marihuany (organizacje)
-- ============================================================================

DROP TABLE IF EXISTS `pystories_marihuana`;
CREATE TABLE `pystories_marihuana` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `stan` int(11) NOT NULL DEFAULT 0,
  `pos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: pystories_stereo
-- System odtwarzacza muzyki w pojazdach
-- ============================================================================

DROP TABLE IF EXISTS `pystories_stereo`;
CREATE TABLE `pystories_stereo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `nazwa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ulubione` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `ulubione` (`ulubione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- TABLE: discord_connect
-- Połączenie kont Discord z kontami gry
-- ============================================================================

DROP TABLE IF EXISTS `discord_connect`;
CREATE TABLE `discord_connect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `discordid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatarurl` text COLLATE utf8mb4_unicode_ci,
  `booster` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sid` (`sid`),
  UNIQUE KEY `discordid` (`discordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;

-- ============================================================================
-- INITIAL DATA - Przykładowe dane początkowe
-- ============================================================================

-- Przykładowa aktualizacja
INSERT INTO `pystories_aktualizacje` (`dodal`, `typ`, `aktualizacja`) VALUES
('System', 'info', 'Witamy na serwerze NitroRPG! Serwer został pomyślnie skonfigurowany.');

-- ============================================================================
-- COMMIT
-- ============================================================================

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
