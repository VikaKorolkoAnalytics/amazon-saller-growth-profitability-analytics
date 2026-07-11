/* ======================================================
POST-LOAD VALIDATION: FACT, DIMENSION, AND MAPPING TABLES 
=======================================================*/


--DIM TABLES
SELECT 'dim_state' AS table_name;
SELECT TOP 10 * FROM dbo.dim_state;
SELECT COUNT (*) AS row_count FROM dbo.dim_state;

SELECT 'dim_location' AS table_name;
SELECT TOP 10 * FROM dbo.dim_location;
SELECT COUNT (*) AS row_count FROM dbo.dim_location;

SELECT 'dim_product' AS table_name;
SELECT TOP 10 * FROM dbo.dim_product;
SELECT COUNT (*) AS row_count FROM dbo.dim_product;

SELECT 'dim_campaign' AS table_name;
SELECT TOP 10 * FROM dbo.dim_campaign;
SELECT COUNT (*) AS row_count FROM dbo.dim_campaign;

SELECT 'dim_date' AS table_name;
SELECT TOP 10 * FROM dbo.dim_date;
SELECT COUNT (*) AS row_count FROM dbo.dim_date;



--MAPPING TABLE
SELECT 'product_mapping' AS table_name;
SELECT TOP 10 * FROM dbo.product_mapping;
SELECT COUNT (*) AS row_count FROM dbo.product_mapping;

-- Data quality: find SKUs in staging that are not mapped in product_mapping
SELECT DISTINCT stg.sku
FROM dbo.stg_amazon_sales stg
WHERE NOT EXISTS (
SELECT 1
FROM dbo.product_mapping pm
WHERE pm.sku = stg.sku
);


--FACT TABLES

--FACT_AMAZON_SALES
SELECT 'fact_amazon_sales' AS table_name;
SELECT TOP 10 * FROM dbo.fact_amazon_sales;
SELECT COUNT (*) AS row_count FROM dbo.fact_amazon_sales;

--Check duplicate order_id
SELECT order_id, 
product_key, 
COUNT (*) AS cnt
FROM dbo.fact_amazon_sales
GROUP BY order_id, product_key
HAVING COUNT (*) > 1;

--Checking totals between fact_amazon_sales and stg_amazon_sales
SELECT 
SUM (quantity) AS quantity,
SUM (line_revenue) AS line_revenue,
SUM (selling_fees) AS selling_fees,
SUM (fba_fees) AS fba_fees
FROM fact_amazon_sales;
--vs
SELECT 
SUM (quantity) AS quantity,
SUM (line_revenue) AS line_revenue,
SUM (selling_fees) AS selling_fees,
SUM (fba_fees) AS fba_fees
FROM dbo.stg_amazon_sales
WHERE transaction_type = 'Order';

--Checking NULL in key fields
SELECT *
 FROM dbo.fact_amazon_sales
 WHERE date_key IS NULL
 OR product_key IS NULL
 OR location_key IS NULL;


--FACT_AMAZON_RETURNS
SELECT 'fact_amazon_returns' AS table_name;
SELECT TOP 10 * FROM dbo.fact_amazon_returns;
SELECT COUNT (*) AS row_count FROM dbo.fact_amazon_returns;

--Check duplicate order_id
SELECT order_id, 
product_key, 
location_key,
date_key,
COUNT (*) AS cnt
FROM dbo.fact_amazon_returns
GROUP BY order_id, 
product_key,
location_key,
date_key
HAVING COUNT (*) > 1;

--Checking totals between fact_amazon_returns and stg_amazon_sales
SELECT 
SUM (returned_quantity) AS returned_quantity,
SUM (ABS (refund_amount)) AS refund_amount,
SUM (refund_fees) AS refund_fees
FROM fact_amazon_returns;
--vs
SELECT 
SUM (quantity) AS quantity,
SUM (ABS(line_revenue)) AS line_revenue,
SUM (selling_fees) AS selling_fees
FROM dbo.stg_amazon_sales
WHERE transaction_type = 'Refund';

--Checking NULL in key fields
SELECT *
 FROM dbo.fact_amazon_returns
 WHERE date_key IS NULL
 OR product_key IS NULL
 OR location_key IS NULL;


--FACT_AMAZON_ADS
SELECT 'fact_amazon_ads' AS table_name;
SELECT TOP 10 * FROM dbo.fact_amazon_ads;
SELECT COUNT (*) AS row_count FROM dbo.fact_amazon_ads;

--Check duplicate date_key, campaign_key
SELECT  date_key,
campaign_key,
COUNT (*) AS cnt
FROM dbo.fact_amazon_ads
GROUP BY 
date_key,
campaign_key
HAVING COUNT (*) > 1;

--Checking totals between fact_amazon_ads and stg_amazon_ads
SELECT 
SUM (impressions) AS impressions,
SUM (clicks) AS clicks,
SUM (spend) AS spend
FROM fact_amazon_ads;
--vs
SELECT 
SUM (impressions) AS impressions,
SUM (clicks) AS clicks,
SUM (spend) AS spend
FROM dbo.stg_amazon_ads;

--Checking NULL in key fields
SELECT *
 FROM dbo.fact_amazon_ads
 WHERE date_key IS NULL
 OR campaign_key IS NULL;


--FACT_META_ADS
SELECT 'fact_meta_ads' AS table_name;
SELECT TOP 10 * FROM dbo.fact_meta_ads;
SELECT COUNT (*) AS row_count FROM dbo.fact_meta_ads;

--Check duplicate date_key, campaign_key
SELECT  date_key,
campaign_key,
COUNT (*) AS cnt
FROM dbo.fact_meta_ads
GROUP BY 
date_key,
campaign_key
HAVING COUNT (*) > 1;

--Checking totals between fact_meta_ads and stg_meta_ads
SELECT 
SUM (impressions) AS impressions,
SUM (clicks) AS clicks,
SUM (spend) AS spend
FROM fact_meta_ads;
--vs
SELECT 
SUM (impressions) AS impressions,
SUM (clicks) AS clicks,
SUM (spend) AS spend
FROM dbo.stg_meta_ads;

--Checking NULL in key fields
SELECT *
 FROM dbo.fact_meta_ads
 WHERE date_key IS NULL
 OR campaign_key IS NULL;