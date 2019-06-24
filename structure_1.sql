-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 24 2019 г., 13:48
-- Версия сервера: 10.3.15-MariaDB
-- Версия PHP: 7.3.6

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

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `authorid` int(11) NOT NULL,
  `postid` int(11) NOT NULL,
  `edited` int(11) NOT NULL,
  `timeedited` varchar(100) NOT NULL,
  `time` int(11) NOT NULL,
  `content` varchar(10000) CHARACTER SET utf8mb4 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_appointments`
--

CREATE TABLE `ea_appointments` (
  `id` int(11) NOT NULL,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `hash` text DEFAULT NULL,
  `is_unavailable` tinyint(4) DEFAULT 0,
  `id_users_provider` int(11) DEFAULT NULL,
  `id_users_customer` int(11) DEFAULT NULL,
  `id_services` int(11) DEFAULT NULL,
  `id_google_calendar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_consents`
--

CREATE TABLE `ea_consents` (
  `id` int(11) NOT NULL,
  `created` datetime DEFAULT current_timestamp(),
  `modified` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(256) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `ip` varchar(256) DEFAULT NULL,
  `type` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_migrations`
--

CREATE TABLE `ea_migrations` (
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_roles`
--

CREATE TABLE `ea_roles` (
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
-- Структура таблицы `ea_secretaries_providers`
--

CREATE TABLE `ea_secretaries_providers` (
  `id_users_secretary` int(11) NOT NULL,
  `id_users_provider` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_services`
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
-- Структура таблицы `ea_services_providers`
--

CREATE TABLE `ea_services_providers` (
  `id_users` int(11) NOT NULL,
  `id_services` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_service_categories`
--

CREATE TABLE `ea_service_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_settings`
--

CREATE TABLE `ea_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(512) DEFAULT NULL,
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_users`
--

CREATE TABLE `ea_users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `last_name` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL,
  `email` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL,
  `Userphoto` varchar(300) CHARACTER SET utf8mb4 NOT NULL,
  `mobile_number` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `phone_number` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `address` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `city` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `country` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `zip_code` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `id_roles` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ea_user_settings`
--

CREATE TABLE `ea_user_settings` (
  `id_users` int(11) NOT NULL,
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
  `calendar_view` varchar(32) DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `follows`
--

CREATE TABLE `follows` (
  `id` int(11) NOT NULL,
  `reader` int(11) NOT NULL,
  `read` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `liker` int(11) NOT NULL,
  `post_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `message` varchar(1538) NOT NULL,
  `m_from` int(11) NOT NULL,
  `m_to` int(11) NOT NULL,
  `m_time` int(11) NOT NULL,
  `m_seen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `mynotepad`
--

CREATE TABLE `mynotepad` (
  `main_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `note_title` varchar(1000) NOT NULL,
  `note_content` varchar(1000) NOT NULL,
  `note_time` int(11) NOT NULL
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
-- Структура таблицы `r_star`
--

CREATE TABLE `r_star` (
  `id` int(11) NOT NULL,
  `minion` int(11) NOT NULL,
  `favorite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `saved`
--

CREATE TABLE `saved` (
  `main_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_saved_id` int(11) NOT NULL,
  `saved_time` int(11) NOT NULL
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

--
-- Структура таблицы `user_extended`
--

CREATE TABLE `user_extended` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
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
  `login_attempts` int(11) NOT NULL,
  `language` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `aSetup` int(11) NOT NULL,
  `online` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `wpost`
--

CREATE TABLE `wpost` (
  `post_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `post_img` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `post_time` int(11) NOT NULL,
  `post_content` mediumtext CHARACTER SET utf8mb4 NOT NULL,
  `p_title` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `p_likes` int(100) NOT NULL,
  `p_privacy` int(11) NOT NULL,
  `shared` varchar(1000) CHARACTER SET utf8mb4 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `authorid` (`authorid`),
  ADD KEY `postid` (`postid`);

--
-- Индексы таблицы `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_users_customer` (`id_users_customer`),
  ADD KEY `id_services` (`id_services`),
  ADD KEY `id_users_provider` (`id_users_provider`);

--
-- Индексы таблицы `ea_consents`
--
ALTER TABLE `ea_consents`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ea_roles`
--
ALTER TABLE `ea_roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD PRIMARY KEY (`id_users_secretary`,`id_users_provider`),
  ADD KEY `id_users_secretary` (`id_users_secretary`),
  ADD KEY `id_users_provider` (`id_users_provider`);

--
-- Индексы таблицы `ea_services`
--
ALTER TABLE `ea_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_categories` (`id_service_categories`);

--
-- Индексы таблицы `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD PRIMARY KEY (`id_users`,`id_services`),
  ADD KEY `id_services` (`id_services`);

--
-- Индексы таблицы `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ea_settings`
--
ALTER TABLE `ea_settings`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ea_users`
--
ALTER TABLE `ea_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_roles` (`id_roles`);

--
-- Индексы таблицы `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD PRIMARY KEY (`id_users`);

--
-- Индексы таблицы `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `reader` (`reader`),
  ADD KEY `read` (`read`);

--
-- Индексы таблицы `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `post_id` (`post_id`),
  ADD KEY `liker` (`liker`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `m_from` (`m_from`),
  ADD KEY `m_to` (`m_to`);

--
-- Индексы таблицы `mynotepad`
--
ALTER TABLE `mynotepad`
  ADD PRIMARY KEY (`main_id`) USING BTREE,
  ADD KEY `author_id` (`author_id`);

--
-- Индексы таблицы `notificationsc`
--
ALTER TABLE `notificationsc`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `from_id` (`from_id`),
  ADD KEY `for_id` (`for_id`);

--
-- Индексы таблицы `r_star`
--
ALTER TABLE `r_star`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `minion` (`minion`),
  ADD KEY `favorite` (`favorite`);

--
-- Индексы таблицы `saved`
--
ALTER TABLE `saved`
  ADD PRIMARY KEY (`main_id`) USING BTREE,
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_saved_id` (`user_saved_id`);

--
-- Индексы таблицы `supportbox`
--
ALTER TABLE `supportbox`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `from_id` (`from_id`),
  ADD KEY `for_id` (`for_id`);

--
-- Индексы таблицы `user_extended`
--
ALTER TABLE `user_extended`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `userid` (`userid`) USING BTREE;

--
-- Индексы таблицы `wpost`
--
ALTER TABLE `wpost`
  ADD PRIMARY KEY (`post_id`) USING BTREE,
  ADD KEY `author_id` (`author_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_appointments`
--
ALTER TABLE `ea_appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_consents`
--
ALTER TABLE `ea_consents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_roles`
--
ALTER TABLE `ea_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_services`
--
ALTER TABLE `ea_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_settings`
--
ALTER TABLE `ea_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ea_users`
--
ALTER TABLE `ea_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `follows`
--
ALTER TABLE `follows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `mynotepad`
--
ALTER TABLE `mynotepad`
  MODIFY `main_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `notificationsc`
--
ALTER TABLE `notificationsc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `r_star`
--
ALTER TABLE `r_star`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `saved`
--
ALTER TABLE `saved`
  MODIFY `main_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `user_extended`
--
ALTER TABLE `user_extended`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`postid`) REFERENCES `wpost` (`post_id`),
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`authorid`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD CONSTRAINT `appointments_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_users_customer` FOREIGN KEY (`id_users_customer`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD CONSTRAINT `secretaries_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `secretaries_users_secretary` FOREIGN KEY (`id_users_secretary`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ea_services`
--
ALTER TABLE `ea_services`
  ADD CONSTRAINT `services_service_categories` FOREIGN KEY (`id_service_categories`) REFERENCES `ea_service_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD CONSTRAINT `services_providers_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `services_providers_users_provider` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ea_users`
--
ALTER TABLE `ea_users`
  ADD CONSTRAINT `users_roles` FOREIGN KEY (`id_roles`) REFERENCES `ea_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD CONSTRAINT `user_settings_users` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`reader`) REFERENCES `ea_user_settings` (`id_users`),
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`read`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `wpost` (`post_id`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`liker`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`m_from`) REFERENCES `ea_user_settings` (`id_users`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`m_to`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `mynotepad`
--
ALTER TABLE `mynotepad`
  ADD CONSTRAINT `mynotepad_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `notificationsc`
--
ALTER TABLE `notificationsc`
  ADD CONSTRAINT `notificationsc_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `ea_user_settings` (`id_users`),
  ADD CONSTRAINT `notificationsc_ibfk_2` FOREIGN KEY (`for_id`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `r_star`
--
ALTER TABLE `r_star`
  ADD CONSTRAINT `r_star_ibfk_1` FOREIGN KEY (`minion`) REFERENCES `ea_user_settings` (`id_users`),
  ADD CONSTRAINT `r_star_ibfk_2` FOREIGN KEY (`favorite`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `saved`
--
ALTER TABLE `saved`
  ADD CONSTRAINT `saved_ibfk_1` FOREIGN KEY (`user_saved_id`) REFERENCES `ea_user_settings` (`id_users`),
  ADD CONSTRAINT `saved_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `wpost` (`post_id`);

--
-- Ограничения внешнего ключа таблицы `supportbox`
--
ALTER TABLE `supportbox`
  ADD CONSTRAINT `supportbox_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `ea_user_settings` (`id_users`),
  ADD CONSTRAINT `supportbox_ibfk_2` FOREIGN KEY (`for_id`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `user_extended`
--
ALTER TABLE `user_extended`
  ADD CONSTRAINT `user_extended_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `ea_user_settings` (`id_users`);

--
-- Ограничения внешнего ключа таблицы `wpost`
--
ALTER TABLE `wpost`
  ADD CONSTRAINT `wpost_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `ea_user_settings` (`id_users`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
