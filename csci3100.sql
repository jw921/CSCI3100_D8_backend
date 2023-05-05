-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2023 at 03:33 AM
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
  `coursename` varchar(32) DEFAULT NULL,
  `weekday` set('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `starttime` time DEFAULT NULL,
  `endtime` time DEFAULT NULL,
  `place` varchar(32) DEFAULT NULL,
  `department` varchar(32) DEFAULT NULL,
  `instructor` varchar(32) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `assessment_method` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`coursecode`, `coursename`, `weekday`, `starttime`, `endtime`, `place`, `department`, `instructor`, `capacity`, `assessment_method`) VALUES
('ART101', 'Art Appreciation', 'Saturday', '17:00:00', '20:00:00', 'Room 109', 'Art', 'Kevin Chen', 20, 'project'),
('ART102', 'Introduction to Art', 'Monday', '10:00:00', '12:00:00', 'Art Building Room 101', 'Art Department', 'John Smith', 30, 'project'),
('BIOL101', 'Biology I', 'Friday', '16:00:00', '19:00:00', 'Room 108', 'Biology', 'Emily Wang', 30, 'project'),
('CHEM101', 'Chemistry I', 'Tuesday', '13:00:00', '16:00:00', 'Room 105', 'Chemistry', 'Michael Brown', 25, 'project'),
('CS101', 'Introduction to Computer Science', 'Friday', '09:00:00', '12:00:00', 'Room 101', 'Computer Science', 'John Smith', 50, 'exam'),
('ECON101', 'Principles of Microeconomics', 'Saturday', '18:00:00', '21:00:00', 'Room 110', 'Economics', 'Jane Doe', 30, 'project'),
('ENGL101', 'Composition I', 'Saturday', '11:00:00', '14:00:00', 'Room 103', 'English', 'David Lee', 30, 'project'),
('HIST101', 'World History I', 'Wednesday', '14:00:00', '17:00:00', 'Room 106', 'History', 'Maria Rodriguez', 35, 'project'),
('MATH201', 'Art Calculus I', 'Saturday', '10:00:00', '13:00:00', 'Room 102', 'Mathematics', 'Jane Doe', 40, 'project'),
('PHYS101', 'Physics I', 'Monday', '12:00:00', '15:00:00', 'Room 104', 'Physics', 'Sarah Johnson', 20, 'project'),
('PSYC101', 'Introduction to Psychology', 'Tuesday', '15:00:00', '18:00:00', 'Room 107', 'Psychology', 'Daniel Kim', 45, 'project');

-- --------------------------------------------------------

--
-- Stand-in structure for view `course_capacity`
-- (See below for the actual view)
--
CREATE TABLE `course_capacity` (
`coursecode` varchar(32)
,`remaining_capacity` bigint(22)
);

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

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`info_id`, `coursecode`, `createdtime`, `status`) VALUES
(2222, 'CHEM101', '2023-04-13 02:04:14', 'dropped'),
(4444, 'CHEM101', '2023-04-13 02:01:39', 'waitlisted'),
(5678, 'CHEM101', '2023-04-13 01:42:02', 'enrolled'),
(9999, 'CHEM101', '2023-04-13 01:41:35', 'enrolled');

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
('admin ah', 'adm@gg.com', 'admin', 123123123, 'admin', 'adm@gg.com'),
('Tony Chan', '123456', 'student', 777888999, 'CS', '123456@example.com');

-- --------------------------------------------------------

--
-- Structure for view `course_capacity`
--
DROP TABLE IF EXISTS `course_capacity`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `course_capacity`  AS SELECT `c`.`coursecode` AS `coursecode`, `c`.`capacity`- count(`r`.`info_id`) AS `remaining_capacity` FROM (`courses` `c` left join `record` `r` on(`c`.`coursecode` = `r`.`coursecode`)) WHERE `r`.`status` = 'enrolled' OR `r`.`status` is null GROUP BY `c`.`coursecode`, `c`.`capacity` ;

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
  ADD PRIMARY KEY (`info_id`,`coursecode`,`createdtime`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`info_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
