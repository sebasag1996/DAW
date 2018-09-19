BULK INSERT a1209924.a1209924.[Materiales]
   FROM 'e:\wwwroot\a1209924\materiales.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

SELECT * FROM Materiales