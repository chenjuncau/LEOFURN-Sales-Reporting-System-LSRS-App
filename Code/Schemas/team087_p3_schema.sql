-- create database
-- CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS gatechUser@localhost IDENTIFIED BY 'gatech123';

DROP DATABASE IF EXISTS `cs6400_sp21_team087`; 
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS cs6400_sp21_team087
    DEFAULT CHARACTER SET utf8mb4 
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE cs6400_sp21_team087;

GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO 'gatechUser'@'localhost';
GRANT ALL PRIVILEGES ON `gatechuser`.* TO 'gatechUser'@'localhost';
GRANT ALL PRIVILEGES ON `cs6400_sp21_team087`.* TO 'gatechUser'@'localhost';
FLUSH PRIVILEGES;

-- database name: cs6400_sp21_team087
DROP TABLE IF EXISTS City CASCADE;
DROP TABLE IF EXISTS Store CASCADE;
DROP TABLE IF EXISTS Childcare CASCADE;
DROP TABLE IF EXISTS Updates CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Category CASCADE;
DROP TABLE IF EXISTS Belongs CASCADE;
DROP TABLE IF EXISTS Dates CASCADE;
DROP TABLE IF EXISTS Discounted CASCADE;
DROP TABLE IF EXISTS Holiday CASCADE;
DROP TABLE IF EXISTS Campaign CASCADE;
DROP TABLE IF EXISTS Advertises CASCADE;
DROP TABLE IF EXISTS Sells CASCADE;

-- Tables 
CREATE TABLE City (
CityName varchar(50) NOT NULL,
StateName varchar(50) NOT NULL,
PRIMARY KEY (CityName, StateName)
);


CREATE TABLE Store (
StoreNumber integer NOT NULL,
PhoneNumber varchar(50) DEFAULT NULL,
StreetAddress varchar(100) NOT NULL,
CityName varchar(50) NOT NULL,
StateName varchar(50) NOT NULL,
Restaurant boolean NOT NULL,
Snackbar boolean NOT NULL,
PRIMARY KEY (StoreNumber)
);

CREATE TABLE Childcare (
StoreNumber integer NOT NULL,
TimeLimit integer DEFAULT NULL,
PRIMARY KEY (StoreNumber)
);


CREATE TABLE Updates (
CityName varchar(50) NOT NULL,
StateName varchar(50) NOT NULL,
Population integer NOT NULL,
PRIMARY KEY (CityName, StateName)
);


CREATE TABLE Product (
PID integer NOT NULL,
ProductName varchar(50) NOT NULL,
RetailPrice float NOT NULL,
PRIMARY KEY (PID)
);

CREATE TABLE Category (
CategoryName varchar(50) NOT NULL,
PRIMARY KEY (CategoryName)
);

CREATE TABLE Belongs (
PID integer NOT NULL,
CategoryName varchar(50) NOT NULL,
PRIMARY KEY (PID, CategoryName)
);

CREATE TABLE Dates (
DateN date NOT NULL,
PRIMARY KEY (DateN));


CREATE TABLE Discounted (
PID integer NOT NULL,
DateN date NOT NULL,
DiscountedPrice float NOT NULL,
PRIMARY KEY (PID, DateN)
);


CREATE TABLE Holiday (
DateN date NOT NULL,
HolidayName varchar(200) NOT NULL,
PRIMARY KEY (DateN)
);

CREATE TABLE Campaign(
CampaignName varchar(80) NOT NULL,
PRIMARY KEY (CampaignName)
);

CREATE TABLE Advertises (
DateN date NOT NULL,
CampaignName varchar(80) NOT NULL,
PRIMARY KEY (DateN,CampaignName)
);

CREATE TABLE Sells (
PID integer NOT NULL,
StoreNumber integer NOT NULL,
DateN date NOT NULL,
Quantity integer NOT NULL,
PRIMARY KEY (PID, StoreNumber, DateN)
);

-- Constraints   Foreign Keys: FK_ChildTable_childColumn_ParentTable_parentColumn

ALTER TABLE Store
  ADD CONSTRAINT fk_Store_CityName_StateName_City_CityName_StateName FOREIGN KEY (CityName, StateName) REFERENCES City (CityName, StateName);
  
ALTER TABLE Childcare
  ADD CONSTRAINT fk_Childcare_StoreNumber_Store_StoreNumber FOREIGN KEY (StoreNumber) REFERENCES Store (StoreNumber) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Updates 
  ADD CONSTRAINT fk_Updates_CityName_StateName_City_CityName_StateName FOREIGN KEY (CityName, StateName) REFERENCES City (CityName, StateName) ON DELETE CASCADE ON UPDATE CASCADE;
  -- ADD CONSTRAINT fk_Updates_DateN_Dates_DateN FOREIGN KEY (DateN) REFERENCES Dates (DateN);

ALTER TABLE Belongs
  ADD CONSTRAINT fk_Belongs_PID_Product_PID FOREIGN KEY (PID) REFERENCES Product (PID),
  ADD CONSTRAINT fk_Belongs_CategoryName_Category_CategoryNam FOREIGN KEY (CategoryName) REFERENCES Category (CategoryName);  
  
ALTER TABLE Discounted
  ADD CONSTRAINT fk_Discounted_PID_Product_PID FOREIGN KEY (PID) REFERENCES Product (PID),
  ADD CONSTRAINT fk_Discounted_DateN_Dates_DateN FOREIGN KEY (DateN) REFERENCES Dates (DateN);

ALTER TABLE Holiday
  ADD CONSTRAINT fk_Holiday_DateN_Dates_DateN FOREIGN KEY (DateN) REFERENCES Dates (DateN);

ALTER TABLE Advertises
  ADD CONSTRAINT fk_Advertises_CampaignName_Campaign_CampaignName FOREIGN KEY (CampaignName) REFERENCES Campaign (CampaignName),
  ADD CONSTRAINT fk_Advertises_DateN_Dates_DateN FOREIGN KEY (DateN) REFERENCES Dates (DateN);

ALTER TABLE Sells
  ADD CONSTRAINT fk_Sells_PID_Product_PID FOREIGN KEY (PID) REFERENCES Product (PID),
  ADD CONSTRAINT fk_Sells_StoreNumber_Store_StoreNumber FOREIGN KEY (StoreNumber) REFERENCES Store (StoreNumber),
  ADD CONSTRAINT fk_Sells_DateN_Dates_DateN FOREIGN KEY (DateN) REFERENCES Dates (DateN);

