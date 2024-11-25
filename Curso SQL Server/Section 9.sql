--Copiar el esquema de la base de datos
--Crea un Db copia de solo lectura
DBCC CLONEDATABASE(Marketplace, Marketplace2)

--Copiar el esquema de la base de datos
DBCC CLONEDATABASE(Marketplace, Marketplace2)
ALTER DATABASE Marketplace2 SET READ_WRITE

--Chequea toda la db y muestra que inconsistencias tiene
DBCC CHECKDB ('Marketplace') 

DBCC CHECKDB ('Marketplace') WITH ALL_ERRORMSGS

DBCC CHECKDB ('Marketplace') WITH ESTIMATEONLY

DBCC CHECKDB ('Marketplace') WITH PHYSICAL_ONLY

--Chequea toda la db para la estrucutura de datos, consistencia de datos
DBCC CHECKALLOC ('Marketplace') 

--Compacta el espacio de la BD
DBCC SHRINKDATABASE ('Marketplace')

--Muestra el porcentaje de log de las DB
DBCC SQLPERF(LOGSPACE)

--Libera la cache de los planes de ejecucion del motor
--SELECT * FROM sys.dm_exec_cached_plans
DBCC FREEPROCCACHE