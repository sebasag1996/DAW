BULK INSERT a1209924.a1209924.[Proyectos]
   FROM 'e:\wwwroot\a1209924\proyectos.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

SELECT * FROM Proyectos