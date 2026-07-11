# Power Query Incremental Filter
To support monthly incremental updates, a dynamic filter was added to the staging query.

The logic identifies the most recent source file and exports only new records for downstream SQL loading.

```powerquery
//Steps to extract only new data
MaxSourceFile = List.Max(#"Renamed Columns"[source_file]),
FilteredRows = Table.SelectRows(#"Renamed Columns", each [source_file] = MaxSourceFile)
```

## Purpose
- Automatically identifies the latest monthly source file.
- Exports only newly processed records.
- Reduces unnecessary SQL loading.
- Supports incremental loading of staging data.