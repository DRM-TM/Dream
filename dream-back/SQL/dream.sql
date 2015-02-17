-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: roemer.im    Database: dream
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.12-MariaDB-1~wheezy-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `mature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `name` (`name`),
  KEY `name_2` (`name`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'WTF',0),(2,'Fun',0),(4,'Sexy',1),(5,'Porno',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dream_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `post_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `dream_id` (`dream_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`dream_id`) REFERENCES `dream` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (2,1,1,'Hahahhaahahaah énorme','2014-10-14 08:11:32'),(3,1,1,'Lol je suis mdr','2014-10-20 22:00:00'),(5,1,2,'lol','2015-02-10 11:13:48'),(6,1,4,'comment','2015-02-10 11:14:09'),(8,1,3,'omg','2015-02-10 11:21:26'),(11,1,1,'lol','2015-02-10 13:04:09'),(12,1,14,'j\'aime les commentaires','2015-02-10 18:13:15'),(13,1,14,'moi aussi','2015-02-10 13:46:29');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `definition`
--

DROP TABLE IF EXISTS `definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL,
  `definition` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `definition`
--

LOCK TABLES `definition` WRITE;
/*!40000 ALTER TABLE `definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionnary`
--

DROP TABLE IF EXISTS `dictionnary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionnary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL,
  `meaning` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionnary`
--

LOCK TABLES `dictionnary` WRITE;
/*!40000 ALTER TABLE `dictionnary` DISABLE KEYS */;
/*!40000 ALTER TABLE `dictionnary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dream`
--

DROP TABLE IF EXISTS `dream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `fk_dream_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_dream_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dream`
--

LOCK TABLES `dream` WRITE;
/*!40000 ALTER TABLE `dream` DISABLE KEYS */;
INSERT INTO `dream` VALUES (1,1,4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus.','2014-10-08 09:41:15'),(2,1,4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus.','2014-10-08 09:41:15'),(3,9,4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus.','2014-10-08 14:00:53'),(4,1,4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus.','2014-10-10 13:17:19'),(5,1,4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus.','2014-10-10 13:26:39'),(6,9,4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in faucibus.','2014-11-11 20:03:41'),(7,1,2,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In at nibh commodo nibh fringilla mollis et a nunc. Ut auctor, ante et viverra elementum, massa justo gravida nisi, et lacinia magna turpis sed nisl. Nulla malesuada felis et ex ornare bibendum. Interdum et malesuada fames ac ante ipsum primis in fauci','2015-02-10 17:35:31'),(14,1,1,'this is a big deal','2015-02-14 10:53:51'),(15,1,1,'This is the content!','2015-02-15 20:55:24'),(16,1,1,'This is the content!','2015-02-16 14:02:56'),(17,1,1,'This is the content!','2015-02-16 17:18:06');
/*!40000 ALTER TABLE `dream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hashtag`
--

DROP TABLE IF EXISTS `hashtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hashtag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dream_id` int(11) NOT NULL,
  `content` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`),
  KEY `user_id_2` (`user_id`),
  KEY `dream_id` (`dream_id`),
  CONSTRAINT `hashtag_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `hashtag_ibfk_2` FOREIGN KEY (`dream_id`) REFERENCES `dream` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashtag`
--

LOCK TABLES `hashtag` WRITE;
/*!40000 ALTER TABLE `hashtag` DISABLE KEYS */;
INSERT INTO `hashtag` VALUES (23,1,1,'#omg'),(33,1,1,'#lol'),(34,1,3,'#lol'),(36,1,2,'#lol'),(37,1,4,'#tag'),(38,1,1,'#lol'),(39,1,1,'#ojuivyc'),(42,1,14,'#tg'),(44,1,6,'#lol'),(45,1,14,'#first'),(46,1,15,''),(47,1,15,'#ceciestuntag');
/*!40000 ALTER TABLE `hashtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reported`
--

DROP TABLE IF EXISTS `reported`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reported` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dream_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dream_id` (`dream_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reported_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `reported_ibfk_1` FOREIGN KEY (`dream_id`) REFERENCES `dream` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reported`
--

LOCK TABLES `reported` WRITE;
/*!40000 ALTER TABLE `reported` DISABLE KEYS */;
INSERT INTO `reported` VALUES (1,1,1);
/*!40000 ALTER TABLE `reported` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(1024) NOT NULL,
  `username` varchar(255) NOT NULL,
  `inscription_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_connection` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_token` varchar(1024) NOT NULL,
  `birthdate` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'julien.ganichot@gmail.com','496cbab8b3ff76c6634c1b09af63b9c261417459','Ganitzsh','2014-10-08 09:31:55','2014-10-08 09:31:55','','1993-06-21'),(9,'lautre@labas.com','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','LaUtre','2014-10-22 07:09:57','2014-10-22 07:09:57','','2014-10-01'),(10,'loris.mendiondo@gmail.com','ea1fd631af9fa9259237cd27d5f24409b192b672','mendio','2015-02-10 13:13:40','2015-02-10 13:13:40','','2015-02-17'),(17,'azeaze@aze.aze','de271790913ea81742b7d31a70d85f50a3d3e5ae','azezae','2015-02-15 20:19:16','2015-02-15 20:19:16','kek','1993-06-21'),(21,'lol@mail.com','lol','lol','2015-02-17 18:05:56','2015-02-17 18:05:56','','2015-02-02'),(22,'chien@lacasse.fr','lol','ChienDeLaCasse','2015-02-17 18:45:03','2015-02-17 18:45:03','','2015-02-12');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` VALUES (1,'pute',2),(2,'enculer',2),(3,'connard',2),(4,'pd',2),(5,'salope',2),(6,'bite',2),(7,'chatte',0),(8,'enculé',2),(9,'bougnoul',2),(10,'con',2),(11,'connard',2),(12,'conne',2),(13,'conasse',2);
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-17 22:58:34
