# Meta Ads ETL Pipeline

## Applied Steps

- Source
- Promoted Headers
- Standardize Column Names
- Removed Unnecessary Columns
- Removed Duplicates
- Replaced Empty Clicks with Zero
- Added Channel (Meta Ads)
- Added Source System (Meta Ads)
- Changed Data Types
- Added Source File
- Reordered Columns

## Processing Logic

1. Import the consolidated Meta Ads source file.
2. Standardize column names and structure.
3. Remove unnecessary reporting fields.
4. Remove duplicate records.
5. Replace missing click values with zero.
6. Apply data type validation.
7. Add Channel and SourceSystem metadata.
8. Generate SourceFile identifiers for data lineage and auditing.
9. Create the final staging dataset.
10. Export the final dataset as `stg_meta_ads.csv`.

## Business Purpose

Transforms raw Meta Ads campaign reports into a clean and standardized staging dataset ready for SQL Server loading and downstream marketing performance analysis.