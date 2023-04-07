-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2023 at 04:11 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `csci3100`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `coursecode` varchar(32) NOT NULL,
  `coursename` varchar(32) DEFAULT NULL,
  `time_period` varchar(255) DEFAULT NULL,
  `place` varchar(32) DEFAULT NULL,
  `department` varchar(32) DEFAULT NULL,
  `instructor` varchar(32) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `assessment_method` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`coursecode`, `coursename`, `time_period`, `place`, `department`, `instructor`, `capacity`, `assessment_method`) VALUES
('ART101', 'Art Appreciation', 'S 17:00-20:00', 'Room 109', 'Art', 'Kevin Chen', 20, 'project'),
('ART102', 'Introduction to Art', 'M 10:00-12:00', 'Art Building Room 101', 'Art Department', 'John Smith', 30, 'project'),
('BIOL101', 'Biology I', 'F 16:00-19:00', 'Room 108', 'Biology', 'Emily Wang', 30, 'project'),
('CHEM101', 'Chemistry I', 'T 13:00-16:00', 'Room 105', 'Chemistry', 'Michael Brown', 25, 'project'),
('CS101', 'Introduction to Computer Science', 'F 09:00-12:00', 'Room 101', 'Computer Science', 'John Smith', 50, 'exam'),
('ECON101', 'Principles of Microeconomics', 'S 18:00-21:00', 'Room 110', 'Economics', 'Jane Doe', 30, 'project'),
('ENGL101', 'Composition I', 'S 11:00-14:00', 'Room 103', 'English', 'David Lee', 30, 'project'),
('HIST101', 'World History I', 'W 14:00-17:00', 'Room 106', 'History', 'Maria Rodriguez', 35, 'project'),
('MATH201', 'Art Calculus I', 'S 10:00-13:00', 'Room 102', 'Mathematics', 'Jane Doe', 40, 'project'),
('PHYS101', 'Physics I', 'M 12:00-15:00', 'Room 104', 'Physics', 'Sarah Johnson', 20, 'project'),
('PSYC101', 'Introduction to Psychology', 'T 15:00-18:00', 'Room 107', 'Psychology', 'Daniel Kim', 45, 'project');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `usertype` varchar(32) NOT NULL,
  `info_id` int(12) NOT NULL,
  `department` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `usertype`, `info_id`, `department`, `email`) VALUES
('Kim', '55664477', 'student', 554, 'Cs', '123456@gmail.com'),
('BobJohnson', 'Passw0rd!', 'instructor', 1234, 'Art', 'BobJohnson-p@example.com'),
('JohnDoe', 'MyPa$$word', 'student', 2222, 'Electrical Engineering', 'JohnDoe-c@example.com'),
('MaryLee', 'P@ssw0rd', 'student', 4444, 'Mathematics', 'MaryLee-c@example.com'),
('DavidBrown', 'S3cr3tP@ss', 'admin', 5678, 'Biology', 'DavidBrown-s@example.com'),
('JaneSmith', 'S3cur3P@ss', 'admin', 9999, 'Computer Science', 'JaneSmith-s@example.com'),
('jdoe', 'password123', 'student', 12345, 'Computer Science', 'jdoe-c@example.com'),
('Tony Chan', '123456', 'student', 777888999, 'CS', '123456@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`coursecode`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`info_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
