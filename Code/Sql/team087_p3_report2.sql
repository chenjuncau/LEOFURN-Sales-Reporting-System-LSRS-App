-- 6. Report 2 Actual vs Predicted Revenue Report
SELECT * FROM
(
SELECT
Product_ID,
Product_Name,
Retail_Price,
SUM(Total_Quantity) AS Total_Units_Sold,
SUM(Sale_Quantity) AS Total_Units_Sold_at_Discount,
SUM(Retail_Quantity) AS Total_Units_Sold_at_Retail,
SUM(Transaction_Amount) AS Actual_Revenue,
CAST(SUM(Predicted_Amount) AS NUMERIC(18, 2)) AS Predicted_Revenue,
CAST(SUM(Difference1) AS NUMERIC(18, 2)) AS DifferenceSum
FROM
(SELECT
S.PID AS Product_ID,
P.ProductName AS Product_Name,
P.RetailPrice AS Retail_Price,
-- IFNULL(G.DiscountedPrice, 0) AS Sale_Price,
C.CategoryName,
StoreNumber,
S.DateN,
SUM(
-- IF(ISNULL(G.DiscountedPrice), 0, Quantity)) 
 (CASE
  WHEN G.DiscountedPrice IS NULL THEN 0
  ELSE Quantity
 END))

AS Sale_Quantity,
SUM(
-- IF(ISNULL(G.DiscountedPrice), Quantity, 0))
 (CASE
  WHEN G.DiscountedPrice IS NULL THEN Quantity
  ELSE 0
 END))
 AS Retail_Quantity,
SUM(Quantity * 

-- IF(ISNULL(G.DiscountedPrice), P.RetailPrice,
-- G.DiscountedPrice)

 (CASE
  WHEN G.DiscountedPrice IS NULL THEN P.RetailPrice
  ELSE G.DiscountedPrice
 END))

AS Transaction_Amount,
SUM(
-- IF(ISNULL(G.DiscountedPrice), Quantity * P.RetailPrice, 0.75 *
-- Quantity *
-- P.RetailPrice))
 (CASE
  WHEN G.DiscountedPrice IS NULL THEN Quantity * P.RetailPrice
  ELSE 0.75 *
Quantity *
P.RetailPrice
 END))

 AS Predicted_Amount,
Quantity * 
-- IF(ISNULL(G.DiscountedPrice), P.RetailPrice,
-- G.DiscountedPrice) 
 (CASE
  WHEN G.DiscountedPrice IS NULL THEN P.RetailPrice
  ELSE G.DiscountedPrice
 END)
-
SUM(
-- IF(ISNULL(G.DiscountedPrice), Quantity * P.RetailPrice, 0.75 *
-- Quantity *
-- P.RetailPrice))
 (CASE
  WHEN G.DiscountedPrice IS NULL THEN Quantity * P.RetailPrice
  ELSE 0.75 *
Quantity *
P.RetailPrice
 END))
 AS Difference1,

SUM(Quantity) AS Total_Quantity
FROM Sells S
JOIN Belongs C
ON S.PID = C.PID AND C.CategoryName = 'Couches and Sofas'
JOIN Product P
ON S.PID = P.PID
LEFT OUTER JOIN Discounted G
ON S.PID = G.PID AND S.DateN = G.DateN
GROUP BY S.PID, P.ProductName, P.RetailPrice, DiscountedPrice,
C.CategoryName,
StoreNumber, S.DateN
) AS InnerSelect
GROUP BY Product_ID, Product_Name, Retail_Price ) as MMM
-- HAVING innerselect.Difference1 > 5000 OR innerselect.Difference1 < -5000
WHERE ABS(MMM.DifferenceSum) > 5000.0
ORDER BY MMM.DifferenceSum DESC;