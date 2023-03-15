-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2023 at 06:13 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scrap_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `buyer`
--

CREATE TABLE `buyer` (
  `buyer_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buyer`
--

INSERT INTO `buyer` (`buyer_id`, `name`, `email`, `password`, `address`, `phone`) VALUES
(2, 'RajReddy', 'b@abc.com', '123', 'ifj', '7474464201');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `name`, `email`, `password`, `role`, `phone`) VALUES
(2, 'Mudeyya', 'c@abc.com', '123', 'Employee', '9452687643');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `scrap_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `buyer_id`, `vendor_id`, `scrap_id`, `type`, `quantity`, `price`, `status`, `timestamp`) VALUES
(35, 2, 4, 10, '1', 1, '20.00', 'pending', '2023-01-31 12:36:01');

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `new_order_trigger` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
  DECLARE buyer_name VARCHAR(255);

  SELECT name INTO buyer_name
  FROM buyer
  WHERE buyer_id = NEW.buyer_id;

  INSERT INTO trigger_name (order_id, buyer_name, timestamp)
  VALUES (NEW.order_id, buyer_name, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `scrap`
--

CREATE TABLE `scrap` (
  `scrap_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `quantity` float NOT NULL,
  `price` float NOT NULL,
  `other_details` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scrap`
--

INSERT INTO `scrap` (`scrap_id`, `vendor_id`, `type`, `quantity`, `price`, `other_details`) VALUES
(10, 4, '1', 1, 20, 'Steel'),
(13, 4, '2', 1, 15, 'Paper'),
(14, 5, '21', 1, 24, 'Copper\r\n'),
(15, 5, '22', 1, 18, 'Dairy packets');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `vendor_id`, `buyer_id`, `type`, `quantity`, `price`, `date`, `status`) VALUES
(5, 4, 2, '4', 1, '15.00', '2023-01-28', '0'),
(6, 4, 2, '4', 1, '15.00', '2023-01-28', '0'),
(7, 5, 2, '21', 1, '24.00', '2023-01-28', '0'),
(8, 5, 2, '21', 1, '24.00', '2023-01-28', '0'),
(9, 4, 2, '1', 1, '20.00', '2023-01-30', '0'),
(10, 4, 2, '1', 1, '20.00', '2023-01-30', '0');

-- --------------------------------------------------------

--
-- Table structure for table `trigger_name`
--

CREATE TABLE `trigger_name` (
  `order_id` int(11) NOT NULL,
  `buyer_name` varchar(255) NOT NULL,
  `timestamp` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trigger_name`
--

INSERT INTO `trigger_name` (`order_id`, `buyer_name`, `timestamp`) VALUES
(35, 'RajReddy', '2023-01-31');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `vendor_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`vendor_id`, `name`, `email`, `password`, `address`, `phone`) VALUES
(4, 'Mudanna Halsur', 'a@abc.com', '123', 'xyz', '9742453654'),
(5, 'Jyothi Raj', 'a2@abc.com', '123', 'qwe', '7483772978');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buyer`
--
ALTER TABLE `buyer`
  ADD PRIMARY KEY (`buyer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `buyer_id` (`buyer_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `scrap_id` (`scrap_id`);

--
-- Indexes for table `scrap`
--
ALTER TABLE `scrap`
  ADD PRIMARY KEY (`scrap_id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `trigger_name`
--
ALTER TABLE `trigger_name`
  ADD KEY `abc` (`order_id`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`vendor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buyer`
--
ALTER TABLE `buyer`
  MODIFY `buyer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `scrap`
--
ALTER TABLE `scrap`
  MODIFY `scrap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `vendor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buyer`
--
ALTER TABLE `buyer`
  ADD CONSTRAINT `buyer_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `buyer` (`buyer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`scrap_id`) REFERENCES `scrap` (`scrap_id`);

--
-- Constraints for table `scrap`
--
ALTER TABLE `scrap`
  ADD CONSTRAINT `scrap_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `buyer` (`buyer_id`);

--
-- Constraints for table `trigger_name`
--
ALTER TABLE `trigger_name`
  ADD CONSTRAINT `abc` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
