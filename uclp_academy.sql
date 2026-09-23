-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 23, 2026 at 06:05 AM
-- Server version: 10.3.39-MariaDB
-- PHP Version: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uclp_academy`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `activity` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_type` enum('admin','editor','doctor') DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `user_id`, `user_type`, `action`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:15:50'),
(2, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:38:08'),
(3, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:40:43'),
(4, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:43:05'),
(5, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:43:16'),
(6, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:43:30'),
(7, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 05:55:06'),
(8, 1, 'admin', 'Added Doctor', 'Added doctor: Desktop Checking (desktopchecking@uclp.edu)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 06:31:11'),
(9, 1, 'admin', 'Updated Doctor', 'Updated doctor ID: 3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 06:31:30'),
(10, 1, 'admin', 'Added Doctor', 'Added doctor: Desktop Checking 2345 (desktopchecking123@uclp.edu)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 06:43:55'),
(11, 1, 'admin', 'Doctor Verification', 'Verified doctor ID: 4, Status: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 06:44:07'),
(12, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 06:51:23'),
(13, 2, 'editor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 06:51:37'),
(14, 2, 'editor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:01:19'),
(15, 2, 'editor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:01:19'),
(16, 2, 'editor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:01:32'),
(17, 2, 'editor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:01:38'),
(18, 2, 'editor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:01:38'),
(19, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:03:07'),
(20, 4, 'doctor', 'Requested Supply', 'book_2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:22:33'),
(21, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:29:39'),
(22, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:29:39'),
(23, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:29:43'),
(24, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:30:45'),
(25, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:30:45'),
(26, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:30:50'),
(27, 1, 'admin', 'Processed Supply Request', 'Request ID: 1, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:30:59'),
(28, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:31:04'),
(29, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:31:04'),
(30, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:31:09'),
(31, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:35:59'),
(32, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:35:59'),
(33, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:36:06'),
(34, 1, 'admin', 'Updated Book', 'Updated book ID: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:36:27'),
(35, 1, 'admin', 'Updated Book', 'Updated book ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:36:39'),
(36, 1, 'admin', 'Updated Journal', 'Updated journal ID: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:36:59'),
(37, 1, 'admin', 'Updated Journal', 'Updated journal ID: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:11'),
(38, 1, 'admin', 'Updated Journal Status', 'Journal ID: 1, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:16'),
(39, 1, 'admin', 'Updated Journal', 'Updated journal ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:23'),
(40, 1, 'admin', 'Updated Journal Status', 'Journal ID: 2, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:26'),
(41, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:32'),
(42, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:32'),
(43, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:37:36'),
(44, 4, 'doctor', 'Download', 'Downloaded book: Neurology Essentials', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:38:33'),
(45, 4, 'doctor', 'Download', 'Downloaded book: Neurology Essentials', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 07:44:58'),
(46, 4, 'doctor', 'Requested Download Permission', 'book_2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:22:52'),
(47, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:26:49'),
(48, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:26:49'),
(49, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:26:57'),
(50, 1, 'admin', 'Processed Download Permission', 'Permission ID: 1, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:33:37'),
(51, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:34:12'),
(52, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:34:12'),
(53, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:34:16'),
(54, 4, 'doctor', 'Download', 'Downloaded book: Neurology Essentials', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:34:28'),
(55, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:38:35'),
(56, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:38:35'),
(57, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:38:40'),
(58, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:39:11'),
(59, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:39:11'),
(60, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:39:15'),
(61, 4, 'doctor', 'Requested Download Permission', 'journal_1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:44:42'),
(62, 4, 'doctor', 'Requested Download Permission', 'book_1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:45:00'),
(63, 4, 'doctor', 'Requested Download Permission (Renewal)', 'book_2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:48:45'),
(64, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:04'),
(65, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:04'),
(66, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:08'),
(67, 1, 'admin', 'Processed Download Permission', 'Permission ID: 4, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:19'),
(68, 1, 'admin', 'Processed Download Permission', 'Permission ID: 3, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:21'),
(69, 1, 'admin', 'Processed Download Permission', 'Permission ID: 2, Status: approved', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:24'),
(70, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:28'),
(71, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:28'),
(72, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:33'),
(73, 4, 'doctor', 'Download', 'Downloaded book: Textbook of Cardiology', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:41'),
(74, 4, 'doctor', 'Download', 'Downloaded book: Textbook of Cardiology', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:49:43'),
(75, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:53:16'),
(76, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:53:16'),
(77, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 08:53:31'),
(78, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:00:40'),
(79, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:00:40'),
(80, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:00:43'),
(81, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:04:20'),
(82, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:04:20'),
(83, 2, 'editor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:04:25'),
(84, 2, 'editor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:04:42'),
(85, 2, 'editor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:04:42'),
(86, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:04:47'),
(87, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:23:26'),
(88, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:23:26'),
(89, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:26:04'),
(90, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:26:15'),
(91, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:26:15'),
(92, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:26:21'),
(93, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:29:53'),
(94, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:29:53'),
(95, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:29:56'),
(96, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:32:09'),
(97, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:32:09'),
(98, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:32:13'),
(99, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:32:54'),
(100, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:32:54'),
(101, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:32:57'),
(102, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:33:03'),
(103, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:33:03'),
(104, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:56:52'),
(105, 1, 'admin', 'Doctor Verification', 'Verified doctor ID: 3, Status: 0', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:58:06'),
(106, 1, 'admin', 'Doctor Verification', 'Verified doctor ID: 3, Status: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:58:09'),
(107, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:59:50'),
(108, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:59:50'),
(109, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 09:59:56'),
(110, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 10:00:02'),
(111, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 10:00:02'),
(112, 4, 'doctor', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:44:33'),
(113, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:47:26'),
(114, 4, 'doctor', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:47:26'),
(115, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:47:31'),
(116, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:51:57'),
(117, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:51:57'),
(118, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:52:00'),
(119, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:52:36'),
(120, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:52:36'),
(121, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:52:38'),
(122, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:53:13'),
(123, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:53:13'),
(124, 1, 'admin', 'User Login', 'User logged in successfully', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:53:16'),
(125, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:55:40'),
(126, 1, 'admin', 'User Logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 11:55:40'),
(127, 1, 'admin', 'User Login', 'User logged in successfully', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 16:51:44'),
(128, 1, 'admin', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 16:58:59'),
(129, 1, 'admin', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 16:58:59'),
(130, 1, 'admin', 'User Login', 'User logged in successfully', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 16:59:07'),
(131, 1, 'admin', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:15:44'),
(132, 1, 'admin', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:15:44'),
(133, 2, 'editor', 'User Login', 'User logged in successfully', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:16:20'),
(134, 2, 'editor', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:31:35'),
(135, 2, 'editor', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:31:35'),
(136, 2, 'editor', 'User Login', 'User logged in successfully', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:31:39'),
(137, 2, 'editor', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:31:57'),
(138, 2, 'editor', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:31:57'),
(139, 4, 'doctor', 'User Login', 'User logged in successfully', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:32:31'),
(140, 4, 'doctor', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:33:07'),
(141, 4, 'doctor', 'User Logout', 'User logged out', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-13 17:33:07'),
(142, 1, 'admin', 'User Login', 'User logged in successfully', '118.179.27.143', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-15 06:39:30'),
(143, 1, 'admin', 'User Login', 'User logged in successfully', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-15 15:35:08'),
(144, 1, 'admin', 'Added Book', 'Added book: Test', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-15 15:38:10'),
(145, 1, 'admin', 'Updated Book Status', 'Book ID: 3, Status: approved', '103.155.98.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-15 15:38:15'),
(146, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:30:22'),
(147, 1, 'admin', 'Added Journal', 'Added journal: Test', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:34:11'),
(148, 1, 'admin', 'Updated Journal Status', 'Journal ID: 3, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:34:14'),
(149, 1, 'admin', 'Updated Journal Status', 'Journal ID: 3, Status: pending', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:34:16'),
(150, 1, 'admin', 'Updated Book', 'Updated book ID: 3', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:34:39'),
(151, 1, 'admin', 'Updated Journal Status', 'Journal ID: 3, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:34:47'),
(152, 1, 'admin', 'Updated Journal', 'Updated journal ID: 3', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:41:43'),
(153, 1, 'admin', 'Added Doctor', 'Added doctor: Testing Doctor (testingdoctor@ucpl.academy)', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:42:52'),
(154, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:43:19'),
(155, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:43:19'),
(156, 6, 'doctor', 'User Registration', 'New doctor registered', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:44:25'),
(157, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:44:42'),
(158, 1, 'admin', 'Doctor Verification', 'Verified doctor ID: 6, Status: 1', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:44:51'),
(159, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:44:52'),
(160, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:44:52'),
(161, 6, 'doctor', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:44:57'),
(162, 6, 'doctor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:45:24'),
(163, 6, 'doctor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:45:24'),
(164, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:53:02'),
(165, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:53:05'),
(166, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:53:05'),
(167, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 02:53:24'),
(168, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:00:33'),
(169, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:08:32'),
(170, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:08:32'),
(171, 2, 'editor', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:08:49'),
(172, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:14:31'),
(173, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:14:31'),
(174, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:14:40'),
(175, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 03:20:57'),
(176, 1, 'admin', 'Added Book', 'Added book: Test 001', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:40:51'),
(177, 1, 'admin', 'Updated Book', 'Updated book ID: 4', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:41:03'),
(178, 1, 'admin', 'Updated Book Status', 'Book ID: 4, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:41:08'),
(179, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 03:41:48'),
(180, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:08:32'),
(181, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:08:32'),
(182, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:09:34'),
(183, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:15:20'),
(184, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:27:48'),
(185, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:27:48'),
(186, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:31:24'),
(187, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:31:32'),
(188, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:31:32'),
(189, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:38:26'),
(190, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:40:34'),
(191, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:40:34'),
(192, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 04:40:38'),
(193, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:40:46'),
(194, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:40:46'),
(195, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:40:49'),
(196, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:51:09'),
(197, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 04:51:09'),
(198, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:12:14'),
(199, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:12:21'),
(200, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:12:21'),
(201, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:13:12'),
(202, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 05:19:38'),
(203, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:20:49'),
(204, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 05:34:52'),
(205, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 05:34:52'),
(206, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 05:34:56'),
(207, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:35:22'),
(208, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:35:22'),
(209, 2, 'editor', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:35:46'),
(210, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:36:02'),
(211, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:36:02'),
(212, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 05:54:01'),
(213, 1, 'admin', 'Updated Journal', 'Updated journal ID: 3', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 06:33:17'),
(214, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 06:34:07'),
(215, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 06:34:38'),
(216, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 06:34:38'),
(217, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 06:35:43'),
(218, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 06:35:43'),
(219, 6, 'doctor', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 06:51:50'),
(220, 6, 'doctor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:04:22'),
(221, 6, 'doctor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:04:22'),
(222, 2, 'editor', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:04:28'),
(223, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:07:29'),
(224, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:07:29'),
(225, 2, 'editor', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 07:07:42'),
(226, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 07:08:05'),
(227, 2, 'editor', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 07:08:05'),
(228, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:08:29'),
(229, 1, 'admin', 'Added Book', 'Added book: General Specialty Surgical Instruments', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:18:30'),
(230, 1, 'admin', 'Added Book', 'Added book: Kaplan Medical Surgery', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:19:45'),
(231, 1, 'admin', 'Updated Book Status', 'Book ID: 6, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:19:50'),
(232, 1, 'admin', 'Updated Book Status', 'Book ID: 5, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:19:51'),
(233, 1, 'admin', 'Added Book', 'Added book: Langmans Medical Embryology 12th Edi.', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:21:33'),
(234, 1, 'admin', 'Added Book', 'Added book: Lipincott&#039;s Atlas of Anatomy', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:23:13'),
(235, 1, 'admin', 'Added Book', 'Added book: Lippincott&#039;s Pharmacology 5th Edi.', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:24:47'),
(236, 1, 'admin', 'Deleted Book', 'Deleted book ID: 4', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:24:58'),
(237, 1, 'admin', 'Deleted Book', 'Deleted book ID: 3', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:25:01'),
(238, 1, 'admin', 'Deleted Book', 'Deleted book ID: 1', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:25:04'),
(239, 1, 'admin', 'Deleted Book', 'Deleted book ID: 2', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:25:06');
INSERT INTO `audit_trail` (`id`, `user_id`, `user_type`, `action`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(240, 1, 'admin', 'Updated Book Status', 'Book ID: 9, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:25:48'),
(241, 1, 'admin', 'Updated Book Status', 'Book ID: 8, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:25:50'),
(242, 1, 'admin', 'Updated Book Status', 'Book ID: 7, Status: approved', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 07:25:51'),
(243, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 10:29:52'),
(244, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 10:51:44'),
(245, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 10:51:44'),
(246, 1, 'admin', 'User Login', 'User logged in successfully', '103.140.177.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', '2026-08-16 11:13:37'),
(247, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 11:14:30'),
(248, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 11:15:32'),
(249, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 11:15:32'),
(250, 1, 'admin', 'Added Book', 'Added book: AAOS Comprehensive Orthopaedic Review - Study Questions, 1st ed', '103.140.177.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', '2026-08-16 11:21:29'),
(251, 1, 'admin', 'Updated Book Status', 'Book ID: 10, Status: approved', '103.140.177.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', '2026-08-16 11:21:39'),
(252, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-16 11:39:18'),
(253, 1, 'admin', 'Added Book', 'Added book: General Specialty Surgical Instruments', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-16 12:33:30'),
(254, 1, 'admin', 'Updated Book Status', 'Book ID: 11, Status: approved', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-16 12:41:22'),
(255, 1, 'admin', 'User Login', 'User logged in successfully', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 13:52:21'),
(256, 1, 'admin', 'Added Book', 'Added book: IAP Textbook of Pediatrics 4th Ed', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 14:36:39'),
(257, 1, 'admin', 'Updated Book Status', 'Book ID: 12, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 14:36:46'),
(258, 1, 'admin', 'User Login', 'User logged in successfully', '37.111.200.29', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-16 14:59:52'),
(259, 1, 'admin', 'Added Book', 'Added book: Operative Techniques in Orthopaedic Surgical Oncology', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:04:46'),
(260, 1, 'admin', 'Updated Book Status', 'Book ID: 13, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:04:52'),
(261, 1, 'admin', 'Added Book', 'Added book: Ortho Notes: Clinical Examination Pocket Guide', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:08:24'),
(262, 1, 'admin', 'Updated Book Status', 'Book ID: 14, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:08:29'),
(263, 1, 'admin', 'Added Book', 'Added book: Apley’s System of Orthopaedics and Fractures', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:09:41'),
(264, 1, 'admin', 'Updated Book Status', 'Book ID: 15, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:10:01'),
(265, 1, 'admin', 'Added Book', 'Added book: Rapid Review Physiology', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:12:49'),
(266, 1, 'admin', 'Updated Book Status', 'Book ID: 16, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:14:42'),
(267, 1, 'admin', 'Added Book', 'Added book: Netter&#039;s Orthopaedic Clinical Examination', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:16:39'),
(268, 1, 'admin', 'Updated Book Status', 'Book ID: 17, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:16:50'),
(269, 1, 'admin', 'Added Book', 'Added book: Preoperative Assessment and Management', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:41:19'),
(270, 1, 'admin', 'Updated Book Status', 'Book ID: 18, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:44:19'),
(271, 1, 'admin', 'Added Book', 'Added book: Oxford Handbook of Operative Surgery', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:47:34'),
(272, 1, 'admin', 'Added Book', 'Added book: Williams obstetrics 23rd Ed', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:56:58'),
(273, 1, 'admin', 'Updated Book Status', 'Book ID: 19, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:57:09'),
(274, 1, 'admin', 'Updated Book Status', 'Book ID: 20, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 15:57:11'),
(275, 1, 'admin', 'Added Book', 'Added book: Snell&#039;s Clinical Neuroanatomy', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 16:12:54'),
(276, 1, 'admin', 'Updated Book Status', 'Book ID: 21, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 16:13:03'),
(277, 1, 'admin', 'Added Book', 'Added book: Pocket Guide to the Operating Room', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 16:16:05'),
(278, 1, 'admin', 'Updated Book Status', 'Book ID: 22, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 16:16:09'),
(279, 1, 'admin', 'Added Book', 'Added book: Robbins, Cotran &amp; Kumar Pathologic Basis of Disease', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 16:45:30'),
(280, 1, 'admin', 'Updated Book Status', 'Book ID: 23, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:00:26'),
(281, 1, 'admin', 'Added Book', 'Added book: Operative Techniques: Knee Surgery', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:04:17'),
(282, 1, 'admin', 'Updated Book Status', 'Book ID: 24, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:04:22'),
(283, 1, 'admin', 'Added Book', 'Added book: Miller&#039;s Review of Orthopaedics', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:09:27'),
(284, 1, 'admin', 'Updated Book Status', 'Book ID: 25, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:09:33'),
(285, 1, 'admin', 'Added Book', 'Added book: Schwartz&#039;s Manual of Surgery', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:11:59'),
(286, 1, 'admin', 'Added Book', 'Added book: Long Cases in General Surgery', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:14:34'),
(287, 1, 'admin', 'Updated Book Status', 'Book ID: 26, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:14:42'),
(288, 1, 'admin', 'Updated Book Status', 'Book ID: 27, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:14:45'),
(289, 1, 'admin', 'Added Book', 'Added book: Imaging for Surgical Disease', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:22:38'),
(290, 1, 'admin', 'Updated Book', 'Updated book ID: 28', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:23:48'),
(291, 1, 'admin', 'Updated Book Status', 'Book ID: 28, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:24:03'),
(292, 1, 'admin', 'Added Book', 'Added book: Browse&#039;s Introduction to the Investigation and Management of Surgical Disease', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:28:44'),
(293, 1, 'admin', 'Updated Book Status', 'Book ID: 29, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:28:54'),
(294, 1, 'admin', 'Added Book', 'Added book: Campbell&#039;s Operative Orthopaedics', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:33:21'),
(295, 1, 'admin', 'Updated Book Status', 'Book ID: 30, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:33:34'),
(296, 7, 'doctor', 'User Registration', 'New doctor registered', '103.85.243.73', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_6_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/152.0.7977.40 Mobile/15E148 Safari/604.1', '2026-08-16 17:33:36'),
(297, 1, 'admin', 'Added Book', 'Added book: Really Essential Medical Immunology', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:37:32'),
(298, 1, 'admin', 'Updated Book Status', 'Book ID: 31, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:37:41'),
(299, 1, 'admin', 'Added Book', 'Added book: Textbook of Arthroscopy', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:44:13'),
(300, 1, 'admin', 'Updated Book Status', 'Book ID: 32, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-16 17:44:20'),
(301, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 02:48:29'),
(302, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:09:38'),
(303, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:10:01'),
(304, 1, 'admin', 'Added Book', 'Added book: Imaging For Surgical Disease 7th Ed', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:14:39'),
(305, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:14:39'),
(306, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:14:45'),
(307, 1, 'admin', 'Updated Book Status', 'Book ID: 33, Status: approved', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:14:45'),
(308, 1, 'admin', 'Added Book', 'Added book: Kaplan Medical Surgery Notes', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:20:47'),
(309, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:20:47'),
(310, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:20:56'),
(311, 1, 'admin', 'Updated Book Status', 'Book ID: 34, Status: approved', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:20:56'),
(312, 1, 'admin', 'Added Book', 'Added book: Lippincott_s Pharmacology 5th Ed', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:29:59'),
(313, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:29:59'),
(314, 1, 'admin', 'Deleted Book', 'Deleted book ID: 11', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:30:05'),
(315, 1, 'admin', 'Updated Book Status', 'Book ID: 35, Status: approved', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-17 03:30:05'),
(316, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 05:00:11'),
(317, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 05:21:56'),
(318, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 05:21:56'),
(319, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 06:20:45'),
(320, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 07:07:08'),
(321, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 07:07:08'),
(322, 1, 'admin', 'User Login', 'User logged in successfully', '115.127.26.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-17 11:48:21'),
(323, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-19 07:21:03'),
(324, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-19 07:22:02'),
(325, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-19 07:22:02'),
(326, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-20 11:23:00'),
(327, 1, 'admin', 'User Login', 'User logged in successfully', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 05:57:36'),
(328, 1, 'admin', 'Added Book', 'Added book: Shoulder Arthroscopy: Principles and Practice', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 06:08:12'),
(329, 1, 'admin', 'Updated Book Status', 'Book ID: 36, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 06:08:19'),
(330, 1, 'admin', 'Added Book', 'Added book: Hand Surgery', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 06:11:01'),
(331, 1, 'admin', 'Updated Book Status', 'Book ID: 37, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 06:11:20'),
(332, 1, 'admin', 'Added Book', 'Added book: Oxford Handbook of Trauma and Orthopaedics', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 06:18:41'),
(333, 1, 'admin', 'Updated Book Status', 'Book ID: 38, Status: approved', '118.179.124.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-21 06:18:46'),
(334, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 02:39:19'),
(335, 1, 'admin', 'Requested Download Permission', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 02:48:23'),
(336, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 02:49:52'),
(337, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 02:50:33'),
(338, 1, 'admin', 'Requested Supply', 'book_36', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 02:58:05'),
(339, 1, 'admin', 'Requested Supply', 'book_37', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 03:01:19'),
(340, 1, 'admin', 'Requested Supply', 'book_25', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 03:03:45'),
(341, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 03:05:23'),
(342, 1, 'admin', 'Requested Supply', 'book_25', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 03:26:50'),
(343, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 05:14:55'),
(344, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 05:18:21'),
(345, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 05:18:54'),
(346, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 05:39:14'),
(347, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 05:40:58'),
(348, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 11; rk3568_r) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '2026-08-22 05:43:33'),
(349, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:09:46'),
(350, 1, 'admin', 'Requested Supply', 'book_30', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:15:44'),
(351, 1, 'admin', 'Requested Supply', 'book_15', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:19:06'),
(352, 1, 'admin', 'Requested Supply', 'book_15', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:21:11'),
(353, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:32:33'),
(354, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:44:50'),
(355, 1, 'admin', 'Requested Supply', 'book_36', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:47:34'),
(356, 1, 'admin', 'Requested Supply', 'book_25', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 06:59:01'),
(357, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:00:19'),
(358, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:01:51'),
(359, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:04:34'),
(360, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:05:37'),
(361, 1, 'admin', 'Requested Supply', 'book_25', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:18:09'),
(362, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:19:19'),
(363, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:20:42'),
(364, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:22:37'),
(365, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:24:55'),
(366, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:26:11'),
(367, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:28:32'),
(368, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:30:49'),
(369, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:32:23'),
(370, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:33:36'),
(371, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:36:23'),
(372, 1, 'admin', 'Requested Supply', 'book_36', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:38:48'),
(373, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:45:48'),
(374, 1, 'admin', 'Processed Supply Request', 'Request ID: 7, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:47:30'),
(375, 1, 'admin', 'Requested Supply', 'book_30', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:50:33'),
(376, 1, 'admin', 'Requested Supply', 'book_25', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:51:26'),
(377, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:52:26'),
(378, 1, 'admin', 'Requested Supply', 'book_37', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:54:04'),
(379, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:55:17'),
(380, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:56:13'),
(381, 1, 'admin', 'Requested Supply', 'book_30', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:57:45'),
(382, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:58:39'),
(383, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 07:59:54'),
(384, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 08:00:45'),
(385, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 09:45:31'),
(386, 1, 'admin', 'Requested Supply', 'book_37', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 09:50:31'),
(387, 1, 'admin', 'Requested Supply', 'book_30', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 09:53:31'),
(388, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 09:55:47'),
(389, 1, 'admin', 'Requested Supply', 'book_13', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 09:59:05'),
(390, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:00:19'),
(391, 1, 'admin', 'Requested Supply', 'book_36', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:01:31'),
(392, 1, 'admin', 'Requested Supply', 'book_37', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:03:05'),
(393, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:04:02'),
(394, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:05:50'),
(395, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:07:38'),
(396, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:21:01'),
(397, 1, 'admin', 'Requested Supply', 'book_37', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:23:36'),
(398, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:24:52'),
(399, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:27:40'),
(400, 1, 'admin', 'Requested Supply', 'book_17', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:29:03'),
(401, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:30:09'),
(402, 1, 'admin', 'Requested Supply', 'book_30', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:32:19'),
(403, 1, 'admin', 'Requested Supply', 'book_10', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 10:34:02'),
(404, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:41:24'),
(405, 1, 'admin', 'Processed Supply Request', 'Request ID: 4, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:42:23'),
(406, 1, 'admin', 'Processed Supply Request', 'Request ID: 3, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:42:34'),
(407, 1, 'admin', 'Processed Supply Request', 'Request ID: 2, Status: approved', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:42:45'),
(408, 1, 'admin', 'Processed Supply Request', 'Request ID: 5, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:43:21'),
(409, 1, 'admin', 'Processed Supply Request', 'Request ID: 6, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:43:32'),
(410, 1, 'admin', 'Processed Supply Request', 'Request ID: 8, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:43:40'),
(411, 1, 'admin', 'Processed Supply Request', 'Request ID: 9, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:50:56'),
(412, 1, 'admin', 'Processed Supply Request', 'Request ID: 15, Status: rejected', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 11:51:33'),
(413, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 15:19:49'),
(414, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 15:23:48'),
(415, 1, 'admin', 'Requested Supply', 'book_37', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 15:26:37'),
(416, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 15:28:53'),
(417, 1, 'admin', 'Requested Supply', 'book_32', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 15:30:03'),
(418, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 15:32:07'),
(419, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 03:06:37'),
(420, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 03:30:39'),
(421, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 03:51:07'),
(422, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 03:51:07'),
(423, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 05:07:46'),
(424, 1, 'admin', 'Requested Supply', 'book_24', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 05:09:13'),
(425, 1, 'admin', 'Requested Supply', 'book_36', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 05:20:07'),
(426, 1, 'admin', 'Requested Supply', 'book_38', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 05:25:59'),
(427, 1, 'admin', 'User Login', 'User logged in successfully', '119.148.2.124', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-23 10:45:38'),
(428, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-30 03:55:36'),
(429, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-30 03:55:46'),
(430, 1, 'admin', 'User Logout', 'User logged out', '27.147.137.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-30 03:55:46'),
(431, 1, 'admin', 'User Login', 'User logged in successfully', '49.229.236.180', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-09-06 20:55:29'),
(432, 1, 'admin', 'User Login', 'User logged in successfully', '37.111.213.169', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', '2026-09-08 09:48:24'),
(433, 1, 'admin', 'User Login', 'User logged in successfully', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-08 09:57:14'),
(434, 1, 'admin', 'Processed Download Permission', 'Permission ID: 5, Status: approved', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-08 09:58:56'),
(435, 1, 'admin', 'Download', 'Downloaded book: Oxford Handbook of Trauma and Orthopaedics', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-08 09:59:15'),
(436, 1, 'admin', 'User Logout', 'User logged out', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-08 10:01:33'),
(437, 1, 'admin', 'User Logout', 'User logged out', '27.147.132.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-08 10:01:33');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(200) NOT NULL,
  `specialty_id` int(11) NOT NULL,
  `year` year(4) DEFAULT NULL,
  `publisher` varchar(200) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_watermarked` tinyint(1) DEFAULT 1,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `uploaded_by` int(11) DEFAULT NULL,
  `download_count` int(11) DEFAULT 0,
  `view_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `specialty_id`, `year`, `publisher`, `isbn`, `cover_image`, `file_path`, `description`, `is_watermarked`, `status`, `uploaded_by`, `download_count`, `view_count`, `created_at`, `updated_at`) VALUES
(5, 'General Specialty Surgical Instruments', 'Novo Surgical, Inc', 32, '0000', 'Novo Surgical, Inc', '', '1786864708_3c451ee91267eb9c.jpg', '1786864708_c64257a3d43765a6.pdf', 'General Specialty Surgical Instruments', 1, 'approved', 1, 0, 0, '2026-08-16 07:18:30', '2026-08-16 07:19:51'),
(6, 'Kaplan Medical Surgery', 'Kaplan Medical', 32, '0000', 'Kaplan Medical', '', '1786864780_1652cbfbebc4820c.jpg', '1786864780_8fb742a3f3cecb50.pdf', 'Kaplan Medical Surgery', 1, 'approved', 1, 0, 0, '2026-08-16 07:19:45', '2026-08-16 07:19:50'),
(7, 'Langmans Medical Embryology 12th Edi.', 'Lippincott Williams &amp; Wilkins', 32, '0000', 'Wolters Kluwer Health', '', '1786864889_5b49d0dfa082d726.jpg', '1786864889_0fa0238eec699c20.pdf', 'Langmans Medical Embryology 12th Edi.', 1, 'approved', 1, 0, 1, '2026-08-16 07:21:33', '2026-08-16 07:26:19'),
(8, 'Lipincott&#039;s Atlas of Anatomy', 'Patrick W. Tank &amp; Thomas R. Gest', 32, '0000', 'Wolters Kluwer Health', '', '1786864993_b3f2ec1ca417b3b6.jpg', '1786864993_d641100794a41afd.pdf', 'Lipincott&#039;s Atlas of Anatomy', 1, 'approved', 1, 0, 0, '2026-08-16 07:23:13', '2026-08-16 07:25:50'),
(9, 'Lippincott&#039;s Pharmacology 5th Edi.', 'Michelle A. Clark &amp; Richard Finkel &amp; Jose A. Rey &amp; Karen Whalen', 11, '0000', '', '', '1786865083_6c9d07b7d339a4b5.jpg', '1786865083_150eb63eb466e464.pdf', 'Lippincott&#039;s Pharmacology 5th Edi.', 1, 'approved', 1, 0, 0, '2026-08-16 07:24:47', '2026-08-16 07:25:48'),
(10, 'AAOS Comprehensive Orthopaedic Review - Study Questions, 1st ed', 'AAOS', 35, '0000', '', '', '1786879289_b05d65f67270b7b4.png', '1786879289_138431c2b01b1bc1.pdf', '', 1, 'approved', 1, 0, 1, '2026-08-16 11:21:29', '2026-08-22 10:33:11'),
(12, 'IAP Textbook of Pediatrics 4th Ed', 'A. Parthasarathy', 22, '2009', '', '978-81-8448-580-6', '1786890999_e8f0b4fcdd1c3b88.jpg', '1786890999_da8def0179fd137c.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-16 14:36:39', '2026-08-16 14:36:46'),
(13, 'Operative Techniques in Orthopaedic Surgical Oncology', 'Martin M. Malawer, James C. Wittig, Jacob Bickels, Sam W. Wiesel', 35, '2016', '', '978-1-4511-9327-5', '1786892686_93f9168e98f9c6a0.jpg', '1786892686_d7b139f29de64e6c.pdf', 'A comprehensive, step-by-step reference for operative techniques in orthopaedic surgical oncology.', 1, 'approved', 1, 0, 1, '2026-08-16 15:04:46', '2026-08-22 09:58:15'),
(14, 'Ortho Notes: Clinical Examination Pocket Guide', 'Dawn T. Gulick', 35, '2018', '', '978-0-8036-6657-3', '1786892904_b4182aa18438f258.jpg', '1786892904_44d8ef689499439e.pdf', 'A concise clinical pocket guide covering essential orthopaedic examination techniques, including medical screening, imaging, mechanism of injury, range of motion, strength and functional deficits, palpation, and special tests.', 1, 'approved', 1, 0, 0, '2026-08-16 15:08:24', '2026-08-16 15:08:29'),
(15, 'Apley’s System of Orthopaedics and Fractures', 'Louis Solomon, David Warwick, Selvadurai Nayagam', 35, '2018', '', '978-0340942055', '1786892978_c31bcb32081f8bea.jpg', '1786892978_5f83a8dd7745ae1e.pdf', 'A comprehensive textbook of orthopaedic surgery covering general orthopaedics, regional orthopaedics, fractures and joint injuries.', 1, 'approved', 1, 0, 7, '2026-08-16 15:09:41', '2026-08-23 03:09:12'),
(16, 'Rapid Review Physiology', 'Thomas A. Brown', 26, '2011', '', '978-0-323-07260-1', '1786893169_5e8954dff21972a7.jpg', '1786893169_cad7a2e55e519053.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-16 15:12:49', '2026-08-16 15:14:42'),
(17, 'Netter&#039;s Orthopaedic Clinical Examination', 'Joshua A. Cleland, Shane Koppenhaver', 35, '2011', '', '978-1-4377-1384-8', '1786893396_6fa66579b17a9e61.jpg', '1786893395_d1ef86448a239683.pdf', '', 1, 'approved', 1, 0, 8, '2026-08-16 15:16:39', '2026-08-22 10:28:00'),
(18, 'Preoperative Assessment and Management', 'BobbieJean Sweitzer', 2, '2008', '', '978-0-7817-7498-7', '1786894879_fde7c5c77f500a17.jpg', '1786894879_3e408d5e75d7a432.pdf', 'A practical handbook covering preoperative evaluation, risk assessment, history taking, physical examination, diagnostic testing, and management of medical conditions relevant to anesthesia and surgery.', 1, 'approved', 1, 0, 0, '2026-08-16 15:41:19', '2026-08-16 15:44:19'),
(19, 'Oxford Handbook of Operative Surgery', 'Greg R. McLatchie; David J. Leaper', 32, '2006', '', '978-0-19-851056-7', '1786895254_40bb1a9871e3ccdc.jpg', '1786895254_3dd17140c830612b.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-16 15:47:34', '2026-08-16 15:57:09'),
(20, 'Williams obstetrics 23rd Ed', 'F. Gary Cunningham, Kenneth J. Leveno, Steven L. Bloom, John C. Hauth, Dwight J. Rouse, Catherine Y. Spong', 11, '2010', '', '978-0-07-149701-5', '1786895813_0c199b7778e44bab.jpg', '1786895813_30d0e1be49210318.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-16 15:56:58', '2026-08-16 15:57:11'),
(21, 'Snell&#039;s Clinical Neuroanatomy', 'Richard S. Snell', 20, '2010', '', '978-0-7817-9427-5', '1786896774_370556514eba9d5f.jpg', '1786896774_2f00033a924d71e7.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-16 16:12:54', '2026-08-16 16:13:03'),
(22, 'Pocket Guide to the Operating Room', 'Maxine A. Goldman', 32, '2008', '', '978-0-8036-1226-6', '1786896965_a2a246fcabed6a25.jpg', '1786896965_8048694ce6e71871.pdf', 'A practical pocket reference for perioperative care, covering surgical procedures, patient preparation, positioning, skin preparation, draping, instrumentation, supplies, and special considerations across various surgical specialties.', 1, 'approved', 1, 0, 2, '2026-08-16 16:16:05', '2026-08-22 10:48:08'),
(23, 'Robbins, Cotran &amp; Kumar Pathologic Basis of Disease', 'Vinay Kumar; Abul K. Abbas; Jon C. Aster; Jayanta Debnath; Abhijit Das', 15, '2025', '', '9780443264528', '1786898726_88d03259902f349d.jpg', '1786898726_7045a15f4e8b96fb.pdf', 'A comprehensive textbook of pathology covering the cellular and molecular basis of human disease, including disease mechanisms, morphology, clinical manifestations, diagnosis, and major organ-system disorders.', 1, 'approved', 1, 0, 0, '2026-08-16 16:45:30', '2026-08-16 17:00:26'),
(24, 'Operative Techniques: Knee Surgery', 'Mark D. Miller; James A. Browne; Brian J. Cole; Andrew J. Cosgarea; Brett D. Owens', 35, '2018', 'Elsevier', '9780323462921', '1786899857_fe4973db5b911eb2.gif', '1786899857_4c2929ce46c22308.pdf', 'A highly visual, step-by-step guide to modern knee surgery covering knee arthroscopy, meniscal procedures, cartilage procedures, ligament reconstruction, patellofemoral surgery, knee arthroplasty, and other operative techniques.', 1, 'approved', 1, 0, 30, '2026-08-16 17:04:17', '2026-08-23 05:08:05'),
(25, 'Miller&#039;s Review of Orthopaedics', 'Mark D. Miller; Stephen R. Thompson', 35, '2020', 'Elsevier', '9780323609784', '1786900165_a24549854137b549.jpg', '1786900165_4e62d3228431d8c4.pdf', '', 1, 'approved', 1, 0, 10, '2026-08-16 17:09:27', '2026-08-22 10:20:09'),
(26, 'Schwartz&#039;s Manual of Surgery', 'F. Charles Brunicardi', 32, '2006', 'McGraw-Hill', '978-0-07-144243-7', '1786900318_0633c30f63a31d3a.jpg', '1786900318_19c6523c799f0b9d.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-16 17:11:59', '2026-08-16 17:14:42'),
(27, 'Long Cases in General Surgery', 'R. Rajamahendran', 32, '2013', '', '978-93-5090-190-8', '1786900472_e861c98dc2ba3200.jpg', '1786900472_3ea052d7ecb05518.pdf', 'A practical guide to long-case clinical examination in general surgery, covering history taking, physical examination, investigations, diagnosis and management of common surgical conditions.', 1, 'approved', 1, 0, 0, '2026-08-16 17:14:34', '2026-08-16 17:14:45'),
(28, 'Imaging for Surgical Disease', 'Raphael Sun; David C. Ring; Steven Sauk; Hui Sen Chong', 32, '2014', 'Lippincott Williams &amp;amp; Wilkins', '9781451186383', '1786901028_90076382f9f82b2d.jpg', '1786900955_4addc660dd444f63.pdf', 'A concise, practical imaging guide for surgical residents covering common surgical diseases and their radiological findings.', 1, 'approved', 1, 0, 0, '2026-08-16 17:22:38', '2026-08-16 17:24:03'),
(29, 'Browse&#039;s Introduction to the Investigation and Management of Surgical Disease', 'Norman L. Browse; John Black; Kevin G. Burnand; Steven A. Corbett; William E. G. Thomas', 32, '2010', '', '9780340945742', '1786901320_4a1f487e3d56a1df.jpg', '1786901320_d1d8dd2424234623.pdf', 'A practical and concise textbook covering the investigation and management of surgical diseases.', 1, 'approved', 1, 0, 2, '2026-08-16 17:28:44', '2026-08-22 05:27:04'),
(30, 'Campbell&#039;s Operative Orthopaedics', 'S. Terry Canale; James H. Beaty', 35, '2008', '', '978-0-323-03329-9', '1786901600_c3e9fbf83f904928.jpg', '1786901600_fc45a475c4288c0d.pdf', 'A comprehensive reference in orthopaedic surgery covering operative and minimally invasive procedures, musculoskeletal conditions, trauma, arthroplasty, sports medicine, spine, hand, foot and ankle surgery, tumors, infections, and postoperative management.', 1, 'approved', 1, 0, 9, '2026-08-16 17:33:21', '2026-08-22 10:30:44'),
(31, 'Really Essential Medical Immunology', 'Arthur Rabson; Ivan M. Roitt; Peter J. Delves', 1, '2005', '', '978-1-4051-2115-6', '1786901852_17f35fa73f805b87.jpg', '1786901852_7182196d947ddf41.pdf', 'A concise textbook covering the essential principles of medical immunology, including innate and acquired immunity, antigen recognition, antibodies, immune responses, immunity to infection, immunodeficiency, hypersensitivity, transplantation, tumor immunology, and autoimmune diseases.', 1, 'approved', 1, 0, 0, '2026-08-16 17:37:32', '2026-08-16 17:37:41'),
(32, 'Textbook of Arthroscopy', 'Mark D. Miller; Brian J. Cole', 35, '2004', '', '978-0-7216-0013-0', '1786902252_03d5d767af5da178.jpg', '1786902252_b4907362c925b26b.pdf', 'A comprehensive reference on diagnostic and operative arthroscopy covering the shoulder, elbow, wrist, hip, knee, ankle and spine.', 1, 'approved', 1, 0, 21, '2026-08-16 17:44:13', '2026-08-22 15:29:17'),
(33, 'Imaging For Surgical Disease 7th Ed', 'Raphael Sun, MD, David Ring, MD, Steven Sauk, MD, Hui Sen Chong, MD', 32, '0000', '', '', '1786936479_013e8e245f7a719b.jpg', '1786936479_a27b3f51734a90db.pdf', '', 1, 'approved', 1, 0, 1, '2026-08-17 03:14:39', '2026-08-22 10:38:19'),
(34, 'Kaplan Medical Surgery Notes', 'Kaplan, Inc.', 32, '0000', '', '', '1786936842_ea38437268e6ac40.jpg', '1786936842_3ca289be8d1a0b8c.pdf', '', 1, 'approved', 1, 0, 0, '2026-08-17 03:20:47', '2026-08-17 03:20:56'),
(35, 'Lippincott_s Pharmacology 5th Ed', 'Michelle A. Clark, Ph.D., Richard Finkel, Pharm.D., Jose A. Rey, Pharm.D., BCPP,  Karen Whalen, Pharm.D., BCPS, Richard A. Harvey, Ph.D.', 15, '0000', '', '', '1786937395_58171b7ef7fff6dd.jpg', '1786937395_50cd1bc79117176f.pdf', '', 1, 'approved', 1, 0, 2, '2026-08-17 03:29:59', '2026-08-23 03:37:09'),
(36, 'Shoulder Arthroscopy: Principles and Practice', 'Giuseppe Milano; Andrea Grasso; Roman Brzóska; Ladislav Kovačič', 35, '2023', 'Springer', '978-3-662-66867-2', '1787292489_78f741f09e6be707.png', '1787292489_ff2990bc6a6aedba.pdf', '', 1, 'approved', 1, 0, 10, '2026-08-21 06:08:12', '2026-08-23 05:18:55'),
(37, 'Hand Surgery', 'David Warwick; Roderick Dunn; Erman Melikyan; Jane Vadher', 35, '2009', 'Oxford University Press', '978-0-19-922723-5', '1787292661_4f9c2fe1559d6049.jpg', '1787292661_b18f2def38ec6b68.pdf', '', 1, 'approved', 1, 0, 12, '2026-08-21 06:11:01', '2026-08-23 03:36:30'),
(38, 'Oxford Handbook of Trauma and Orthopaedics', 'Kunal Kulkarni; Randeep Aujla; Jeremy Granville Chapman', 35, '2025', '', '9780198738657', '1787293121_531ddd6662e48e3a.jpg', '1787293121_af1826918b75cb24.pdf', '', 1, 'approved', 1, 1, 22, '2026-08-21 06:18:41', '2026-09-08 09:59:30');

-- --------------------------------------------------------

--
-- Table structure for table `download_permissions`
--

CREATE TABLE `download_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_type` enum('book','journal') NOT NULL,
  `item_id` int(11) NOT NULL,
  `max_downloads` int(11) DEFAULT 2,
  `used_downloads` int(11) DEFAULT 0,
  `status` enum('pending','approved','rejected','expired') DEFAULT 'pending',
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `admin_notes` text DEFAULT NULL,
  `processed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `download_permissions`
--

INSERT INTO `download_permissions` (`id`, `user_id`, `item_type`, `item_id`, `max_downloads`, `used_downloads`, `status`, `requested_at`, `approved_at`, `expires_at`, `admin_notes`, `processed_by`) VALUES
(1, 4, 'book', 2, 1, 1, 'approved', '2026-08-13 08:22:52', '2026-08-13 08:33:37', '2026-09-12 08:33:37', '', 1),
(2, 4, 'journal', 1, 2, 0, 'approved', '2026-08-13 08:44:42', '2026-08-13 08:49:24', '2026-09-12 08:49:24', '', 1),
(3, 4, 'book', 1, 2, 2, 'approved', '2026-08-13 08:45:00', '2026-08-13 08:49:21', '2026-09-12 08:49:21', '', 1),
(4, 4, 'book', 2, 2, 0, 'approved', '2026-08-13 08:48:45', '2026-08-13 08:49:18', '2026-09-12 08:49:18', '', 1),
(5, 1, 'book', 38, 1, 1, 'approved', '2026-08-22 02:48:23', '2026-09-08 09:58:56', '2026-09-09 15:58:56', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `journal_name` varchar(200) NOT NULL,
  `specialty_id` int(11) NOT NULL,
  `issue` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `volume` varchar(50) DEFAULT NULL,
  `pages` varchar(50) DEFAULT NULL,
  `doi` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `abstract` text DEFAULT NULL,
  `is_watermarked` tinyint(1) DEFAULT 1,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `uploaded_by` int(11) DEFAULT NULL,
  `download_count` int(11) DEFAULT 0,
  `view_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journals`
--

INSERT INTO `journals` (`id`, `title`, `journal_name`, `specialty_id`, `issue`, `date`, `volume`, `pages`, `doi`, `file_path`, `abstract`, `is_watermarked`, `status`, `uploaded_by`, `download_count`, `view_count`, `created_at`, `updated_at`) VALUES
(1, 'Advances in Cardiac Care', 'Journal of Cardiology', 3, '4', '2023-12-15', '45', '', '', '1786606619_f56d97907f596cd9.pdf', 'Latest advances in cardiac care', 1, 'approved', NULL, 0, 19, '2026-08-13 03:44:44', '2026-08-16 06:52:29'),
(2, 'Neurological Research Updates', 'Neurology Today', 19, '2', '2023-11-20', '38', '', '', '1786606643_94cd016cd3294a37.pdf', 'Recent developments in neurology', 1, 'approved', NULL, 0, 5, '2026-08-13 03:44:44', '2026-08-13 17:17:02'),
(3, 'Testing', 'Test', 1, 'I-1', '2004-02-02', 'V-1', '12-16', 'Test', '1786847651_32c27ef73c37e4a5.pdf', 'Test', 1, 'approved', 1, 0, 0, '2026-08-16 02:34:11', '2026-08-16 06:33:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

CREATE TABLE `specialties` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `specialties`
--

INSERT INTO `specialties` (`id`, `name`, `description`, `status`, `created_at`) VALUES
(1, 'Allergy & Immunology', NULL, 1, '2026-08-13 03:44:44'),
(2, 'Anaesthesiology', NULL, 1, '2026-08-13 03:44:44'),
(3, 'Cardiology', NULL, 1, '2026-08-13 03:44:44'),
(4, 'Clinical Haematology', NULL, 1, '2026-08-13 03:44:44'),
(5, 'Critical Care Medicine', NULL, 1, '2026-08-13 03:44:44'),
(6, 'Dermatology & Venereology', NULL, 1, '2026-08-13 03:44:44'),
(7, 'Diabetology', NULL, 1, '2026-08-13 03:44:44'),
(8, 'Emergency Medicine', NULL, 1, '2026-08-13 03:44:44'),
(9, 'ENT', NULL, 1, '2026-08-13 03:44:44'),
(10, 'Endocrinology & Metabolism', NULL, 1, '2026-08-13 03:44:44'),
(11, 'Family Medicine', NULL, 1, '2026-08-13 03:44:44'),
(12, 'Gastroenterology', NULL, 1, '2026-08-13 03:44:44'),
(13, 'Hepatology', NULL, 1, '2026-08-13 03:44:44'),
(14, 'Infectious Diseases', NULL, 1, '2026-08-13 03:44:44'),
(15, 'Internal Medicine', NULL, 1, '2026-08-13 03:44:44'),
(16, 'Interventional Cardiology', NULL, 1, '2026-08-13 03:44:44'),
(17, 'Medical Oncology', NULL, 1, '2026-08-13 03:44:44'),
(18, 'Nephrology', NULL, 1, '2026-08-13 03:44:44'),
(19, 'Neurology', NULL, 1, '2026-08-13 03:44:44'),
(20, 'Neuro Medicine', NULL, 1, '2026-08-13 03:44:44'),
(21, 'Nuclear Medicine', NULL, 1, '2026-08-13 03:44:44'),
(22, 'Paediatric Medicine', NULL, 1, '2026-08-13 03:44:44'),
(23, 'Paediatric Neurology', NULL, 1, '2026-08-13 03:44:44'),
(24, 'Pain Medicine', NULL, 1, '2026-08-13 03:44:44'),
(25, 'Palliative Medicine', NULL, 1, '2026-08-13 03:44:44'),
(26, 'Physical Medicine & Rehabilitation', NULL, 1, '2026-08-13 03:44:44'),
(27, 'Psychiatry', NULL, 1, '2026-08-13 03:44:44'),
(28, 'Pulmonology / Respiratory Medicine', NULL, 1, '2026-08-13 03:44:44'),
(29, 'Rheumatology', NULL, 1, '2026-08-13 03:44:44'),
(30, 'Sleep Medicine', NULL, 1, '2026-08-13 03:44:44'),
(31, 'Sports Medicine', NULL, 1, '2026-08-13 03:44:44'),
(32, 'Surgery', NULL, 1, '2026-08-13 03:44:44'),
(33, 'Tropical Medicine', NULL, 1, '2026-08-13 03:44:44'),
(34, 'Transfusion Medicine', NULL, 1, '2026-08-13 03:44:44'),
(35, 'Orthopaedics', 'Orthopaedics', 1, '2026-08-16 10:52:49');

-- --------------------------------------------------------

--
-- Table structure for table `supply_requests`
--

CREATE TABLE `supply_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `journal_id` int(11) DEFAULT NULL,
  `request_type` enum('book','journal') NOT NULL,
  `delivery_address` text NOT NULL,
  `delivery_phone` varchar(20) DEFAULT NULL,
  `status` enum('pending','approved','rejected','completed') DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `processed_by` int(11) DEFAULT NULL,
  `request_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supply_requests`
--

INSERT INTO `supply_requests` (`id`, `user_id`, `book_id`, `journal_id`, `request_type`, `delivery_address`, `delivery_phone`, `status`, `admin_notes`, `processed_by`, `request_date`, `processed_date`) VALUES
(2, 1, 38, NULL, 'book', 'Dhàka', '019899945933', 'approved', '', 1, '2026-08-22 02:49:52', '2026-08-22 11:42:45'),
(3, 1, 38, NULL, 'book', 'Dhàka', '019899945933', 'rejected', '', 1, '2026-08-22 02:50:33', '2026-08-22 11:42:34'),
(4, 1, 36, NULL, 'book', 'Emran bsoh', '019899945933', 'rejected', '', 1, '2026-08-22 02:58:05', '2026-08-22 11:42:23'),
(5, 1, 37, NULL, 'book', 'Shafiullah 01989995546, hand surgery', '', 'rejected', '', 1, '2026-08-22 03:01:19', '2026-08-22 11:43:21'),
(6, 1, 25, NULL, 'book', 'Ghhjnkjjh 0096⅝4467', '', 'rejected', '', 1, '2026-08-22 03:03:45', '2026-08-22 11:43:32'),
(7, 1, 17, NULL, 'book', 'Gghjjjjh456789', '', 'rejected', '', 1, '2026-08-22 03:05:23', '2026-08-22 07:47:30'),
(8, 1, 25, NULL, 'book', 'Kibria,01929993161,NITOR', '', 'rejected', '', 1, '2026-08-22 03:26:50', '2026-08-22 11:43:40'),
(9, 1, 32, NULL, 'book', 'Dr. Shibendu Mistri, 01712994743 . popular dia. Khulna', '', 'rejected', '', 1, '2026-08-22 05:18:21', '2026-08-22 11:50:56'),
(10, 1, 32, NULL, 'book', 'Dr. Shibendu Mistri, 01712994743 . popular dia. Khulna', '', 'pending', NULL, NULL, '2026-08-22 05:18:54', NULL),
(11, 1, 24, NULL, 'book', 'Dr. Masud, Central Police hospital, Dhaka', '01755949538', 'pending', NULL, NULL, '2026-08-22 05:39:14', NULL),
(12, 1, 32, NULL, 'book', 'Dr. Masud, Central police hospital, 01755949538', '', 'pending', NULL, NULL, '2026-08-22 05:40:58', NULL),
(13, 1, 24, NULL, 'book', 'Dr. MASUD, Central police hospital, 01755949538', '', 'pending', NULL, NULL, '2026-08-22 05:43:33', NULL),
(14, 1, 30, NULL, 'book', 'Dr Koushik,01626009820,DMCH', '', 'pending', NULL, NULL, '2026-08-22 06:15:44', NULL),
(15, 1, 15, NULL, 'book', 'Drr', '', 'rejected', '', 1, '2026-08-22 06:19:06', '2026-08-22 11:51:33'),
(16, 1, 15, NULL, 'book', 'Dr Kousshik,01626009820,DMCH', '', 'pending', NULL, NULL, '2026-08-22 06:21:11', NULL),
(17, 1, 24, NULL, 'book', 'Dr Shibendu,01712994743,Popular,Khulna', '', 'pending', NULL, NULL, '2026-08-22 06:32:33', NULL),
(18, 1, 24, NULL, 'book', 'Dr ABUL HASAN,01719706867,CUMCH', '', 'pending', NULL, NULL, '2026-08-22 06:44:50', NULL),
(19, 1, 36, NULL, 'book', 'Dr Abul Hasan,01719706867,CUMCH', '', 'pending', NULL, NULL, '2026-08-22 06:47:34', NULL),
(20, 1, 25, NULL, 'book', 'Dr. Noman, 01731706877, NITOR', '', 'pending', NULL, NULL, '2026-08-22 06:59:01', NULL),
(21, 1, 17, NULL, 'book', 'Dr. Norman, 01731706877, nitor', '', 'pending', NULL, NULL, '2026-08-22 07:00:19', NULL),
(22, 1, 32, NULL, 'book', 'Dr. Noman, 01731706877, nitor', '', 'pending', NULL, NULL, '2026-08-22 07:01:51', NULL),
(23, 1, 24, NULL, 'book', 'Dr. Belayet, 01716638580,ibch,kakrail', '', 'pending', NULL, NULL, '2026-08-22 07:04:34', NULL),
(24, 1, 17, NULL, 'book', 'Dr Belayet,01716638580,ibch, kakrail', '', 'pending', NULL, NULL, '2026-08-22 07:05:37', NULL),
(25, 1, 25, NULL, 'book', 'Dr Mamun,01917797951,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:18:09', NULL),
(26, 1, 17, NULL, 'book', 'Dr Mamun,01917797951,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:19:19', NULL),
(27, 1, 32, NULL, 'book', 'Dr Mamun,01917797951,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:20:42', NULL),
(28, 1, 17, NULL, 'book', 'Dr All Mamun,01733463474,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:22:37', NULL),
(29, 1, 24, NULL, 'book', 'Dr Al Mamun,01733463474,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:24:55', NULL),
(30, 1, 32, NULL, 'book', 'Dr Al Mamun,01733463474,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:26:11', NULL),
(31, 1, 17, NULL, 'book', 'Dr Nizamuddin,01819676698,Life Care,raozan', '', 'pending', NULL, NULL, '2026-08-22 07:28:32', NULL),
(32, 1, 24, NULL, 'book', 'Dr Nizamuddin,01819676698,life Care, raozan', '', 'pending', NULL, NULL, '2026-08-22 07:30:49', NULL),
(33, 1, 38, NULL, 'book', 'Dr Nizamuddin,01819676698,life Care,raozan', '', 'pending', NULL, NULL, '2026-08-22 07:32:23', NULL),
(34, 1, 32, NULL, 'book', 'Dr Nizamuddin,01819676698,life care,raozan', '', 'pending', NULL, NULL, '2026-08-22 07:33:36', NULL),
(35, 1, 32, NULL, 'book', 'Dr MD Rakibul,01710833121,NITOR', '', 'pending', NULL, NULL, '2026-08-22 07:36:23', NULL),
(36, 1, 36, NULL, 'book', 'Dr MD Rakibul,01710833121,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:38:48', NULL),
(37, 1, 24, NULL, 'book', 'Dr MD Zakaria,01675989814,Bhola', '', 'pending', NULL, NULL, '2026-08-22 07:45:48', NULL),
(38, 1, 30, NULL, 'book', 'Dr Sanjoy,01822815515,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:50:33', NULL),
(39, 1, 25, NULL, 'book', 'Dr Sanjoy,01822815515,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:51:26', NULL),
(40, 1, 38, NULL, 'book', 'Dr Sanjoy,01822815515,nitor', '', 'pending', NULL, NULL, '2026-08-22 07:52:26', NULL),
(41, 1, 37, NULL, 'book', 'Dr Zia,01816873090,Nazirhat', '', 'pending', NULL, NULL, '2026-08-22 07:54:04', NULL),
(42, 1, 38, NULL, 'book', 'Dr Zia,01816873090,Nazirhat', '', 'pending', NULL, NULL, '2026-08-22 07:55:17', NULL),
(43, 1, 32, NULL, 'book', 'Dr Zia,01816873090,Nazirhat', '', 'pending', NULL, NULL, '2026-08-22 07:56:13', NULL),
(44, 1, 30, NULL, 'book', 'Dr Moinul,01620119802,BISH', '', 'pending', NULL, NULL, '2026-08-22 07:57:45', NULL),
(45, 1, 24, NULL, 'book', 'Dr Moinul,01620119802,bish', '', 'pending', NULL, NULL, '2026-08-22 07:58:39', NULL),
(46, 1, 38, NULL, 'book', 'Dr Moiniul,01620119802,bish', '', 'pending', NULL, NULL, '2026-08-22 07:59:54', NULL),
(47, 1, 32, NULL, 'book', 'Dr Moinul,01620119802,bish', '', 'pending', NULL, NULL, '2026-08-22 08:00:45', NULL),
(48, 1, 37, NULL, 'book', 'Dr Jane Alan,01717098995,nitor', '', 'pending', NULL, NULL, '2026-08-22 09:50:31', NULL),
(49, 1, 30, NULL, 'book', 'Dr MD Shah Alam,01716960316,kushtia medical college hospital', '', 'pending', NULL, NULL, '2026-08-22 09:53:31', NULL),
(50, 1, 24, NULL, 'book', 'Dr MD Shah Alam, 01716960316,kushtia medical college hospital', '', 'pending', NULL, NULL, '2026-08-22 09:55:47', NULL),
(51, 1, 13, NULL, 'book', 'Dr Jane Alam,01717098995,nitor', '', 'pending', NULL, NULL, '2026-08-22 09:59:05', NULL),
(52, 1, 38, NULL, 'book', 'Dr Jane Alam,01717098995,nitor', '', 'pending', NULL, NULL, '2026-08-22 10:00:19', NULL),
(53, 1, 36, NULL, 'book', 'Dr Jane Alam, 01717098995, nitor', '', 'pending', NULL, NULL, '2026-08-22 10:01:31', NULL),
(54, 1, 37, NULL, 'book', 'Dr Sirajus Salekeen,01717366027,nitor', '', 'pending', NULL, NULL, '2026-08-22 10:03:05', NULL),
(55, 1, 32, NULL, 'book', 'Dr Sirajus Salekeen,01717366027,nitor', '', 'pending', NULL, NULL, '2026-08-22 10:04:02', NULL),
(56, 1, 32, NULL, 'book', 'Dr Neyamul Hasan,01740634011,Rupgonj Health Complex', '', 'pending', NULL, NULL, '2026-08-22 10:05:50', NULL),
(57, 1, 32, NULL, 'book', 'Dr Jane Alam,01717098995,nitor', '', 'pending', NULL, NULL, '2026-08-22 10:07:38', NULL),
(58, 1, 37, NULL, 'book', 'Dr. MD. Jainal Abedin, 01842172133,CMCH', '01842172133,', 'pending', NULL, NULL, '2026-08-22 10:23:36', NULL),
(59, 1, 32, NULL, 'book', 'Dr Jainal Abedin,01842172133,CMCH', '', 'pending', NULL, NULL, '2026-08-22 10:24:52', NULL),
(60, 1, 38, NULL, 'book', 'Dr Munshi Foyzul Rabby, 01717969939,CMCH', '', 'pending', NULL, NULL, '2026-08-22 10:27:40', NULL),
(61, 1, 17, NULL, 'book', 'Dr Munzur Rahman, 01717516391,RMCH', '', 'pending', NULL, NULL, '2026-08-22 10:29:03', NULL),
(62, 1, 32, NULL, 'book', 'Dr Munzur Rahman, 01717516391,RMCH', '', 'pending', NULL, NULL, '2026-08-22 10:30:09', NULL),
(63, 1, 30, NULL, 'book', 'Dr.Ferdous Parvej, 01723803355, Kushtia Medical college hospital', '', 'pending', NULL, NULL, '2026-08-22 10:32:19', NULL),
(64, 1, 10, NULL, 'book', 'Dr Hossain, 01731479351, NITOR', '', 'pending', NULL, NULL, '2026-08-22 10:34:02', NULL),
(65, 1, 24, NULL, 'book', 'Dr mohiuddin ,  01850375665,cmch', '', 'pending', NULL, NULL, '2026-08-22 15:23:48', NULL),
(66, 1, 37, NULL, 'book', 'Dr mohiuddin Ahmed,01850375665,cmch', '', 'pending', NULL, NULL, '2026-08-22 15:26:37', NULL),
(67, 1, 32, NULL, 'book', 'Dr.Mahmud,01813312309', '', 'pending', NULL, NULL, '2026-08-22 15:28:53', NULL),
(68, 1, 32, NULL, 'book', 'Dr MD shakil 01817798147 CMÇH', '', 'pending', NULL, NULL, '2026-08-22 15:30:03', NULL),
(69, 1, 24, NULL, 'book', 'Dr habiba 01862846425 panchlaish', '', 'pending', NULL, NULL, '2026-08-22 15:32:07', NULL),
(70, 1, 24, NULL, 'book', 'Dr Mizan 01841680236 CMCH', '', 'pending', NULL, NULL, '2026-08-23 05:09:13', NULL),
(71, 1, 36, NULL, 'book', 'Dr MD didarul Alam 01718278338 CMCH', '', 'pending', NULL, NULL, '2026-08-23 05:20:07', NULL),
(72, 1, 38, NULL, 'book', 'Dr mazharul Islam 01882517686 Cmch', '', 'pending', NULL, NULL, '2026-08-23 05:25:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_type` enum('doctor','admin','editor') NOT NULL DEFAULT 'doctor',
  `name` varchar(100) NOT NULL,
  `bmdc_reg_no` varchar(50) DEFAULT NULL,
  `specialty` varchar(100) DEFAULT NULL,
  `hospital_institute` varchar(200) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT 'default.jpg',
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `download_limit` int(11) DEFAULT 2,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_type`, `name`, `bmdc_reg_no`, `specialty`, `hospital_institute`, `mobile`, `email`, `password`, `profile_image`, `is_verified`, `is_active`, `download_limit`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin User', NULL, NULL, NULL, NULL, 'admin@uclp.edu', '$2y$10$PC5DN6zQIAYrnozuzlvJQehqSsmIYhAS1.QvPWdYEe9YFnVopqto.', '1787455900_b739ceedf4721078.jpg', 1, 1, 2, '2026-08-13 03:44:44', '2026-08-23 03:31:40'),
(2, 'editor', 'Editor User', NULL, NULL, NULL, NULL, 'editor@uclp.edu', '$2y$10$YQa5pZLHKu6gqmG/mx9G0OAVaPySKNcW6a4AGUGdBKLpeW0gmOJiO', 'default.jpg', 1, 1, 2, '2026-08-13 03:44:44', '2026-08-13 05:15:33'),
(3, 'doctor', 'Desktop Checking 021', 'A1234', 'Family Medicine', 'DMU', '', 'desktopchecking@uclp.edu', '$2y$10$/p2KtVKYN8dwW4icK97.BOVC4vqqP12rXdPZQldvZnJW5C1GLvZX.', 'default.jpg', 1, 1, 2, '2026-08-13 06:31:11', '2026-08-13 09:58:09'),
(4, 'doctor', 'Desktop Checking 2345', 'A345678', 'ENT', 'DMU', '', 'desktopchecking123@uclp.edu', '$2y$10$TD0b2Hn1tqftMeiAfvPQ1eId8FEtvWNt0hOaZU3geY1Ktuf7LIt7O', 'default.jpg', 1, 1, 2, '2026-08-13 06:43:55', '2026-08-13 06:44:07'),
(5, 'doctor', 'Testing Doctor', 'A091234', 'Cardiology', 'DMU', '', 'testingdoctor@ucpl.academy', '$2y$10$JAOt4F6TBMYc0rh7leOLJeCc4Xl0sKbmYXV6NZwke130RFtnJ2mai', 'default.jpg', 1, 1, 2, '2026-08-16 02:42:52', NULL),
(6, 'doctor', 'Test Checking Doctor', 'A23567', '20', 'NINS', '01789001122', 'testingcheckingdoctor@ucpl.academy', '$2y$10$zY1mT6.rFKIzHB.uUp7eLOBp0o1Mc5V3dJBlFZ8qAgufjcBIoLNX2', 'default.jpg', 1, 1, 2, '2026-08-16 02:44:25', '2026-08-16 02:44:51'),
(7, 'doctor', 'Safayat Mahmud', '123456', '1', 'Uu', '01929993016', 'safayat.mahmud@unigroup-bd.com', '$2y$10$9KGJpv3GEPBMFAWq1VJ2R..diOBaFhB1SBJKMnq36rsmuxMQPtqi6', 'default.jpg', 0, 1, 2, '2026-08-16 17:33:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Indexes for table `download_permissions`
--
ALTER TABLE `download_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_unique` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_unique` (`name`);

--
-- Indexes for table `supply_requests`
--
ALTER TABLE `supply_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `journal_id` (`journal_id`),
  ADD KEY `processed_by` (`processed_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_unique` (`email`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token_unique` (`session_token`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=438;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `download_permissions`
--
ALTER TABLE `download_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `supply_requests`
--
ALTER TABLE `supply_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD CONSTRAINT `audit_trail_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `download_permissions`
--
ALTER TABLE `download_permissions`
  ADD CONSTRAINT `download_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `journals`
--
ALTER TABLE `journals`
  ADD CONSTRAINT `journals_ibfk_1` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supply_requests`
--
ALTER TABLE `supply_requests`
  ADD CONSTRAINT `supply_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supply_requests_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supply_requests_ibfk_3` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supply_requests_ibfk_4` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
