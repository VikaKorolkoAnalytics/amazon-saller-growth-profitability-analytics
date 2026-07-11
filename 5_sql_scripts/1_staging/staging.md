# SQL Staging Layer
The staging layer stores cleaned datasets exported from Power Query:
- stg_amazon_sales
- stg_amazon_ads
- stg_meta_ads

Validation checks include:
- Row count validation
- Data type verification
- NULL checks on critical fields
- Duplicate record detection and vaidation
- Post-load data quality validation 

### Releted SQL Scripts
[SQL Staging Validation Script](./1_validation_stg_tables.sql)