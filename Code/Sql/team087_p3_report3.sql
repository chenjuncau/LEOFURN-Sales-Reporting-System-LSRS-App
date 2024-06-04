SELECT
Store.StoreNumber,
Store.StreetAddress,
City.CityName,
date_part('year', Sells.DateN) AS SoldYear,
CAST(SUM(
-- IF(Sells.DateN = Discounted.DateN AND
-- Sells.PID = Discounted.PID,Discounted.DiscountedPrice, Product.RetailPrice)
 (CASE
  WHEN Sells.DateN = Discounted.DateN AND
Sells.PID = Discounted.PID THEN Discounted.DiscountedPrice
  ELSE Product.RetailPrice
 END)
* Sells.quantity) AS NUMERIC(18, 2)) AS Revenue		
FROM
Sells
LEFT OUTER JOIN
Discounted
ON
Sells.DateN = Discounted.DateN AND
Sells.PID = Discounted.PID,
Product,
Store,
City
WHERE City.StateName = <state>
AND Store.StateName = <state>
AND Store.CityName = City.CityName
AND Sells.StoreNumber = Store.StoreNumber
AND Sells.PID = Product.PID
GROUP BY
Store.StoreNumber,
Store.StreetAddress,
City.CityName,
date_part('year', Sells.DateN)
ORDER BY SoldYear, Revenue DESC;
