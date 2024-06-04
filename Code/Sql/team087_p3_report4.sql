-- 8. Report 4 Outdoor Furniture on GroundHog Day   
SELECT t1.Sales_Year AS SalesYear, t1.Total_Units_Sold as TotalUnitsSold,
t1.Units_Sold_Days AS AveSoldPerDay, 
case when t2.Total_Units_Sold is not null then t2.Total_Units_Sold else 0 end as SoldonGroundHogDay
FROM
(SELECT date_part('year', Sells.DateN) as Sales_Year, SUM(Sells.Quantity) as Total_Units_Sold,
(SUM(Sells.Quantity)/365) as Units_Sold_Days FROM Sells JOIN Belongs ON
Sells.PID = Belongs.PID WHERE Belongs.CategoryName = 'Outdoor Furniture'
GROUP BY date_part('year', Sells.DateN) ORDER BY date_part('year', Sells.DateN) ASC) t1
LEFT JOIN
(SELECT date_part('year', Sells.DateN) as Sales_Year ,SUM(Sells.Quantity) as Total_Units_Sold 
FROM Sells JOIN Belongs ON
Sells.PID = Belongs.PID WHERE Belongs.CategoryName = 'Outdoor Furniture'
AND date_part('month', Sells.DateN) = 2
AND date_part('day', Sells.DateN) = 2 GROUP BY date_part('year', Sells.DateN) ORDER BY
date_part('year', Sells.DateN) ASC) t2
ON t1.Sales_Year=t2.Sales_Year


-- SELECT t1.Sales_Year AS SalesYear, t1.Total_Units_Sold as TotalUnitsSold,
-- t1.Units_Sold_Days AS AveSoldPerDay, t2.Total_Units_Sold as SoldonGroundHogDay
-- FROM
-- (SELECT date_part('year', Sells.DateN) as Sales_Year, SUM(Sells.Quantity) as Total_Units_Sold,
-- (SUM(Sells.Quantity)/365) as Units_Sold_Days FROM Sells JOIN Belongs ON
-- Sells.PID = Belongs.PID WHERE Belongs.CategoryName = 'Outdoor Furniture'
-- GROUP BY date_part('year', Sells.DateN) ORDER BY date_part('year', Sells.DateN) ASC) t1
-- JOIN
-- (SELECT date_part('year', Sells.DateN) as Sales_Year ,SUM(Sells.Quantity) as Total_Units_Sold 
-- FROM Sells JOIN Belongs ON
-- Sells.PID = Belongs.PID WHERE Belongs.CategoryName = 'Outdoor Furniture'
-- AND date_part('month', Sells.DateN) = 2
-- AND date_part('day', Sells.DateN) = 2 GROUP BY date_part('year', Sells.DateN) ORDER BY
-- date_part('year', Sells.DateN) ASC) t2
-- ON t1.Sales_Year=t2.Sales_Year