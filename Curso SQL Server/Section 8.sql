UPDATE Products SET Price = 150.50 Where ProductID = 2

UPDATE Products SET Stock += 20 Where SellerID = 35

--Actualizar Las ventas con un join para obtener el total en salesDetails por Saleid Sumando Precio * Cantidad 
UPDATE [dbo].[Sales] Set Total = TotalSuma
FROM [dbo].[Sales] s
INNER JOIN 
(
   SELECT SaleID, Sum(Price * Quantity) AS TotalSuma
   FROM [dbo].[SaleDetails] 
   GROUP BY SaleID
) ds ON s.SaleID = ds.SaleID

DELETE FROM [dbo].[Products] WHERE SellerID = 2

DELETE FROM [dbo].[SaleDetails] 
WHERE SaleID IN (
  SELECT SaleID 
  FROM Sales
  WHERE CustomerID = 4
);

SELECT
  SaleDate,
  COUNT(*) as NumerodeCompras
FROM Sales
GROUP BY SaleDate
HAVING COUNT(*) > 1
ORDER BY SaleDate DESC

SELECT 
  YEAR(SaleDate) Año,
  MONTH(SaleDate) Mes, 
  COUNT(*) CantidadVentas,
  SUM(Total) IngresosTotales
FROM SALES
WHERE YEAR(SaleDate) = 2024
GROUP BY YEAR(SaleDate), MONTH(SaleDate)
ORDER BY Año, Mes

SELECT
  p.ProductName, s.SellerName
FROM Products p
JOIN Sellers s ON p.SellerID = s.SellerID

SELECT
  p.ProductName, c.FirstName + ' ' + c.LastName  as CustomerName, s.Total
FROM Products p
JOIN SaleDetails sd ON p.ProductID = sd.ProductID
JOIN Sales s ON s.SaleID = sd.SaleID
JOIN Customers c ON c.CustomerID = s.CustomerID
WHERE YEAR(s.SaleDate) = 2024


SELECT
 s.sellerName, COUNT (DISTINCT sd.ProductID) as ProductosVendidos,
 SUM(sd.Quantity) as Unidadesvendidas, SUM(sd.Quantity * sd.Price) as IngresosTotales 
FROM Sellers s
JOIN Products p ON s.SellerID = p.sellerID
JOIN SaleDetails sd ON p.ProductID = sd.ProductID
JOIN Sales sa ON sd.SaleID = sa.SaleID
WHERE YEAR(sa.SaleDate) = 2024
GROUP BY s.SellerName
HAVING SUM(sd.Quantity * sd.Price) > 0
ORDER BY IngresosTotales DESC


SELECT * FROM Products WHERE ProductName like '%iphone%'

SELECT * FROM Products WHERE ProductName like 'd%' and Description like '%cleaner%'

SELECT * FROM Products WHERE CONCAT(ProductName, ' ', Description) not like '%iphone%'