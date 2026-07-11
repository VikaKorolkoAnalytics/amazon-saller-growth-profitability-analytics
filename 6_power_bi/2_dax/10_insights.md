# 10 Insights 
This folder contains measures used to generate dynamic labels, KPI indicators, trend descriptions, conditional formatting, and business insight narratives throughout the report.

These measures enhance report usability and improve executive decision-making by providing meaningful context alongside quantitative metrics.

---
# Dynamic Location Labels
## Location Label
```DAX
Location Label =
IF(
	ISINSCOPE(dim_location[city]),
	MAX(dim_location[city]) & " (" & MAX(dim_state[state_name]) & ")",
	MAX(dim_state[state_name])
)
```
**Purpose:** 
Displays city and state information at detailed levels and state-only information at aggregated levels.

**Business Meaning:** 
Improves geographic analysis and report readability.

---
# Dynamic Trend Labels
## Trend Change %
```DAX
Trend Change % =
SWITCH(
	TRUE(),

	ISINSCOPE(dim_date[month_name]),
    	"MoM: "
    	& FORMAT([Gross Revenue MoM %], "+0.00%;-0.00%;"),

	ISINSCOPE(dim_date[quarter]),
    	"QoQ: "
    	& FORMAT([Gross Revenue QoQ %], "+0.00%;-0.00%;"),

	"YoY: "
    	& FORMAT([Gross Revenue YoY %], "+0.00%;-0.00%;")
)
```
**Purpose:** 
Dynamically displays MoM, QoQ, or YoY growth depending on the reporting granularity.

**Business Meaning:** 
Provides immediate trend context without requiring separate calculations or visuals.

---
# Waterfall Analysis Support
## % of Gross Revenue
```DAX
% of Gross Revenue =
DIVIDE(
	[Waterfall Value],
	CALCULATE(
    	[Total Gross Revenue],
    	REMOVEFILTERS('Waterfall Steps')
	)
)
```
**Purpose:** 
Calculates each waterfall component as a percentage of Gross Revenue.

**Business Meaning:** 
Supports profitability decomposition and P&L waterfall analysis.

---
# Conditional KPI Indicators
## Highlight Return Rate
```DAX
Highlight Return Rate =
SWITCH(
	TRUE(),
	[Return Rate %] > 0.07,
	"🔴 Critical return rate",
	BLANK()
)
```
**Purpose:** 
Flags unusually high return rates.

**Business Meaning:** 
Provides an immediate warning when return activity exceeds acceptable levels.

---
# Return Performance Labels
## Refund Amount YoY Label
```DAX
Refund Amount YoY Label =
VAR ChangeYoY = [Refund Amount YoY %]

RETURN
IF(
	ISBLANK(ChangeYoY),
	"",
	(IF(ChangeYoY > 0, "↑ ", "↓ "))
    	& "YoY"
)
```
**Purpose:** 
Generates a directional YoY indicator for refund amounts.

**Business Meaning:** 
Improves interpretation of refund trends within KPI visuals.

---
## Refund Units YoY Label
```DAX
Refund Units YoY Label =
VAR ChangeUnitsYoY = [Returned Units YoY %]

RETURN
IF(
	ISBLANK(ChangeUnitsYoY),
	"",
	(IF(ChangeUnitsYoY > 0, "↑ ", "↓ "))
    	& "YoY"
)
```
**Purpose:** 
Generates a directional YoY indicator for returned units.

**Business Meaning:** 
Highlights changes in return volume compared to the prior year.

---
## Return Rate pp MoM Label
```DAX
Return Rate pp MoM Label =
VAR ChangeReturnRateMoM = [Return Rate pp MoM]

RETURN
IF(
	ISBLANK(ChangeReturnRateMoM),
	"",
	IF(ChangeReturnRateMoM > 0, "↑ ", "↓ ")
    	& "pp MoM"
)
```
**Purpose:** 
Generates an indicator showing month-over-month change in Return Rate.

**Business Meaning:** 
Improves monitoring of return performance and operational quality.

---
# Business Value
These measures support:
- Dynamic report labeling.
- Automated KPI interpretation.
- Executive dashboards.
- Geographic analysis.
- Waterfall analysis.
- Return monitoring.
- Conditional formatting.
- Trend communication.
- Business insight generation.
- Decision support reporting.
