-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2020 at 06:01 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `accounts`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `password`, `email`) VALUES
(1, 'admin', 'admin', 'patawee.daw@gmail.com'),
(3, 'Tutor', '123', 'patawee.daw@gmail.com'),
(4, 'mai', '123', 'mai@mai.com'),
(7, 'maiChanLoveU', '123', 'maiChan@gmail.com'),
(8, 'NongK', '123', 'NongK@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `approvement`
--

CREATE TABLE `approvement` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `approver_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `approvement`
--

INSERT INTO `approvement` (`id`, `task_id`, `approver_id`) VALUES
(2, 1, 1),
(3, 2, 1),
(4, 2, 2),
(5, 2, 3),
(7, 3, 1),
(12, 6, 1),
(13, 6, 3),
(14, 6, 4),
(15, 8, 1),
(16, 8, 3),
(17, 8, 4),
(18, 5, 1),
(19, 7, 1),
(20, 7, 3),
(21, 7, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isConfirmed` int(1) NOT NULL,
  `owner_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `description`, `isConfirmed`, `owner_email`) VALUES
(1, 'test 1', 'test', 1, ''),
(2, 'test 2', 'test dfdfsdfsdfsdf', 1, ''),
(3, 'express', 'text', 1, ''),
(4, 'SQLtest', 'description test', 1, ''),
(5, 'Liverpool Project', 'Live Broadcast\r\nSponsorship', 0, ''),
(6, 'Ultraman Project', '2020 - 2024 COPYRIGHT', 1, 'patawee.daw@gmail.com'),
(7, 'Mockup Project', 'This is the mockup project for testing the approvement and email system.', 1, 'napat.s@swiftdynamics.co.th'),
(8, 'Jotaro', 'this is mockup project', 1, 'patawee.daw@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `approvement`
--
ALTER TABLE `approvement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `approvement`
--
ALTER TABLE `approvement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
