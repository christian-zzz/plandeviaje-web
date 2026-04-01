-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2026 at 09:28 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pdv`
--

-- --------------------------------------------------------

--
-- Table structure for table `accommodation`
--

CREATE TABLE `accommodation` (
  `accommodation_ID` bigint UNSIGNED NOT NULL,
  `post_FK` bigint UNSIGNED NOT NULL,
  `destination` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `map_location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `starting_price` decimal(10,2) NOT NULL,
  `stars` int NOT NULL,
  `features` text COLLATE utf8mb4_unicode_ci,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `board_type_FK` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accommodation`
--

INSERT INTO `accommodation` (`accommodation_ID`, `post_FK`, `destination`, `map_location`, `starting_price`, `stars`, `features`, `isActive`, `board_type_FK`) VALUES
(1, 2, 'Playa El Agua, Margarita', '', 65.00, 5, NULL, 1, 1),
(2, 5, 'Calle Miragua, Playa El Agua. Isla Margarita', '', 65.00, 5, NULL, 1, 2),
(3, 8, 'Av Aldonza Manrique, Porlamar, Isla de Margarita', '', 57.00, 5, NULL, 1, 2),
(4, 9, 'Avenida 31 de Julio, Playa Manzanillo, Playa El Agua', 'Hotel Hesperia Playa El Agua, Avenida 31 de Julio, Playa Manzanillo, Playa El Agua, Parroquia Paraguachí, Municipio Antolín del Campo, Estado Nueva Esparta, 6324, Venezuela', 48.00, 4, '[{\"icon\":\"wifi\",\"label\":\"WiFi Libre\"},{\"icon\":\"pool\",\"label\":\"Piscina\"},{\"icon\":\"restaurant\",\"label\":\"Restaurante\"},{\"icon\":\"bar\",\"label\":\"Bar\"},{\"icon\":\"clock\",\"label\":\"Recepci\\u00f3n 24h\"},{\"icon\":\"ac\",\"label\":\"Aire Acondicionado\"},{\"icon\":\"parking\",\"label\":\"Estacionamiento\"},{\"icon\":\"beach\",\"label\":\"Acceso a Playa\"},{\"icon\":\"phone\",\"label\":\"Tel\\u00e9fono\"},{\"icon\":\"shuttle\",\"label\":\"Transporte\"}]', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `accommodation_room_type`
--

CREATE TABLE `accommodation_room_type` (
  `id` bigint UNSIGNED NOT NULL,
  `accommodation_id` bigint UNSIGNED NOT NULL,
  `room_type_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accommodation_room_type`
--

INSERT INTO `accommodation_room_type` (`id`, `accommodation_id`, `room_type_id`) VALUES
(2, 4, 2),
(3, 4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `blog_category_ID` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`blog_category_ID`, `name`) VALUES
(1, 'Travel Tips'),
(2, 'Destinations'),
(3, 'Food & Drink'),
(4, 'Culture'),
(5, 'Adventures');

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `blog_post_ID` bigint UNSIGNED NOT NULL,
  `post_FK` bigint UNSIGNED NOT NULL,
  `blog_category_FK` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts_tags`
--

CREATE TABLE `blog_posts_tags` (
  `blog_post_tag_ID` bigint UNSIGNED NOT NULL,
  `blog_post_FK` bigint UNSIGNED NOT NULL,
  `blog_tag_FK` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_tags`
--

CREATE TABLE `blog_tags` (
  `blog_tag_ID` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_tags`
--

INSERT INTO `blog_tags` (`blog_tag_ID`, `name`) VALUES
(1, 'Beach'),
(2, 'Mountain'),
(3, 'City'),
(4, 'Nature'),
(5, 'Luxury'),
(6, 'Budget'),
(7, 'Backpacking');

-- --------------------------------------------------------

--
-- Table structure for table `board_types`
--

CREATE TABLE `board_types` (
  `board_type_ID` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `board_types`
--

INSERT INTO `board_types` (`board_type_ID`, `type`) VALUES
(1, 'Todo Incluido'),
(2, 'Solo Desayuno'),
(3, 'Media Pensión');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-settings.all', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:12:{s:13:\"contact_phone\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:1;s:3:\"key\";s:13:\"contact_phone\";s:5:\"value\";s:12:\"582952644299\";s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:1;s:3:\"key\";s:13:\"contact_phone\";s:5:\"value\";s:12:\"582952644299\";s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:13:\"contact_email\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:2;s:3:\"key\";s:13:\"contact_email\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:2;s:3:\"key\";s:13:\"contact_email\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:15:\"contact_address\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:3;s:3:\"key\";s:15:\"contact_address\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:3;s:3:\"key\";s:15:\"contact_address\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:15:\"social_facebook\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:4;s:3:\"key\";s:15:\"social_facebook\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:4;s:3:\"key\";s:15:\"social_facebook\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:16:\"social_instagram\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:5;s:3:\"key\";s:16:\"social_instagram\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:5;s:3:\"key\";s:16:\"social_instagram\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:16:\"contact_whatsapp\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:6;s:3:\"key\";s:16:\"contact_whatsapp\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:6;s:3:\"key\";s:16:\"contact_whatsapp\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:48:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:22:\"contact_hours_weekdays\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:7;s:3:\"key\";s:22:\"contact_hours_weekdays\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:7;s:3:\"key\";s:22:\"contact_hours_weekdays\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:22:\"contact_hours_saturday\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:8;s:3:\"key\";s:22:\"contact_hours_saturday\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:8;s:3:\"key\";s:22:\"contact_hours_saturday\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:20:\"contact_hours_sunday\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:9;s:3:\"key\";s:20:\"contact_hours_sunday\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:9;s:3:\"key\";s:20:\"contact_hours_sunday\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:17:\"contact_map_frame\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:10;s:3:\"key\";s:17:\"contact_map_frame\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:10;s:3:\"key\";s:17:\"contact_map_frame\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:17:\"contact_video_url\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:11;s:3:\"key\";s:17:\"contact_video_url\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:11;s:3:\"key\";s:17:\"contact_video_url\";s:5:\"value\";N;s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:14:\"_setting_group\";O:18:\"App\\Models\\Setting\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"settings\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:12;s:3:\"key\";s:14:\"_setting_group\";s:5:\"value\";s:11:\"informacion\";s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:12;s:3:\"key\";s:14:\"_setting_group\";s:5:\"value\";s:11:\"informacion\";s:4:\"type\";s:4:\"text\";s:5:\"group\";s:7:\"general\";s:10:\"created_at\";s:19:\"2026-03-27 15:13:26\";s:10:\"updated_at\";s:19:\"2026-03-27 15:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:3:\"key\";i:1;s:5:\"value\";i:2;s:4:\"type\";i:3;s:5:\"group\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 2089986565),
('laravel-cache-settings.contenido', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 2089986705);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consultants`
--

CREATE TABLE `consultants` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `country_ID` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`country_ID`, `name`) VALUES
(1, 'USA'),
(11, 'Argentina'),
(12, 'Bolivia'),
(24, 'Mexico'),
(25, 'Colombia');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `flights_ID` bigint UNSIGNED NOT NULL,
  `post_FK` bigint UNSIGNED NOT NULL,
  `destination` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_FK` bigint UNSIGNED NOT NULL,
  `map_location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `features` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `requirements` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `starting_price` decimal(10,2) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`flights_ID`, `post_FK`, `destination`, `country_FK`, `map_location`, `features`, `requirements`, `starting_price`, `isActive`) VALUES
(3, 6, 'Bogotá, Distrito Capital', 25, '4.6533817,-74.0836331', '[{\"icon\":\"laundry\",\"label\":\"Maleta 26Kg\"},{\"icon\":\"clock\",\"label\":\"Tarifa Febrero 2026\"}]', '[\"Se debe diligenciar el Check-Mig en la p\\u00e1gina de Migraci\\u00f3n Colombia\",\"Acta de nacimiento para menores de edad\",\"Tarjeta de Movilidad Fronteriza (TMF)\",\"Permiso Especial de Permanencia (PEP) o Permiso por Protecci\\u00f3n Temporal (PPT)\",\"C\\u00e9dula de identidad venezolana\",\"Pasaporte vigente o con hasta 10 a\\u00f1os de haber perdido su vigencia\"]', 406.00, 1),
(4, 7, 'Cancún', 24, '21.1527467,-86.8425761', '[{\"icon\":\"laundry\",\"label\":\"Maleta 23Kg\"},{\"icon\":\"clock\",\"label\":\"Tarifa Enero 2026\"}]', '[\"Carta de invitaci\\u00f3n o reservaci\\u00f3n de hotel\",\"Boleto ida y vuelta\",\"Solvencia econ\\u00f3mica ha dicho pa\\u00eds\",\"Permanencia m\\u00e1xima permitida para ciudadanos venezolanos ciento ochenta (180) d\\u00edas\",\"Pasaporte v\\u00e1lido y vigente durante toda su estancia en M\\u00e9xico\",\"Visa de visitante\"]', 461.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `guest_types`
--

CREATE TABLE `guest_types` (
  `guest_type_ID` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `guest_types`
--

INSERT INTO `guest_types` (`guest_type_ID`, `type`) VALUES
(1, 'Pareja'),
(2, 'Familia'),
(3, 'Individual');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_ID` bigint UNSIGNED NOT NULL,
  `post_FK` bigint UNSIGNED NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_ID`, `post_FK`, `url`) VALUES
(1, 5, '/storage/uploads/migrated_1774621334_NUnR1.jpg'),
(2, 5, '/storage/uploads/migrated_1774621338_yQJ9O.jpg'),
(3, 5, '/storage/uploads/migrated_1774621341_GRIwn.jpg'),
(14, 9, '/storage/uploads/migrated_1774621350_Rwf5C.webp'),
(15, 9, '/storage/uploads/migrated_1774621355_nzncH.webp'),
(16, 9, 'https://cotizador.plandeviaje.com.ve/src/images/galeria_hotel/96ea91d88f2554bce46872bd4e744dd6.webp'),
(17, 9, '/storage/uploads/migrated_1774621372_niMuR.webp'),
(18, 9, '/storage/uploads/migrated_1774621377_FeWCf.webp'),
(19, 9, '/storage/uploads/migrated_1774621381_zr72K.webp'),
(20, 10, '/storage/uploads/migrated_1774621385_Nthng.webp'),
(21, 10, '/storage/uploads/migrated_1774621392_YFQIV.webp'),
(22, 10, '/storage/uploads/migrated_1774621396_ip0JY.webp'),
(23, 10, '/storage/uploads/migrated_1774621400_jUgVS.webp'),
(24, 10, '/storage/uploads/migrated_1774621404_xMLyB.webp'),
(25, 10, '/storage/uploads/migrated_1774621408_7Ez8c.webp'),
(26, 6, '/storage/uploads/migrated_1774621411_1lwkm.jpg'),
(27, 6, '/storage/uploads/migrated_1774621414_RCTfQ.jpg'),
(28, 6, '/storage/uploads/migrated_1774621418_8EhnN.jpg'),
(29, 6, '/storage/uploads/migrated_1774621421_mYlw3.jpg'),
(30, 7, '/storage/uploads/migrated_1774621424_gBhhJ.jpg'),
(31, 7, '/storage/uploads/migrated_1774621427_Bv6ih.jpg'),
(32, 7, '/storage/uploads/migrated_1774621428_ouurN.jpg'),
(33, 7, '/storage/uploads/migrated_1774621430_pToXa.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `inquiries_ID` bigint UNSIGNED NOT NULL,
  `post_FK` bigint UNSIGNED NOT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guest_type_FK` bigint UNSIGNED NOT NULL,
  `kids` tinyint(1) NOT NULL,
  `from_date` timestamp NULL DEFAULT NULL,
  `to_date` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `consultant_id` bigint UNSIGNED DEFAULT NULL,
  `assignment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `assigned_at` timestamp NULL DEFAULT NULL,
  `data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_02_06_000001_create_lookup_tables', 1),
(5, '2026_02_06_000002_create_posts_table', 1),
(6, '2026_02_06_000003_create_post_subtypes_tables', 1),
(7, '2026_02_06_000004_create_inquiries_and_others_table', 1),
(8, '2026_02_06_152918_create_personal_access_tokens_table', 2),
(10, '2026_02_27_155616_add_google_id_avatar_users_table', 3),
(11, '2026_02_27_170700_add_google_id_to_users_table', 4),
(12, '2026_02_27_185920_create_consultants_table', 4),
(13, '2026_02_27_190049_add_assignment_fields_to_inquiries_table', 4),
(14, '2026_03_06_154106_add_room_types_and_update_accommodation_table', 5),
(15, '2026_03_06_155452_modify_accommodation_room_types_relation', 6),
(16, '2026_03_06_161500_add_guest_and_board_types_to_flights_table', 7),
(17, '2026_03_06_170759_remove_guest_type_and_days_from_accommodation_table', 8),
(18, '2026_03_20_160638_remove_guest_board_from_flights_table', 9),
(19, '2026_03_20_173257_add_data_to_inquiries_table', 10),
(20, '2026_03_27_083739_create_settings_table', 11);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `packages_ID` bigint UNSIGNED NOT NULL,
  `post_FK` bigint UNSIGNED NOT NULL,
  `accommodation_FK` bigint UNSIGNED NOT NULL,
  `features` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `starting_price` decimal(10,2) NOT NULL,
  `days` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guest_type_FK` bigint UNSIGNED NOT NULL,
  `board_type_FK` bigint UNSIGNED NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `isFeatured` tinyint(1) NOT NULL,
  `end_date` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`packages_ID`, `post_FK`, `accommodation_FK`, `features`, `starting_price`, `days`, `guest_type_FK`, `board_type_FK`, `isActive`, `isFeatured`, `end_date`) VALUES
(1, 3, 1, '[{\"icon\":\"wifi\",\"label\":\"WiFi Libre\"},{\"icon\":\"pool\",\"label\":\"Piscina\"},{\"icon\":\"restaurant\",\"label\":\"Restaurante\"},{\"icon\":\"bar\",\"label\":\"Bar\"},{\"icon\":\"clock\",\"label\":\"Recepci\\u00f3n 24h\"},{\"icon\":\"ac\",\"label\":\"Aire Acondicionado\"},{\"icon\":\"parking\",\"label\":\"Estacionamiento\"},{\"icon\":\"beach\",\"label\":\"Acceso a Playa\"},{\"icon\":\"phone\",\"label\":\"Tel\\u00e9fono\"},{\"icon\":\"shuttle\",\"label\":\"Transporte\"},{\"icon\":\"beach\",\"label\":\"Habitacion Doble\"},{\"icon\":\"restaurant\",\"label\":\"Todas las comidas\"},{\"icon\":\"bar\",\"label\":\"Bebidas Nacionales Ilimitadas\"},{\"icon\":\"spa\",\"label\":\"Animacion y Recreacion\"},{\"icon\":\"kids\",\"label\":\"\\u00c1rea Infantil\"},{\"icon\":\"tennis\",\"label\":\"Habitaciones Pet Friendly\"}]', 118.00, '3 Días / 2 Noches', 3, 1, 1, 1, '2026-03-27 10:19:26'),
(2, 10, 4, '[{\"icon\":\"wifi\",\"label\":\"WiFi Libre\"},{\"icon\":\"pool\",\"label\":\"Piscina\"},{\"icon\":\"restaurant\",\"label\":\"Restaurante\"},{\"icon\":\"bar\",\"label\":\"Bar\"},{\"icon\":\"clock\",\"label\":\"Recepci\\u00f3n 24h\"},{\"icon\":\"ac\",\"label\":\"Aire Acondicionado\"},{\"icon\":\"parking\",\"label\":\"Estacionamiento\"},{\"icon\":\"beach\",\"label\":\"Acceso a Playa\"},{\"icon\":\"phone\",\"label\":\"Tel\\u00e9fono\"},{\"icon\":\"shuttle\",\"label\":\"Transporte\"},{\"icon\":\"beach\",\"label\":\"Habitacion Doble\"},{\"icon\":\"restaurant\",\"label\":\"Todas las comidas\"},{\"icon\":\"bar\",\"label\":\"Bebidas Nacionales Ilimitadas\"},{\"icon\":\"spa\",\"label\":\"Animacion y Recreacion\"},{\"icon\":\"kids\",\"label\":\"\\u00c1rea Infantil\"},{\"icon\":\"tennis\",\"label\":\"Habitaciones Pet Friendly\"}]', 255.00, '4 Días / 3 Noches', 3, 1, 1, 1, '2026-03-27 10:19:26');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 1, 'auth_token', '72590ef9a75b3b0da133aa8f794c3670674d1fafeb86a0953271654b40e7a3d9', '[\"*\"]', '2026-02-27 20:10:36', NULL, '2026-02-27 19:44:25', '2026-02-27 20:10:36'),
(3, 'App\\Models\\User', 1, 'auth_token', '8d7d9943e1b86d9e193e9f2be0bff85e232a748c4b856a87d867e7f9d982a33d', '[\"*\"]', '2026-02-27 20:12:28', NULL, '2026-02-27 20:12:04', '2026-02-27 20:12:28'),
(17, 'App\\Models\\User', 1, 'auth_token', 'e51428258e819eb4bbb437e997c2f57dfaa6cb8a590a8ad91289bf20d8c22378', '[\"*\"]', '2026-02-28 17:12:50', NULL, '2026-02-27 23:23:22', '2026-02-28 17:12:50'),
(19, 'App\\Models\\User', 4, 'auth_token', '51b8dc18ffb09282c68caf803d4f60bbf9935d73323f644038e2569625bdfe76', '[\"*\"]', '2026-03-02 06:57:46', NULL, '2026-03-02 06:57:44', '2026-03-02 06:57:46'),
(20, 'App\\Models\\User', 1, 'auth_token', '085c827e4b228ace7b7731a199c3de1210b6ae57d475383c752917c7b2c338e1', '[\"*\"]', '2026-03-03 21:30:27', NULL, '2026-03-03 18:41:40', '2026-03-03 21:30:27'),
(21, 'App\\Models\\User', 1, 'auth_token', 'a5c776edb0e390094165e07079ebe02eff88f7f508b0e6ec6cc4cbfc7b6ed431', '[\"*\"]', '2026-03-04 03:02:40', NULL, '2026-03-04 02:44:40', '2026-03-04 03:02:40'),
(22, 'App\\Models\\User', 1, 'auth_token', 'a77b211b6ef81982f8ed36c3f6eb176c8d0fdc59cb6d341912d069047223dcff', '[\"*\"]', '2026-03-06 22:15:01', NULL, '2026-03-06 19:26:25', '2026-03-06 22:15:01'),
(23, 'App\\Models\\User', 1, 'auth_token', '20079fb904b2b99fdf36ca1b52db8cc01f03b468881279000b803a0160c34a8e', '[\"*\"]', '2026-03-10 19:29:33', NULL, '2026-03-10 17:45:00', '2026-03-10 19:29:33'),
(24, 'App\\Models\\User', 1, 'auth_token', '729983f11d482916d58308340563dd1cf4b067757ff793ba0072a3f2730bf450', '[\"*\"]', '2026-03-11 04:03:13', NULL, '2026-03-10 19:34:26', '2026-03-11 04:03:13'),
(25, 'App\\Models\\User', 1, 'auth_token', '0253bd842e4173480b7b82218beb2433e97041c395d9a7ecfcf5fb34ccebc71e', '[\"*\"]', NULL, NULL, '2026-03-13 19:44:12', '2026-03-13 19:44:12'),
(26, 'App\\Models\\User', 1, 'auth_token', '650eca39efbce90bf4a00a948c8d740acbf38b88a043017b261b7e9e51e121a1', '[\"*\"]', '2026-03-14 08:14:20', NULL, '2026-03-13 19:45:10', '2026-03-14 08:14:20'),
(28, 'App\\Models\\User', 1, 'auth_token', '75cdd3204a874ca35aeb603df2a93ad5f4a75d0d5240b910779e12433a18e00c', '[\"*\"]', '2026-03-18 02:31:56', NULL, '2026-03-18 02:31:52', '2026-03-18 02:31:56'),
(29, 'App\\Models\\User', 1, 'auth_token', '8023ee7bd9abf30688382cc153abaa07cb919b63334698968687561336b9d9e5', '[\"*\"]', '2026-03-20 21:23:57', NULL, '2026-03-20 17:53:21', '2026-03-20 21:23:57'),
(30, 'App\\Models\\User', 1, 'auth_token', '018c44eee9ed1ea91e4564ff695e01ea97100aa7cc8e1c6c074e39fa7e235e87', '[\"*\"]', '2026-03-24 16:11:04', NULL, '2026-03-20 22:35:52', '2026-03-24 16:11:04'),
(31, 'App\\Models\\User', 1, 'auth_token', '77cc576bc7b54d8525e5b36f7390837d9cdcb6e4db8e7184078db2ef7767ca08', '[\"*\"]', '2026-03-27 13:24:45', NULL, '2026-03-27 01:50:42', '2026-03-27 13:24:45'),
(32, 'App\\Models\\User', 1, 'auth_token', '49ce39cd8b684d21b4a784a025aebeea5df69503935fe98e977239a5c9581475', '[\"*\"]', '2026-03-27 13:31:46', NULL, '2026-03-27 13:27:24', '2026-03-27 13:31:46'),
(33, 'App\\Models\\User', 1, 'auth_token', '2c80601825619847c81216b3b35d6d1d55dc1e71b664a98c5361af50e861a3ff', '[\"*\"]', '2026-03-27 23:30:44', NULL, '2026-03-27 14:12:01', '2026-03-27 23:30:44'),
(34, 'App\\Models\\User', 1, 'auth_token', '7fc35dab5b9a941a99ca7a57a16c9bfee261fd5b162659f82e9c70bcdac073cf', '[\"*\"]', '2026-04-01 13:22:47', NULL, '2026-04-01 11:56:41', '2026-04-01 13:22:47'),
(35, 'App\\Models\\User', 1, 'auth_token', '1a7e0f2ef970546fff3fcf48c6511190fb1be602a25cce07ea9887539d371c89', '[\"*\"]', '2026-04-01 12:51:35', NULL, '2026-04-01 12:45:04', '2026-04-01 12:51:35');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_ID` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `overview` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `information` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdBy` bigint UNSIGNED NOT NULL,
  `updatedBy` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_ID`, `name`, `overview`, `information`, `banner`, `thumbnail`, `createdBy`, `updatedBy`, `created_at`, `updated_at`) VALUES
(2, 'Lidotel Agua Dorada', 'Agua Dorada Beach Hotel', '', '/storage/uploads/migrated_1774621246_2rY20.webp', '/storage/uploads/migrated_1774621282_aaCI5.jpg', 1, 1, '2026-02-06 19:15:23', '2026-02-06 19:15:23'),
(3, 'Vacaciones de Verano', 'Verano en Margarita', 'a', '/storage/uploads/migrated_1774621258_2eUCw.jpg', '/storage/uploads/migrated_1774621289_aFG53.jpg', 1, 1, '2026-02-06 19:15:23', '2026-02-06 19:15:23'),
(5, 'H2Otel Margarita\r\n', 'H2Otel / Playa el Agua\r\n', '', '/storage/uploads/migrated_1774621260_f2cLO.webp', '/storage/uploads/migrated_1774621295_xPgRL.jpg', 1, 1, '2026-02-06 20:29:10', '2026-02-06 20:29:10'),
(6, 'Conoce Bogotá', 'Boletos Aéreos a Bogotá - Colombia', 'Bogotá te espera para una gran aventura.\n\nConoce lugares increíbles como el Museo del Oro, la Catedral de Sal o la Montaña de Monserrate', '/storage/uploads/migrated_1774621262_qBIQ0.jpg', '/storage/uploads/migrated_1774621299_OQLZn.jpg', 1, 1, '2026-02-06 20:36:08', '2026-03-27 17:46:34'),
(7, 'Escápate a Cancún', 'Boletos Aéreos a Cancún - México', 'Un paraíso caribeño por explorar.\n\nVive la magia de Cancún, donde las aguas cristalinas y la diversión sin fin te esperan para una experiencia inolvidable.', '/storage/uploads/migrated_1774621268_rNOoK.jpg', '/storage/uploads/migrated_1774621302_R64lq.jpg', 1, 1, '2026-02-06 20:38:45', '2026-03-27 17:53:26'),
(8, 'Tibisay Hotel Boutique', 'Tibisay Margarita / Pampatar', '', '/storage/uploads/migrated_1774621272_EpMBc.webp', '/storage/uploads/migrated_1774621308_wgDVA.jpg', 1, 1, '2026-02-06 22:40:46', '2026-02-06 22:40:46'),
(9, 'Hesperia Playa El Agua', 'Descubre Margarita y Vive en Grande en Hesperia Playa El Agua', 'Ubicado en Playa el Agua, a 35 minutos del Aeropuerto Internaconal Santiago Mariño. Hesperia Playa El Agua es un complejo turístico que ofrece todo lo necesario para unas vacaciones inolvidables. Diversión, comodidad, variedad gastronómica y un inigualable servicio hacen de este hotel el lugar indicado para disfrutar de unos días en familia.\n\nCon un hermoso y agradable ambiente, el hotel dispone de una gran variedad de servicios para el máximo disfrute de sus huéspedes, entre ellos wifi gratis, piscinas, restaurantes, bares, canchas de tenis, cancha de usos múltiples, club de niños, anfiteatro al aire libre, sala de juegos, entre otros.\n\nCada rincón del hotel y su personal te esperan para garantizarte una experiencia única, descubre Margarita y Vive en Grande en Hesperia Playa El Agua.', '/storage/uploads/migrated_1774621276_agGxk.png', 'https://cotizador.plandeviaje.com.ve/src/images/hotel/47ce4fb02929fe05a7479e6bc2e9f8d9.jpg', 1, 1, '2026-02-06 22:46:35', '2026-03-10 22:50:19'),
(10, 'Semana Santa en Margarita', 'Semana Santa en Margarita', 'La Semana Santa se pasa mejor en Margarita.\n\nEl Hotel Margarita Village, cuenta con una privilegiada ubicación en la ciudad de Porlamar, ofrece un ambiente acogedor y un servicio de la mejor calidad para unos días de diversión en el Caribe.', '/storage/uploads/migrated_1774621279_HwWF1.jpg', '/storage/uploads/migrated_1774621324_nBifP.jpg', 1, 1, '2026-03-20 19:47:49', '2026-03-20 19:47:49');

-- --------------------------------------------------------

--
-- Table structure for table `room_types`
--

CREATE TABLE `room_types` (
  `room_type_ID` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_types`
--

INSERT INTO `room_types` (`room_type_ID`, `type`) VALUES
(1, 'Simple'),
(2, 'Doble'),
(3, 'Presidencial');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0zJeIcZz5d06IEy4nIuk2JpIyok13IKjnzfCqJNl', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSXhJUWFBUUdvUFBTNWowZzJpMFdvZ2RwRmN0M3ZwckxsSzVVU3ZubCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772202198),
('4RWP3UVenE9Zyj2XhPJhDgECmcVhf4LTMQ32TZKO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiazVnUTNuMlZkVFZMODFZTkltMXZWcUVlbWIzV0xmSFRGUElVREhibiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770403227),
('e7ZBMNwGwaebJ3bfXuLbUNPakqwtuVWnEYWjbkTu', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTIyVmx3N1JEdWRRbTdqWXdISlVYRFlzcWt6TlY2OFZiNndJTUJOTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770738815),
('gdk4d3VtTC1FRYpE3OLqzbrU85wL6oE8Cl3xbGmT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNkxYdkVSaVhOS1QyU3A2eHc1VUdQNXBBSTVROFg4d0t0Rmlxa1NPMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1772220754),
('ohSIa0xzLywVHYSwUSMM9djimMxmR8jYbhDkaA0M', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMlY3QUZySTl3MDlOcERGMWpDUXpqNVlWd3pNMGs0Szd0UGR6TTVGUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771594986),
('PwWswZGIDZ6xWIfhd45xcgxGG8h0Q66dvk9D9F8P', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNUI4VFdreTBTSG1XdHZCVGN4Vm1XZU1XMzdFUzYzOVZmZkNvS1U2SCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1772416545),
('s6M6s8cXAEQyFZBLD0S3TUZeUs2fdN4o7EL2Rf23', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0hxdXM5NWd3TFI4bVVDQkZEWW1KR21DNlRBeEZDRmFzSmc0aHRETCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771612478),
('XXWJjm5PSkszepv32voAmi4BSj9TNpUGa1GdNaMC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVZkS0l0aEpRaFg3TjZrdm55UHdUNkh0dFlDMGZXRlo0cUl6NG5jdyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhdGUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771594988);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'string',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `group`, `created_at`, `updated_at`) VALUES
(1, 'contact_phone', '582952644299', 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:48:51'),
(2, 'contact_email', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:48:51'),
(3, 'contact_address', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:48:51'),
(4, 'social_facebook', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:48:51'),
(5, 'social_instagram', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:48:51'),
(6, 'contact_whatsapp', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:48:51'),
(7, 'contact_hours_weekdays', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:13:26'),
(8, 'contact_hours_saturday', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:13:26'),
(9, 'contact_hours_sunday', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:13:26'),
(10, 'contact_map_frame', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:13:26'),
(11, 'contact_video_url', NULL, 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:13:26'),
(12, '_setting_group', 'informacion', 'text', 'general', '2026-03-27 19:13:26', '2026-03-27 19:13:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_ID` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_ID`, `name`, `role`, `email`, `google_id`, `avatar`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 1, 'admin@example.com', NULL, NULL, '2026-02-06 19:15:22', '$2y$12$Qy7e4UBRJCd1HM8rxdNZT.2khM/Y2A7PcPSEjq8FkzICEAH473T.u', 'ORKuXmRJo9', '2026-02-06 19:15:23', '2026-02-06 19:15:23'),
(4, 'Editor User', 2, 'editor@example.com', NULL, NULL, NULL, '$2y$12$6iZXQtH7eeXf4ES0Wqn9fOXW2DsXkwekW3BN6VG6o2mZkcOElOWUG', NULL, '2026-02-27 22:29:27', '2026-02-27 22:29:27'),
(5, 'Manager User', 3, 'manager@example.com', NULL, NULL, NULL, '$2y$12$bAYw2qNWXAu2Qsx0YaWYreTc.mIKpmhrN9y9iOWHHiZuGRQNSRoby', NULL, '2026-02-27 22:30:10', '2026-02-27 22:30:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accommodation`
--
ALTER TABLE `accommodation`
  ADD PRIMARY KEY (`accommodation_ID`),
  ADD KEY `accommodation_post_fk_foreign` (`post_FK`),
  ADD KEY `accommodation_board_type_fk_foreign` (`board_type_FK`);

--
-- Indexes for table `accommodation_room_type`
--
ALTER TABLE `accommodation_room_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accommodation_room_type_accommodation_id_foreign` (`accommodation_id`),
  ADD KEY `accommodation_room_type_room_type_id_foreign` (`room_type_id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`blog_category_ID`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`blog_post_ID`),
  ADD KEY `blog_posts_post_fk_foreign` (`post_FK`),
  ADD KEY `blog_posts_blog_category_fk_foreign` (`blog_category_FK`);

--
-- Indexes for table `blog_posts_tags`
--
ALTER TABLE `blog_posts_tags`
  ADD PRIMARY KEY (`blog_post_tag_ID`),
  ADD KEY `blog_posts_tags_blog_post_fk_foreign` (`blog_post_FK`),
  ADD KEY `blog_posts_tags_blog_tag_fk_foreign` (`blog_tag_FK`);

--
-- Indexes for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD PRIMARY KEY (`blog_tag_ID`);

--
-- Indexes for table `board_types`
--
ALTER TABLE `board_types`
  ADD PRIMARY KEY (`board_type_ID`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `consultants`
--
ALTER TABLE `consultants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_ID`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`flights_ID`),
  ADD KEY `flights_post_fk_foreign` (`post_FK`),
  ADD KEY `flights_country_fk_foreign` (`country_FK`);

--
-- Indexes for table `guest_types`
--
ALTER TABLE `guest_types`
  ADD PRIMARY KEY (`guest_type_ID`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_ID`),
  ADD KEY `images_post_fk_foreign` (`post_FK`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`inquiries_ID`),
  ADD KEY `inquiries_post_fk_foreign` (`post_FK`),
  ADD KEY `inquiries_guest_type_fk_foreign` (`guest_type_FK`),
  ADD KEY `inquiries_consultant_id_foreign` (`consultant_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`packages_ID`),
  ADD KEY `packages_post_fk_foreign` (`post_FK`),
  ADD KEY `packages_accommodation_fk_foreign` (`accommodation_FK`),
  ADD KEY `packages_guest_type_fk_foreign` (`guest_type_FK`),
  ADD KEY `packages_board_type_fk_foreign` (`board_type_FK`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_ID`),
  ADD KEY `posts_createdby_foreign` (`createdBy`),
  ADD KEY `posts_updatedby_foreign` (`updatedBy`);

--
-- Indexes for table `room_types`
--
ALTER TABLE `room_types`
  ADD PRIMARY KEY (`room_type_ID`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_ID`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accommodation`
--
ALTER TABLE `accommodation`
  MODIFY `accommodation_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `accommodation_room_type`
--
ALTER TABLE `accommodation_room_type`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `blog_category_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `blog_post_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_posts_tags`
--
ALTER TABLE `blog_posts_tags`
  MODIFY `blog_post_tag_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_tags`
--
ALTER TABLE `blog_tags`
  MODIFY `blog_tag_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `board_types`
--
ALTER TABLE `board_types`
  MODIFY `board_type_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `consultants`
--
ALTER TABLE `consultants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `country_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `flights_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `guest_types`
--
ALTER TABLE `guest_types`
  MODIFY `guest_type_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `image_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `inquiries_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `packages_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `room_types`
--
ALTER TABLE `room_types`
  MODIFY `room_type_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_ID` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accommodation`
--
ALTER TABLE `accommodation`
  ADD CONSTRAINT `accommodation_board_type_fk_foreign` FOREIGN KEY (`board_type_FK`) REFERENCES `board_types` (`board_type_ID`),
  ADD CONSTRAINT `accommodation_post_fk_foreign` FOREIGN KEY (`post_FK`) REFERENCES `posts` (`post_ID`) ON DELETE CASCADE;

--
-- Constraints for table `accommodation_room_type`
--
ALTER TABLE `accommodation_room_type`
  ADD CONSTRAINT `accommodation_room_type_accommodation_id_foreign` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodation` (`accommodation_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `accommodation_room_type_room_type_id_foreign` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_ID`) ON DELETE CASCADE;

--
-- Constraints for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD CONSTRAINT `blog_posts_blog_category_fk_foreign` FOREIGN KEY (`blog_category_FK`) REFERENCES `blog_categories` (`blog_category_ID`),
  ADD CONSTRAINT `blog_posts_post_fk_foreign` FOREIGN KEY (`post_FK`) REFERENCES `posts` (`post_ID`) ON DELETE CASCADE;

--
-- Constraints for table `blog_posts_tags`
--
ALTER TABLE `blog_posts_tags`
  ADD CONSTRAINT `blog_posts_tags_blog_post_fk_foreign` FOREIGN KEY (`blog_post_FK`) REFERENCES `blog_posts` (`blog_post_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_posts_tags_blog_tag_fk_foreign` FOREIGN KEY (`blog_tag_FK`) REFERENCES `blog_tags` (`blog_tag_ID`) ON DELETE CASCADE;

--
-- Constraints for table `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `flights_country_fk_foreign` FOREIGN KEY (`country_FK`) REFERENCES `countries` (`country_ID`),
  ADD CONSTRAINT `flights_post_fk_foreign` FOREIGN KEY (`post_FK`) REFERENCES `posts` (`post_ID`) ON DELETE CASCADE;

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_post_fk_foreign` FOREIGN KEY (`post_FK`) REFERENCES `posts` (`post_ID`) ON DELETE CASCADE;

--
-- Constraints for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD CONSTRAINT `inquiries_consultant_id_foreign` FOREIGN KEY (`consultant_id`) REFERENCES `consultants` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `inquiries_guest_type_fk_foreign` FOREIGN KEY (`guest_type_FK`) REFERENCES `guest_types` (`guest_type_ID`),
  ADD CONSTRAINT `inquiries_post_fk_foreign` FOREIGN KEY (`post_FK`) REFERENCES `posts` (`post_ID`) ON DELETE CASCADE;

--
-- Constraints for table `packages`
--
ALTER TABLE `packages`
  ADD CONSTRAINT `packages_accommodation_fk_foreign` FOREIGN KEY (`accommodation_FK`) REFERENCES `accommodation` (`accommodation_ID`),
  ADD CONSTRAINT `packages_board_type_fk_foreign` FOREIGN KEY (`board_type_FK`) REFERENCES `board_types` (`board_type_ID`),
  ADD CONSTRAINT `packages_guest_type_fk_foreign` FOREIGN KEY (`guest_type_FK`) REFERENCES `guest_types` (`guest_type_ID`),
  ADD CONSTRAINT `packages_post_fk_foreign` FOREIGN KEY (`post_FK`) REFERENCES `posts` (`post_ID`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`user_ID`),
  ADD CONSTRAINT `posts_updatedby_foreign` FOREIGN KEY (`updatedBy`) REFERENCES `users` (`user_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
