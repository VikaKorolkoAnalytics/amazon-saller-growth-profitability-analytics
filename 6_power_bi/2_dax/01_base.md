# 01 Base Measures
This folder contains foundational business measures used throughout the semantic model and serves as the basis for financial, marketing, product, and profitability analysis.

---
## Total Gross Revenue
```DAX
Total Gross Revenue =
SUM(fact_amazon_sales[line_revenue])
```
**Purpose:**  
Calculates total sales revenue before returns, product costs, and other deductions.

---
## Total Orders
```DAX
Total Orders =
DISTINCTCOUNT(fact_amazon_sales[order_id])
```
**Purpose:** 
Calculates the number of unique customer orders.

---
## Total Units Sold
```DAX
Total Units Sold =
SUM(fact_amazon_sales[quantity])
```

**Purpose:**
Calculates the total quantity of units sold.

---
## Unit Price
```DAX
Unit Price =
DIVIDE(
    [Total Gross Revenue],
    [Total Units Sold]
)
```
**Purpose:** 
Calculates the average selling price per unit.

---
## Average Order Value (AOV)
```DAX
Average Order Value (AOV) =
DIVIDE(
    [Total Gross Revenue],
    [Total Orders]
)
```
**Purpose:**  
Calculates the average revenue generated per customer order.

---
## COGS (Product Cost)
```DAX
COGS (Product Cost) =
SUMX(
    fact_amazon_sales,
    fact_amazon_sales[quantity] 
    * fact_amazon_sales[cost_per_unit]
)
```
**Purpose:** 
Calculates total Cost of Goods Sold (COGS) based on unit quantity and product cost.

---
## Total Selling Fees
```DAX
Total Selling Fees =
- SUM(fact_amazon_sales[selling_fees])
```
**Purpose:**  
Calculates total Amazon selling fees.

---
## Total FBA Fees
```DAX
Total FBA Fees =
- SUM(fact_amazon_sales[fba_fees])
```
**Purpose:**  
Calculates total Amazon fulfillment (FBA) fees.