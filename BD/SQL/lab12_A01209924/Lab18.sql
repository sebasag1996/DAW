--Consulta 1
Select SUM(Costo*(1+(PorcentajeImpuesto/100))*Cantidad) FROM materiales m, entregan e
where m.clave = e.clave AND e.fecha >= '01-JAN-1997' AND e.fecha < '31-DEC-1997'

--Consulta 2
Select RazonSocial, Count(Cantidad) as TotalCantidad, SUM(Costo*(1+(PorcentajeImpuesto/100))*Cantidad)
from Proveedores p, Materiales m, Entregan e
where p.RFC = e.RFC AND m.Clave = e.Clave
GROUP BY RazonSocial

--Consulta 3