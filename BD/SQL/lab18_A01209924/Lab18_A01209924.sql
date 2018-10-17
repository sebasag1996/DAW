--La suma de las cantidades e importe total de todas las entregas realizadas durante el 97.
SELECT SUM(Costo*(1+(PorcentajeImpuesto/100))*Cantidad) AS 'Ventas 97' from materiales,entregan
where materiales.clave = entregan.clave AND fecha BETWEEN '01-JAN-1997' AND '31-DEC-1997'

--Para cada proveedor, obtener la razón social del proveedor, número de entregas e importe total
--de las entregas realizadas.
SELECT RazonSocial, COUNT(Cantidad) AS 'Cantidad de Entregas', SUM(Costo*(1+(PorcentajeImpuesto/100))*Cantidad) AS 'VentasDelProveedor'
FROM Proveedores P, Entregan E, Materiales M
WHERE M.clave = E.clave AND E.RFC = P.RFC
GROUP BY RazonSocial

--Por cada material obtener la clave y descripción del material, la cantidad total entregada,
--la mínima cantidad entregada, la máxima cantidad entregada, el importe total de las entregas
--de aquellos materiales en los que la cantidad promedio entregada sea mayor a 400.
SELECT M.Clave, Descripcion, CAST(SUM(Cantidad) AS INT) AS 'Vendidos',
	CAST(MIN(Cantidad) AS INT) AS 'Min entr',
	CAST(MAX(Cantidad) AS INT) AS 'Max entr',
	SUM(Costo*(1+(PorcentajeImpuesto/100))*Cantidad) AS 'Ventas Del Producto'
FROM Materiales M, Entregan E
WHERE M.clave = E.clave
GROUP BY M.Clave, M.Descripcion
HAVING AVG(Cantidad) > 400

--Para cada proveedor, indicar su razón social y mostrar la cantidad promedio de cada material
--entregado, detallando la clave y descripción del material, excluyendo aquellos proveedores
--para los que la cantidad promedio sea menor a 500
SELECT RazonSocial, AVG(Cantidad) AS 'Prom entr', M.Clave, Descripcion
FROM Proveedores P, Materiales M, Entregan E
WHERE M.clave = E.clave AND E.RFC = P.RFC
GROUP BY P.RazonSocial, M.Clave, M.Descripcion
HAVING AVG(Cantidad) < 500
ORDER BY RazonSocial ASC

--Mostrar en una solo consulta los mismos datos que en la consulta anterior pero para dos grupos
--de proveedores: aquellos para los que la cantidad promedio entregada es menor a 370 y
--aquellos para los que la cantidad promedio entregada sea mayor a 450.
(SELECT RazonSocial, AVG(Cantidad) AS 'Prom entr', M.Clave, Descripcion
FROM Proveedores P, Materiales M, Entregan E
WHERE M.clave = E.clave AND E.RFC = P.RFC
GROUP BY P.RazonSocial, M.Clave, M.Descripcion
HAVING AVG(Cantidad) < 370)
UNION
(SELECT RazonSocial, AVG(Cantidad) AS 'Prom entr', M.Clave, Descripcion
FROM Proveedores P, Materiales M, Entregan E
WHERE M.clave = E.clave AND E.RFC = P.RFC
GROUP BY P.RazonSocial, M.Clave, M.Descripcion
HAVING AVG(Cantidad) < 450)
ORDER BY RazonSocial ASC

--Considerando que los valores de tipos CHAR y VARCHAR deben ir encerrados entre apóstrofes,
--los valores numéricos se escriben directamente y los de fecha, como '1-JAN-00' para 1o.
--de enero del 2000, inserta cinco nuevos materiales.
SELECT * FROM Materiales
INSERT INTO Materiales VALUES(1440, 'Tornillo T10', 12.0, 0)
INSERT INTO Materiales VALUES(1450, 'Tornillo T12', 13.0, 0)
INSERT INTO Materiales VALUES(1460, 'Tornillo T16', 14.0, 0)
INSERT INTO Materiales VALUES(1470, 'Tornillo T20', 15.0, 0)
INSERT INTO Materiales VALUES(1480, 'Tornillo T22', 16.0, 0)

--Clave y descripción de los materiales que nunca han sido entregados.
SELECT Clave, Descripcion
FROM Materiales E
WHERE Clave NOT IN(
	SELECT Clave
	FROM Entregan
)

--Razón social de los proveedores que han realizado entregas tanto al proyecto 'Vamos México'
--como al proyecto 'Querétaro Limpio'.
SELECT RazonSocial, Denominacion
FROM Proveedores Pr, Entregan E, Proyectos P
WHERE Pr.RFC = E.RFC AND E.Numero = P.Numero
	AND (Denominacion = 'Vamos Mexico' OR Denominacion = 'Queretaro limpio')
GROUP BY RazonSocial, Denominacion

--Descripción de los materiales que nunca han sido entregados al proyecto 'CIT Yucatán'.
SELECT M.Clave
FROM Materiales M, Proveedores Pr, Entregan E, Proyectos P
WHERE M.Clave = E.Clave AND Pr.RFC = E.RFC AND E.Numero = P.Numero
	AND (Denominacion != 'CIT Yucatan')
GROUP BY M.Clave

--Razón social y promedio de cantidad entregada de los proveedores cuyo promedio de cantidad
--entregada es mayor al promedio de la cantidad entregada por el proveedor con el RFC 'VAGO780901'.	
SELECT RazonSocial, AVG(Cantidad) AS 'Prom entr'
FROM Proveedores Pr, Entregan E
WHERE Pr.RFC = E.RFC
GROUP BY RazonSocial
HAVING AVG(Cantidad) > (
	SELECT AVG(Cantidad)
	FROM Proveedores Pr, Entregan E
	WHERE Pr.RFC = 'CCCC800101' AND Pr.RFC = E.RFC)
	--'VAGO780901' no existe, se usó otra RFC para comprobar

--RFC, razón social de los proveedores que participaron en el proyecto 'Infonavit Durango' y
--cuyas cantidades totales entregadas en el 2000 fueron mayores a las cantidades totales entregadas
--en el 2001.
SELECT * FROM Materiales
SELECT * FROM Entregan
SELECT * FROM Proyectos
SELECT * FROM Proveedores

SELECT SUM(Cantidad)/COUNT(Cantidad)
FROM Proveedores Pr, Entregan E
WHERE Pr.RFC = 'CCCC800101' AND Pr.RFC = E.RFC

SELECT Pr.RFC, RazonSocial, Denominacion
FROM Proveedores Pr, Entregan E, Proyectos P
WHERE Pr.RFC = E.RFC AND E.Numero = P.Numero AND (Denominacion = 'Infonavit Durango')
	AND fecha BETWEEN '01-JAN-2000' AND '31-DEC-2000'
GROUP BY Pr.RFC, RazonSocial, Denominacion
HAVING COUNT(Cantidad) >(
	SELECT COUNT(Cantidad)
	FROM Proveedores Pr, Entregan E, Proyectos P
	WHERE Pr.RFC = E.RFC AND E.Numero = P.Numero AND (Denominacion = 'Infonavit Durango')
		AND fecha BETWEEN '01-JAN-2001' AND '31-DEC-2001'
)