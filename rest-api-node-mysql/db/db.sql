-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema redflags
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema redflag
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema redflag
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `redflag` DEFAULT CHARACTER SET utf8 ;
USE `redflag` ;

-- -----------------------------------------------------
-- Table `redflag`.`evidencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`evidencias` (
  `idEvidencias` INT(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(100) NOT NULL,
  `Imagen1` BLOB NOT NULL,
  `Imagen2` BLOB NULL DEFAULT NULL,
  `Imagen3` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEvidencias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`usuario` (
  `nombre` VARCHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `cedula` VARCHAR(15) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `usuario` VARCHAR(30) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fotoPerfil` BLOB NULL DEFAULT NULL,
  `tipoUser` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`bandera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`bandera` (
  `idBandera` INT(11) NOT NULL AUTO_INCREMENT,
  `latitud` DECIMAL(20,0) NOT NULL,
  `banderacol` DECIMAL(20,0) NOT NULL,
  `referencia` VARCHAR(45) NOT NULL,
  `calleP` VARCHAR(45) NULL DEFAULT NULL,
  `calleS` VARCHAR(45) NULL DEFAULT NULL,
  `nroCasa` INT(11) NULL DEFAULT NULL,
  `nIntegrantes` INT(11) NULL DEFAULT NULL,
  `nombreBeneficiario` VARCHAR(60) NULL DEFAULT NULL,
  `cedulaBeneficiario` VARCHAR(15) NULL DEFAULT NULL,
  `apellidoBeneficiario()` VARCHAR(60) NULL DEFAULT NULL,
  `Usuario_cedula` VARCHAR(15) NOT NULL,
  `Evidencias_idEvidencias` INT(11) NOT NULL,
  PRIMARY KEY (`idBandera`),
  INDEX `fk_Bandera_Usuario_idx` (`Usuario_cedula` ASC)  ,
  INDEX `fk_Bandera_Evidencias1_idx` (`Evidencias_idEvidencias` ASC)  ,
  CONSTRAINT `fk_Bandera_Evidencias1`
    FOREIGN KEY (`Evidencias_idEvidencias`)
    REFERENCES `redflag`.`evidencias` (`idEvidencias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bandera_Usuario`
    FOREIGN KEY (`Usuario_cedula`)
    REFERENCES `redflag`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`donacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`donacion` (
  `idDonacion` INT(11) NOT NULL AUTO_INCREMENT,
  `estado` INT(11) NOT NULL,
  `fecha` VARCHAR(10) NULL DEFAULT NULL,
  `Usuario_cedula` VARCHAR(15) NOT NULL,
  `Evidencias_idEvidencias` INT(11) NOT NULL,
  PRIMARY KEY (`idDonacion`),
  INDEX `fk_Donacion_Usuario1_idx` (`Usuario_cedula` ASC)  ,
  INDEX `fk_Donacion_Evidencias1_idx` (`Evidencias_idEvidencias` ASC)  ,
  CONSTRAINT `fk_Donacion_Evidencias1`
    FOREIGN KEY (`Evidencias_idEvidencias`)
    REFERENCES `redflag`.`evidencias` (`idEvidencias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Donacion_Usuario1`
    FOREIGN KEY (`Usuario_cedula`)
    REFERENCES `redflag`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`falsabandera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`falsabandera` (
  `idFalsaBandera` INT(11) NOT NULL AUTO_INCREMENT,
  `estado` INT(11) NOT NULL,
  `Usuario_cedula` VARCHAR(15) NOT NULL,
  `Evidencias_idEvidencias` INT(11) NOT NULL,
  `Bandera_idBandera` INT(11) NOT NULL,
  PRIMARY KEY (`idFalsaBandera`, `Evidencias_idEvidencias`),
  INDEX `fk_FalsaBandera_Usuario1_idx` (`Usuario_cedula` ASC)  ,
  INDEX `fk_FalsaBandera_Evidencias1_idx` (`Evidencias_idEvidencias` ASC)  ,
  INDEX `fk_FalsaBandera_Bandera1_idx` (`Bandera_idBandera` ASC)  ,
  CONSTRAINT `fk_FalsaBandera_Bandera1`
    FOREIGN KEY (`Bandera_idBandera`)
    REFERENCES `redflag`.`bandera` (`idBandera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FalsaBandera_Evidencias1`
    FOREIGN KEY (`Evidencias_idEvidencias`)
    REFERENCES `redflag`.`evidencias` (`idEvidencias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FalsaBandera_Usuario1`
    FOREIGN KEY (`Usuario_cedula`)
    REFERENCES `redflag`.`usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`tipodonacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`tipodonacion` (
  `idTipoDonacion` INT(11) NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDonacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`bandera_has_tipodonacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`bandera_has_tipodonacion` (
  `bandera_idBandera` INT(11) NOT NULL,
  `tipodonacion_idTipoDonacion` INT(11) NOT NULL,
  PRIMARY KEY (`bandera_idBandera`, `tipodonacion_idTipoDonacion`),
  INDEX `fk_bandera_has_tipodonacion_tipodonacion1_idx` (`tipodonacion_idTipoDonacion` ASC)  ,
  INDEX `fk_bandera_has_tipodonacion_bandera1_idx` (`bandera_idBandera` ASC)  ,
  CONSTRAINT `fk_bandera_has_tipodonacion_bandera1`
    FOREIGN KEY (`bandera_idBandera`)
    REFERENCES `redflag`.`bandera` (`idBandera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bandera_has_tipodonacion_tipodonacion1`
    FOREIGN KEY (`tipodonacion_idTipoDonacion`)
    REFERENCES `redflag`.`tipodonacion` (`idTipoDonacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `redflag`.`donacion_has_tipodonacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `redflag`.`donacion_has_tipodonacion` (
  `donacion_idDonacion` INT(11) NOT NULL,
  `tipodonacion_idTipoDonacion` INT(11) NOT NULL,
  PRIMARY KEY (`donacion_idDonacion`, `tipodonacion_idTipoDonacion`),
  INDEX `fk_donacion_has_tipodonacion_tipodonacion1_idx` (`tipodonacion_idTipoDonacion` ASC)  ,
  INDEX `fk_donacion_has_tipodonacion_donacion1_idx` (`donacion_idDonacion` ASC)  ,
  CONSTRAINT `fk_donacion_has_tipodonacion_donacion1`
    FOREIGN KEY (`donacion_idDonacion`)
    REFERENCES `redflag`.`donacion` (`idDonacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donacion_has_tipodonacion_tipodonacion1`
    FOREIGN KEY (`tipodonacion_idTipoDonacion`)
    REFERENCES `redflag`.`tipodonacion` (`idTipoDonacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

ALTER TABLE `redflag`.`bandera` 
ADD COLUMN `longitud` DECIMAL(20) NULL AFTER `Evidencias_idEvidencias`;
 ALTER TABLE `redflag`.`bandera` 
DROP COLUMN `banderacol`;

INSERT INTO `redflag`.`usuario` (`nombre`, `apellido`, `cedula`, `correo`, `usuario`, `password`, `tipoUser`) VALUES ('Juan', 'Cevallos', '1106060658', 'cevallosjuanfrancisco@gmail.com', 'jfcevallos8', 'jfcevallos8', '0');
INSERT INTO `redflag`.`usuario` (`nombre`, `apellido`, `cedula`, `correo`, `usuario`, `password`, `tipoUser`) VALUES ('Danilo', 'Mendoza', '11060606060', 'domendoza@utpl.edu.ec', 'domendoza', 'domendoza', '0');
INSERT INTO `redflag`.`usuario` (`nombre`, `apellido`, `cedula`, `correo`, `usuario`, `password`, `tipoUser`) VALUES ('Jorge', 'Sarmiento', '1105050548', 'jorgitosar@gmail.com', 'jorgesarmineto', 'jorgesarmiento', '1');

INSERT INTO `redflag`.`tipodonacion` (`idTipoDonacion`, `Tipo`) VALUES ('1', 'Ropa');
INSERT INTO `redflag`.`tipodonacion` (`idTipoDonacion`, `Tipo`) VALUES ('2', 'Alimentos');
INSERT INTO `redflag`.`tipodonacion` (`idTipoDonacion`, `Tipo`) VALUES ('3', 'Medicinas');

ALTER TABLE `redflag`.`evidencias` 
CHANGE COLUMN `Imagen1` `Imagen1` BLOB NULL ,
CHANGE COLUMN `Imagen3` `Imagen3` BLOB NULL DEFAULT NULL ;

INSERT INTO `redflag`.`evidencias` (`idEvidencias`, `Descripcion`) VALUES ('1', 'Esta evidencia es generica');

INSERT INTO `redflag`.`bandera` (`idBandera`, `latitud`, `referencia`, `calleP`, `calleS`, `nIntegrantes`, `nombreBeneficiario`, `apellidoBeneficiario()`, `Usuario_cedula`, `Evidencias_idEvidencias`, `longitud`) VALUES ('1', '-3.978968', 'Esquinera', 'Avenida Turunuma', '', '3', 'Pedro ', 'Jacome', '1106060658', '1', '-79.211630');

INSERT INTO `redflag`.`donacion` (`idDonacion`, `estado`, `fecha`, `Usuario_cedula`, `Evidencias_idEvidencias`) VALUES ('1', '1', '20/24/20', '1106060658', '1');
INSERT INTO `redflag`.`falsabandera` (`idFalsaBandera`, `estado`, `Usuario_cedula`, `Evidencias_idEvidencias`, `Bandera_idBandera`) VALUES ('1', '1', '1106060658', '1', '1');
INSERT INTO `redflag`.`bandera_has_tipodonacion` (`bandera_idBandera`, `tipodonacion_idTipoDonacion`) VALUES ('1', '1');
INSERT INTO `redflag`.`donacion_has_tipodonacion` (`donacion_idDonacion`, `tipodonacion_idTipoDonacion`) VALUES ('1', '1');
UPDATE `redflag`.`bandera` SET `latitud` = '--4.022035', `longitud` = '79.507896' WHERE (`idBandera` = '1');

ALTER TABLE `redflag`.`bandera` 
CHANGE COLUMN `latitud` `latitud` VARCHAR(20) NOT NULL ,
CHANGE COLUMN `longitud` `longitud` VARCHAR(20) NULL DEFAULT NULL ;
ALTER TABLE `redflag`.`bandera` 
CHANGE COLUMN `apellidoBeneficiario()` `apellidoBeneficiario` VARCHAR(60) NULL DEFAULT NULL ;


USE `redflag`;
DROP procedure IF EXISTS `AgregaroEditarBandera`;

DELIMITER $$
USE `redflag`$$
CREATE procedure AgregaroEditarBandera(
		IN _id INT,
        IN _latitud VARCHAR(20),
        IN _referencia VARCHAR(45),
        IN _calleP VARCHAR(45),
        IN _calleS VARCHAR(45),
        IN _nroCasa INT,
        IN _nIntegrantes INT,
        IN _nombreBeneficiario VARCHAR(60),
        IN _cedulaBeneficiario VARCHAR(15),
        IN _apellidoBeneficiario VARCHAR(60),
        IN _Usuario_cedula VARCHAR(15),
        IN _Evidencias_idEvidencias INT,
        IN _longitud VARCHAR(20)
        
)
BEGIN
	if (_id = 0) THEN
		INSERT INTO `redflag`.`bandera` (`latitud`, `referencia`, `calleP`, `calleS`,`nroCasa` ,
        `nIntegrantes`, `nombreBeneficiario`, `cedulaBeneficiario`,`apellidoBeneficiario`, `Usuario_cedula`,
        `Evidencias_idEvidencias`, `longitud`) 
        VALUES (_latitud, _referencia, _calleP, _calleS, _nroCasa, _nIntegrantes, _nombreBeneficiario,
        _cedulaBeneficiario, _apellidoBeneficiario, _Usuario_cedula, __Evidencias_idEvidencias, _longitud);
	ELSE
		update bandera
        set
			latitud = _latitud,
            referencia = _referencia,
            calleP = _calleP,
            calleS = _calleS,
            nroCasa = _nroCasa,
            nIntegrantes = _nIntegrantes,
            nombreBeneficiario = _nombreBeneficiario,
            cedulaBeneficiario = _cedulaBeneficiario,
            apellidoBeneficiario = _apellidoBeneficiario,
            Usuario_cedula = _Usuario_cedula,
            Evidencias_idEvidencias = _Evidencias_idEvidencias,
            longitud = _longitud
            WHERE idBandera = _id;
	END IF;
    SELECT _id AS idBandera;
end$$

DELIMITER ;

USE `redflag`;
DROP procedure IF EXISTS `AgregaroEditarBandera`;

DELIMITER $$
USE `redflag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregaroEditarBandera`(
		IN _id INT,
        IN _latitud VARCHAR(20),
        IN _referencia VARCHAR(45),
        IN _calleP VARCHAR(45),
        IN _calleS VARCHAR(45),
        IN _nroCasa INT,
        IN _nIntegrantes INT,
        IN _nombreBeneficiario VARCHAR(60),
        IN _cedulaBeneficiario VARCHAR(15),
        IN _apellidoBeneficiario VARCHAR(60),
        IN _Usuario_cedula VARCHAR(15),
        IN _Evidencias_idEvidencias INT,
        IN _longitud VARCHAR(20)
        
)
BEGIN
	if (_id = 0) THEN
		INSERT INTO `redflag`.`bandera` (`latitud`, `referencia`, `calleP`, `calleS`,`nroCasa` ,
        `nIntegrantes`, `nombreBeneficiario`, `cedulaBeneficiario`,`apellidoBeneficiario`, `Usuario_cedula`,
        `Evidencias_idEvidencias`, `longitud`) 
        VALUES (_latitud, _referencia, _calleP, _calleS, _nroCasa, _nIntegrantes, _nombreBeneficiario,
        _cedulaBeneficiario, _apellidoBeneficiario, _Usuario_cedula, _Evidencias_idEvidencias, _longitud);
	ELSE
		update bandera
        set
			latitud = _latitud,
            referencia = _referencia,
            calleP = _calleP,
            calleS = _calleS,
            nroCasa = _nroCasa,
            nIntegrantes = _nIntegrantes,
            nombreBeneficiario = _nombreBeneficiario,
            cedulaBeneficiario = _cedulaBeneficiario,
            apellidoBeneficiario = _apellidoBeneficiario,
            Usuario_cedula = _Usuario_cedula,
            Evidencias_idEvidencias = _Evidencias_idEvidencias,
            longitud = _longitud
            WHERE idBandera = _id;
	END IF;
    SELECT _id AS idBandera;
end$$

DELIMITER ;


USE `redflag`;
DROP procedure IF EXISTS `AgregaroEditarDonacion`;

DELIMITER $$
USE `redflag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregaroEditarDonacion`(
		IN _id INT,
        IN _estado INT,
        IN _fecha VARCHAR(10),
        IN _Usuario_cedula VARCHAR(15),
        IN _Evidencias_idEvidencias INT
        
)
BEGIN
	if (_id = 0) THEN
		INSERT INTO `redflag`.`donacion` (`estado`, `fecha`, `Usuario_cedula`, `Evidencias_idEvidencias`) VALUES (_estado, _fecha, _Usuario_cedula, _Evidencias_idEvidencias);
	ELSE
		update donacion
        set
			estado = _estado,
            fecha = _fecha,
            Usuario_cedula = _Usuario_cedula,
            Evidencias_idEvidencias = _Evidencias_idEvidencias
            WHERE idBandera = _id;
	END IF;
    SELECT _id AS idDonacion;
end$$

DELIMITER ;




USE `redflag`;
DROP procedure IF EXISTS `AgregaroEditarDonacion`;

DELIMITER $$
USE `redflag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregaroEditarDonacion`(
		IN _id INT,
        IN _estado INT,
        IN _fecha VARCHAR(10),
        IN _Usuario_cedula VARCHAR(15),
        IN _Evidencias_idEvidencias INT
        
)
BEGIN
	if (_id = 0) THEN
		INSERT INTO `redflag`.`donacion` (`estado`, `fecha`, `Usuario_cedula`, `Evidencias_idEvidencias`) VALUES (_estado, _fecha, _Usuario_cedula, _Evidencias_idEvidencias);
	ELSE
		update donacion
        set
			estado = _estado,
            fecha = _fecha,
            Usuario_cedula = _Usuario_cedula,
            Evidencias_idEvidencias = _Evidencias_idEvidencias
            WHERE idDonacion = _id;
	END IF;
    SELECT _id AS idDonacion;
end$$

DELIMITER ;


USE `redflag`;
DROP procedure IF EXISTS `AgregarUsuario`;

DELIMITER $$
USE `redflag`$$
CREATE PROCEDURE `AgregarUsuario` (
		IN _nombre VARCHAR(60),
        IN _apellido VARCHAR(60),
        IN _cedula VARCHAR(15),
        IN _correo VARCHAR(100),
        IN _usuario VARCHAR(30),
        IN _password VARCHAR(45),
        IN _fotoPerfil BLOB,
        IN _tipoUser INT(11) 
)
BEGIN
			INSERT INTO `redflag`.`usuario` (`nombre`, `apellido`, `cedula`, `correo`, `usuario`, `password`,`_fotoPerfil`, `tipoUser`)
            VALUES (_nombre, _apellido, _cedula, _correo, _usuario, _password, _fotoPerfil, _tipoUser);
			SELECT _cedula AS cedula;
END$$

DELIMITER ;

USE `redflag`;
DROP procedure IF EXISTS `AgregarUsuario`;

DELIMITER $$
USE `redflag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarUsuario`(
		IN _nombre VARCHAR(60),
        IN _apellido VARCHAR(60),
        IN _cedula VARCHAR(15),
        IN _correo VARCHAR(100),
        IN _usuario VARCHAR(30),
        IN _password VARCHAR(45),
        IN _fotoPerfil BLOB,
        IN _tipoUser INT(11) 
)
BEGIN
			INSERT INTO `redflag`.`usuario` (`nombre`, `apellido`, `cedula`, `correo`, `usuario`, `password`,`fotoPerfil`, `tipoUser`)
            VALUES (_nombre, _apellido, _cedula, _correo, _usuario, _password, _fotoPerfil, _tipoUser);
			SELECT _cedula AS cedula;
END$$

DELIMITER ;

USE `redflag`;
DROP procedure IF EXISTS `EditarUsuario`;

DELIMITER $$
USE `redflag`$$
CREATE PROCEDURE `EditarUsuario` (
		IN _nombre VARCHAR(60),
        IN _apellido VARCHAR(60),
        IN _cedula VARCHAR(15),
        IN _correo VARCHAR(100),
        IN _usuario VARCHAR(30),
        IN _password VARCHAR(45),
        IN _fotoPerfil BLOB,
        IN _tipoUser INT(11) 
)
BEGIN
	update usuario
		set
			nombre = _nombre,
            apellido = _apellido,
            correo = _correo,
            usuario = _usuario,
            password = _password,
            fotoPerfil = _fotoPerfil,
            tipoUser = _tipoUser
			WHERE cedula = _cedula;
END$$

DELIMITER ;

USE `redflag`;
DROP procedure IF EXISTS `EditarUsuario`;

DELIMITER $$
USE `redflag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditarUsuario`(
		IN _nombre VARCHAR(60),
        IN _apellido VARCHAR(60),
        IN _cedula VARCHAR(15),
        IN _correo VARCHAR(100),
        IN _usuario VARCHAR(30),
        IN _password VARCHAR(45),
        IN _fotoPerfil BLOB,
        IN _tipoUser INT(11) 
)
BEGIN
	update usuario
		set
			nombre = _nombre,
            apellido = _apellido,
            correo = _correo,
            usuario = _usuario,
            password = _password,
            fotoPerfil = _fotoPerfil,
            tipoUser = _tipoUser
			WHERE cedula = _cedula;
            SELECT _cedula AS cedula;
END$$

DELIMITER ;

USE `redflag`;
DROP procedure IF EXISTS `AgregarEditarReportes`;

DELIMITER $$
USE `redflag`$$
CREATE PROCEDURE `AgregarEditarReportes` (
	IN _idFalsaBandera INT,
    IN _estado INT,
    IN _Usuario_cedula VARCHAR(15),
    IN _Evidencias_idEvidencias INT,
    IN _Bandera_idBandera INT    
)
BEGIN
	if (_idFalsaBandera = 0) then
		INSERT INTO `redflag`.`falsabandera` (`estado`, `Usuario_cedula`, `Evidencias_idEvidencias`, `Bandera_idBandera`) VALUES (_estado, _Usuario_cedula,_Evidencias_idEvidencias,_Bandera_idBandera);
	ELSE
    update falsabandera
		set
        estado = _estado,
        Usuario_cedula = _Usuario_cedula,
        Evidencias_idEvidencias = _Evidencias_idEvidencias,
        Bandera_idBandera = _Bandera_idBandera
        WHERE idFalsaBandera = _idFalsaBandera;
	END IF;
    SELECT _idFalsaBandera AS idFalsaBandera;
END$$

DELIMITER ;

