# Amazon Sales ETL Pipeline

## Applied Steps

- Source
- Promoted_Headers
- Standardize_Column_Names
- Changed_Data_Types
- Added_Column_Source_system_(Amazon_Sales)
- Changed_Source_System_Data_Type
- Filtered_Order_Refund
- Removed Duplicates

## Processing Logic

1. Ingest CSV files from a source folder.
2. Apply a standardized cleaning function to every file.
3. Standardize column names and data types.
4. Add SourceSystem for data lineage tracking.
5. Preserve SourceFile for auditing and traceability.
6. Filter relevant transaction types.
7. Remove duplicate records.
8. Consolidate all files into a single staging dataset.
9. Export the final dataset as `stg_amazon_sales.csv`.

## Business Purpose

Transforms raw Amazon transaction reports into a clean and standardized staging dataset ready for SQL Server loading and downstream dimensional modeling.

## Technical Implementation
[Amazon Sales M Code](./m-code/amazon_sales_m_code.md) 