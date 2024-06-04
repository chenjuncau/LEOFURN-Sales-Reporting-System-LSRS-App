SELECT * 
FROM crosstab($$ SELECT date_part('month', DateN) AS themonth , TimeLimit, SUM(sale) AS total_sale
FROM
(SELECT s.PID AS PID, s.DateN, st.TimeLimit as Timelimit, CASE WHEN d.DateN IS NULL THEN
s.Quantity*p.RetailPrice ELSE s.Quantity*d.DiscountedPrice END AS sale
FROM
(SELECT PID, StoreNumber, DateN, Quantity FROM Sells
WHERE DateN >(date '2012-07-01' - interval '12 MONTH')) s
JOIN
(SELECT StoreNumber, (CASE WHEN TimeLimit is NULL THEN 0 ELSE
TimeLimit END) AS TimeLimit FROM Childcare) st
ON
s.StoreNumber =st.StoreNumber
JOIN
(SELECT PID, RetailPrice from Product) p
ON
s.PID =p.PID
LEFT JOIN
(SELECT PID, DateN, DiscountedPrice from Discounted) d
ON
s.PID =d.PID and s.DateN =d.DateN) t1
GROUP BY date_part('month', DateN), TimeLimit
ORDER BY date_part('month', DateN), TimeLimit
$$)  AS final_result(themonth float, "NO CHILDCARE" float,"30" float,"45" float,"60" float);




-- -- ')  AS final_result(Month TEXT, 30 NUMERIC,45 NUMERIC,60 NUMERIC,'NO CHILDCARE' NUMERIC);


-- -- (SELECT StoreNumber, (CASE WHEN TimeLimit is NULL THEN 'NO_CHILDCARE' ELSE

-- CREATE EXTENSION tablefunc;

-- -- SELECT PID, StoreNumber, DateN, Quantity FROM Sells order by DateN DESC limit 200


-- -- SELECT PID, StoreNumber, DateN, Quantity FROM Sells
-- -- WHERE DateN >(date '2012-07-01' - interval '12 MONTH')

-- SELECT * 
-- FROM crosstab($$ SELECT PID, StoreNumber, Quantity FROM Sells $$)


-- SELECT date_part('month', DateN) AS month , TimeLimit, SUM(sale) AS total_sale
-- FROM
-- (SELECT s.PID AS PID, s.DateN, st.TimeLimit as Timelimit, CASE WHEN d.DateN IS NULL THEN
-- s.Quantity*p.RetailPrice ELSE s.Quantity*d.DiscountedPrice END AS sale
-- FROM
-- (SELECT PID, StoreNumber, DateN, Quantity FROM Sells
-- WHERE DateN >(date '2012-07-01' - interval '12 MONTH')) s
-- JOIN
-- (SELECT StoreNumber, (CASE WHEN TimeLimit is NULL THEN 0 ELSE
-- TimeLimit END) AS TimeLimit FROM Childcare) st
-- ON
-- s.StoreNumber =st.StoreNumber
-- JOIN
-- (SELECT PID, RetailPrice from Product) p
-- ON
-- s.PID =p.PID
-- LEFT JOIN
-- (SELECT PID, DateN, DiscountedPrice from Discounted) d
-- ON
-- s.PID =d.PID and s.DateN =d.DateN) t1
-- GROUP BY date_part('month', DateN), TimeLimit
-- ORDER BY date_part('month', DateN), TimeLimit


