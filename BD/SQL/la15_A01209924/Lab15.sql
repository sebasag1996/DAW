--Consultar tabla completa
SELECT * FROM Materiales
--Selección
select * from materiales
where clave=1000

--Proyección
select clave,rfc,fecha from entregan 

--Join Natural
select * from materiales,entregan
where materiales.clave = entregan.clave

--Join Específico
select * from entregan,proyectos
where entregan.numero < = proyectos.numero

--Unión
(select * from entregan where clave=1450)
union
(select * from entregan where clave=1300)
--Unión sin usar Unión
SELECT * FROM entregan
WHERE clave=1450 OR clave=1300

--Intersección
(select clave from entregan where numero=5001)
intersect
(select clave from entregan where numero=5018) 

--Diferencia
select * from entregan
WHERE clave NOT IN (select clave from entregan where clave=1000)

--Producto cartesiano
select * from entregan,materiales

set dateformat dmy
SELECT descripcion FROM materiales m, entregan e
where m.clave = e.clave AND e.fecha >= '01-JAN-2000' AND e.fecha < '01-JAN-2001'

set dateformat dmy
SELECT DISTINCT descripcion FROM materiales m, entregan e
where m.clave = e.clave AND e.fecha >= '01-JAN-2000' AND e.fecha < '01-JAN-2001'

set dateformat dmy
SELECT P.Numero, denominacion, fecha FROM Proyectos P, Entregan E
ORDER BY P.numero ASC, fecha DESC

--Like
SELECT * FROM Materiales where Descripcion LIKE 'Si%'
--El % nos permite consultar todas los campos que empiece con Si en este ejemplo
--Si fuera solo Si la busqueda debe ser exactamente Si

--Operadores de cadena
DECLARE @foo varchar(40);
DECLARE @bar varchar(40);
SET @foo = '¿Que resultado';
SET @bar = ' ¿¿¿??? '
SET @foo += ' obtienes?';
PRINT @foo + @bar;

--Declare permite declarar variables
--Se obtiene un prompt preguntando el resultado
--@foo es el string
--Set setea un parametro en la variable


SELECT RFC FROM Entregan WHERE RFC LIKE '[A-D]%';
SELECT RFC FROM Entregan WHERE RFC LIKE '[^A]%';
SELECT Numero FROM Entregan WHERE Numero LIKE '___6';

--Between
SELECT Clave,RFC,Numero,Fecha,Cantidad
FROM Entregan
WHERE Numero Between 5000 and 5010;

set dateformat dmy
SELECT DISTINCT fecha FROM materiales m, entregan e
where m.clave = e.clave AND e.fecha BETWEEN '01-JAN-2000' AND '01-JAN-2001'

--Exists
SELECT RFC,Cantidad, Fecha,Numero
FROM [Entregan]
WHERE [Numero] Between 5000 and 5010 AND
Exists ( SELECT [RFC]
FROM [Proveedores]
WHERE RazonSocial LIKE 'La%' and [Entregan].[RFC] = [Proveedores].[RFC] ) 

--Exists usando IN
SELECT RFC,Cantidad, Fecha,Numero
FROM [Entregan]
WHERE [Numero] Between 5000 and 5010 AND RFC IN ( SELECT [RFC]
FROM [Proveedores]
WHERE RazonSocial LIKE 'La%' and [Entregan].[RFC] = [Proveedores].[RFC] )

--Exists usando NOT IN
SELECT RFC,Cantidad, Fecha,Numero
FROM [Entregan]
WHERE [Numero] Between 5000 and 5010 AND RFC NOT IN ( SELECT [RFC]
FROM [Proveedores]
WHERE RazonSocial NOT LIKE 'La%' and [Entregan].[RFC] != [Proveedores].[RFC] ) 

--SOME
SELECT RFC,Cantidad, Fecha,Numero
FROM [Entregan]
WHERE Numero >SOME(
 SELECT Numero FROM Entregan WHERE Numero = 5010
)

--TOP
SELECT TOP 2 * FROM Proyectos
SELECT TOP Numero FROM Proyectos

--devuelve los primeros 2 de la tabla

--Agregar dato y columna de Porcentajeimpuesto
ALTER TABLE materiales ADD PorcentajeImpuesto NUMERIC(6,2);
UPDATE materiales SET PorcentajeImpuesto = 2*clave/1000;
SELECT * FROM materiales

select SUM(Costo*(1+(PorcentajeImpuesto/100))*Cantidad) from materiales,entregan
where materiales.clave = entregan.clave

--Vistas
CREATE VIEW vistaEntregas AS
SELECT RFC,Cantidad, Fecha,Numero
FROM [Entregan]
WHERE [Numero] Between 5000 and 5010 AND RFC IN ( SELECT [RFC]
FROM [Proveedores]
WHERE RazonSocial LIKE 'La%' and [Entregan].[RFC] = [Proveedores].[RFC] )

SELECT * FROM vistaEntregas