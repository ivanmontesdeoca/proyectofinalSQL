Use plataforma;

-- cargamos las distintas tablas. comenzamos con la tabla fuente 
-- que en nuestra base de datos es la tabla principal

drop table if exists fuente;
CREATE table fuente (
id_fuente int NOT NULL auto_increment,
fecha date NOT NULL,
link_ varchar(200) NOT NULL, 
titulo TEXT (400) NOT NULL,
texto TEXT (5000) NOT NULL,
seccion char (20) NULL,
primary key (id_fuente));

drop table if exists fechaylugar;
CREATE table fechaylugar (
id_fuente int NOT NULL,
id_fechaylugar int NOT NULL auto_increment,
fecha date NOT NULL,
pais char (30) NOT NULL,
provincia char (30) NULL,
ciudad char (30) NULL,
primary key (id_fechaylugar, id_fuente),
CONSTRAINT FK_fuente_fechaylugar foreign key (id_fuente) references fuente(id_fuente));

drop table if exists accidentes;
CREATE table accidentes (
id_fuente int NOT NULL,
id_accidentes int NOT NULL auto_increment,
tipo_accidente char (50) NOT NULL,
vehiculo char (10) NULL, -- esto tiene que ser con opcion 
motivo char (200) NULL,
primary key (id_accidentes),
CONSTRAINT FK_accidentes foreign key (id_fuente) references fuente(id_fuente));

drop table if exists inseguridad;
CREATE table inseguridad (
id_fuente int NOT NULL,
id_inseguridad int NOT NULL auto_increment,
tipo_inseguridad char (50) NOT NULL,
arma char (12) NULL,
motivo tinytext NULL,
primary key (id_inseguridad),
CONSTRAINT FK_inseguridad foreign key (id_fuente) references fuente(id_fuente));


drop table if exists salud_repartidor;
CREATE table salud_repartidor (
id_fuente int not NULL,
id_accidentes int NULL,
id_violencia int NULL,
id_salud_repartidor int NOT NULL auto_increment,
Estado char (50) NOT NULL, 
obra_social char (20) NULL, -- esto tiene que ser con opcion
ART ENUM ('SI', 'NO') NULL, -- esto tiene que ser con opcion
primary key (id_salud_repartidor),
CONSTRAINT FK_salud_ foreign key (id_fuente) references fuente(id_fuente));

drop table if exists conflicto;
CREATE table conflicto (
id_fuente int NOT NULL,
id_conflicto int NOT NULL auto_increment,
primary key (id_conflicto),
CONSTRAINT FK_conflicto foreign key (id_fuente) references fuente(id_fuente));


drop table if exists demanda;
CREATE table demanda (
id_fuente int NOT NULL,
id_conflicto int NOT NULL,
id_demanda int NOT NULL auto_increment,
tipo_demanda ENUM ("SALARIAL", "SEGURIDAD SOCIAL", "RECONOCIMIENTO LABORAL") NOT NULL, -- este podria ser con opciones
demanda MEDIUMTEXT NOT NULL,
primary key (id_demanda),
CONSTRAINT FK_demanda foreign key (id_fuente) references fuente(id_fuente),
CONSTRAINT FK_demanda_ foreign key (id_conflicto) references conflicto(id_conflicto));


drop table if exists accion;
CREATE table accion (
id_fuente int NOT NULL,
id_conflicto int NOT NULL,
id_accion int NOT NULL auto_increment,
tipo_accion ENUM ("MOVILIZACION", "PARO", "DESCONEXION","DECLARACION","CORTE", "DESPIDO", "LOCK OUT") NOT NULL, -- este podria ser con opciones
accion mediumtext NOT NULL,
participantes SMALLINT NULL,
primary key (id_accion),
CONSTRAINT FK_accion foreign key (id_fuente) references fuente(id_fuente),
CONSTRAINT FK_accion_ foreign key (id_conflicto) references conflicto(id_conflicto));


drop table if exists organizacion;
CREATE table organizacion (
id_fuente int NOT NULL,
id_conflicto int NOT NULL,
id_org int NOT NULL auto_increment,
name_org TINYTEXT NOT NULL, -- este podria ser con opciones
tipo_org ENUM("SINDICATO","AGRUPACION","RED") NULL,
orientacion ENUM("TRADICIONAL", "BASE", "ESPONTANEA") NULL,
primary key (id_org),
CONSTRAINT FK_org foreign key (id_fuente) references fuente(id_fuente),
CONSTRAINT FK_org_ foreign key (id_conflicto) references conflicto(id_conflicto));

drop table if exists empresa;
CREATE table empresa (
id_fuente int NOT NULL,
id_conflicto int NOT NULL,
id_empresa int NOT NULL auto_increment,
name_empresa ENUM("RAPPI","PEDIDOS YA", "GLOVO", "UBEREATS") NOT NULL, 
primary key (id_empresa),
CONSTRAINT FK_empresa foreign key (id_fuente) references fuente(id_fuente),
CONSTRAINT FK_empresa_ foreign key (id_conflicto) references conflicto(id_conflicto));

drop table if exists politicas_publicas;
CREATE TABLE politicas_publicas(
id_fuente int NOT NULL,
id_pol int NOT NULL auto_increment,
institucion ENUM("ESTADO NACIONAL", "EJECUTIVO CABA", "EJECUTIVO BSAS", "LEGISLATURA", "PODER JUDICIAL") NOT NULL, 
accion tinytext NOT NULL,
objetivo ENUM("regulacion laboral", "regulacion comercial") NOT NULL,
primary key (id_pol),
CONSTRAINT FK_pol foreign key (id_fuente) references fuente(id_fuente));





