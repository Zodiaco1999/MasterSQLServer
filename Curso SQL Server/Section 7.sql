--WHIT TIES
--De la mano de orderby by esta instruccion incluye los elementos con el mismo valor
SELECT TOP 4 WITH TIES * FROM Products ORDER BY STock DESC

--PIVOT
SELECT ProductId, ProductName, [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], 
       [2024-06], [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
FROM (
SELECT 
  p.ProductName, 
  p.ProductId,
  CONVERT (NVARCHAR(7), s.SaleDate, 120) as SalesMonth,
  sd.Quantity
  FROM SaleDetails sd
  JOIN Sales s ON s.SaleID = sd.SaleID
  JOIN Products p ON p.ProductID = sd.ProductID
) as SourceTable
  PIVOT
(SUM(Quantity) for SalesMonth in
([2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
 [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12])) as PivotTable

 --UNPIVOT
SELECT ProductId, ProductName, SalesMonth, Quantity
FROM (
  SELECT ProductId, ProductName, [2024-01], [2024-02], [2024-03], [2024-04], [2024-05], 
         [2024-06], [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12]
  FROM (
    SELECT 
      p.ProductName, 
      p.ProductId,
      CONVERT (NVARCHAR(7), s.SaleDate, 120) as SalesMonth,
      sd.Quantity
      FROM SaleDetails sd
      JOIN Sales s ON s.SaleID = sd.SaleID
      JOIN Products p ON p.ProductID = sd.ProductID
) as SourceTable PIVOT
(SUM(Quantity) for SalesMonth in
([2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
 [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12])) as PivotTable
  ) as Pivote UNPIVOT(
  Quantity for SalesMonth in
([2024-01], [2024-02], [2024-03], [2024-04], [2024-05], [2024-06], 
 [2024-07], [2024-08], [2024-09], [2024-10], [2024-11], [2024-12])) as UnpivotTable
