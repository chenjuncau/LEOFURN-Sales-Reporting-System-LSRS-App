-- Report 9 Advertising Campaign Analysis
SELECT PID AS ProductID, ProductName, Sold_During_Campaign, Sold_Outside_Campaign,
Difference
FROM
(SELECT PID, ProductName, Sold_During_Campaign, Sold_Outside_Campaign,
Difference,
RANK() OVER (PARTITION BY productName ORDER BY Difference DESC) AS
sale_rank
FROM
(SELECT PID, ProductName, SUM(Sold_During_Campaign) AS Sold_During_Campaign,
SUM(Sold_Outside_Campaign) AS Sold_Outside_Campaign,
SUM(Sold_During_Campaign)-SUM(Sold_Outside_Campaign) AS Difference
FROM
(SELECT p.PID AS PID, ProductName, s.DateN, CASE WHEN ac.DateN IS NOT NULL THEN
Quantity ELSE 0 END AS Sold_During_Campaign,
CASE WHEN ac.DateN IS NULL THEN Quantity ELSE 0 END AS
Sold_Outside_Campaign
FROM
(SELECT PID, DateN, Quantity FROM Sells) s
JOIN
(SELECT PID, ProductName from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT DateN, CampaignName from Advertises) ac
ON
s.DateN =ac.DateN) t
GROUP BY PID, ProductName) X) tt
WHERE tt.sale_rank<=10
UNION
SELECT PID, ProductName, Sold_During_Campaign, Sold_Outside_Campaign,
Difference
FROM
(SELECT PID, ProductName, Sold_During_Campaign, Sold_Outside_Campaign,
Difference,
RANK() OVER (PARTITION BY productName ORDER BY Difference) AS sale_rank
FROM
(SELECT PID, ProductName, SUM(Sold_During_Campaign) AS Sold_During_Campaign,
SUM(Sold_Outside_Campaign) AS Sold_Outside_Campaign,
SUM(Sold_During_Campaign)-SUM(Sold_Outside_Campaign) AS Difference
FROM
(SELECT p.PID AS PID, ProductName, s.DateN, CASE WHEN ac.DateN IS NOT NULL THEN
Quantity ELSE 0 END AS Sold_During_Campaign,
CASE WHEN ac.DateN IS NULL THEN Quantity ELSE 0 END AS
Sold_Outside_Campaign
FROM
(SELECT PID, DateN, Quantity FROM Sells) s
JOIN
(SELECT PID, ProductName from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT DateN, CampaignName from Advertises) ac
ON
s.DateN =ac.DateN) t
GROUP BY PID, ProductName) X) tt
WHERE tt.sale_rank<=10;






