-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 30, 2021 at 05:31 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `krishconnect`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` varchar(50) NOT NULL,
  `content` mediumtext NOT NULL,
  `title` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `priority` varchar(20) NOT NULL,
  `last date` varchar(20) NOT NULL,
  `department` varchar(10) NOT NULL,
  `section` varchar(10) NOT NULL,
  `semester` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `announcement_responses`
--

CREATE TABLE `announcement_responses` (
  `id` varchar(100) NOT NULL,
  `registerNumber` varchar(25) NOT NULL,
  `response` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `deptName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `letter`
--

CREATE TABLE `letter` (
  `username` varchar(25) NOT NULL,
  `tutor` varchar(30) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `reason` varchar(200) NOT NULL,
  `proof` varchar(100) DEFAULT NULL,
  `accepted` int(11) DEFAULT NULL,
  `timestamps` datetime NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `name` varchar(40) NOT NULL,
  `phone_number` bigint(11) NOT NULL,
  `location` varchar(100) NOT NULL,
  `locationprivacy` tinyint(1) DEFAULT NULL,
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isTutor` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `staffsubject`
--

CREATE TABLE `staffsubject` (
  `staffname` varchar(40) DEFAULT NULL,
  `departmentName` varchar(50) DEFAULT NULL,
  `section` varchar(2) NOT NULL,
  `semester` int(2) NOT NULL,
  `subjectCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `register_number` varchar(40) NOT NULL,
  `name` varchar(25) NOT NULL,
  `phone_number` bigint(11) NOT NULL,
  `department` varchar(45) NOT NULL,
  `section` varchar(2) NOT NULL,
  `semester` int(2) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `location_privacy` tinyint(1) NOT NULL,
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `code` varchar(10) NOT NULL,
  `subjectName` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tutor`
--

CREATE TABLE `tutor` (
  `name` varchar(40) DEFAULT NULL,
  `department` varchar(40) NOT NULL,
  `section` varchar(2) NOT NULL,
  `semester` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `announcement_responses`
--
ALTER TABLE `announcement_responses`
  ADD KEY `foreign_key-0` (`id`),
  ADD KEY `foreign-key-1` (`registerNumber`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`deptName`);

--
-- Indexes for table `letter`
--
ALTER TABLE `letter`
  ADD PRIMARY KEY (`timestamps`),
  ADD KEY `roll_no_fk1` (`username`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `staffsubject`
--
ALTER TABLE `staffsubject`
  ADD KEY `staffname` (`staffname`),
  ADD KEY `departmentName` (`departmentName`),
  ADD KEY `subjectCode` (`subjectCode`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`register_number`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tutor`
--
ALTER TABLE `tutor`
  ADD KEY `name` (`name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcement_responses`
--
ALTER TABLE `announcement_responses`
  ADD CONSTRAINT `foreign-key-1` FOREIGN KEY (`registerNumber`) REFERENCES `login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foreign_key-0` FOREIGN KEY (`id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `letter`
--
ALTER TABLE `letter`
  ADD CONSTRAINT `roll_no_fk1` FOREIGN KEY (`username`) REFERENCES `student` (`register_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`name`) REFERENCES `login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staffsubject`
--
ALTER TABLE `staffsubject`
  ADD CONSTRAINT `staffsubject_ibfk_1` FOREIGN KEY (`staffname`) REFERENCES `login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `staffsubject_ibfk_2` FOREIGN KEY (`departmentName`) REFERENCES `department` (`deptName`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `staffsubject_ibfk_3` FOREIGN KEY (`subjectCode`) REFERENCES `subject` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `roll_no_fk` FOREIGN KEY (`register_number`) REFERENCES `login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tutor`
--
ALTER TABLE `tutor`
  ADD CONSTRAINT `tutor_ibfk_1` FOREIGN KEY (`name`) REFERENCES `login` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
