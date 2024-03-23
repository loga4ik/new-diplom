-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 23, 2024 at 11:57 PM
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
(2, 'фывфывфывфы', 1, 5);

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
(1, 1, 1),
(2, 2, 2);

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
(5, 'asd', 1, NULL, 1, 8, 1);

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
  `text` text
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

--
-- Dumping data for table `student_test`
--

INSERT INTO `student_test` (`id`, `mark`, `point`, `test_id`, `user_id`, `try`) VALUES
(1, 5, 50, 1, 77, 1),
(2, 4, 50, 1, 77, 1),
(3, 4, 50, 1, 77, 1),
(4, 4, 50, 2, 77, 1);

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
(1, 'test one', 10, 50, 1, 1),
(2, 'test 2', 10, 50, 2, 0),
(8, 'asd', 1, 1, 2, 0);

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
(2, 'admin', 'admin', 'admin', 'admin', '$2y$13$OPlJC8YfaEg4KmDEQzIvH.cN0aRiJZh0MgmVQkB94bpDRyjBZDWDy', 'admin', 'admin', 3, 'qCRkB2qqOQz6IGyPYRnwkKy7m0jmpwOJ'),
(64, 'manager', 'manager', 'manager', 'manager', '$2y$13$epYjBRhA5xhI9EB5XqmU3.p5A9qSVG4uXNH9ma1HXay9ReNfovSCC', 'manager', 'manager', 2, 'f6ngohpbehFcE-5hcojG7N_LnIOnD5zO'),
(68, 'teacher', 'teacher', 'teacher', 'teacher', '$2y$13$Tq7pIwFSvU.JgAFj1I1.x.ETffLgNx44o/TH8./f50zVR1TciKHbq', 'teacher', 'teacher', 3, 'LwJUjcM9VhLjsEQvDuyMvot8nDN0J2XF'),
(77, 'student', 'student', 'student', 'student', '$2y$13$xceS3/d8uJpFbwBIGZwk1uSv0mwd3/neiZvy53fMvloNBiS004dHW', 'student', 'student', 4, '6AGxewilkapWVuCJ8sBrkknUA2mgp5QK'),
(115, 'asd', 'asd', 'asd', 'GDZTXH', '$2y$13$h.8ENnJc4KjdCfvTA/a0YuK6V462K56ssaO1WjVESmVy6HAgldfUu', NULL, NULL, 3, '5dYWPqygvR1EnHk2WsgpIbPjta-Lo-Om'),
(116, 'asd', 'asd', 'asd', 'LJ3iaQ', '$2y$13$RM7kiGybInVQtqnR.3feW.WcX8BOCMrloW1gonX.YfE8OGo7iWLOa', NULL, NULL, 3, 'sCwbX3d7WxIs8d0erwxhD8jdcxgwMV2G'),
(117, 'asd', 'asd', 'asd', 'oz9_Ll', '$2y$13$U2JC9H1vEkxkZZDg5kewy.IYE4TmZoM5mKbOIscdNWKBw8DjP7clW', NULL, NULL, 3, 'UGtckEutEggzMjuMmHRnOuAG6tFA7zj3'),
(118, 'asd', 'asd', 'asd', '49MHHt', '$2y$13$2fR7E0FnQBIQgOYKCwOeE.EhZN3oZlE49poZFRNWSjToCULMlZDAC', NULL, NULL, 3, 'Os8OMYX5OQUhTVGJmvKNxGOvAiBehoeR'),
(119, 'asd', 'asd', 'as', '_u-qRE', '$2y$13$3jPVjJKh0mPG/wS1U9CweOlvyyfkyaEQcrFUVdrKDU9V7trZSMvMm', NULL, NULL, 3, 'OHDWDBFDbbpDOG-MVv9IL0cT9xXRTS7U'),
(120, 'asd', 'asd', 'asd', 'DGjaxe', '$2y$13$WIZJEv2HINk4tOun2WM2B.cU/odeowlxdmkF4buWZ32Wx4cUFPNcG', NULL, NULL, 3, 'rex2OaL-CudI6XxJODMW9XrAr9IpRd55'),
(121, 'asd', 'asd', 'asd', 'PQ8wD1', '$2y$13$Kx8MTaXhFFh5UYyr3Nb2K.pD8MargfYcOCkHovwBDUJ1loK1XoDw2', NULL, NULL, 3, 'b43239FsGWRWhNf-XJHO38sxlhbEG_k7'),
(122, 'asd', 'asd', 'asd', 'n6sd2E', '$2y$13$iX1S2olY9bnYONlphSW5WebvuAfoGV9kUHj40/gJEnH1YEGYP7JuG', NULL, NULL, 3, 'LPq2ZLCByaRifl7Ni1H2tb_X4Uyc9eTP'),
(123, 'asd', 'asd', 'asd', 'M0So0g', '$2y$13$ns1vrWfpmyelsa.Cimw4R.bO0lZ87yycWcF5f0R58SfhZEqTVu/Ky', NULL, NULL, 3, 'AEyQ-7jKdQ1vHbJtRHCHBcrb7qKHHZ7O'),
(124, 'asd', 'asd', 'as', '4dtkXf', '$2y$13$BLGe.j4j6xOxZ1rEKt5PZusQCtgCCK9HQrKHccPuq5OR7R//.Qi2.', NULL, NULL, 3, 'lmMEpfdzDfe-oaejL49KOJmu0lIMrL7s'),
(125, 'asd', 'asd', 'asd', 'Rdy9h8', '$2y$13$r12.gtg6E1OZtieyDmolwOtA8Whxe2PARleAkTy.dkdvdoqnAvna2', NULL, NULL, 3, 'rB_i4m7dAw_a0F4qfHs3u27NxdYa7PzO'),
(126, 'asd', 'asd', 'asd', 'BjXJy-', '$2y$13$7X0HOha6z5NBsg0E82pMcutyTiIqByP2fodmcDhyPbYt/hwGd21jK', NULL, NULL, 3, 'QWFVg20kr_a41CLU6telslUR8PD0RNGV'),
(127, 'asd', 'asd', 'asd', 'Tt6cl0', '$2y$13$44eR8vzRZslqj7pOhpZJC.oCTYtkYZnTpII.ZOaDdipDSWwW90doe', NULL, NULL, 3, 'acXDLPyZsdffCH6T3942ULNxaAInLKa1'),
(128, 'asd', 'asd', 'asd', 'MZFMgn', '$2y$13$W5jD3dgAfoHfH70F2hK88OXquLuHk6DtRQApvVGHzL0.UKMNbtJKG', NULL, NULL, 3, '3Heiwd2_38v7cZF08eb4gK7lC9zALMTe'),
(129, 'asd', 'asd', 'as', 'jwzJYq', '$2y$13$FLepLvJqlZF/UrGZhGaruua.6iU2M0e7rQJyBBa4w5LrgVshHS5M.', NULL, NULL, 3, 'D8OW8sdcr6SGjyWISvUBPhtESd7cP06d'),
(130, '1', '1', '1', 'oUIdt_', '$2y$13$1b3H7JV0466f6Kg3ycpve.MuTJ8N0TjflLFeyQffuUWk7fh9Zvwa.', NULL, NULL, 3, 'pb3X8HbJj1-ta0GKViQhT6V0nkzrszT3'),
(131, '1', '1', '1', 'XeJ89R', '$2y$13$YTmPZebw577Tk/r8x8xPU.j5ISk8xl.2MvJ/5wKsIf8/rpfqL7xxW', NULL, NULL, 3, 'nHEQqGlqP8YtMJyCum3Son2sicLWVrhL'),
(132, '2', '2', '2', 'H8LKNj', '$2y$13$tpjpLBn4I2UhKtsl5nBhiO.O1SH3L94rbAmxvpObLBaL5yYpShiva', NULL, NULL, 3, 'T3g8CKgMGoa1UZSEUrnlIzes5mvbqnbS'),
(133, 'd', 'd', 'd', 'KAurFQ', '$2y$13$OvZrq22YNcl2RMLvAQoBxeFaleiDb5Sm855z.O6bS08FMCeC9xDI2', NULL, NULL, 3, 'UfMzlebVMVv1wN_WFtUz2vITYEnsNfDV'),
(134, 'c', 'c', 'c', '3ZZwFm', '$2y$13$r3rb9qxupEITJDQGGV3nIOtPr4u04Mk/QyicXQtrG3N1AFWv4m19u', NULL, NULL, 3, 'nqrL5lEyixlkb1Tqmg7w_oQZzYgKxNXu'),
(135, 'c', 'c', 'x', '_WQwRw', '$2y$13$Emv1jd4h7BPBKp6R0lCMTenieOxuZTLBrs3IaoYA.kRC2eu5xHMfq', NULL, NULL, 3, 'scdPFxCGiH7bc_-FdhAnIKkEM8_kzssI'),
(136, 'asdas', 'asd', 'asd', 'VMLMF2', '$2y$13$VE1YykiYmepTFHcsydW//.Z6q7EUMKNjN8mZCZ/DrBDkqDxYh5WUC', NULL, NULL, 3, 'fS117IlJhwsOYrr3jHXihOUyexElT8CP'),
(137, 'asdas', 'asd', 'asd', 'rfafrR', '$2y$13$qW4YR8/L9LcUYFB8YWY/EuwPlAUaw9te2ArkZ.1gsa46OzHclrrFK', NULL, NULL, 3, '94VcwrVDGTUVKpUUjStuAlrLbD2kdMVo'),
(138, 'asdas', 'asd', 'asd', 'B_jpyl', '$2y$13$oGrWBUt2QVixgdGjRE1wD.wCx/3nt1byoT.keInF13JNBMZwvzv.y', NULL, NULL, 3, 'oUgvdNy8wYpQxACRNscujuH3x6uKyN-N'),
(139, 'asdas', 'asd', 'as', '6UHmF-', '$2y$13$xpRRbhRjKyk.6UFC4ELIF.//RBLmBhIRyWcs9FIAHdVTn.RCtf7xS', NULL, NULL, 3, 'DCqRGY6E4yQ5Xp7Ek9OFH-U4irOJ8vzr'),
(140, 'asdasd', 'asdasd', 'asdasd', 'GGbaNz', '$2y$13$nNPOfo7G1G7/T.SSF.mVgOaN74ecwCa9XWn/rofvu16/gsUJ8qOke', NULL, NULL, 3, 'i2s7zUrMltAwzLx40iVigVR7sI-VzxD5'),
(141, 'asd', 'asd', 'asd', 'HVetJ3', '$2y$13$hy2sXdsREBIsZ9ArySJw3.HT6L1mWUxjZe1EeaIEW3dO/wcPJIMo6', NULL, NULL, 3, 'viPHLz0j4as05A-4lMSbqvqN7maU25xT'),
(142, 'asd', 'asd', 'as', 'MDRvrr', '$2y$13$cTDsNphqtnYo.RQ5pygDvuUari.xm.DpqUABwhxFwW6C6KV3GeXjW', NULL, NULL, 3, 'bg2Fxa8cRdm9gsHDHmoTtaNAuTjzDV00'),
(143, 'asd', 'asd', 'asd', 'CbVw67', '$2y$13$M3/sHPoERB.FbVRbvXNweeH1eeHx4uvgUEP8RYTqb7lf0IoRwaAyW', NULL, NULL, 3, 'r1XT0TOulYNJhsQsvzuOOfc5fWSwSajp'),
(144, 'asd', 'asd', 'as', 'JmfP9G', '$2y$13$QXy9TddpdmWVSvgvowiCgek3iFlfRsEzHpgAhf30pxy9UHVdYhOAC', NULL, NULL, 3, 'semiEVGT5r0a5-83R8idTEGZ4gIouKRN'),
(145, 'asd', 'asd', 'asd', 'o16CW4', '$2y$13$tSYiwVYiawNd/PNVtcf3GuPDq3SERnPFb9GikUUuyf8q4F8NBKSoa', NULL, NULL, 3, 'bBaxiTVxMZGYzzJhNKNXVj0NUMoraaY8');

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
(16, 140, 2),
(17, 143, 1),
(18, 144, 1),
(19, 145, 1),
(20, 68, 1),
(21, 68, 2);

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
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id-subject` (`subject_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `group_test`
--
ALTER TABLE `group_test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
