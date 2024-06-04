-- 5. Report 1 Category Report
SELECT
Belongs.CategoryName as categoryName,
COUNT(Belongs.PID) as totalProducts,
MIN(Product.RetailPrice) as minRetailPrice,
AVG(Product.RetailPrice) as avgRetailPrice,
MAX(Product.RetailPrice) as maxRetailPrice
FROM Belongs
LEFT JOIN Product on Product.PID = Belongs.PID
GROUP BY CategoryName
ORDER BY CategoryName ASC;

