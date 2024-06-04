# Project Phase 3 : Team087

This is LEOFURN Sales Reporting System (LSRS) App.
- Using PostgreSQL database. 
- Using R shiny for interface. 

# Folder Structure 
- LSRSApp.R:  This is main code for running the shiny app.
- Code\Demo_data:  all the demo data.
- Code\Html:  html file for interface.
- Code\Schemas:  Create the table and load the demo data.
- Code\Sql: all the report and statistic sql code.
- Demo.mp4:  This is demo video how to run the program.
- TeamInfo.txt: Team087 member information.
	
# Software Prerequisites
- Install the latest version of PostgreSQL & pgAdmin 4.
- Install the latest version of R and R studio. 

# Software Installation
- R Installation Instructions:<br/>
    - Go to https://cran.rstudio.com/bin/windows/base/ to download.
    - Click "Download R for Windows" and save the executable file somewhere on your computer.
    - Once the installer downloads, Right-click on it and select “Run as administrator”      
    Run the .exe file and follow the installation instructions.  
    - Now that R is installed, you need to download and install RStudio. 
- RStudio Installation Instructions:
    - Go to https://www.rstudio.com/products/rstudio/download/ to download.
    - Click on "Download RStudio Desktop."
    - Choose on the version recommended for your system, or the latest Windows version, and save the executable file.  
    - Run the .exe file and follow the installation instructions. 
- PostgreSQL & pgAdmin 4 Installation Instructions:
    - Download PostgreSQL from this link: https://www.enterprisedb.com/downloads/postgres-postgresql-downloads.
    - Click on the executable file to run the installer.
    - Create a password to access the database while installing. password 1234 in the code. 
    - Install pgadmin4 during installation.

# LEOFURN Sales Reporting System (LSRS) App
- Clone our entire app repository to your computer from github. 

- Open pgAdmin do the following: 
    - Go to the Code\Schemas folder
    - Create the tables schemas in team087_p3_schema.sql
    - Copy the tsv files in the Demo_Data folder to PostgreSQL using the code in team087_p3_LoadData.sql

- Test the Shiny App: 
    - Go to Phase 3 main folder and open LSRSApp.R
    - Set the working directory to the main folder. You can do this by going to session>set working directory> choose a directory or edit this code in the r file, setwd("D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS"). To verify your directory type getwd() in the console below. 
    - Installation of required packages has been automated. If the packages does not automatically install, please install it mannualy. 
    - Click on Run App. (You can run the app in R or open in your local browser) 


	
