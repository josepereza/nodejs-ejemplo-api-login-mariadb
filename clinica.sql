-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: clinica
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vorname` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `seguro` varchar(45) DEFAULT NULL,
  `allergien` set('Erdnuss','Gluten','Baumnuss','Sellerie','Senf','Fisch','Sesam','Milch','Ei','Muscheln','Soya','Sulfite','Lupine','Schwein') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'jose','perez','axa','Gluten,Milch'),(2,'santi','sepulveda','tico','Gluten'),(3,'pedro','martinez','axa','Milch'),(4,'jaro','hasa','kk','Gluten'),(5,'diego','maradona','css','Gluten,Milch'),(6,'flori','gomez','axa','Schwein');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gerichte`
--

DROP TABLE IF EXISTS `gerichte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gerichte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(70) DEFAULT NULL,
  `kommando` varchar(45) DEFAULT NULL COMMENT 'Vorpeise, Hauptgeicht,Dessert',
  `bestandteil` set('Erdnuss','Gluten','Baumnuss','Sellerie','Senf','Fisch','Sesam','Milch','Ei','Muscheln','Soya','Sulfite','Lupine','Schwein') DEFAULT NULL,
  `kategorie` varchar(45) DEFAULT NULL COMMENT 'Herz,Vegetarisch,Klassich',
  `menüreihenfolge` varchar(45) DEFAULT NULL COMMENT 'Frühstuck,Mittagsmenu,Abendmenu',
  `zimmer` varchar(4) DEFAULT NULL,
  `besucher` tinyint DEFAULT '0',
  `getränke` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idgerichte_UNIQUE` (`id`),
  UNIQUE KEY `menüreihenfolge_UNIQUE` (`menüreihenfolge`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gerichte`
--

LOCK TABLES `gerichte` WRITE;
/*!40000 ALTER TABLE `gerichte` DISABLE KEYS */;
INSERT INTO `gerichte` VALUES (1,'Vollkornbrot herzhalft',NULL,'Erdnuss,Gluten,Milch,Soya','Herz','Frühstück',NULL,0,0);
/*!40000 ALTER TABLE `gerichte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lmenu`
--

DROP TABLE IF EXISTS `lmenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lmenu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NOT NULL,
  `gerichte_id` int NOT NULL,
  PRIMARY KEY (`id`,`menu_id`,`gerichte_id`),
  KEY `fk_lmenu_menu1_idx` (`menu_id`),
  CONSTRAINT `fk_lmenu_menu1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lmenu`
--

LOCK TABLES `lmenu` WRITE;
/*!40000 ALTER TABLE `lmenu` DISABLE KEYS */;
/*!40000 ALTER TABLE `lmenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lpedido`
--

DROP TABLE IF EXISTS `lpedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lpedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ctad` int DEFAULT '1',
  `pedidos_id` int NOT NULL,
  `gerichte_id` int NOT NULL,
  `portion` decimal(2,1) DEFAULT '1.0',
  PRIMARY KEY (`id`),
  KEY `fk_lpedido_pedidos1_idx` (`pedidos_id`),
  KEY `fk_lpedido_gerichte_idx` (`gerichte_id`),
  CONSTRAINT `fk_lpedido_gerichte` FOREIGN KEY (`gerichte_id`) REFERENCES `gerichte` (`id`),
  CONSTRAINT `fk_lpedido_pedidos1` FOREIGN KEY (`pedidos_id`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lpedido`
--

LOCK TABLES `lpedido` WRITE;
/*!40000 ALTER TABLE `lpedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `lpedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `klasse` varchar(45) DEFAULT NULL COMMENT 'Herz,Vegetarisch,Klassich',
  `datum` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idmenu_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL,
  `fecha` date NOT NULL,
  `clientes_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedidos_clientes1_idx` (`clientes_id`),
  CONSTRAINT `fk_pedidos_clientes1` FOREIGN KEY (`clientes_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `vorname` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `admin` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'perez','jose','josepereza66@gmail.com','123456',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-23  9:30:16
