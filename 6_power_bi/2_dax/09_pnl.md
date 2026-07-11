# 09 P&L Measures
This folder contains measures used to support Profit & Loss analysis, financial performance monitoring, executive reporting, dynamic KPI switching, and waterfall visualizations.

The measures power the P&L dashboard page and provide dynamic financial insights based on user-selected metrics.

---
# Financial Performance KPI Switching
## P&L Current FP
```DAX
P&L Current FP =
SWITCH(
	SELECTEDVALUE('P&L Financial Performance'[Metric]),
	"Net Sales", [Net Sales],
	"Gross Profit", [Gross Profit],
	"Operating Profit", [Operating Profit (EBIT)]
)
```
**Purpose:** 
Dynamically returns the currently selected Financial Performance metric.

---
## P&L Prior Month FP
```DAX
P&L Prior Month FP =
IF(
	NOT(
    	HASONEVALUE(dim_date[year_number])
    	&&
    	HASONEVALUE(dim_date[month_number])
	),
	BLANK(),

	SWITCH(
    	SELECTEDVALUE('P&L Financial Performance'[Metric]),

    	"Net Sales",
    	CALCULATE(
        	[Net Sales],
        	PREVIOUSMONTH(dim_date[full_date])
    	),

    	"Gross Profit",
    	CALCULATE(
        	[Gross Profit],
        	PREVIOUSMONTH(dim_date[full_date])
    	),

    	"Operating Profit",
    	CALCULATE(
        	[Operating Profit (EBIT)],
        	PREVIOUSMONTH(dim_date[full_date])
    	)
	)
)
```
**Purpose:** 
Returns the prior month value of the selected financial metric.

---
## P&L FP MoM %
```DAX
P&L FP MoM % =
VAR CurrentFP = [P&L Current FP]
VAR PreviousFP = [P&L Prior Month FP]

RETURN
IF(
	ISBLANK(PreviousFP),
	BLANK(),
	DIVIDE(CurrentFP - PreviousFP, PreviousFP)
)
```
**Purpose:** 
Calculates month-over-month growth for the selected financial metric.

---
# Efficiency KPI Switching
## P&L Current EM
```DAX
P&L Current EM =
SWITCH(
	SELECTEDVALUE('P&L Efficiency Metrics'[Metric]),
	"Gross Margin", [Gross Margin %],
	"Operating Margin", [Operating Margin %],
	"Return Rate", [Return Rate %]
)
```
**Purpose:** 
Returns the selected efficiency metric.

---
## P&L Prior Month EM
```DAX
P&L Prior Month EM =
IF(
	NOT(
    	HASONEVALUE(dim_date[year_number])
    	&&
    	HASONEVALUE(dim_date[month_number])
	),
	BLANK(),

	SWITCH(
    	SELECTEDVALUE('P&L Efficiency Metrics'[Metric]),

    	"Gross Margin",
    	CALCULATE(
        	[Gross Margin %],
        	PREVIOUSMONTH(dim_date[full_date])
    	),

    	"Operating Margin",
    	CALCULATE(
        	[Operating Margin %],
        	PREVIOUSMONTH(dim_date[full_date])
    	),

    	"Return Rate",
    	CALCULATE(
        	[Return Rate %],
        	PREVIOUSMONTH(dim_date[full_date])
    	)
	)
)
```
**Purpose:** 
Returns the previous month value of the selected efficiency metric.

---
## P&L EM MoM (pp)
```DAX
P&L EM MoM (pp) =
VAR CurrentEM = [P&L Current EM]
VAR PreviousEM = [P&L Prior Month EM]

RETURN
IF(
	ISBLANK(PreviousEM),
	BLANK(),
	(CurrentEM - PreviousEM) * 100
)
```
**Purpose:** 
Calculates month-over-month change in efficiency metrics using percentage points.

---
## P&L EM Color
```DAX
P&L EM Color =
SWITCH(
	SELECTEDVALUE('P&L Efficiency Metrics'[Metric]),

	"Gross Margin",
    	IF([P&L EM MoM (pp)] > 0, "#2E8B57", "#D64545"),

	"Operating Margin",
    	IF([P&L EM MoM (pp)] > 0, "#2E8B57", "#D64545"),

	"Return Rate",
    	IF([P&L EM MoM (pp)] > 0, "#D64545", "#2E8B57")
)
```
**Purpose:** 
Controls conditional formatting and KPI coloring based on business performance.

---
# Automated Business Insights
## P&L Insights
```DAX
P&L Insights =
VAR SalesMoM = [Net Sales MoM %]
VAR ProfitMoM = [Operating Profit MoM %]
VAR MarginMoM = [Operating Margin MoM (pp)]
VAR ReturnRateMoM = [Return Rate MoM (pp)]

RETURN
IF(
	ISBLANK(SalesMoM)
    	|| ISBLANK(ProfitMoM)
    	|| ISBLANK(ReturnRateMoM)
    	|| ISBLANK(MarginMoM),

	"Select a single Year and Month to view insights",

	"• Net Sales "
    	& IF(SalesMoM >= 0, "increased by ", "decreased by ")
    	& FORMAT(ABS(SalesMoM), "0.00%")
    	& " vs prior month."
    	& UNICHAR(10) & UNICHAR(10)

    	& "• Operating Profit "
    	& IF(
        	ProfitMoM >= 0,
        	"increased by "
            	& FORMAT(ABS(ProfitMoM), "0.00%")
            	& ", indicating profitability growth remained aligned with revenue expansion.",

        	"decreased by "
            	& FORMAT(ABS(ProfitMoM), "0.00%")
            	& ", indicating profitability weakened compared to the prior month."
    	)
    	& UNICHAR(10) & UNICHAR(10)

    	& "• Operating Margin "
    	& IF(
        	MarginMoM >= 0,
        	"improved by "
            	& FORMAT(ABS(MarginMoM), "0.00")
            	& " pp, reflecting improved operating efficiency.",

        	"declined by "
            	& FORMAT(ABS(MarginMoM), "0.00")
            	& " pp, indicating increased operating costs."
    	)
    	& UNICHAR(10) & UNICHAR(10)

    	& "• Return Rate "
    	& IF(
        	ReturnRateMoM < 0,
        	"improved by "
            	& FORMAT(ABS(ReturnRateMoM), "0.00")
            	& " pp, contributing positively to overall performance.",

        	"worsened by "
            	& FORMAT(ABS(ReturnRateMoM), "0.00")
            	& " pp and should be monitored closely."
    	)
)
```
**Purpose:** 
Generates dynamic business commentary based on month-over-month financial performance.

---
# Waterfall Analysis
## Waterfall Value
```DAX
Waterfall Value =
SWITCH(
	SELECTEDVALUE('Waterfall Steps'[Step]),
	"Gross Revenue", [Total Gross Revenue],
	"Refunds", - [Total Refund Amount],
	"COGS", - [COGS (Product Cost)],
	"Selling Fees", - [Total Selling Fees],
	"FBA Fees", - [Total FBA Fees],
	"Ad Spend", - [Total Ad Spend (Combined)],
	"Refunds", - [Total Refund Amount],
	"Refund Fees", [Total Refund Fees]
)
```
**Purpose:** 
Provides dynamic values for the P&L waterfall chart.

**Business Meaning:** 
Explains how Gross Revenue is transformed into Operating Profit by visualizing each major cost and profitability component.

---
# Business Value
These measures support:
- Dynamic P&L reporting.
- Financial KPI switching.
- Executive scorecards.
- Automated business insights.
- Margin analysis.
- Return impact analysis.
- Profitability monitoring.
- Waterfall chart visualization.
- Decision support and executive reporting.
