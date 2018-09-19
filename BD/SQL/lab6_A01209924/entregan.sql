SET DATEFORMAT dmy

BULK INSERT a1209924.a1209924.[Entregan]
   FROM 'e:\wwwroot\a1209924\entregan.csv'
   WITH 
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '0x0a'
      )

SELECT * FROM Entregan