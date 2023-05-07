## Date created
3rd May 2023

## Project Title
Building an Azure Data Warehouse for Bike Share Data Analytics

## Description
This project demonstrate my knowledge on building data warehouse solution using Azure by building star schema OLAP from OLTP data.

## Files used
* 00_raw_ProjectDataToPostgres.py
* raw csv files (https://drive.google.com/drive/folders/1sFpJ2lFZu45PuwirY_8_sQZ04oGoPIbl?usp=share_link)
* 03_cetas_dates.sql
* 03_cetas_payment.sql
* 03_cetas_rider.sql
* 03_cetas_station.sql
* 03_cetas_trip.sql
* 04_star_schema_tbl_script.sql
* date dimension table (https://community.sisense.com/t5/knowledge/date-dimension-file/ta-p/9562)

## Dataset
The raw dataset consists of trip, rider, payment and station data in separate csv files. These are the transactional data of a bike sharing platform which needs to be transformed into a database for analytical purposes.

## Data Transformation
1) Use 00_raw_ProjectDataToPostgres.py to create raw transactional data into Azure PostgreSQL database. This will simulate the production environment where the data is being used in the OLTP system. 
2) Extract the data from Azure PostgreSQL by using a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse.
3) Create external tables in Azure Synapse workspace to read the tables in Blob storage.
4) Transform the tables into fact and dimension tables.

## List of Resources
- udacity.com
- community.sisense.com

## Credits
* [Udacity](udacity.com)
* [community.sisense.com](https://community.sisense.com/t5/knowledge/date-dimension-file/ta-p/9562)
