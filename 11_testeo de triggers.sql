USE plataforma;

-- -- --------------------------------------------
-- testeamos triggers --
-- -- ------------------------------------------

-- 1. probamos el trigger trig_inser_demanda que 
-- copia en la tabla audit_dem los INSERT realizados en la tabla demanda

insert into demanda (id_fuente,id_conflicto, tipo_demanda, demanda)
VALUES (8, 3,'SALARIAL', 'reclaman aumento de salario');

-- verificamos con
-- select * from demanda;
-- select * from audit_dem;

-- 2. probamos el trigger trig_upload_accion
-- que interviene en las inserciones de la tabla accion 
-- agregando id, fecha, usuario y consola en la tabla audit_accion

insert into accion (id_fuente, id_conflicto, tipo_accion, accion, participantes)
VALUES (12, 5,'MOVILIZACION', 'marcharon en la 9 de julio', 150);

-- testeamos y la informacion se cargo correctamente
-- select * from accion;
-- select * from audit_accion;

-- 3. testeamos el trigger trig_delete_politicas
-- este trigger interviene ante eliminacion, modificacion o insercion de datos
-- en la tabla 'politicas_publicas' y guarda la informacion en la tabla 'audit_pol3'

delete from politicas_publicas where id_pol = 14;

INSERT INTO politicas_publicas(id_fuente, id_fechaylugar, id_pol, institucion, accion, objetivo)
VALUES(20, 20, 14,'PODER JUDICIAL','multa','regulacion laboral');

UPDATE politicas_publicas
SET accion = 'intimidacion'
WHERE id_pol = 14;

-- testeamos que funcionan las distintas operaciones y confirmamos que las acciones
-- son exitosas 
-- select * from politicas_publicas;
-- select * from audit_pol3;