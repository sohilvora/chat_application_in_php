-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2024 at 07:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chat_app_php`
--

-- --------------------------------------------------------

--
-- Table structure for table `chatrooms`
--

CREATE TABLE `chatrooms` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `msg` text NOT NULL,
  `created_on` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatrooms`
--

INSERT INTO `chatrooms` (`id`, `userid`, `msg`, `created_on`) VALUES
(1, 3, 'hello zaid', '19-04-2024 01:07:08'),
(2, 3, 'how are you', '19-04-2024 01:30:04'),
(3, 1, 'I m fine', '19-04-2024 01:30:27'),
(4, 1, 'hello', '19-04-2024 05:54:46'),
(5, 2, 'ismail', '20-04-2024 08:12:15');

-- --------------------------------------------------------

--
-- Table structure for table `chat_message`
--

CREATE TABLE `chat_message` (
  `chat_message_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `chat_message` text NOT NULL,
  `timestamp` varchar(50) NOT NULL,
  `status` enum('Yes','No') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_message`
--

INSERT INTO `chat_message` (`chat_message_id`, `to_user_id`, `from_user_id`, `chat_message`, `timestamp`, `status`) VALUES
(1, 1, 3, 'hello yusuf', '19-04-2024 07:08:31', 'Yes'),
(2, 3, 1, 'hello zaid', '19-04-2024 07:08:51', 'Yes'),
(3, 3, 1, 'hello yusuf', '19-04-2024 07:32:03', 'Yes'),
(4, 1, 3, 'hello', '19-04-2024 07:33:20', 'Yes'),
(5, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:29', 'Yes'),
(6, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:29', 'Yes'),
(7, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:30', 'Yes'),
(8, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:31', 'Yes'),
(9, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:32', 'Yes'),
(10, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:32', 'Yes'),
(11, 2, 1, 'klsdghkdfhgdkfjh\n', '20-04-2024 08:13:32', 'Yes'),
(12, 1, 2, 'kljsclkjlsd', '20-04-2024 08:15:32', 'Yes'),
(13, 1, 2, 'kljsclkjlsd', '20-04-2024 08:15:32', 'Yes'),
(14, 1, 2, 'kljsclkjlsd', '20-04-2024 08:15:32', 'Yes'),
(15, 1, 2, 'kljsclkjlsd', '20-04-2024 08:15:33', 'Yes'),
(16, 1, 2, 'kljsclkjlsd', '20-04-2024 08:15:33', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `chat_user_table`
--

CREATE TABLE `chat_user_table` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_profile` text NOT NULL,
  `user_status` enum('Disabled','Enable') NOT NULL,
  `user_created_on` datetime NOT NULL,
  `user_verification_code` varchar(100) NOT NULL,
  `user_login_status` enum('Logout','Login') NOT NULL,
  `user_token` varchar(100) NOT NULL,
  `user_connection_id` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_user_table`
--

INSERT INTO `chat_user_table` (`user_id`, `user_name`, `user_email`, `user_password`, `user_profile`, `user_status`, `user_created_on`, `user_verification_code`, `user_login_status`, `user_token`, `user_connection_id`) VALUES
(1, 'Zaid', 'zaidvora.zv@gmail.com', 'zaidvora', 'images/1103784977.png', 'Enable', '2024-04-18 16:39:32', '99f867cc3589595e61fae00448456b53', 'Logout', '', 104),
(7, 'sohil ', 'SOHILVORA2000@GMAIL.COM', 'sohilvora', 'images/1713807057.png', 'Enable', '2024-04-22 19:30:57', 'efb9d0d1286b7406c4ba52ad410cd5aa', 'Login', '886412b851ec10eeb0880efdcd0e8fe6', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatrooms`
--
ALTER TABLE `chatrooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_message`
--
ALTER TABLE `chat_message`
  ADD PRIMARY KEY (`chat_message_id`);

--
-- Indexes for table `chat_user_table`
--
ALTER TABLE `chat_user_table`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatrooms`
--
ALTER TABLE `chatrooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chat_message`
--
ALTER TABLE `chat_message`
  MODIFY `chat_message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `chat_user_table`
--
ALTER TABLE `chat_user_table`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
