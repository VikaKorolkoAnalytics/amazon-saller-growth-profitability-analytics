# Amazon Sales - Power Query M Code

This document contains the Power Query implementation used to standardize, cleanse, and consolidate Amazon Sales source files before loading them into the SQL staging layer.

## Transform Sample File 

```powerquery
let
    Source = Csv.Document(Parameter1,[Delimiter=",", Columns=11, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    Promoted_Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Standardize_Column_Names = Table.RenameColumns(Promoted_Headers,{{"date/time", "order_date"}, {"type", "transaction_type"}, {"order id", "order_id"}, {"description", "product_name"}, {"order city", "order_city"}, {"order state", "order_state"}, {"product sales", "line_revenue"}, {"selling fees", "selling_fees"}, {"fba fees", "fba_fees"}}),
    Changed_Data_Types = Table.TransformColumnTypes(Standardize_Column_Names,{{"order_date", type date}, {"transaction_type", type text}, {"order_id", type text}, {"sku", type text}, {"product_name", type text}, {"quantity", Int64.Type}, {"order_city", type text}, {"order_state", type text}, {"line_revenue", type number}, {"selling_fees", type number}, {"fba_fees", type number}}),
    #"Added_Column_Source_system_(Amazon Sales)" = Table.AddColumn(Changed_Data_Types, "source_system", each "Amazon Sales"),
    Changed_Source_System_Data_Type = Table.TransformColumnTypes(#"Added_Column_Source_system_(Amazon Sales)",{{"source_system", type text}}),
    Filtered_Order_Refund_FeeAdjustment = Table.SelectRows(Changed_Source_System_Data_Type, each ([transaction_type] = "Order" or [transaction_type] = "Refund")),
    #"Removed Duplicates" = Table.Distinct(Filtered_Order_Refund_FeeAdjustment, {"order_date", "order_id", "sku"})
in
    #"Removed Duplicates"
```
### Purpose 

Applies standardized cleansing and transformation logic to a single Amazon Sales source file, ensuring consistent schema and data quality.

---

## stg_amazon_sales

```powerquery
let
    Source = Folder.Files ("<Amazon Sales Source Folder>"),
    #"Filtered Hidden Files1" = Table.SelectRows(Source, each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
    #"Renamed Columns1" = Table.RenameColumns(#"Invoke Custom Function1", {"Name", "Source.Name"}),
    #"Removed Other Columns1" = Table.SelectColumns(#"Renamed Columns1", {"Source.Name", "Transform File"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
    #"Renamed Columns" = Table.RenameColumns(#"Expanded Table Column1",{{"Source.Name", "source_file"}})
in
    #"Renamed Columns"
```

### Purpose 

Combines multiple monthly Amazon Sales files into a single consolidated staging dataset while preserving source file lineage for auditing and traceability.