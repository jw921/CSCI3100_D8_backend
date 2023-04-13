-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 13, 2023 at 09:55 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 7.4.21

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
  `coursename` varchar(32) NOT NULL,
  `time_period` varchar(255) NOT NULL,
  `place` varchar(32) NOT NULL,
  `department` varchar(32) NOT NULL,
  `instructor` varchar(32) NOT NULL,
  `capacity` int(11) NOT NULL,
  `assessment_method` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`coursecode`, `coursename`, `time_period`, `place`, `department`, `instructor`, `capacity`, `assessment_method`) VALUES
('BABA101', 'Introduction to Business', 'T 14:30-16:30', 'Room 307', 'Business', 'ShawLeung', 100, 'exam'),
('BABA102', 'Advance Business', 'F 16:30-18:30', 'Room 102', 'Business', 'ShawLeung', 100, 'exam'),
('BIOL101', 'Biology I', 'F 16:00-19:00', 'Room 108', 'Biology', 'Emily Wang', 30, 'project'),
('CHEM101', 'Chemistry I', 'T 13:00-16:00', 'Room 105', 'Chemistry', 'Michael Brown', 25, 'project'),
('CHLT101', 'Chinese Language', 'M 08:30-13:30', 'Room 101', 'Chinese', 'ChungChi', 200, 'project'),
('CHLT102', 'Chinese Language Grammar', 'T 14:30-16:30', 'Room 102', 'Chinese', 'ChungChi', 100, 'project'),
('CS101', 'Introduction to Computer Science', 'F 09:00-12:00', 'Room 101', 'Computer Science', 'John Smith', 50, 'exam'),
('ECON101', 'Principles of Microeconomics', 'S 18:00-21:00', 'Room 110', 'Economics', 'Jane Doe', 30, 'project'),
('ENGL101', 'Composition I', 'S 11:00-14:00', 'Room 103', 'English', 'David Lee', 30, 'exam'),
('HIST101', 'World History I', 'W 14:00-17:00', 'Room 106', 'History', 'Maria Rodriguez', 35, 'project'),
('HIST102', 'World History II', 'T 14:30-16:30', 'Room 102', 'Chinese', 'Maria Rodriguez', 100, 'exam'),
('IBBA103', 'International Business', 'T 14:30-16:30', 'Room 100', 'IBBA', 'LeeKeungKeung', 100, 'project'),
('IBBA104', 'Advance International Business', 'W 12:30-13:30', 'Room 102', 'IBBA', 'LeeKeungKeung', 100, 'exam'),
('MATH201', 'Art Calculus I', 'S 10:00-13:00', 'Room 102', 'Mathematics', 'Jane Doe', 40, 'project'),
('PHYS100', 'Introduction to Physics', 'T 16:00-19:00', 'Room 207', 'Physics', 'Peter Kwan', 80, 'exam'),
('PHYS101', 'Physics I', 'M 12:00-15:00', 'Room 104', 'Physics', 'Sarah Johnson', 20, 'exam'),
('PHYS102', 'Physics in Engineering', 'T 19:00-23:00', 'Room 207', 'Physics', 'Peter Kwan', 100, 'exam'),
('PSYC102', 'Introduction to Psychology', 'T 15:00-18:00', 'Room 107', 'Psychology', 'SirRunRun', 45, 'project'),
('PSYC103', 'Psychology Theory', 'W 08:30-12:30', 'Room 100', 'Psychology', 'SirRunRun', 10, 'exam'),
('UGEA100', 'Chinese in Practice', 'T 14:30-16:30', 'Room 102', 'Chinese', 'ChungChi', 100, 'exam'),
('UGEB100', 'Engine in Practice', 'W 12:30-16:30', 'Room 102', 'Electronic Enginerring', 'CheungLiLi', 100, 'project');

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

CREATE TABLE `record` (
  `info_id` int(12) NOT NULL,
  `coursecode` varchar(32) NOT NULL,
  `createdtime` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` set('pending','waitlisted','rejected','dropped','enrolled') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
('Tony Chan', '123456', 'student', 777888999, 'CS', '123456@example.com'),
('Maria Rodriguez', 'password123456', 'student', 123456, 'History', 'sammi-li@example.com'),
('admin1', 'passwordadmin1', 'admin', 666, 'Computer Science', 'admin1@example.com'),
('Sam Cheung', 'password', 'student', 123, 'Languistics', 'samsamcheung@example.com'),
('Peter Leung', 'password123', 'student', 12345, 'Chinese', 'peterllp@example.com'),
('admin2', 'passwordadmin2', 'admin', 666, 'Electronic Enginerring', 'admin2@example.com'),
('admin3', 'passwordadmin3', 'admin', 777, 'BBA', 'admin3@example.com'),
('CheungLiLi', 'Passw0rd!', 'instructor', 1234, 'Electronic Enginerring', 'cll@example.com'),
('LeeKeungKeung', 'Passw0rd!', 'instructor', 1234, 'IBBA', 'lkk@example.com'),
('admin3', 'passwordadmin4', 'admin', 888, 'BBA', 'admin4@example.com'),
('SirRunRun', 'Passw0rd!', 'instructor', 1234, 'Psychology', 'rss@example.com'),
('admin3', 'passwordadmin5', 'admin', 999, 'BBA', 'admin5@example.com'),
('ShawLeung', 'Passw0rd!', 'instructor', 1234, 'Businness', 'shl@example.com'),
('ChungChi', 'Passw0rd!', 'instructor', 1234, 'Chinese', 'cc@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`coursecode`);

--
-- Indexes for table `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`info_id`,`coursecode`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
