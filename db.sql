-- --------------------------------------------------------

--
-- Table structure for table `ProductList`
--



CREATE TABLE `ProductList` (
  `pId` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(150) NOT NULL,
  `model` VARCHAR(150) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `numOfString` MEDIUMINT(11) NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`pId`));
  
 
 -- --------------------------------------------------------

--
-- Table structure for table `Inventory`
--


  CREATE TABLE `Inventory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pId` INT(11) NULL,
  `uniqueSerialNumber` VARCHAR(100) NOT NULL,
  `buyDate` DATE NOT NULL,
  `sellDate` DATE NULL,
  `accessoriesSold` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Inventory_1_idx` (`pId` ASC),
  CONSTRAINT `fk_Inventory_1`
    FOREIGN KEY (`pId`)
    REFERENCES `ProductList` (`pId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES (1,1,'ABC123','2018-03-10','2018-03-20',NULL),(2,1,'ABC124','2018-03-22',NULL,NULL),(3,2,'XYZ1','2018-04-02','2018-04-04',NULL),(4,2,'XYZ2','2018-04-08',NULL,NULL),(5,3,'001','2018-04-12','2018-04-19',NULL),(6,3,'002','2018-04-25',NULL,NULL),(7,4,'#9812','2018-03-30',NULL,NULL);
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ProductList`
--

LOCK TABLES `ProductList` WRITE;
/*!40000 ALTER TABLE `ProductList` DISABLE KEYS */;
INSERT INTO `ProductList` VALUES (1,'Yamaha','YZ-200','electric',4,15000),(2,'Yamaha','YZ-500','electric',5,22000),(3,'Kanda Shokai','Gakki','acoustic',4,18000),(4,'Maybach','Maybach-1','acoustic',4,33000),(5,'JOSHUA GUITARS','Rainsong BI-WS1000N2','acoustic',4,45000);
/*!40000 ALTER TABLE `ProductList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Create statement for SP `fetchSalesByMonth`
--

DROP procedure IF EXISTS `fetchSalesByMonth`;

DELIMITER $$
CREATE DEFINER=`test`@`%` PROCEDURE `fetchSalesByMonth`(
IN month VARCHAR(8)
)
BEGIN
	SELECT 
    *
	FROM
		Inventory,
		ProductList
	WHERE
		Inventory.pId = ProductList.pId
		AND SUBSTRING(Inventory.sellDate, 1, 7) = month;
END$$

DELIMITER ;


