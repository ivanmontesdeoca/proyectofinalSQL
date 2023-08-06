use plataforma;

-- primer ejercicio a modo de prueba. Se crean dos variables que son cantidad de acciones (movilizaciones o paros, por ejemplo)
-- y se busca multiplicarlo por una cantidad de huelguistas determinada para conocer el total de huelguistas
-- el ejercicio tiene un limite claro dado que presupone que siempre la cantidad de huelguistas es equivalente
-- en todas las movilizaciones. De todas formas el objetivo es comenzar a probar el funcionamiento de las funciones.

DELIMITER $$
-- drop if not exists f_huelguistas;
CREATE function f_huelguistas (accion INT, huelguistas INT) RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE resultado INT;
    SET resultado = (accion * huelguistas);
    RETURN resultado;
    END $$
    DELIMITER ;
    
-- probabmos, funciona bien.  select f_huelguistas(5, 256) as cantidad_huelguistas;


-- 2)
-- en esta funcion vamos a medir la relevancia de una palabra en el corpus de noticia con el que trabajamos.
-- la funcion permite al usuario cargar cualquier tipo de palabra y realizar una medicion de la misma.
-- la medicion se establece a partir de contar la cantidad de veces que se menciona dicha palabra en la columna "titulo"
-- y se divide dicha cantidad por el total de filas -cada fila representa una noticia.

DELIMITER $$
drop function if exists fn_palabra_t;
CREATE FUNCTION fn_palabra_t (p_cp CHAR(50))
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE resultado FLOAT;
    SET resultado = (
        SELECT COUNT(*) 
        FROM fuente
    ) / (
        SELECT SUM(LENGTH(titulo) - LENGTH(REPLACE(titulo, p_cp, '')))
        FROM fuente
    );
    RETURN resultado;
END $$
DELIMITER ;

-- probamos y funciona bien. SELECT fn_palabra_t ('') as mencion_repartidor



-- 3)
-- se realiza el mismo ejercicio que el anterior pero en este caso medimos sobre la columna texto
-- en donde se encuentra la totalidad del texto de la nota periodistica. 

DELIMITER $$
drop function if exists fn_palabra_c;
CREATE FUNCTION fn_palabra_c (p_texto CHAR(50))
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE resultado FLOAT;
    SET resultado = (SELECT COUNT(*) 
        FROM fuente
    ) / (
        SELECT SUM(LENGTH(texto) - LENGTH(REPLACE(texto, p_texto, '')))
        FROM fuente
    );
    RETURN resultado;
END $$
DELIMITER ;

-- probamos funciona bien. select fn_palabra_c('huelga') as mencion_cuerpo

-- ahora vamos a hacer la misma medicion pero tomando el total de titulo y texto

DELIMITER $$
drop function if exists fn_palabra_c;
CREATE FUNCTION fn_palabra_c (p_titytex CHAR(50))
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE resultado FLOAT;
    SET resultado = (SELECT COUNT(*) FROM fuente) 
    / (
	(SELECT SUM(LENGTH(texto) - LENGTH(REPLACE(texto, p_titytex, '')))FROM fuente) + 
	(SELECT SUM( LENGTH(titulo)- LENGTH(REPLACE(titulo, p_titytex, '')))FROM fuente)
        );
    RETURN resultado;
END $$
DELIMITER ;

-- funciona bien select fn_palabra_c ('huelga') as mencion_total;

 

