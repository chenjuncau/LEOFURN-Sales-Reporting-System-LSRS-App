SELECT t_small.year, Small, Medium, Large, Extra_Large
FROM
(SELECT date_part('year',(DateN)) AS year, SUM(sale) AS Small
FROM
(SELECT s.PID, s.DateN, CASE WHEN d.DateN IS NULL THEN
s.Quantity*p.RetailPrice ELSE s.Quantity*d.DiscountedPrice END AS sale
FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells) s
JOIN
(SELECT StoreNumber, CityName from Store) st
ON
s.StoreNumber= st.StoreNumber
JOIN
(SELECT CityName, population from Updates
WHERE population < 3700000) c
ON
st.CityName =c.CityName
JOIN
(SELECT PID, RetailPrice from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT PID, DateN, DiscountedPrice from Discounted) d
ON
s.PID =d.PID and s.DateN =d.DateN) t_1
GROUP BY date_part('year',(DateN))
ORDER BY date_part('year',(DateN))) t_small
JOIN
(SELECT date_part('year',(DateN)) AS year, SUM(sale) AS Medium
FROM
(SELECT s.PID, s.DateN, CASE WHEN d.DateN IS NULL THEN
s.Quantity*p.RetailPrice ELSE s.Quantity*d.DiscountedPrice END AS sale
FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells) s
JOIN
(SELECT StoreNumber, CityName from Store) st
ON
s.StoreNumber= st.StoreNumber
JOIN
(SELECT CityName, population from Updates
WHERE population >= 3700000 AND population <6700000) c
ON
st.CityName =c.CityName
JOIN
(SELECT PID, RetailPrice from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT PID, DateN, DiscountedPrice from Discounted) d
ON
s.PID =d.PID and s.DateN =d.DateN) t_1
GROUP BY date_part('year',(DateN))
ORDER BY date_part('year',(DateN))) t_medium
ON t_small.year=t_medium.year
JOIN
(SELECT date_part('year',(DateN)) AS year, SUM(sale) AS Large
FROM
(SELECT s.PID, s.DateN, CASE WHEN d.DateN IS NULL THEN
s.Quantity*p.RetailPrice ELSE s.Quantity*d.DiscountedPrice END AS sale
FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells) s
JOIN
(SELECT StoreNumber, CityName from Store) st
ON
s.StoreNumber= st.StoreNumber
JOIN
(SELECT CityName, population from Updates
WHERE population >= 6700000 AND population <9000000) c
ON
st.CityName =c.CityName
JOIN
(SELECT PID, RetailPrice from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT PID, DateN, DiscountedPrice from Discounted) d
ON
s.PID =d.PID and s.DateN =d.DateN) t_1
GROUP BY date_part('year',(DateN))
ORDER BY date_part('year',(DateN))) t_large
ON
t_small.year=t_large.year
JOIN
(SELECT date_part('year',(DateN)) AS year, SUM(sale) AS Extra_Large
FROM
(SELECT s.PID, s.DateN, CASE WHEN d.DateN IS NULL THEN
s.Quantity*p.RetailPrice ELSE s.Quantity*d.DiscountedPrice END AS sale
FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells) s
JOIN
(SELECT StoreNumber, CityName from Store) st
ON
s.StoreNumber= st.StoreNumber
JOIN
(SELECT CityName, population from Updates
WHERE population >= 9000000) c
ON
st.CityName =c.CityName
JOIN
(SELECT PID, RetailPrice from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT PID, DateN, DiscountedPrice from Discounted) d
ON
s.PID =d.PID and s.DateN =d.DateN) t_1
GROUP BY date_part('year',(DateN))
ORDER BY date_part('year',(DateN))) t_ex_large
ON
t_small.year=t_ex_large.year;
