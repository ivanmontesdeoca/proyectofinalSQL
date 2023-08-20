use plataforma;


-- 1
-- se crea la vista de la informacion de la tabla violencia
CREATE OR REPLACE VIEW v_inseguridad AS(
select salud_repartidor.Estado, inseguridad.tipo_inseguridad, inseguridad.arma, inseguridad.motivo
	from salud_repartidor join inseguridad
	on salud_repartidor.id_fuente = inseguridad.id_fuente);



-- 2
-- se crea una vista sobre la tabla accion que muestra las
-- acciones en la que participaron mas de 100 manifestantes 
CREATE OR REPLACE VIEW v_participantes AS
select accion.accion, organizacion.name_org 
from accion join organizacion 
on accion.id_conflicto = organizacion.id_conflicto
where accion.participantes >= 100;


-- 3
-- se crea una vista sobre la tabla fuente
-- que filtra la informacion de la columna 'titulo' (de noticias periodisticas)
-- a partir de palabras que refieren a la conflictividad
-- como 'huelga' o 'protesta' y se las ordenada por id
CREATE OR REPLACE VIEW v_huelgas AS
select titulo, id_fuente, fecha from fuente
where titulo like '%hue%'
or titulo like '%prot%'
order by id_fuente; 


-- 4.
-- se realiza la vista de informacion de tres tablas referentes a la conflictividad
-- se trata de las tablas demanda, accion y organizacion.
CREATE OR REPLACE VIEW v_conflictividad AS
(select demanda.tipo_demanda, demanda.demanda, accion.tipo_accion, accion.accion, organizacion.name_org, organizacion.tipo_org
from demanda join organizacion
on demanda.id_conflicto = organizacion.id_conflicto 
join accion
on demanda.id_conflicto = accion.id_conflicto);


-- 5. 
-- se crea una vista sobre la tabla politicas publucas
-- que muestra las acciones judiciales vinculadas al poder judicial y a la regulacion laboral

CREATE or REPLACE VIEW v_accion_judicial as(
select * from politicas_publicas
where objetivo like '%laboral%' 
and institucion like '%judicial%'
or institucion like'%poder%'
order by id_pol);

-- 6
-- Se muestra la fecha y el pais de las acciones realizadas y de la cantidad de participantes 

CREATE OR REPLACE VIEW v_fecha_accion AS(
select fechaylugar.fecha, fechaylugar.pais, accion.tipo_accion, accion.participantes
	from fechaylugar join accion
	on fechaylugar.id_fuente = accion.id_fuente
    );


