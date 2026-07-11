/*===============================
SINGLE INCREMENTAL LOADING SCRIPT
(Press F5 and everything updates)
===============================*/


/*================================================================================
1. LOADING TO STAGING WITH REPEAT PROTECTION
(ATTENTION: the order of the columns in the CSV must match the order in the table!)
=================================================================================*/

-- Declare variables once at the very beginning 
-- Specify the name of the file being uploaded. It must match the name in the CSV file
-- We update the file name every month
DECLARE @FileAmazonSales NVARCHAR(200) = 'amazon_sales_2025_12.csv';
DECLARE @FileAmazonAds NVARCHAR(200) = 'Amazon_ads_2025_Dec.csv';
DECLARE @FileMetaAds NVARCHAR(200) = 'Meta_ads_2025_12.csv';

/*=================
AMAZON SALES UPDATE  
=================*/
-- Let's check if this file is already in the staging area
IF NOT EXISTS (
    SELECT 1 FROM dbo.stg_amazon_sales 
    WHERE source_file = @FileAmazonSales
)
BEGIN
-- If not, we download it
BULK INSERT dbo.stg_amazon_sales
FROM 'C:\SQL_Data_amazon_sales\amazon_sales_2025_12.csv'
WITH (
    FIELDTERMINATOR = ',',      -- Comma separator
    ROWTERMINATOR = '\n',       -- End of line
    FIRSTROW = 2,
    TABLOCK,
    CODEPAGE = '65001'         -- To support UTF-8
 );
    PRINT 'File ' + @FileAmazonSales + ' successfully loaded into staging.';
END
ELSE
    PRINT 'File ' + @FileAmazonSales + ' already loaded. Skipping.';

/*===============
AMAZON ADS UPDATE  
===============*/
-- Let's check if this file is already in the staging area
IF NOT EXISTS (
    SELECT 1 FROM dbo.stg_amazon_ads 
    WHERE source_file = @FileAmazonAds
)
BEGIN
-- If not, we download it
BULK INSERT dbo.stg_amazon_ads
FROM 'C:\SQL_Data_amazon_ads\Amazon_ads_2025_Dec.csv'
WITH (
    FIELDTERMINATOR = ',',      -- Comma separator
    ROWTERMINATOR = '\n',       -- End of line
    FIRSTROW = 2,
    TABLOCK,
    CODEPAGE = '65001'         -- To support UTF-8
 );
    PRINT 'File ' + @FileAmazonAds + ' successfully loaded into staging.';
END
ELSE
    PRINT 'File ' + @FileAmazonAds + ' already loaded. Skipping.';

/*=============
META ADS UPDATE  
=============*/
-- Let's check if this file is already in the staging area
IF NOT EXISTS (
    SELECT 1 FROM dbo.stg_meta_ads 
    WHERE source_file = @FileMetaAds
)
BEGIN
-- If not, we download it
BULK INSERT dbo.stg_meta_ads
FROM 'C:\SQL_Data_meta_ads\Meta_ads_2025_12.csv'
WITH (
    FIELDTERMINATOR = ',',      -- Comma separator
    ROWTERMINATOR = '\n',       -- End of line
    FIRSTROW = 2,
    TABLOCK,
    CODEPAGE = '65001'         -- To support UTF-8
    );
    PRINT 'File ' + @FileMetaAds + ' successfully loaded into staging.';
END
ELSE
    PRINT 'File ' + @FileMetaAds + ' already loaded. Skipping.';

/*========================
2. UPDATING ALL DIMENSIONS 
========================*/

--Update dim_location
INSERT INTO dbo.dim_location (state_code, city)
SELECT DISTINCT 
stg.order_state AS state_code,
stg.order_city AS city
FROM dbo.stg_amazon_sales stg
WHERE stg.order_state IS NOT NULL 
AND stg.order_city IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM dbo.dim_location dl
    WHERE dl.state_code = stg.order_state
    AND dl.city = stg.order_city
    );

--Update dim_product 
INSERT INTO dbo.dim_product (
sku,
product_name,
color,
cost_per_unit
)
SELECT DISTINCT
stg.sku,
pm.product_name,
pm.color
FROM dbo.stg_amazon_sales stg
JOIN dbo.product_mapping pm
ON stg.sku = pm.sku
WHERE NOT EXISTS (
     SELECT 1 
     FROM dbo.dim_product dp
     WHERE dp.sku = stg.sku
);

--Update dim_campaign
INSERT INTO dbo.dim_campaign (
campaign_id,
campaign_name,
channel,
source_system
)
SELECT
ma.campaign_id,
ma.campaign_name,
ma.channel,
ma.source_system
FROM (
     SELECT
     stga.campaign_id,
     stga.campaign_name,
     stga.channel,
     stga.source_system
     FROM dbo.stg_amazon_ads stga
     WHERE stga.campaign_id IS NOT NULL

     UNION

     SELECT
     stgm.campaign_id,
     stgm.campaign_name,
     stgm.channel,
     stgm.source_system
     FROM dbo.stg_meta_ads stgm
     WHERE stgm.campaign_id IS NOT NULL
) ma
WHERE NOT EXISTS (
    SELECT 1 
    FROM dbo.dim_campaign dc
    WHERE dc.campaign_id = ma.campaign_id
);


/*=================
3. UPDATE ALL FACTS
=================*/

--Update fact_amazon_sales 
INSERT INTO dbo.fact_amazon_sales (
date_key,
product_key,
location_key,
order_id,
quantity,
line_revenue,
selling_fees,
fba_fees,
cost_per_unit,
source_system 
)
SELECT 
dd.date_key,
dp.product_key,
dl.location_key,
stg.order_id,
SUM (stg.quantity) AS quantity,
SUM (stg.line_revenue) AS line_revenue,
SUM (stg.selling_fees) AS selling_fees,
SUM (stg.fba_fees) AS fba_fees,
CASE 
    WHEN dd.full_date < '2025-04-01' THEN 9.00
    ELSE 18.40
    END AS cost_per_unit,
stg.source_system 
FROM dbo.stg_amazon_sales stg
JOIN dbo.dim_date dd
ON dd.full_date = stg.order_date
JOIN dbo.dim_product dp
ON dp.sku = stg.sku
JOIN dbo.dim_location dl
ON dl.state_code = stg.order_state
AND dl.city = stg.order_city
WHERE transaction_type = 'Order'
AND stg.order_id IS NOT NULL
AND NOT EXISTS (
     SELECT 1 
     FROM dbo.fact_amazon_sales fs
     WHERE fs.order_id = stg.order_id
     AND fs.product_key = dp.product_key
)
GROUP BY 
    dd.date_key,
    dp.product_key,
    dl.location_key,
    stg.order_id,
    dd.full_date,
    stg.source_system;

--Update fact_amazon_returns
INSERT INTO dbo.fact_amazon_returns (
date_key,
product_key,
location_key,
order_id,
returned_quantity,
refund_amount,
refund_fees,
cost_per_unit,
source_system 
)
SELECT 
dd.date_key,
dp.product_key,
dl.location_key,
stg.order_id,
SUM (stg.quantity) AS returned_quantity,
SUM (ABS (stg.line_revenue)) AS refund_amount,
SUM (stg.selling_fees) AS refund_fees,
CASE
    WHEN dd.full_date < '2025-04-01' THEN 9.00
    ELSE 18.40
    END AS cost_per_unit,
stg.source_system 
FROM dbo.stg_amazon_sales stg
JOIN dbo.dim_date dd
ON dd.full_date = stg.order_date
JOIN dbo.dim_product dp
ON dp.sku = stg.sku
JOIN dbo.dim_location dl
ON dl.state_code = stg.order_state
AND dl.city = stg.order_city
WHERE transaction_type = 'Refund'
AND stg.order_id IS NOT NULL
AND NOT EXISTS (
     SELECT 1 
     FROM dbo.fact_amazon_returns fr
     WHERE fr.order_id = stg.order_id
     AND fr.product_key = dp.product_key
)
GROUP BY 
    dd.date_key,
    dp.product_key,
    dl.location_key,
    stg.order_id,
    dd.full_date,
    stg.source_system;

--Update fact_amazon_ads 
INSERT INTO dbo.fact_amazon_ads (
date_key,
campaign_key,
impressions,
clicks,
spend,
source_system
)
SELECT
dd.date_key,
dc.campaign_key,
SUM (stga.impressions) AS impressions,
SUM (stga.clicks) AS clicks,
SUM (stga.spend) AS spend,
stga.source_system
FROM dbo.stg_amazon_ads stga
JOIN dbo.dim_date dd
ON dd.full_date = stga.report_date
JOIN dbo.dim_campaign dc
ON dc.campaign_id = stga.campaign_id
WHERE NOT EXISTS (
      SELECT 1
      FROM  dbo.fact_amazon_ads fa
      WHERE fa.date_key = dd.date_key
      AND fa.campaign_key = dc.campaign_key
)
GROUP BY 
dd.date_key,
dc.campaign_key,
stga.source_system;


--Update fact_meta_ads 
INSERT INTO dbo.fact_meta_ads (
date_key,
campaign_key,
impressions,
clicks,
spend,
source_system
)
SELECT
dd.date_key,
dc.campaign_key,
stgm.impressions AS impressions,
stgm.clicks AS clicks,
stgm.spend AS spend,
stgm.source_system
FROM dbo.stg_meta_ads stgm
JOIN dbo.dim_date dd
ON dd.full_date = stgm.report_date
JOIN dbo.dim_campaign dc
ON dc.campaign_id = stgm.campaign_id
WHERE NOT EXISTS (
      SELECT 1
      FROM  dbo.fact_meta_ads fm
      WHERE fm.date_key = dd.date_key
      AND fm.campaign_key = dc.campaign_key
);

/*===============================================
4. CHECKING THE RESULTS OF THE INCREMENTAL UPDATE
===============================================*/

-- How many rows were loaded from a specific file?
SELECT COUNT(*) AS rows_loaded_Amazon_Sales
FROM dbo.stg_amazon_sales
WHERE source_file = 'amazon_sales_2025_12.csv';

SELECT COUNT(*) AS rows_loaded_Amazon_Ads
FROM dbo.stg_amazon_ads
WHERE source_file = 'Amazon_ads_2025_Dec.csv';

SELECT COUNT(*) AS rows_loaded_Meta_Ads
FROM dbo.stg_meta_ads
WHERE source_file = 'Meta_ads_2025_12.csv';

-- Checking that there are no duplicates by key
SELECT 
'dim_location' AS table_name,
state_code,
city,
COUNT(*) AS duplicates
FROM dbo.dim_location
GROUP BY state_code, city
HAVING COUNT(*) > 1;

SELECT 
'dim_product' AS table_name,
sku,
COUNT(*) AS duplicates
FROM dbo.dim_product
GROUP BY sku
HAVING COUNT(*) > 1;

SELECT 
'dim_campaign' AS table_name,
campaign_id,
COUNT(*) AS duplicates
FROM dbo.dim_campaign
GROUP BY campaign_id
HAVING COUNT(*) > 1;

SELECT 
'fact_amazon_sales' AS table_name,
order_id, 
product_key, 
COUNT(*) AS duplicates
FROM dbo.fact_amazon_sales
GROUP BY order_id, product_key
HAVING COUNT(*) > 1;

SELECT 
'fact_amazon_returns' AS table_name,
order_id, 
product_key, 
location_key,
date_key,
COUNT (*) AS duplicates
FROM dbo.fact_amazon_returns
GROUP BY 
order_id, 
product_key,
location_key,
date_key
HAVING COUNT (*) > 1;

SELECT  
'fact_amazon_ads' AS table_name,
date_key,
campaign_key,
COUNT (*) AS duplicates
FROM dbo.fact_amazon_ads
GROUP BY 
date_key,
campaign_key
HAVING COUNT (*) > 1;

SELECT  
'fact_meta_ads' AS table_name,
date_key,
campaign_key,
COUNT (*) AS cnt
FROM dbo.fact_meta_ads
GROUP BY 
date_key,
campaign_key
HAVING COUNT (*) > 1;