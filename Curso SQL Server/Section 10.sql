--Remplaza una parte de una cadena de texto por otra
SELECT STUFF('Hello World', 7, 5, 'SQL Server')

SELECT NEWID() AS UniqueIdentifierr

--Suma los valores de un grupo
SELECT CHECKSUM_AGG(BINARY_CHECKSUM(*)) FROM Marketplace.dbo.Products

--Concatena una cadena con un separador
SELECT CONCAT_WS('-', '2024', '11', '06');

SELECT SYSDATETIMEOFFSET() AS FechaHoraConZonaHoraria

SELECT SYSUTCDATETIME() AS FechaHoraUTC

SELECT HASHBYTES('SHA2_512', 'HELLO WORLD') AS HashValue

--Devuelve un numero de una cantidad de bytes encriptado
SELECT CRYPT_GEN_RANDOM(2) AS RandomNumber

SELECT SESSION_USER AS CurrentOwner, SYSTEM_USER AS CurrentServerUser

--Retorna propiedades del servidor
SELECT SERVERPROPERTY('ProductVersion'), SERVERPROPERTY('Edition')

--Separa los registros por grupos dando un parametro de separacion
SELECT NTILE(4) OVER (ORDER BY Price DESC) as Quarttile, ProductName, Price FROM Products

SELECT FORMATMESSAGE('Hola, %s. Hoy es %s.', 'Mundo', 'Lunes') as mensaje

--Obtiene el ultimo dia del mes, params: (date, diasParaSumarORestar)
SELECT EOMONTH(GETDATE(), 1)

SELECT value FROM string_split('1,2,3', ',')

SELECT REPLICATE('*', 80)