-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 11, 2023 at 06:09 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

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
CREATE DATABASE IF NOT EXISTS `csci3100` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `csci3100`;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `CourseCode` varchar(9) NOT NULL,
  `ClassId` varchar(1) NOT NULL,
  `InstructorId` int(12) NOT NULL,
  `ClassDescription` tinytext DEFAULT NULL,
  `ClassWebsite` text DEFAULT NULL,
  `CourseOutlineLink` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `class`:
--   `CourseCode`
--       `course` -> `CourseCode`
--   `InstructorId`
--       `users` -> `info_id`
--   `CourseCode`
--       `course` -> `CourseCode`
--   `InstructorId`
--       `users` -> `info_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `classevent`
--

CREATE TABLE `classevent` (
  `CourseCode` varchar(9) NOT NULL,
  `ClassId` varchar(1) NOT NULL,
  `EventId` varchar(5) NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `Venue` varchar(32) NOT NULL,
  `Weekday` set('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  `Capacity` int(11) NOT NULL,
  `Waitlist` tinyint(1) NOT NULL COMMENT 'true false only'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `classevent`:
--

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `CourseCode` varchar(9) NOT NULL,
  `CourseName` varchar(128) NOT NULL,
  `Description` varchar(512) NOT NULL,
  `Prerequisite` varchar(512) NOT NULL,
  `Department` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `course`:
--

-- --------------------------------------------------------

--
-- Table structure for table `operation`
--

CREATE TABLE `operation` (
  `CreatedTime` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'remember, no need insert this column, will automatically added',
  `OperationId` int(6) NOT NULL,
  `StudentId` int(12) NOT NULL,
  `CourseCode` varchar(9) NOT NULL,
  `ClassId` varchar(1) NOT NULL,
  `EventId` varchar(5) NOT NULL,
  `Staus` set('pending','waitlisted','rejected','dropped','enrolled') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `operation`:
--

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `CreatedTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `RequestId` int(6) NOT NULL,
  `info_id` int(12) NOT NULL,
  `Request` text NOT NULL,
  `Solved` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `request`:
--

-- --------------------------------------------------------

--
-- Table structure for table `semester`
--

CREATE TABLE `semester` (
  `Semester` int(1) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `semester`:
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `info_id` int(12) NOT NULL,
  `usertype` varchar(32) NOT NULL,
  `FullName` varchar(64) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `department` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `users`:
--

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`info_id`, `usertype`, `FullName`, `username`, `password`, `department`, `email`) VALUES
(554, 'student', '', 'Kim', '55664477', 'Cs', '123456@gmail.com'),
(1234, 'instructor', '', 'BobJohnson', 'Passw0rd!', 'Art', 'BobJohnson-p@example.com'),
(2222, 'student', '', 'JohnDoe', 'MyPa$$word', 'Electrical Engineering', 'JohnDoe-c@example.com'),
(4444, 'student', '', 'MaryLee', 'P@ssw0rd', 'Mathematics', 'MaryLee-c@example.com'),
(5678, 'admin', '', 'DavidBrown', 'S3cr3tP@ss', 'Biology', 'DavidBrown-s@example.com'),
(9999, 'admin', '', 'JaneSmith', 'S3cur3P@ss', 'Computer Science', 'JaneSmith-s@example.com'),
(12345, 'student', '', 'jdoe', 'password123', 'Computer Science', 'jdoe-c@example.com'),
(777888999, 'student', '', 'Tony Chan', '123456', 'CS', '123456@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`CourseCode`,`ClassId`),
  ADD KEY `InfoIdRestrict` (`InstructorId`);

--
-- Indexes for table `classevent`
--
ALTER TABLE `classevent`
  ADD PRIMARY KEY (`CourseCode`,`ClassId`,`EventId`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseCode`);

--
-- Indexes for table `operation`
--
ALTER TABLE `operation`
  ADD PRIMARY KEY (`OperationId`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`RequestId`);

--
-- Indexes for table `semester`
--
ALTER TABLE `semester`
  ADD PRIMARY KEY (`Semester`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`info_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `CourseCodeUpdate` FOREIGN KEY (`CourseCode`) REFERENCES `course` (`CourseCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `InfoIdRestrict` FOREIGN KEY (`InstructorId`) REFERENCES `users` (`info_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
