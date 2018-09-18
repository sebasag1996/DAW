bulk insert rcortese.rcortese.[Materiales]
	from 'e:\wwwroot\rcortese\materiales.csv\
	WITH
	(
		codepage = 'acp',
		fieldterminator = ',',
		rowterminator = '\n'
	)