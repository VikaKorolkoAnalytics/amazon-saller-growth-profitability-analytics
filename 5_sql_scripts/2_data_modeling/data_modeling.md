# Data Modeling

The dimensional model was implemented using a Hybrid Star Schema design.

## Dimension Tables

- dim_date
- dim_product
- dim_location
- dim_state
- dim_campaign

## Mapping Tables

- product_mapping

## Fact Tables

- fact_amazon_sales
- fact_amazon_returns
- fact_amazon_ads
- fact_meta_ads

## Data Modeling Process

1. Created dimension and mapping tables.
2. Loaded dimension attributes from staging datasets.
3. Generated the Date Dimension to support Time Intelligence calculations.
4. Created fact tables and loaded transactional and advertising data.
5. Established relationships through surrogate keys.
6. Implemented post-load data quality validation.

### Dimension & Mapping Validation

- Row count verification.
- Sample data inspection (TOP 10).
- SKU mapping validation between staging and mapping tables.
- Detection of unmapped SKUs before fact table loading.

### Fact Table Validation

The following checks were performed for all fact tables:

- Row count verification.
- Sample data inspection (TOP 10).
- Duplicate record detection.
- NULL checks on foreign key fields.
- Reconciliation of aggregated values between staging and fact tables.

### Reconciliation Checks

The following business measures were compared between staging and fact tables:

- Sales Quantity
- Revenue
- Selling Fees
- FBA Fees
- Returned Units
- Refund Amount
- Advertising Impressions
- Clicks
- Spend

This validation process ensured that all fact tables accurately reflected their corresponding staging datasets before being used for analytical reporting.

### Releted SQL Scripts
- [Create Dimension & Mapping Tables](./2_create_dim_mapping_tables.sql)
- [Load Dimension & Mapping Data](./3_load_data_dim_mapping_tables.sql)
- [Create Fact Tables](./4_create_fact_tables.sql)
- [Load Fact Data](./5_load_data_fact_tables.sql)
- [Post-Load Data Validation](./6_post-load_validation_dim_mapping_fact_tables.sql)