-- Report 5 State with Highest Volume for each Category

SELECT CategoryName, StateName, count FROM
(SELECT CategoryName, StateName, count, RANK() OVER (PARTITION BY
CategoryName ORDER BY count DESC) AS count_rank
FROM
(SELECT t3.StateName, t4.CategoryName, count(*) as count FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells
WHERE date_part('year',DateN)= <sale_year> and date_part('month',DateN)= <sale_month> ) t1
JOIN
(SELECT StoreNumber, CityName from Store) t2
ON
t1.StoreNumber =t2.StoreNumber
JOIN
(SELECT CityName, StateName from City) t3
ON
t2.CityName =t3.CityName
JOIN
(SELECT PID, CategoryName FROM Belongs) t4
ON
t1.PID =t4.PID
GROUP BY t3.StateName, t4.CategoryName
ORDER BY t4.CategoryName, count(*) desc) x) m
WHERE m.count_rank=1;

