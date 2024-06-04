SELECT p.CategoryName AS Category, st.Restaurant AS STORE_TYPE,
SUM(s.Quantity) AS QUANTITY_SOLD
FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells) s
JOIN
(SELECT StoreNumber, CASE WHEN Restaurant = 'true' THEN 'Non-restaurant' ELSE
'Restaurant' END AS Restaurant FROM Store) st
ON
s.StoreNumber =st.StoreNumber
JOIN
(SELECT PID, CategoryName from Belongs) p
ON
s.PID =p.PID
GROUP BY p.CategoryName, st.Restaurant
ORDER BY p.CategoryName, st.Restaurant;