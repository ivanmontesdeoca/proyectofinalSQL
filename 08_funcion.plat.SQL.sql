use plataforma;

-- -- --------------------------------------------
-- CREACION DE FUNCIONES --
-- -- ------------------------------------------


-- 1)
--  Se crean dos variables que son cantidad de acciones (movilizaciones o paros, por ejemplo)
-- y se multiplica por una cantidad de huelguistas determinada para conocer el total de huelguistas
-- el ejercicio tiene un limite claro dado que presupone que siempre la cantidad de huelguistas es equivalente
-- en todas las movilizaciones. De todas formas el objetivo es comenzar a probar el funcionamiento de las funciones.


DROP function if exists f_huelguistas;
DELIMITER $$
CREATE function f_huelguistas(accion INT, huelguistas INT) 
RETURNS VARCHAR (200)
DETERMINISTIC
BEGIN
	DECLARE resultado INT;
    DECLARE result_message VARCHAR(200);
    SET resultado = (accion * huelguistas);
    
     IF resultado IS NULL THEN
        SET result_message = "cargue nuevamente los datos, deben ser numericos";
    ELSE
        SET result_message = CONCAT('la cantidad de manifestantes es ', resultado);
    END IF;
    
    RETURN result_message;

    END $$
    DELIMITER ;


-- 2)
-- se mide la relevancia de una palabra en el corpus de noticia con el que trabajamos.
-- la funcion permite al usuario cargar cualquier tipo de palabra y realizar una medicion de la misma.
-- la medicion se establece a partir de contar la cantidad de veces que se menciona dicha palabra en la columna "titulo"
-- y se divide dicha cantidad por el total de filas -cada fila representa una noticia.


DROP function if exists fn_palabra_t;
DELIMITER $$
CREATE FUNCTION fn_palabra_t (p_cp CHAR(50))
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE resultado FLOAT;
    DECLARE result_message VARCHAR(200);
    SET resultado = (
        SELECT COUNT(*) 
        FROM fuente
    ) / (
        SELECT SUM(LENGTH(titulo) - LENGTH(REPLACE(titulo, p_cp, '')))
        FROM fuente
    );
    
        IF resultado IS NULL THEN
        SET result_message = "No se encuentra la palabra indicada. cargue una nueva";
    ELSE
        SET result_message = CONCAT('la tasa es ', resultado);
    END IF;
    
    RETURN result_message;
    
END $$
DELIMITER ;

-- probamos y funciona bien SELECT fn_palabra_t ('') as mencion_repartidor



-- 3)
-- se realiza el mismo ejercicio que el anterior pero en este caso medimos sobre la columna texto
-- en donde se encuentra la totalidad del texto de la nota periodistica. 

drop function if exists fn_palabra_c;
DELIMITER $$
CREATE FUNCTION fn_palabra_c (p_texto CHAR(50))
RETURNS VARCHAR (200)
DETERMINISTIC
BEGIN
    DECLARE resultado FLOAT;
    DECLARE result_message VARCHAR(200);
    
    SET resultado = (SELECT COUNT(*) 
        FROM fuente
    ) / (
        SELECT SUM(LENGTH(texto) - LENGTH(REPLACE(texto, p_texto, '')))
        FROM fuente
    );
    
     IF resultado IS NULL THEN
        SET result_message = "No se encuentra la palabra indicada. cargue una nueva";
    ELSE
        SET result_message = CONCAT('la tasa es ', resultado);
    END IF;
    
    RETURN result_message;
    
END $$
DELIMITER ;

-- probamos funciona bien. select fn_palabra_c('huelga') as mencion_cuerpo

-- 4)
-- se mide una palabra clave sobre el total de palabras de la columna titulo y texto


drop function if exists fn_palabrastot;
DELIMITER $$
CREATE FUNCTION fn_palabrastot (p_titytex CHAR(50))
RETURNS VARCHAR (200)
DETERMINISTIC
BEGIN
    DECLARE resultado FLOAT;
	DECLARE result_message VARCHAR(200);
    
    SET resultado = (SELECT COUNT(*) FROM fuente) 
    / (
	(SELECT SUM(LENGTH(texto) - LENGTH(REPLACE(texto, p_titytex, '')))FROM fuente) + 
	(SELECT SUM( LENGTH(titulo)- LENGTH(REPLACE(titulo, p_titytex, '')))FROM fuente)
        );
        
          IF resultado IS NULL THEN
        SET result_message = "No se encuentra la palabra indicada. cargue una nueva";
    ELSE
        SET result_message = CONCAT('la tasa es ', resultado);
    END IF;
    
    RETURN result_message;
END $$
DELIMITER ;

-- funciona bien select fn_palabra_c ('huelga') as mencion_total;

 
-- 4.
-- el usuario puede cargar una fecha de inicio y de finalizacion
-- la función devuelve la cantidad de individuos movilizados en el periodo seleccionado. 

DROP FUNCTION IF EXISTS fn_participantes_fecha; 
DELIMITER //
CREATE FUNCTION fn_participantes_fecha(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE total_participantes INT;
    DECLARE result_message VARCHAR(200);
    
    SELECT SUM(participantes) INTO total_participantes
    FROM v_fecha_accion
    WHERE fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
    
    IF total_participantes IS NULL THEN
        SET result_message = 'No se encuentran participantes en acciones en las fechas seleccionadas. Cargue nuevas fechas';
    ELSE
        SET result_message = CONCAT('Total de participantes: ', total_participantes);
    END IF;
    
    RETURN result_message;
END;
//
DELIMITER ;
