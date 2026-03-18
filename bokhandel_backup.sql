-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: bokhandel
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'c863c45b-bf9c-11f0-a1e5-005056c00001:1-269';

--
-- Table structure for table `bestallningar`
--

DROP TABLE IF EXISTS `bestallningar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallningar` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Datum` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Totalbelopp` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `bestallningar_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`) ON DELETE CASCADE,
  CONSTRAINT `bestallningar_chk_1` CHECK ((`Totalbelopp` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallningar`
--

LOCK TABLES `bestallningar` WRITE;
/*!40000 ALTER TABLE `bestallningar` DISABLE KEYS */;
INSERT INTO `bestallningar` VALUES (1,1,'2026-03-18 10:02:44',39.98),(2,2,'2026-03-18 10:02:44',17.99),(3,4,'2026-03-18 10:02:44',56.97),(4,1,'2026-03-18 10:02:44',18.99);
/*!40000 ALTER TABLE `bestallningar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bocker`
--

DROP TABLE IF EXISTS `bocker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bocker` (
  `BokID` int NOT NULL AUTO_INCREMENT,
  `Titel` varchar(100) NOT NULL,
  `ISBN` char(13) NOT NULL,
  `Forfattare` varchar(100) NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  `Lagerstatus` int NOT NULL,
  PRIMARY KEY (`BokID`),
  UNIQUE KEY `ISBN` (`ISBN`),
  CONSTRAINT `bocker_chk_1` CHECK ((`Pris` > 0)),
  CONSTRAINT `bocker_chk_2` CHECK ((`Lagerstatus` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bocker`
--

LOCK TABLES `bocker` WRITE;
/*!40000 ALTER TABLE `bocker` DISABLE KEYS */;
INSERT INTO `bocker` VALUES (1,'Hobbit','9780345445605','J R R Tolkien',19.99,8),(2,'1984','9780141036144','George Orwell',18.99,1),(3,'Project Hail Mary','9780593135228','Andy Weir',17.99,19);
/*!40000 ALTER TABLE `bocker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunder`
--

DROP TABLE IF EXISTS `kunder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunder` (
  `KundID` int NOT NULL AUTO_INCREMENT,
  `Namn` varchar(100) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Telefon` varchar(20) DEFAULT NULL,
  `Adress` varchar(255) NOT NULL,
  PRIMARY KEY (`KundID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `index_email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunder`
--

LOCK TABLES `kunder` WRITE;
/*!40000 ALTER TABLE `kunder` DISABLE KEYS */;
INSERT INTO `kunder` VALUES (1,'Anna Andersson','anna@mail.com','1234567890','Adress1'),(2,'Erik Svensson','erik@mail.com','1224567890','Adress2'),(3,'Lisa Berg','nyemail@mail.com','1034567800','Adress3'),(4,'Clas Ohlson','cl@mail.com','5554567800','Adress4');
/*!40000 ALTER TABLE `kunder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `logga_ny_kund` AFTER INSERT ON `kunder` FOR EACH ROW BEGIN
   INSERT INTO Kundlogg (KundID, Handelse)
   VALUES (NEW.KundID, CONCAT('Ny kund: ', NEW.Namn));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `LoggID` int NOT NULL AUTO_INCREMENT,
  `KundID` int DEFAULT NULL,
  `Handelse` varchar(255) DEFAULT NULL,
  `Loggdatum` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LoggID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `kundlogg_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,1,'Ny kund: Anna Andersson','2026-03-18 10:02:44'),(2,2,'Ny kund: Erik Svensson','2026-03-18 10:02:44'),(3,3,'Ny kund: Lisa Berg','2026-03-18 10:02:44'),(4,4,'Ny kund: Clas Ohlson','2026-03-18 10:02:44');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrader`
--

DROP TABLE IF EXISTS `orderrader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderrader` (
  `OrderradID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `BokID` int NOT NULL,
  `Antal` int NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderradID`),
  KEY `OrderID` (`OrderID`),
  KEY `BokID` (`BokID`),
  CONSTRAINT `orderrader_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `bestallningar` (`OrderID`) ON DELETE CASCADE,
  CONSTRAINT `orderrader_ibfk_2` FOREIGN KEY (`BokID`) REFERENCES `bocker` (`BokID`) ON DELETE CASCADE,
  CONSTRAINT `orderrader_chk_1` CHECK ((`Antal` > 0)),
  CONSTRAINT `orderrader_chk_2` CHECK ((`Pris` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrader`
--

LOCK TABLES `orderrader` WRITE;
/*!40000 ALTER TABLE `orderrader` DISABLE KEYS */;
INSERT INTO `orderrader` VALUES (1,1,1,2,19.99),(2,2,3,1,17.99),(3,3,2,3,18.99),(4,4,2,1,18.99);
/*!40000 ALTER TABLE `orderrader` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `uppdatera_lager` AFTER INSERT ON `orderrader` FOR EACH ROW BEGIN
   UPDATE Bocker
   SET Lagerstatus = Lagerstatus - NEW.Antal
   WHERE BokID = NEW.BokID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'bokhandel'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18 11:05:16
