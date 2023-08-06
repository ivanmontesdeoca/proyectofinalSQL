use plataforma;

-- se realizan las funciones commit, rollback y savepoint

-- 1. se cambian los valores de una variable de la tabla demanda y se fijan con la expresion commit

START TRANSACTION;

savepoint lote_1;
UPDATE demanda
SET demanda = 'regulacion laboral'
where id_demanda >= 3;

select * from demanda;

commit;

-- 2. se eliminan registros de la tabla demanda y se la ordena en sentido decreciente,
-- se guardan los registros con la expresion commit

savepoint lote_2;
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

select * from demanda;
-- 3. se insertan dos registros en la tabla demanda, luego con la expresion rollback los mismos no se guardan


savepoint lote_3;

insert into demanda values (29,4,4,'SEGURIDAD SOCIAL', 'elementos de higiene');
insert into demanda values (30,5,5, 'SALARIAL', 'condiciones de trabajo');

--  no me reconoce este rollback
rollback;

select * from demanda;

-- 4. elimino todos los registros de la tabla demanda con el objetivo de dejar la version final en el
-- siguiente paso

savepoint lote_4;
DELETE FROM 
	demanda 
where
	id_demanda <= 3; 

select * from demanda;

-- rollback to lote_3;
-- no me reconoce el rollback to lote_3

savepoint lote_5;
insert into demanda values (17,1,1,'SALARIAL', "condiciones de trabajo");
insert into demanda values (26,2,2,'SALARIAL', "condiciones de trabajo");
insert into demanda values (27,3,3,"SALARIAL", 'condiciones e trabajo');
insert into demanda values (29,4,4,'SEGURIDAD SOCIAL', 'elementos de higiene');
insert into demanda values (30,5,5, 'SALARIAL', 'condiciones de trabajo');

select * from demanda;

