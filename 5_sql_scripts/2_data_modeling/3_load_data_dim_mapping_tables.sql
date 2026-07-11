/* ======================================
LOAD DATA INTO DIMENSION & MAPPING TABLES
====================================== */

--Load into dim_state
INSERT INTO dim_state (state_code, state_name)
VALUES
('AL', 'Alabama'),
('AK', 'Alaska'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');

--Load dim_location from stg_amazon_sales
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

--Load into product_mapping
INSERT INTO dbo.product_mapping (
sku,
product_name,
color)
VALUES 
('II-1JLZ-7YG6', 'Car Seat for Dog, Beige', 'Beige'),
('OT-T2IP-D9BI', 'Car Seat for Dog, Pink', 'Pink'),
('WS-L9LR-FMUA', 'Car Seat for Dog, Grey', 'Grey'),
('03-ZPPH-X7CL', 'Car Seat for Dog, Brown', 'Brown'),
('32-IQYL-UHAB', 'Car Seat for Dog, Black', 'Black'),
('8O-DXOB-HH5A', 'Car Seat for Dog, Rainbow', 'Rainbow');

--Load dim_product from stg_amazon_sales 
INSERT INTO dbo.dim_product (
sku,
product_name,
color
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

--Load dim_campaign from Amazon and Meta tables
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

--Ensure Monday = 1 for weekday calculation
SET DATEFIRST 1;
--Generate and load dim_date
WITH dates AS(
SELECT CAST ('2024-01-01' AS DATE) AS full_date
UNION ALL
SELECT DATEADD (DAY, 1, full_date)
FROM dates 
WHERE full_date < '2030-12-31'
)

INSERT INTO dbo.dim_date (
date_key,
full_date,
year_number,
month_number,
month_name,
quarter,
day_of_month,
day_name,
day_of_week,
is_weekend
)
SELECT
CONVERT (INT, CONVERT (VARCHAR (8), full_date, 112)),
full_date,
YEAR (full_date),
MONTH (full_date),
DATENAME (MONTH, full_date),
DATEPART (QUARTER, full_date),
DAY (full_date),
DATENAME (WEEKDAY, full_date),
DATEPART (WEEKDAY, full_date),
CASE
    WHEN DATEPART (WEEKDAY, full_date) IN (1,7) THEN 1
    ELSE 0
END 
FROM dates
WHERE NOT EXISTS (
     SELECT 1 
     FROM dbo.dim_date dd
     WHERE dd.full_date = dates.full_date
)
OPTION (MAXRECURSION 0); 