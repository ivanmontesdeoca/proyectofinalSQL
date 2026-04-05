# Base de Datos – Actividad de Repartidores en Plataformas

## Descripción del proyecto

Este proyecto consiste en el diseño e implementación de una base de datos relacional en MySQL construida 
a partir de noticias periodísticas sobre plataformas de reparto (scraping de Infobae).

El objetivo es analizar la actividad del sector mediante tres dimensiones principales:

- Conflictos laborales  
- Accidentes e inseguridad en la vía pública  
- Políticas regulatorias  

## Modelo de datos

La base de datos presenta una estructura jerárquica (piramidal):

# Nivel 1 – Tabla principal
- `fuente`: contiene la información central de cada noticia (link, fecha, título, texto)

# Nivel 2 – Tablas temáticas
- `fechaylugar`
- `conflicto`
- `accidente_transito`
- `inseguridad`
- `politicas_publicas`

# Nivel 3 – Tablas derivadas
- Conflictos:
  - `demanda`
  - `accion`
  - `organizacion`
  - `empresa`
- Accidentes/Inseguridad:
  - `estado_repartidor`

---

## ⚙️ Funcionalidades principales

### 📊 Vistas (Views)
Se desarrollaron vistas para facilitar el análisis:

- `v_violencias`: estado de repartidores afectados  
- `v_participantes`: acciones colectivas con alta participación  
- `v_huelgas`: detección de protestas  
- `v_conflictividad`: integración de demandas, acciones y organizaciones  
- `v_fecha_accion`: análisis temporal y geográfico  

---

### 🧮 Funciones
Funciones orientadas al análisis de datos y minería de texto:

- Estimación de cantidad de huelguistas  
- Frecuencia de palabras clave en títulos  
- Frecuencia de palabras clave en textos  
- Medición combinada de relevancia textual  
- Cálculo de participantes en periodos específicos  

# Procedimientos almacenados
- Filtrado de políticas públicas por palabra clave  
- Conteo de tipos de acciones colectivas  

# Triggers
- Registro automático de cambios  
- Auditoría de modificaciones  
- Copia de datos relevantes  

# Control y administración

- Control de transacciones (COMMIT, ROLLBACK, SAVEPOINT)  
- Gestión de permisos con DCL (GRANT / REVOKE)  
- Creación de usuarios  

# Backup
Se incluye respaldo de tablas clave para preservar información ante modificaciones.

---

# Tecnologías utilizadas

- MySQL  
- SQL (DDL, DML, DQL, TCL, DCL)  
- Modelado relacional  

## Objetivo analítico

La base permite:

- Analizar la evolución de conflictos laborales  
- Identificar demandas y repertorios de protesta  
- Medir la inseguridad en el trabajo de reparto  
- Evaluar políticas públicas en el sector  

---

## Posibles mejoras

- Automatización del procesamiento de texto  
- Integración con herramientas de análisis (Python / NLP)  
- Pipeline automatizado de scraping  

---

## Iván Montes de Oca

Iván Montes de Oca  
🔗 https://github.com/ivanmontesdeoca
