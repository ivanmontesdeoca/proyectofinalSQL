Use plataforma;

-- -- --------------------------------------------
-- PERMISOS a USUARIOS --
-- -- ------------------------------------------

-- 1: creo un usuario 'ivanmontesdeoca' y asigno un password.
-- le asigno todos los permisos 

CREATE USER ivanmontesdeoca@localhost IDENTIFIED BY 'LEON2486';

GRANT ALL PRIVILEGES ON *.* TO ivanmontesdeoca@localhost;

FLUSH PRIVILEGES;

CREATE DATABASE SQLcurso_plat;

-- 2. 
-- se genera un usuario llamado coderhouse 
-- se le asigna permisos visualizar la tabla 'organizacion'

CREATE USER CODERHOUSE@localhost IDENTIFIED BY 'CODERHOUSE';

GRANT SELECT ON plataforma.organizacion to CODERHOUSE@localhost;

-- 3 
-- se le asignan mas permisos al usuario coderhouse
-- se permite visualizar e insertar datos en la tabla 'demanda'.

GRANT SELECT, INSERT ON plataforma.demanda to CODERHOUSE@localhost;

-- 4
-- se realiza un chequeo de permisos al usuario coderohouse
-- se confirma que se adjusicaron permisos utilizando el schema oculto SQL
USE mysql;
SHOW GRANTS FOR CODERHOUSE@localhost;

-- 5 
-- se genera un nuevo usuario 'coderhouse1' y se asigna password
-- se le da permiso para realizar insercion de datos y actualizar todas las tablas

CREATE USER CODERHOUSE1@localhost IDENTIFIED BY 'CODERHOUSE1';

GRANT SELECT, INSERT, UPDATE ON *.* to CODERHOUSE1@localhost;

-- 6 
-- se eliminan la totalidad de permisos al usuario CODERHOUSE impidiendole el acceso a la base de datos

REVOKE UPDATE ON *.* FROM CODERHOUSE@localhost;