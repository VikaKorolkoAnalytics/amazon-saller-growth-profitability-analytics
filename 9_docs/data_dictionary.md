# Data Dictionary
This document describes the main tables and fields used in the Amazon Seller Growth & Profitability Analytics solution.

---
# fact_amazon_sales
Stores completed Amazon sales transactions.

| Column | Description |
|----------|------------|
| date_key | Foreign key to the Date dimension |
| product_key | Foreign key to the Product dimension |
| location_key | Foreign key to the Location dimension |
| order_id | Unique customer order identifier |
| quantity | Number of units sold |
| line_revenue | Gross revenue before refunds |
| selling_fees | Amazon selling fees |
| fba_fees | Amazon fulfillment fees |
| cost_per_unit | Product cost per unit |
| source_system | Source platform identifier |

---
# fact_amazon_returns
Stores product return and refund transactions.

| Column | Description |
|----------|------------|
| date_key | Foreign key to the Date dimension |
| product_key | Foreign key to the Product dimension |
| location_key | Foreign key to the Location dimension |
| order_id | Order associated with the return |
| returned_quantity | Number of units returned |
| refund_amount | Amount refunded to the customer |
| refund_fees | Amazon refund fee reimbursement |
| cost_per_unit | Product cost per unit |
| source_system | Source platform identifier |

---
# fact_amazon_ads
Stores Amazon Ads campaign performance metrics.

| Column | Description |
|----------|------------|
| date_key | Foreign key to the Date dimension |
| campaign_key | Foreign key to the Campaign dimension |
| impressions | Number of ad impressions |
| clicks | Number of ad clicks |
| spend | Advertising spend |
| source_system | Source platform identifier |

---
# fact_meta_ads
Stores Meta Ads campaign performance metrics.

| Column | Description |
|----------|------------|
| date_key | Foreign key to the Date dimension |
| campaign_key | Foreign key to the Campaign dimension |
| impressions | Number of ad impressions |
| clicks | Number of ad clicks |
| spend | Advertising spend |
| source_system | Source platform identifier |

---
# dim_date
Calendar dimension supporting Time Intelligence calculations.

| Column | Description |
|----------|------------|
| date_key | Surrogate key |
| full_date | Calendar date |
| year_number | Calendar year |
| quarter_number | Calendar quarter |
| month_number | Calendar month number |
| month_name | Calendar month name |
| year_quarter | Year-quarter label |
| year_quarter_sort | Sort key for year-quarter reporting |

---
# dim_product
Product dimension.

| Column | Description |
|----------|------------|
| product_key | Surrogate key |
| sku | Amazon product SKU |
| product_name | Product name |
| color | Product color |
| cost_per_unit | Product cost per unit |

---
# dim_location
Customer location dimension.

| Column | Description |
|----------|------------|
| location_key | Surrogate key |
| state_code | State abbreviation |
| city | Customer city |

---
# dim_state
State reference dimension.

| Column | Description |
|----------|------------|
| state_code | State abbreviation |
| state_name | State name |

---
# dim_campaign
Marketing campaign dimension.

| Column | Description |
|----------|------------|
| campaign_key | Surrogate key |
| campaign_id | Campaign identifier |
| campaign_name | Campaign name |
| channel | Advertising channel |
| source_system | Source platform identifier |

---
# product_mapping
Mapping table used during dimensional modeling.

| Column | Description |
|----------|------------|
| sku | Amazon SKU |
| product_name | Product name |
| color | Product color |

---
# Staging Tables
The staging layer contains cleaned datasets exported from Power Query before loading into SQL Server.
- stg_amazon_sales
- stg_amazon_ads
- stg_meta_ads

These tables serve as the source for dimensional modeling and fact table loading.
