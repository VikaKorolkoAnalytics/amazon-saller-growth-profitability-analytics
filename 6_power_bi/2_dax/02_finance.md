# 02 Finance Measures
This folder contains core financial measures used to support profitability analysis, executive reporting, and the Profit & Loss (P&L) framework.

### P&L Structure
```text
    Gross Revenue
        ↓
     Returns
        ↓
    Net Sales
        ↓
       COGS
        ↓
   Gross Profit
        ↓
Operating Expenses
        ↓
Operating Profit (EBIT)
```
---
## Net Sales
```DAX
Net Sales =
[Total Gross Revenue] - [Total Refund Amount]
```
**Purpose:** 
Calculates revenue retained after customer refunds.

---
## Gross Profit
```DAX
Gross Profit =
[Net Sales] - [COGS (Product Cost)]
```
**Purpose:** 
Measures profitability after deducting product costs from Net Sales.

---
## Total Operating Expenses
```DAX
Total Operating Expenses =
[Selling Fees]
+ [FBA Fees]
+ [Total Ad Spend (Combined)]
- [Refund Fees]
```
**Purpose:** 
Calculates total operating expenses, including Amazon fees and advertising costs, while accounting for refund fee compensation.

---
## Operating Profit (EBIT)
```DAX
Operating Profit (EBIT) =
[Gross Profit]
- [Total Operating Expenses]
```
**Purpose:** 
Measures operating profitability before taxes and financing costs.

---
## Gross Margin %

```DAX
Gross Margin % =
DIVIDE(
	[Gross Profit],
	[Net Sales]
)
```
**Purpose:** 
Measures product-level profitability by showing the percentage of Net Sales retained after product costs.

---
## Operating Margin %
```DAX
Operating Margin % =
DIVIDE(
	[Operating Profit (EBIT)],
	[Net Sales]
)
```
**Purpose:** 
Measures overall business efficiency by showing the percentage of Net Sales retained after all operating expenses.

---
## Profit Per Unit
```DAX
Profit Per Unit =
DIVIDE(
	[Gross Profit],
	[Total Units Sold]
)
```
**Purpose:** 
Calculates the average gross profit generated per unit sold.
