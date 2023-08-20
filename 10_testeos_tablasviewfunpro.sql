use plataforma;

-- COMANDOS PARA PROBAR LAS TABLAS

-- VISTA TOTAL DE CADA UNA DE LAS TABLAS
SELECT * FROM fuente;
SELECT * FROM fechaylugar;
SELECT * FROM multilugar;
SELECT * FROM inseguridad;
SELECT * FROM accidentes;
SELECT * FROM salud_repartidor;
SELECT * FROM conflicto;
SELECT * FROM accion;
SELECT * FROM demanda;
SELECT * FROM organizacion;
SELECT * FROM empresa;
SELECT * FROM politicas_publicas;

-- VISTAS TOTAL DE CADA UNA DE LAS TABLAS DE AUDITORIAS
SELECT * FROM audit_accion;
SELECT * FROM audit_dem;
SELECT * FROM audit_pol3;

-- VISTAS VIEWS SELECCIONADAS 
select * from v_accion_judicial;
select * from v_conflictividad;
select * from v_huelgas;
select * from v_inseguridad;
select * from v_participantes;
select * from v_fecha_accion;

-- PRUEBA DE FUNCIONES

-- se debe agregar o cambiar la cantidad de acciones y cantidad de huelguistas
-- por ejemplo 3, 40 entre parentesis
SELECT f_huelguistas(2, 50) as cantidad_huelguistas;
-- se debe agregar o reemplazar una palabra clave (''), p.j. repartidor
SELECT fn_palabra_c ('repartidor') as med_palabra_tex;
-- se debe agregar o reemplazar una palabra clave (''), p.j. huelga. 
SELECT fn_palabra_t ('huelga') as med_palabra_tit;
-- se debe agregar o reemplazar una palabra clave (''), p.j. Rappi, midel en titulo y texto
SELECT fn_palabrastot ('rappi') as med_palabra_tot;
-- se debe cargar o reemplazar la fecha de inicio y fin. La función devuelve la cantidad de 
-- huelguistas
SELECT fn_participantes_fecha('2011-01-01', '2012-06-30') AS total_participantes;

-- testeo de procedimientos 
-- 1. se debe agregar o reemplazar palabra clave
call P_seleccion ('regulacion laboral');

-- 2  contar_filas_con_variable 
-- se debe aplicar desde consola (boton rayo)
