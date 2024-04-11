-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 11, 2024 at 02:39 PM
-- Server version: 5.7.39-log
-- PHP Version: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `new_diplom`
--

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `is_true` tinyint(1) NOT NULL,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`id`, `title`, `is_true`, `question_id`) VALUES
(14, 'd', 1, 15),
(15, 'd', 0, 15);

-- --------------------------------------------------------

--
-- Table structure for table `auth_assignment`
--

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_item`
--

CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_item_child`
--

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_rule`
--

CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deny`
--

CREATE TABLE `deny` (
  `id` int(11) NOT NULL,
  `true_false` tinyint(1) NOT NULL,
  `group_test_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `title`) VALUES
(1, 'iv123'),
(2, '228');

-- --------------------------------------------------------

--
-- Table structure for table `group_test`
--

CREATE TABLE `group_test` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group_test`
--

INSERT INTO `group_test` (`id`, `test_id`, `group_id`) VALUES
(18, 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1710234645),
('m140506_102106_rbac_init', 1710358066),
('m170907_052038_rbac_add_index_on_auth_assignment_user_id', 1710358066),
('m180523_151638_rbac_updates_indexes_without_prefix', 1710358066),
('m200409_110543_rbac_update_mssql_trigger', 1710358066);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id` int(11) NOT NULL,
  `text` text NOT NULL,
  `points_per_question` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `level_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`id`, `text`, `points_per_question`, `image`, `level_id`, `test_id`, `type_id`) VALUES
(15, 'd', 1, NULL, 2, 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `question_level`
--

CREATE TABLE `question_level` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question_level`
--

INSERT INTO `question_level` (`id`, `title`) VALUES
(1, 'Лёгкий'),
(2, 'Средний'),
(3, 'Сложный');

-- --------------------------------------------------------

--
-- Table structure for table `question_type`
--

CREATE TABLE `question_type` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question_type`
--

INSERT INTO `question_type` (`id`, `title`) VALUES
(1, 'Один правильный ответ'),
(2, 'Несколько правильных ответов'),
(3, 'Ввод ответа от студента');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `title`) VALUES
(1, 'admin'),
(2, 'manager'),
(3, 'teacher'),
(4, 'student');

-- --------------------------------------------------------

--
-- Table structure for table `student_answer`
--

CREATE TABLE `student_answer` (
  `student_test_id` int(11) NOT NULL,
  `ansuer_id` int(11) NOT NULL,
  `text` text,
  `question_id` int(11) NOT NULL,
  `answer_title` text NOT NULL,
  `cheked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student_test`
--

CREATE TABLE `student_test` (
  `id` int(11) NOT NULL,
  `mark` int(11) NOT NULL,
  `point` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `try` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id`, `title`) VALUES
(1, 'пришем код'),
(2, 'не пришем код');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subject`
--

CREATE TABLE `teacher_subject` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teacher_subject`
--

INSERT INTO `teacher_subject` (`id`, `user_id`, `subject_id`) VALUES
(1, 68, 1),
(2, 68, 2);

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `question_count` int(10) UNSIGNED NOT NULL,
  `point_count` int(10) UNSIGNED DEFAULT NULL,
  `subject_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `title`, `question_count`, `point_count`, `subject_id`, `is_active`) VALUES
(16, 'd', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `test_status`
--

CREATE TABLE `test_status` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test_status`
--

INSERT INTO `test_status` (`id`, `title`) VALUES
(1, 'active'),
(2, 'not_active'),
(3, 'closed');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `patronimyc` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `auth_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `surname`, `patronimyc`, `login`, `password`, `email`, `phone`, `role_id`, `auth_key`) VALUES
(2, 'admin', 'admin', 'admin', 'admin', '$2y$13$OPlJC8YfaEg4KmDEQzIvH.cN0aRiJZh0MgmVQkB94bpDRyjBZDWDy', 'admin', 'admin', 1, 'qCRkB2qqOQz6IGyPYRnwkKy7m0jmpwOJ'),
(64, 'manager', 'manager', 'manager', 'manager', '$2y$13$epYjBRhA5xhI9EB5XqmU3.p5A9qSVG4uXNH9ma1HXay9ReNfovSCC', 'manager', 'manager', 2, 'f6ngohpbehFcE-5hcojG7N_LnIOnD5zO'),
(68, 'teacher', 'teacher', 'teacher', 'teacher', '$2y$13$Tq7pIwFSvU.JgAFj1I1.x.ETffLgNx44o/TH8./f50zVR1TciKHbq', 'teacher', 'teacher', 3, 'LwJUjcM9VhLjsEQvDuyMvot8nDN0J2XF'),
(77, 'student', 'student', 'student', 'student', '$2y$13$xceS3/d8uJpFbwBIGZwk1uSv0mwd3/neiZvy53fMvloNBiS004dHW', 'student', 'student', 4, '6AGxewilkapWVuCJ8sBrkknUA2mgp5QK'),
(161, 'zxc', 'zxc', 'zzxc', 'TPjIAA', '$2y$13$TEONH5mblAOzApgtYkjgdOIIV9.QlprncVsEiw2Hthj2MTBxyONQG', NULL, NULL, 3, 'bncFJgxKnqNuQ9G0fZNDZBA6VclxfKmh'),
(162, 'zxc', 'zxc', 'zzxc', 'ECVLPK', '$2y$13$z4BCOx69UKiMMjDo7Chey.YY6VOkUapXLO/8gdjaqc0NMB8T94bPC', NULL, NULL, 3, 'EsuSJSsqNjm0_8P2Wn2NthgOaYFdC1yi'),
(163, 'zxc', 'zxc', 'zzx', 'OLL3bF', '$2y$13$PXNNcDgjha7km.3Qn3I3cejPemUUmkJBXT6OP7WbL0atMCvS9wQnK', NULL, NULL, 3, 'XsMAWBx9C5rhkz4ivrEFvcUUD0Km92Vt'),
(164, 'zxc', 'zxc', 'zzxc', 'f1t7iy', '$2y$13$gcSNzIr.QTvjeyx4.463ieLGRyqEL0jgS9zDS2FY49aYtu62kAguG', NULL, NULL, 3, 'nGfZ0p3rT2s4zd_954EWiEen0nWS70iQ'),
(165, 'zxc', 'zxc', 'zzxc', 'EoAtwF', '$2y$13$pg/kBDHXGow98FRRjZFJfu5rVr5.DcMynyOhlLrN3w3Q1xatHc2Ke', NULL, NULL, 3, 'EW_Xp_NiA9rezV4x6vBSLxgpCnB45U55'),
(166, 'zxc', 'zxc', 'zzx', 'M9Rm0D', '$2y$13$24MxVCULCcX0NYTSwIjWQu2dZQ2imQihyuMfVEITiuD6.gavElxOa', NULL, NULL, 3, '7BzABjhCrrXIKUKe7ZFfGwOFIExrpyF-'),
(167, 'zxc', 'zxc', 'zzxc', 'lU12nX', '$2y$13$21nS7QlFyr.j6OO2DIoALuAHz6yMwcFQMawLbt.dPwPav6ZwYMSGO', NULL, NULL, 3, '6ZEXqEu8oYMgJjCifbTsioJDIadco5i3'),
(168, 'zxc', 'zxc', 'zzxc', '3EzmTC', '$2y$13$5kPVzmNs/CHjX.peto1A5.m75ny7mdouE7Ir3mAt1QoGE662qaCoy', NULL, NULL, 3, 'O0966UixCUR6dujHUnPtpQJIvH-wF00D'),
(169, 'zxc', 'zxc', 'zzxc', '0BXfoA', '$2y$13$/Dqyb0gDwYRsMTr2gToLkODFvSBGf1sf5M/F6EQBYmCXp8tvZX4pi', NULL, NULL, 3, 'o5FTqgOVhwYA-txRGoty2sfOZ7LlQY9A'),
(170, 'zxc', 'zxc', 'zzxc', 'apu0ZS', '$2y$13$OHG3WJztCdsqKgkHHteF3Oa8nyfn9wQJbtjhrmYBo98eQpzziylgW', NULL, NULL, 3, '8TfNyuSsYZJJLTdaTXAMfzxfQ7AtzzCt'),
(171, 'zxc', 'zxc', 'zzx', 'b3b7fy', '$2y$13$erw..1CDqzjSIBfUKgRBc.7QmxNpLtGu9qeJrRE3ypHntTkLpbmQW', NULL, NULL, 3, 'VEkkQYAeArDL9rd0loWgG30jOSeBsqYP'),
(172, 'zxc', 'zxc', 'zzxc', 'yUMfSD', '$2y$13$c9jHq0cY8qQIk3oLjAzfluCVjieg0.OSHEk726vBSqT6MUG5CXmwG', NULL, NULL, 3, 'W3tLkh_TNZJorcgtZvH2Gi9Th7eUV8xV'),
(173, 'zxc', 'zxc', 'zzxc', 'pUu6jB', '$2y$13$UnknggUG97MIeyzsFmVSguZPdSrMALFxqNE1umENc64vpCDLz6NV6', NULL, NULL, 3, 'rqL5OOfgQYQueyaxdJkuepq0-8fA7sdS'),
(174, 'zxc', 'zxc', 'zzx', 'Ld58hZ', '$2y$13$P8VICibF9EcgqYTfNmoWKOsQSCKp1FAd0C0woDzIx1875ZaHbt126', NULL, NULL, 3, '_pa1Vap0pnbFSkU-W4xGGF24tuI3xKV1'),
(175, 'zxc', 'zxc', 'zzxc', 'pdOvVs', '$2y$13$OPm6kBB1/z.01W57zDK12umA3rQyh2R/iqKf6MQumon5upZe334Pm', NULL, NULL, 3, 'hPXIldmf3mZ-cC7vBYeJ1ppyO4UzRvk9'),
(176, 'zxc', 'zxc', 'zzxc', 'tsAXEK', '$2y$13$WZ5qwCPPeI.4OmetD7PSqOsIDLEJarX8Z1wDYsPwuJHcMbVIcuZ/K', NULL, NULL, 3, 'iXlZdoX1-KsCZ-2WC6u2zPOA7bFqb8HI'),
(177, 'zxc', 'zxc', 'zzx', '_HvlFk', '$2y$13$El8E6U09l9LD4worzXjNVuLg1Q810anWFkan3P3OwZz7bEQ90vGSm', NULL, NULL, 3, 'HXz41ZUyfN-M0xPLgSfcmBve2XN0oMJO'),
(178, 'zxc', 'zxc', 'zzxc', 'nf8Bca', '$2y$13$0lFEf3i.PPRNHjqIlSyaPeUjLsuvjeVhOTVk8hmjcyGs.Ov71XoGu', NULL, NULL, 3, 'GnS5MxbGpKqVhtE202qu3No5LXPVSKTY'),
(179, 'zxc', 'zxc', 'zzxc', 'fDekuI', '$2y$13$od87VhD1diC9mSD93Kou8OuXzoAeQAwTgUlcmcPARxlvO/Wx05GsW', NULL, NULL, 3, 'mmrE68BbWimXZtBcnvBkoz2VjyvgH7wq'),
(180, 'zxc', 'zxc', 'zzx', 'YGlC6q', '$2y$13$OTOE.yfa0RjakGWyB3qbre4SER4XkkSn3OG11oxGI1SWB/nnxGrTm', NULL, NULL, 3, 'i2R4o20qAI_sknDEuMjgPIJZ6-eFuMh4'),
(181, 'zxc', 'zxc', 'zzxc', 'PU4m-x', '$2y$13$lgdxlnsBnHBXtKvyKyRddOqWP8iDlr1URIE5eoDMyggZoaBP86szC', NULL, NULL, 3, 'iFA0tQuG6g6F2y0h4tIcc8eaW8A_F0vs'),
(182, 'zxc', 'zxc', 'zzxc', '7f9G2w', '$2y$13$Mui8nWNfC/LbDiYKnBHDdOI1ucKTlUv5ddlSnnB2UveZGWUYq1/iK', NULL, NULL, 3, '240RPUMJz2NjOi89WDBSPXQ3nh_X4zLu'),
(183, 'zxc', 'zxc', 'zzx', 'MuWQXh', '$2y$13$MwcNb/vhlG2BqWGP6dTTcukZ7GSoxfTrX.MPLJBM6.EhjeEzwIKJe', NULL, NULL, 3, 'YXjt-37r0lP0ypwp11zWYrs-AbCAE1IV'),
(184, 'zxc', 'zxc', 'zzxc', '6gIvCp', '$2y$13$nbr3LGHVyakp1QvKOK7LLu0Gywaj0QT0.sQ19yell7p3nqGXJzM7.', NULL, NULL, 3, '99bq2HlGw2zXsGRRlQ5J5g7vNd2BiqAy'),
(185, 'zxc', 'zxc', 'zzxc', 'PBSTZQ', '$2y$13$wMBsxhgBxJAvSEtXx2eHr.rXRzgVEyNWMCQEaB/38BX.Dq0VcDQUm', NULL, NULL, 3, 'IpIeaOPtfTWCY-uNXqHe1jTYO8H2afA4'),
(186, 'zxc', 'zxc', 'zzx', 'gl2llQ', '$2y$13$ZqM4pUu8OrcTcZPbKqbdt.JG61z28Iavw/35xY0A5gDTLTYs4ItvS', NULL, NULL, 3, 'vTJTqaZFEvN1RsDvl4f_7G9emWvseaJ4'),
(187, 'zxc', 'zxc', 'zzxc', 'klLP7o', '$2y$13$.FLnu54pZSLo7.MWvYXsfu9ZY096PBUqsktc3lxSWDnb.hpL3M22i', NULL, NULL, 3, '1kpHsdh8Vi_2EsLauh5d-31_5AjgGgWM'),
(188, 'zxc', 'zxc', 'zzxc', 'rS19U6', '$2y$13$mqHBh5tM2T9B/qess43eR.ZjKuDDWyqp40juwbNoeoMqGGlUxvl1W', NULL, NULL, 3, 'vO17BHDcDmgGX8Rg9RZ0dMYqxxVESQDW'),
(189, 'zxc', 'zxc', 'zzx', 'ikwTt8', '$2y$13$p6vjcUlk4VPYp3O33iPolucPXdL.jktjTHw6jtcxnjsc14dtr55i2', NULL, NULL, 3, 'Dx0cwdjdDT900-Mo9lM4LrU6eC5yehFv'),
(190, 'zxc', 'zxc', 'zzxc', 'tWNFzC', '$2y$13$lN1FGSnWJgc1jLU1MzD4Uuzicbme1bSxbRp9l9YmfOU5YG5RtgZsC', NULL, NULL, 3, 'Vv_MkbEEjiHQ_ddCGkieIypQXrJQm9Sp'),
(191, 'zxc', 'zxc', 'zzxc', 'mRv2aC', '$2y$13$nE49qaOboqT/LKER7kGfK.ShWAnwAgI/r6kLIvWz1kGnibI5KBD.2', NULL, NULL, 3, '9Tw-aNucxxnptV-uBL0xb5GX1EdWRQKI'),
(192, 'zxc', 'zxc', 'zzx', 'JbMXOp', '$2y$13$hH/BlRDiD/FfZXFKAGbeheGG3NLvq.KQk4Ma28R5dlN6/zK46D6Ru', NULL, NULL, 3, '0U4h2lM4gz4pwmE7mW_anRagAKH_0RHY'),
(193, 'zxc', 'zxc', 'zzxc', 'F_9Jt_', '$2y$13$L5Tpx7EteP66CxvLNAO5Reqp5eRie0zg4UMCGYhpXa4nfU.VebaWC', NULL, NULL, 3, 'gqG62GQ_BQWNkTr4hpTMDcZBPANnQgFF'),
(194, 'zxc', 'zxc', 'zzxc', 'ZnVUWi', '$2y$13$L9NFv9lnpnEb9CBj362Pium/iwv5bFn1hM.hx57dIdxFWDR.PjZP.', NULL, NULL, 3, 'mquPPSrdCJm9n3KGGGXFEX34zPu99KVJ'),
(195, 'zxc', 'zxc', 'zzx', 'AJB8T0', '$2y$13$c87.9oIrWsbRmq6bCGDFcuU6ZsSA5hGSwpkCJL0qL0HjVbTCJjpzu', NULL, NULL, 3, 'xZ-SDbishNDDhDEmbGGOgj3094w6r_uw'),
(196, 'asd', 'asd', 'asd', 'SYv1Ko', 'Rbusg1', NULL, NULL, 4, '2wswApznFJYIKHn3q-J6SGgsIPtJKZYi'),
(197, 'asd', 'asd', 'asd', 'jYoAiH', '9evLs2', NULL, NULL, 4, 'gcOwme25oUkpBop4_qmH2I3hS1pejjqC'),
(198, 'asd', 'asd', 'asd', '3LDoyq', 'wjyf6f', NULL, NULL, 4, 'YYiyKoF8942w18sN6WSe_O0FKYglkBRn'),
(199, 'asd', 'asd', 'as', 'RgqJSk', 'jhzHvn', NULL, NULL, 4, 'fyaS0wHBV5OVbyRUX5020Zmilp3eX_IB'),
(200, 'zxc', 'zxc', 'zxc', 'AiZzKB', 'BFPHZO', NULL, NULL, 3, '_1aJQSgyXr8mzls4WhwWlKnRagJBKimR'),
(201, 'zxc', 'zxc', 'zxc', 'Bt3ASp', 'xMnAMB', NULL, NULL, 3, 'GBssEAV3UklqatUo9cPa_dX1SeBTjX4h'),
(202, 'zxc', 'zxc', 'zx', 'cNCpS0', 'aDpP6X', NULL, NULL, 3, 'zdoLmvX5_lybKLRVSA_aKYbqTJbNZ9tH'),
(203, 'zxc', 'zxc', 'zxc', 'CHNSea', 'g67DBG', NULL, NULL, 4, 'g24trlRXVjt-mjUH5WR2IWWc8dJcQavP'),
(204, 'zxc', 'zxc', 'zxc', '9y2pxA', '7fNSVy', NULL, NULL, 4, 'aWKKcVeK-eaAaT8iOn7ZZkJ7OSV1hJC9'),
(205, 'zxc', 'zxc', 'zx', 'SWzFZH', 'rcRYGb', NULL, NULL, 4, 'e3QxSiHlFUL7_iptArdy6gxbgRjqqsTC'),
(206, 'zxc', 'zxc', 'zxc', 'IOB_Ye', 'FB-NfS', NULL, NULL, 4, 'edaJ4YrcbxSwOqv5LeA5TiWdTkPwbPrM'),
(207, 'zxc', 'zxc', 'zxc', 'lgYHY4', 'LU0G83', NULL, NULL, 4, '6fFPZiJo4Fk6SpPWdIQAKp9KpPQPuHPn'),
(208, 'zxc', 'zxc', 'zx', 'qSOdfs', 'hA3lkG', NULL, NULL, 4, 'RjEzg7dbCUmuRoyKNKw2a3408_I9eiDM'),
(209, 'zxc', 'zxc', 'zxc', 'XN4LuZ', 'kvnlXD', NULL, NULL, 4, 'o8pWLNL3wHEDbNJNyTdyz4ibvC8mx-Gx'),
(210, 'zxc', 'zxc', 'zxc', 'Gch_Rp', 'yCyiSi', NULL, NULL, 4, '1pgRJaJV1pxtfZUZzUzMA3KC4MNg-D2g'),
(211, 'zxc', 'zxc', 'zx', 'XzNnRD', 'wIu06T', NULL, NULL, 4, 'hPbG9byf0-lkOie_xash97IilZTJX5YN'),
(212, 'zxc', 'zxc', 'zxc', 'YV-zEZ', 'yXDgYE', NULL, NULL, 4, 'V4Ygs3G4fwRQwqxRZ-GzUCBmTuYx90NF'),
(213, 'zxc', 'zxc', 'zxc', 'ucuXwM', 'NVL-iP', NULL, NULL, 4, 'aX5gTOPzPNHjTyrZ1VOpjEbH8hVR65Dk'),
(214, 'zxc', 'zxc', 'zx', 'DZxYiv', 'x45nmU', NULL, NULL, 4, 'rVrMEOqxo0VPbjWboqgeJFockG_Sl-_G'),
(215, 'zxc', 'zxc', 'zxc', 'ywPam_', 'SsEzLS', NULL, NULL, 4, 'CJyIk0m8_Cr1oDv8fpXwvQuHlXMZOSmQ'),
(216, 'zxc', 'zxc', 'zxc', '2fle_S', '6sl3Wy', NULL, NULL, 4, 'EBrACNw4SQryEZibSUaUtL_KsbO_2M5Z'),
(217, 'zxc', 'zxc', 'zx', 'N0wNRr', 'NgiAHN', NULL, NULL, 4, 'vXkyQ3pQVqlevt08xtReFWMCSWWHTAUW'),
(218, 'zxc', 'zxc', 'zxc', 'vfwmKl', 'wBfwkD', NULL, NULL, 4, 'lPXIV_iI8O0ZgnnsNIXAhyoJDQsW1-rc'),
(219, 'zxc', 'zxc', 'zxc', '3g5TsZ', 'nxya0m', NULL, NULL, 4, 'CM7tZSjMHJBBwFJ6JVzyIj8syCgXetGq'),
(220, 'zxc', 'zxc', 'zx', 'y1gB1S', 'He2VHw', NULL, NULL, 4, 'XkXanJSSjNgBm9LyQJ_0szkTC_ruOmbn'),
(221, 'zxc', 'zxc', 'zxc', 'X6fNcj', 'Sb3NfZ', NULL, NULL, 4, 'Yr3GRJlycAK4QhgUX5-E6TfYFUL195f_'),
(222, 'zxc', 'zxc', 'zxc', 'I2VdMP', 'eUn1jw', NULL, NULL, 4, 'H2qRztOJ1tebCc0R7gu74MmeEoIk0-zu'),
(223, 'zxc', 'zxc', 'zx', 'q-yJTh', 'Ml-O2a', NULL, NULL, 4, 'YVQkaVRmy0yrBie-6SMBm6MnGvIXShvT'),
(224, 'zxc', 'zxc', 'zxc', '4E8a9a', 'kFXcU9', NULL, NULL, 4, 'Tk1eInRQWX5w4-QNogt-SUOL74oTWbEL'),
(225, 'zxc', 'zxc', 'zxc', 'A83eAq', 'I1Pyyc', NULL, NULL, 4, 'x1K9t3n8wfXu5Z5o6jdDR98Te2MKj-yN'),
(226, 'zxc', 'zxc', 'zx', '92hT4n', 'AbOpBh', NULL, NULL, 4, 'SCZdwkz_SVmlm9Kt1AcToYIxLdKC-kZ5'),
(227, 'zxc', 'zxc', 'zxc', 'nR_tOZ', 'HCHLRL', NULL, NULL, 4, 'vdkXRqO6g_D0HHLv50Sci5u4ecLVIPJ1'),
(228, 'zxc', 'zxc', 'zxc', 'F6FYCd', 'X-zJtW', NULL, NULL, 4, 'C8EYajYMgw1KlLQRTThwvT3fxdryfGuo'),
(229, 'zxc', 'zxc', 'zx', '7XAtnF', 'mUBBQL', NULL, NULL, 4, 'qdYu5gBP-e1sRZvBaNSKFIGq46o_L4Hh'),
(230, 'zxc', 'zxc', 'zxc', 'ouWbyB', 'X2kaJV', NULL, NULL, 4, '7UQlL7eLCuAB5b0sHGdojL-k2Di2GXfo'),
(231, 'zxc', 'zxc', 'zxc', 'DIQfyF', 'yAWlEw', NULL, NULL, 4, 'g8_IW0BzfGBWVAXMujmlAJC0ljAlryT3'),
(232, 'zxc', 'zxc', 'zx', 'Df3F9e', 'VvvMCB', NULL, NULL, 4, '72iotd7sxtcV2rTdDoTKVZH-tJXVVRs2'),
(233, 'zxc', 'zxc', 'zxc', 'LdI4iv', 'U0faht', NULL, NULL, 4, 'a70kqTvCR23Q8pgePk5rwEU3iNqb0JzK'),
(234, 'zxc', 'zxc', 'zxc', '-Z7rTa', '6-YCNt', NULL, NULL, 4, 'Wal1aSn2tVJoFWZjIOOOoC0dh9qSgVZ_'),
(235, 'zxc', 'zxc', 'zx', '2vIedk', 'U4KnTz', NULL, NULL, 4, 'vn2tLo9RFZ2bD6N0aE-TTDSKVYn5SNck'),
(236, 'zxc', 'zxc', 'zxc', 'm6FPBX', '2jtul3', NULL, NULL, 4, 'E-orhtHOMMjghKs537MR7adgdTm4FL1k'),
(237, 'zxc', 'zxc', 'zxc', 'cW8OQ_', 'DXdlR0', NULL, NULL, 4, 'CJpxroi6-l0yvyPo0mnnlXQYYbsxqJ00'),
(238, 'zxc', 'zxc', 'zx', 'ZzpEgS', 'f_vCcM', NULL, NULL, 4, 'yh-lurJYp21rehJjoHXJSnYDZgoVydBD'),
(239, 'zxc', 'zxc', 'zxc', 'i28V1w', 'RajtUx', NULL, NULL, 4, 'eytnGpHCoTcvZQvYEw5iWFyh_OVKD_C4'),
(240, 'zxc', 'zxc', 'zxc', '0JrCAO', '_IVBNg', NULL, NULL, 4, '1T-b_QFDPDDsoLUTyFzGzq1UYxxHvFvv'),
(241, 'zxc', 'zxc', 'zx', 'ttq_rS', 'pm_8YV', NULL, NULL, 4, 'dVpPD4gdQqHGUl-EzO4x2tzz_yXdyJNG'),
(242, 'zxc', 'zxc', 'zxc', '3ph9bG', '1iz4m2', NULL, NULL, 4, 'sKtd1oM3sQFZgU5qSJFZE7QZy6WhWeXX'),
(243, 'zxc', 'zxc', 'zxc', 'fSia-Z', 'I_PtiF', NULL, NULL, 4, 'ojR3klEBfiA6yjLKi-oVgOy86VMTOIu9'),
(244, 'zxc', 'zxc', 'zx', 'bnY8i7', 'q-dYQu', NULL, NULL, 4, 'BmowkULK3B6sayvI9zJQ9IneEqkl39De'),
(245, 'zxc', 'zxc', 'zxc', 'xV0bvu', 'y8NxkT', NULL, NULL, 4, 'cEtj29sCPt1TcyaEyMMjzptuIYCLM4Bt'),
(246, 'zxc', 'zxc', 'zxc', 'Ofrx0H', 'cW_GsF', NULL, NULL, 4, '1E8I93fBAZO1ipVaU86rykBgEjqKFSzh'),
(247, 'zxc', 'zxc', 'zx', 'R58SkD', 'OnEZP1', NULL, NULL, 4, '9TXzyTS3JhFaujWPgX6fppKMJVSSTjit'),
(248, 'zxc', 'zxc', 'zxc', 'tw6w_P', 'CPFHkF', NULL, NULL, 4, 'zF--vBgLnq2YKBvfFCqwW3vO5Vei9iNv'),
(249, 'zxc', 'zxc', 'zxc', 'c81v2b', 'Kzxkh_', NULL, NULL, 4, 'gJBDcjZP1gKx5kvoOU2MspwJUenwcms5'),
(250, 'zxc', 'zxc', 'zx', 'RFZpd_', 'Gtwlg2', NULL, NULL, 4, '14yXc6RVPvz_pfEzUOLhLBRQICqwScmP'),
(251, 'zxc', 'zxc', 'zxc', 'yYVJwW', 'bz1rKJ', NULL, NULL, 4, 'oTrE5dVwMPV-PquY7rKgNynC20mwb_JI'),
(252, 'zxc', 'zxc', 'zxc', '0oOaW0', 'khsFZm', NULL, NULL, 4, 'G2qi39ixG6NIsXSjXkS7L2hJB-xG9MqS'),
(253, 'zxc', 'zxc', 'zx', 'GwmW32', '2KA0Jn', NULL, NULL, 4, 'rwZYPEXS26QLlqlCVIhub_E3cSkEguh_'),
(254, 'zxc', 'zxc', 'zxc', 'efBedz', 'KT6RNB', NULL, NULL, 4, 'RCfCR4F7TLoUnQQZtMCT_f2GhuHwCLFS'),
(255, 'zxc', 'zxc', 'zxc', '15fogn', 'qwQ5Fm', NULL, NULL, 4, '8MTswvHzmFEm_WVx0Rf1vQA4kw2GO1Gb'),
(256, 'zxc', 'zxc', 'zx', 'IRSZHd', '7u0zVY', NULL, NULL, 4, 'FJPviyWQ5pXIt1gW0ntyxeNEUN3AvfMc'),
(257, 'zxc', 'zxc', 'zxc', 'WDUOAN', 'DHaL16', NULL, NULL, 4, 'lut_VghgxxeBQEF4Cn3HL1vKozZPMn0Y'),
(258, 'zxc', 'zxc', 'zxc', 'AlDbAf', 'vBY2qJ', NULL, NULL, 4, '7NUoizNRL7CF9Xc5nQ0jzr578OdxSxQe'),
(259, 'zxc', 'zxc', 'zx', 'IrlBGq', 'Gaq9-M', NULL, NULL, 4, 'SXl_XBT-us-a08SjUN5hJWBX5dq_O-Eo'),
(260, 'zxc', 'zxc', 'zxc', 'tXOSba', 'gTtKDJ', NULL, NULL, 4, '6GUJu_jJvKYEa86aqtTKgUEEZuwjJIku'),
(261, 'zxc', 'zxc', 'zxc', 'MJwo06', 'cHPZ3o', NULL, NULL, 4, 'aH29w0PbOqEJyiF2IfuwjbaCFxh00P9Q'),
(262, 'zxc', 'zxc', 'zx', 'mZ01UU', 'inCIYB', NULL, NULL, 4, 'zaAj28cwh_rBMVdnsqY01WtGkqnY-tzM'),
(263, 'zxc', 'zxc', 'zxc', '-cZHnd', 'GYti6A', NULL, NULL, 4, 'DU82bh-rsC0QyPLpBufFrPogmSSUoWdF'),
(264, 'zxc', 'zxc', 'zxc', 'Xdc1Wr', 'Iz8LSr', NULL, NULL, 4, 'yQFlp6wvJ_UxDa9I-Cv2MFhoDgqrCb1_'),
(265, 'zxc', 'zxc', 'zx', 'LkXjql', 'X4Jz3W', NULL, NULL, 4, '4BcW0ko_wfKGLK603HrCr6XLrBz58UaX'),
(266, 'zxc', 'zxc', 'zxc', 'CldjIW', 'BQtvEe', NULL, NULL, 4, '9RrgW-NUTAF42pTFG65L1eiC2H7yAZAs'),
(267, 'zxc', 'zxc', 'zxc', 'deZhdc', '5KgKaM', NULL, NULL, 4, 'CkGgEqV_hBpLkWCKULRkEDBmK-YCpSTd'),
(268, 'zxc', 'zxc', 'zx', 'gB3Zb8', 'j07q0B', NULL, NULL, 4, 'tKWpbNeVzpDwDn4J3pfzjGLLvJoC8nOw'),
(269, 'zxc', 'zxc', 'zxc', 'c7ic3j', '9cccLY', NULL, NULL, 4, 'soYBWX0olzlctmW-VFupUWHTJJKTIZCZ'),
(270, 'zxc', 'zxc', 'zxc', 'CGkWzR', 'hndPGS', NULL, NULL, 4, 'imjwu9-bIclOg2S2eRd_afC21-IEkSHu'),
(271, 'zxc', 'zxc', 'zxc', 'B3xuWc', 'g8x8MO', NULL, NULL, 4, 'jS4LOPLyuvJnAuxprRl8Ww89AgNTvBca'),
(272, 'zxc', 'zxc', 'zxc', 'Qlhtdm', 'irSCuC', NULL, NULL, 4, '2BW-ogHxBPQePLg0XdoEdVWhANXvMuhX'),
(273, 'zxc', 'zxc', 'zx', 'O-7r92', 'vPEDhL', NULL, NULL, 4, 'lv9cedB1OWzwZVAlAZlR_3s7ygwKb5aj'),
(274, 'zxc', 'zxc', 'zxc', 'Mz1qZ3', 'gIRUzS', NULL, NULL, 4, 'oT0yy0noEW7qg3MJgn6Y6c-WXqFpdYeM'),
(275, 'zxc', 'zxc', 'zxc', 'nf6Gy7', '6g4tU4', NULL, NULL, 4, 'UY5VC59-BewKMcyPADCFE1oWZUtTzr3b'),
(276, 'zxc', 'zxc', 'zx', 'EyTfeP', 'ttJRNf', NULL, NULL, 4, '9gThe04j6Z-PeBECXjwvZboWkPG8s8-i'),
(277, 'zxc', 'zxc', 'zxc', 'JKzMaO', 'lHZtyv', NULL, NULL, 4, 'vCvBfqp2sxq7jzjOOTkh_Ffk_lo24Jce'),
(278, 'zxc', 'zxc', 'zxc', '4R1h0d', 's0KTtT', NULL, NULL, 4, 'lrn1f50O3qOCxDdS3tDgsoear7N8XFNZ'),
(279, 'zxc', 'zxc', 'zx', 'eJN2nD', 'RlndWh', NULL, NULL, 4, 'jC2Icm_8XO4IEWsLv63YICPm5SHsKgEB'),
(280, 'zxc', 'zxc', 'zxc', 'VLpkU8', '-FdKFe', NULL, NULL, 4, 'mNU070K51yi7Yth5ao0_pDbEJdlZVyaA'),
(281, 'zxc', 'zxc', 'zxc', 'VFGqoE', 'u71mXh', NULL, NULL, 4, 'vEorlfivaOPM3jOZyXBRzInavxhBnus9'),
(282, 'zxc', 'zxc', 'zx', 'gdeICY', 'oavLxj', NULL, NULL, 4, 'xKVcPULEduzHijVlRd0kSU5JZKyxQs77'),
(283, 'zxc', 'zxc', 'zxc', 'oxsHDp', '7H8A7t', NULL, NULL, 4, 'MQiYP7POAnRG-tXIcybKPMsIzXw9nYDf'),
(284, 'zxc', 'zxc', 'zxc', '5Ak4U_', '1Ycu22', NULL, NULL, 4, 'HTebtiYhUSuR61PHYpo8otwFYl819NUL'),
(285, 'zxc', 'zxc', 'zx', '23ijno', 'wqnpy_', NULL, NULL, 4, 'bPVL4opzXmjSXMiP3R-6Fr5ATCAyE0AY'),
(286, 'zxc', 'zxc', 'zxc', 'QsigB1', 'LUj43i', NULL, NULL, 4, '33qinVyCB-eI6XoN_C3SfpoWlAFvAon9'),
(287, 'zxc', 'zxc', 'zxc', 'VtDlhX', 'fJWJEJ', NULL, NULL, 4, 'QZOJEXRSV1c70F9t7LQtuP6rQq1h91eO'),
(288, 'zxc', 'zxc', 'zx', 'Flo6g2', '6j5vNk', NULL, NULL, 4, 'dfpHmZ_mi2VnC19r7Wps4f6FXyM1cQnt'),
(289, 'zxc', 'zxc', 'zxc', '4gx9Sg', 'fETSdM', NULL, NULL, 4, 'oedj5M2C7P29wrgsRqjc9x0FgM3EayHJ'),
(290, 'zxc', 'zxc', 'zxc', 'rkiuZg', '5l-T8v', NULL, NULL, 4, '_LueMGj79kNBKTp3dw_0JC43qgdOXXcC'),
(291, 'zxc', 'zxc', 'zx', 'aNjvFX', 'Tiu_bs', NULL, NULL, 4, 'PiWuPp-NxX_tu3TnskTewiD073WWvGXE'),
(292, 'zxc', 'zxc', 'zxc', 'UmZ3KS', '1aLaTI', NULL, NULL, 4, 'FcCeX1amk0CTE5xqTBsY5vDWQEHq-iBz'),
(293, 'zxc', 'zxc', 'zxc', 'kFzugN', 'PC6_H-', NULL, NULL, 4, 'M0yu3fq9le0wTH63yZfYNkq8QYp-7o5a'),
(294, 'zxc', 'zxc', 'zx', 'vuynGc', 'J09VTk', NULL, NULL, 4, 'k1VOUVBwBvg0rukmoQsn6pGk2i31cPdm'),
(295, 'zxc', 'zxc', 'zxc', 'QmXbGx', 'tBUgfL', NULL, NULL, 4, 'VvNmPQ5_XauhNS6rGUjOe-KlyBLd7B3P'),
(296, 'zxc', 'zxc', 'zxc', 'gKiFta', 'J4xgTL', NULL, NULL, 4, 'wJEjX-4mWImDy6yc_u1yJz1aAlmGvRQQ'),
(297, 'zxc', 'zxc', 'zx', '3BSuhj', 'kRVGm0', NULL, NULL, 4, '2Pzms5KSyV7QGGDXQOYV6JvsoBYJeLpZ'),
(298, 'zxc', 'zxc', 'zxc', 't8-blp', '6ZvMkO', NULL, NULL, 4, 'eaWdp2XYvXDe7dB9wa6fxtEutGa80Fze'),
(299, 'zxc', 'zxc', 'zxc', 'bfk5s1', 'l-vvli', NULL, NULL, 4, '5DtS92H6BIJr-TyhZuLMlTrsqq8dNlSJ'),
(300, 'zxc', 'zxc', 'zx', 'ImwnQe', 'sWT9A-', NULL, NULL, 4, 'mpMWLvf_9g4SQaTDuBORI7maEbgtYXYv'),
(301, 'zxc', 'zxc', 'zxc', 'UVHiYI', 'DLmn2a', NULL, NULL, 4, 'SPL14QIjXJZzCpw6zD7K-wNiSCJrRGLC'),
(302, 'zxc', 'zxc', 'zxc', '7bq_Sr', 'U6x478', NULL, NULL, 4, 'vHeRUndezU1FPxqW2AKyIpK5pxkABQSA'),
(303, 'zxc', 'zxc', 'zx', 'E6-DSd', 'kWTZt0', NULL, NULL, 4, '_IWWO-I7qECk1fORpxN7MZJMvYEy2sNr'),
(304, 'zxc', 'zxc', 'zxc', '-fxT21', 'bMjvJv', NULL, NULL, 4, 'v-vtyFnt-y1fxndEUp1qUsgWusZ7Qfs9'),
(305, 'zxc', 'zxc', 'zxc', '8LrlvU', 'bP0qNf', NULL, NULL, 4, 'qg618IkxcufNdF4Gw7zV5Nh8vbunwweM'),
(306, 'zxc', 'zxc', 'zx', 'T5CHEX', 'uNU1lS', NULL, NULL, 4, 'fmN5dLhCoPG_DbAKUpQeqaXaXItplGnf'),
(307, 'zxc', 'zxc', 'zxc', 'mcluN9', 'ugeIA4', NULL, NULL, 4, '4eiW9NzmVMWpOKC16Lm1PhbrTBWpE9V6'),
(308, 'zxc', 'zxc', 'zxc', 'OZounI', 'taMYAf', NULL, NULL, 4, 'v0L3Vn6HZdnqd1RRCw98E9l1cGAgH9Zx'),
(309, 'zxc', 'zxc', 'zx', 'd8zcS7', 'Xqbf_u', NULL, NULL, 4, 'UlDaSqZfgVt5wR2cZXLyXB6B2vm7t-yS'),
(310, 'zxc', 'zxc', 'zxc', 'h8FLrj', 'xPxHwf', NULL, NULL, 4, 'L7e9C7AvnvWoE2gg8NypyGDBhuWwpPVE'),
(311, 'zxc', 'zxc', 'zxc', 'moDoXh', 'IqLFhU', NULL, NULL, 4, 'Oad40mX-OrQammuw6oeEQOpIOcjxGvzD'),
(312, 'zxc', 'zxc', 'zx', 'LqS7hl', 'R7qjYj', NULL, NULL, 4, '3QeGU9tw_fBBhjMtFtw8xCu8Tvr3HWHD'),
(313, 'zxc', 'zxc', 'zxc', 'Zr7xy3', 'X7vp3d', NULL, NULL, 4, 'HmQDvi4TG558R4pFtbYGnNRgMVGBJOeO'),
(314, 'zxc', 'zxc', 'zxc', 'Oc8JJ-', 'bcNddU', NULL, NULL, 4, '3OfmiFkOYDB4oYtG726j1ARAl7_Xsd5L'),
(315, 'zxc', 'zxc', 'zx', 'oftnOM', 'Vs5dkd', NULL, NULL, 4, 'uEz_K2XqA-EqtOJNh9xcx4gmsOaqjf9i'),
(316, 'zxc', 'zxc', 'zxc', 'UfU7P7', 'GWckr5', NULL, NULL, 4, '0OD5g62nmCtgzpLBwBewQ0bUCIb4faaf'),
(317, 'zxc', 'zxc', 'zxc', 'vtu53N', 'VvHSBm', NULL, NULL, 4, 'X2YC6L508ILqX1CbAGBt0h7eR80pYDJd'),
(318, 'zxc', 'zxc', 'zx', '_i76yW', 'jaQzBW', NULL, NULL, 4, 'kyWgbOja1Wne6x1SjiIirXC_ciBXKlab'),
(319, 'zxc', 'zxc', 'zxc', 'rf3XP8', 'Rii903', NULL, NULL, 4, 'DIcdy-vUsJW-Fr4__BNjf1Td5Xuk0xFU'),
(320, 'zxc', 'zxc', 'zxc', 'y6LlzT', 'RtuQid', NULL, NULL, 4, 'p8ZQYttVo8xwLYgPmifiDkiwvm3zUZ4I'),
(321, 'zxc', 'zxc', 'zx', 'vZ5Lgp', '8siCYd', NULL, NULL, 4, 'D0Cwm3OIVprF08lt0PhdOu17BxFoXnuw'),
(322, 'zxc', 'zxc', 'zxc', '5bOrWn', 'QeCKj-', NULL, NULL, 4, 'fQvaOl5aunVnb21-3XZl-bcX73oStXhJ'),
(323, 'zxc', 'zxc', 'zxc', 'zX3UC9', 'CBcT5L', NULL, NULL, 4, 'DU-Gpwdx9qhdZii4LAl-BvjjGux4BdVh'),
(324, 'zxc', 'zxc', 'zx', 'OC7ldI', 'PVaBLi', NULL, NULL, 4, 'AjqTAyL7ZpYRbRHLIYZUDBgzbsZ1YLk6'),
(325, 'zxc', 'zxc', 'zxc', 'OoTbHb', '06v1sk', NULL, NULL, 4, 'lk5rIy-90iwJh87W8hrKdmHZXd38yQGt'),
(326, 'zxc', 'zxc', 'zxc', '31JDvf', 'PzvKjD', NULL, NULL, 4, 'xaYncVB3HsIX4IjE17yJAtl5kB05DHJD'),
(327, 'zxc', 'zxc', 'zx', 'hTb2VF', 'AfQk8h', NULL, NULL, 4, 'zOBf9W4O1nORii428ApW_1-THqs28PIh'),
(328, 'zxc', 'zxc', 'zxc', 'G8G8SV', '8KzqhT', NULL, NULL, 4, '8lJgXwYHAxdocG37AX0NSipJT1negYx8'),
(329, 'zxc', 'zxc', 'zxc', 'xjKGZ0', 'zZjUcd', NULL, NULL, 4, 'zJu61DwGLfSdLaSZbOGz8G--gDjlDfw0'),
(330, 'zxc', 'zxc', 'zx', '3OLNW3', 'U6kB1H', NULL, NULL, 4, 'nnPi4U4hyucXThGYy1C2Z9_KBxfTZHMY'),
(331, 'zxc', 'zxc', 'zxc', 'YwfhUA', 'eOl-66', NULL, NULL, 4, '1IVDJ6mzxoSLVwSt3XoN-TRf80zByNOU'),
(332, 'zxc', 'zxc', 'zxc', 'tt--_q', 'xn9BzJ', NULL, NULL, 4, 'TB0oBauEsYhXg4Ayg69iubbvLjGDeBnZ'),
(333, 'zxc', 'zxc', 'zx', '82FRUI', 'dlT5eP', NULL, NULL, 4, 'FQJ2fbUrfhjOUGD0g9NqNSPILU_GU74u'),
(334, 'zxc', 'zxc', 'zxc', 'Op962H', 'YyaG31', NULL, NULL, 4, 'B2cpdbEKC3GwYZ3CmQ7hFhfIatv9MgAm'),
(335, 'zxc', 'zxc', 'zxc', 'kr5Slo', 'X7e6Zk', NULL, NULL, 4, 'y5a5cGu6RkmwkoGCuZ_2wcMhyUcOdRX4'),
(336, 'zxc', 'zxc', 'zx', 'FAyCG4', 'do8b7b', NULL, NULL, 4, 'a0C2omX_ZXZ7SvSyC9A30OWNO3ruf2Z9'),
(337, 'zxc', 'zxc', 'zxc', 'TY86xe', 'aLxFxU', NULL, NULL, 4, 'FUEKvKdKGN5mY0-eq_BysRLJ3Hdv33Pm'),
(338, 'zxc', 'zxc', 'zxc', 'mDlZkT', '8qzQq-', NULL, NULL, 4, 'y7mOWIrsjDHI4D9dsJxB7-uZZG0-z3ge'),
(339, 'zxc', 'zxc', 'zx', 'OhdTrK', 'yuKpOK', NULL, NULL, 4, 'wecTKq8q2Rl60X085_1v_fg1l5wWg59f'),
(340, 'zxc', 'zxc', 'zxc', 'w4tq60', '76Njkr', NULL, NULL, 4, 'wnKE2LWFG6P0f9Fee-z_NR42jx8QzP4M'),
(341, 'zxc', 'zxc', 'zxc', '5p9IzP', 'yf6t2A', NULL, NULL, 4, 'xgKceGOtb0Oh4v-eXaRuoIBxvRrSdMw0'),
(342, 'zxc', 'zxc', 'zx', 'FhStBu', 'L43B0t', NULL, NULL, 4, 'Wka7vN-l8hWPD94Q878kWVwIoDMi4sUP'),
(343, 'zxc', 'zxc', 'zxc', 'VOLd9N', 'WEdw6T', NULL, NULL, 4, '7e3StzxzmM7SYH85LmkcRJ3jo3Mgue7h'),
(344, 'zxc', 'zxc', 'zxc', '0IS9T6', 'RmRgn8', NULL, NULL, 4, 'UPknh6nFLr4jQqM59tzkVKJ6LCjF66iu'),
(345, 'zxc', 'zxc', 'zx', 'NVkk9g', 'LDXb63', NULL, NULL, 4, 'scDY4vossF4cvQA1cnYAGPcvNWcasYOR'),
(346, 'zxc', 'zxc', 'zxc', 'qjEZHk', 'Mo2csf', NULL, NULL, 4, 'Tq3sbey7kNCacHNdmdroKlCMIwu00JqM'),
(347, 'zxc', 'zxc', 'zxc', 'woPTUa', 'LBMrP4', NULL, NULL, 4, 'pLn-D0ylynjxVsHij8QOPqVDnF7vuhYt'),
(348, 'zxc', 'zxc', 'zx', 'wNdOaZ', '34tKV2', NULL, NULL, 4, 'FxDmoC7CCoFBCfMAgOlAUnNetaKjFcpA'),
(349, 'zxc', 'zxc', 'zxc', 'NnTMg2', '8eVuw5', NULL, NULL, 4, '4perTzdQR1IZs6Z23rSm4uTtpcyTlglv'),
(350, 'zxc', 'zxc', 'zxc', 'jrGTrV', 'vlze2I', NULL, NULL, 4, 'uOVJN9jEck9u9fExttThcIYxPZFv6kF3'),
(351, 'zxc', 'zxc', 'zx', 'GIbkIs', 'ft-whr', NULL, NULL, 4, '31lGlZrUMqseSdDLjdkNBAB5Dj2x4MZe'),
(352, 'zxc', 'zxc', 'zxc', 'nq0a1e', 'MWXX0N', NULL, NULL, 4, 'IhaNsPTbU1mG8bEf4fwAYS8pIv377xEu'),
(353, 'zxc', 'zxc', 'zxc', '2IJNHm', 'HlMFSG', NULL, NULL, 4, '2U5tn1vWgt8qumIk1iqCqku9_id3nZtI'),
(354, 'zxc', 'zxc', 'zx', 'jAst1M', '_Y9BbT', NULL, NULL, 4, '9yko_9fcxtA4T4mx3naEX6mK8R-ZcYu6'),
(355, 'zxc', 'zxc', 'zxc', 'e9cxEh', 'CO1AoC', NULL, NULL, 4, 'jgZxnXhG2qm-weiYoUqxRjyg1qieNNS2'),
(356, 'zxc', 'zxc', 'zxc', 'iyb-GD', 'plxRVd', NULL, NULL, 4, 'wf1RL4uGupsvB278T9_0mWy7zly4JlPs'),
(357, 'zxc', 'zxc', 'zx', '3QkebA', 'F7umxj', NULL, NULL, 4, 'qBlsWKG3oXI4ZQKWwYKTnKCgougarH38'),
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
(644, 'zd', 'zxcd', 'zvxc', 'zL0Jq4', '_bSbIR', NULL, NULL, 4, 'D7ZVWUYhgDcMDYg37BJXFWnkEbvee4qd');
INSERT INTO `user` (`id`, `name`, `surname`, `patronimyc`, `login`, `password`, `email`, `phone`, `role_id`, `auth_key`) VALUES
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
(682, 'zxasd', 'zxdc', 'zxsa', 'dx1--9', '$2y$13$HWVaIcG/DwlynpREiAP7iuo2xlXinV8Eu0azX1D0wkL.10z/Db82m', NULL, NULL, 3, '_8k3BwHzQSgogBiZtt8h0Q9hqcAkdmhC');

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `user_id`, `group_id`) VALUES
(11, 2, 1),
(13, 2, 2),
(15, 77, 1),
(20, 68, 1),
(21, 68, 2),
(34, 161, 2),
(35, 162, 2),
(36, 163, 2),
(37, 164, 2),
(38, 165, 2),
(39, 166, 2),
(40, 169, 2),
(41, 170, 2),
(42, 171, 2),
(43, 172, 1),
(44, 173, 1),
(45, 174, 1),
(46, 175, 1),
(47, 176, 1),
(48, 177, 1),
(49, 178, 1),
(50, 179, 1),
(51, 180, 1),
(52, 181, 1),
(53, 182, 1),
(54, 183, 1),
(55, 184, 1),
(56, 185, 1),
(57, 186, 1),
(58, 187, 1),
(59, 188, 1),
(60, 189, 1),
(61, 190, 1),
(62, 191, 1),
(63, 192, 1),
(64, 193, 2),
(65, 194, 2),
(66, 195, 2),
(67, 196, 1),
(68, 197, 1),
(69, 198, 2),
(70, 199, 2),
(71, 203, 2),
(72, 204, 2),
(73, 205, 2),
(74, 206, 2),
(75, 207, 2),
(76, 208, 2),
(77, 209, 2),
(78, 210, 2),
(79, 211, 2),
(80, 212, 2),
(81, 213, 2),
(82, 214, 2),
(83, 215, 2),
(84, 216, 2),
(85, 217, 2),
(86, 218, 2),
(87, 219, 2),
(88, 220, 2),
(89, 221, 2),
(90, 222, 2),
(91, 223, 2),
(92, 224, 2),
(93, 225, 2),
(94, 226, 2),
(95, 227, 2),
(96, 228, 2),
(97, 229, 2),
(98, 230, 2),
(99, 231, 2),
(100, 232, 2),
(101, 233, 2),
(102, 234, 2),
(103, 235, 2),
(104, 236, 2),
(105, 237, 2),
(106, 238, 2),
(107, 239, 2),
(108, 240, 2),
(109, 241, 2),
(110, 242, 1),
(111, 243, 1),
(112, 244, 1),
(113, 245, 1),
(114, 246, 1),
(115, 247, 1),
(116, 248, 1),
(117, 249, 1),
(118, 250, 1),
(119, 251, 1),
(120, 252, 1),
(121, 253, 1),
(122, 254, 1),
(123, 255, 1),
(124, 256, 1),
(125, 257, 1),
(126, 258, 1),
(127, 259, 1),
(128, 260, 1),
(129, 261, 1),
(130, 262, 1),
(131, 263, 1),
(132, 264, 1),
(133, 265, 1),
(134, 266, 1),
(135, 267, 1),
(136, 268, 1),
(137, 269, 1),
(138, 270, 1),
(139, 271, 1),
(140, 272, 1),
(141, 273, 1),
(142, 274, 1),
(143, 275, 1),
(144, 276, 1),
(145, 277, 1),
(146, 278, 1),
(147, 279, 1),
(148, 280, 1),
(149, 281, 1),
(150, 282, 1),
(151, 283, 1),
(152, 284, 1),
(153, 285, 1),
(154, 286, 1),
(155, 287, 1),
(156, 288, 1),
(157, 289, 1),
(158, 290, 1),
(159, 291, 1),
(160, 292, 1),
(161, 293, 1),
(162, 294, 1),
(163, 295, 1),
(164, 296, 1),
(165, 297, 1),
(166, 298, 1),
(167, 299, 1),
(168, 300, 1),
(169, 301, 1),
(170, 302, 1),
(171, 303, 1),
(172, 304, 1),
(173, 305, 1),
(174, 306, 1),
(175, 307, 1),
(176, 308, 1),
(177, 309, 1),
(178, 310, 1),
(179, 311, 1),
(180, 312, 1),
(181, 313, 1),
(182, 314, 1),
(183, 315, 1),
(184, 316, 1),
(185, 317, 1),
(186, 318, 1),
(187, 319, 1),
(188, 320, 1),
(189, 321, 1),
(190, 322, 1),
(191, 323, 1),
(192, 324, 1),
(193, 325, 1),
(194, 326, 1),
(195, 327, 1),
(196, 328, 1),
(197, 329, 1),
(198, 330, 1),
(199, 331, 1),
(200, 332, 1),
(201, 333, 1),
(202, 334, 1),
(203, 335, 1),
(204, 336, 1),
(205, 337, 1),
(206, 338, 1),
(207, 339, 1),
(208, 340, 1),
(209, 341, 1),
(210, 342, 1),
(211, 343, 1),
(212, 344, 1),
(213, 345, 1),
(214, 346, 1),
(215, 347, 1),
(216, 348, 1),
(217, 349, 1),
(218, 350, 1),
(219, 351, 1),
(220, 352, 1),
(221, 353, 1),
(222, 354, 1),
(223, 355, 1),
(224, 356, 1),
(225, 357, 1),
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
(538, 670, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD PRIMARY KEY (`item_name`,`user_id`),
  ADD KEY `idx-auth_assignment-user_id` (`user_id`);

--
-- Indexes for table `auth_item`
--
ALTER TABLE `auth_item`
  ADD PRIMARY KEY (`name`),
  ADD KEY `rule_name` (`rule_name`),
  ADD KEY `idx-auth_item-type` (`type`);

--
-- Indexes for table `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD PRIMARY KEY (`parent`,`child`),
  ADD KEY `child` (`child`);

--
-- Indexes for table `auth_rule`
--
ALTER TABLE `auth_rule`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `deny`
--
ALTER TABLE `deny`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_test_id` (`group_test_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_test`
--
ALTER TABLE `group_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `level_id` (`level_id`),
  ADD KEY `question_ibfk_3` (`test_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `question_level`
--
ALTER TABLE `question_level`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_answer`
--
ALTER TABLE `student_answer`
  ADD KEY `ansuer_id` (`ansuer_id`),
  ADD KEY `student_answer_ibfk_1` (`student_test_id`);

--
-- Indexes for table `student_test`
--
ALTER TABLE `student_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacher_subject`
--
ALTER TABLE `teacher_subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id-subject` (`subject_id`),
  ADD KEY `test_ibfk_2` (`is_active`);

--
-- Indexes for table `test_status`
--
ALTER TABLE `test_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `deny`
--
ALTER TABLE `deny`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `group_test`
--
ALTER TABLE `group_test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `question_level`
--
ALTER TABLE `question_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `question_type`
--
ALTER TABLE `question_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `student_test`
--
ALTER TABLE `student_test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `teacher_subject`
--
ALTER TABLE `teacher_subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `test_status`
--
ALTER TABLE `test_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=683;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=539;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deny`
--
ALTER TABLE `deny`
  ADD CONSTRAINT `deny_ibfk_1` FOREIGN KEY (`group_test_id`) REFERENCES `group_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deny_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_test`
--
ALTER TABLE `group_test`
  ADD CONSTRAINT `group_test_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_test_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `question_level` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `question_ibfk_3` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `question_ibfk_4` FOREIGN KEY (`type_id`) REFERENCES `question_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_answer`
--
ALTER TABLE `student_answer`
  ADD CONSTRAINT `student_answer_ibfk_1` FOREIGN KEY (`student_test_id`) REFERENCES `student_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_answer_ibfk_2` FOREIGN KEY (`ansuer_id`) REFERENCES `answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_test`
--
ALTER TABLE `student_test`
  ADD CONSTRAINT `student_test_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_test_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher_subject`
--
ALTER TABLE `teacher_subject`
  ADD CONSTRAINT `teacher_subject_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_subject_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_group`
--
ALTER TABLE `user_group`
  ADD CONSTRAINT `user_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_group_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
