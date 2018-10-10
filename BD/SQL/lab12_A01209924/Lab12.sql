IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Materiales')

DROP TABLE Materiales

CREATE TABLE Materiales
(
  Clave numeric(5) not null,
  Descripcion varchar(50),
  Costo numeric (8,2)
) 

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proveedores')

DROP TABLE Proveedores

CREATE TABLE Proveedores
(
  RFC char(13) not null,
  RazonSocial varchar(50)
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proyectos')

DROP TABLE Proyectos

CREATE TABLE Proyectos
(
  Numero numeric(5) not null,
  Denominacion varchar(50)
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Entregan')

DROP TABLE Entregan

CREATE TABLE Entregan
(
  Clave numeric(5) not null,
  RFC char(13) not null,
  Numero numeric(5) not null,
  Fecha DateTime not null,
  Cantidad numeric (8,2)
) 

--Insertar datos a las tablas
BULK INSERT a1209924.a1209924.[Materiales]
   FROM 'e:\wwwroot\a1209924\materiales.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

BULK INSERT a1209924.a1209924.[Proyectos]
   FROM 'e:\wwwroot\a1209924\proyectos.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

BULK INSERT a1209924.a1209924.[Proveedores]
   FROM 'e:\wwwroot\a1209924\proveedores.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

SET DATEFORMAT dmy -- especificar formato de la fecha

BULK INSERT a1209924.a1209924.[Entregan]
   FROM 'e:\wwwroot\a1209924\entregan.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

	  --Ejercicio 2
	  INSERT INTO Materiales values(1000, 'xxx', 1000) 

	  Delete from Materiales where Clave = 1000 and Costo = 1000 

	  ALTER TABLE Materiales add constraint llaveMateriales PRIMARY KEY (Clave) 

	  INSERT INTO Materiales values(1000, 'xxx', 1000) 

	  sp_helpconstraint materiales 

	  --ALTER TABLE tableName drop constraint ConstraintName 

	  --Ejercicio 3
	  INSERT INTO entregan values (0, 'xxx', 0, '1-jan-02', 0) ;

	  Delete from Entregan where Clave = 0 

	 -- ALTER TABLE entregan add constraint cfentreganclave
	  --foreign key (clave) references materiales(clave); 

	  --Ejercicio 4
	  INSERT INTO entregan values (1000, 'AAAA800101', 5000, GETDATE(), 0); 

	  ALTER TABLE entregan add constraint cantidad check (cantidad > 0) ; 