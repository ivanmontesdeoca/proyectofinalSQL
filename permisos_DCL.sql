-- permisos y usuarios
-- 1: me creo un usuario para mi mismo porque estaba usando el host sin contraseña
-- en principio funciona bien, me otorgo todos los privilegios, los actualizo y creo una base de datos.

CREATE USER ivanmontesdeoca@localhost IDENTIFIED BY 'LEON2486';

GRANT ALL PRIVILEGES ON *.* TO ivanmontesdeoca@localhost;

FLUSH PRIVILEGES;

CREATE DATABASE SQLcurso_plat;

-- 2. creo un usuario llamado coderhouse para que pueda visualizar la organizacion

CREATE USER CODERHOUSE@localhost IDENTIFIED BY 'CODERHOUSE';

GRANT SELECT ON plataforma.organizacion to CODERHOUSE@localhost;

-- 3 le otorgo permisos para visualizar e insertar datos en la tabla demanda

GRANT SELECT, INSERT ON plataforma.demanda to CODERHOUSE@localhost;

-- 4 chequeamos que se adjusicaron los permisos utilizando el schema oculto SQL
USE mysql;
SHOW GRANTS FOR CODERHOUSE@localhost;

-- 5 genero un nuevo usuario que puede ver, insertar y actualizar todas las tablas

CREATE USER CODERHOUSE1@localhost IDENTIFIED BY 'CODERHOUSE1';

GRANT SELECT, INSERT, UPDATE ON *.* to CODERHOUSE1@localhost;

-- 6 borro los permisos del usuario CODERHOUSE

REVOKE UPDATE ON *.* FROM CODERHOUSE@localhost;