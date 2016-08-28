-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Schema sys_contable
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sys_contable` DEFAULT CHARACTER SET latin1 ;
USE `sys_contable` ;

-- -----------------------------------------------------
-- Table `sys_contable`.`sys_acceso_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_acceso_modulo` (
  `id_acceso_mod` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT(20) NULL DEFAULT NULL,
  `id_modulo` BIGINT(20) NULL DEFAULT NULL,
  `estado_acceso_mod` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_acceso_mod`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_categoria_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_categoria_modulo` (
  `id_cate_mod` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_mod` BIGINT(20) NULL DEFAULT NULL,
  `idpadre_cate_mod` BIGINT(20) NULL DEFAULT NULL,
  `nombre_cate_mod` VARCHAR(100) NULL DEFAULT NULL,
  `orden_cate_mod` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cate_mod`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_categoria_acceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_categoria_acceso` (
  `acceso_cat_accion` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_emp` BIGINT(20) NULL DEFAULT NULL,
  `id_cate_mod` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`acceso_cat_accion`),
  INDEX `FK_sys_categoria_acceso` (`id_cate_mod` ASC),
  CONSTRAINT `FK_sys_categoria_acceso`
    FOREIGN KEY (`id_cate_mod`)
    REFERENCES `sys_contable`.`sys_categoria_modulo` (`id_cate_mod`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_ciudad` (
  `id_ciudad` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ciudad`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_civil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_civil` (
  `id_civil` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre_civil` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id_civil`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_sexo` (
  `id_sexo` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre_sexo` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id_sexo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_cliente` (
  `id_cli` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_ciudad` BIGINT(20) NULL DEFAULT NULL,
  `id_sexo` BIGINT(20) NULL DEFAULT NULL,
  `nombre_cli` VARCHAR(50) NULL DEFAULT NULL,
  `apelli_cli` VARCHAR(50) NULL DEFAULT NULL,
  `dui_cli` VARCHAR(10) NULL DEFAULT NULL,
  `direc_cli` VARCHAR(100) NULL DEFAULT NULL,
  `tel1_cli` VARCHAR(12) NULL DEFAULT NULL,
  `tel2_cli` VARCHAR(12) NULL DEFAULT NULL,
  `cel_cli` VARCHAR(12) NULL DEFAULT NULL,
  `cupo_cli` SMALLINT(6) NULL DEFAULT NULL,
  `fecha_cli` DATE NULL DEFAULT NULL,
  `estado_cli` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cli`),
  INDEX `FK_sys_cliente` (`id_ciudad` ASC),
  INDEX `FK_sys_cliente_sexo` (`id_sexo` ASC),
  CONSTRAINT `FK_sys_cliente`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `sys_contable`.`sys_ciudad` (`id_ciudad`),
  CONSTRAINT `FK_sys_cliente_sexo`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `sys_contable`.`sys_sexo` (`id_sexo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_cuenta` (
  `id_cta` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `idpadre_cta` BIGINT(20) NULL DEFAULT NULL,
  `cod_cta` VARCHAR(20) NULL DEFAULT NULL,
  `nombre_cta` VARCHAR(100) NULL DEFAULT NULL,
  `orden_cta` BIGINT(20) NULL DEFAULT NULL COMMENT 'los hijos de cts pueden estar desordenados por eso se ordena : 4,5,6',
  PRIMARY KEY (`id_cta`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_cuenta_cobrar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_cuenta_cobrar` (
  `id_cxc` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_cliente` BIGINT(20) NULL DEFAULT NULL,
  `tipo_doc` BIGINT(20) NULL DEFAULT NULL COMMENT 'id letra de cambio o pagare',
  `id_doc` BIGINT(20) NULL DEFAULT NULL COMMENT 'id del doc puede ser factura ,nota venta,servicios prestados',
  `id_opc` BIGINT(20) NULL DEFAULT NULL COMMENT 'id si es factura,nota venta,servicios prestados',
  `nota_cxc` TEXT NULL DEFAULT NULL,
  `monto_cxc` DECIMAL(10,2) NULL DEFAULT NULL,
  `saldo_cxc` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cxc`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_cuentacobrar_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_cuentacobrar_detalle` (
  `id_detcxc` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `valor_detcxc` DECIMAL(10,2) NULL DEFAULT NULL,
  `abono_detcxc` DECIMAL(10,2) NULL DEFAULT NULL,
  `estado_detcxc` VARCHAR(20) NULL DEFAULT NULL COMMENT 'por vencer,vencido',
  PRIMARY KEY (`id_detcxc`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_libro_transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_libro_transaccion` (
  `id_ctr` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `cod_tabla` BIGINT(20) NULL DEFAULT NULL COMMENT '0:asi misma,1:ing. compras,2:factura',
  `ref_ctr` BIGINT(20) NULL DEFAULT NULL COMMENT 'autonumerico de si misma,autonumerico de 1:compras,2:factura auto numerico',
  `descrip_ctr` TEXT NULL DEFAULT NULL,
  `fecha_ctr` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_ctr`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_detalle_transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_detalle_transaccion` (
  `id_detctr` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_ctr` BIGINT(20) NULL DEFAULT NULL COMMENT 'id de libro diario',
  `id_cta` BIGINT(20) NULL DEFAULT NULL COMMENT 'id=4 , not 10.1',
  `debe_detctr` DECIMAL(6,2) NULL DEFAULT NULL,
  `haber_detctr` DECIMAL(6,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_detctr`),
  INDEX `FK_sys_detalle_transaccion` (`id_ctr` ASC),
  INDEX `FK_sys_detalle_transaccion_cuenta` (`id_cta` ASC),
  CONSTRAINT `FK_sys_detalle_transaccion`
    FOREIGN KEY (`id_ctr`)
    REFERENCES `sys_contable`.`sys_libro_transaccion` (`id_ctr`),
  CONSTRAINT `FK_sys_detalle_transaccion_cuenta`
    FOREIGN KEY (`id_cta`)
    REFERENCES `sys_contable`.`sys_cuenta` (`id_cta`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_ocupacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_ocupacion` (
  `id_ocupacion` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre_ocupacion` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ocupacion`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_empleado` (
  `id_emp` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_ciudad` BIGINT(20) NULL DEFAULT NULL,
  `id_sexo` BIGINT(20) NULL DEFAULT NULL,
  `id_civil` BIGINT(20) NULL DEFAULT NULL,
  `id_ocupacion` BIGINT(20) NULL DEFAULT NULL,
  `nombre_emp` VARCHAR(50) NULL DEFAULT NULL,
  `apelli_emp` VARCHAR(50) NULL DEFAULT NULL,
  `dui_emp` VARCHAR(10) NULL DEFAULT NULL,
  `direc_emp` VARCHAR(100) NULL DEFAULT NULL,
  `tel1_emp` VARCHAR(12) NULL DEFAULT NULL,
  `cel_emp` VARCHAR(12) NULL DEFAULT NULL,
  `fecha_emp` DATE NULL DEFAULT NULL,
  `estado_emp` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_emp`),
  INDEX `FK_sys_empleado` (`id_ciudad` ASC),
  INDEX `FK_sys_empleado_sexo` (`id_sexo` ASC),
  INDEX `FK_sys_empleado_civil` (`id_civil` ASC),
  INDEX `FK_sys_empleado_ocupa` (`id_ocupacion` ASC),
  CONSTRAINT `FK_sys_empleado`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `sys_contable`.`sys_ciudad` (`id_ciudad`),
  CONSTRAINT `FK_sys_empleado_civil`
    FOREIGN KEY (`id_civil`)
    REFERENCES `sys_contable`.`sys_civil` (`id_civil`),
  CONSTRAINT `FK_sys_empleado_ocupa`
    FOREIGN KEY (`id_ocupacion`)
    REFERENCES `sys_contable`.`sys_ocupacion` (`id_ocupacion`),
  CONSTRAINT `FK_sys_empleado_sexo`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `sys_contable`.`sys_sexo` (`id_sexo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_modulo` (
  `id_mod` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre_mod` VARCHAR(60) NULL DEFAULT NULL,
  `estado_mod` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_mod`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_proveedor` (
  `id_provd` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_ciudad` BIGINT(20) NULL DEFAULT NULL,
  `nombre_provd` VARCHAR(50) NULL DEFAULT NULL,
  `dui_provd` VARCHAR(10) NULL DEFAULT NULL,
  `direc_provd` VARCHAR(150) NULL DEFAULT NULL,
  `tel1_provd` VARCHAR(12) NULL DEFAULT NULL,
  `tel2_provd` VARCHAR(12) NULL DEFAULT NULL,
  `cel_provd` VARCHAR(12) NULL DEFAULT NULL,
  `contacto_provd` VARCHAR(50) NULL DEFAULT NULL,
  `referncia_provd` VARCHAR(100) NULL DEFAULT NULL,
  `web_provd` VARCHAR(50) NULL DEFAULT NULL,
  `email_contacto_provd` VARCHAR(50) NULL DEFAULT NULL,
  `estado_provd` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_provd`),
  INDEX `FK_sys_proveedor` (`id_ciudad` ASC),
  CONSTRAINT `FK_sys_proveedor`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `sys_contable`.`sys_ciudad` (`id_ciudad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_rol` (
  `id_rol` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sys_contable`.`sys_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`sys_usuario` (
  `id_usuario` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_emp` BIGINT(20) NULL DEFAULT NULL,
  `id_rol` BIGINT(20) NULL DEFAULT NULL,
  `clave_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `estado_usuario` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `FK_sys_usuario` (`id_rol` ASC),
  INDEX `FK_sys_usuario_empleado` (`id_emp` ASC),
  CONSTRAINT `FK_sys_usuario`
    FOREIGN KEY (`id_rol`)
    REFERENCES `sys_contable`.`sys_rol` (`id_rol`),
  CONSTRAINT `FK_sys_usuario_empleado`
    FOREIGN KEY (`id_emp`)
    REFERENCES `sys_contable`.`sys_empleado` (`id_emp`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
