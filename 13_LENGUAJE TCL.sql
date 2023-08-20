use plataforma;

-- -- --------------------------------------------
-- LENGUAJE TCL --
-- -- ------------------------------------------

-- se realizan las funciones commit, rollback y savepoint

-- 1. se actualizan los valores de una variable de la tabla 'demanda' 
-- mediante la expresion 'commit' se confirma la modificacion. 

START TRANSACTION;

savepoint savepoint_1;
UPDATE demanda
SET demanda = 'regulacion laboral'
where id_demanda >= 3;

select * from demanda;

commit;

-- 2. 
-- se eliminan registros de la tabla 'demanda' y se la ordena en sentido decreciente,
-- se guardan los registros con la expresion commit

savepoint savepoint_2;
DELETE FROM 
	demanda 
where
	id_demanda >= 4; 

SELECT * FROM
	demanda
order by
	id_demanda desc
limit 5;
 
commit;


-- 3. 
-- se insertan dos registros en la tabla 'demanda', 
-- se emplea la expresion rollback para evitar que los cambios se realicen.

savepoint savepoint_3;

insert into demanda values (29,4,4,'SEGURIDAD SOCIAL', 'elementos de higiene');
insert into demanda values (30,5,5, 'SALARIAL', 'condiciones de trabajo');

--  no me reconoce este rollback
rollback;

select * from demanda;

-- 4. 
-- se eliminan todos los registros de la tabla demanda con el objetivo de dejar
-- la version final en el siguiente paso

savepoint savepoint_4;
DELETE FROM 
	demanda 
where
	id_demanda <= 3; 



