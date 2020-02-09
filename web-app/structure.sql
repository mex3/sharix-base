

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `structure`
--


--
-- Структура таблицы `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `hash` text DEFAULT NULL,
  `is_unavailable` tinyint(4) DEFAULT 0,
  `id_provider` int(11) DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL,
  `id_services` int(11) DEFAULT NULL,
  `id_google_calendar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `slug` varchar(256) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT NULL,
  `appointments` int(11) DEFAULT NULL,
  `customers` int(11) DEFAULT NULL,
  `services` int(11) DEFAULT NULL,
  `users` int(11) DEFAULT NULL,
  `system_settings` int(11) DEFAULT NULL,
  `user_settings` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------


--
-- Структура таблицы `services`
--

CREATE TABLE `ea_services` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(32) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `availabilities_type` varchar(32) DEFAULT 'flexible',
  `attendants_number` int(11) DEFAULT 1,
  `id_service_categories` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `service_categories`
--

CREATE TABLE `ea_service_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(512) DEFAULT NULL,
  `working_plan` text DEFAULT NULL,
  `notifications` tinyint(4) DEFAULT 0,
  `google_sync` tinyint(4) DEFAULT 0,
  `google_token` text DEFAULT NULL,
  `google_calendar` varchar(128) DEFAULT NULL,
  `sync_past_days` int(11) DEFAULT 5,
  `sync_future_days` int(11) DEFAULT 5,
  `calendar_view` varchar(32) DEFAULT 'default',
  `followers` int(100) NOT NULL,
  `userphoto` varchar(300) CHARACTER SET utf8mb4 NOT NULL,
  `user_cover_photo` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `school` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `work` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `work0` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `birthday` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `verify` int(11) NOT NULL,
  `website` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `bio` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `gender` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `login_attemipts` int(11) NOT NULL,
  `language` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `aSetup` int(11) NOT NULL,
  `online` int(100) NOT NULL,
  `first_name` varchar(256) CHARACTER SET utf8mb4 NOT NULL,
  `last_name` varchar(512) CHARACTER SET utf8mb4 NOT NULL,
  `email` varchar(512) CHARACTER SET utf8mb4 NOT NULL,
  `mobile_number` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `phone_number` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `address` varchar(256) CHARACTER SET utf8mb4 NOT NULL,
  `city` varchar(256) CHARACTER SET utf8mb4 NOT NULL,
  `country` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `zip_code` varchar(64) CHARACTER SET utf8mb4 NOT NULL,
  `notes` text NOT NULL,
  `id_roles` int(11) NOT NULL,
  `admin` varchar(50) CHARACTER SET utf8mb4 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `follow`
--

CREATE TABLE `follow` (
  `id` int(11) NOT NULL,
  `reader` int(11) NOT NULL,
  `read` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `notificationsc`
--

CREATE TABLE `notificationsc` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `for_id` int(11) NOT NULL,
  `notifyType_id` bigint(11) NOT NULL,
  `notifyType` varchar(100) NOT NULL,
  `seen` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------


--
-- Структура таблицы `supportbox`
--

CREATE TABLE `supportbox` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `for_id` int(11) NOT NULL,
  `r_type` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `subject` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `report` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `r_time` int(11) NOT NULL,
  `r_replay` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `r_replay_time` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

