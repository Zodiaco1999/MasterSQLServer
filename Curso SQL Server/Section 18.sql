--Creacion del indice full text para el campo LongDescription configurando el idioma español
CREATE FULLTEXT INDEX ON product_texts (LongDescription LANGUAGE 3082) -- 3082 es español
KEY INDEX [PK__product___AB2B33D3890A1016]
ON FullTextSeacrh_Products
WITH STOPLIST = SYSTEM;

--Path del archivo de Thesaurus (sinonimos)
SELECT * FROM sys.master_files WHERE database_id = 1

--Cargar el archivo thesaurus para el lenguaje español
EXEC sys.sp_fulltext_load_thesaurus_file 3082

--Adicionar la stop list a la tabla
ALTER FULLTEXT INDEX ON dbo.product_texts SET STOPLIST MyCompleteStopList;

--Registro que contengan la plabra que inicie con tecno
SELECT * FROM product_texts pt WHERE CONTAINS(pt.LongDescription, '"tecno*"')              

--Registro que no contengan la plabra que inicie con tecno
SELECT * FROM product_texts pt WHERE NOT CONTAINS(pt.LongDescription, '"tecno*"')

--Registro que no contengan la plabra iphone o tecnología
SELECT * FROM product_texts pt WHERE CONTAINS(pt.LongDescription, 'iphone OR tecnología')

--Registro que no contengan la plabra iphone y tecnología
SELECT * FROM product_texts pt WHERE CONTAINS(pt.LongDescription, 'iphone AND tecnología')

--Registro que no contengan la plabra iphone y no tecnología
SELECT * FROM product_texts pt WHERE CONTAINS(pt.LongDescription, 'iphone AND NOT tecnología')

--Registros que tienen la palabra tecnología y excepcional con maximo 5 palabras en medio y que respete el orden
SELECT * FROM product_texts pt WHERE CONTAINS(pt.LongDescription, 'NEAR((tecnología, excepcional), 5, TRUE)')

--Registros con la palabra avanzados en las diferentes las formas gramaticales (avanzar, avanzado, avanzando)
SELECT ProductID, LongDescription FROM product_texts
WHERE CONTAINS(LongDescription, 'FORMSOF(INFLECTIONAL, "avanzados")');

--Registros con los sinominos de la palabra consola previamente configurados en el archivo tsesn.xml
SELECT ProductID, LongDescription FROM product_texts
WHERE CONTAINS(LongDescription, 'FORMSOF(THESAURUS, "consola")');

--Registro de los datos asiciados a avanzados en todas sus conjugaciones
SELECT * FROM sys.dm_fts_parser('FORMSOF(INFLECTIONAL, "avanzados")', 3082, NULL, 0)

--Registros con los sinominos o conjugaciones de las palabras Playstation o explorar
SELECT ProductID, LongDescription FROM product_texts
WHERE FREETEXT(LongDescription, 'Playstation explorar');

 
