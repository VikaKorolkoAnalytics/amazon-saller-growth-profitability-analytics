# 03 Returns Measures
This folder contains measures used to analyze product returns, refund activity, and their impact on business performance and profitability.

---
## Total Returned Units
```DAX
Total Returned Units =
SUM(fact_amazon_returns[returned_quantity])
```
**Purpose:** 
Calculates the total quantity of units returned by customers.

---
## Total Refund Amount
```DAX
Total Refund Amount =
SUM(fact_amazon_returns[refund_amount])
```
**Purpose:** 
Calculates the total amount refunded to customers.

---
## Total Refund Fees
```DAX
Total Refund Fees =
SUM(fact_amazon_returns[refund_fees])
```
**Purpose:** 
Calculates Amazon refund fee reimbursements.

**Note:** 
Refund fees are stored as positive values and partially offset return-related losses.

---
## Return Rate %
```DAX
Return Rate % =
DIVIDE(
	[Total Returned Units],
	[Total Units Sold]
)
```
**Purpose:** 
Measures the percentage of sold units that were returned by customers.

---
## Business Value
These measures help evaluate:
- Return behavior by product and location.
- Financial impact of refunds and return activity.
- Return trends over time.
- Operational opportunities to reduce return-related losses.
- Impact of returns on overall profitability.
