-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 16, 2023 lúc 02:17 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `machineman`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `changed_part`
--

CREATE TABLE `changed_part` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `image` tinyblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `changed_part`
--

INSERT INTO `changed_part` (`id`, `code`, `name`, `price`, `quantity`, `issue_id`, `image`) VALUES
(7, 'sdf', 'sdf', NULL, 2, 35, NULL),
(8, 'trr', 'ewe', NULL, 3, 35, NULL),
(9, 'sdf', 'sdf', NULL, 2, 36, NULL),
(10, 'trr', 'ewe', NULL, 3, 36, NULL),
(11, 'sdf', 'sdf', NULL, 2, 46, NULL),
(12, 'trr', 'ewe', NULL, 3, 46, NULL),
(21, NULL, NULL, NULL, NULL, 47, NULL),
(22, NULL, NULL, NULL, NULL, 47, NULL),
(23, NULL, NULL, NULL, NULL, 47, NULL),
(44, 'holo', 'sdf', NULL, 2, 51, NULL),
(45, 'shup', 'ewe', NULL, 3, 51, NULL),
(46, 'holo', 'sdf', NULL, 2, 52, NULL),
(47, 'shup', 'ewe', NULL, 3, 52, NULL),
(50, 'oplo', 'sdf', NULL, 2, 50, NULL),
(51, 'ssosoup', 'ewe', NULL, 3, 50, NULL),
(52, 'holo', 'sdf', NULL, 2, 53, NULL),
(53, 'shup', 'ewe', NULL, 3, 53, NULL),
(57, 'oplo', 'sdf', NULL, 2, 56, NULL),
(58, 'ssosoup', 'ewe', NULL, 3, 56, NULL),
(83, 'sdf', 'sdf', NULL, 3, 48, NULL),
(84, 'trr', 'ewe', NULL, 2, 48, NULL),
(85, NULL, NULL, NULL, NULL, 48, NULL),
(86, NULL, NULL, NULL, NULL, 48, NULL),
(136, '1', 'sdf-sdf', NULL, 3, 6, NULL),
(137, '2', 'trr-ewe', NULL, 2, 6, NULL),
(138, 'holo', 'sdf', NULL, 2, 63, NULL),
(139, 'shup', 'ewe', NULL, 3, 63, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `component`
--

CREATE TABLE `component` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `component_equipment`
--

CREATE TABLE `component_equipment` (
  `component_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `department`
--

INSERT INTO `department` (`id`, `code`, `description`, `name`) VALUES
(1, 'dsd', 'sdf', 'sdf'),
(2, 'ds', 'sdss', 'sdss');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `department_error`
--

CREATE TABLE `department_error` (
  `department_id` int(11) NOT NULL,
  `error_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`id`, `code`, `created_date`, `email`, `name`, `phone`, `updated_date`, `user_id`) VALUES
(1, 'fsdfs', NULL, 'sdf', 'sdf', '0147852369', NULL, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `equipment`
--

INSERT INTO `equipment` (`id`, `code`, `description`, `name`, `department_id`, `owner_id`) VALUES
(1, 'sdf', 'sdf', 'sdf', 1, NULL),
(3, 'sdfsds', 'sdfsss', 'sdfs', 1, NULL),
(4, 'sdfs', 'sdf', 'sdfsd', 2, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `error`
--

CREATE TABLE `error` (
  `id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `issue`
--

CREATE TABLE `issue` (
  `id` int(11) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `big_issue` bit(1) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `downtime` varchar(255) DEFAULT NULL,
  `end` time DEFAULT NULL,
  `error` varchar(255) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `ycsc` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `created_by_username` varchar(255) DEFAULT NULL,
  `updated_by_username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `issue`
--

INSERT INTO `issue` (`id`, `action`, `big_issue`, `create_by`, `create_date`, `description`, `downtime`, `end`, `error`, `issue_date`, `notes`, `start`, `status`, `update_by`, `updated_date`, `ycsc`, `department_id`, `equipment_id`, `created_by`, `updated_by`, `created_at`, `deleted`, `updated_at`, `created_by_username`, `updated_by_username`) VALUES
(5, 'w', b'0', '', '2023-08-22 01:57:53', '', '0:37:38', '05:33:44', 'd', '2023-09-07', '', '04:56:06', 'follow', NULL, '2023-09-07 14:25:37', '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(6, 'acc', b'1', '', '2023-08-22 03:01:12', 'des', '23:2:0', '23:02:02', 'dss', '2023-08-21', 'norerwe', '00:00:02', 'done', NULL, '2023-09-06 15:18:21', 'sdsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(7, 'act', b'0', '', '2023-08-22 03:16:19', '', '1:0:0', '00:22:22', 'sdsds', '2023-08-21', '', '23:22:22', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(8, 'acr', b'1', '', '2023-08-22 03:21:57', 'ẻd', '13:9:49', '12:32:11', 'sds', '2023-08-21', 'fsd', '23:22:22', 'pending', NULL, NULL, 'ad', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(9, 'zxz', b'0', '', '2023-08-22 03:28:13', '', '0:0:5', '05:34:49', 'zx', '2023-08-21', '', '05:34:44', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(10, 'zxz', b'0', '', '2023-08-22 03:28:16', '', '0:0:5', '05:34:49', 'zx', '2023-08-21', '', '05:34:44', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(11, 'zxz', b'0', '', '2023-08-22 03:28:17', '', '0:0:5', '05:34:49', 'zx', '2023-08-21', '', '05:34:44', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(12, 'zxz', b'0', '', '2023-08-22 03:28:19', '', '0:0:5', '05:34:49', 'zx', '2023-08-21', '', '05:34:44', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(13, 'thay tế', b'1', '', '2023-08-23 07:21:25', 'Hỏng hóc thiết bị', '1:2:0', '09:22:55', 'hở ống', '2023-08-23', '', '08:20:55', 'done', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(14, 'Holle', b'1', '', '2023-08-23 09:11:50', '', '23:50:0', '23:45:11', 'Toafn', '2023-08-23', 'Note', '23:55:11', 'done', NULL, NULL, 'Tocsit', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(15, 'ACtions', b'1', '', '2023-08-23 09:27:14', 'Moo ta', '0:45:11', '05:55:33', 'Erroa tu may client', '2023-08-23', '', '05:10:22', 'done', NULL, NULL, 'Ycsc', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(16, 'Holle', b'1', '', '2023-08-23 09:32:47', '', '23:50:0', '23:45:11', 'Toafn', '2023-08-23', 'Note', '23:55:11', 'done', NULL, NULL, 'Tocsit', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(17, 'Holle', b'1', '', '2023-08-23 09:33:02', '', '23:50:0', '23:45:11', 'Toafn', '2023-08-23', 'Note', '23:55:11', 'done', NULL, NULL, 'Tocsit', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(18, 'Holle', b'1', '', '2023-08-23 09:33:42', '', '23:50:0', '23:45:11', 'Toafn', '2023-08-23', 'Note', '23:55:11', 'done', NULL, NULL, 'Tocsit', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(19, 'ACtions', b'1', '', '2023-08-23 09:34:00', 'Moo ta', '0:45:11', '05:55:33', 'Erroa tu may client', '2023-08-23', 'Notes nef', '05:10:22', 'done', NULL, NULL, 'Ycsc', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(20, 'huh', b'0', '', '2023-08-25 09:47:14', '', '0:0:3', '13:44:58', 'sdfs', '2023-08-25', '', '13:44:55', 'done', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(21, 'sdfsd', b'0', '', '2023-08-25 23:33:03', '', '0:0:22', '05:55:33', 'dsfsd', '2023-08-25', '', '05:55:11', 'done', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(22, 'acrafdsaf', b'1', '', '2023-08-26 08:14:09', 'dsd', '23:14:0', '12:09:55', 'sdsd', '2023-08-26', '', '12:55:55', 'pending', NULL, NULL, 'sdsdsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(23, 'acrafdsaf', b'1', '', '2023-08-26 08:14:48', 'dsd', '23:14:0', '12:09:55', 'sdsd', '2023-08-26', '', '12:55:55', 'pending', NULL, NULL, 'sdsdsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(24, 'sdfsdf', b'0', '', '2023-08-26 08:15:45', '', '23:59:50', '23:06:45', 'sdfsdf', '2023-08-26', '', '23:06:55', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(25, 'sdf', b'1', '', '2023-08-26 08:56:31', 'sdfasdf', '23:59:58', '13:55:03', 'sdfsd', '2023-08-26', '', '13:55:05', 'follow', NULL, NULL, 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(39, 'actyioans', b'1', '', NULL, 'descsa', '1:0:4', '17:11:26', 'Hư bột hư đường', '2023-08-31', '', '16:11:22', 'follow', NULL, NULL, 'tyds', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(40, 'hgjhgj', b'0', '', NULL, '', '23:55:0', '09:50:55', 'fghjkl', '2023-08-31', '', '09:55:55', 'done', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(41, 'Actionss', b'0', '', NULL, '', '1:0:0', '03:05:22', 'fdgdfgdfgfd', '2023-08-31', '', '02:05:22', 'follow', NULL, NULL, '', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(42, 'dsfgsdfgsd', b'1', '', '2023-08-31 23:28:16', 'Cdeaf', '0:0:45', '05:05:50', 'dfgdfgd', '2023-08-31', '', '05:05:05', 'follow', NULL, '2023-08-31 23:28:16', 'dsfgsdf', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(43, 'acdasc', b'0', '', '2023-09-01 03:44:19', '', '0:0:1', '06:04:05', 'sdfasd', '2023-08-31', '', '06:04:04', 'pending', NULL, '2023-09-01 03:44:19', '', 2, 4, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(44, 'cvxvx', b'1', '', NULL, 'fsfsf', '4:1:2', '10:06:06', 'cvcvvc', '2023-09-01', 'dfdfd', '06:05:04', 'pending', NULL, '2023-09-05 09:36:30', '', 2, 4, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(45, 'cvxvxbbn', b'0', '', '2023-09-01 10:55:27', '', '4:1:2', '09:06:06', 'cvcvvc', '2023-09-01', '', '05:05:04', 'follow', NULL, '2023-09-01 10:55:27', '', 2, 4, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(46, 'sdf', b'1', NULL, '2023-09-02 11:24:00', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-02 11:32:16', 'sdfsdfsd', 2, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(47, 'sdf', b'1', NULL, '2023-09-02 14:31:00', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-02 15:25:01', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(48, 'sdf', b'0', NULL, '2023-09-03 15:55:35', '', '23:59:58', '18:55:03', 'sdfsd', '2023-08-26', '', '18:55:05', 'done', NULL, '2023-09-05 09:43:44', 'sdfsdfsd', 2, 4, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(49, 'sdf', b'1', NULL, '2023-09-03 17:06:53', 'sdfasdf', '23:59:58', '18:55:03', 'sdfsd', '2023-08-26', '', '18:55:05', 'pending', NULL, '2023-09-05 10:35:40', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(50, 'sdf', b'1', NULL, '2023-09-03 19:13:43', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-03 19:14:45', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(51, 'sdf', b'1', NULL, '2023-09-03 19:23:28', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-03 19:23:28', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(52, 'sdf', b'1', NULL, '2023-09-03 19:26:11', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-03 19:26:11', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(53, 'sdf', b'1', NULL, '2023-09-03 19:28:08', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-03 19:28:08', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(54, 'sdf', b'1', NULL, '2023-09-03 19:42:49', 'sdfasdf', '23:59:58', '16:55:03', 'sdfsd', '2023-08-26', '', '16:55:05', 'done', NULL, '2023-09-05 13:38:19', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(55, 'sdf', b'1', NULL, '2023-09-03 19:45:47', 'sdfasdf', '23:59:58', '16:55:03', 'sdfsd', '2023-08-26', '', '16:55:05', 'done', NULL, '2023-09-05 13:31:42', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(56, 'sdf', b'1', NULL, '2023-09-03 19:55:04', 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, '2023-09-03 19:55:04', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(58, 'sdf', b'1', NULL, '2023-09-04 08:57:01', 'sdfasdf', '23:59:58', '18:55:03', 'sdfsd', '2023-08-26', '', '18:55:05', 'pending', NULL, '2023-09-06 11:13:12', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(59, 'sdf', b'1', NULL, '2023-09-04 09:48:24', 'sdfasdf', '23:59:58', '16:55:03', 'sdfsd', '2023-08-26', '', '16:55:05', 'done', NULL, '2023-09-05 13:27:05', 'sdfsdfsd', 1, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(60, 'sdf', b'0', NULL, '2023-09-04 10:13:53', 'sdfasdf', '23:59:58', '18:55:03', 'sdfsd', '2023-08-26', '', '18:55:05', 'done', NULL, '2023-09-05 09:51:18', 'sdfsdfsd', 1, 3, NULL, NULL, NULL, 0, NULL, NULL, NULL),
(63, 'sdf', b'1', NULL, NULL, 'sdfasdf', '23:59:58', '14:55:03', 'sdfsd', '2023-08-26', '', '14:55:05', 'follow', NULL, NULL, 'sdfsdfsd', 1, 1, '3', '3', '2023-09-18 07:36:35', 0, '2023-09-18 07:36:35', NULL, NULL),
(64, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:36', 0, '2023-10-14 20:17:36', 'manager', NULL),
(65, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:38', 0, '2023-10-14 20:17:38', 'manager', NULL),
(66, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:43', 0, '2023-10-14 20:17:43', 'manager', NULL),
(67, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:45', 0, '2023-10-14 20:17:45', 'manager', NULL),
(68, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:47', 0, '2023-10-14 20:17:47', 'manager', NULL),
(69, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:49', 0, '2023-10-14 20:17:49', 'manager', NULL),
(70, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:51', 0, '2023-10-14 20:17:51', 'manager', NULL),
(71, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:53', 0, '2023-10-14 20:17:53', 'manager', NULL),
(72, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:55', 0, '2023-10-14 20:17:55', 'manager', NULL),
(73, 'jksdkfh', b'1', NULL, NULL, 'dsf', '0:0:3', '11:22:25', 'sdkjafhkh', '2023-10-14', '', '11:22:22', 'done', NULL, NULL, 'hdjshg', 1, 1, '3', '3', '2023-10-14 20:17:58', 0, '2023-10-14 20:17:58', 'manager', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permission`
--

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `permission_key` varchar(255) DEFAULT NULL,
  `permission_name` varchar(255) DEFAULT NULL,
  `created_by_username` varchar(255) DEFAULT NULL,
  `updated_by_username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `permission`
--

INSERT INTO `permission` (`id`, `created_at`, `created_by`, `deleted`, `updated_at`, `updated_by`, `permission_key`, `permission_name`, `created_by_username`, `updated_by_username`) VALUES
(1, NULL, NULL, 0, NULL, NULL, 'USER_DELETE', 'USER_DELETE', NULL, NULL),
(2, NULL, NULL, 0, NULL, NULL, 'USER_READ', 'USER_READ', NULL, NULL),
(3, NULL, NULL, 0, NULL, NULL, 'USER_UPDATE', 'USER_UPDATE', NULL, NULL),
(4, NULL, NULL, 0, NULL, NULL, 'USER_CREATE', 'USER_CREATE', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `product_code` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `role_key` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`id`, `created_at`, `created_by`, `deleted`, `updated_at`, `updated_by`, `role_key`, `role_name`) VALUES
(1, NULL, NULL, 0, NULL, NULL, 'ROLE_ADMIN', 'quản trị viên'),
(2, NULL, NULL, 0, NULL, NULL, 'ROLE_CUSTOMER', 'khách hàng'),
(3, NULL, NULL, 0, NULL, NULL, 'ROLE_MANAGER', 'quản lý'),
(4, NULL, NULL, 0, NULL, NULL, 'ROLE_EMPLOYEE', 'Nhân viên');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_permission`
--

CREATE TABLE `role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role_permission`
--

INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 2),
(3, 1),
(3, 2),
(3, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `spare_part`
--

CREATE TABLE `spare_part` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `in_stock` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `spare_part`
--

INSERT INTO `spare_part` (`id`, `code`, `name`, `price`, `in_stock`, `image_url`) VALUES
(1, 'sdf', 'sdf', 435345, NULL, NULL),
(2, 'trr', 'ewe', 453, NULL, NULL),
(3, '1223234', 'fsdfsa', 21151, NULL, NULL),
(4, '1223234', 'fsdfsa', 21151, NULL, NULL),
(5, 'sadf', 'sdfs', 54, NULL, NULL),
(6, 'sadfsadf', 'sdfs3', 54121, NULL, NULL),
(7, 'sf', 'sdf2', 3422, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `token`
--

CREATE TABLE `token` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `token` varchar(1000) DEFAULT NULL,
  `token_exp_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `token`
--

INSERT INTO `token` (`id`, `created_at`, `created_by`, `deleted`, `updated_at`, `updated_by`, `token`, `token_exp_date`) VALUES
(1, '2023-08-21 21:59:44', 1, 0, '2023-08-21 21:59:44', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM0OTM5ODQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkMGlIZ2ZnUXcwbEFKQ0RFRE9ZaUZLdXJJXC84TXkxamZ0V1RrSWs2WmNJYWFDVTkxY2lxTnhlIiwidXNlcklkIjoxLCJhdXRob3JpdGllcyI6W10sInVzZXJuYW1lIjoidG9hbiJ9fQ.3G4fXnTmzbPh0G2zpHpNLj1ngUU_o-vTyz1axWf8Wn0', '2023-08-31 21:59:44'),
(2, '2023-08-21 22:02:26', 1, 0, '2023-08-21 22:02:26', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM0OTQxNDYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkMGlIZ2ZnUXcwbEFKQ0RFRE9ZaUZLdXJJXC84TXkxamZ0V1RrSWs2WmNJYWFDVTkxY2lxTnhlIiwidXNlcklkIjoxLCJhdXRob3JpdGllcyI6W10sInVzZXJuYW1lIjoidG9hbiJ9fQ.lI_inxpALg27E4BIOuQAUAsK3S3kRkAYjK2fq737rx4', '2023-08-31 22:02:26'),
(3, '2023-10-16 07:10:41', NULL, 0, '2023-10-16 07:10:41', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTgyNzkwNDEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.A_RPLLquRfy0AIs5lnltXLU62QuNfnOdf3XXV5d8SZI', '2023-10-26 07:10:41'),
(4, '2023-08-22 21:55:20', 2, 0, '2023-08-22 21:55:20', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODAxMjAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.Q5z47fWfgL6T3xwbVDMarWmsq2NgTzFv0CPt-zK9ZJU', '2023-09-01 21:55:20'),
(5, '2023-08-22 21:56:53', 2, 0, '2023-08-22 21:56:53', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODAyMTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.dOjaDOmYc8FC2dGq1vdcOEAomVoEt4OkrOnFOtdIvo0', '2023-09-01 21:56:54'),
(6, '2023-08-22 21:58:20', 2, 0, '2023-08-22 21:58:20', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODAzMDAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.K3YejyVBj4UMe2eYo0GhdG6StteW9sXUocUNbBUmWzM', '2023-09-01 21:58:20'),
(7, '2023-08-22 21:58:35', 4, 0, '2023-08-22 21:58:35', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODAzMTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkdU5nRm4yM3VReXNVZUJLdUJNTkRRLnpBckVoOFBlY1R3R25UMkRHTWhpM0xLdFA2RW9BSG0iLCJ1c2VySWQiOjQsImF1dGhvcml0aWVzIjpbIkNVU1RPTUVSIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoiY3VzdG9tZXIifX0._67GkjVNNmAnbWhmnLuVO8HX0WPAXnqWPzmJ8VYQmvE', '2023-09-01 21:58:35'),
(8, '2023-08-22 21:58:44', 3, 0, '2023-08-22 21:58:44', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODAzMjQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.9TTSTSJcTfbARI13NnXx22VXZjtC_TKj7i81kAMBtrk', '2023-09-01 21:58:44'),
(9, '2023-08-22 22:03:46', 1, 0, '2023-08-22 22:03:46', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA2MjYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkMGlIZ2ZnUXcwbEFKQ0RFRE9ZaUZLdXJJXC84TXkxamZ0V1RrSWs2WmNJYWFDVTkxY2lxTnhlIiwidXNlcklkIjoxLCJhdXRob3JpdGllcyI6WyJDVVNUT01FUiIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6InRvYW4ifX0.-nbdO10cWB3BMRS5Jq2ub3ki0eOrrI5wbfVcV16yW4c', '2023-09-01 22:03:46'),
(10, '2023-08-22 22:05:03', 3, 0, '2023-08-22 22:05:03', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA3MDMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.Why46eaNjvnTEJVbuswguRY2KErBIsB_bhMSdg-Z_rA', '2023-09-01 22:05:03'),
(11, '2023-08-22 22:06:43', 2, 0, '2023-08-22 22:06:43', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA4MDMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.Ve-TstAASLDwyIV2X9vZ7IX0a9fQ9-Arbi3y9eqiS8c', '2023-09-01 22:06:43'),
(12, '2023-08-22 22:08:03', 2, 0, '2023-08-22 22:08:03', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA4ODMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.4ZnCVX-31LimgzcT5hN8IFA6hXdZe-K6ZQbP4pT7rTo', '2023-09-01 22:08:03'),
(13, '2023-08-22 22:08:34', 2, 0, '2023-08-22 22:08:34', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA5MTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.mA3cdC5WTg0EdAcV0CiPNlQalqEAYeOWv_syQUNHo8c', '2023-09-01 22:08:34'),
(14, '2023-08-22 22:08:36', 2, 0, '2023-08-22 22:08:36', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA5MTYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.yvu7bZMxzRoHLd75ZyiTfDHIdifhouu5CjJE7Pieh-I', '2023-09-01 22:08:36'),
(15, '2023-08-22 22:08:37', 2, 0, '2023-08-22 22:08:37', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM1ODA5MTcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.smtuV5mppykYHWBy3C-ocep8MUrARA-5Ebtl-o28kgA', '2023-09-01 22:08:37'),
(16, '2023-08-24 10:18:03', 3, 0, '2023-08-24 10:18:03', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTEwODMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.jtGphqfpJj57rphkMaN6QCIRmklpT9SeqsXijPxmo-Y', '2023-09-03 10:18:04'),
(17, '2023-08-24 10:19:42', 3, 0, '2023-08-24 10:19:42', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTExODIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0._Uu--lrGE36mikGee3R3kSyw1FSNms8dY28W6_wbPG0', '2023-09-03 10:19:42'),
(18, '2023-08-24 10:20:31', 3, 0, '2023-08-24 10:20:31', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTEyMzEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.hWw6AingLHPiWjmY0ZBbXA5rqsG6dwNKYAD7kKpQ-M0', '2023-09-03 10:20:31'),
(19, '2023-08-24 10:24:14', 2, 0, '2023-08-24 10:24:14', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTE0NTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.RwKGWv9IaPecOn6QM8VcAXA0wapB0buUxcdWcD2r1cg', '2023-09-03 10:24:14'),
(20, '2023-08-24 10:36:02', 2, 0, '2023-08-24 10:36:02', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTIxNjIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.mXQDEF4b-2xHEtFa0v4BMWc554CEgLrVNLlu23dlP9c', '2023-09-03 10:36:02'),
(21, '2023-08-24 11:09:29', 2, 0, '2023-08-24 11:09:29', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTQxNjksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.EqWHf3ztarw7n8aJg6q-mxJEaU7JBPxhOWh-TTwOBWI', '2023-09-03 11:09:30'),
(22, '2023-08-24 11:10:35', 2, 0, '2023-08-24 11:10:35', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTQyMzUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ._841qX-cCLCKjHRJizJCQvr4DhMmh48-Gr6_oht_1-Y', '2023-09-03 11:10:35'),
(23, '2023-08-24 11:23:41', 2, 0, '2023-08-24 11:23:41', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTUwMjEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.sjPWruPYmKQRdB-nc4ujypccTY13p56Apr45bq5aLAM', '2023-09-03 11:23:41'),
(24, '2023-08-24 11:24:52', 2, 0, '2023-08-24 11:24:52', NULL, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTM3MTUwOTIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.xzs-tf-O35eAPk_JLoFGyR12llOuZdgb8nGhJEaajV4', '2023-09-03 11:24:52'),
(25, '2023-09-11 07:52:54', 0, 0, '2023-09-11 07:52:54', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTc1NzQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkYllpYklTT0NxYzFiTVZlRzQzZ0ROT1wvMW5nSGoyOGtGQmt6a2xhaEh1MklUekRYOG1UXC9CYSIsInVzZXJJZCI6NiwiYXV0aG9yaXRpZXMiOltdLCJ1c2VybmFtZSI6InRvYW5iZW5jYXQyIn19.xxVUhZjmc_1Wk36lpzoqEXEoR6z79B6c1LDBa54bZNk', '2023-09-21 07:52:54'),
(26, '2023-09-11 07:53:56', 0, 0, '2023-09-11 07:53:56', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTc2MzYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.E5KVKdl-oIrb9AQDpIcKmTL--40UX34NaHWqDH-lhhQ', '2023-09-21 07:53:56'),
(27, '2023-09-11 08:05:24', 0, 0, '2023-09-11 08:05:24', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTgzMjQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.2pxpUtEGqq1RidaBXN7FQcGadjVDjGuy90u_tzDgsOo', '2023-09-21 08:05:24'),
(28, '2023-09-11 08:13:26', 0, 0, '2023-09-11 08:13:26', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTg4MDUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.yXDqk91YFQp061X_Kan3dsJ_7p9-0FAXkE8y137UCQ0', '2023-09-21 08:13:26'),
(29, '2023-09-11 08:16:50', 0, 0, '2023-09-11 08:16:50', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTkwMDksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.5LDqBFHB6XR0AEiN6x9I3H5NYWunE-Y-iAxm-wN4lgQ', '2023-09-21 08:16:50'),
(30, '2023-09-11 08:16:51', 0, 0, '2023-09-11 08:16:51', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTkwMTEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.4fp-Srmhn-Y2lOC429fxM-O71BVxbxv0la1Fb9n5yzQ', '2023-09-21 08:16:51'),
(31, '2023-09-11 08:16:56', 0, 0, '2023-09-11 08:16:56', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTkwMTYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.hjOHBiRcFBNiSbS-4J48mu5CR3cKqyZ6F7BgZaDuoq4', '2023-09-21 08:16:56'),
(32, '2023-09-11 08:17:25', 0, 0, '2023-09-11 08:17:25', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTkwNDUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.3HOVsFzLLE5QnH0KEc1H6HOHt30LHu0nEjVAiRB2d5c', '2023-09-21 08:17:25'),
(33, '2023-09-11 08:18:08', 0, 0, '2023-09-11 08:18:08', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTkwODgsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.N9hBZMP3wPyvoK9bltTZ6Xz-6cVO1VLFgt53XXAJPzw', '2023-09-21 08:18:08'),
(34, '2023-09-11 08:23:55', 0, 0, '2023-09-11 08:23:55', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTk0MzUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.gLpiE8tIVr6Q69G-2zgs4kkAq9l6qtGkq4GlruvQh4M', '2023-09-21 08:23:55'),
(35, '2023-09-11 08:24:13', 0, 0, '2023-09-11 08:24:13', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTk0NTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.3aL6R7N95fM-ogg85q7MIn7MDuifUfFyDc2pbIqADc0', '2023-09-21 08:24:13'),
(36, '2023-09-11 08:25:05', 0, 0, '2023-09-11 08:25:05', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTk1MDQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.1ADrGTLep9HBnai5NLZmLYqYELmW1xMGBkibMWrJTL8', '2023-09-21 08:25:04'),
(37, '2023-09-11 08:30:56', 0, 0, '2023-09-11 08:30:56', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTk4NTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.3ZZoiEI4lgXfF-nfjbgHUSP5GclcY48nySzLbC73zUA', '2023-09-21 08:30:55'),
(38, '2023-09-11 08:32:34', 0, 0, '2023-09-11 08:32:34', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNTk5NTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.dVdmFwqBtrJ-VjD-DAKRzYo1glK-mfOt2EdYPCQUX_8', '2023-09-21 08:32:34'),
(39, '2023-09-11 08:45:20', 0, 0, '2023-09-11 08:45:20', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNjA3MTksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.i8rmv2LUqW8OQHWxYswU7JNZLRtkgGs8bqaprxhAjfo', '2023-09-21 08:45:20'),
(40, '2023-09-11 11:34:16', 0, 0, '2023-09-11 11:34:16', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzA4NTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.mjcMHTYKeTgePJim-XsDiWYeUQzQr1h4tajffb1TIE0', '2023-09-21 11:34:16'),
(41, '2023-09-11 11:34:16', 0, 0, '2023-09-11 11:34:16', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzA4NTYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.TrpDNzRj1bgRNU-kNTOKwjOzhvjJXLNc4yQ41uyP5QI', '2023-09-21 11:34:16'),
(42, '2023-09-11 12:17:29', 0, 0, '2023-09-11 12:17:29', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzM0NDksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.6Bahx6R74lBRvjJGdsBxdMSqlbANG3J_Nm_-TCocqqg', '2023-09-21 12:17:29'),
(43, '2023-09-11 12:17:36', 0, 0, '2023-09-11 12:17:36', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzM0NTYsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.4uF6WTg8aD_XHc4iwR04sXc_q7_z5ddU5e4Co_ljbhc', '2023-09-21 12:17:36'),
(44, '2023-09-11 12:35:45', 3, 0, '2023-09-11 12:35:45', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzQ1NDQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.M7ZvZ17sP7Fy5Ce4KySsklQ8tX9JWy9sdvn9lyI-zRU', '2023-09-21 12:35:44'),
(45, '2023-09-11 12:37:15', 3, 0, '2023-09-11 12:37:15', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzQ2MzQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiQURNSU4iLCJVU0VSX1JFQUQiXSwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.-g-QbYvmUt3JPiK2meIWG5gqLCUmSxw3N1R-qwKFDdI', '2023-09-21 12:37:14'),
(46, '2023-09-11 12:52:44', 0, 0, '2023-09-11 12:52:44', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzU1NjMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.ciZLPHxowiOLVzPT2XbyK_MOmsWZS5HMQJ_0YE8vnZA', '2023-09-21 12:52:43'),
(47, '2023-09-11 12:53:33', 0, 0, '2023-09-11 12:53:33', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzU2MTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.xAHFUksVicAoTQmdxfTMI7o7c1AuedfNGXPSqudufvg', '2023-09-21 12:53:33'),
(48, '2023-09-11 12:56:44', 3, 0, '2023-09-11 12:56:44', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzU4MDQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9VUERBVEUiLCJVU0VSX0NSRUFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.zTg3BGyO7Bg39vMysWoD2Gw7lwuq06elW1mPKeoEO4M', '2023-09-21 12:56:44'),
(49, '2023-09-11 13:04:01', 0, 0, '2023-09-11 13:04:01', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzYyNDEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.qCcz92_byTvtPTWZtM-KkAOiLiEqIgu5kyEpkLw8r-w', '2023-09-21 13:04:01'),
(50, '2023-09-11 13:18:50', 0, 0, '2023-09-11 13:18:50', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzcxMjksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.XMRZWJyyyw8B7NT0k6xOdGsynukMitCwKC5JX0JDv4g', '2023-09-21 13:18:50'),
(51, '2023-09-11 13:21:00', 0, 0, '2023-09-11 13:21:00', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUyNzcyNjAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJNQU5BR0VSIiwiVVNFUl9DUkVBVEUiLCJVU0VSX1VQREFURSIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6Im1hbmFnZXIifX0.617JbdG8ayxSNYUT4Pm1cztWL-p0K0LAd9ie6B_3GMo', '2023-09-21 13:21:00'),
(52, '2023-09-12 12:58:47', 0, 0, '2023-09-12 12:58:47', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUzNjIzMjcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.KRRH_s5ATie9N5m20vowZPJnNOyZW3uaVDd5uBSnkyg', '2023-09-22 12:58:47'),
(53, '2023-09-12 13:06:35', 0, 0, '2023-09-12 13:06:35', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUzNjI3OTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.aRwgG2GZ-Kc-jH94Vn_5CtkPYT96YaFxPCJMtP_a43Q', '2023-09-22 13:06:35'),
(54, '2023-09-12 13:19:58', 0, 0, '2023-09-12 13:19:58', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUzNjM1OTcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.Cv16DriravPClUZ71rQl_cpe9ugksFZtO7j8HQtHllA', '2023-09-22 13:19:57'),
(55, '2023-09-12 13:56:31', 0, 0, '2023-09-12 13:56:31', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUzNjU3OTEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.rxwmfCp82sbIiwzNIxzuEl4CijiW0vM5dD4WGC4MOtg', '2023-09-22 13:56:31'),
(56, '2023-09-12 13:57:15', 0, 0, '2023-09-12 13:57:15', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTUzNjU4MzUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.qysuEcKHFBaKRcK-KPJDGwy0FeqFlwO5e9_tyAw1Y94', '2023-09-22 13:57:15'),
(57, '2023-09-13 09:59:58', 0, 0, '2023-09-13 09:59:58', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0Mzc5OTgsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.Y3J5eBc0_NIF4RCOXn_j-YDCr9ZgVojVPe_Pr-fjAUo', '2023-09-23 09:59:58'),
(58, '2023-09-13 10:00:00', 0, 0, '2023-09-13 10:00:00', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0MzgwMDAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.j07jefNLcKHlzXd9sP6f5nQagA8l2vqK8nfBM9aGjMw', '2023-09-23 10:00:00'),
(59, '2023-09-13 10:00:35', 0, 0, '2023-09-13 10:00:35', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0MzgwMzUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.hHqbS8TTdiikoqOqFONMfLFpDWueZlawU8SWCesIxBA', '2023-09-23 10:00:35'),
(60, '2023-09-13 10:00:37', 0, 0, '2023-09-13 10:00:37', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0MzgwMzcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.TnNDcL8zPJnY_Q6pm1Dj1eKkyilTGcdSKruLGMpaOf4', '2023-09-23 10:00:37'),
(61, '2023-09-13 16:14:37', 0, 0, '2023-09-13 16:14:37', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjA0NzcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.tRENCNdo2e2ALgu6M8ky3y_dQP3C0uFvxUpB8gsMOj4', '2023-09-23 16:14:37'),
(62, '2023-09-13 16:15:39', 0, 0, '2023-09-13 16:15:39', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjA1MzksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiUk9MRV9BRE1JTiIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6ImFkbWluIn19.5jcdONYMFcVfurwyp-p3XlxChe9Qo00XjIi7uvmTCcE', '2023-09-23 16:15:39'),
(63, '2023-09-13 16:15:47', 0, 0, '2023-09-13 16:15:47', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjA1NDcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.TS4KATIrFDsKwjKUAZ_i3H1Oqbp26F44n0totHyAaVQ', '2023-09-23 16:15:47'),
(64, '2023-09-13 16:17:01', 0, 0, '2023-09-13 16:17:01', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjA2MjEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.ucRWCDE8GWSG2UbreM5zPWuAO2eeblss4hnWTbjwvUY', '2023-09-23 16:17:01'),
(65, '2023-09-13 16:17:22', 0, 0, '2023-09-13 16:17:22', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjA2NDIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.scz8G1Y_XKCoi0vAWUVQNhVXfDIEMztzih6xsy9axno', '2023-09-23 16:17:22'),
(66, '2023-09-13 16:20:18', 0, 0, '2023-09-13 16:20:18', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjA4MTgsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.qVvwyte2IEhY93mwuD9myUaCh2nYM4puwQIXH-HLPRA', '2023-09-23 16:20:18'),
(67, '2023-09-13 16:32:18', 0, 0, '2023-09-13 16:32:18', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE1MzgsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.z_UjnZgud1iLNeqs4-226kKa52z1wgQCZW6dj-mD18c', '2023-09-23 16:32:18'),
(68, '2023-09-13 16:32:19', 0, 0, '2023-09-13 16:32:19', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE1MzksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.g3dK9Coc5oPv25qzEDs0p3zJHvb96-XyGiyXrhvpr2U', '2023-09-23 16:32:19'),
(69, '2023-09-13 16:32:21', 0, 0, '2023-09-13 16:32:21', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE1NDEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.OS0Vrh21EZFv6Z1mkjFRN9hy2I5Fhf32U2ZfQgU8Azg', '2023-09-23 16:32:21'),
(70, '2023-09-13 16:33:10', 0, 0, '2023-09-13 16:33:10', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE1OTAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.ixxq_AaUDVm6W3Qtjd8FbAxCUvcBW_Sc4QPBHiZZC5Y', '2023-09-23 16:33:10'),
(71, '2023-09-13 16:33:52', 0, 0, '2023-09-13 16:33:52', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE2MzIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.nPWK8T0QaAHh6PodHxlKAb7ySWO2HLq3auPVEVdK0TQ', '2023-09-23 16:33:52'),
(72, '2023-09-13 16:35:44', 0, 0, '2023-09-13 16:35:44', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE3NDQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.nS8xoKLiE7gpfmzilEVZJODq38VOl50r4v3eKEbQZME', '2023-09-23 16:35:44'),
(73, '2023-09-13 16:36:11', 0, 0, '2023-09-13 16:36:11', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE3NzEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.CO9SSr2u4UX6LfVDZHX95K0i93wbq7I5ulElAL3Rdk8', '2023-09-23 16:36:11'),
(74, '2023-09-13 16:36:12', 0, 0, '2023-09-13 16:36:12', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE3NzIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.n0x8Pqcb5L8Dzfzq_egjZXXaEH_73JanldjLDpjNUlU', '2023-09-23 16:36:12'),
(75, '2023-09-13 16:36:29', 3, 0, '2023-09-13 16:36:29', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE3ODksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.rEQaYSfcAtjXP8WdEIdjSoO7s6AZ7E39_wwqxoGVzCo', '2023-09-23 16:36:29'),
(76, '2023-09-13 16:36:34', 3, 0, '2023-09-13 16:36:34', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE3OTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.lCRFeFW0koexM_N7d3166U4tp-yfR2LlMy5tWKmSBNQ', '2023-09-23 16:36:34'),
(77, '2023-09-13 16:37:49', 0, 0, '2023-09-13 16:37:49', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE4NjksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.uSAMqOxXkuxQZ91PVd2xOxzqir4rCwIgiY5zrCRHzTw', '2023-09-23 16:37:49'),
(78, '2023-09-13 16:38:45', 0, 0, '2023-09-13 16:38:45', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU0NjE5MjUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.V0EURmys-KEpBhqKjQiugLRb9DjWdPOGlAhl-WpvdJY', '2023-09-23 16:38:45'),
(79, '2023-09-14 13:15:54', 0, 0, '2023-09-14 13:15:54', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU1MzYxNTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.7S_eYnofJsiYTjGOadf5sqAYdoNeHaogEZKXtzw55WA', '2023-09-24 13:15:53'),
(80, '2023-09-14 13:37:27', 3, 0, '2023-09-14 13:37:27', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU1Mzc0NDcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiUk9MRV9BRE1JTiIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6ImFkbWluIn19.Q9CQCJB0-Twv_2q_wGrIRieItCQv98Ttfbm8XPeOalw', '2023-09-24 13:37:27'),
(81, '2023-09-14 13:37:47', 2, 0, '2023-09-14 13:37:47', 2, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU1Mzc0NjcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.uM68TCjuLTnI6N-n70HBORaUezhyUBs3RUNKf6U-oUg', '2023-09-24 13:37:47'),
(82, '2023-09-15 15:12:29', 0, 0, '2023-09-15 15:12:29', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU2Mjk1NDcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.p8x8KpuFfOkyJrh6yMoXj7Hn8CKGh6n4q6etJ8yPnfc', '2023-09-25 15:12:29'),
(83, '2023-09-15 15:12:30', 0, 0, '2023-09-15 15:12:30', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU2Mjk1NTAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.2fZTxfXguC6JDhjchb_VEmd1zC2cyJBbwdi6LR32p34', '2023-09-25 15:12:30'),
(84, '2023-09-15 15:59:03', 3, 0, '2023-09-15 15:59:03', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU2MzIzNDMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.DGFlj1rV7UQIiV96Pg-E2aPHjNNKVLJbqE7sym1tUAU', '2023-09-25 15:59:03'),
(85, '2023-09-18 06:57:11', 0, 0, '2023-09-18 06:57:11', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU4NTkwMzAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX1VQREFURSIsIlVTRVJfQ1JFQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.DZBhzYOzGDY8eym9KMRw_tAPpu5RErpBJt1Z_R6Hm7w', '2023-09-28 06:57:11'),
(86, '2023-09-18 07:35:54', 0, 0, '2023-09-18 07:35:54', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU4NjEzNTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcFpGb3QyMTM0TWNHQzBcL05kSkJDXC9lUFZnc1YyUXRVYVVTUFM5QXZvYTVwU21jYVZsSHIzVyIsInVzZXJJZCI6MywiYXV0aG9yaXRpZXMiOlsiVVNFUl9ERUxFVEUiLCJST0xFX01BTkFHRVIiLCJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiVVNFUl9SRUFEIl0sInVzZXJuYW1lIjoibWFuYWdlciJ9fQ.KdyVQX0NSNIyuPZ-G0atpjwvZ7Ty25FhGzeT4tQcxp0', '2023-09-28 07:35:54'),
(87, '2023-09-18 07:37:51', 3, 0, '2023-09-18 07:37:51', 3, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU4NjE0NzEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkbXp1cGhuNXNZS2lqRVl2SFZXeDZKZTM1XC9jdjlyWjV3RnRSTmtSWEg4MWRHQlRlcEtMdUcuIiwidXNlcklkIjoyLCJhdXRob3JpdGllcyI6WyJVU0VSX0NSRUFURSIsIlVTRVJfVVBEQVRFIiwiUk9MRV9BRE1JTiIsIlVTRVJfUkVBRCJdLCJ1c2VybmFtZSI6ImFkbWluIn19.yIbQFy6RUdxzNJ8uz-3p9K-vo1VYoWF9gMIkcwsYOXw', '2023-09-28 07:37:51'),
(88, '2023-09-18 08:13:23', 0, 0, '2023-09-18 08:13:23', 0, 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTU4NjM2MDMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcC5Wbi51SDJlTjNRODlWMERwUzRkZWtwakc0SkFSTExEY0xlU1RyazFkeEs0aE12OHNOWVciLCJ1c2VySWQiOjcsImF1dGhvcml0aWVzIjpbXSwidXNlcm5hbWUiOiJuZXdtYW4ifX0.f5ivyEgxB8kW3p3S1HnBwnINrh7VmaxU3KJ33RhnIMs', '2023-09-28 08:13:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `created_at`, `created_by`, `deleted`, `updated_at`, `updated_by`, `password`, `username`) VALUES
(1, '2023-08-21 21:59:40', NULL, 0, '2023-08-21 21:59:40', NULL, '$2a$10$0iHgfgQw0lAJCDEDOYiFKurI/8My1jftWTkIk6ZcIaaCU91ciqNxe', 'toan'),
(2, '2023-08-22 21:49:07', NULL, 0, '2023-08-22 21:49:07', NULL, '$2a$10$mzuphn5sYKijEYvHVWx6Je35/cv9rZ5wFtRNkRXH81dGBTepKLuG.', 'admin'),
(3, '2023-08-22 21:49:16', NULL, 0, '2023-08-22 21:49:16', NULL, '$2a$10$pZFot2134McGC0/NdJBC/ePVgsV2QtUaUSPS9Avoa5pSmcaVlHr3W', 'manager'),
(4, '2023-08-22 21:49:36', NULL, 0, '2023-08-22 21:49:36', NULL, '$2a$10$uNgFn23uQysUeBKuBMNDQ.zArEh8PecTwGnT2DGMhi3LKtP6EoAHm', 'customer'),
(6, '2023-09-11 07:52:51', 0, 0, '2023-09-11 07:52:51', 0, '$2a$10$bYibISOCqc1bMVeG43gDNO/1ngHj28kFBkzklahHu2ITzDX8mT/Ba', 'toanbencat2'),
(7, '2023-09-18 06:58:44', 3, 0, '2023-09-18 06:58:44', 3, '$2a$10$p.Vn.uH2eN3Q89V0DpS4dekpjG4JARLLDcLeSTrk1dxK4hMv8sNYW', 'newman');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_role`
--

CREATE TABLE `user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 2);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `changed_part`
--
ALTER TABLE `changed_part`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKl8id3vwyun3r3hlchjxs8fa3c` (`issue_id`);

--
-- Chỉ mục cho bảng `component`
--
ALTER TABLE `component`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_24wq1y3l3mfjohvgtsewd3vo` (`code`),
  ADD UNIQUE KEY `UK_qkg4faf5v8maop4avw1y44cxp` (`name`);

--
-- Chỉ mục cho bảng `component_equipment`
--
ALTER TABLE `component_equipment`
  ADD PRIMARY KEY (`component_id`,`equipment_id`),
  ADD KEY `FKqfip17qhuwkjx71q0sly4xb0x` (`equipment_id`);

--
-- Chỉ mục cho bảng `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_q8ymhgj6pt1msox0o3bg51uvo` (`code`);

--
-- Chỉ mục cho bảng `department_error`
--
ALTER TABLE `department_error`
  ADD PRIMARY KEY (`department_id`,`error_id`),
  ADD KEY `FKd38n1w5xf4snl0iyvecvbxoad` (`error_id`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_nbyivu8qgmx0r7wtbplf01gf8` (`code`),
  ADD UNIQUE KEY `UK_fopic1oh5oln2khj8eat6ino0` (`email`),
  ADD UNIQUE KEY `UK_buf2qp04xpwfp5qq355706h4a` (`phone`),
  ADD KEY `FK6lk0xml9r7okjdq0onka4ytju` (`user_id`);

--
-- Chỉ mục cho bảng `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_cbhui2xihg5khndr1ljt9sjqg` (`code`),
  ADD UNIQUE KEY `UK_m6whtgwe6ya84f59coio1j1wh` (`name`),
  ADD KEY `FKdaa1vqflnntgppniar3ga738m` (`department_id`),
  ADD KEY `FKde1wpiwx7276lnm3xjo5g80sh` (`owner_id`);

--
-- Chỉ mục cho bảng `error`
--
ALTER TABLE `error`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_oqdy2q90nwts0cs1da6bpb3nx` (`name`);

--
-- Chỉ mục cho bảng `issue`
--
ALTER TABLE `issue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK9fhb2xwi7m3oemu43l0emh0bn` (`department_id`),
  ADD KEY `FKe6g1wipd695wglx00xvce770o` (`equipment_id`);

--
-- Chỉ mục cho bảng `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_922x4t23nx64422orei4meb2y` (`product_code`),
  ADD UNIQUE KEY `UK_f55t6sm19p5lrihq24a6knota` (`product_name`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `FKf8yllw1ecvwqy3ehyxawqa1qp` (`permission_id`);

--
-- Chỉ mục cho bảng `spare_part`
--
ALTER TABLE `spare_part`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_sb8bbouer5wak8vyiiy4pf2bx` (`username`);

--
-- Chỉ mục cho bảng `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKa68196081fvovjhkek5m97n3y` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `changed_part`
--
ALTER TABLE `changed_part`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT cho bảng `component`
--
ALTER TABLE `component`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `error`
--
ALTER TABLE `error`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `issue`
--
ALTER TABLE `issue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT cho bảng `permission`
--
ALTER TABLE `permission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `spare_part`
--
ALTER TABLE `spare_part`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `token`
--
ALTER TABLE `token`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `changed_part`
--
ALTER TABLE `changed_part`
  ADD CONSTRAINT `FKl8id3vwyun3r3hlchjxs8fa3c` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`);

--
-- Các ràng buộc cho bảng `component_equipment`
--
ALTER TABLE `component_equipment`
  ADD CONSTRAINT `FKfj39f2a5rn7uo443swh6y57y1` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`),
  ADD CONSTRAINT `FKqfip17qhuwkjx71q0sly4xb0x` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`);

--
-- Các ràng buộc cho bảng `department_error`
--
ALTER TABLE `department_error`
  ADD CONSTRAINT `FK2mwxmosaaf6wh01qutaje0yat` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `FKd38n1w5xf4snl0iyvecvbxoad` FOREIGN KEY (`error_id`) REFERENCES `error` (`id`);

--
-- Các ràng buộc cho bảng `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `FK6lk0xml9r7okjdq0onka4ytju` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `FKdaa1vqflnntgppniar3ga738m` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `FKde1wpiwx7276lnm3xjo5g80sh` FOREIGN KEY (`owner_id`) REFERENCES `employee` (`id`);

--
-- Các ràng buộc cho bảng `issue`
--
ALTER TABLE `issue`
  ADD CONSTRAINT `FK9fhb2xwi7m3oemu43l0emh0bn` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `FKe6g1wipd695wglx00xvce770o` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`);

--
-- Các ràng buộc cho bảng `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `FKa6jx8n8xkesmjmv6jqug6bg68` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `FKf8yllw1ecvwqy3ehyxawqa1qp` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`);

--
-- Các ràng buộc cho bảng `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `FK859n2jvi8ivhui0rl0esws6o` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FKa68196081fvovjhkek5m97n3y` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
