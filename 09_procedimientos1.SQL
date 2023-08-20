USE plataforma;

-- -- --------------------------------------------
-- CREACION DE 	STORE PROCEDURE --
-- -- ------------------------------------------

-- 1.
-- se crea un primer procedimiento 'P_seleccion" que actua en la tabla 'politicas_publicas'
-- que permite filtras las acciones estatales en pos de la regulacion laboral o comercial de la actividad

DROP PROCEDURE IF EXISTS p_regulacion;
DELIMITER $$
CREATE PROCEDURE p_regulacion (IN palabra ENUM('regulacion laboral', 'regulacion comercial'))
BEGIN
    SELECT * FROM politicas_publicas
    WHERE objetivo = palabra;
END $$
DELIMITER ;

-- pruebo y funciona call P_seleccion ('regulacion laboral');

-- 2.
-- se crea un procedimineto "contar_filas_con_variables"
-- actua sobre la tabla accion
-- cuenta la cantidad de filas (noticias) que mencionan cierto tipo de accion de tipo ENUM

DROP PROCEDURE IF EXISTS p_contador_tipaccion;
DELIMITER $$
CREATE PROCEDURE p_contador_tipaccion(
  IN palabra ENUM('PARO', 'MOVILIZACION','DESCONEXION','DECLARACION','CORTE','DESPIDO','LOCK OUT'),
  OUT p_cantidad INT
  )
BEGIN
  SELECT COUNT(*) INTO p_cantidad
  FROM accion
  WHERE tipo_accion = palabra;
  
END $$
DELIMITER 

select * from accion;

-- funciona bien 
-- SET @num_filas = 0;
-- CALL contar_filas_con_variable('PARO', @num_filas);
-- SELECT @num_filas;





