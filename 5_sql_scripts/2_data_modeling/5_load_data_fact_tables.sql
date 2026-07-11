/* =========================
LOAD DATA INTO FACT TABLES
========================= */

--Load data into fact_amazon_sales (aggregated grain)
--Keep only order transactions (exclude Refunds)
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

--Load return transaction into fact_amazon_returns (aggregated grain)
--Keep only refund transactions (exclude Orders)
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

--Load data into into fact_amazon_ads (aggregated grain)
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


--Load data into into fact_meta_ads 
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