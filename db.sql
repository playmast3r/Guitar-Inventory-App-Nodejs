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

