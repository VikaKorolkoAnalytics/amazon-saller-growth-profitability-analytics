# 05 Combined Marketing Measures
This folder contains measures used to evaluate overall marketing performance by combining Amazon Ads and Meta Ads data into a unified reporting framework.

The measures support advertising efficiency analysis, spend allocation, and marketing contribution to business performance.

---
## Total Ad Spend (Combined)
```DAX
Total Ad Spend (Combined) =
SUM(fact_amazon_ads[spend])
+
SUM(fact_meta_ads[spend])
```
**Purpose:** 
Calculates total advertising spend across Amazon Ads and Meta Ads.

---
## Total Impressions
```DAX
Total Impressions =
SUM(fact_amazon_ads[impressions])
+
SUM(fact_meta_ads[impressions])
```
**Purpose:** 
Calculates total advertising impressions across all marketing channels.

---
## Total Clicks
```DAX
Total Clicks =
SUM(fact_amazon_ads[clicks])
+
SUM(fact_meta_ads[clicks])
```
**Purpose:** 
Calculates total advertising clicks generated across all marketing channels.

---
## CTR (Click-Through Rate)
```DAX
CTR (Click-Through Rate) =
DIVIDE(
	[Total Clicks],
	[Total Impressions]
)
```
**Purpose:** 
Measures the percentage of impressions that resulted in clicks.

**Business Meaning:** 
Higher CTR generally indicates stronger audience engagement and more effective advertising creatives.

---
## CPC (Cost Per Click)
```DAX
CPC (Cost Per Click) =
DIVIDE(
	[Total Ad Spend (Combined)],
	[Total Clicks]
)
```
**Purpose:** 
Calculates the average advertising cost incurred for each click.

**Business Meaning:** 
Measures traffic acquisition efficiency.

---
## TACoS (Total Advertising Cost of Sales)
```DAX
TACoS =
DIVIDE(
	[Total Ad Spend (Combined)],
	[Net Sales]
)
```
**Purpose:** 
Measures advertising spend as a percentage of total net sales.

**Business Meaning:** 
Evaluates how much advertising contributes to overall business growth and profitability.

---
## Share of Spend
```DAX
Share of Spend =
DIVIDE(
	[Total Ad Spend (Combined)],
	CALCULATE(
    	[Total Ad Spend (Combined)],
    	ALL(dim_campaign[campaign_name])
	)
)
```
**Purpose:** 
Calculates the percentage of total advertising spend allocated to each campaign.

**Business Meaning:** 
Supports budget allocation analysis and identification of campaigns consuming the largest share of advertising investment.

---
## Business Value
These measures help evaluate:
- Overall marketing efficiency.
- Advertising spend allocation.
- Cross-channel marketing performance.
- Traffic generation effectiveness.
- Advertising contribution to sales.
- Budget optimization opportunities.
- Executive marketing reporting.
