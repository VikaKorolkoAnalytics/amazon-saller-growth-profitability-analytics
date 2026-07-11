# 12 Calculated Columns
This folder contains calculated columns used to support time-based analysis and chronological sorting in Power BI visuals.

---
## Year Quarter
```DAX
year_quarter =
FORMAT(dim_date[full_date], "YYYY")
	& " Q"
	& dim_date[quarter_number]
```
**Purpose:** 
Creates a user-friendly Year-Quarter label for reporting and visualizations.

**Example:**
```text
2024 Q1
2024 Q2
2025 Q3
```

**Business Meaning:** 
Provides a readable time hierarchy for trend and quarterly performance analysis.

---
## Year Quarter Sort
```DAX
year_quarter_sort =
dim_date[year_number] * 10
	+ dim_date[quarter_number]
```
**Purpose:** 
Creates a numeric sorting key for the Year Quarter column.

**Example:**
```text
2024 Q1 → 20241
2024 Q2 → 20242
2024 Q3 → 20243
2025 Q1 → 20251
```

**Business Meaning:** 
Ensures chronological ordering of Year-Quarter labels in Power BI visuals and prevents alphabetical sorting issues.

---
# Business Value
These calculated columns support:
- Quarterly trend analysis.
- Time-based reporting.
- Chronological sorting in visualizations.
- Accurate YoY and QoQ reporting.
- Executive dashboard presentation.
