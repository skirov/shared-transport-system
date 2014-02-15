SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `STS` DEFAULT CHARACTER SET utf8 ;
USE `STS` ;

-- -----------------------------------------------------
-- Table `STS`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Users` (
  `Email` VARCHAR(100) NOT NULL,
  `FullName` VARCHAR(100) NULL DEFAULT NULL,
  `PasswordHash` VARCHAR(21844) NULL DEFAULT NULL,
  `Id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  INDEX `fk_Users_Passengers1_idx` (`Id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Passengers` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Passengers_Users1_idx` (`UserId` ASC),
  CONSTRAINT `fk_Passengers_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `STS`.`Users` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Roles` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`UserRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`UserRoles` (
  `UserId` INT NOT NULL,
  `RoleId` INT NOT NULL,
  PRIMARY KEY (`UserId`, `RoleId`),
  INDEX `fk_Users_has_Roles_Roles1_idx` (`RoleId` ASC),
  CONSTRAINT `fk_Users_has_Roles_Roles1`
    FOREIGN KEY (`RoleId`)
    REFERENCES `STS`.`Roles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserRoles_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `STS`.`Users` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Cities` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Routes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Routes` (
  `FromCityId` INT NOT NULL,
  `ToCityId` INT NOT NULL,
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Cities_has_Cities_Cities2_idx` (`ToCityId` ASC),
  INDEX `fk_Cities_has_Cities_Cities1_idx` (`FromCityId` ASC),
  CONSTRAINT `fk_Cities_has_Cities_Cities1`
    FOREIGN KEY (`FromCityId`)
    REFERENCES `STS`.`Cities` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cities_has_Cities_Cities2`
    FOREIGN KEY (`ToCityId`)
    REFERENCES `STS`.`Cities` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Drivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Drivers` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Drivers_Users1_idx` (`UserId` ASC),
  CONSTRAINT `fk_Drivers_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `STS`.`Users` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`Cars` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `DriverId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Cars_Drivers1_idx` (`DriverId` ASC),
  CONSTRAINT `fk_Cars_Drivers1`
    FOREIGN KEY (`DriverId`)
    REFERENCES `STS`.`Drivers` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`PassengersInCars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STS`.`PassengersInCars` (
  `CarId` INT NOT NULL,
  `PassengerId` VARCHAR(45) NOT NULL,
  INDEX `fk_PassengersInCars_Passengers1_idx` (`PassengerId` ASC),
  INDEX `fk_PassengersInCars_Cars1_idx` (`CarId` ASC),
  CONSTRAINT `fk_PassengersInCars_Passengers1`
    FOREIGN KEY (`PassengerId`)
    REFERENCES `STS`.`Passengers` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PassengersInCars_Cars1`
    FOREIGN KEY (`CarId`)
    REFERENCES `STS`.`Cars` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
