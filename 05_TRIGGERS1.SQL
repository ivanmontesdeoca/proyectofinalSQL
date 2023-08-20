use plataforma;

-- -- --------------------------------------------
-- triggers --
-- -- ------------------------------------------


-- se crea un TRIGGER SIMPLE que copia la informacion inserta en la tabla demanda
-- en una tabla llamada audit_dem
DROP TABLE IF EXISTS audit_dem; 
CREATE TABLE audit_dem (
id_audit INT PRIMARY KEY auto_increment,
id_demanda INT,
tipo_demanda ENUM('SALARIAL','SEGURIDAD SOCIAL','RECONOCIMIENTO LABORAL'),
demanda MEDIUMTEXT
);

DROP TRIGGER IF EXISTS trig_inser_demanda;

DELIMITER $$
CREATE TRIGGER trig_inser_demanda
AFTER INSERT ON demanda
FOR EACH ROW	
BEGIN
INSERT INTO audit_dem (id_demanda, tipo_demanda, demanda)
VALUES (NEW.id_demanda, NEW.tipo_demanda, NEW.demanda);
END $$
DELIMITER ;



-- se crea TRIGGER que indica 'fecha', 'usuario' y 'consola' posterior a la
-- insersion de datos en la tabla 'accion'. La informacion se copia 
-- en una tabla llamada 'audit_accion'


DROP TABLE IF EXISTS audit_accion; 
CREATE TABLE audit_accion (
id_audit_accion INT PRIMARY KEY auto_increment,
id_accion INT,
fecha DATETIME,
usuario VARCHAR(40),
procedimiento  VARCHAR(40) 
);

DROP TRIGGER IF EXISTS trig_upload_accion;

DELIMITER $$

CREATE TRIGGER trig_upload_accion
AFTER INSERT ON accion
FOR EACH ROW	
BEGIN
INSERT INTO audit_accion (id_accion, fecha, usuario, procedimiento)
VALUES (NEW.id_accion, CURRENT_DATE(), USER(), DATABASE());

END $$
DELIMITER ;

-- se crean tres trigger sobre la tabla 'politicas publicas' que
-- registran los datos eliminados, actualizados e insertos en una tabla
-- llamada audit_pol3

DROP TABLE if exists audit_pol3;

CREATE TABLE audit_pol3 (
id_audit INT PRIMARY KEY auto_increment,
id_pol INT,
institucion VARCHAR (40),
accion VARCHAR(40),
objetivo VARCHAR (40),
fecha DATE,
usuario VARCHAR(40),
procedimiento  VARCHAR(40) 
);


DROP TRIGGER IF EXISTS trig_delete_politicas;

DELIMITER $$

CREATE TRIGGER trig_delete_politicas
AFTER DELETE ON politicas_publicas
FOR EACH ROW
BEGIN
  INSERT INTO audit_pol3 (id_pol, institucion,accion, objetivo, fecha, usuario, procedimiento)
  VALUES (OLD.id_pol, OLD.institucion, OLD.accion, OLD.objetivo, CURRENT_DATE(), USER(), 'DELETE');
END $$

DELIMITER ;


DROP TRIGGER IF EXISTS trig_update_politicas

DELIMITER $$

CREATE TRIGGER trig_update_politicas
AFTER UPDATE ON politicas_publicas
FOR EACH ROW
BEGIN
  INSERT INTO audit_pol3 (id_pol, institucion,accion, objetivo, fecha, usuario, procedimiento)
  VALUES (NEW.id_pol, NEW.institucion, NEW.accion, NEW.objetivo, CURRENT_DATE(), USER(), 'UPDATE');
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS trig_insert_politicas3;

DELIMITER $$

CREATE TRIGGER trig_insert_politicas3
AFTER INSERT ON politicas_publicas
FOR EACH ROW	
BEGIN

INSERT INTO audit_pol3 (id_pol, institucion, accion, objetivo, fecha, usuario, procedimiento)
VALUES (NEW.id_pol, NEW.institucion, NEW.accion, NEW.objetivo, CURRENT_DATE(), USER(), 'INSERT');

END $$

DELIMITER ;

 
