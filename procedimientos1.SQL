
-- prueblo un primer procedimiento muy sencillo.
-- es un select * from where (columna). El procedimiento permite cargar una palabra clave en un IN

DELIMITER $$

DROP PROCEDURE IF EXISTS P_seleccion;
CREATE PROCEDURE IF NOT EXISTS P_seleccion (IN palabra char(50))
BEGIN

select * from politicas_publicas
where objetivo = palabra;

END $$

DELIMITER ;

-- pruebo y funciona call P_seleccion ('regulacion laboral');

-- ahora voy a probar otro sencillo que combina in con un OUT

DELIMITER $$

DROP PROCEDURE IF EXISTS contar_filas_con_variable;
CREATE PROCEDURE IF NOT EXISTS contar_filas_con_variable(
  IN p_variable VARCHAR(50),
  OUT p_num_filas INT
)
BEGIN
  SELECT COUNT(*) INTO p_num_filas
  FROM accion
  WHERE tipo_accion = p_variable;
END $$
DELIMITER 

-- funciona bien 
SET @num_filas = 0;
CALL contar_filas_con_variable('PARO', @num_filas);
SELECT @num_filas;

-- ahora haremos un procedimiento con funciones





-- DROP PROCEDURE IF EXISTS ordenador_variables;

DELIMITER $$

CREATE PROCEDURE ordenador_variables (IN field char(20))
BEGIN
    DECLARE accion_order VARCHAR(50);
    DECLARE clausula VARCHAR(100);
    
    IF field <> '' THEN 
        SET accion_order = concat(' ORDER BY ', field);
    ELSE 
        SET accion_order = '';
    END IF;
    
    SET clausula = concat('SELECT * FROM accion', accion_order);
    PREPARE runSQL FROM clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END $$
DELIMITER ;


call ordenador_variables('a');



