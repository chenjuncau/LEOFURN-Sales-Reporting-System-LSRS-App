--change each file path to your own directory to load these files.

COPY city(CityName, StateName)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\city.tsv' DELIMITER E'\t' CSV HEADER;

COPY store(StoreNumber, PhoneNumber, StreetAddress, CityName, StateName,Restaurant,Snackbar)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\stores.tsv' DELIMITER E'\t' CSV HEADER;

COPY Childcare(StoreNumber, TimeLimit)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\Childcare.tsv' DELIMITER E'\t' CSV HEADER;

COPY Updates(CityName, StateName,Population)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\population.tsv' DELIMITER E'\t' CSV HEADER;

COPY Product(PID, ProductName,RetailPrice)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\products.tsv' DELIMITER E'\t' CSV HEADER;

COPY Category(CategoryName)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\categories.tsv' DELIMITER E'\t' CSV HEADER;

COPY Belongs(PID, CategoryName)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\productcategories.tsv' DELIMITER E'\t' CSV HEADER;

COPY Dates(DateN)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\date.tsv' DELIMITER E'\t' CSV HEADER;

COPY Discounted(PID, DateN,DiscountedPrice)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\discounts.tsv' DELIMITER E'\t' CSV HEADER;

COPY Holiday(DateN, HolidayName)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\holidays.tsv' DELIMITER E'\t' CSV HEADER;

COPY Campaign(CampaignName)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\campaigns.tsv' DELIMITER E'\t' CSV HEADER;

COPY Advertises(DateN, CampaignName)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\ad_campaigns.tsv' DELIMITER E'\t' CSV HEADER;

COPY Sells(PID,StoreNumber,DateN,Quantity)
FROM 'D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS\\Code\\Demo_Data\\sales.tsv' DELIMITER E'\t' CSV HEADER;


