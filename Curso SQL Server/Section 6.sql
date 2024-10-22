-- INSERT SELECT
insert into Prices
    select SaleID, Total from Sales

--UPDATE INNER JOIN
update Products set Stock = 0
    from Products p
	join Sellers s on p.SellerID = s.SellerID
	where s.SellerName = 'Future Electronics 10'

--DELETE INNER JOIN 
delete p
from Products p
	join Sellers s on p.SellerID = s.SellerID
	where s.SellerName = 'Future Electronics 10'

--SELECT INTO
--Crea una nueva tabla a partir de una o mas tablas existentes 
--SalesProducts: nombre de la nueva tabla
select p.*, s.ProductID as ProductIDInSale, s.Price as PriceSale, s.Quantity 
into SalesProducts 
from Products p join SaleDetails s on p.ProductID = s.ProductID

--SUBCONSULTAS
--Clientes cuyas compras totales sean mayor ha 10000
select c.CustomerID, c.FirstName, c.LastName, c.Email From Customers c
where c.CustomerID in (
    select s.CustomerID 
    from Sales s
    group by s.CustomerID
    having sum(s.Total) > 10000)

--Provedores de los cuales no se ha vendido ningun producto
select s.SellerName, s.Contact, s.Email 
from Sellers s join Products p on s.SellerID = p.SellerID
where p.ProductID not in (
    select distinct sd.ProductID
	from SaleDetails sd)

--CASE WHEN
SELECT
  s.SaleId,
  COUNT(ProductId) AS NumberOfProducts,
  Total,
  CASE
    WHEN Count(ProductId) > 3 THEN 'Venta Grande'
    WHEN Total > 5000 THEN 'Venta de Alto Valor' 
    ELSE 'Venta Estandar'
  END as SaleType
FROM Sales s
  JOIN SaleDetails sd ON s.SaleID = sd.SaleID 
  GROUP BY s.SaleId, Total

--UNION y UNION ALL
-- Se utiliza para unir los registros de 2 tablas similes
--UNION Elimina la redundancia
SELECT * FROM (
  SELECT * FROM Sales2024_08 
  UNION
  SELECT * FROM Sales2024_09
) as Meses08y09
WHERE Total > 1000