# 08 Time Intelligence Measures
This folder contains measures used for trend analysis, period-over-period comparisons, growth monitoring, and executive performance reporting.

The measures support Month-to-Date (MTD), Year-to-Date (YTD), Month-over-Month (MoM), Quarter-over-Quarter (QoQ), and Year-over-Year (YoY) analysis.

---
# Period-to-Date Analysis
## Gross Revenue MTD
```DAX
Gross Revenue MTD =
TOTALMTD(
	[Total Gross Revenue],
	dim_date[full_date]
)
```
**Purpose:** 
Calculates Gross Revenue accumulated from the beginning of the current month.

---
## Gross Revenue YTD
```DAX
Gross Revenue YTD =
TOTALYTD(
	[Total Gross Revenue],
	dim_date[full_date]
)
```
**Purpose:** 
Calculates Gross Revenue accumulated from the beginning of the year.

---
## Gross Revenue Prior Year YTD
```DAX
Gross Revenue Prior Year YTD =
CALCULATE(
	[Total Gross Revenue],
	DATESYTD(
    	SAMEPERIODLASTYEAR(dim_date[full_date])
	)
)
```
**Purpose:** 
Calculates YTD Gross Revenue for the previous year.

---
# Prior Period Measures
## Gross Revenue Prior Year
```DAX
Gross Revenue Prior Year =
CALCULATE(
	[Total Gross Revenue],
	SAMEPERIODLASTYEAR(dim_date[full_date])
)
```
**Purpose:** 
Returns Gross Revenue for the equivalent period in the previous year.

---
## Gross Revenue Prior Month
```DAX
Gross Revenue Prior Month =
CALCULATE(
	[Total Gross Revenue],
	PREVIOUSMONTH(dim_date[full_date])
)
```
**Purpose:** 
Returns Gross Revenue from the previous month.

---
## Refund Amount Prior Year
```DAX
Refund Amount Prior Year =
CALCULATE(
	[Total Refund Amount],
	SAMEPERIODLASTYEAR(dim_date[full_date])
)
```
**Purpose:** 
Returns total refund amount for the same period in the previous year.

---
# Year-over-Year Analysis
## Gross Revenue YoY %
```DAX
Gross Revenue YoY % =
IF(
	NOT HASONEVALUE(dim_date[year_number]),
	BLANK(),

	VAR CurrentSales = [Total Gross Revenue]
	VAR PrevSales = [Gross Revenue Prior Year]

	RETURN
	IF(
    	ISBLANK(PrevSales),
    	BLANK(),
    	DIVIDE(CurrentSales - PrevSales, PrevSales)
	)
)
```
**Purpose:** 
Measures year-over-year revenue growth.

---
## Refund Amount YoY %
```DAX
Refund Amount YoY % =
IF(
	HASONEVALUE(dim_date[year_number]),

	VAR CurrentR = [Total Refund Amount]
	VAR PrevR = [Refund Amount Prior Year]

	RETURN
	IF(
    	ISBLANK(PrevR),
    	BLANK(),
    	DIVIDE(CurrentR - PrevR, PrevR)
	)
)
```
**Purpose:** 
Measures year-over-year growth in refunds.

---
## Returned Units YoY %
```DAX
Returned Units YoY % =
IF(
	HASONEVALUE(dim_date[year_number]),

	VAR CurrentValue = [Total Returned Units]
	VAR PreviousValue =
    	CALCULATE(
        	[Total Returned Units],
        	DATEADD(dim_date[full_date], -1, YEAR)
    	)

	RETURN
	IF(
    	ISBLANK(PreviousValue),
    	BLANK(),
    	DIVIDE(CurrentValue - PreviousValue, PreviousValue)
	)
)
```
**Purpose:** 
Measures year-over-year growth in returned units.

---
# Month-over-Month Analysis
## Gross Revenue MoM %
```DAX
Gross Revenue MoM % =
IF(
	HASONEVALUE(dim_date[year_number])
	&& HASONEVALUE(dim_date[month_name]),

	VAR Current_ = [Total Gross Revenue]
	VAR Previous =
	CALCULATE(
    	[Total Gross Revenue],
    	PREVIOUSMONTH(dim_date[full_date])
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	DIVIDE(Current_ - Previous, Previous)
	)
)
```
**Purpose:** 
Measures month-over-month revenue growth.

---
## NetSales MoM %
```DAX
NetSales MoM % =
IF(
	HASONEVALUE(dim_date[year_number])
	&& HASONEVALUE(dim_date[month_name]),

	VAR Current_ = [Net Sales]
	VAR Previous =
	CALCULATE(
    	[Net Sales],
    	PREVIOUSMONTH(dim_date[full_date])
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	DIVIDE(Current_ - Previous, Previous)
	)
)
```
**Purpose:** 
Measures month-over-month Net Sales growth.

---
## Operating Profit MoM %
```DAX
Operating Profit MoM % =
IF(
	HASONEVALUE(dim_date[year_number])
	&& HASONEVALUE(dim_date[month_name]),

	VAR Current_ = [Operating Profit (EBIT)]
	VAR Previous =
	CALCULATE(
    	[Operating Profit (EBIT)],
    	PREVIOUSMONTH(dim_date[full_date])
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	DIVIDE(Current_ - Previous, Previous)
	)
)
```
**Purpose:** 
Measures month-over-month Operating Profit growth.

---
## Orders MoM %
```DAX
Orders MoM % =
IF(
	HASONEVALUE(dim_date[year_number])
	&& HASONEVALUE(dim_date[month_name]),

	VAR Current_ = [Total Orders]
	VAR Previous =
	CALCULATE(
    	[Total Orders],
    	PREVIOUSMONTH(dim_date[full_date])
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	DIVIDE(Current_ - Previous, Previous)
	)
)
```
**Purpose:** 
Measures month-over-month order growth.

---
# Margin & Rate Variance Analysis
## Operating Margin MoM (pp)
```DAX
Operating Margin MoM (pp) =
IF(
	HASONEVALUE(dim_date[year_number])
	&& HASONEVALUE(dim_date[month_name]),

	VAR Current_ = [Operating Margin %]
	VAR Previous =
	CALCULATE(
    	[Operating Margin %],
    	DATEADD(dim_date[full_date], -1, MONTH)
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	(Current_ - Previous) * 100
	)
)
```
**Purpose:** 
Measures month-over-month change in Operating Margin expressed in percentage points.

---
## Return Rate MoM (pp)
```DAX
Return Rate MoM (pp) =
IF(
	HASONEVALUE(dim_date[year_number])
	&& HASONEVALUE(dim_date[month_name]),

	VAR Current_ = [Return Rate %]

	VAR Previous =
    	CALCULATE(
        	[Return Rate %],
        	DATEADD(dim_date[full_date], -1, MONTH)
    	)

	RETURN
    	IF(
        	ISBLANK(Previous),
        	BLANK(),
        	(Current_ - Previous) * 100
    	)
)
```
**Purpose:** 
Measures month-over-month change in Return Rate expressed in percentage points.

---
# Quarter-over-Quarter Analysis
## Gross Revenue QoQ %
```DAX
Gross Revenue QoQ % =
IF(
	NOT HASONEVALUE(dim_date[year_number]),
	BLANK(),

	VAR Current_ = [Total Gross Revenue]
	VAR Previous =
	CALCULATE(
    	[Total Gross Revenue],
    	PREVIOUSQUARTER(dim_date[full_date])
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	DIVIDE(Current_ - Previous, Previous)
	)
)
```
**Purpose:** 
Measures quarter-over-quarter revenue growth.

---
# Executive Reporting Measures
## Gross Revenue MoM % Scorecard
```DAX
Gross Revenue MoM % Scorecard =
IF(
	ISINSCOPE(dim_date[month_name]),

	VAR Current_ = [Total Gross Revenue]
	VAR Previous =
	CALCULATE(
    	[Total Gross Revenue],
    	PREVIOUSMONTH(dim_date[full_date])
	)

	RETURN
	IF(
    	ISBLANK(Previous),
    	BLANK(),
    	DIVIDE(Current_ - Previous, Previous)
	)
)
```

**Purpose:** 
Provides a MoM growth metric optimized for KPI scorecards.

---
## Revenue Growth FY2025 vs FY2024 %
```DAX
Revenue Growth FY2025 vs FY2024 % =
VAR GrossRevenue2025 =
	CALCULATE(
    	[Total Gross Revenue],
    	dim_date[year_number] = 2025
	)

VAR GrossRevenue2024 =
	CALCULATE(
    	[Total Gross Revenue],
    	dim_date[year_number] = 2024
	)

RETURN
DIVIDE(
	GrossRevenue2025 - GrossRevenue2024,
	GrossRevenue2024
)
```
**Purpose:** 
Measures total revenue growth between FY2024 and FY2025.

---
# Business Value
These measures support:
- MTD reporting
- YTD reporting
- YoY analysis
- MoM analysis
- QoQ analysis
- Executive KPI scorecards
- Revenue growth monitoring
- Profitability trend analysis
- Return performance analysis
- Strategic planning and forecasting
