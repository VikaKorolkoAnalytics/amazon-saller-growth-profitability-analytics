# Amazon Ads ETL Pipeline

## Applied Steps

- Source
- Promoted Headers
- Standardize Column Names
- Cleaned Campaign ID
- Changed Data Types
- Removed Unnecessary Column
- Removed Duplicates
- Removed Blank Rows
- Added Channel (Amazon Ads)
- Changed Channel Data Type
- Added Source System (Amazon Ads)
- Changed Source System Data Type

## Processing Logic

1. Ingest monthly Amazon Ads CSV files from a source folder.
2. Apply a reusable cleaning function.
3. Standardize campaign identifiers and column names.
4. Validate and convert data types.
5. Remove duplicates and blank rows.
6. Add Channel and SourceSystem metadata.
7. Consolidate all files into a single staging dataset.
8. Export the final dataset as `stg_amazon_ads.csv`.

## Business Purpose

Transforms raw Amazon Ads reports into a clean and standardized staging dataset ready for SQL Server loading and downstream marketing performance analysis.