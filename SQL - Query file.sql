-- MySQL Script generated by MySQL Workbench
-- Mon Dec  4 12:56:23 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `ClientID` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `BirthDate` DATE NOT NULL,
  `EmailAddress` VARCHAR(45) NOT NULL,
  `ContactNumber` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `MembershipID` VARCHAR(45) NULL,
  `MembershipLevel` VARCHAR(45) NULL,
  PRIMARY KEY (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `DeptID` INT NOT NULL,
  `DeptType` VARCHAR(45) NOT NULL,
  `DeptName` VARCHAR(45) NOT NULL,
  `ManagerSSN` VARCHAR(45) NOT NULL,
  `ManagerName` VARCHAR(45) NULL,
  PRIMARY KEY (`DeptID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `EmpSSN` VARCHAR(20) NOT NULL,
  `DeptID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Salary` INT(11) NULL DEFAULT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `ContactNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`EmpSSN`),
  INDEX `fk_Employee_Department1_idx` (`DeptID` ASC),
  CONSTRAINT `fk_Employee_Department1`
    FOREIGN KEY (`DeptID`)
    REFERENCES `mydb`.`Department` (`DeptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `OrderID` VARCHAR(20) NOT NULL,
  `Client_ClientID` VARCHAR(45) NOT NULL,
  `DateTime` DATETIME NOT NULL,
  `Amount` INT NOT NULL,
  `OrderRating` INT NULL,
  `Employee_EmpSSN` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Order_Employee1_idx` (`Employee_EmpSSN` ASC),
  INDEX `fk_Order_Client1_idx` (`Client_ClientID` ASC),
  CONSTRAINT `fk_Order_Employee1`
    FOREIGN KEY (`Employee_EmpSSN`)
    REFERENCES `mydb`.`Employee` (`EmpSSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Client1`
    FOREIGN KEY (`Client_ClientID`)
    REFERENCES `mydb`.`Client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Promotion` (
  `PromoID` VARCHAR(20) NOT NULL,
  `PromoName` VARCHAR(255) NOT NULL,
  `Code` VARCHAR(45) NOT NULL,
  `StartingTime` DATETIME NOT NULL,
  `EndingTime` DATETIME NOT NULL,
  `PromoCost` INT NOT NULL,
  `Employee_EmpSSN` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`PromoID`),
  INDEX `fk_Promotion_Employee1_idx` (`Employee_EmpSSN` ASC),
  CONSTRAINT `fk_Promotion_Employee1`
    FOREIGN KEY (`Employee_EmpSSN`)
    REFERENCES `mydb`.`Employee` (`EmpSSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Service` (
  `ServiceID` INT NOT NULL,
  `Order_OrderID` VARCHAR(20) NOT NULL,
  `ServiceName` VARCHAR(255) NOT NULL,
  `ServiceFee` INT NOT NULL,
  `ServiceDate` DATE NOT NULL,
  `ServiceRating` VARCHAR(20) NULL,
  `Promotion_PromoID` VARCHAR(20) NOT NULL,
  `Employee_EmpSSN` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ServiceID`),
  INDEX `fk_Service&Product_Employee1_idx` (`Employee_EmpSSN` ASC),
  INDEX `fk_Service&Product_Promotion1_idx` (`Promotion_PromoID` ASC),
  INDEX `fk_Service_Order1_idx` (`Order_OrderID` ASC),
  CONSTRAINT `fk_Service&Product_Employee1`
    FOREIGN KEY (`Employee_EmpSSN`)
    REFERENCES `mydb`.`Employee` (`EmpSSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service&Product_Promotion1`
    FOREIGN KEY (`Promotion_PromoID`)
    REFERENCES `mydb`.`Promotion` (`PromoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service_Order1`
    FOREIGN KEY (`Order_OrderID`)
    REFERENCES `mydb`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service Failure Recovery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Service Failure Recovery` (
  `FailedServiceID` VARCHAR(20) NOT NULL,
  `StartDate` DATE NULL,
  `FinishDate` DATE NULL,
  `FailureRecoveryRating` INT NULL,
  `Service&Product_ServiceID` INT NOT NULL,
  `Employee_EmpSSN` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`FailedServiceID`),
  INDEX `fk_Service Failure Recovery_Service&Product1_idx` (`Service&Product_ServiceID` ASC),
  INDEX `fk_Service Failure Recovery_Employee1_idx` (`Employee_EmpSSN` ASC),
  CONSTRAINT `fk_Service Failure Recovery_Service&Product1`
    FOREIGN KEY (`Service&Product_ServiceID`)
    REFERENCES `mydb`.`Service` (`ServiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service Failure Recovery_Employee1`
    FOREIGN KEY (`Employee_EmpSSN`)
    REFERENCES `mydb`.`Employee` (`EmpSSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;