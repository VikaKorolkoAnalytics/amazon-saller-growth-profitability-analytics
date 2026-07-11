/* ====================
VALIDATION STAGE TABLES 
=====================*/

--Basic string validation of data
SELECT TOP 10 *
FROM dbo.stg_amazon_sales;

SELECT TOP 10 *
FROM dbo.stg_amazon_ads;

SELECT TOP 10 *
FROM dbo.stg_meta_ads;

--Checking the number of rows in a table 
SELECT COUNT (*) AS amazon_sales
FROM dbo.stg_amazon_sales;

SELECT COUNT (*) AS amazon_ads
FROM dbo.stg_amazon_ads;

SELECT COUNT (*) AS meta_ads
FROM dbo.stg_meta_ads;

--Checking the data type
SELECT COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'stg_amazon_sales';

SELECT COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'stg_amazon_ads';

SELECT COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'stg_meta_ads';

--Check for NULL values in key columns
SELECT * 
FROM dbo.stg_amazon_sales
WHERE order_date IS NULL 
OR order_id IS NULL 
OR sku IS NULL
OR quantity IS NULL;

SELECT * 
FROM dbo.stg_amazon_ads
WHERE report_date IS NULL 
OR campaign_id IS NULL 
OR impressions IS NULL
OR clicks IS NULL
OR spend IS NULL;

SELECT * 
FROM dbo.stg_meta_ads
WHERE report_date IS NULL 
OR campaign_id IS NULL 
OR impressions IS NULL
OR clicks IS NULL
OR spend IS NULL;

--Check for duplicates
SELECT
order_date,
order_id,
sku,
COUNT (*) AS cnt
FROM dbo.stg_amazon_sales
GROUP BY 
order_date,
order_id,
sku
HAVING COUNT (*) > 1;

SELECT
report_date,
campaign_id,
campaign_name,
COUNT (*) AS cnt
FROM dbo.stg_amazon_ads
GROUP BY 
report_date,
campaign_id,
campaign_name
HAVING COUNT (*) > 1;

SELECT
report_date,
campaign_id,
campaign_name,
COUNT (*) AS cnt
FROM dbo.stg_meta_ads
GROUP BY 
report_date,
campaign_id,
campaign_name
HAVING COUNT (*) > 1;