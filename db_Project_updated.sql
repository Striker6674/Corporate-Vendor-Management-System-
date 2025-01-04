-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: corporate_vendor_managment_system
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `budget`
--

DROP TABLE IF EXISTS `budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budget` (
  `BudgetID` int NOT NULL AUTO_INCREMENT,
  `DepartmentID` int NOT NULL,
  `TotalBudget` decimal(10,2) NOT NULL,
  `Expenditure` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`BudgetID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `budget_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budget`
--

LOCK TABLES `budget` WRITE;
/*!40000 ALTER TABLE `budget` DISABLE KEYS */;
INSERT INTO `budget` VALUES (1,1,50000.00,20000.00),(2,2,75000.00,3000.00),(3,3,60000.00,20000.00);
/*!40000 ALTER TABLE `budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complianceaudit`
--

DROP TABLE IF EXISTS `complianceaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complianceaudit` (
  `AuditID` int NOT NULL AUTO_INCREMENT,
  `VendorID` int NOT NULL,
  `AuditDate` date NOT NULL,
  `Result` varchar(50) NOT NULL,
  `Comments` text,
  PRIMARY KEY (`AuditID`),
  KEY `VendorID` (`VendorID`),
  CONSTRAINT `complianceaudit_ibfk_1` FOREIGN KEY (`VendorID`) REFERENCES `vendor` (`VendorID`) ON DELETE CASCADE,
  CONSTRAINT `complianceaudit_chk_1` CHECK ((`Result` in (_utf8mb4'Pass',_utf8mb4'Fail',_utf8mb4'Pending')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complianceaudit`
--

LOCK TABLES `complianceaudit` WRITE;
/*!40000 ALTER TABLE `complianceaudit` DISABLE KEYS */;
INSERT INTO `complianceaudit` VALUES (1,1,'2024-03-15','Pass','Vendor meets all compliance requirements.'),(2,2,'2024-03-20','Pending','Awaiting documentation for ISO certification renewal.'),(3,3,'2024-03-10','Fail','Vendor failed to provide necessary safety certifications.');
/*!40000 ALTER TABLE `complianceaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract` (
  `ContractID` int NOT NULL AUTO_INCREMENT,
  `VendorID` int NOT NULL,
  `Terms` text,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `RenewalDate` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ContractID`),
  KEY `VendorID` (`VendorID`),
  CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`VendorID`) REFERENCES `vendor` (`VendorID`) ON DELETE CASCADE,
  CONSTRAINT `chk_EndDate` CHECK ((`EndDate` > `StartDate`))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (1,1,'Annual maintenance and supply agreement.','2024-01-01','2024-12-31','2024-11-30','Active'),(2,2,'Quarterly office supplies.','2024-01-01','2024-03-31','2024-03-15','Active'),(3,3,'Logistics partnership agreement.','2024-01-01','2024-12-31','2024-11-30','Active'),(4,4,'Quarterly office supplies 2.0.','2024-11-01','2025-01-05','2024-12-31','Expired');
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DepartmentID` int NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(100) NOT NULL,
  `AllocatedBudget` decimal(10,2) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'IT Department',50000.00),(2,'Procurement',75000.00),(3,'Logistics',60000.00);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `NotificationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `Message` text NOT NULL,
  `IsRead` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NotificationID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,1,'Contract #1 is due for renewal in 30 days.',0,'2024-11-22 17:53:29'),(2,2,'Purchase Order #2 has exceeded the allocated budget.',0,'2024-11-22 17:53:29'),(3,3,'Vendor #3 has submitted a new compliance certification.',0,'2024-11-22 17:53:29');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `performance`
--

DROP TABLE IF EXISTS `performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `performance` (
  `PerformanceID` int NOT NULL AUTO_INCREMENT,
  `VendorID` int NOT NULL,
  `Rating` decimal(3,2) NOT NULL,
  `Feedback` text,
  PRIMARY KEY (`PerformanceID`),
  KEY `VendorID` (`VendorID`),
  CONSTRAINT `performance_ibfk_1` FOREIGN KEY (`VendorID`) REFERENCES `vendor` (`VendorID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `performance`
--

LOCK TABLES `performance` WRITE;
/*!40000 ALTER TABLE `performance` DISABLE KEYS */;
INSERT INTO `performance` VALUES (1,1,4.50,'Reliable and prompt service.'),(2,2,4.00,'Good quality supplies.'),(3,3,4.70,'Efficient and timely delivery.');
/*!40000 ALTER TABLE `performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseorder`
--

DROP TABLE IF EXISTS `purchaseorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseorder` (
  `POID` int NOT NULL AUTO_INCREMENT,
  `ContractID` int NOT NULL,
  `DepartmentID` int NOT NULL,
  `Items` text,
  `TotalCost` decimal(10,2) NOT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`POID`),
  KEY `ContractID` (`ContractID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `purchaseorder_ibfk_1` FOREIGN KEY (`ContractID`) REFERENCES `contract` (`ContractID`) ON DELETE CASCADE,
  CONSTRAINT `purchaseorder_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorder`
--

LOCK TABLES `purchaseorder` WRITE;
/*!40000 ALTER TABLE `purchaseorder` DISABLE KEYS */;
INSERT INTO `purchaseorder` VALUES (1,1,1,'Desktops, Laptops',15000.00,'Fulfilled'),(2,2,2,'Stationery, Paper',3000.00,'Pending'),(3,3,3,'Transportation services',20000.00,'In Progress'),(5,1,3,'laptops,mobile',1000.00,'Fulfilled');
/*!40000 ALTER TABLE `purchaseorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `TaskID` int NOT NULL AUTO_INCREMENT,
  `AssignedTo` int NOT NULL,
  `DepartmentID` int NOT NULL,
  `Description` text NOT NULL,
  `Status` varchar(50) NOT NULL,
  `DueDate` date DEFAULT NULL,
  PRIMARY KEY (`TaskID`),
  KEY `AssignedTo` (`AssignedTo`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`AssignedTo`) REFERENCES `user` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`) ON DELETE CASCADE,
  CONSTRAINT `task_chk_1` CHECK ((`Status` in (_utf8mb4'Pending',_utf8mb4'In Progress',_utf8mb4'Completed')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (2,3,3,'Schedule compliance audit for Vendor #1.','In Progress','2024-04-15'),(3,1,1,'Update contract terms for Vendor #2.','Pending','2024-06-01');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Role` enum('Admin','Procurement Manager','Department Head','Vendor') NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin','John Doe','admin@example.com','$2b$10$eX5A7L1NwGx.z7yJMeLv3eY1FqCpTp1msxfrUQ0OwD1T/n5PKBxKu',NULL,NULL),(2,'Procurement Manager','Jane Smith','jane.smith@example.com','defaultpassword',NULL,NULL),(3,'Department Head','Michael Johnson','michael.johnson@example.com','defaultpassword',NULL,NULL),(7,'Vendor','Alice Vendor','alice@techsuppliesco.com','8d7cf17d5bec277ad4f7e2c491cfb8b3446b3ceff77055844387590884ca86b2',NULL,NULL),(8,'Vendor','Bob Vendor','bob@officeessentials.com','411a37a65021fe5f72bc7db32eb39131894decccd4c4a8e331145e03ad158a63',NULL,NULL),(9,'Vendor','Charlie Vendor','charlie@logisticsolutions.com','dc33cd136b7f301d9d4ccdbdae5eeaaf1414ba356f008f718b48b474e074e854',NULL,NULL),(10,'Vendor','Hussain Ahmad','i221374@nu.edu.pk','61bfe574ea615ee3847c735bffb725b526a5a02c1a91613d867e72d15ab5a3ad',NULL,NULL),(11,'Department Head','Asad Ullah','octablood@gmail.com','b7e29dbd0415cae27b4eb1bae012951c42da58b1423114fffca75919685b2e9b',NULL,NULL),(12,'Department Head','Sami Naeem','octablood67@gmail.com','$2b$10$2WhFRWDfWS2NLEfITUviruQ8qyhADpMxHjQeYCPm9ITEYCH/eJ6ga',NULL,NULL),(13,'Admin','Hussain Ahmad','abcd@gmail.com','$2b$10$4z4a4xFPJ4W08VO/09WkGuH9PIKyQ1JYmfT2J0HznD00icFJWjqhe',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `VendorID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `ContactDetails` varchar(255) NOT NULL,
  `ServiceCategory` varchar(100) DEFAULT NULL,
  `ComplianceCertification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`VendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (1,'Tech Supplies Co.','123-456-7890','IT Equipment','ISO 9001'),(2,'Office Essentials Ltd.','234-567-8901','Office Supplies','ISO 14001'),(3,'Logistics Solutions Inc.','345-678-9012','Logistics','ISO 45001'),(4,'Office Essentials Ltd 2.0','111-111-1111','Aviation','ISO 45002'),(5,'Tech Supplies Co2.0.','123-456-7891','Office Supplies','ISO 45003'),(6,'Tech Supplies Co2.1.','123-456-7777','Hotel','ISO 9000');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-01  9:49:20
