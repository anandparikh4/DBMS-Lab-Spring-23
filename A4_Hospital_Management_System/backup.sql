-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: 20CS30065
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_admission`
--

DROP TABLE IF EXISTS `accounts_admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_admission` (
  `Admission_ID` int NOT NULL AUTO_INCREMENT,
  `Patient_Email` varchar(255) NOT NULL,
  `Room_ID` int NOT NULL,
  `Start` datetime NOT NULL,
  `End` datetime NOT NULL,
  `PCP_Email` varchar(255) NOT NULL,
  `Total_Cost` int DEFAULT NULL,
  PRIMARY KEY (`Admission_ID`),
  KEY `Patient_Email` (`Patient_Email`),
  KEY `PCP_Email` (`PCP_Email`),
  KEY `Room_ID` (`Room_ID`),
  CONSTRAINT `accounts_admission_ibfk_1` FOREIGN KEY (`Patient_Email`) REFERENCES `accounts_patient` (`Email_ID`),
  CONSTRAINT `accounts_admission_ibfk_2` FOREIGN KEY (`PCP_Email`) REFERENCES `accounts_physician` (`Email_ID`),
  CONSTRAINT `accounts_admission_ibfk_3` FOREIGN KEY (`Room_ID`) REFERENCES `accounts_room` (`Room_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_admission`
--

LOCK TABLES `accounts_admission` WRITE;
/*!40000 ALTER TABLE `accounts_admission` DISABLE KEYS */;
INSERT INTO `accounts_admission` VALUES (15,'pranavmehrotra@kgpian.iitkgp.ac.in',4,'2023-02-27 20:23:00','2023-03-01 16:00:07','abc@gmail.com',20),(17,'s2@test.com',4,'2023-02-11 00:06:00','2023-03-01 18:36:34','abc@gmail.com',360),(18,'pranav.nssc@gmail.com',4,'2023-03-01 22:27:00','2023-03-02 16:57:53','xyz@gmail.com',0),(19,'pranav.nssc@gmail.com',4,'2023-03-04 20:00:00','2023-03-04 20:00:00','abc@gmail.com',NULL),(20,'pran@gmail.com',5,'2023-03-01 02:30:00','2023-03-02 18:54:49','abc@gmail.com',100),(21,'pran@gmail.com',5,'2023-03-03 04:30:00','2023-03-03 04:30:00','abc@gmail.com',NULL);
/*!40000 ALTER TABLE `accounts_admission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_appointment`
--

DROP TABLE IF EXISTS `accounts_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_appointment` (
  `Appointment_ID` int NOT NULL AUTO_INCREMENT,
  `Patient_Email` varchar(255) NOT NULL,
  `Physician_Email` varchar(255) NOT NULL,
  `Start` datetime NOT NULL,
  `Appointment_Fee` int DEFAULT NULL,
  PRIMARY KEY (`Appointment_ID`),
  KEY `Patient_Email` (`Patient_Email`),
  KEY `Physician_Email` (`Physician_Email`),
  CONSTRAINT `accounts_appointment_ibfk_1` FOREIGN KEY (`Patient_Email`) REFERENCES `accounts_patient` (`Email_ID`),
  CONSTRAINT `accounts_appointment_ibfk_2` FOREIGN KEY (`Physician_Email`) REFERENCES `accounts_physician` (`Email_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_appointment`
--

LOCK TABLES `accounts_appointment` WRITE;
/*!40000 ALTER TABLE `accounts_appointment` DISABLE KEYS */;
INSERT INTO `accounts_appointment` VALUES (1,'pranavmehrotra@kgpian.iitkgp.ac.in','abc@gmail.com','2023-03-01 12:00:00',200),(2,'pranav.nssc@gmail.com','abc@gmail.com','2023-03-01 17:35:39',200),(3,'pranavmehrotra@kgpian.iitkgp.ac.in','abc@gmail.com','2023-03-01 18:00:00',300),(4,'s2@test.com','abc@gmail.com','2023-03-02 12:00:00',NULL),(11,'pranav.nssc@gmail.com','abc@gmail.com','2023-03-02 11:00:00',NULL),(12,'pranavmehrotra@kgpian.iitkgp.ac.in','abc@gmail.com','2023-03-04 15:00:00',NULL),(13,'pranavmehrotra@kgpian.iitkgp.ac.in','abc@gmail.com','2023-03-06 11:00:00',NULL),(17,'pran@gmail.com','abc@gmail.com','2023-03-03 14:00:00',210),(18,'pranavmehrotra@kgpian.iitkgp.ac.in','abc@gmail.com','2023-03-03 11:00:00',200);
/*!40000 ALTER TABLE `accounts_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_data_entry`
--

DROP TABLE IF EXISTS `accounts_data_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_data_entry` (
  `Email_ID` varchar(255) NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL,
  `Employee_ID` int NOT NULL,
  `Password` varchar(512) NOT NULL,
  PRIMARY KEY (`Email_ID`),
  UNIQUE KEY `Employee_ID` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_data_entry`
--

LOCK TABLES `accounts_data_entry` WRITE;
/*!40000 ALTER TABLE `accounts_data_entry` DISABLE KEYS */;
INSERT INTO `accounts_data_entry` VALUES ('s1@gmail.com','SARANSH','SHARMA',33,'pbkdf2_sha256$320000$ouzf0D2q7wmgRmEEDSZxjY$mQ3Qzg8NYcXxpZjMX1MuTfXL9LqvwPWYc8w+TiZIz5M=');
/*!40000 ALTER TABLE `accounts_data_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_db_admin`
--

DROP TABLE IF EXISTS `accounts_db_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_db_admin` (
  `Username` varchar(255) NOT NULL,
  `Password` varchar(512) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_db_admin`
--

LOCK TABLES `accounts_db_admin` WRITE;
/*!40000 ALTER TABLE `accounts_db_admin` DISABLE KEYS */;
INSERT INTO `accounts_db_admin` VALUES ('admin','admin'),('user','placement');
/*!40000 ALTER TABLE `accounts_db_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_front_desk`
--

DROP TABLE IF EXISTS `accounts_front_desk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_front_desk` (
  `Email_ID` varchar(255) NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL,
  `Employee_ID` int NOT NULL,
  `Password` varchar(512) NOT NULL,
  PRIMARY KEY (`Email_ID`),
  UNIQUE KEY `Employee_ID` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_front_desk`
--

LOCK TABLES `accounts_front_desk` WRITE;
/*!40000 ALTER TABLE `accounts_front_desk` DISABLE KEYS */;
INSERT INTO `accounts_front_desk` VALUES ('alumni1@test.com','RAM','MEHRA',23,'pbkdf2_sha256$320000$EtKFahBYEb7tHqLNKVLtgW$o3//8pKYhBFjH/O90uVa8VyFoudLIHP81Tb/RY1NsxE='),('s2@gmail.com','SARANSH','JI',999,'pbkdf2_sha256$320000$z03sfdbd6lGCuWaUWM88rA$q/fRT9OvYTvw1rQRUb71JfQH08yyji8MQKTsWBXfUDo='),('t2@test.com','EBERG','EHTRR',32432,'pbkdf2_sha256$320000$m2Q84IPz4L5DJ6t8F76Bp1$A5x9zze4DldYXWoCE6k4GPxJ7KfJTR3vAJjZl2gHyYU=');
/*!40000 ALTER TABLE `accounts_front_desk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_health_record`
--

DROP TABLE IF EXISTS `accounts_health_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_health_record` (
  `Record_ID` int NOT NULL AUTO_INCREMENT,
  `Admission_ID` int NOT NULL,
  `Date` datetime NOT NULL,
  `Vitals` text,
  `Remarks` text,
  PRIMARY KEY (`Record_ID`),
  KEY `Admission_ID` (`Admission_ID`),
  CONSTRAINT `accounts_health_record_ibfk_1` FOREIGN KEY (`Admission_ID`) REFERENCES `accounts_admission` (`Admission_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_health_record`
--

LOCK TABLES `accounts_health_record` WRITE;
/*!40000 ALTER TABLE `accounts_health_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_health_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_patient`
--

DROP TABLE IF EXISTS `accounts_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_patient` (
  `Email_ID` varchar(255) NOT NULL,
  `SSN` int NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Insurance_ID` int DEFAULT NULL,
  `Phone` varchar(15) NOT NULL,
  `Age` int NOT NULL,
  `Blood_Group` varchar(8) DEFAULT NULL,
  `Status` int NOT NULL,
  `Gender` varchar(255) NOT NULL,
  PRIMARY KEY (`Email_ID`),
  UNIQUE KEY `SSN` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_patient`
--

LOCK TABLES `accounts_patient` WRITE;
/*!40000 ALTER TABLE `accounts_patient` DISABLE KEYS */;
INSERT INTO `accounts_patient` VALUES ('pran@gmail.com',2037302332,'Shreyas','Jena','Durgapur',270404,'9473256748',20,'B-',1,'Male'),('pranav.nssc@gmail.com',21423,'Ram','Mehra','39-A , CIVIL LINES',423423,'09451808519',23,'A+',1,'Male'),('pranavmehrotra@kgpian.iitkgp.ac.in',231313,'Pranav','Mehrotra','139',21313,'9670070737',23,'AB+',2,'Male'),('s2@test.com',21324,'Ram','Mehra','39-A , CIVIL LINES',34324,'9451808519',34,'O+',2,'Male');
/*!40000 ALTER TABLE `accounts_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_physician`
--

DROP TABLE IF EXISTS `accounts_physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_physician` (
  `Email_ID` varchar(255) NOT NULL,
  `Employee_ID` int NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL,
  `Department` varchar(255) NOT NULL,
  `Position` varchar(255) NOT NULL,
  `Password` varchar(512) NOT NULL,
  PRIMARY KEY (`Email_ID`),
  UNIQUE KEY `Employee_ID` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_physician`
--

LOCK TABLES `accounts_physician` WRITE;
/*!40000 ALTER TABLE `accounts_physician` DISABLE KEYS */;
INSERT INTO `accounts_physician` VALUES ('abc@gmail.com',2001,'RAJAT','JAIN','Dermatology','PHYSICIAN','pbkdf2_sha256$320000$Ng4PChAv2YDz5OztTVWz5I$sAue2XZ8aEoG+bqkjjj2YWCiM8seDp4W5gxQpWCH3j8='),('s1@gmail.com',12,'SARANSH','SHARMA','cardiology','HEAD','pbkdf2_sha256$320000$r6eNlwAz2iCCRcLoHM2vyw$ljp0K4zg9j4AJ5qCbi+Q/n0gBptyPYNkL3PpSTfURqM='),('xyz@gmail.com',2000,'PRANAV','NYATI','Cardiology','SURGEON','pbkdf2_sha256$320000$Xpx5mrhhzYaTvLweEXHBMH$jA/nCE0R2TQjhG8XSA36KfnBOzuKiRG8I6U95MlciK8=');
/*!40000 ALTER TABLE `accounts_physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_prescribes`
--

DROP TABLE IF EXISTS `accounts_prescribes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_prescribes` (
  `Prescribe_ID` int NOT NULL AUTO_INCREMENT,
  `Physician_Email` varchar(255) NOT NULL,
  `Patient_Email` varchar(255) NOT NULL,
  `Date` datetime NOT NULL,
  `Prescription` text NOT NULL,
  PRIMARY KEY (`Prescribe_ID`),
  KEY `Patient_Email` (`Patient_Email`),
  KEY `Physician_Email` (`Physician_Email`),
  CONSTRAINT `accounts_prescribes_ibfk_1` FOREIGN KEY (`Patient_Email`) REFERENCES `accounts_patient` (`Email_ID`),
  CONSTRAINT `accounts_prescribes_ibfk_2` FOREIGN KEY (`Physician_Email`) REFERENCES `accounts_physician` (`Email_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_prescribes`
--

LOCK TABLES `accounts_prescribes` WRITE;
/*!40000 ALTER TABLE `accounts_prescribes` DISABLE KEYS */;
INSERT INTO `accounts_prescribes` VALUES (1,'abc@gmail.com','pranavmehrotra@kgpian.iitkgp.ac.in','2023-03-01 13:23:00','eewewr'),(2,'abc@gmail.com','pranav.nssc@gmail.com','2023-03-03 05:40:00','eodkep'),(3,'abc@gmail.com','pran@gmail.com','2023-03-04 15:30:00','wekdwd'),(4,'abc@gmail.com','pranavmehrotra@kgpian.iitkgp.ac.in','2023-03-02 07:50:00','Dolo-650 -> 5 days (3 times a day)\r\nAzithral -> 500 (1 times a day)\r\nZircold-CZ -> (2 times a day)');
/*!40000 ALTER TABLE `accounts_prescribes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_room`
--

DROP TABLE IF EXISTS `accounts_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_room` (
  `Room_ID` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) NOT NULL,
  `Room_Name` varchar(255) NOT NULL,
  `Capacity` int NOT NULL,
  `Cost` int NOT NULL,
  PRIMARY KEY (`Room_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_room`
--

LOCK TABLES `accounts_room` WRITE;
/*!40000 ALTER TABLE `accounts_room` DISABLE KEYS */;
INSERT INTO `accounts_room` VALUES (4,'Maternity','C-201',0,20),(5,'General Ward','GW-1',9,100);
/*!40000 ALTER TABLE `accounts_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_tested`
--

DROP TABLE IF EXISTS `accounts_tested`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_tested` (
  `Tested_ID` int NOT NULL AUTO_INCREMENT,
  `Patient_Email` varchar(255) NOT NULL,
  `Test_ID` int NOT NULL,
  `Date` datetime NOT NULL,
  `Test_Result` text,
  PRIMARY KEY (`Tested_ID`),
  KEY `Patient_Email` (`Patient_Email`),
  KEY `Test_ID` (`Test_ID`),
  CONSTRAINT `accounts_tested_ibfk_1` FOREIGN KEY (`Patient_Email`) REFERENCES `accounts_patient` (`Email_ID`),
  CONSTRAINT `accounts_tested_ibfk_2` FOREIGN KEY (`Test_ID`) REFERENCES `accounts_tests` (`Test_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_tested`
--

LOCK TABLES `accounts_tested` WRITE;
/*!40000 ALTER TABLE `accounts_tested` DISABLE KEYS */;
INSERT INTO `accounts_tested` VALUES (1,'pranavmehrotra@kgpian.iitkgp.ac.in',3,'2023-03-03 13:00:00','kdkdkdk'),(2,'pran@gmail.com',3,'2023-03-03 13:00:00','kssls');
/*!40000 ALTER TABLE `accounts_tested` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_tests`
--

DROP TABLE IF EXISTS `accounts_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_tests` (
  `Test_ID` int NOT NULL AUTO_INCREMENT,
  `Test_Name` varchar(255) NOT NULL,
  `Cost` int NOT NULL,
  PRIMARY KEY (`Test_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_tests`
--

LOCK TABLES `accounts_tests` WRITE;
/*!40000 ALTER TABLE `accounts_tests` DISABLE KEYS */;
INSERT INTO `accounts_tests` VALUES (1,'MRI',5000),(2,'Blood Test',200),(3,'Endoscopy',2000),(4,'RT-PCR',300);
/*!40000 ALTER TABLE `accounts_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_treatment`
--

DROP TABLE IF EXISTS `accounts_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_treatment` (
  `Treatment_ID` int NOT NULL AUTO_INCREMENT,
  `Treatment_Name` varchar(255) NOT NULL,
  `Cost` int NOT NULL,
  PRIMARY KEY (`Treatment_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_treatment`
--

LOCK TABLES `accounts_treatment` WRITE;
/*!40000 ALTER TABLE `accounts_treatment` DISABLE KEYS */;
INSERT INTO `accounts_treatment` VALUES (1,'Angioplasty',50000),(2,'Brain Tumor Surgery',80000),(3,'Bypass Surgery',120000);
/*!40000 ALTER TABLE `accounts_treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_undergoes`
--

DROP TABLE IF EXISTS `accounts_undergoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_undergoes` (
  `Undergoes_ID` int NOT NULL AUTO_INCREMENT,
  `Patient_Email` varchar(255) NOT NULL,
  `Treatment_ID` int NOT NULL,
  `Physician_Email` varchar(255) NOT NULL,
  `Date` datetime NOT NULL,
  `Remarks` text,
  PRIMARY KEY (`Undergoes_ID`),
  KEY `Treatment_ID` (`Treatment_ID`),
  KEY `Patient_Email` (`Patient_Email`),
  KEY `Physician_Email` (`Physician_Email`),
  CONSTRAINT `accounts_undergoes_ibfk_1` FOREIGN KEY (`Treatment_ID`) REFERENCES `accounts_treatment` (`Treatment_ID`),
  CONSTRAINT `accounts_undergoes_ibfk_2` FOREIGN KEY (`Patient_Email`) REFERENCES `accounts_patient` (`Email_ID`),
  CONSTRAINT `accounts_undergoes_ibfk_3` FOREIGN KEY (`Physician_Email`) REFERENCES `accounts_physician` (`Email_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_undergoes`
--

LOCK TABLES `accounts_undergoes` WRITE;
/*!40000 ALTER TABLE `accounts_undergoes` DISABLE KEYS */;
INSERT INTO `accounts_undergoes` VALUES (1,'pran@gmail.com',1,'abc@gmail.com','2023-03-03 16:00:00','skks');
/*!40000 ALTER TABLE `accounts_undergoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add db_admin',1,'add_db_admin'),(2,'Can change db_admin',1,'change_db_admin'),(3,'Can delete db_admin',1,'delete_db_admin'),(4,'Can view db_admin',1,'view_db_admin'),(5,'Can add front_desk',2,'add_front_desk'),(6,'Can change front_desk',2,'change_front_desk'),(7,'Can delete front_desk',2,'delete_front_desk'),(8,'Can view front_desk',2,'view_front_desk'),(9,'Can add data_entry',3,'add_data_entry'),(10,'Can change data_entry',3,'change_data_entry'),(11,'Can delete data_entry',3,'delete_data_entry'),(12,'Can view data_entry',3,'view_data_entry'),(13,'Can add physician',4,'add_physician'),(14,'Can change physician',4,'change_physician'),(15,'Can delete physician',4,'delete_physician'),(16,'Can view physician',4,'view_physician'),(17,'Can add tested',5,'add_tested'),(18,'Can change tested',5,'change_tested'),(19,'Can delete tested',5,'delete_tested'),(20,'Can view tested',5,'view_tested'),(21,'Can add tests',6,'add_tests'),(22,'Can change tests',6,'change_tests'),(23,'Can delete tests',6,'delete_tests'),(24,'Can view tests',6,'view_tests'),(25,'Can add treatment',7,'add_treatment'),(26,'Can change treatment',7,'change_treatment'),(27,'Can delete treatment',7,'delete_treatment'),(28,'Can view treatment',7,'view_treatment'),(29,'Can add room',8,'add_room'),(30,'Can change room',8,'change_room'),(31,'Can delete room',8,'delete_room'),(32,'Can view room',8,'view_room'),(33,'Can add patient',9,'add_patient'),(34,'Can change patient',9,'change_patient'),(35,'Can delete patient',9,'delete_patient'),(36,'Can view patient',9,'view_patient'),(37,'Can add undergoes',10,'add_undergoes'),(38,'Can change undergoes',10,'change_undergoes'),(39,'Can delete undergoes',10,'delete_undergoes'),(40,'Can view undergoes',10,'view_undergoes'),(41,'Can add admission',11,'add_admission'),(42,'Can change admission',11,'change_admission'),(43,'Can delete admission',11,'delete_admission'),(44,'Can view admission',11,'view_admission'),(45,'Can add prescribes',12,'add_prescribes'),(46,'Can change prescribes',12,'change_prescribes'),(47,'Can delete prescribes',12,'delete_prescribes'),(48,'Can view prescribes',12,'view_prescribes'),(49,'Can add health_record',13,'add_health_record'),(50,'Can change health_record',13,'change_health_record'),(51,'Can delete health_record',13,'delete_health_record'),(52,'Can view health_record',13,'view_health_record'),(53,'Can add appointment',14,'add_appointment'),(54,'Can change appointment',14,'change_appointment'),(55,'Can delete appointment',14,'delete_appointment'),(56,'Can view appointment',14,'view_appointment'),(57,'Can add log entry',15,'add_logentry'),(58,'Can change log entry',15,'change_logentry'),(59,'Can delete log entry',15,'delete_logentry'),(60,'Can view log entry',15,'view_logentry'),(61,'Can add permission',16,'add_permission'),(62,'Can change permission',16,'change_permission'),(63,'Can delete permission',16,'delete_permission'),(64,'Can view permission',16,'view_permission'),(65,'Can add group',17,'add_group'),(66,'Can change group',17,'change_group'),(67,'Can delete group',17,'delete_group'),(68,'Can view group',17,'view_group'),(69,'Can add user',18,'add_user'),(70,'Can change user',18,'change_user'),(71,'Can delete user',18,'delete_user'),(72,'Can view user',18,'view_user'),(73,'Can add content type',19,'add_contenttype'),(74,'Can change content type',19,'change_contenttype'),(75,'Can delete content type',19,'delete_contenttype'),(76,'Can view content type',19,'view_contenttype'),(77,'Can add session',20,'add_session'),(78,'Can change session',20,'change_session'),(79,'Can delete session',20,'delete_session'),(80,'Can view session',20,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$320000$TjzDTopSNoCrCf4MkO52vK$O7+rBXIEbFDNEzJ23tH4TSJ/CB1oFkK2w6cZuRECofg=','2023-03-03 07:28:56.028122',1,'user','','','saransh03sharma@gmail.com',1,1,'2023-02-28 13:07:41.120591');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-02-28 13:07:59.166648','admin','admin',1,'[{\"added\": {}}]',1,1),(2,'2023-02-28 13:51:23.021499','3','3 saransh',1,'[{\"added\": {}}]',8,1),(3,'2023-02-28 13:57:10.681182','1','1 s1@gmail.com',3,'',11,1),(4,'2023-02-28 13:59:44.828621','s1@gmail.com','s1@gmail.com',3,'',9,1),(5,'2023-02-28 13:59:51.545607','s1@gmail.com','SARANSH SHARMA',3,'',4,1),(6,'2023-02-28 14:00:01.883999','3','3 saransh',3,'',8,1),(7,'2023-02-28 14:04:17.838553','user','user',2,'[{\"changed\": {\"fields\": [\"Username\", \"Password\"]}}]',1,1),(8,'2023-02-28 18:30:08.360260','4','4 C-201',1,'[{\"added\": {}}]',8,1),(9,'2023-02-28 18:33:54.556718','1','1 pranavmehrotra@kgpian.iitkgp.ac.in',1,'[{\"added\": {}}]',14,1),(10,'2023-03-01 06:06:16.724167','3','3 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(11,'2023-03-01 06:06:16.727335','2','2 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(12,'2023-03-01 06:11:25.746726','7','7 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(13,'2023-03-01 06:11:25.749708','6','6 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(14,'2023-03-01 06:11:25.752772','5','5 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(15,'2023-03-01 06:11:25.755812','4','4 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(16,'2023-03-01 14:49:10.439380','12','12 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(17,'2023-03-01 14:49:10.441375','11','11 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(18,'2023-03-01 14:53:04.732470','14','14 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(19,'2023-03-01 14:53:04.734464','13','13 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(20,'2023-03-01 14:53:04.735463','10','10 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(21,'2023-03-01 14:53:04.737456','9','9 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(22,'2023-03-01 14:53:04.738454','8','8 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(23,'2023-03-01 17:35:56.235801','2','2 pranav.nssc@gmail.com',1,'[{\"added\": {}}]',14,1),(24,'2023-03-01 19:45:42.655548','t2@test.com','t2@test.com',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',2,1),(25,'2023-03-02 08:35:33.344393','16','16 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',11,1),(26,'2023-03-02 08:52:36.636941','3','3 pranavmehrotra@kgpian.iitkgp.ac.in',1,'[{\"added\": {}}]',14,1),(27,'2023-03-02 11:30:16.520508','10','10 pranav.nssc@gmail.com',3,'',14,1),(28,'2023-03-02 11:30:16.525691','9','9 pranav.nssc@gmail.com',3,'',14,1),(29,'2023-03-02 11:30:16.530050','8','8 s2@test.com',3,'',14,1),(30,'2023-03-02 11:30:16.533973','7','7 pranav.nssc@gmail.com',3,'',14,1),(31,'2023-03-02 11:30:16.538670','6','6 s2@test.com',3,'',14,1),(32,'2023-03-02 11:30:24.699686','5','5 pranav.nssc@gmail.com',3,'',14,1),(33,'2023-03-02 18:50:21.458859','5','5 GW-1',1,'[{\"added\": {}}]',8,1),(34,'2023-03-02 21:08:48.943965','pranav.nssc@gmail.com','pranav.nssc@gmail.com',2,'[{\"changed\": {\"fields\": [\"Gender\"]}}]',9,1),(35,'2023-03-02 21:09:51.032870','s2@test.com','s2@test.com',2,'[{\"changed\": {\"fields\": [\"Gender\"]}}]',9,1),(36,'2023-03-02 21:09:57.014377','s2@test.com','s2@test.com',2,'[]',9,1),(37,'2023-03-02 21:10:05.086556','pranavmehrotra@kgpian.iitkgp.ac.in','pranavmehrotra@kgpian.iitkgp.ac.in',2,'[{\"changed\": {\"fields\": [\"Gender\"]}}]',9,1),(38,'2023-03-02 21:10:10.583318','pranav.nssc@gmail.com','pranav.nssc@gmail.com',2,'[]',9,1),(39,'2023-03-02 21:10:17.926000','pran@gmail.com','pran@gmail.com',2,'[{\"changed\": {\"fields\": [\"Gender\"]}}]',9,1),(40,'2023-03-02 22:28:16.096478','5','5 pranavmehrotra@kgpian.iitkgp.ac.in',3,'',12,1),(41,'2023-03-02 22:37:22.607256','1','1 MRI',1,'[{\"added\": {}}]',6,1),(42,'2023-03-02 22:37:47.770633','2','2 Blood Test',1,'[{\"added\": {}}]',6,1),(43,'2023-03-02 22:38:02.547165','3','3 Endoscopy',1,'[{\"added\": {}}]',6,1),(44,'2023-03-02 22:38:17.141914','4','4 RT-PCR',1,'[{\"added\": {}}]',6,1),(45,'2023-03-02 22:38:55.440378','1','1 Angioplasty',1,'[{\"added\": {}}]',7,1),(46,'2023-03-02 22:39:14.281147','2','2 Brain Tumor Surgery',1,'[{\"added\": {}}]',7,1),(47,'2023-03-02 22:40:14.826469','3','3 Bypass Surgery',1,'[{\"added\": {}}]',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (11,'accounts','admission'),(14,'accounts','appointment'),(3,'accounts','data_entry'),(1,'accounts','db_admin'),(2,'accounts','front_desk'),(13,'accounts','health_record'),(9,'accounts','patient'),(4,'accounts','physician'),(12,'accounts','prescribes'),(8,'accounts','room'),(5,'accounts','tested'),(6,'accounts','tests'),(7,'accounts','treatment'),(10,'accounts','undergoes'),(15,'admin','logentry'),(17,'auth','group'),(16,'auth','permission'),(18,'auth','user'),(19,'contenttypes','contenttype'),(20,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-02-28 13:06:55.335312'),(2,'auth','0001_initial','2023-02-28 13:06:55.589404'),(3,'admin','0001_initial','2023-02-28 13:06:55.680508'),(4,'admin','0002_logentry_remove_auto_add','2023-02-28 13:06:55.697462'),(5,'admin','0003_logentry_add_action_flag_choices','2023-02-28 13:06:55.713421'),(6,'contenttypes','0002_remove_content_type_name','2023-02-28 13:06:55.805214'),(7,'auth','0002_alter_permission_name_max_length','2023-02-28 13:06:55.857992'),(8,'auth','0003_alter_user_email_max_length','2023-02-28 13:06:55.903867'),(9,'auth','0004_alter_user_username_opts','2023-02-28 13:06:55.929799'),(10,'auth','0005_alter_user_last_login_null','2023-02-28 13:06:55.988991'),(11,'auth','0006_require_contenttypes_0002','2023-02-28 13:06:56.007817'),(12,'auth','0007_alter_validators_add_error_messages','2023-02-28 13:06:56.034166'),(13,'auth','0008_alter_user_username_max_length','2023-02-28 13:06:56.090873'),(14,'auth','0009_alter_user_last_name_max_length','2023-02-28 13:06:56.155608'),(15,'auth','0010_alter_group_name_max_length','2023-02-28 13:06:56.205362'),(16,'auth','0011_update_proxy_permissions','2023-02-28 13:06:56.272452'),(17,'auth','0012_alter_user_first_name_max_length','2023-02-28 13:06:56.330296'),(18,'sessions','0001_initial','2023-02-28 13:06:56.389140');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('5h0w14hyuen78r908gtqonrl8yncdplq','eyJ1c2VyIjoiYWx1bW5pMUB0ZXN0LmNvbSIsInR5cGUiOiJmcm9udF9kZXNrIiwiX3Nlc3Npb25faW5pdF90aW1lc3RhbXBfIjoxNjc3ODM0ODk3LjA0Nzk3ODR9:1pY1VB:7u7u_bfnT4Wkc8GeC4931tJnbCYRLvcbWXSv3uTH1fA','2023-03-17 09:14:57.068119'),('lx28slhfqec7u25i7mpdde08fftj2jzg','.eJxVjMsOwiAUBf-FtSGAPLt07zeQW7i1qAVT6Mr479KkC92eMzNv4mFrs98qrj5FMhBOTr_bCOGBeT_iHfKt0FByW9NId4Qeb6XXEvF5Odi_wAx17jYYFIozo9VoUAXpuAFjmXPRSDGhFJaNUU4xCO50jJ3TYHECDEahUnKPVqw1lexTTs23tGBtsLw8Gbg2Xeh1SzU7C-v45wtJ90Yd:1pXFgM:BBaDDcBKsCwiWckH_Rhy0P_HMbF9Kl6Ebc-7gRxKMa4','2023-03-15 06:11:18.639040'),('r73bxqtsgacm7rox9ersyn6whhz74ysg','eyJ1c2VyIjoiczFAZ21haWwuY29tIiwidHlwZSI6ImRhdGFfZW50cnkiLCJfc2Vzc2lvbl9pbml0X3RpbWVzdGFtcF8iOjE2Nzc4MjEzODYuOTYxMDU2Mn0:1pXxzG:vGn6cyjr-vkRgQgkAmsDatqZAMCc6S791T5fQsiFWO8','2023-03-17 05:29:46.973024');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-03 15:01:29
