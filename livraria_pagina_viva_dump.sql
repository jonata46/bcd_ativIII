/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: livraria_pagina_viva
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `livraria_pagina_viva`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `livraria_pagina_viva` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `livraria_pagina_viva`;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `id_autor` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `nacionalidade` varchar(50) NOT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES
(1,'Machado de Assis','Brasileira'),
(2,'Jorge Amado','Brasileira'),
(3,'JoÃ£o GuimarÃ£es Rosa','Brasileira'),
(4,'Clarice Lispector','Brasileira'),
(5,'Carlos Drummond de Andrade','Brasileira'),
(6,'CecÃ­lia Meireles','Brasileira'),
(7,'Ariano Suassuna','Brasileira'),
(8,'Monteiro Lobato','Brasileira'),
(9,'Ana Ribeiro','Brasileira'),
(10,'Carlos Menezes','Portuguesa');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES
(6,'DidÃ¡tico'),
(4,'Infantil'),
(2,'Poesia'),
(1,'Romance'),
(3,'Teatro'),
(5,'Tecnologia');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_interesses`
--

DROP TABLE IF EXISTS `cliente_interesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_interesses` (
  `id_cliente` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`,`id_categoria`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `cliente_interesses_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `cliente_interesses_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_interesses`
--

LOCK TABLES `cliente_interesses` WRITE;
/*!40000 ALTER TABLE `cliente_interesses` DISABLE KEYS */;
INSERT INTO `cliente_interesses` VALUES
(1,1),
(1,2),
(2,5),
(3,1),
(4,3),
(5,2),
(6,5),
(7,4),
(8,5);
/*!40000 ALTER TABLE `cliente_interesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_telefones`
--

DROP TABLE IF EXISTS `cliente_telefones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_telefones` (
  `id_telefone` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `tipo` enum('celular','residencial','comercial') NOT NULL,
  PRIMARY KEY (`id_telefone`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `cliente_telefones_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_telefones`
--

LOCK TABLES `cliente_telefones` WRITE;
/*!40000 ALTER TABLE `cliente_telefones` DISABLE KEYS */;
INSERT INTO `cliente_telefones` VALUES
(1,1,'(11) 98888-1111','celular'),
(2,1,'(11) 3333-1111','residencial'),
(3,2,'(21) 97777-2222','celular'),
(4,3,'(31) 96666-3333','celular'),
(5,4,'(71) 95555-4444','celular'),
(6,5,'(51) 94444-5555','celular'),
(7,6,'(81) 93333-6666','celular'),
(8,7,'(11) 2222-7777','comercial'),
(9,8,'(41) 92222-8888','celular');
/*!40000 ALTER TABLE `cliente_telefones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `cpf` char(11) NOT NULL,
  `cidade` varchar(60) NOT NULL,
  `uf` char(2) NOT NULL,
  `data_cadastro` date NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES
(1,'Mariana Souza','mariana.souza@gmail.com','11111111111','SÃ£o Paulo','SP','2025-03-10'),
(2,'Pedro Almeida','pedro.almeida@outlook.com','22222222222','Rio de Janeiro','RJ','2025-05-22'),
(3,'Juliana Costa','juliana.costa@gmail.com','33333333333','Belo Horizonte','MG','2025-08-14'),
(4,'Rafael Lima','rafael.lima@yahoo.com','44444444444','Salvador','BA','2025-11-02'),
(5,'Camila Ferreira','camila.ferreira@gmail.com','55555555555','Porto Alegre','RS','2026-01-18'),
(6,'Lucas Martins','lucas.martins@hotmail.com','66666666666','Recife','PE','2026-02-27'),
(7,'Fernanda Rocha','fernanda.rocha@gmail.com','77777777777','SÃ£o Paulo','SP','2026-04-05'),
(8,'Bruno Carvalho','bruno.carvalho@outlook.com','88888888888','Curitiba','PR','2026-06-30');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editoras`
--

DROP TABLE IF EXISTS `editoras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `editoras` (
  `id_editora` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(60) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`id_editora`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editoras`
--

LOCK TABLES `editoras` WRITE;
/*!40000 ALTER TABLE `editoras` DISABLE KEYS */;
INSERT INTO `editoras` VALUES
(1,'Editora Horizonte','SÃ£o Paulo','SP'),
(2,'Letras do Sul','Porto Alegre','RS'),
(3,'Casa do SertÃ£o','Salvador','BA'),
(4,'Ponte Nova','Belo Horizonte','MG'),
(5,'Tecnoprint','Recife','PE');
/*!40000 ALTER TABLE `editoras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens_pedido`
--

DROP TABLE IF EXISTS `itens_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens_pedido` (
  `id_pedido` int(11) NOT NULL,
  `id_livro` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL CHECK (`quantidade` > 0),
  `preco_unitario` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_pedido`,`id_livro`),
  KEY `id_livro` (`id_livro`),
  CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`id_livro`) REFERENCES `livros` (`id_livro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_pedido`
--

LOCK TABLES `itens_pedido` WRITE;
/*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
INSERT INTO `itens_pedido` VALUES
(1,1,1,39.90),
(1,5,2,34.90),
(2,10,1,89.90),
(3,3,1,49.90),
(3,9,3,29.90),
(4,2,1,42.50),
(4,6,1,44.00),
(5,4,1,79.90),
(5,8,2,36.50),
(6,6,1,44.00),
(6,7,1,38.00),
(7,10,1,89.90),
(8,1,1,39.90),
(8,9,4,29.90),
(9,3,1,49.90),
(9,10,2,89.90),
(10,5,1,34.90),
(10,8,1,36.50);
/*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro_autor`
--

DROP TABLE IF EXISTS `livro_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro_autor` (
  `id_livro` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL,
  PRIMARY KEY (`id_livro`,`id_autor`),
  KEY `id_autor` (`id_autor`),
  CONSTRAINT `livro_autor_ibfk_1` FOREIGN KEY (`id_livro`) REFERENCES `livros` (`id_livro`),
  CONSTRAINT `livro_autor_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autores` (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro_autor`
--

LOCK TABLES `livro_autor` WRITE;
/*!40000 ALTER TABLE `livro_autor` DISABLE KEYS */;
INSERT INTO `livro_autor` VALUES
(1,1),
(2,1),
(3,2),
(4,3),
(5,4),
(6,5),
(7,6),
(8,7),
(9,8),
(10,9),
(10,10);
/*!40000 ALTER TABLE `livro_autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livros`
--

DROP TABLE IF EXISTS `livros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `livros` (
  `id_livro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `isbn` char(13) NOT NULL,
  `ano_publicacao` smallint(6) NOT NULL,
  `preco` decimal(8,2) NOT NULL CHECK (`preco` > 0),
  `estoque` int(11) NOT NULL DEFAULT 0 CHECK (`estoque` >= 0),
  `id_editora` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_livro`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `id_editora` (`id_editora`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `livros_ibfk_1` FOREIGN KEY (`id_editora`) REFERENCES `editoras` (`id_editora`),
  CONSTRAINT `livros_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livros`
--

LOCK TABLES `livros` WRITE;
/*!40000 ALTER TABLE `livros` DISABLE KEYS */;
INSERT INTO `livros` VALUES
(1,'Dom Casmurro','9780000000011',1899,39.90,25,1,1),
(2,'MemÃ³rias PÃ³stumas de BrÃ¡s Cubas','9780000000028',1881,42.50,18,1,1),
(3,'CapitÃ£es da Areia','9780000000035',1937,49.90,30,3,1),
(4,'Grande SertÃ£o: Veredas','9780000000042',1956,79.90,8,3,1),
(5,'A Hora da Estrela','9780000000059',1977,34.90,22,2,1),
(6,'Antologia PoÃ©tica','9780000000066',1962,44.00,12,4,2),
(7,'Romanceiro da InconfidÃªncia','9780000000073',1953,38.00,6,4,2),
(8,'Auto da Compadecida','9780000000080',1955,36.50,15,2,3),
(9,'ReinaÃ§Ãµes de Narizinho','9780000000097',1931,29.90,40,1,4),
(10,'Banco de Dados na PrÃ¡tica','9780000000103',2021,89.90,10,5,5);
/*!40000 ALTER TABLE `livros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_fiscais`
--

DROP TABLE IF EXISTS `notas_fiscais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_fiscais` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `data_emissao` date NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_nota`),
  UNIQUE KEY `id_pedido` (`id_pedido`),
  UNIQUE KEY `numero` (`numero`),
  CONSTRAINT `notas_fiscais_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_fiscais`
--

LOCK TABLES `notas_fiscais` WRITE;
/*!40000 ALTER TABLE `notas_fiscais` DISABLE KEYS */;
INSERT INTO `notas_fiscais` VALUES
(1,1,'NF000001','2026-01-12',109.70),
(2,2,'NF000002','2026-02-03',89.90),
(3,3,'NF000003','2026-02-20',139.60),
(4,4,'NF000004','2026-03-15',86.50),
(5,5,'NF000005','2026-04-08',152.90),
(6,6,'NF000006','2026-05-19',82.00),
(7,8,'NF000008','2026-07-21',159.50),
(8,9,'NF000009','2026-09-14',229.70);
/*!40000 ALTER TABLE `notas_fiscais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `data_pedido` date NOT NULL,
  `status` enum('Pendente','Pago','Enviado','Entregue','Cancelado') NOT NULL DEFAULT 'Pendente',
  `forma_pagamento` enum('Pix','CartÃ£o de crÃ©dito','Boleto') NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES
(1,1,'2026-01-12','Entregue','Pix'),
(2,2,'2026-02-03','Entregue','CartÃ£o de crÃ©dito'),
(3,3,'2026-02-20','Entregue','Boleto'),
(4,1,'2026-03-15','Entregue','CartÃ£o de crÃ©dito'),
(5,4,'2026-04-08','Enviado','Pix'),
(6,5,'2026-05-19','Pago','Pix'),
(7,6,'2026-06-02','Cancelado','Boleto'),
(8,7,'2026-07-21','Enviado','CartÃ£o de crÃ©dito'),
(9,2,'2026-09-14','Pago','Pix'),
(10,8,'2026-10-30','Pendente','Boleto');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'livraria_pagina_viva'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-04 11:38:30
