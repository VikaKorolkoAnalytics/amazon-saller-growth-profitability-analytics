# Incremental Load Process
The solution supports incremental monthly updates without reloading the entire dataset.

This approach minimizes processing time while ensuring data consistency across staging, dimension, and fact tables.

## Incremental Loading Architecture
``` text
Monthly Source File
         ↓
Power Query Refresh
         ↓
Staging CSV File
         ↓
SQL Staging Layer
         ↓
Dimension Updates
         ↓
Fact Updates
         ↓
Power BI Refresh
```

## Processing Logic
### Step 1. Source File Refresh
A new monthly CSV file is added to the source folder.

Power Query automatically applies the existing transformation logic to the new file using the Folder + Function pattern.

### Step 2. Latest File Extraction
A dynamic Power Query filter identifies the most recent source file and exports only new records for loading.
```text
MaxSourceFile
        ↓
Filter Latest File
        ↓
Export Staging CSV
```

### Step 3. Staging Load
The transformed CSV file is loaded into SQL Server using BULK INSERT.

Before loading, the process verifies whether the source file has already been imported.

### Step 4. Dimension Updates
Dimension tables are updated incrementally:
- dim_location
- dim_product
- dim_campaign

Only new records are inserted.

### Step 5. Fact Table Updates
Fact tables are updated incrementally:
- fact_amazon_sales
- fact_amazon_returns
- fact_amazon_ads
- fact_meta_ads

Duplicate prevention is implemented using `NOT EXISTS` validation logic.

### Step 6. Validation
After each update, validation checks are performed:
- Row count verification
- Duplicate detection
- Primary business metric reconciliation
- Dimension integrity validation

## Benefits
- Incremental processing of new monthly data
- Duplicate protection
- Data lineage via `source_file` tracking
- Safe re-execution (idempotent design)
- Reduced processing time compared to full reloads

## Related Documentation
[Power Query Incremental Filter](./power_query_incremental_filter.md)

## Related SQL Scripts
[Incremental Load Process](./7_single_script_for_incremental_updates.sql)