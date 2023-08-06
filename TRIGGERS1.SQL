-- TRIGGERS
use plataforma;

-- TRIGGERS SIMPLE, copia de tabla 
DROP TABLE IF EXISTS audit_pol; 
CREATE TABLE audit_pol (
id_audir INT PRIMARY KEY auto_increment,
id_pol INT,
institucion ENUM('ESTADO NACIONAL','EJECUTIVO CABA','EJECUTIVO BSAS','LEGISLATURA','PODER JUDICIAL'),
accion TINYTEXT,
OBJETIVO ENUM('regulacion laboral','regulacion comercioal')
);

DROP TRIGGER IF EXISTS trig_inser_politicas;

DELIMITER $$
CREATE TRIGGER trig_inser_politicas
AFTER INSERT ON politicas_publicas
FOR EACH ROW	
BEGIN
INSERT INTO audit_pol (id_pol, institucion, accion, objetivo)
VALUES (NEW.id_pol, NEW.institucion, NEW.accion, NEW.objetivo);
END $$
DELIMITER ;

INSERT INTO politicas_publicas(id_fuente, id_fechaylugar, id_pol, institucion, accion, objetivo)
VALUES (11,12,13,'PODER JUDICIAL', 'sancion', 'regulacion laboral');

INSERT INTO politicas_publicas(id_fuente, id_fechaylugar, id_pol, institucion, accion, objetivo)
VALUES (16,16, 10, 'PODER JUDICIAL', 'sancion', 'regulacion laboral');

-- funciona bien select * from politicas_publicas
-- funciona bien select * from audit_pol


-- ahora vamos a agregar usuario, hora de carga de la modificacion. pero no mas informacion.
-- TRIGGERS, copia tabla y agrega dia, usuario y consola de modificaicon. 


DROP TABLE IF EXISTS audit_pol2; 

CREATE TABLE audit_pol2 (
id_audit2 INT PRIMARY KEY auto_increment,
id_pol INT,
fecha DATE,
usuario VARCHAR(40),
procedimiento  VARCHAR(40) 
);

DROP TRIGGER IF EXISTS trig_upload_politicas2;

DELIMITER $$

CREATE TRIGGER trig_upload_politicas2
AFTER INSERT ON politicas_publicas
FOR EACH ROW	
BEGIN
INSERT INTO audit_pol2 (id_pol, fecha, usuario, procedimiento)
VALUES (NEW.id_pol, CURRENT_DATE(), USER(), DATABASE());

END $$
DELIMITER ;

INSERT INTO politicas_publicas(id_fuente, id_fechaylugar, id_pol, institucion, accion, objetivo)
VALUES(17, 17, 11,'PODER JUDICIAL','multa','regulacion laboral');

INSERT INTO politicas_publicas(id_fuente, id_fechaylugar, id_pol, institucion, accion, objetivo)
VALUES(18, 18, 12,'PODER JUDICIAL','multa','regulacion laboral');


-- funciona bien select * from politicas_publicas;
-- funciona bien select * from audit_pol2;

-- ahora creo otros tres sobre la misma tabla que me permiten 
-- registras los datos eliminados, actualizados e insertos. 

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
  INSERT INTO audit_pol3 (id_pol, fecha, usuario, procedimiento)
  VALUES (OLD.id_pol, CURRENT_DATE(), USER(), 'DELETE');
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

delete from politicas_publicas where id_pol = 14;

INSERT INTO politicas_publicas(id_fuente, id_fechaylugar, id_pol, institucion, accion, objetivo)
VALUES(20, 20, 14,'PODER JUDICIAL','multa','regulacion laboral');

UPDATE politicas_publicas
SET accion = 'intimidacion'
WHERE id_pol = 14;

-- funciona bien select * from politicas_publicas;
-- funciona bien select * from audit_pol3;

 
