# Calculated Tables
This folder contains calculated tables used to support financial reporting, dynamic KPI selection, waterfall analysis, strategic planning, and executive reporting.

These tables extend the semantic model beyond traditional dimensions and facts by enabling dynamic report behavior and business storytelling.

---
# Waterfall Analysis
## Waterfall Steps
```DAX
Waterfall Steps =
DATATABLE(
	"Step", STRING,
	"Order", INTEGER,
	{
    	{"Gross Revenue", 1},
    	{"Refunds", 2},
    	{"COGS", 3},
    	{"Selling Fees", 4},
    	{"FBA Fees", 5},
    	{"Ad Spend", 6},
    	{"Refund Fees", 7}
	}
)
```
**Purpose:** 
Provides the ordered categories used in the Profit & Loss waterfall chart.

**Business Meaning:** 
Allows the report to visualize how Gross Revenue is transformed into Operating Profit by displaying each cost and profitability component in sequence.

---
# Financial KPI Selection
## P&L Financial Performance
```DAX
P&L Financial Performance =
DATATABLE(
	"Metric", STRING,
	"Sort Order", INTEGER,
	{
    	{"Net Sales", 1},
    	{"Gross Profit", 2},
    	{"Operating Profit", 3}
	}
)
```
**Purpose:** 
Provides a metric selector for financial performance analysis.

**Business Meaning:** 
Allows users to dynamically switch between key financial metrics without creating separate visuals.

---
# Efficiency KPI Selection
## P&L Efficiency Metrics
```DAX
P&L Efficiency Metrics =
DATATABLE(
	"Metric", STRING,
	"Sort Order", INTEGER,
	{
    	{"Gross Margin", 1},
    	{"Operating Margin", 2},
    	{"Return Rate", 3}
	}
)
```
**Purpose:** 
Provides a metric selector for operational efficiency analysis.

**Business Meaning:** 
Allows users to dynamically evaluate margin performance and return behavior using a single visual.

---
# Strategic Planning
## Growth Opportunities
```DAX
Growth Opportunities =
DATATABLE(
	"#", STRING,
	"Priority", STRING,
	"Opportunity", STRING,
	"Expected Impact", STRING,
	"Business Area", STRING,
	"Action", STRING,
	{
    	{"1", "🔴 High", "Reduce return rate","High", "Returns", "Investigate key return drivers and implement targeted corrective actions"},
    	{"2", "🔴 High", "Improve inventory planning", "High","Supply chain", "Align inventory planning with seasonal demand patterns and top-performing colors"},
    	{"3", "🔴 High", "Protect operating margin", "High", "Finance", "Monitor product costs and optimize pricing and inventory decisions to protect profitability"},
    	{"4", "🟡 Medium", "Reallocate advertising budget", "Medium", "Marketing", "Focus advertising spend on top-performing colors and revenue-generating states"},
    	{"5", "🟡 Medium", "Expand geographic reach", "Medium", "Sales", "Identify growth opportunities beyond top-performing states"},
    	{"6", "🟢 Low", "Optimize low-performing colors", "Medium", "Product", "SKU rationalization and portfolio review"}
	}
)
```
**Purpose:** 
Stores strategic business recommendations and growth opportunities used in the Planning & Growth Strategy report page.

**Business Meaning:** 
Transforms analytical findings into actionable business recommendations and supports executive decision-making.

---
# Business Value
These calculated tables support:
- Dynamic KPI selection.
- Interactive financial reporting.
- Executive dashboards.
- Waterfall chart analysis.
- Strategic planning.
- Growth opportunity assessment.
- Profitability monitoring.
- Business storytelling.
- Decision support reporting.
