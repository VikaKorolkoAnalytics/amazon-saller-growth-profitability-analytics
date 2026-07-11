# Amazon Ads - Power Query M Code

This document contains the Power Query implementation used to standardize, cleanse, and consolidate Amazon Ads source files before loading them into the SQL staging layer.

## Transform Sample File

```powerquery
let
    Source = Csv.Document(Parameter1,[Delimiter=",", Columns=7, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    Promoted_Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Standardize_Column_Names = Table.RenameColumns(Promoted_Headers,{{"Date", "report_date"}, {"Campaign ID", "campaign_id"}, {"Campaign name", "campaign_name"}, {"Impressions", "impressions"}, {"Clicks", "clicks"}, {"Supply cost", "spend"}}),
    Cleaned_Campaign_Id = Table.TransformColumns(Standardize_Column_Names,{{"campaign_id", each let t = Text.From(_), t1 = Text.Replace(t, "=""", ""), t2 = Text.Replace(t1, """", "") in t2}}),
    Changed_Data_Types = Table.TransformColumnTypes(Cleaned_Campaign_Id,{{"report_date", type date}, {"campaign_id", type text}, {"campaign_name", type text}, {"impressions", Int64.Type}, {"clicks", Int64.Type}, {"spend", type number}}),
    Removed_Unnecessary_Column = Table.RemoveColumns(Changed_Data_Types,{"Budget currency"}),
    Removed_Blank_Rows = Table.SelectRows(Removed_Unnecessary_Column, each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Removed Duplicates" = Table.Distinct(Removed_Blank_Rows, {"report_date", "campaign_id", "campaign_name"}),
    Added_Column_Channel_Amazon_Ads = Table.AddColumn(#"Removed Duplicates", "channel", each "Amazon Ads"),
    Changed_Channel_Data_Type = Table.TransformColumnTypes(Added_Column_Channel_Amazon_Ads,{{"channel", type text}}),
    #"Added Column_Source_System_Amazon_Ads" = Table.AddColumn(Changed_Channel_Data_Type, "source_system", each "Amazon Ads"),
    Changed_Source_System_Data_Type = Table.TransformColumnTypes(#"Added Column_Source_System_Amazon_Ads",{{"source_system", type text}})
in
    Changed_Source_System_Data_Type

```
### Purpose

Applies standardized cleansing and transformation logic to a single Amazon Ads source file, ensuring consistent schema, campaign tracking accuracy, and data quality.

---

## stg_amazon_ads

```powerquery
let
    Source = Folder.Files("<Amazon Ads Source Folder>"),
    #"Filtered Hidden Files1" = Table.SelectRows(Source, each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
    #"Renamed Columns1" = Table.RenameColumns(#"Invoke Custom Function1", {"Name", "Source.Name"}),
    #"Removed Other Columns1" = Table.SelectColumns(#"Renamed Columns1", {"Source.Name", "Transform File"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
    #"Renamed Columns" = Table.RenameColumns(#"Expanded Table Column1",{{"Source.Name", "source_file"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"source_file", type text}})
in
    #"Changed Type"

```
### Purpose

Combines multiple monthly Amazon Ads files into a single consolidated staging dataset while preserving source file lineage for auditing and traceability.