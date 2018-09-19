BULK INSERT a1209924.a1209924.[Proveedores]
   FROM 'e:\wwwroot\a1209924\proveedores.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

SELECT * FROM Proveedores