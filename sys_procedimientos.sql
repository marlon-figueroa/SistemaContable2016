
USE `sys_contable` ;

-- -----------------------------------------------------
-- Placeholder table for view `sys_contable`.`v_acceso_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`v_acceso_categoria` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sys_contable`.`v_libro_cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`v_libro_cuenta` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sys_contable`.`v_mayor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`v_mayor` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sys_contable`.`v_usuario_acceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sys_contable`.`v_usuario_acceso` (`id` INT);

-- -----------------------------------------------------
-- procedure sp_detalle_libro_insert
-- -----------------------------------------------------

DELIMITER $$
USE `sys_contable`$$
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `sp_detalle_libro_insert`(in t_id_libro bigint(20),t_id_cuenta bigint(20),tdebe decimal(6,2),thaber decimal(6,2))
BEGIN
start TRANSACTION;
INSERT INTO sys_detalle_transaccion (id_ctr, id_cta, debe_detctr, haber_detctr)
VALUES (t_id_libro, t_id_cuenta, tdebe, thaber);		
COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_libro_diario_insert
-- -----------------------------------------------------

DELIMITER $$
USE `sys_contable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_libro_diario_insert`(IN tcod_tabla BIGINT(20),tref bigint(20),tdescrip varchar(500))
BEGIN
START TRANSACTION;
INSERT INTO sys_libro_transaccion( cod_tabla, ref_ctr, descrip_ctr, fecha_ctr)
	VALUES (tcod_tabla, tref, tdescrip, date(now()));
	select LAST_INSERT_ID();
COMMIT;	

END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `sys_contable`.`v_acceso_categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sys_contable`.`v_acceso_categoria`;
USE `sys_contable`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sys_contable`.`v_acceso_categoria` AS (select `sys_contable`.`sys_categoria_acceso`.`id_emp` AS `id_emp`,`sys_contable`.`sys_categoria_acceso`.`id_cate_mod` AS `id_cate_mod`,`sys_contable`.`sys_categoria_modulo`.`id_mod` AS `id_mod`,`sys_contable`.`sys_categoria_modulo`.`idpadre_cate_mod` AS `idpadre_cate_mod`,`sys_contable`.`sys_categoria_modulo`.`nombre_cate_mod` AS `nombre_cate_mod`,`sys_contable`.`sys_categoria_modulo`.`orden_cate_mod` AS `orden_cate_mod` from (`sys_contable`.`sys_categoria_acceso` join `sys_contable`.`sys_categoria_modulo` on((`sys_contable`.`sys_categoria_acceso`.`id_cate_mod` = `sys_contable`.`sys_categoria_modulo`.`id_cate_mod`))));

-- -----------------------------------------------------
-- View `sys_contable`.`v_libro_cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sys_contable`.`v_libro_cuenta`;
USE `sys_contable`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sys_contable`.`v_libro_cuenta` AS (select `sys_contable`.`sys_detalle_transaccion`.`id_ctr` AS `id_ctr`,`sys_contable`.`sys_detalle_transaccion`.`id_cta` AS `id_cta`,`sys_contable`.`sys_cuenta`.`cod_cta` AS `cod_cta`,`sys_contable`.`sys_cuenta`.`nombre_cta` AS `nombre_cta`,`sys_contable`.`sys_detalle_transaccion`.`debe_detctr` AS `debe_detctr`,`sys_contable`.`sys_detalle_transaccion`.`haber_detctr` AS `haber_detctr` from (`sys_contable`.`sys_detalle_transaccion` join `sys_contable`.`sys_cuenta` on((`sys_contable`.`sys_detalle_transaccion`.`id_cta` = `sys_contable`.`sys_cuenta`.`id_cta`))));

-- -----------------------------------------------------
-- View `sys_contable`.`v_mayor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sys_contable`.`v_mayor`;
USE `sys_contable`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sys_contable`.`v_mayor` AS (select `sys_contable`.`sys_detalle_transaccion`.`id_ctr` AS `id_ctr`,`sys_contable`.`sys_detalle_transaccion`.`id_cta` AS `id_cta`,`sys_contable`.`sys_cuenta`.`cod_cta` AS `cod_cta`,cast(`sys_contable`.`sys_libro_transaccion`.`fecha_ctr` as date) AS `fecha`,`sys_contable`.`sys_cuenta`.`nombre_cta` AS `nombre_cta`,`sys_contable`.`sys_detalle_transaccion`.`debe_detctr` AS `debe_detctr`,`sys_contable`.`sys_detalle_transaccion`.`haber_detctr` AS `haber_detctr` from ((`sys_contable`.`sys_detalle_transaccion` join `sys_contable`.`sys_libro_transaccion` on((`sys_contable`.`sys_detalle_transaccion`.`id_ctr` = `sys_contable`.`sys_libro_transaccion`.`id_ctr`))) join `sys_contable`.`sys_cuenta` on((`sys_contable`.`sys_detalle_transaccion`.`id_cta` = `sys_contable`.`sys_cuenta`.`id_cta`))));

-- -----------------------------------------------------
-- View `sys_contable`.`v_usuario_acceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sys_contable`.`v_usuario_acceso`;
USE `sys_contable`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sys_contable`.`v_usuario_acceso` AS (select `sys_contable`.`sys_rol`.`nombre_rol` AS `nombre_rol`,`sys_contable`.`sys_empleado`.`nombre_emp` AS `nombre_emp`,`sys_contable`.`sys_empleado`.`apelli_emp` AS `apelli_emp`,`sys_contable`.`sys_usuario`.`id_emp` AS `id_emp`,`sys_contable`.`sys_usuario`.`estado_usuario` AS `estado_usuario` from ((`sys_contable`.`sys_usuario` join `sys_contable`.`sys_empleado` on((`sys_contable`.`sys_usuario`.`id_emp` = `sys_contable`.`sys_empleado`.`id_emp`))) join `sys_contable`.`sys_rol` on((`sys_contable`.`sys_usuario`.`id_rol` = `sys_contable`.`sys_rol`.`id_rol`))));

