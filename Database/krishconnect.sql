-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2021 at 06:41 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

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
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `deptName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`deptName`) VALUES
('Civil Engineering'),
('Computer Science and Business Studies'),
('Computer Science and Engineering'),
('Electrical and Electronics Engineering'),
('Electronic and Communication Engineering'),
('Information Technology'),
('Mechanical Engineering'),
('Mechatronics Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`username`, `password`) VALUES
('asdfghjkl', 'asdfghjkl');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `name` varchar(40) NOT NULL,
  `phone_number` bigint(11) NOT NULL,
  `loaction` varchar(100) DEFAULT NULL,
  `locationprivacy` tinyint(1) DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `isTutor` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`name`, `phone_number`, `loaction`, `locationprivacy`, `last_seen`, `isTutor`) VALUES
('asdfghjkl', 8667802637, NULL, 0, NULL, 0);

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

--
-- Dumping data for table `staffsubject`
--

INSERT INTO `staffsubject` (`staffname`, `departmentName`, `section`, `semester`, `subjectCode`) VALUES
('asdfghjkl', 'Computer Science and Engineering', 'A', 2, 'C');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `register_number` varchar(40) DEFAULT NULL,
  `phone_number` bigint(11) NOT NULL,
  `department` varchar(45) NOT NULL,
  `section` varchar(2) NOT NULL,
  `semester` int(2) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `location_privacy` tinyint(1) NOT NULL,
  `last_seen` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `code` varchar(10) NOT NULL,
  `subjectName` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`code`, `subjectName`) VALUES
('A', 'A'),
('B', 'B'),
('C', 'C');

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
-- Dumping data for table `tutor`
--

INSERT INTO `tutor` (`name`, `department`, `section`, `semester`) VALUES
('asdfghjkl', 'Mechanical Engineering', 'A', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`deptName`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD KEY `name` (`name`);

--
-- Indexes for table `staffsubject`
--
ALTER TABLE `staffsubject`
  ADD KEY `staffname` (`staffname`),
  ADD KEY `departmentName` (`departmentName`),
  ADD KEY `subjectCode` (`subjectCode`);

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
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`name`) REFERENCES `login` (`username`);

--
-- Constraints for table `staffsubject`
--
ALTER TABLE `staffsubject`
  ADD CONSTRAINT `staffsubject_ibfk_1` FOREIGN KEY (`staffname`) REFERENCES `login` (`username`),
  ADD CONSTRAINT `staffsubject_ibfk_2` FOREIGN KEY (`departmentName`) REFERENCES `department` (`deptName`),
  ADD CONSTRAINT `staffsubject_ibfk_3` FOREIGN KEY (`subjectCode`) REFERENCES `subject` (`code`);

--
-- Constraints for table `tutor`
--
ALTER TABLE `tutor`
  ADD CONSTRAINT `tutor_ibfk_1` FOREIGN KEY (`name`) REFERENCES `login` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
