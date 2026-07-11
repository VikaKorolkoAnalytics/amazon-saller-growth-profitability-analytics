# Meta Ads - Power Query M Code

This document contains the Power Query implementation used to standardize, cleanse, and prepare Meta Ads data before loading it into the SQL staging layer.

## stg_meta_ads

```powerquery
let
    Source = Csv.Document(File.Contents("C:\Users\vikto\Downloads\Meta_ads_all_period.csv"),[Delimiter=",", Columns=8, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    Promoted_Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Standardardize_Column_Names = Table.RenameColumns(Promoted_Headers,{{"Day", "report_date"}, {"Campaign ID", "campaign_id"}, {"Campaign name", "campaign_name"}, {"Impressions", "impressions"}, {"Link clicks", "clicks"}, {"Amount spent (USD)", "spend"}}),
    Removed_Unnecessary_Columns = Table.RemoveColumns(Standardardize_Column_Names,{"Reporting starts", "Reporting ends"}),
    #"Removed Duplicates" = Table.Distinct(Removed_Unnecessary_Columns, {"report_date", "campaign_id", "campaign_name"}),
    Replaced_Empty_Clicks_With_Zero = Table.ReplaceValue(#"Removed Duplicates","","0",Replacer.ReplaceValue,{"clicks"}),
    Added_Column_Channel_Meta_Ads = Table.AddColumn(Replaced_Empty_Clicks_With_Zero, "channel", each "Meta Ads"),
    Added_Column_Sourse_System_Meta_Ads = Table.AddColumn(Added_Column_Channel_Meta_Ads, "source_system", each "Meta Ads"),
    Changed_Data_Types = Table.TransformColumnTypes(Added_Column_Sourse_System_Meta_Ads,{{"report_date", type date}, {"campaign_id", type text}, {"campaign_name", type text}, {"impressions", Int64.Type}, {"clicks", Int64.Type}, {"spend", type number}, {"channel", type text}, {"source_system", type text}}),
    Added_Column_Source_File = Table.AddColumn(Changed_Data_Types, "source_file", each "Meta_ads_" & Date.ToText ([report_date], "yyyy_MM")),
    #"Reordered Columns_Source_File" = Table.ReorderColumns(Added_Column_Source_File,{"source_file", "report_date", "campaign_id", "campaign_name", "impressions", "clicks", "spend", "channel", "source_system"})
in
    #"Reordered Columns_Source_File"
```

### Purpose

Transforms a consolidated Meta Ads source file into a clean staging dataset while preserving source lineage and ensuring consistent reporting structure.