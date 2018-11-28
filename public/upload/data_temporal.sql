CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.35-MariaDB

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
-- Table structure for table `ACTAS`
--

DROP TABLE IF EXISTS `ACTAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACTAS` (
  `ID_ACTA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `ACTA` mediumblob,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ACTA`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  KEY `FK_ACTAS_SEMESTRES1` (`ID_SEMESTRE`),
  KEY `FK_ACTAS_ESPECIALIDADES1` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_ACTAS_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_ACTAS_SEMESTRES1` FOREIGN KEY (`ID_SEMESTRE`) REFERENCES `SEMESTRES` (`ID_SEMESTRE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACTAS`
--

LOCK TABLES `ACTAS` WRITE;
/*!40000 ALTER TABLE `ACTAS` DISABLE KEYS */;
INSERT INTO `ACTAS` VALUES (1,1,1,NULL,NULL,NULL,NULL,1),(2,1,1,NULL,NULL,NULL,NULL,1),(3,1,1,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ACTAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ALUMNOS`
--

DROP TABLE IF EXISTS `ALUMNOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ALUMNOS` (
  `ID_ALUMNO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `NOMBRES` varchar(145) DEFAULT NULL,
  `APELLIDO_PATERNO` varchar(45) DEFAULT NULL,
  `APELLIDO_MATERNO` varchar(45) DEFAULT NULL,
  `CODIGO` varchar(45) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ALUMNO`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  UNIQUE KEY `ID_ALUMNO_UNIQUE` (`ID_ALUMNO`),
  KEY `FK_ALUMNOS_SEMESTRES1` (`ID_SEMESTRE`),
  KEY `FK_ALUMNOS_ESPECIALIDADES1` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_ALUMNOS_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ALUMNOS_SEMESTRES1` FOREIGN KEY (`ID_SEMESTRE`) REFERENCES `SEMESTRES` (`ID_SEMESTRE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ALUMNOS`
--

LOCK TABLES `ALUMNOS` WRITE;
/*!40000 ALTER TABLE `ALUMNOS` DISABLE KEYS */;
INSERT INTO `ALUMNOS` VALUES (1,1,1,'Sebastian','Ganto','Huarhua','20130917',NULL,NULL,NULL,1),(2,1,1,'Sebastian','Ganto','Huarhua','20130917',NULL,NULL,NULL,1),(3,1,1,'Sebastian','Ganto','Huarhua','20130917',NULL,NULL,NULL,1),(4,1,1,'Luis','Arana','Motta','20140967',NULL,NULL,NULL,1),(5,1,1,'Daniela','Argumanis','Escalante','20140445',NULL,NULL,NULL,1),(6,1,1,'Karla','Pedraza','Salinas','20141056',NULL,NULL,NULL,1),(7,1,1,'Andre','Pando','Huarhua','20142145',NULL,NULL,NULL,1),(8,1,1,'Yoluana','Gamboa','Sanchez','20140058',NULL,NULL,NULL,1),(9,1,1,'Ronie','Arauco','Alarcon','20140880',NULL,NULL,NULL,1),(10,1,1,'Eduardo','Velarde','Polar','20141142',NULL,NULL,NULL,1),(11,1,1,'Daniel','Chapi','Alejo','20140352',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ALUMNOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ALUMNOS_HAS_HORARIOS`
--

DROP TABLE IF EXISTS `ALUMNOS_HAS_HORARIOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ALUMNOS_HAS_HORARIOS` (
  `ID_ALUMNO` int(10) unsigned NOT NULL,
  `ID_HORARIO` int(10) unsigned NOT NULL,
  `ID_PROYECTO` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ALUMNO`,`ID_HORARIO`,`ID_PROYECTO`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  KEY `FK_ALUMNOS_HAS_HORARIOS_PROYECTOS1` (`ID_PROYECTO`),
  KEY `FK_ALUMNOS_HAS_HORARIOS_HORARIOS1` (`ID_HORARIO`),
  KEY `FK_ALUMNOS_HAS_HORARIOS_ALUMNOS1` (`ID_ALUMNO`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_ALUMNOS_HAS_HORARIOS_ALUMNOS1` FOREIGN KEY (`ID_ALUMNO`, `ID_SEMESTRE`, `ID_ESPECIALIDAD`) REFERENCES `ALUMNOS` (`ID_ALUMNO`, `ID_SEMESTRE`, `ID_ESPECIALIDAD`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ALUMNOS_HAS_HORARIOS_HORARIOS1` FOREIGN KEY (`ID_HORARIO`) REFERENCES `HORARIOS` (`ID_HORARIO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ALUMNOS_HAS_HORARIOS_PROYECTOS1` FOREIGN KEY (`ID_PROYECTO`) REFERENCES `PROYECTOS` (`ID_PROYECTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ALUMNOS_HAS_HORARIOS`
--

LOCK TABLES `ALUMNOS_HAS_HORARIOS` WRITE;
/*!40000 ALTER TABLE `ALUMNOS_HAS_HORARIOS` DISABLE KEYS */;
INSERT INTO `ALUMNOS_HAS_HORARIOS` VALUES (1,5,1,1,1,NULL,NULL,NULL,1),(2,5,1,1,1,NULL,NULL,NULL,1),(3,5,1,1,1,NULL,NULL,NULL,1),(4,5,1,1,1,NULL,NULL,NULL,1),(5,5,1,1,1,NULL,NULL,NULL,1),(6,6,2,1,1,NULL,NULL,NULL,1),(7,6,2,1,1,NULL,NULL,NULL,1),(8,7,3,1,1,NULL,NULL,NULL,1),(9,7,3,1,1,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ALUMNOS_HAS_HORARIOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATEGORIAS`
--

DROP TABLE IF EXISTS `CATEGORIAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CATEGORIAS` (
  `ID_CATEGORIA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_RESULTADO` int(10) unsigned NOT NULL,
  `NOMBRE` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CATEGORIA`,`ID_RESULTADO`),
  KEY `FK_CATEGORIAS_RESULTADOS1` (`ID_RESULTADO`),
  CONSTRAINT `FK_CATEGORIAS_RESULTADOS1` FOREIGN KEY (`ID_RESULTADO`) REFERENCES `RESULTADOS` (`ID_RESULTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORIAS`
--

LOCK TABLES `CATEGORIAS` WRITE;
/*!40000 ALTER TABLE `CATEGORIAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CATEGORIAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CURSOS`
--

DROP TABLE IF EXISTS `CURSOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CURSOS` (
  `ID_CURSO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `CODIGO_CURSO` varchar(45) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `ESTADO_ACREDITACION` int(11) DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CURSO`,`ID_ESPECIALIDAD`,`ID_SEMESTRE`),
  KEY `FK_CURSOS_ESPECIALIDADES1` (`ID_ESPECIALIDAD`),
  KEY `FK_CURSOS_SEMESTRES1` (`ID_SEMESTRE`),
  CONSTRAINT `FK_CURSOS_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_CURSOS_SEMESTRES1` FOREIGN KEY (`ID_SEMESTRE`) REFERENCES `SEMESTRES` (`ID_SEMESTRE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CURSOS`
--

LOCK TABLES `CURSOS` WRITE;
/*!40000 ALTER TABLE `CURSOS` DISABLE KEYS */;
INSERT INTO `CURSOS` VALUES (2,1,1,'Etica Profesional','ING220',NULL,NULL,1,NULL,1),(3,1,1,'Desarrollo de Programas 1','INF226',NULL,NULL,1,NULL,1),(4,1,1,'Proyecto de Tesis 1','INF391',NULL,NULL,1,NULL,1),(5,1,1,'Desarrollo de Programas 2','INF227',NULL,NULL,1,NULL,1),(6,1,1,'Proyecto de Tesis 2','INF392',NULL,NULL,1,NULL,1);
/*!40000 ALTER TABLE `CURSOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EOS`
--

DROP TABLE IF EXISTS `EOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EOS` (
  `ID_EOS` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_EOS`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  KEY `FK_EOS_SEMESTRES1` (`ID_SEMESTRE`),
  KEY `FK_EOS_ESPECIALIDADES1` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_EOS_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_EOS_SEMESTRES1` FOREIGN KEY (`ID_SEMESTRE`) REFERENCES `SEMESTRES` (`ID_SEMESTRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EOS`
--

LOCK TABLES `EOS` WRITE;
/*!40000 ALTER TABLE `EOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `EOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ESCALA_CALIFICACIONES`
--

DROP TABLE IF EXISTS `ESCALA_CALIFICACIONES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ESCALA_CALIFICACIONES` (
  `ID_ESCALA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(145) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ESCALA`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ESCALA_CALIFICACIONES`
--

LOCK TABLES `ESCALA_CALIFICACIONES` WRITE;
/*!40000 ALTER TABLE `ESCALA_CALIFICACIONES` DISABLE KEYS */;
INSERT INTO `ESCALA_CALIFICACIONES` VALUES (1,'1',NULL,NULL,NULL,1),(2,'2',NULL,NULL,NULL,1),(3,'3',NULL,NULL,NULL,1),(4,'4',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ESCALA_CALIFICACIONES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ESPECIALIDADES`
--

DROP TABLE IF EXISTS `ESPECIALIDADES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ESPECIALIDADES` (
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ESPECIALIDAD`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ESPECIALIDADES`
--

LOCK TABLES `ESPECIALIDADES` WRITE;
/*!40000 ALTER TABLE `ESPECIALIDADES` DISABLE KEYS */;
INSERT INTO `ESPECIALIDADES` VALUES (1,'INGENIERIA INFORMATICA',NULL,NULL,NULL,1),(2,'INGENIERIA INDUSTRIAL',NULL,NULL,NULL,1),(3,'INGENIERIA CIVIL',NULL,NULL,NULL,1),(4,'INGENIERIA MECATRONICA',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ESPECIALIDADES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ESPECIALIDADES_HAS_PROFESORES`
--

DROP TABLE IF EXISTS `ESPECIALIDADES_HAS_PROFESORES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ESPECIALIDADES_HAS_PROFESORES` (
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `ID_USUARIO` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ESPECIALIDAD`,`ID_USUARIO`),
  KEY `FK_ESPECIALIDADES_HAS_PROFESORES_USUARIOS1` (`ID_USUARIO`),
  CONSTRAINT `FK_ESPECIALIDADES_HAS_PROFESORES_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_ESPECIALIDADES_HAS_PROFESORES_USUARIOS1` FOREIGN KEY (`ID_USUARIO`) REFERENCES `USUARIOS` (`ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ESPECIALIDADES_HAS_PROFESORES`
--

LOCK TABLES `ESPECIALIDADES_HAS_PROFESORES` WRITE;
/*!40000 ALTER TABLE `ESPECIALIDADES_HAS_PROFESORES` DISABLE KEYS */;
INSERT INTO `ESPECIALIDADES_HAS_PROFESORES` VALUES (1,6,NULL,NULL,NULL,1),(1,7,NULL,NULL,NULL,1),(1,8,NULL,NULL,NULL,1),(1,9,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ESPECIALIDADES_HAS_PROFESORES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HORARIOS`
--

DROP TABLE IF EXISTS `HORARIOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HORARIOS` (
  `ID_HORARIO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CURSO` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `NOMBRE` varchar(70) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_HORARIO`,`ID_CURSO`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  KEY `FK_HORARIOS_CURSOS1` (`ID_CURSO`,`ID_ESPECIALIDAD`,`ID_SEMESTRE`),
  CONSTRAINT `FK_HORARIOS_CURSOS1` FOREIGN KEY (`ID_CURSO`, `ID_ESPECIALIDAD`, `ID_SEMESTRE`) REFERENCES `CURSOS` (`ID_CURSO`, `ID_ESPECIALIDAD`, `ID_SEMESTRE`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HORARIOS`
--

LOCK TABLES `HORARIOS` WRITE;
/*!40000 ALTER TABLE `HORARIOS` DISABLE KEYS */;
INSERT INTO `HORARIOS` VALUES (2,2,1,1,'0841',NULL,NULL,NULL,1),(3,2,1,1,'0842',NULL,NULL,NULL,1),(4,2,1,1,'0843',NULL,NULL,NULL,1),(5,3,1,1,'0981',NULL,NULL,NULL,1),(6,4,1,1,'0981',NULL,NULL,NULL,1),(7,5,1,1,'1081',NULL,NULL,NULL,1),(8,6,1,1,'1081',NULL,NULL,NULL,1),(9,2,1,1,'0841',NULL,NULL,NULL,1),(10,2,1,1,'0842',NULL,NULL,NULL,1),(11,2,1,1,'0843',NULL,NULL,NULL,1),(12,3,1,1,'0981',NULL,NULL,NULL,1),(13,4,1,1,'0981',NULL,NULL,NULL,1),(14,5,1,1,'1081',NULL,NULL,NULL,1),(15,6,1,1,'1081',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `HORARIOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INDICADORES`
--

DROP TABLE IF EXISTS `INDICADORES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `INDICADORES` (
  `ID_INDICADOR` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CATEGORIA` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACON` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_INDICADOR`,`ID_CATEGORIA`),
  KEY `FK_INDICADORES_CATEGORIAS1` (`ID_CATEGORIA`),
  CONSTRAINT `FK_INDICADORES_CATEGORIAS1` FOREIGN KEY (`ID_CATEGORIA`) REFERENCES `CATEGORIAS` (`ID_CATEGORIA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INDICADORES`
--

LOCK TABLES `INDICADORES` WRITE;
/*!40000 ALTER TABLE `INDICADORES` DISABLE KEYS */;
/*!40000 ALTER TABLE `INDICADORES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS`
--

DROP TABLE IF EXISTS `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS` (
  `ID_INDICADOR` int(10) unsigned NOT NULL,
  `ID_CATEGORIA` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `ID_ALUMNO` int(10) unsigned NOT NULL,
  `ID_HORARIO` int(10) unsigned NOT NULL,
  `ID_ESCALA` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_INDICADOR`,`ID_CATEGORIA`),
  KEY `FK_INDICADORES_HAS_ALUMNOS_HAS_HORARIOS_ESCALACALIFICACION1` (`ID_ESCALA`),
  KEY `FK_INDICADORES_HAS_ALUMNOS_HAS_HORARIOS_ALUMNOS_HAS_HORARIOS1` (`ID_ALUMNO`,`ID_HORARIO`),
  CONSTRAINT `FK_INDICADORES_HAS_ALUMNOS_HAS_HORARIOS_ALUMNOS_HAS_HORARIOS1` FOREIGN KEY (`ID_ALUMNO`, `ID_HORARIO`) REFERENCES `ALUMNOS_HAS_HORARIOS` (`ID_ALUMNO`, `ID_HORARIO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_INDICADORES_HAS_ALUMNOS_HAS_HORARIOS_ESCALACALIFICACION1` FOREIGN KEY (`ID_ESCALA`) REFERENCES `ESCALA_CALIFICACIONES` (`ID_ESCALA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_INDICADORES_HAS_ALUMNOS_HAS_HORARIOS_INDICADORES1` FOREIGN KEY (`ID_INDICADOR`, `ID_CATEGORIA`) REFERENCES `INDICADORES` (`ID_INDICADOR`, `ID_CATEGORIA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS`
--

LOCK TABLES `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS` WRITE;
/*!40000 ALTER TABLE `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `INDICADORES_HAS_ALUMNOS_HAS_HORARIOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INDICADORES_HAS_CURSOS`
--

DROP TABLE IF EXISTS `INDICADORES_HAS_CURSOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `INDICADORES_HAS_CURSOS` (
  `ID_CURSO` int(10) unsigned NOT NULL,
  `ID_INDICADOR` int(10) unsigned NOT NULL,
  `ID_CATEGORIA` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CURSO`,`ID_INDICADOR`,`ID_CATEGORIA`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  KEY `FK_INDICADORES_HAS_CURSOS_INDICADORES1` (`ID_INDICADOR`,`ID_CATEGORIA`),
  KEY `FK_INDICADORES_HAS_CURSOS_CURSOS1` (`ID_CURSO`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_INDICADORES_HAS_CURSOS_INDICADORES1` FOREIGN KEY (`ID_INDICADOR`, `ID_CATEGORIA`) REFERENCES `INDICADORES` (`ID_INDICADOR`, `ID_CATEGORIA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INDICADORES_HAS_CURSOS`
--

LOCK TABLES `INDICADORES_HAS_CURSOS` WRITE;
/*!40000 ALTER TABLE `INDICADORES_HAS_CURSOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `INDICADORES_HAS_CURSOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MENUS`
--

DROP TABLE IF EXISTS `MENUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MENUS` (
  `ID_MENU` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_MENU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MENUS`
--

LOCK TABLES `MENUS` WRITE;
/*!40000 ALTER TABLE `MENUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `MENUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MENU_HAS_ROL`
--

DROP TABLE IF EXISTS `MENU_HAS_ROL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MENU_HAS_ROL` (
  `ID_MENU` int(10) unsigned NOT NULL,
  `ID_ROL` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_MENU`,`ID_ROL`),
  KEY `FK_MENU_HAS_ROL_ROL1` (`ID_ROL`),
  CONSTRAINT `FK_MENU_HAS_ROL_MENU` FOREIGN KEY (`ID_MENU`) REFERENCES `MENUS` (`ID_MENU`),
  CONSTRAINT `FK_MENU_HAS_ROL_ROL1` FOREIGN KEY (`ID_ROL`) REFERENCES `ROLES` (`ID_ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MENU_HAS_ROL`
--

LOCK TABLES `MENU_HAS_ROL` WRITE;
/*!40000 ALTER TABLE `MENU_HAS_ROL` DISABLE KEYS */;
/*!40000 ALTER TABLE `MENU_HAS_ROL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLANES_DE_MEJORAS`
--

DROP TABLE IF EXISTS `PLANES_DE_MEJORAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PLANES_DE_MEJORAS` (
  `ID_PLAN` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `PLAN` mediumblob,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_PLAN`,`ID_SEMESTRE`,`ID_ESPECIALIDAD`),
  KEY `FK_PLANDEMEJORAS_SEMESTRES1` (`ID_SEMESTRE`),
  KEY `FK_PLANDEMEJORAS_ESPECIALIDADES1` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_PLANDEMEJORAS_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_PLANDEMEJORAS_SEMESTRES1` FOREIGN KEY (`ID_SEMESTRE`) REFERENCES `SEMESTRES` (`ID_SEMESTRE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLANES_DE_MEJORAS`
--

LOCK TABLES `PLANES_DE_MEJORAS` WRITE;
/*!40000 ALTER TABLE `PLANES_DE_MEJORAS` DISABLE KEYS */;
INSERT INTO `PLANES_DE_MEJORAS` VALUES (1,1,1,NULL,NULL,NULL,NULL,1),(2,1,1,NULL,NULL,NULL,NULL,1),(3,1,1,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `PLANES_DE_MEJORAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROFESORES_HAS_HORARIOS`
--

DROP TABLE IF EXISTS `PROFESORES_HAS_HORARIOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROFESORES_HAS_HORARIOS` (
  `ID_USUARIO` int(10) unsigned NOT NULL,
  `ID_HORARIO` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_USUARIO`,`ID_HORARIO`),
  KEY `FK_PROFESORES_HAS_HORARIOS_HORARIOS1` (`ID_HORARIO`),
  CONSTRAINT `FK_PROFESORES_HAS_HORARIOS_HORARIOS1` FOREIGN KEY (`ID_HORARIO`) REFERENCES `HORARIO` (`ID_HORARIO`),
  CONSTRAINT `FK_PROFESORES_HAS_HORARIOS_USUARIOS1` FOREIGN KEY (`ID_USUARIO`) REFERENCES `USUARIOS` (`ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROFESORES_HAS_HORARIOS`
--

LOCK TABLES `PROFESORES_HAS_HORARIOS` WRITE;
/*!40000 ALTER TABLE `PROFESORES_HAS_HORARIOS` DISABLE KEYS */;
INSERT INTO `PROFESORES_HAS_HORARIOS` VALUES (4,6,NULL,NULL,NULL,1),(7,8,NULL,NULL,NULL,1),(8,5,NULL,NULL,NULL,1),(9,2,NULL,NULL,NULL,1),(9,3,NULL,NULL,NULL,1),(9,4,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `PROFESORES_HAS_HORARIOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROYECTOS`
--

DROP TABLE IF EXISTS `PROYECTOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROYECTOS` (
  `ID_PROYECTO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RUTA` varchar(145) DEFAULT NULL,
  `NOMBRE` varchar(145) DEFAULT NULL,
  `PROYECTO` mediumblob,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_PROYECTO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROYECTOS`
--

LOCK TABLES `PROYECTOS` WRITE;
/*!40000 ALTER TABLE `PROYECTOS` DISABLE KEYS */;
INSERT INTO `PROYECTOS` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,1),(2,NULL,NULL,NULL,NULL,NULL,NULL,1),(3,NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `PROYECTOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESULTADOS`
--

DROP TABLE IF EXISTS `RESULTADOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESULTADOS` (
  `ID_RESULTADO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `DESCRIPCION` varchar(1000) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_RESULTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESULTADOS`
--

LOCK TABLES `RESULTADOS` WRITE;
/*!40000 ALTER TABLE `RESULTADOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESULTADOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLES`
--

DROP TABLE IF EXISTS `ROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ROLES` (
  `ID_ROL` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLES`
--

LOCK TABLES `ROLES` WRITE;
/*!40000 ALTER TABLE `ROLES` DISABLE KEYS */;
INSERT INTO `ROLES` VALUES (1,'ADMINISTRADOR','2018-09-29 15:40:41','2018-09-29 15:40:41',1,1),(2,'COORDINADOR','2018-09-29 15:42:57','2018-09-29 15:42:57',1,1),(3,'ASISTENTE','2018-09-29 15:43:21','2018-09-29 15:43:21',1,1),(4,'PROFESOR','2018-09-29 15:43:28','2018-09-29 15:43:28',1,1);
/*!40000 ALTER TABLE `ROLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SEMESTRES`
--

DROP TABLE IF EXISTS `SEMESTRES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SEMESTRES` (
  `ID_SEMESTRE` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FECHA_INICIO` datetime DEFAULT NULL,
  `FECHA_FIN` datetime DEFAULT NULL,
  `FECHA_ALERTA` datetime DEFAULT NULL,
  `ANHO` int(11) DEFAULT NULL,
  `CICLO` int(11) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_SEMESTRE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SEMESTRES`
--

LOCK TABLES `SEMESTRES` WRITE;
/*!40000 ALTER TABLE `SEMESTRES` DISABLE KEYS */;
INSERT INTO `SEMESTRES` VALUES (1,'2017-03-13 00:00:00','2017-08-12 00:00:00','2017-07-22 00:00:00',2017,1,NULL,NULL,NULL,1),(2,'2017-08-14 00:00:00','2017-12-30 00:00:00','2017-12-16 00:00:00',2017,2,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `SEMESTRES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SOS`
--

DROP TABLE IF EXISTS `SOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SOS` (
  `ID_SOS` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_SOS`,`ID_ESPECIALIDAD`,`ID_SEMESTRE`),
  KEY `FK_SOS_ESPECIALIDADES1` (`ID_ESPECIALIDAD`),
  KEY `FK_SOS_SEMESTRES1` (`ID_SEMESTRE`),
  CONSTRAINT `FK_SOS_ESPECIALIDADES1` FOREIGN KEY (`ID_ESPECIALIDAD`) REFERENCES `ESPECIALIDADES` (`ID_ESPECIALIDAD`),
  CONSTRAINT `FK_SOS_SEMESTRES1` FOREIGN KEY (`ID_SEMESTRE`) REFERENCES `SEMESTRES` (`ID_SEMESTRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SOS`
--

LOCK TABLES `SOS` WRITE;
/*!40000 ALTER TABLE `SOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `SOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SOS_HAS_EOS`
--

DROP TABLE IF EXISTS `SOS_HAS_EOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SOS_HAS_EOS` (
  `ID_SOS` int(10) unsigned NOT NULL,
  `ID_ESPECIALIDAD` int(10) unsigned NOT NULL,
  `ID_SEMESTRE` int(10) unsigned NOT NULL,
  `ID_EOS` int(10) unsigned NOT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_SOS`,`ID_ESPECIALIDAD`,`ID_SEMESTRE`,`ID_EOS`),
  KEY `FK_SOS_HAS_EOS_EOS1` (`ID_EOS`),
  CONSTRAINT `FK_SOS_HAS_EOS_EOS1` FOREIGN KEY (`ID_EOS`) REFERENCES `EOS` (`ID_EOS`),
  CONSTRAINT `FK_SOS_HAS_EOS_SOS1` FOREIGN KEY (`ID_SOS`, `ID_ESPECIALIDAD`, `ID_SEMESTRE`) REFERENCES `SOS` (`ID_SOS`, `ID_ESPECIALIDAD`, `ID_SEMESTRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SOS_HAS_EOS`
--

LOCK TABLES `SOS_HAS_EOS` WRITE;
/*!40000 ALTER TABLE `SOS_HAS_EOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `SOS_HAS_EOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USUARIOS`
--

DROP TABLE IF EXISTS `USUARIOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USUARIOS` (
  `ID_USUARIO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ROL` int(10) unsigned NOT NULL,
  `USUARIO` varchar(45) DEFAULT NULL,
  `PASS` varchar(200) DEFAULT NULL,
  `CORREO` varchar(100) DEFAULT NULL,
  `FECHA_REGISTRO` datetime DEFAULT NULL,
  `FECHA_ACTUALIZACION` datetime DEFAULT NULL,
  `USUARIO_MODIF` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  `NOMBRES` varchar(50) DEFAULT NULL,
  `APELLIDO_PATERNO` varchar(50) DEFAULT NULL,
  `APELLIDO_MATERNO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_USUARIO`,`ID_ROL`),
  UNIQUE KEY `ID_USUARIO_UNIQUE` (`ID_USUARIO`),
  KEY `FK_USUARIOS_ROLES1` (`ID_ROL`),
  CONSTRAINT `FK_USUARIOS_ROLES1` FOREIGN KEY (`ID_ROL`) REFERENCES `ROLES` (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USUARIOS`
--

LOCK TABLES `USUARIOS` WRITE;
/*!40000 ALTER TABLE `USUARIOS` DISABLE KEYS */;
INSERT INTO `USUARIOS` VALUES (1,1,'20142145','$2Y$10$K0RFOQG2COQXSK.Y9VW7FUQD1V6EV7COMEGQAVBC48/R5AWAKCITU','ANDRE.PANDO@PUCP.PE','2018-09-29 15:49:45','2018-09-29 20:53:39',NULL,1,'ENRIQUE ANDRÉ','PANDO','ROBLES'),(2,2,'C0007','$2y$10$cgKFD7RKCRfeyestjtCZfu/9R4CTF/2mQahv74Hak02RL9TK2gxga','LUIS.FLORES@PUCP.PE','2018-09-29 15:49:45','2018-10-10 00:27:54',NULL,1,'LUIS','FLORES','GARCÍA'),(3,3,'A0007',NULL,'JHAIR.SISTEMA@PUCP.PE','2018-09-29 15:49:45','2018-09-29 15:49:45',NULL,1,'JHAIR','SISTEMA','SISTEMA'),(4,4,'P0007',NULL,'FREDDY.PAZ@PUCP.PE','2018-09-29 15:49:45','2018-09-29 15:49:45',NULL,1,'FREDDY','PAZ','ARENAS'),(6,4,'P001',NULL,'P001@PUCP.PE',NULL,NULL,NULL,1,'ALEJANDRO','BELLO','RUIZ'),(7,4,'P002',NULL,'P002@PUCP.PE',NULL,NULL,NULL,1,'ANDRES','MELGAR','SASIETA'),(8,4,'P003',NULL,'P003@PUCP.PE',NULL,NULL,NULL,1,'ABRAHAM','DAVILA','RAMON'),(9,4,'P004',NULL,'P004@PUCP.PE',NULL,NULL,NULL,1,'LUIS','RIOS','ALEJO');
/*!40000 ALTER TABLE `USUARIOS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-22  3:20:15