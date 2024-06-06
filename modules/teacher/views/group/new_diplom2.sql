-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 06 2024 г., 13:23
-- Версия сервера: 8.0.30
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `new_diplom2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `answer`
--

CREATE TABLE `answer` (
  `id` int NOT NULL,
  `title` text NOT NULL,
  `is_true` tinyint(1) NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `answer`
--

INSERT INTO `answer` (`id`, `title`, `is_true`, `question_id`) VALUES
(16, 'ответ правильный', 1, 16),
(17, 'ответ второй', 0, 16),
(18, 'ответ первый', 0, 17),
(19, 'ответ правильный', 1, 17),
(20, '1', 0, 18),
(21, 'прав', 1, 18),
(22, 'прав', 1, 19),
(23, '2', 0, 19),
(25, 'фыв', 1, 21),
(26, 'фыв', 1, 22);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_assignment`
--

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_item`
--

CREATE TABLE `auth_item` (
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` smallint NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `rule_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_item_child`
--

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `child` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_rule`
--

CREATE TABLE `auth_rule` (
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `deny`
--

CREATE TABLE `deny` (
  `id` int NOT NULL,
  `is_true` tinyint(1) NOT NULL,
  `group_test_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `group`
--

CREATE TABLE `group` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `group`
--

INSERT INTO `group` (`id`, `title`) VALUES
(1, 'iv123'),
(2, '228');

-- --------------------------------------------------------

--
-- Структура таблицы `group_test`
--

CREATE TABLE `group_test` (
  `id` int NOT NULL,
  `date` date DEFAULT NULL,
  `avg_points` float DEFAULT NULL,
  `val_5` int DEFAULT NULL,
  `val_4` int DEFAULT NULL,
  `val_3` int DEFAULT NULL,
  `fails` int DEFAULT NULL,
  `group_id` int NOT NULL,
  `test_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `group_test`
--

INSERT INTO `group_test` (`id`, `date`, `avg_points`, `val_5`, `val_4`, `val_3`, `fails`, `group_id`, `test_id`) VALUES
(38, NULL, 2, 7, NULL, 6, NULL, 1, 17),
(39, NULL, 4, 1, NULL, NULL, NULL, 1, 19),
(45, NULL, NULL, NULL, NULL, NULL, NULL, 2, 21),
(46, NULL, 4, 1, NULL, NULL, NULL, 1, 21),
(47, NULL, NULL, NULL, NULL, NULL, NULL, 1, 17),
(48, NULL, NULL, NULL, NULL, NULL, NULL, 1, 17),
(49, NULL, NULL, NULL, NULL, NULL, NULL, 1, 17);

-- --------------------------------------------------------

--
-- Структура таблицы `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1710234645),
('m140506_102106_rbac_init', 1710358066),
('m170907_052038_rbac_add_index_on_auth_assignment_user_id', 1710358066),
('m180523_151638_rbac_updates_indexes_without_prefix', 1710358066),
('m200409_110543_rbac_update_mssql_trigger', 1710358066);

-- --------------------------------------------------------

--
-- Структура таблицы `question`
--

CREATE TABLE `question` (
  `id` int NOT NULL,
  `text` text NOT NULL,
  `points_per_question` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `level_id` int NOT NULL,
  `test_id` int NOT NULL,
  `type_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `question`
--

INSERT INTO `question` (`id`, `text`, `points_per_question`, `image`, `level_id`, `test_id`, `type_id`) VALUES
(16, 'вопрос первый', 2, NULL, 2, 17, 1),
(17, 'вопрос второй', 2, NULL, 2, 17, 1),
(18, '1', 1, NULL, 1, 19, 1),
(19, '2', 3, NULL, 3, 19, 1),
(21, 'фыв', 2, NULL, 2, 21, 3),
(22, 'фыв', 2, NULL, 2, 21, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `question_level`
--

CREATE TABLE `question_level` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `question_level`
--

INSERT INTO `question_level` (`id`, `title`) VALUES
(1, 'Лёгкий'),
(2, 'Средний'),
(3, 'Сложный');

-- --------------------------------------------------------

--
-- Структура таблицы `question_type`
--

CREATE TABLE `question_type` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `question_type`
--

INSERT INTO `question_type` (`id`, `title`) VALUES
(1, 'Один правильный ответ'),
(2, 'Несколько правильных ответов'),
(3, 'Ввод ответа от студента');

-- --------------------------------------------------------

--
-- Структура таблицы `role`
--

CREATE TABLE `role` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `role`
--

INSERT INTO `role` (`id`, `title`) VALUES
(1, 'admin'),
(2, 'manager'),
(3, 'teacher'),
(4, 'student');

-- --------------------------------------------------------

--
-- Структура таблицы `student_answer`
--

CREATE TABLE `student_answer` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  `user_id` int NOT NULL,
  `answer_id` int NOT NULL,
  `answer_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cheked` tinyint(1) DEFAULT NULL,
  `is_true` tinyint(1) DEFAULT NULL,
  `attempt` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `student_answer`
--

INSERT INTO `student_answer` (`id`, `question_id`, `user_id`, `answer_id`, `answer_title`, `cheked`, `is_true`, `attempt`) VALUES
(569, 17, 77, 19, NULL, 1, 1, 0),
(570, 16, 77, 16, NULL, 1, 1, 0),
(571, 16, 77, 17, NULL, 1, 0, 0),
(572, 17, 77, 18, NULL, 1, 0, 0),
(573, 17, 77, 19, NULL, 1, 1, 1),
(574, 16, 77, 16, NULL, 1, 1, 1),
(575, 16, 77, 17, NULL, 1, 0, 2),
(576, 17, 77, 19, NULL, 1, 1, 2),
(577, 16, 77, 16, NULL, 1, 1, 1),
(578, 17, 77, 19, NULL, 1, 1, 1),
(579, 17, 77, 18, NULL, 1, 0, 3),
(580, 16, 77, 17, NULL, 1, 0, 3),
(581, 21, 77, 25, 'asdasdasd', 1, 1, 1),
(582, 22, 77, 26, 'asdasdasdasd', 1, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `student_test`
--

CREATE TABLE `student_test` (
  `id` int NOT NULL,
  `points` int NOT NULL,
  `mark` int NOT NULL,
  `test_id` int NOT NULL,
  `user_id` int NOT NULL,
  `group_test_id` int NOT NULL,
  `cheked` tinyint(1) NOT NULL,
  `date` date DEFAULT NULL,
  `attempt` int NOT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `student_test`
--

INSERT INTO `student_test` (`id`, `points`, `mark`, `test_id`, `user_id`, `group_test_id`, `cheked`, `date`, `attempt`, `ip`) VALUES
(82, 4, 5, 17, 77, 38, 1, '2024-04-28', 0, NULL),
(83, 0, 2, 17, 77, 38, 0, '2024-04-28', 0, NULL),
(84, 4, 5, 17, 77, 38, 1, '2024-04-28', 1, NULL),
(85, 2, 3, 17, 77, 38, 1, '2024-04-30', 2, NULL),
(86, 4, 5, 17, 77, 39, 1, '2024-05-07', 1, NULL),
(87, 0, 2, 17, 77, 38, 1, '2024-05-07', 3, NULL),
(88, 4, 5, 21, 77, 46, 1, '2024-05-09', 1, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `subject`
--

CREATE TABLE `subject` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `subject`
--

INSERT INTO `subject` (`id`, `title`) VALUES
(1, 'пришем код'),
(2, 'не пришем код');

-- --------------------------------------------------------

--
-- Структура таблицы `teacher_subject`
--

CREATE TABLE `teacher_subject` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `subject_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `teacher_subject`
--

INSERT INTO `teacher_subject` (`id`, `user_id`, `subject_id`) VALUES
(1, 68, 1),
(2, 68, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `test`
--

CREATE TABLE `test` (
  `id` int NOT NULL,
  `title` text NOT NULL,
  `question_count` int NOT NULL,
  `point_count` int DEFAULT NULL,
  `subject_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `test`
--

INSERT INTO `test` (`id`, `title`, `question_count`, `point_count`, `subject_id`, `is_active`) VALUES
(17, 'новый тест по писать код нада', 2, 4, 1, 0),
(18, 'новый тест по писать код нада', 2, 4, 1, 0),
(19, 'новая теста по не писать код', 2, 4, 2, 0),
(21, 'asd', 2, 4, 2, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `test_status`
--

CREATE TABLE `test_status` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `test_status`
--

INSERT INTO `test_status` (`id`, `title`) VALUES
(1, 'active'),
(2, 'not_active'),
(3, 'closed');

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `patronimyc` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` int NOT NULL,
  `auth_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `name`, `surname`, `patronimyc`, `login`, `password`, `email`, `phone`, `role_id`, `auth_key`) VALUES
(2, 'admin', 'admin', 'admin', 'admin', '$2y$13$OPlJC8YfaEg4KmDEQzIvH.cN0aRiJZh0MgmVQkB94bpDRyjBZDWDy', 'admin', 'admin', 1, 'qCRkB2qqOQz6IGyPYRnwkKy7m0jmpwOJ'),
(68, 'teacher', 'teacher', 'teacher', 'teacher', '$2y$13$Tq7pIwFSvU.JgAFj1I1.x.ETffLgNx44o/TH8./f50zVR1TciKHbq', 'teacher', 'teacher', 3, 'LwJUjcM9VhLjsEQvDuyMvot8nDN0J2XF'),
(77, 'student', 'student', 'student', 'student', '$2y$13$xceS3/d8uJpFbwBIGZwk1uSv0mwd3/neiZvy53fMvloNBiS004dHW', 'student', 'student', 4, '6AGxewilkapWVuCJ8sBrkknUA2mgp5QK'),
(358, 'zxc', 'zxc', 'zxc', 'I1B4ig', '9HoVqi', NULL, NULL, 4, '4q_Hxw84JuP6gBIChmVsApwbC9SaiypZ'),
(359, 'zxc', 'zxc', 'zxc', 'OdaCB_', 'gSUPDJ', NULL, NULL, 4, 'BdhAaL_LxEYFQOjos_3hGXLE1s2PH38Y'),
(360, 'zxc', 'zxc', 'zx', 'l8mbTN', '_kWgJ_', NULL, NULL, 4, 'ZDRX8ZlKzBKe9fzJVpl9BivB79G089mt'),
(361, 'zxc', 'zxc', 'zxc', 'sUoOzr', 'jrNvV7', NULL, NULL, 4, 'w2aB836Gk2RoquP_6ZmW5sU2Rk5FFU5Y'),
(362, 'zxc', 'zxc', 'zxc', 'rQo2_y', 'VdJ_Ri', NULL, NULL, 4, 'OTEAQ4XGB1wcpJXsFIv8fKDCnk2xev4X'),
(363, 'zxc', 'zxc', 'zx', 'RsqHKt', 'sNbdpX', NULL, NULL, 4, 'Mn8R2oykrpHJmg_WONExhtjmSombi7DA'),
(364, 'zxc', 'zxc', 'zxc', 'ZkAEY0', 'IrLMMT', NULL, NULL, 4, 'cOWo1cD4ziebblUxTmedSnrh6T7ZGK_B'),
(365, 'zxc', 'zxc', 'zxc', 'G9fsA9', 'MYXwxI', NULL, NULL, 4, 'aRQ1J71BczIUt4koOrxok3plmYSDBybu'),
(366, 'zxc', 'zxc', 'zx', 'KHrmQo', 'jzIKtE', NULL, NULL, 4, 'ywlWYPBCY9t8662NskOhA56Vis5D8H8h'),
(367, 'zxc', 'zxc', 'zxc', 'SyWzTQ', 'K9ecv-', NULL, NULL, 4, '01l_7A6kLCB9qs5B0jCKyneVD1D8G4OH'),
(368, 'zxc', 'zxc', 'zxc', 'KqVluu', 'dV7rH8', NULL, NULL, 4, 'HpaINebdPMU4O3VYtSWgbH9EfCWYd5oo'),
(369, 'zxc', 'zxc', 'zx', 'zEM46q', 'oslkE-', NULL, NULL, 4, '0sV6lcF2VjmKaaaFlb2aN-lS28Vf95R0'),
(370, 'zxc', 'zxc', 'zxc', 'VdcaSW', 'IztYTg', NULL, NULL, 4, '0z3LOpU-DhkpH4Ry6t7MGpIN7VOst-RK'),
(371, 'zxc', 'zxc', 'zxc', 'jz1si-', 'F8yD1W', NULL, NULL, 4, 'sJXQbgyj7VGVwbyPoNTxDF_-2tpQFcfW'),
(372, 'zxc', 'zxc', 'zx', '67tJOI', 'kwZ7dl', NULL, NULL, 4, '6I2bMbxoGZVIG4pyJcAcp-LdMWqj3NrC'),
(373, 'zxc', 'zxc', 'zxc', 'FL8dhu', 'NowBR5', NULL, NULL, 4, '8GOhQNpG5hx6I2bvpPZEqdA8znTd6jFn'),
(374, 'zxc', 'zxc', 'zxc', 'jICCuB', 'E9ctAf', NULL, NULL, 4, '7grCcdX0sG4oegQPRiL__8t1MQNK-xQz'),
(375, 'zxc', 'zxc', 'zx', 'oVWx42', 'QDApzE', NULL, NULL, 4, 'GFgIK0vnemYv9wzH34_P_YCmwE8llmr6'),
(376, 'zxc', 'zxc', 'zxc', '-RWqhZ', 'djE7cD', NULL, NULL, 4, 'Yewz038IT0d443bOD-6TOPRlQjHnqAfB'),
(377, 'zxc', 'zxc', 'zxc', 'x3o4bY', 'O-KVk2', NULL, NULL, 4, 'xFLHdNzojKux74-CG0HHIYJu-Cq69pMf'),
(378, 'zxc', 'zxc', 'zx', '8x7dll', 'bj23nH', NULL, NULL, 4, 'ptFEjRk3w4pto5F3t3S2wdoMAWC9l29W'),
(379, 'zxc', 'zxc', 'zxc', 'fRNy_i', 'zek2PK', NULL, NULL, 4, 'IKekS3uIN1Ra8WYOK7-hbu6N_whuOdsT'),
(380, 'zxc', 'zxc', 'zxc', 'yLyokz', 'siKK_1', NULL, NULL, 4, 'VqyIUfw4nVm9VwLBizwYxsTgrCDbZi0A'),
(381, 'zxc', 'zxc', 'zx', 'nPimil', 'PRBE8u', NULL, NULL, 4, 'PbPNs996ZHkGW6NjG_mJt7lncFEoIztr'),
(382, 'zxc', 'zxc', 'zxc', 'xfYgUo', 'XTkJpD', NULL, NULL, 4, 'RL6E5y8nOKuJ54hZV9tt1Jsc8jqLwkys'),
(383, 'zxc', 'zxc', 'zxc', 'PuCuWS', 'iMmOoC', NULL, NULL, 4, 'NIWLn00Iw_kky3rDMhlp850BrRcE_MTf'),
(384, 'zxc', 'zxc', 'zx', '8v1_8J', 'JXlVm-', NULL, NULL, 4, '7wvEkLW1ar_Czo0dcOsqUKJAHv7Q9Ju0'),
(385, 'zxc', 'zxc', 'zxc', 'VYLG-B', 'GtRTKr', NULL, NULL, 4, '19wYU-cfmzo9KqjbRnHznhYi8gmgOwfw'),
(386, 'zxc', 'zxc', 'zxc', 'H7Ev7_', 'yTS_EO', NULL, NULL, 4, 'kUOdvyAdx-bmqMofZeff-e53RyyW5pmI'),
(387, 'zxc', 'zxc', 'zx', 'sdD9ne', 'RJV5OY', NULL, NULL, 4, 'lk90oYIhoLXFQ46vDEj_k9SmJQgiZ9Ki'),
(388, 'zxc', 'zxc', 'zxc', 'nOPbvH', '9tgncd', NULL, NULL, 4, 'I3znCh0qrxjMoDs0U4P71BQkb0MJ76eO'),
(389, 'zxc', 'zxc', 'zxc', 'xMFl9p', 'BUAE_z', NULL, NULL, 4, 'so_0Mth1y2Fr9cETRz4mdu0Z-RPplLjt'),
(390, 'zxc', 'zxc', 'zx', 'Zr4UCA', 'T9WAh_', NULL, NULL, 4, '4dQTWCwJOsuXy_Cg0596YjtFpGvEJ1S6'),
(391, 'zxc', 'zxc', 'zxc', 'cQ3Liv', 'dFYuOH', NULL, NULL, 4, 'RNoJtH-oWoaQu_pYK4qjM-RBKE__Uw3k'),
(392, 'zxc', 'zxc', 'zxc', 'ZeF0m5', '7TveeN', NULL, NULL, 4, 'MnIn6RR5qznre3bZjpSFa7ffXEd8rqJh'),
(393, 'zxc', 'zxc', 'zx', 'OmuWQE', '9PJpD8', NULL, NULL, 4, 'sY6W65z2kgrpfQ-aJhqpWLoxXu2-ujBC'),
(394, 'zxc', 'zxc', 'zxc', 'Y1ZNa4', 'dvCKws', NULL, NULL, 4, 'h76VZGelhbPf7kShkE7ozk62XJveeRme'),
(395, 'zxc', 'zxc', 'zxc', 'eo0WTq', 'pHiTsy', NULL, NULL, 4, '--iQ1l4cR-kX6CeaGIIV3zdrf1FRF83h'),
(396, 'zxc', 'zxc', 'zx', 'MsZhnI', '5yeipg', NULL, NULL, 4, '9RRDf1rUPTLmCFPOAvyTElaY0ADq625A'),
(397, 'zxc', 'zxc', 'zxc', '4RzS8W', '9wofrS', NULL, NULL, 4, 'NUYnQb1qZlOsMRT-ALpp03FZVSbDogBx'),
(398, 'zxc', 'zxc', 'zxc', 'cmF4Zz', 'pBgutk', NULL, NULL, 4, 's7IXW7Kj_DegwFKiv8I72pkhU2zoRonZ'),
(399, 'zxc', 'zxc', 'zx', '7djxdw', 'JTOvcG', NULL, NULL, 4, '6HtHcoYba8SZW9DxENeWHMtN1g4hefqO'),
(400, 'zxc', 'zxc', 'zxc', 'Mw54Tm', 'oGjBno', NULL, NULL, 4, 'SQrdosU3cxv7Z1KJmsdZP7UhLGqhj6gR'),
(401, 'zxc', 'zxc', 'zxc', 'nAfWYS', 'j4Zqxw', NULL, NULL, 4, 'q0KyvecMtblCEOLZ82XiAWcEhhw6g0_j'),
(402, 'zxc', 'zxc', 'zx', 'trtoKS', '0OcnW_', NULL, NULL, 4, 'Pw4qptGq4k7ahQqtF0DwPSUkuEuWf6MC'),
(403, 'zxc', 'zxc', 'zxc', 'Xev6Sy', 'Wmhqpt', NULL, NULL, 4, 'Kgve6FHh4GcnzDdFDDJpCbUCkqZge3ti'),
(404, 'zxc', 'zxc', 'zxc', 'Rwddb7', 'GhynV-', NULL, NULL, 4, 'TahtBC9PSEx-uJdgpXHwjWubVRnFy4Gb'),
(405, 'zxc', 'zxc', 'zx', '8QjKjl', 'yd6O5X', NULL, NULL, 4, 'o9CmO4RxmNDQm4_GkjYZcpVqkOve8W6T'),
(406, 'zxc', 'zxc', 'zxc', 'DzwaoR', 'aPwZ1w', NULL, NULL, 4, '8pnT6c5AdqztOG86Er2g-INRx0hRHLKq'),
(407, 'zxc', 'zxc', 'zxc', 'dMCfuA', 'mhjlHe', NULL, NULL, 4, '80K45ae2BoH3zIU824piso5wWeSwUlHV'),
(408, 'zxc', 'zxc', 'zx', 'iGjcaS', 'mJpWXt', NULL, NULL, 4, 'RWUb2h0QhHn5gvAw1aXcveG_zzHbDg8m'),
(409, 'zxc', 'zxc', 'zxc', 'Mmg6UT', '4azEqT', NULL, NULL, 4, '-6B1LlDC52frfSEt_q8A3MlEhpnYbd_n'),
(410, 'zxc', 'zxc', 'zxc', 'AdM3GH', 'fhcjer', NULL, NULL, 4, 'GhfUxUKMBeqo6NQKtxpkRfgR41WVy20I'),
(411, 'zxc', 'zxc', 'zx', 'D6mYiH', 'HQdfKm', NULL, NULL, 4, 'TsTC5ae5exV_RpMd3OAxXz01XiuW5jUG'),
(412, 'zxc', 'zxc', 'zxc', 'fGSzen', '5YdKAr', NULL, NULL, 4, '1Cf9M0i9L0H2lfjL-2w5ocw8K1ZtKBzT'),
(413, 'zxc', 'zxc', 'zxc', '2Z0Vdv', 'Cxtl0O', NULL, NULL, 4, 'RZCxR-uiz0Uc3PsX3CPfj0C-L4i7ZySz'),
(414, 'zxc', 'zxc', 'zx', 'rJCM8s', 'C1X0In', NULL, NULL, 4, 'FZ20GB_rBUlmaW8WNvUGL_2Aip5Pf4UV'),
(415, 'zxc', 'zxc', 'zxc', 'ouhnFg', 'MIQeAw', NULL, NULL, 4, '0erM_hSxTtBXQaD6Xl2B_jsDx-e8ecTr'),
(416, 'zxc', 'zxc', 'zxc', 'owq3D1', 'UlWRT8', NULL, NULL, 4, 'mnXvBYB5CbO7F1P2XhbDnGBk_9mUgA90'),
(417, 'zxc', 'zxc', 'zx', 'FZpfzG', 'fPA25O', NULL, NULL, 4, 'GwHj7a94x_oGFVYXwVVAkmczK_-LiGli'),
(418, 'zxc', 'zxc', 'zxc', 'bO1Un8', 'ypDy6E', NULL, NULL, 4, 'DBhzrQEZgbY4fHais8M79bTz2fRJ-2PG'),
(419, 'zxc', 'zxc', 'zxc', 'yHHbyn', 'xKbd1P', NULL, NULL, 4, 'G6Q7qrRyg_3wbdfK-3dAGFwTZ-PhkaD8'),
(420, 'zxc', 'zxc', 'zx', 'DuoxvG', '4GupN6', NULL, NULL, 4, 'elVXfjGF-0TB9aHtZ9UjUESxYlBy27TR'),
(421, 'zxc', 'zxc', 'zxc', '1a50c9', 'H4fvze', NULL, NULL, 4, 'rT_u21p_WSAp8vUpV3St6XWUlxE10Dho'),
(422, 'zxc', 'zxc', 'zxc', 'oFPvFN', 'D4tEfT', NULL, NULL, 4, 'M_K27m6sUAK-dUqiAMcbdqaHI5WfF4YZ'),
(423, 'zxc', 'zxc', 'zx', 'BXa96g', 'x-WWxs', NULL, NULL, 4, '8hbx1bZgTme6NBY_EmOIkOZKWskTmge5'),
(424, 'zxc', 'zxc', 'zxc', 'nOq_n6', 'JESVhx', NULL, NULL, 4, '2l2xpVQ3sHSMP0StHVEz29yUK5-k1dYo'),
(425, 'zxc', 'zxc', 'zxc', 'TYvSGV', 'qmp1OZ', NULL, NULL, 4, '_UteHFYt_5cwRmFFnTY5fze-jQP4sRgp'),
(426, 'zxc', 'zxc', 'zx', '-6aQvv', 'fB2F2b', NULL, NULL, 4, '_cFe_l65EqwlzgIdeRmtKzqvpj2wj_XY'),
(427, 'zxc', 'zxc', 'zxc', 'hKEhm6', '8jc0oz', NULL, NULL, 4, '7n73kx20wZu6vJP4-VtH-ZwRxt0Ch5Td'),
(428, 'zxc', 'zxc', 'zxc', 'jg25d7', 'd6PvcK', NULL, NULL, 4, 'oI17WPcpUnBLmZULlPOS1mclEqrL37f0'),
(429, 'zxc', 'zxc', 'zx', '_GQiJK', 'S12tag', NULL, NULL, 4, '2s07o0QkLcKM8f7eubkPqTnQkyYxTxjR'),
(430, 'zxc', 'zxc', 'zxc', 'EdUBj3', '2FZ0D7', NULL, NULL, 4, '4q5kuzSQxUUVYy9BN86OUCJZX4Mx2wHl'),
(431, 'zxc', 'zxc', 'zxc', '-F93Qi', 'VNUTZP', NULL, NULL, 4, 'catSWP9LhzH0mV881YdbbJtDDMrARNHT'),
(432, 'zxc', 'zxc', 'zx', 'tb3GRG', '8sXSx9', NULL, NULL, 4, 'VUtWf15iqJC7fW133HxCWi5HzzfghOMa'),
(433, 'zxc', 'zxc', 'zxc', '_4Tfs_', 'uj3leP', NULL, NULL, 4, 'Kyt7wiPuvYcBJPxzAbZ2_JKS52Jr1sHe'),
(434, 'zxc', 'zxc', 'zxc', 'KZIDZg', 'tY1QoJ', NULL, NULL, 4, 'oFTp_w3K8gW3k0wo7Bw_vdcXCnSE3Pk_'),
(435, 'zxc', 'zxc', 'zx', 'Siaj9q', 'RrhMTc', NULL, NULL, 4, 'BOoL6q_keVIfdppbD1wiIFmV9Cqi2-dY'),
(436, 'zxc', 'zxc', 'zxc', 'NJwHKc', 'b8f1Fx', NULL, NULL, 4, '5xBkOzrSo50qWAeDGwiX8jK5za76COpQ'),
(437, 'zxc', 'zxc', 'zxc', '0RDray', 'JVSkRR', NULL, NULL, 4, 'B-DrMZvs6C7aBdOOBQXSZbmB2CwdCUap'),
(438, 'zxc', 'zxc', 'zx', 'RdfBkC', 'Iv6Qqq', NULL, NULL, 4, '1osytEEBNs3aHfcbGW80AK7vFZQ9KCU2'),
(439, 'zxc', 'zxc', 'zxc', 'ZXvScq', '--E-Yc', NULL, NULL, 4, 'qmmLlArwxupUGZacvpBnB-DmW9Jgalub'),
(440, 'zxc', 'zxc', 'zxc', 'kj5rUH', 'Gne-Jz', NULL, NULL, 4, 'wxj30nFflkoQnY-__fky0H8vm_8GLoBb'),
(441, 'zxc', 'zxc', 'zx', 'QKgUBa', 'DHbPke', NULL, NULL, 4, 'wSERCCvHo0dTT40-nKjxJCNklX915idm'),
(442, 'zxc', 'zxc', 'zxc', 'fWMral', 'YpSlPl', NULL, NULL, 4, 'kc8UQY75elWJd-MqJpALFCWMEfa8abuO'),
(443, 'zxc', 'zxc', 'zxc', '5kJReg', '1Y3g74', NULL, NULL, 4, 'J43_x1XTlJu4MvzamwTEZWHW38ATKcEX'),
(444, 'zxc', 'zxc', 'zx', 'vH9XFs', 'dBOixw', NULL, NULL, 4, 'mu_l9W8hsbnUIaYUCBnC42mW4HCfpCZV'),
(445, 'zxc', 'zxc', 'zxc', 'LXrigU', '6ROMDG', NULL, NULL, 4, '6F32k7gZ4JgWnw7MHo6xkyGTB1INxIgH'),
(446, 'zxc', 'zxc', 'zxc', '6PW7rm', 'hL2wXT', NULL, NULL, 4, 'GHcjBIm-TWRc-rglb0o6V2aPATHqGODW'),
(447, 'zxc', 'zxc', 'zx', 'hbM14L', 'amP6hB', NULL, NULL, 4, '_k3aCctkqQ3bUfW09Okz5w2S7xD3xzH3'),
(448, 'zxc', 'zxc', 'zxc', '4nINy_', 'boClk_', NULL, NULL, 4, 'B1U2TGyA1fBGw8JHPaAaMrwCvwTWCsOH'),
(449, 'zxc', 'zxc', 'zxc', 'wioBmS', 'DU3C_K', NULL, NULL, 4, 'ubGsMqCZ3kUBB4UaEZS5RmW5IoxTsxZ6'),
(450, 'zxc', 'zxc', 'zx', 'H-ZqdN', 'nhjLjY', NULL, NULL, 4, 'vqgtMYxM93XzzpEkoVtu2kvwP1DZoF6L'),
(451, 'zxc', 'zxc', 'zxc', '4JKh3H', 'yXPCRu', NULL, NULL, 4, 'lCQbfzcf5rhQHQNIazmr62NToyHwhxMa'),
(452, 'zxc', 'zxc', 'zxc', 'MGqOoG', 'DDAGDs', NULL, NULL, 4, 'fnDNAhZVbz_Fv1rqyCEgwq5nZIaz2HBc'),
(453, 'zxc', 'zxc', 'zx', 'q274b2', 'l9-uKH', NULL, NULL, 4, 'xkrEhNvBWcL7Pji0109fB5hHeFRInTNH'),
(454, 'zxc', 'zxc', 'zxc', 'w3Yemn', 'wrDOTD', NULL, NULL, 4, 'pLt4hbfcXtQ83CS2IEyflLvwaEnGAeDO'),
(455, 'zxc', 'zxc', 'zxc', '8y7nju', 'iLnMUd', NULL, NULL, 4, 'LlaI-0EyYwOMMYCWvW1heSSwu_tFD5ZN'),
(456, 'zxc', 'zxc', 'zx', '4CRcMC', 'HHfnEA', NULL, NULL, 4, '19fklYVYHPIK6hVXH09UyHuItMtxLh_e'),
(457, 'zxc', 'zxc', 'zxc', 'hfmOHx', 'NvhzHH', NULL, NULL, 4, 'awz5wbaBWPNoWf6nBZJ2RyvlEna3ndQk'),
(458, 'zxc', 'zxc', 'zxc', 'WppjKn', 'ZpWPP0', NULL, NULL, 4, 'gJMuwLIZGDBOr08WXrzmlZIQgpowB04C'),
(459, 'zxc', 'zxc', 'zx', 'tUjE4A', 'BOUDcb', NULL, NULL, 4, 'oKDCgFk1aIU_0QZMv3GoSoLRxuKGK2I4'),
(460, 'zxc', 'zxc', 'zxc', 'qYOAa8', 'xY8LBs', NULL, NULL, 4, '7bctU3QHgsJOdzb_y0GnpwT7uBiAMSxg'),
(461, 'zxc', 'zxc', 'zxc', 'r1p-MT', 'lFnDYc', NULL, NULL, 4, 'lZ8UyPibIubpw1PkxZHEu2VY_irZj1AB'),
(462, 'zxc', 'zxc', 'zx', 'wtPRzo', '1DiTq5', NULL, NULL, 4, 'rXSBVzQ7NIBr8pcVi_FbmfUFRtV3Npk5'),
(463, 'zxc', 'zxc', 'zxc', 'ueOLj2', '9GT-nL', NULL, NULL, 4, 'IQedeGMslxdqnv8SJWoGbieAra3lHIA8'),
(464, 'zxc', 'zxc', 'zxc', 'JLWTA4', 'xN0Mxm', NULL, NULL, 4, '4rDIOOUDT-p87H-6zW5_kJjxtZVgn-Xj'),
(465, 'zxc', 'zxc', 'zx', '8BuXyM', 'aHjf-o', NULL, NULL, 4, 'QqJN_xzgbfsV3741NsmZOxd3DIm5fjOn'),
(466, 'zxc', 'zxc', 'zxc', 'AOH60l', 's0jrYf', NULL, NULL, 4, '70rHf879JdCMtWumc9W6AH_3-_Pr8To0'),
(467, 'zxc', 'zxc', 'zxc', 'SV1HS9', 'BPDJ1R', NULL, NULL, 4, 'z7dQpuj__oJOhY5rtiTXPInbUu-JIbPW'),
(468, 'zxc', 'zxc', 'zx', 'hTRRQh', 'facKZz', NULL, NULL, 4, 'SmylvcG-DL_M0FM5KIWKhPvG-fNugj5y'),
(469, 'zxc', 'zxc', 'zxc', 'io1t5I', 'vAd24M', NULL, NULL, 4, '4Y69wnO4sH1-UNt9Cln3kVbrVQQxqiQV'),
(470, 'zxc', 'zxc', 'zxc', '1kvPSV', '5EYi9N', NULL, NULL, 4, 'dWlmDKRpmpeRFqYT5ilxDwgWIW3IzrzQ'),
(471, 'zxc', 'zxc', 'zx', 'efFuVZ', 'Iev1Us', NULL, NULL, 4, 'o7eLvkmzfjvKsIm1IV_FZ1DdSR78OB7n'),
(472, 'zxc', 'zxc', 'zxc', 'Q9FBSw', 'PGPP8G', NULL, NULL, 4, 'lyVANA6OE84HQyCcuE8Ec-cH0SqAFLey'),
(473, 'zxc', 'zxc', 'zxc', 'lO_rGL', 'ouIpVg', NULL, NULL, 4, 'QXlgBL6ILmPCUKHe01pMt_-v1SHJYIy2'),
(474, 'zxc', 'zxc', 'zx', '0nHZ5I', 'cFvaMH', NULL, NULL, 4, 'y6L-x_0BruZ7RwknYaHN8xTNpfHDhcbD'),
(475, 'zxc', 'zxc', 'zxc', 'lpgq6n', 'sr0sB6', NULL, NULL, 4, 'RqdZD3BU4_eOFeCUHAdSXU0KKRn6_Ldu'),
(476, 'zxc', 'zxc', 'zxc', '-ATpy5', 'vO6nDh', NULL, NULL, 4, 'shpDZ5xgFAszMyKTuAXyKoeIG33RvHDg'),
(477, 'zxc', 'zxc', 'zx', 'm9ncU1', 'hEr_-G', NULL, NULL, 4, '5gb0OiNnYfTicnJvB8XhJYzSBeo6244F'),
(478, 'zxc', 'zxc', 'zxc', 'gMo_GM', 'RP97jC', NULL, NULL, 4, 'fBNaeAZ6fzwj67QzGjJAFe2BtqNuasbh'),
(479, 'zxc', 'zxc', 'zxc', 'rBQI18', 'fgzZ4N', NULL, NULL, 4, 'nieq6WYijxAzIxO7jRJv8RUGCzcOAtk_'),
(480, 'zxc', 'zxc', 'zx', 'ZmmH1D', '_-6XGx', NULL, NULL, 4, 'y_0gMJb5VKyAvg4aor04lwPd4FUsM6EH'),
(481, 'zxc', 'zxc', 'zxc', '3fGv_D', 'wOmphv', NULL, NULL, 4, '3sI2BTvLToExgRj96nwljLgJFjLhCwkd'),
(482, 'zxc', 'zxc', 'zxc', 'QOP0GU', '4XS2MQ', NULL, NULL, 4, 'evhQYdb-uwr-LjWqIzODHBPFL0ZbYbkk'),
(483, 'zxc', 'zxc', 'zx', 'igFQ-6', 'AGKzBU', NULL, NULL, 4, 'XEHzZIK5PVZqXoUTC9I6CIuO1Sa8xMiW'),
(484, 'zxc', 'zxc', 'zxc', 'dq0P8S', 'Rr7VJs', NULL, NULL, 4, '37jOadDohu7ne17vJumd0oQ1hjqeSqhr'),
(485, 'zxc', 'zxc', 'zxc', 'TLEuEA', 'GddXVu', NULL, NULL, 4, 'TyYl2x8lC3p4467SqQ8JEiUWdQgYlBzU'),
(486, 'zxc', 'zxc', 'zx', 'do-tHZ', '8s5dN6', NULL, NULL, 4, 'TtuYijOn8ZuWAqHpwYEu1uTMDm9Yjheb'),
(487, 'zxc', 'zxc', 'zxc', 'A3Hnso', 'ylHGRY', NULL, NULL, 4, 'WuUqjBfgdqXXGBmqiwc4FmOFgS0EZf9-'),
(488, 'zxc', 'zxc', 'zxc', 'W0UTlG', 'VgRwIN', NULL, NULL, 4, 'C9jf5gAoqopy71PhmReqR1Dk0ZOJI4Ds'),
(489, 'zxc', 'zxc', 'zx', 'mNScrX', '1xIFMl', NULL, NULL, 4, 'a4qcfJUbF5zzNPdrHEsqzRF0Eiey1I5v'),
(490, 'zxcc', 'zxc', 'zxc', 'HDaJJd', '8pE8xH', NULL, NULL, 4, '50Vxk9zMaGwR1GCy6P-Sivais5Zps8xe'),
(491, 'zxcc', 'zxc', 'zxc', 'mnLMwr', '_50EOO', NULL, NULL, 4, 'gDAlVdlsuMvbEpEFpb9MzOica-XQJbfv'),
(492, 'zxcc', 'zxc', 'zx', 'PSRdB9', 'lejorb', NULL, NULL, 4, 'HuWNX4vmkvoT5YxLMrMdquC7SQA4qQ1Y'),
(493, 'zxcc', 'zxc', 'zxc', 'aPmLPs', '_u9cOV', NULL, NULL, 4, 'q7PGWWmLcOsVG85QcJ4eUaJmw_2GhJhy'),
(494, 'zxcc', 'zxc', 'zxc', '2R5lyF', 'ef3hvN', NULL, NULL, 4, 'P-UxL7uqfbxdz-I87QfMtQ9pCKHosdX4'),
(495, 'zxcc', 'zxc', 'zx', 'lzN-YI', 'mo6ynw', NULL, NULL, 4, 'KROoAGR6XEVzFNw5Mp_n87wck3okMzvQ'),
(496, 'zxcc', 'zxc', 'zxc', 'uom-Qq', 'Y8zFwo', NULL, NULL, 4, 'oecAUL97dXaAFVOeLBjWwmlYvks1KtW5'),
(497, 'zxcc', 'zxc', 'zxc', 'pMLjz0', 'IzJLcI', NULL, NULL, 4, 'SWuY4pHwCJdLGIFFY--Sf3EgYOCXN2YG'),
(498, 'zxcc', 'zxc', 'zx', '9x7_Qg', '30pwHl', NULL, NULL, 4, 'Y8cGL5MoMsJ_mOgZBOZilAKibeujkx7L'),
(499, 'zxcc', 'zxc', 'zxc', 'RSUxYC', 'WcNT1b', NULL, NULL, 4, 'SmEDGtVxOLqG212nqN9gy87v8TqcgTsN'),
(500, 'zxcc', 'zxc', 'zxc', '6I0Owu', 'keYUn1', NULL, NULL, 4, '-4zyq9JRoHjnmrF_sM2DytdIMbK-BBTV'),
(501, 'zxcc', 'zxc', 'zx', 'ReI23g', 'gcsNdY', NULL, NULL, 4, 'xMj30bjCleIO03HVlPQmtlSPSdTjgrlA'),
(502, 'zxcc', 'zxc', 'zxc', 'iadUX8', 'iNswmU', NULL, NULL, 4, 'wSgzpzW7XC935qMSDkTcopH-0rf6TGHx'),
(503, 'zxcc', 'zxc', 'zxc', 'zDnH1Y', 'taggX3', NULL, NULL, 4, '37wqBPwPS6p844PoKzvNPP7jYq1d20li'),
(504, 'zxcc', 'zxc', 'zx', 'KTQSD_', 'B4RdEm', NULL, NULL, 4, 'TWSK3XLFbmRxLUxj5o8SwP4kqJTtRPg-'),
(505, 'zxcc', 'zxc', 'zxc', 'B9C2oe', 'VBJq2D', NULL, NULL, 4, 'exaV4mmhDOIqW_bMXoGEykKKQ-B55B1m'),
(506, 'zxcc', 'zxc', 'zxc', 'z-IFIA', '8fRCBK', NULL, NULL, 4, 'R52kyHeDLVMv7TrqTs-y5CdFKpXLvWpI'),
(507, 'zxcc', 'zxc', 'zx', 'UkABD6', '_BcXhk', NULL, NULL, 4, 'Ho__N-kVIO370a0n1D9bwHrUFAv-l5jJ'),
(508, 'zxcc', 'zxc', 'zxc', 'kcQO97', 'V4nKyM', NULL, NULL, 4, 'uKEysZ4ZRGjbUrM-A5KlbWUdFc-isNAG'),
(509, 'zxcc', 'zxc', 'zxc', 'KRaG7U', 'iF21AW', NULL, NULL, 4, '6yNj2z1fnGPILE3Nicl5VG4GqNuS_QLx'),
(510, 'zxcc', 'zxc', 'zx', 'ya3K7H', 'Cpj5qG', NULL, NULL, 4, 'RV2xFvH1swBVC00hrdaaSL7OXfunCSL1'),
(511, 'zxcc', 'zxc', 'zxc', 'uAQutU', 'PhXPTj', NULL, NULL, 4, 'P87nmWmQ1C_b7ERpMk4Cwa-3YIKrTB7F'),
(512, 'zxcc', 'zxc', 'zxc', '3Ps9-1', 'ZNw57Y', NULL, NULL, 4, 'L8j97-y5aIG-7LYrmvjMZoufeAR9LHZ0'),
(513, 'zxcc', 'zxc', 'zx', 'zOy9bJ', 'w3QfbY', NULL, NULL, 4, 'PYPvLSXMVb2E9uE0e7VCyHUeRNUJrDG4'),
(514, 'zxcc', 'zxc', 'zxc', 'EWo0xt', 'qKOApr', NULL, NULL, 4, 'ykUNy-Zd-ALdV2LZDJ2JdJFZ_MN9rlRZ'),
(515, 'zxcc', 'zxc', 'zxc', 'WbkEZD', 'dGzk4o', NULL, NULL, 4, 'wyiiRQcu3b_5cqmo_owKRjdrB0ej_5Kj'),
(516, 'zxcc', 'zxc', 'zx', '4wctyE', 'hyPMaU', NULL, NULL, 4, 'TQHY8pNz6G2fi51NWAUWrUDUHi-UY8H3'),
(517, 'zxcc', 'zxc', 'zxc', 'lsMvQ0', 'IUjU-n', NULL, NULL, 4, 'RVT--dbJF5Ic3Ij4cdrDvNhhGdKC-2WF'),
(518, 'zxcc', 'zxc', 'zxc', 'tpV-W5', 'IV7FYZ', NULL, NULL, 4, 'r8Oyz5sWnhUzfFZnGBglwCH_h1pB9iyJ'),
(519, 'zxcc', 'zxc', 'zx', 'E1pdmC', 'pO6WXe', NULL, NULL, 4, 'SM_xAKz3C1KKhdMw8ExhAyD5ZjbuqE9G'),
(520, 'zxcc', 'zxc', 'zxc', 'qRB9-H', 'KurWsc', NULL, NULL, 4, 'tPMLcg4pRa3BoPe9_O4rAucJmVsre13k'),
(521, 'zxcc', 'zxc', 'zxc', 'GSCXFv', 'iFgmsV', NULL, NULL, 4, 'NH8XuFvBGbQCqiNT7Deamzgj3rGfUoG2'),
(522, 'zxcc', 'zxc', 'zx', 'iTiCLo', '2eEuqv', NULL, NULL, 4, 'aCBJaB2CkL2wija4zfDERiUhqmRevG-j'),
(523, 'zxcc', 'zxc', 'zxc', 'XdhmE8', 'fBxmZG', NULL, NULL, 4, 'BfJ3GEovvvmXKFfsEnCKDujOnWFufuN5'),
(524, 'zxcc', 'zxc', 'zxc', 'lWGVU-', '5sWUHq', NULL, NULL, 4, '5CpqpMB0UFprzb4WmA3HfjypjN2y6_9G'),
(525, 'zxcc', 'zxc', 'zx', 'OeH1H6', 'VJ4GSA', NULL, NULL, 4, 'mixbviFweIDPDsaQa68J0shRcOWlmGVw'),
(526, 'zxcc', 'zxc', 'zxc', 'u0oKFy', 'qirct5', NULL, NULL, 4, '2aoc6sent4zYVRMxx36eMAVOefChZjeS'),
(527, 'zxcc', 'zxc', 'zxc', 'zM82ec', 'JMv1sj', NULL, NULL, 4, 'XvQvWcdlG-K2ziJr3idyg13Qlqc0VTqK'),
(528, 'zxcc', 'zxc', 'zx', 'VodptR', 'ANzdgQ', NULL, NULL, 4, '_KymWCKK9p7OmBxLygONBHOlLVi4YnrZ'),
(529, 'zxcc', 'zxc', 'zxc', 'VR_yYi', 'HAKVKT', NULL, NULL, 4, 'hWUbliPkFz8hqJr-0bxFVi53hJIfO2V7'),
(530, 'zxcc', 'zxc', 'zxc', 'FBjwgA', 'mzGOr1', NULL, NULL, 4, 'hllYSZ_DHEyYOanxjHS9L92V0p2lzJwc'),
(531, 'zxcc', 'zxc', 'zx', 'GqrxBo', '6cpm1E', NULL, NULL, 4, 'RNzmWxg65rnonSRSHuyQbjLxXnNiiSF8'),
(532, 'zxcc', 'zxc', 'zxc', 'Hrh4Cm', 'Gf55p_', NULL, NULL, 4, 'NnDu9XLKilg0c2c4kxbC5ry7TakmCGyY'),
(533, 'zxcc', 'zxc', 'zxc', '5WiwGf', 'HKmwPz', NULL, NULL, 4, 'SiJJQj0ABrzi10TkJdoKUUE97PMeG4Dz'),
(534, 'zxcc', 'zxc', 'zx', 'giK9j2', 'pdJoed', NULL, NULL, 4, '_kW6JLOKldqafSwJYTkLYDjZ-D8gmhiY'),
(535, 'zxcc', 'zxc', 'zxc', '_7ojBI', 'DAZ4iI', NULL, NULL, 4, 'eFQdV2DlUnWng7D_moixkqh1L_eRryAm'),
(536, 'zxcc', 'zxc', 'zxc', 'tChqpV', 'c9L20m', NULL, NULL, 4, 'rpw4NmWs9SzsQc_NCd3TZbTr_efiB1vo'),
(537, 'zxcc', 'zxc', 'zx', '3eY-Ym', 'pqTqxj', NULL, NULL, 4, '1R0u--4CfPNraw-h9Z3Nt9nZv81O65kN'),
(538, 'zxcca', 'zxc', 'zxc', '4IlM3h', 'gV_xKK', NULL, NULL, 4, 'JfqhpEWxYUWzsjEVehGlv5EyRDE-CRxP'),
(539, 'zxcca', 'zxc', 'zxc', 'Y3fkkJ', 'h11mUl', NULL, NULL, 4, 'UXn5HsdX0adXnhpFBKVwe4yRPcMCkQDx'),
(540, 'zxcc', 'zxc', 'zx', 'a9igtb', 'WHjpbj', NULL, NULL, 4, 'bh7mTZbtVGzM6uL7mZtADrLtul-TstQ6'),
(541, 'zx', 'zxc', 'zxc', 'w9xvJm', 'f0je-t', NULL, NULL, 4, 'rw_Z53mALJPbDHLPQsMLUcsZBFaRdE8i'),
(542, 'zx', 'zxc', 'zxc', 'nYB4Po', 'uMT0zs', NULL, NULL, 4, 'tZlDkR99zZGihTBvGtr1_S4LMCc_fLzB'),
(543, 'zx', 'zxc', 'zx', 'fqNRUk', '8RewF8', NULL, NULL, 4, 'HXt94wUivZrHXK4URWzKe62Cr1zAqfpj'),
(544, 'zxasd', 'zxcd', 'zvxc', 'H8dGXr', '92Npld', NULL, NULL, 4, 'qLfS7MYviCSRThUOuuLgukLkWQrvSC6p'),
(545, 'zxasd', 'zxdc', 'zxcasd', 'kVdUJB', '7HXQgw', NULL, NULL, 4, '4kzA_omh8XNuLz8i-pylkVOgeG93gFBq'),
(546, 'zxasd', 'zxdc', 'zxc', 'lB3HxC', 'A3Xtie', NULL, NULL, 4, 'BmA9_kdV1J6_-lK_06VkR4F7AI1xGSFJ'),
(547, 'zxasd', 'zxcd', 'zvxc', 'AnNDmM', 'RpYdtp', NULL, NULL, 4, 'Jmp-Nk4WNl9WhmqRAxGYnUgHH8uRoupB'),
(548, 'zxasd', 'zxdc', 'zxcasd', 'clEQa5', 'ULkFtZ', NULL, NULL, 4, 'bk_l4amQ_JKTRf4Ry8Nz3h9kpRNfw31a'),
(549, 'zxasd', 'zxdc', 'zxc', 'WqnOfH', 'u54f9N', NULL, NULL, 4, '83BItjr3NFDEmeDck98p9WyJzK3_knVh'),
(550, 'zxasd', 'zxcd', 'zvxc', 'HvLwBr', 'FOoeHh', NULL, NULL, 4, 'd_U3R5bmOefXJ0DAQeq2P4hVdqRybGj1'),
(551, 'zxasd', 'zxdc', 'zxcasd', '_-7sRq', 'uzYfNf', NULL, NULL, 4, 'Oop_f5IbV3ioA5sw-RbguDG5bF03gmgS'),
(552, 'zxasd', 'zxdc', 'zxc', 'mwB-2N', '4k6VIs', NULL, NULL, 4, '0CDoSShM-b2dWjrfUH36_aCfLrQRnL8d'),
(553, 'zxasd', 'zxcd', 'zvxc', 'HARUYQ', 'FGmRsU', NULL, NULL, 4, 'vzR8xD3WixEtrkKGOdsKmCZdukiHivxS'),
(554, 'zxasd', 'zxdc', 'zxcasd', 'ixCCc8', '5XtIfm', NULL, NULL, 4, '9-NDg4Lq4WWIFimTRuqsvSWxFaGb0DWT'),
(555, 'zxasd', 'zxdc', 'zxc', 'neHDkg', 'T4KL31', NULL, NULL, 4, 'VGz_EQAA0mereq2Tip0JBSROajmVksLg'),
(556, 'zxasd', 'zxcd', 'zvxc', 'FDUlf7', '8sLimW', NULL, NULL, 4, 'IhW-MuZzygCb79Ng3a48n1BYn1HM5P_l'),
(557, 'zxasd', 'zxdc', 'zxcasd', 'QvVjqD', 'sqTjX5', NULL, NULL, 4, 'YKoq1f2P_Sc5ZARfskQ7UC3DHiqo2A_9'),
(558, 'zxasd', 'zxdc', 'zxc', '_El4UJ', '33w4oV', NULL, NULL, 4, 'Uf7cPKRxMJ-y0JD0CqfdvZGaVAPSXUiJ'),
(559, 'zxasd', 'zxcd', 'zvxc', 'XS_dkP', 'as07fz', NULL, NULL, 4, 'MIa8L52GKkiI-atYTNq8a_9IyfAtpa-C'),
(560, 'zxasd', 'zxdc', 'zxcasd', 'F-zUKG', 'b1Hfin', NULL, NULL, 4, 'kZriIEHghiyJccVlE1cgD56Y_A7H8RwA'),
(561, 'zxasd', 'zxdc', 'zxc', 'sTfrZR', 'IML211', NULL, NULL, 4, 'd22ppqhhH_15nYOJqgz_JU43xh7ocmaM'),
(562, 'zxasd', 'zxcd', 'zvxc', 'sx0vMG', '1Atn5W', NULL, NULL, 4, 'eyiRbefKc_TgNLavJzv9LtQdLdlyGG7a'),
(563, 'zxasd', 'zxdc', 'zxcasd', 'ynM-am', '02EWAr', NULL, NULL, 4, 'f54gGoVMOC4x68bDIJjCkaEcCRaJZ3D5'),
(564, 'zxasd', 'zxdc', 'zxc', 'BPVHg2', '-3sPwV', NULL, NULL, 4, 'Wmcjc_wZPQm0zccnipIOMIzMCIW2bwFl'),
(565, 'zxasd', 'zxcd', 'zvxc', 'Fc_Bti', 'G6eb1l', NULL, NULL, 4, 'b1NCvglqL8QSErBCLAp98usb-3yVRQ2k'),
(566, 'zxasd', 'zxdc', 'zxcasd', 'OJEBUU', 'Xk6C0-', NULL, NULL, 4, 'msnT35zpcCvM3qrGHNQuD3dpQFmMoBsg'),
(567, 'zxasd', 'zxdc', 'zxc', 'UHN8U3', 'p5oU4q', NULL, NULL, 4, 'bO3UQiUg0EO6WxVZghQFrHz1v9ZU_CE5'),
(568, 'zxasd', 'zxcd', 'zvxc', 'Z7aPBc', '0xstV_', NULL, NULL, 4, 'LF3fEIx-JmHES0RoM6i5h6wRxMlTvv3o'),
(569, 'zxasd', 'zxdc', 'zxcasd', 'IdQYNx', '_v11IC', NULL, NULL, 4, '4IbXWbaqB6vaD120yJ1JgDe9yanTIG25'),
(570, 'zxasd', 'zxdc', 'zxc', 'pgK0zm', 'UTKQRD', NULL, NULL, 4, 'E2n2DlXDZ3MbgwuKAHtv4YYiwBAgmE5f'),
(571, 'zxasd', 'zxcd', 'zvxc', 'BGcfdX', '-XbPFH', NULL, NULL, 4, '3VoNqX0LLarapwoAx5-I8DPFP7C6EI7w'),
(572, 'zxasd', 'zxdc', 'zxcasd', 'LIvw9L', 'v8xLPI', NULL, NULL, 4, 'UqIF9m0rVtJzOYlEoeMJ8IAxh5XrsV_u'),
(573, 'zxasd', 'zxdc', 'zxc', 'CqYxim', 'KViH8g', NULL, NULL, 4, 'BW5FVSCqo8dxeehUKVuSUvohZZP3seu8'),
(574, 'zxasd', 'zxcd', 'zvxc', 'UtI_yK', 'JDGrEZ', NULL, NULL, 4, 'RdLhJy8FngF1owPg3BTxLt-mwdpgeAcX'),
(575, 'zxasd', 'zxdc', 'zxcasd', 'z2Srbb', 'l_-TFE', NULL, NULL, 4, 'BlR6Mzgaw73HAPI25c8l_0czWrDvqEqS'),
(576, 'zxasd', 'zxdc', 'zxc', '4fBLUo', 'bMb1_f', NULL, NULL, 4, 'WU_J1GqChcZIs_QDLpmoE94a2f3-3wRz'),
(577, 'zxasd', 'zxcd', 'zvxc', 'GBjKH5', 'l0xdf-', NULL, NULL, 4, 'tgmOrEOUuaYhQhW3rL9Rg66NzM4-V8Nt'),
(578, 'zxasd', 'zxdc', 'zxcasd', 'pdmNSN', 'RaRogN', NULL, NULL, 4, 'If0vmSHw-04lUaXuHteuzBncSQdhB4Yk'),
(579, 'zxasd', 'zxdc', 'zxc', 'mgEBB_', '5WLqCC', NULL, NULL, 4, 'c0AloLL9bLArQmzwa_ty9Zlze2bvDnbW'),
(580, 'zxasd', 'zxcd', 'zvxc', 'PIOSRy', 'UZtf44', NULL, NULL, 4, 'ZETMZCDlXudyXq5yywnHr1UkojMB5CkF'),
(581, 'zxasd', 'zxdc', 'zxcasd', '1p-5V3', 'ysZtiw', NULL, NULL, 4, 'SfNevWIGdyRnhTS2KFEgy0SQf_ncipNX'),
(582, 'zxasd', 'zxdc', 'zxc', 'Yp4ME7', 'l5orT2', NULL, NULL, 4, 'eYnhhIdFXrt-4ESt8Jm1QrS80gA_h5X2'),
(583, 'zxasd', 'zxcd', 'zvxc', 'P8-xyg', 'bZDZJp', NULL, NULL, 4, '1N7EjqiI0CY8iTpSAMTA8T9Um-2L1yO2'),
(584, 'zxasd', 'zxdc', 'zxcasd', 'wAFeI4', 'O987Zf', NULL, NULL, 4, '-_bboT-3HBJsKP85D84pFClYrWdAfxE7'),
(585, 'zxasd', 'zxdc', 'zxc', 'tNJkNv', 'PT0Ip6', NULL, NULL, 4, 'zIZi-8VskxNGo9xQ35DBKoFXv51o6KxK'),
(586, 'zxasd', 'zxcd', 'zvxc', 'YpL0sw', 'RveLwS', NULL, NULL, 4, '8ktLCOcOHqa89u0oJKhudj483ZnJUFYW'),
(587, 'zxasd', 'zxdc', 'zxcasd', 'lf4nbG', 'ivwgEe', NULL, NULL, 4, '7D5PuGnzMKvRsNqzgHW3Cawy5pNfOupZ'),
(588, 'zxasd', 'zxdc', 'zxc', 'uoDtLt', 'BHzft1', NULL, NULL, 4, 'T0a-TGanewCiTxchS57vud8u-kzy3KM3'),
(589, 'zxasd', 'zxcd', 'zvxc', 'ZSmwmb', 'WfhT2z', NULL, NULL, 4, 'm3CqdhaX2pz5vnplEVTBvulZkpM-MLs_'),
(590, 'zxasd', 'zxdc', 'zxcasd', 'vMr_jz', 'FdS5CJ', NULL, NULL, 4, '4GIFguY_yBiwQmwIpA4kzYcOxxqMWr7s'),
(591, 'zxasd', 'zxdc', 'zxc', 'BCFHlK', 'X2Vj6K', NULL, NULL, 4, 'ohvTx8xdlds5JEegUGggrk2mkciPEptI'),
(592, 'zxasd', 'zxcd', 'zvxc', 'E2wDrK', 'WALF0J', NULL, NULL, 4, 'Vk6OFbl5ypHe-99J4lXB-6PnxWM8Yu_6'),
(593, 'zxasd', 'zxdc', 'zxcasd', 'JvSWl0', 'CljscN', NULL, NULL, 4, 'MhWJVYQJIxAOmvZgbXZWWhL39KcNqnn_'),
(594, 'zxasd', 'zxdc', 'zxc', 'Qo-TIM', '94DC84', NULL, NULL, 4, 'xlPF5A6I0y9ka9MURSMRlV_wf8OTn7aB'),
(595, 'zxasd', 'zxcd', 'zvxc', 'ev8avS', 'fA0_ly', NULL, NULL, 4, 'm1rRlO9aeuXnU9INWu08dah5d064cSDg'),
(596, 'zxasd', 'zxdc', 'zxcasd', 'MMw3XH', 'c1Dsaw', NULL, NULL, 4, 'jHMFfuFcIErBryQrw-VO7_DrDhYnPaX1'),
(597, 'zxasd', 'zxdc', 'zxc', 'K116sA', 'naqZXw', NULL, NULL, 4, 'Q_ZGZuYW8YQMo2IpS5FLyHdLARXcWyos'),
(598, 'zxasd', 'zxcd', 'zvxc', 'hX38Ns', 'FUcTZZ', NULL, NULL, 4, 'mQGWvbl-nw3V-E7plj4mcuYyhRkm86up'),
(599, 'zxasd', 'zxdc', 'zxcasd', '4hDe3Z', '8O-x-q', NULL, NULL, 4, 'EzqWlQEFyov7OXPPkb6FbtCinmoi7wV0'),
(600, 'zxasd', 'zxdc', 'zxc', '71PQ_-', 'KqEFQ5', NULL, NULL, 4, 'MNsKGQpTA5Lzx7RDn0JjcwPshrqRuVc7'),
(601, 'zxasd', 'zxcd', 'zvxc', '3cqWet', 'WCfq6x', NULL, NULL, 4, 'i1NszVHSe4AQ3c5hpvVHzYTarTDzQaIv'),
(602, 'zxasd', 'zxdc', 'zxcasd', 'I1yCux', 'IVxoVc', NULL, NULL, 4, '-3EguUF0NMawuCTtpUI7B42RQ86Q4w6o'),
(603, 'zxasd', 'zxdc', 'zxc', 'K-bAja', 'o5V7MB', NULL, NULL, 4, 'wjkrdOIOSbRO4Fmx7newZjJa4cuIixnN'),
(604, 'zd', 'zxcd', 'zvxc', 'ribFhS', 'fyi6bM', NULL, NULL, 4, 'JjihNxzPyGJqPB_3ytMJtDsjT-YBRLXV'),
(605, 'zx', 'zxdc', 'zxcasd', 'tf5iwv', '-G2uFt', NULL, NULL, 4, 'X5WVMmfZyZ-cVupZ0PHmrk-TRScLnbh0'),
(606, 'zxasd', 'zxdc', 'zxc', 'wUrYFY', 'TSMP9z', NULL, NULL, 4, '9aLq6QJ3rjoDW6TXFp71qRiJXL9bXL1o'),
(607, 'zd', 'zxcd', 'zvxc', 'W_QbBZ', 'O1OI44', NULL, NULL, 4, 'wD9RVAYQz_8G8cTocncg4sVW0a12jjDE'),
(608, 'zx', 'zxdc', 'zxcasd', 'kv3nT2', 'LpQscX', NULL, NULL, 4, '7VkJitXR3-Pd0aOI7sCU5QYe5dOvsIaZ'),
(609, 'zxasd', 'zxdc', 'zxc', 'B4ZaPA', 'efgtPF', NULL, NULL, 4, 'RRr_MNcff4dPo_5SxQVPQk7VaX08kxbD'),
(610, 'zd', 'zxcd', 'zvxc', '93NB8c', 'WEybUc', NULL, NULL, 4, 'jgj3lC_mD0TDi05f9jiNSJ4NmkXw2jk7'),
(611, 'zx', 'zxdc', 'zxcasd', 'ocrKDc', 'uZZqCL', NULL, NULL, 4, 'jaMQhP13gUNIPGfWlcAgJVdNAKw9vIdD'),
(612, 'zxasd', 'zxdc', 'zxc', '3j_DVE', 'LWe0yD', NULL, NULL, 4, 'WOu-FzZRgZZSVO699yPGEfraJbi3tKXA'),
(613, 'zd', 'zxcd', 'zvxc', 'XyOkk3', 'R9CkE3', NULL, NULL, 4, 'jBnRDXbC8lp65U8Xbo4UgmQnh5PyO_q1'),
(614, 'zx', 'zxdc', 'zxcasd', 'iHlspe', '0HEM3M', NULL, NULL, 4, 'yRhXWvcXFcZtC74FC0p_u2lec2RkjlZr'),
(615, 'zxasd', 'zxdc', 'zxc', 'l5qi4B', 'Kb_wQJ', NULL, NULL, 4, 'Y1PuarDRLffazOVozqNcEIlA4n1KwdR4'),
(616, 'zd', 'zxcd', 'zvxc', 'skNw9F', 'etfScZ', NULL, NULL, 4, 'au6G9tqQLhPVNCWW1tjGHKUx7zWQiYIt'),
(617, 'zx', 'zxdc', 'zxcasd', 'NqIHa_', 'd4rDPs', NULL, NULL, 4, 'SRa3MdBsM8neHbO0sv93S8ZFOoKzLUeN'),
(618, 'zxasd', 'zxdc', 'zx', '_DyzgL', 'XYiSPB', NULL, NULL, 4, 'hr7-1QBaeABeBbUOt0gfnGY1XUvGr6S6'),
(619, 'zd', 'zxcd', 'zvxc', '_fHka6', 'Y8pOFW', NULL, NULL, 4, 'IRJI-Dwvf0HMm964dCpjWxJY2sQn5Xit'),
(620, 'zx', 'zxdc', 'zxcasd', 'pZuUd1', 'Cuoy1B', NULL, NULL, 4, 'G9Qj_2jbkgrwAP3UY55ssK0IP3ka5sDi'),
(621, 'zxasd', 'zxdc', 'zx', '26r2y1', 'CAibet', NULL, NULL, 4, 'bO12hJfrCzE3LAMJ3RJaSftidAPiNyGx'),
(622, 'zd', 'zxcd', 'zvxc', 'osfdM7', 'blqKmU', NULL, NULL, 4, 'rkjvgvpsSUdxgHakraiYWkQTS-J1badS'),
(623, 'zx', 'zxdc', 'zxcasd', 'ya4Tcw', 'Axo1yL', NULL, NULL, 4, 'rAnbTlWu9cXGOgHLxY-905XY2NBEqpXk'),
(624, 'zxasd', 'zxdc', 'zx', 'Kq60io', 'kdSfnu', NULL, NULL, 4, 'CjZ3by1uuVanmUDFDOjq-m90zVHyxSHz'),
(625, 'zd', 'zxcd', 'zvxc', 'Karz4A', 'B8jw5W', NULL, NULL, 4, 'ojIChAjgw3ZM88wHlHnnjlrykEz6rKd0'),
(626, 'zx', 'zxdc', 'zxcasd', 'ZHdzEI', 't4I4Y4', NULL, NULL, 4, 'M6B999jx9NFAZLShqCkaySnqPg9l4LOE'),
(627, 'zxasd', 'zxdc', 'z', 'B4oMcx', 'XwTFIJ', NULL, NULL, 4, 'rsNjwkcSnVMpCZJTnOPwgAkyQ4rih9Hz'),
(628, 'zd', 'zxcd', 'zvxc', 'wgdqjf', '9MWuje', NULL, NULL, 4, 'Kh1nbdxyKckvjzscmgVuYhXJpFF-ZVWV'),
(629, 'zx', 'zxdc', 'zxcasd', 'cQGW_b', 'Ft1Fzh', NULL, NULL, 4, 'j_CKcU2r5auwIhJsDKVAoZkhFta6tNtn'),
(630, 'zxasd', 'zxdc', 'z', 'o6yMLE', 'qwVlgV', NULL, NULL, 4, '5QtHsSFVN8bFgPedW12P2HDmWXIUM6ID'),
(631, 'zd', 'zxcd', 'zvxc', 'zZT31I', 'X2_gxN', NULL, NULL, 4, '-VeKuEpWESne4BgZ6Sbw7xPWOPP1oUdd'),
(632, 'zx', 'zxdc', 'zxcas', '7Yb-5i', 'v3CgK9', NULL, NULL, 4, 'ZI1qMyxbPqjct5_Uo7d3Q2sEx-m8ca79'),
(633, 'zxasd', 'zxdc', 'z', 'GTTTer', '7ojjAR', NULL, NULL, 4, 'CTSUpRH2rQRh6YRQplDnOtsh_tWEew8S'),
(634, 'zd', 'zxcd', 'zvxc', 'FRFeZh', '6xj69_', NULL, NULL, 4, 'LSp3GYBbRkdBwgqxrHVkc5ihGYu0mzcE'),
(635, 'zx', 'zxdc', 'zxcas', '32oGHz', 'cZBxi1', NULL, NULL, 4, 'vHiiBWUAuL-hgj6DyRsEs7ZsTZHXFiDW'),
(636, 'zxasd', 'zxdc', 'z', 'H878_6', 'swyY8m', NULL, NULL, 4, 'dxCIpP1JCbC3tAXGo7Z9T-waghUE66ZX'),
(637, 'zd', 'zxcd', 'zvxc', 'KXSORH', 'smKBwq', NULL, NULL, 4, 'Z7lXalRzrCy-mjUQ5aZmvr3BixpEtQOQ'),
(638, 'zx', 'zxdc', 'zxcas', '9DNUhw', 'aoQZnc', NULL, NULL, 4, 'MOjs2h0re7yZfgcbh_4ueHYMRWiN6nDy'),
(639, 'zxasd', 'zxdc', 'zx', 'H6ZHMQ', 'uqnfC0', NULL, NULL, 4, 'GrGFkdmQqf19xpzPfj1gYndhAS3bo5J4'),
(640, 'zd', 'zxcd', 'zvxc', '19DkiQ', 'TnC2L9', NULL, NULL, 4, 'U2zOXxr9Eiz-R4-tjP-N1fUkj-JaehUN'),
(641, 'zx', 'zxdc', 'zx', 'zKFnUk', 'IPobd7', NULL, NULL, 4, 'k-mNs_UGQ0lhIcFgbv-LRYIYlryhNkN1'),
(642, 'zxasd', 'zxdc', 'zx', 'E9dr3o', 'txx6VU', NULL, NULL, 4, 'mlnzIrxNEEmZ3tm1nuAMCXRD0M8P4Ri3'),
(643, 'd', 'd', 'd', 'L-JNHr', '$2y$13$CBcw1Rdt9zc93hUCEiDq2uM4j75cWoSvr4WOgmbZTxLFJQthMOswi', NULL, NULL, 4, 'gisTg1RnfgszUR430fAUqSxcsOs-N3oW'),
(644, 'zd', 'zxcd', 'zvxc', 'zL0Jq4', '_bSbIR', NULL, NULL, 4, 'D7ZVWUYhgDcMDYg37BJXFWnkEbvee4qd'),
(645, 'zx', 'zxdc', 'zx', 'rsADx7', 'kriR5n', NULL, NULL, 4, 'B0u0U-alVZRdNEWw_dUNYjM4Ib85KwrQ'),
(646, 'zxasd', 'zxdc', 'zx', 'B7vZAe', 'd7Zux_', NULL, NULL, 4, '-E0rfpP3MSLOb0WT-UFdwmgIpXqV2V2x'),
(647, 'zd', 'zxcd', 'zvxc', '1oTCll', 'k8qDL1', NULL, NULL, 4, 'XzYayQss_H-6P0oN5kUMFOAFiM_yZS5h'),
(648, 'zx', 'zxdc', 'zx', 'MCgrSL', '__KIyu', NULL, NULL, 4, 's7podRV4T-qZwjUsD6BLH7r07M6jhjgL'),
(649, 'zxasd', 'zxdc', 'zx', 'iox8t3', 'Swp2vr', NULL, NULL, 4, 'QpfT_g_VS8ds27o0f2PATHpe2n1GSq2D'),
(650, 'zd', 'zxcd', 'zvxc', 'LOBSQ1', 'aUJesF', NULL, NULL, 4, 'TgYbYEi3OVqJg_kPdvymcLZuSwc9eEy0'),
(651, 'zx', 'zxdc', 'zx', '9S1jmR', '69Ro4A', NULL, NULL, 4, 'G6JSVyZQquRGwqF0g5l4ToUOu7Pbc6r_'),
(652, 'zxasd', 'zxdc', 'zxs', 'lHX33J', 'iX2Z7M', NULL, NULL, 4, 'vcmDCsIuinK-d5AsaREiUclJNhvdP9fd'),
(653, 'zd', 'zxcd', 'zvxc', '2xDOGO', 'RoieZ_', NULL, NULL, 4, '2DnO09awKua0Rl_-WJkXqdegjEm0nonu'),
(654, 'zx', 'zxdc', 'zx', 'Qvnr7g', '_r0CJD', NULL, NULL, 4, 'IDXoEKUmrvDXPH2qE3or9GW6jU6ZsJI_'),
(655, 'zxasd', 'zxdc', 'zxs', '1DE-gb', 'MByZ8r', NULL, NULL, 4, 'kuPyADe79BXagjdoXRwToJs_yWxFiddb'),
(656, 'zd', 'zxcd', 'zvxc', '2Lz9e5', 'PQKq0r', NULL, NULL, 4, 'i749vImyJoKC0Y1QzGZbzlPI6TJL2APH'),
(657, 'zx', 'zxdc', 'zx', 'GWu2L3', '2UKr1P', NULL, NULL, 4, '5XF4dL3Ds0VCO8EQ-TZB9eT1guUXGDUe'),
(658, 'zxasd', 'zxdc', 'zxs', 'xcJavd', 'Vr98Fh', NULL, NULL, 4, 'jNrYYGYnBZrWIuuaDuL0UpSCUpYH1rzY'),
(659, 'zd', 'zxcd', 'zvxc', 'gxbQ8n', 'D-k-OZ', NULL, NULL, 4, 'fLxSBKzMH1OYQ4kPUfTWEtfOOUWe0rSL'),
(660, 'zx', 'zxdc', 'zx', '7MRhiy', 'oB7hxw', NULL, NULL, 4, '1nMeeQwAmHmivPeVAEIVZB-IUMhrODvT'),
(661, 'zxasd', 'zxdc', 'zxs', 'YNfLFu', '-9H5uW', NULL, NULL, 4, 'O5SMOBzUefnTpd5InnXPC5UdCd-0ziJz'),
(662, 'zd', 'zxcd', 'zvxc', 'tGTVR8', 'lbN6yV', NULL, NULL, 4, 'IMhvmG0t5TcWLka4s01_fQczghaeFMgo'),
(663, 'zx', 'zxdc', 'zx', 'SZuw8H', 'SS7WHN', NULL, NULL, 4, '74vcLptOce8i-lINyAC2ifcmaDQ6gYMu'),
(664, 'zxasd', 'zxdc', 'zxs', 'cgm0E9', '0NNO-q', NULL, NULL, 4, '1GtvOJNMYf_dS4YTwZq-N0uvytyfi4ag'),
(665, 'zd', 'zxcd', 'zvxc', 'ejoVZ_', 'RUsAj_', NULL, NULL, 4, '94QANOTCfuBj3Ta0XI6qNB21M4H54GlK'),
(666, 'zx', 'zxdc', 'zx', '9Fh4rZ', 'iP1uhn', NULL, NULL, 4, 'iqmrXbYNqPrg67SK9SadgmFjr6QjIk9T'),
(667, 'zxasd', 'zxdc', 'zxsa', 'PwC_Eu', 'SJ9YLv', NULL, NULL, 4, 'tI08IzVvWEGPscOxPcsdWcu4rVdZiMle'),
(668, 'zd', 'zxcd', 'zvxc', 'FQi-ou', '66BWod', NULL, NULL, 4, 'gU9p_D0mk0sFFAb8etwh3NHiAJM99f1j'),
(669, 'zx', 'zxdc', 'zxd', 'pX2sgc', 'zGRWpg', NULL, NULL, 4, 'EVoeeR27WIDZYZqPI5j6gopje1MpRPZI'),
(670, 'zxasd', 'zxdc', 'zxsa', 'd8T4SP', 'fUwA8w', NULL, NULL, 4, 'r42GIkKstLeShd663sOg0nT2EWJdh22W'),
(671, 'zd', 'zxcd', 'zvxc', 'mgtQ7m', 'QQF3lP', NULL, NULL, 3, 'OInlJ53xXYUNjoy9dE1UQWr8ewoxRWWu'),
(672, 'zx', 'zxdc', 'zxd', 'zGALfP', 'J6AlLY', NULL, NULL, 3, 'jVdLKWCruFSc_-mF79q6hxZcUDp3EVMB'),
(673, 'zxasd', 'zxdc', 'zxsa', 'A82rJH', 'jk8KXv', NULL, NULL, 3, 'SMFjWyo621kqfmYLSHc9S_FEcUFuRK83'),
(674, 'zd', 'zxcd', 'zvxc', '4kAvTx', '$2y$13$ihfeZ/X36rO0xQbPIAtB3uMMrMHrKL3O1jajpyzLk/plmqUhDd6L2', NULL, NULL, 3, 'DQ57vazL-gCoRdqTDNYX_vD3CfqZsm-8'),
(675, 'zx', 'zxdc', 'zxd', 'cgbZle', '$2y$13$yL4zv0eMtpPcMjcNwivri.U.tOhbTEjVvRB1xaGi0/kwQ1j6Gab26', NULL, NULL, 3, 'NZ6lpnpUMjtHj1lO-hdMPBaxGOH63MJk'),
(676, 'zxasd', 'zxdc', 'zxsa', 'GtXRyp', '$2y$13$tJdShBY1q8ffEmlCkx5kQOukTCH3Jw.fatZ9.BuIOc026knLs7Heq', NULL, NULL, 3, '6fC62jzK0AnQRHJD_kToIqOxHMVv0Iko'),
(677, 'zd', 'zxcd', 'zvxc', 'Iwb4dj', '$2y$13$GwBm9KYRqygkqF.UY69xduHMHtaHpZXwdZvT.hbZL/dwVQ9YMuQCe', NULL, NULL, 3, 'W1hUVOjQtrSbTqxZQH5ASkBB_XJB9mk7'),
(678, 'zx', 'zxdc', 'zxd', 'SHGbsU', '$2y$13$SwUnPrzgKfj948KikrK45OuMnZ2nayJoNCoaVdscxC7Pq2QQXrzga', NULL, NULL, 3, 'x-g6SaTvFm7ioISNM_5Uxi3XQSZnJJq_'),
(679, 'zxasd', 'zxdc', 'zxsa', 'Stpeuv', '$2y$13$0Evr6LMqQLVHFoD.fmeBE.e2Cj2LvMy2U7G/XdD8PGFnt74ivsOXi', NULL, NULL, 3, 'XS02zSYympVJZdQcnNCRspJNWsLOM4tC'),
(680, 'zd', 'zxcd', 'zvxc', 'bL05k1', '$2y$13$DUQyFvfavodA1RU8.R8JJ.TobXd9ndUVc/k6q8CAwyvs7OReMdy.i', NULL, NULL, 3, 'xLMV5T0prDUiINibnxyKKqEFWmm8e8yt'),
(681, 'zx', 'zxdc', 'zxd', 'eMEzfU', '$2y$13$E2CiQqXDFm0UFuP7pAmOweKNa5L.7eDAoIIdlUOefE/xqTkXDpS92', NULL, NULL, 3, 'gVc1ZZzgTI9qq3jK8OzGAuZgjmeBID2_'),
(682, 'zxasd', 'zxdc', 'zxsa', 'dx1--9', '$2y$13$HWVaIcG/DwlynpREiAP7iuo2xlXinV8Eu0azX1D0wkL.10z/Db82m', NULL, NULL, 3, '_8k3BwHzQSgogBiZtt8h0Q9hqcAkdmhC'),
(683, 'asd', 'asd', 'asd', '6R6fwP', '$2y$13$7bRRcWx54I0u3GtFQZQuMuJ5V7dAqMIQruGfWWilqtrKNykkRSDra', NULL, NULL, 4, 'RQ5OTvK0CbNOlGxMiU7jpcvvL6oxgOm3'),
(684, 'asd', 'asd', 'asd', 'cz4DhN', '$2y$13$i3oKsuQt6.vlB9hV6zAqpuSinv1f6HIxQyXyQ1SJzYAzXJ61Kzx.a', NULL, NULL, 4, '1iHwFMXT51XQWLk0PwNPWFTgHPtjQvVy'),
(685, 'asd', 'asd', 'asd', '4CKbU0', '$2y$13$KM7.pW.ibQz.kKgmpD8TbOuttp.Lt92lOdfjtdS5RPlgPalsrwMAu', NULL, NULL, 4, '3e1XcgIDpT0X1rDJqfWHfMxCT1HmUSZe'),
(686, 'zd', 'zxcd', 'zvxc', 'f1IzMc', '4stucd', NULL, NULL, 4, 'ClNTzZMYrCWNgGgWGeumxTNahjLRfrpe'),
(687, 'zx', 'zxdc', 'zxd', 'onQJb8', 'ekjb0J', NULL, NULL, 4, 'Frx6fO41Z_so4FJ5JMD3NqDK8kN9cmsk'),
(688, 'zxasd', 'zxdc', 'zxsa', 'idLgNl', 'Zcmn4f', NULL, NULL, 4, 'ouLbIonHhqhXoG463Rl3-L5uzFMi2Xz7'),
(689, 'asdc', 'asdc', 'asdc', 'KKSC-h', '$2y$13$Jw7WAUkE2bDJk87LEzrf8eDTbm0pLFMiQCItfMiTAWoOS4HU6ZNIy', NULL, NULL, 4, 'tZe1HJ6NAt0YxPN7gMEFQZgV5eNYt-z_'),
(690, 'zd', 'zxcd', 'zvxc', 'DF_DXB', '4AhfK6', NULL, NULL, 4, '0umSTlrK3V3m_pb_uzm6YLZTr6YgV3Qx'),
(691, 'zx', 'zxdc', 'zxd', 'WN0opk', 'TJnF8B', NULL, NULL, 4, 'naQWIzMBAoc9O8Fnn3sv7wSO9Jem2U35'),
(692, 'zxasd', 'zxdc', 'zxsa', 'dD4Uj6', 'DoqQhs', NULL, NULL, 4, '9fRYjN23lqb-GLV8F2526ZWd9q0WzNY7'),
(693, 'zd', 'zxcd', 'zvxc', 'vO3Ir_', 'UhKA7x', NULL, NULL, 4, '0iozdKhDvh-QVLM0_d_kj-JCnYBbUsjZ'),
(694, 'zx', 'zxdc', 'zxd', 'dDzvHY', 'CfnEnr', NULL, NULL, 4, 'p3r-k6EIO-opw4nfaVnZdcvnoQOhhqEO'),
(695, 'zxasd', 'zxdc', 'zxsa', '_P6fe2', '_F6_Q9', NULL, NULL, 4, 'SY65HdbOVMQ5ltJ3Y-eYI7BSaoYQM6IV'),
(696, 'zd', 'zxcd', 'zvxc', 'a3k742', 'f1lDsI', NULL, NULL, 4, 'jHql5cj-NWNSvb084HMtxJx1FFlvVZKI'),
(697, 'zx', 'zxdc', 'zxd', 'thJEIi', 'S9b2Cl', NULL, NULL, 4, 'WR06IGQBoMIGuE77WNNu4nVNrUxVRMgZ'),
(698, 'zxasd', 'zxdc', 'zxsa', 'c0eHAe', 'hNfajh', NULL, NULL, 4, 'J7V_jHMQavC-TBedVueRpT34J2GgUN9D'),
(699, 'zd', 'zxcd', 'zvxcd', 'wIJoYN', 'yqLuqw', NULL, NULL, 4, '9BwCF5kk3poMePV0nLsgeauID1PaTwnT'),
(700, 'zx', 'zxdc', 'zxdd', 'RUtLmA', 'nj_CAf', NULL, NULL, 4, 'XqZ9Kw5uO5sua167TTfjZotDlghLmDtB'),
(701, 'zxasd', 'zxdc', 'zxsad', '2RH0qL', 'uGhVy6', NULL, NULL, 4, 'RL3VkaineaXVoGrQmWT6LK_mB_Os3MJh');

-- --------------------------------------------------------

--
-- Структура таблицы `user_group`
--

CREATE TABLE `user_group` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `user_group`
--

INSERT INTO `user_group` (`id`, `user_id`, `group_id`) VALUES
(11, 2, 1),
(13, 2, 2),
(15, 77, 1),
(226, 358, 1),
(227, 359, 1),
(228, 360, 1),
(229, 361, 1),
(230, 362, 1),
(231, 363, 1),
(232, 364, 1),
(233, 365, 1),
(234, 366, 1),
(235, 367, 1),
(236, 368, 1),
(237, 369, 1),
(238, 370, 1),
(239, 371, 1),
(240, 372, 1),
(241, 373, 1),
(242, 374, 1),
(243, 375, 1),
(244, 376, 1),
(245, 377, 1),
(246, 378, 1),
(247, 379, 1),
(248, 380, 1),
(249, 381, 1),
(250, 382, 1),
(251, 383, 1),
(252, 384, 1),
(253, 385, 1),
(254, 386, 1),
(255, 387, 1),
(256, 388, 1),
(257, 389, 1),
(258, 390, 1),
(259, 391, 1),
(260, 392, 1),
(261, 393, 1),
(262, 394, 1),
(263, 395, 1),
(264, 396, 1),
(265, 397, 1),
(266, 398, 1),
(267, 399, 1),
(268, 400, 1),
(269, 401, 1),
(270, 402, 1),
(271, 403, 1),
(272, 404, 1),
(273, 405, 1),
(274, 406, 1),
(275, 407, 1),
(276, 408, 1),
(277, 409, 1),
(278, 410, 1),
(279, 411, 1),
(280, 412, 1),
(281, 413, 1),
(282, 414, 1),
(283, 415, 1),
(284, 416, 1),
(285, 417, 1),
(286, 418, 1),
(287, 419, 1),
(288, 420, 1),
(289, 421, 1),
(290, 422, 1),
(291, 423, 1),
(292, 424, 1),
(293, 425, 1),
(294, 426, 1),
(295, 427, 1),
(296, 428, 1),
(297, 429, 1),
(298, 430, 1),
(299, 431, 1),
(300, 432, 1),
(301, 433, 1),
(302, 434, 1),
(303, 435, 1),
(304, 436, 1),
(305, 437, 1),
(306, 438, 1),
(307, 439, 1),
(308, 440, 1),
(309, 441, 1),
(310, 442, 1),
(311, 443, 1),
(312, 444, 1),
(313, 445, 1),
(314, 446, 1),
(315, 447, 1),
(316, 448, 1),
(317, 449, 1),
(318, 450, 1),
(319, 451, 1),
(320, 452, 1),
(321, 453, 1),
(322, 454, 1),
(323, 455, 1),
(324, 456, 1),
(325, 457, 1),
(326, 458, 1),
(327, 459, 1),
(328, 460, 1),
(329, 461, 1),
(330, 462, 1),
(331, 463, 1),
(332, 464, 1),
(333, 465, 1),
(334, 466, 1),
(335, 467, 1),
(336, 468, 1),
(337, 469, 1),
(338, 470, 1),
(339, 471, 1),
(340, 472, 1),
(341, 473, 1),
(342, 474, 1),
(343, 475, 1),
(344, 476, 1),
(345, 477, 1),
(346, 478, 1),
(347, 479, 1),
(348, 480, 1),
(349, 481, 1),
(350, 482, 1),
(351, 483, 1),
(352, 484, 1),
(353, 485, 1),
(354, 486, 1),
(355, 487, 1),
(356, 488, 1),
(357, 489, 1),
(358, 490, 1),
(359, 491, 1),
(360, 492, 1),
(361, 493, 1),
(362, 494, 1),
(363, 495, 1),
(364, 496, 1),
(365, 497, 1),
(366, 498, 1),
(367, 499, 1),
(368, 500, 1),
(369, 501, 1),
(370, 502, 1),
(371, 503, 1),
(372, 504, 1),
(373, 505, 1),
(374, 506, 1),
(375, 507, 1),
(376, 508, 1),
(377, 509, 1),
(378, 510, 1),
(379, 511, 1),
(380, 512, 1),
(381, 513, 1),
(382, 514, 1),
(383, 515, 1),
(384, 516, 1),
(385, 517, 1),
(386, 518, 1),
(387, 519, 1),
(388, 520, 1),
(389, 521, 1),
(390, 522, 1),
(391, 523, 1),
(392, 524, 1),
(393, 525, 1),
(394, 526, 1),
(395, 527, 1),
(396, 528, 1),
(397, 529, 2),
(398, 530, 2),
(399, 531, 2),
(400, 532, 2),
(401, 533, 2),
(402, 534, 2),
(403, 535, 2),
(404, 536, 2),
(405, 537, 2),
(406, 538, 2),
(407, 539, 2),
(408, 540, 2),
(409, 541, 2),
(410, 542, 2),
(411, 543, 2),
(412, 544, 2),
(413, 545, 2),
(414, 546, 2),
(415, 547, 2),
(416, 548, 2),
(417, 549, 2),
(418, 550, 2),
(419, 551, 2),
(420, 552, 2),
(421, 553, 2),
(422, 554, 2),
(423, 555, 2),
(424, 556, 2),
(425, 557, 2),
(426, 558, 2),
(427, 559, 2),
(428, 560, 2),
(429, 561, 2),
(430, 562, 2),
(431, 563, 2),
(432, 564, 2),
(433, 565, 2),
(434, 566, 2),
(435, 567, 2),
(436, 568, 2),
(437, 569, 2),
(438, 570, 2),
(439, 571, 2),
(440, 572, 2),
(441, 573, 2),
(442, 574, 2),
(443, 575, 2),
(444, 576, 2),
(445, 577, 2),
(446, 578, 2),
(447, 579, 2),
(448, 580, 2),
(449, 581, 2),
(450, 582, 2),
(451, 583, 2),
(452, 584, 2),
(453, 585, 2),
(454, 586, 2),
(455, 587, 2),
(456, 588, 2),
(457, 589, 2),
(458, 590, 2),
(459, 591, 2),
(460, 592, 2),
(461, 593, 2),
(462, 594, 2),
(463, 595, 2),
(464, 596, 2),
(465, 597, 2),
(466, 598, 2),
(467, 599, 2),
(468, 600, 2),
(469, 601, 2),
(470, 602, 2),
(471, 603, 2),
(472, 604, 2),
(473, 605, 2),
(474, 606, 2),
(475, 607, 2),
(476, 608, 2),
(477, 609, 2),
(478, 610, 2),
(479, 611, 2),
(480, 612, 2),
(481, 613, 2),
(482, 614, 2),
(483, 615, 2),
(484, 616, 2),
(485, 617, 2),
(486, 618, 2),
(487, 619, 2),
(488, 620, 2),
(489, 621, 2),
(490, 622, 2),
(491, 623, 2),
(492, 624, 2),
(493, 625, 2),
(494, 626, 2),
(495, 627, 2),
(496, 628, 2),
(497, 629, 2),
(498, 630, 2),
(499, 631, 2),
(500, 632, 2),
(501, 633, 2),
(502, 634, 2),
(503, 635, 2),
(504, 636, 2),
(505, 637, 2),
(506, 638, 2),
(507, 639, 2),
(508, 640, 2),
(509, 641, 2),
(510, 642, 2),
(511, 643, 2),
(512, 644, 1),
(513, 645, 1),
(514, 646, 1),
(515, 647, 1),
(516, 648, 1),
(517, 649, 1),
(518, 650, 1),
(519, 651, 1),
(520, 652, 1),
(521, 653, 1),
(522, 654, 1),
(523, 655, 1),
(524, 656, 1),
(525, 657, 1),
(526, 658, 1),
(527, 659, 2),
(528, 660, 2),
(529, 661, 2),
(530, 662, 1),
(531, 663, 1),
(532, 664, 1),
(533, 665, 1),
(534, 666, 1),
(535, 667, 1),
(536, 668, 1),
(537, 669, 1),
(538, 670, 1),
(539, 683, 1),
(540, 684, 1),
(541, 685, 1),
(542, 686, 2),
(543, 687, 2),
(544, 688, 2),
(545, 689, 1),
(546, 690, 2),
(547, 691, 2),
(548, 692, 2),
(549, 693, 1),
(550, 694, 1),
(551, 695, 1),
(552, 696, 1),
(553, 697, 1),
(554, 698, 1),
(555, 699, 1),
(556, 700, 1),
(557, 701, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Индексы таблицы `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD PRIMARY KEY (`item_name`,`user_id`),
  ADD KEY `idx-auth_assignment-user_id` (`user_id`);

--
-- Индексы таблицы `auth_item`
--
ALTER TABLE `auth_item`
  ADD PRIMARY KEY (`name`),
  ADD KEY `rule_name` (`rule_name`),
  ADD KEY `idx-auth_item-type` (`type`);

--
-- Индексы таблицы `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD PRIMARY KEY (`parent`,`child`),
  ADD KEY `child` (`child`);

--
-- Индексы таблицы `auth_rule`
--
ALTER TABLE `auth_rule`
  ADD PRIMARY KEY (`name`);

--
-- Индексы таблицы `deny`
--
ALTER TABLE `deny`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_test_id` (`group_test_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `group_test`
--
ALTER TABLE `group_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Индексы таблицы `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Индексы таблицы `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `level_id` (`level_id`),
  ADD KEY `question_ibfk_3` (`test_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Индексы таблицы `question_level`
--
ALTER TABLE `question_level`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `student_answer`
--
ALTER TABLE `student_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `answer_id` (`answer_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `student_test`
--
ALTER TABLE `student_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_test_id` (`group_test_id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `teacher_subject`
--
ALTER TABLE `teacher_subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id-subject` (`subject_id`),
  ADD KEY `test_ibfk_2` (`is_active`);

--
-- Индексы таблицы `test_status`
--
ALTER TABLE `test_status`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- Индексы таблицы `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `answer`
--
ALTER TABLE `answer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `deny`
--
ALTER TABLE `deny`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT для таблицы `group`
--
ALTER TABLE `group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `group_test`
--
ALTER TABLE `group_test`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT для таблицы `question`
--
ALTER TABLE `question`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `question_level`
--
ALTER TABLE `question_level`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `question_type`
--
ALTER TABLE `question_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `role`
--
ALTER TABLE `role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `student_answer`
--
ALTER TABLE `student_answer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=583;

--
-- AUTO_INCREMENT для таблицы `student_test`
--
ALTER TABLE `student_test`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT для таблицы `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `teacher_subject`
--
ALTER TABLE `teacher_subject`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `test`
--
ALTER TABLE `test`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `test_status`
--
ALTER TABLE `test_status`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=702;

--
-- AUTO_INCREMENT для таблицы `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=558;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `deny`
--
ALTER TABLE `deny`
  ADD CONSTRAINT `deny_ibfk_1` FOREIGN KEY (`group_test_id`) REFERENCES `group_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deny_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `question_level` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `question_ibfk_3` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `question_ibfk_4` FOREIGN KEY (`type_id`) REFERENCES `question_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `student_answer`
--
ALTER TABLE `student_answer`
  ADD CONSTRAINT `student_answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_answer_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_answer_ibfk_3` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `student_test`
--
ALTER TABLE `student_test`
  ADD CONSTRAINT `student_test_ibfk_1` FOREIGN KEY (`group_test_id`) REFERENCES `group_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_test_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_test_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `teacher_subject`
--
ALTER TABLE `teacher_subject`
  ADD CONSTRAINT `teacher_subject_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_subject_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_group`
--
ALTER TABLE `user_group`
  ADD CONSTRAINT `user_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_group_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
