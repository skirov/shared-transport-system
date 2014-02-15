SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `STS` ;
CREATE SCHEMA IF NOT EXISTS `STS` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `STS` ;

-- -----------------------------------------------------
-- Table `STS`.`Passengers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STS`.`Passengers` ;

CREATE TABLE IF NOT EXISTS `STS`.`Passengers` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STS`.`Users` ;

CREATE TABLE IF NOT EXISTS `STS`.`Users` (
  `Email` VARCHAR(100) NOT NULL,
  `FullName` VARCHAR(100) NULL,
  `PasswordHash` VARCHAR(21844) NULL,
  `Id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  INDEX `fk_Users_Passengers1_idx` (`Id` ASC),
  CONSTRAINT `fk_Users_Passengers1`
    FOREIGN KEY (`Id`)
    REFERENCES `STS`.`Passengers` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STS`.`Roles` ;

CREATE TABLE IF NOT EXISTS `STS`.`Roles` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`UserRoles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STS`.`UserRoles` ;

CREATE TABLE IF NOT EXISTS `STS`.`UserRoles` (
  `UserId` INT NOT NULL,
  `RoleId` INT NOT NULL,
  PRIMARY KEY (`UserId`, `RoleId`),
  INDEX `fk_Users_has_Roles_Roles1_idx` (`RoleId` ASC),
  CONSTRAINT `fk_Users_has_Roles_Roles1`
    FOREIGN KEY (`RoleId`)
    REFERENCES `STS`.`Roles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STS`.`Cities` ;

CREATE TABLE IF NOT EXISTS `STS`.`Cities` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STS`.`Routes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STS`.`Routes` ;

CREATE TABLE IF NOT EXISTS `STS`.`Routes` (
  `FromCityId` INT NOT NULL,
  `ToCityId` INT NOT NULL,
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Id`, `FromCityId`, `ToCityId`),
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
