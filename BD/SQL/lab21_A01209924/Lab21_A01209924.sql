--¿Qué hace el primer bloque del código (bloque del IF)?
--Si ya existe el procedimiento creaMaterial, lo borrará

--¿Para qué sirve la instrucción GO?
--Sirve como un paréntesis
--¿Explica que recibe como parámetro este Procedimiento y qué tabla modifica?
--Recibe los nombres de las columnas de la tabla Materiales para agregar uno nuevo con el uso de procedure

--############Sección Materiales############
IF EXISTS (SELECT name FROM sysobjects
WHERE name = 'creaMaterial' AND type = 'P')
DROP PROCEDURE creaMaterial

GO
CREATE PROCEDURE creaMaterial
	@uclave NUMERIC(5,0),
	@udescripcion VARCHAR(50),
	@ucosto NUMERIC(8,2),
	@uimpuesto NUMERIC(6,2)
AS
INSERT INTO Materiales VALUES(@uclave, @udescripcion, @ucosto, @uimpuesto)
GO

--Para ejecutar el stored procedure, se utiliza la sintaxis mostrada en el siguiente ejemplo:
EXECUTE creaMaterial 5000,'Martillos Acme',250,15
SELECT * FROM Materiales

--Modificar material
IF EXISTS (SELECT name FROM sysobjects
WHERE name = 'modificaMaterial' AND TYPE = 'P')
DROP PROCEDURE modificaMaterial
GO
CREATE PROCEDURE modificaMaterial
	@oldclave NUMERIC(5,0),
	@uclave NUMERIC(5,0),
	@udescripcion VARCHAR(50),
	@ucosto NUMERIC(8,2),
	@uimpuesto NUMERIC(6,2)
AS
UPDATE Materiales
SET Clave=@uclave, Descripcion=@udescripcion, Costo=@ucosto, PorcentajeImpuesto=@uimpuesto
WHERE Clave=@oldclave
GO

EXECUTE modificaMaterial 5000,5001,'Martillos Acme',250,15

SELECT * FROM Materiales

--eliminaMaterial
IF EXISTS (SELECT name FROM sysobjects
WHERE name = 'eliminaMaterial' AND TYPE = 'P')
DROP PROCEDURE eliminaMaterial

GO
CREATE PROCEDURE eliminaMaterial
	@uClave NUMERIC(5,0)
AS
DELETE FROM Materiales WHERE Clave=@uClave
GO
EXECUTE creaMaterial 9999,'Martillos Acme',250,15
EXECUTE eliminaMaterial 9999

--############Sección Proyectos############
--Agregar proyecto
IF EXISTS (SELECT name FROM sysobjects
WHERE name = 'creaProyecto' AND type = 'P')
DROP PROCEDURE creaProyecto
GO
CREATE PROCEDURE creaProyecto
	@unumero NUMERIC(5,0),
	@udenominacion VARCHAR(50)
AS
INSERT INTO Proyectos VALUES(@unumero, @udenominacion)
GO

EXECUTE creaProyecto 9999,'ProyectoPrueba'
--Modificar proyecto
IF EXISTS (SELECT name FROM sysobjects
WHERE name = 'modificaProyecto' AND type = 'P')
DROP PROCEDURE modificaProyecto
GO
CREATE PROCEDURE modificaProyecto
	@
GO

SELECT * FROM 
--############Sección Proveedores############
--############Sección Entregan############


--Realizar consultas con parámetros
IF EXISTS (SELECT name FROM sysobjects
            WHERE name = 'queryMaterial' AND type = 'P')
    DROP PROCEDURE queryMaterial
GO

CREATE PROCEDURE queryMaterial
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8,2)

AS
    SELECT * FROM Materiales WHERE descripcion
    LIKE '%'+@udescripcion+'%' AND costo > @ucosto
GO

EXECUTE queryMaterial 'Lad',20

--Consulta para proyecto MercadoTec
DROP PROCEDURE IF EXISTS qTieneVentasE

DELIMITER //
CREATE PROCEDURE qTieneVentasE()
BEGIN
	SELECT T.num_compra, fecha, C.total
	FROM TieneVenta T, Ventas V, Compra C
	WHERE T.num_compra = V.num_compra
	AND V.num_compra = C.num_compra
	AND T.num_compra NOT LIKE '';
END //
DELIMITER ;

CALL qTieneVentasE()