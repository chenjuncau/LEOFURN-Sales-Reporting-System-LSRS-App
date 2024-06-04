SELECT (SELECT CAST(COUNT(StoreNumber) AS INT) FROM Store) AS The_Count_of_Store,
(SELECT CAST(COUNT(StoreNumber) AS INT) FROM Store WHERE Restaurant = 'true' or Snackbar = 'true') AS The_Count_of_Store_offer_food,
(SELECT CAST(COUNT(StoreNumber) AS INT) AS Count_of_Stores3 FROM Childcare WHERE TimeLimit IS NOT NULL) AS The_Count_of_Store_with_childcare,
(SELECT CAST(COUNT(PID) AS INT) FROM Product) AS The_Count_of_Products,
(SELECT CAST(COUNT(DISTINCT(CampaignName)) AS INT) FROM Campaign) AS The_Count_of_Campaign;

