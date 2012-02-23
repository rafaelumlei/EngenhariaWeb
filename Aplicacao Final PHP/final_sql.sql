SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `eventoss` DEFAULT CHARACTER SET latin1 ;
USE `eventoss` ;

-- -----------------------------------------------------
-- Table `eventoss`.`tipo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`tipo` (
  `idtipo` INT(11) NOT NULL ,
  `nome` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`idtipo`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eventoss`.`utilizador`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`utilizador` (
  `oid` INT(11) NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(255) NULL DEFAULT NULL ,
  `password` VARCHAR(255) NULL DEFAULT NULL ,
  `teste` VARCHAR(255) NULL DEFAULT NULL ,
  `nome` VARCHAR(255) NULL DEFAULT NULL ,
  `foto` VARCHAR(255) NULL DEFAULT NULL ,
  `lat` DOUBLE NULL DEFAULT NULL ,
  `lon` DOUBLE NULL DEFAULT NULL ,
  `lat2` DOUBLE NULL DEFAULT NULL ,
  `lon2` DOUBLE NULL DEFAULT NULL ,
  `username` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`oid`) )
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eventoss`.`evento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`evento` (
  `idevento` INT(11) NOT NULL AUTO_INCREMENT ,
  `dtfim` DATETIME NULL DEFAULT NULL ,
  `dtinicio` DATETIME NULL DEFAULT NULL ,
  `titulo` VARCHAR(255) NULL DEFAULT NULL ,
  `descricao` VARCHAR(255) NULL DEFAULT NULL ,
  `lat` DOUBLE NULL DEFAULT NULL ,
  `lon` DOUBLE NULL DEFAULT NULL ,
  `proxnewsletter` BIT(1) NULL DEFAULT NULL ,
  `tipo_idtipo` INT(11) NULL DEFAULT NULL ,
  `utilizador_oid` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idevento`) ,
  INDEX `fk_evento_tipo` (`tipo_idtipo` ASC) ,
  INDEX `idx_evento_tipo` (`tipo_idtipo` ASC) ,
  INDEX `fk_evento_utilizador` (`utilizador_oid` ASC) ,
  INDEX `idx_evento_utilizador` (`utilizador_oid` ASC) ,
  CONSTRAINT `fk_evento_tipo`
    FOREIGN KEY (`tipo_idtipo` )
    REFERENCES `eventoss`.`tipo` (`idtipo` ),
  CONSTRAINT `fk_evento_utilizador`
    FOREIGN KEY (`utilizador_oid` )
    REFERENCES `eventoss`.`utilizador` (`oid` ))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eventoss`.`comentario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`comentario` (
  `idcomentario` INT(11) NOT NULL AUTO_INCREMENT ,
  `titulo` VARCHAR(255) NULL DEFAULT NULL ,
  `texto` LONGTEXT NULL DEFAULT NULL ,
  `dtcom` DATETIME NULL DEFAULT NULL ,
  `utilizador_oid` INT(11) NULL DEFAULT NULL ,
  `evento_idevento` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idcomentario`) ,
  INDEX `fk_comentario_utilizador` (`utilizador_oid` ASC) ,
  INDEX `idx_comentario_utilizador` (`utilizador_oid` ASC) ,
  INDEX `fk_comentario_evento` (`evento_idevento` ASC) ,
  INDEX `idx_comentario_evento` (`evento_idevento` ASC) ,
  CONSTRAINT `fk_comentario_evento`
    FOREIGN KEY (`evento_idevento` )
    REFERENCES `eventoss`.`evento` (`idevento` ),
  CONSTRAINT `fk_comentario_utilizador`
    FOREIGN KEY (`utilizador_oid` )
    REFERENCES `eventoss`.`utilizador` (`oid` ))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eventoss`.`newsletter`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`newsletter` (
  `nr` INT(11) NOT NULL AUTO_INCREMENT ,
  `titulo` VARCHAR(255) NULL DEFAULT NULL ,
  `dtenvio` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`nr`) )
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eventoss`.`eventosnewsletter`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`eventosnewsletter` (
  `nr` INT(11) NOT NULL DEFAULT '0' ,
  `idevento` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`nr`, `idevento`) ,
  INDEX `nr` (`nr` ASC) ,
  INDEX `idevento` (`idevento` ASC) ,
  CONSTRAINT `nr`
    FOREIGN KEY (`nr` )
    REFERENCES `eventoss`.`newsletter` (`nr` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idevento`
    FOREIGN KEY (`idevento` )
    REFERENCES `eventoss`.`evento` (`idevento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eventoss`.`favoritos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `eventoss`.`favoritos` (
  `utilizador_oid` INT(11) NOT NULL ,
  `evento_idevento` INT(11) NOT NULL ,
  PRIMARY KEY (`utilizador_oid`, `evento_idevento`) ,
  INDEX `fk_favoritos_utilizador` (`utilizador_oid` ASC) ,
  INDEX `fk_favoritos_evento` (`evento_idevento` ASC) ,
  INDEX `idx_favoritos_utilizador` (`utilizador_oid` ASC) ,
  INDEX `idx_favoritos_evento` (`evento_idevento` ASC) ,
  CONSTRAINT `fk_favoritos_evento`
    FOREIGN KEY (`evento_idevento` )
    REFERENCES `eventoss`.`evento` (`idevento` ),
  CONSTRAINT `fk_favoritos_utilizador`
    FOREIGN KEY (`utilizador_oid` )
    REFERENCES `eventoss`.`utilizador` (`oid` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
