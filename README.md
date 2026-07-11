# Amazon Seller Growth & Profitability Analytics

## Project Overview
This project presents an end-to-end Business Intelligence solution designed to transform raw ecommerce sales, returns, and advertising data into actionable business insights through ETL, SQL staging, Hybrid Star Schema modeling, DAX analytics, performance optimization, and Power BI Service deployment.

The solution analyzes sales performance, profitability, marketing efficiency, product performance, return management, and strategic growth opportunities across FY2024–FY2025.

## Business Context
An Amazon-based ecommerce business generated sales, returns, and advertising data across multiple operational systems and exports.

The business lacked a centralized reporting solution, making it difficult to obtain a complete view of sales performance, profitability, marketing efficiency, product performance, and return activity.

To support data-driven decision-making, the business required a unified analytics platform capable of consolidating data from multiple sources and providing both operational and strategic insights using FY2024–FY2025 data.

## Project Objectives
The objective of this project was to design and develop an end-to-end Business Intelligence solution that transforms raw ecommerce data into actionable business insights.

### Business Focus Areas
- Revenue Growth
- Profitability Analysis
- Marketing Performance
- Return Management
- Product Optimization
- Strategic Planning

### Key Objectives
- Consolidate sales, returns, and advertising data into a centralized reporting solution.
- Build a scalable Hybrid Star Schema model for analytical reporting.
- Develop reusable DAX measures for KPI tracking and business analysis.
- Analyze sales performance and revenue trends across FY2024–FY2025.
- Monitor profitability using Net Sales, Gross Profit, Operating Profit, and margin metrics.
- Evaluate advertising efficiency across Amazon Ads and Meta Ads.
- Track return activity and measure its impact on profitability.
- Identify top-performing and underperforming products.
- Analyze business trends using YoY, MoM, QoQ, and YTD calculations.
- Deliver strategic insights and recommendations to support business growth and profitability.

## Business Questions Addressed
The solution was designed to answer key business questions relevant to ecommerce performance, profitability, and growth.

| Business Question | Solution |
|-------------------|-----------|
| How profitable is the business after all expenses? | Built a P&L framework incorporating revenue, returns, product costs, Amazon fees, and advertising expenses. |
| Which products contribute the most revenue and profit? | Performed product-level revenue, gross profit, margin, and contribution analysis. |
| How do returns impact overall business performance? | Measured return rates, refund amounts, and their effect on profitability. |
| How effective is advertising spend across channels? | Evaluated CTR, CPC, Total Ad Spend, and TACoS across Amazon Ads and Meta Ads. |
| How do seasonality and business trends impact performance? | Analyzed revenue and profitability using YoY, MoM, QoQ, and YTD metrics. |
| Which products and business areas require optimization? | Identified low-performing products, high return rates, and profitability risks. |
| Where are the biggest opportunities for future growth? | Developed SWOT analysis, growth opportunities, and strategic recommendations. |
| How can executives monitor business performance in one place? | Built a centralized BI dashboard integrating sales, marketing, returns, product, and financial analytics. |

## Skills Demonstrated
### Data Engineering & Modeling
- Power Query ETL
- SQL Data Transformation
- Data Modeling
- Hybrid Star Schema Design


### Business Intelligence & Analytics
- Power BI Dashboard Development
- DAX Development
- KPI Design & Business Metrics
- Time Intelligence (YoY, MoM, QoQ, YTD)
- Data Visualization


### Performance & Deployment
- Performance Optimization
- DAX Studio Validation
- Power BI Service Deployment


### Business & Strategic Analysis
- Business Analysis
- Profitability Analysis
- Strategic Planning

## Tools & Technologies
### Data Sources
- Amazon Sales CSV Exports
- Amazon Advertising CSV Exports
- Meta Advertising CSV Exports

### Data Preparation
- Power Query (M)
- Microsoft Excel

### Data Storage & Modeling
- SQL Server
- Hybrid Star Schema

### Analytics & Reporting
- Power BI Desktop
- DAX
- Power BI Service
- Power BI Mobile Layouts

### Performance Validation
- Power BI Performance Analyzer
- DAX Studio

## Solution Architecture
[![Solution Architecture](./1_architecture/solution_archtecture.png)](./1_architecture/solution_archtecture.png)
The following diagram illustrates the end-to-end data pipeline, from raw data ingestion through ETL, SQL modeling, analytical reporting, and Power BI Service deployment.

- Raw data ingested from Amazon Sales, Amazon Ads, and Meta Ads CSV exports.
- Power Query used for ETL, data cleansing, and transformation.
- SQL staging layer supports initial and incremental monthly data loads.
- Hybrid Star Schema model implemented to support scalable analytical reporting.
- Power BI Semantic Model contains reusable DAX measures, KPI calculations, and Time Intelligence logic.
- Report deployed to Power BI Service using Import Mode.

## Data Sources
The solution integrates data from multiple ecommerce data sources:

- Amazon Sales exports
- Amazon Advertising exports
- Meta Advertising exports

To demonstrate the data structure and reporting workflow, a subset of source files is included in this repository:

- 3 Amazon Sales sample files
- 3 Amazon Advertising sample files
- 1 Meta Advertising sample file

Raw files are provided for educational and portfolio purposes. Brand-specific identifiers have been excluded from the published project.

Additional source files are available via Google Drive: https://drive.google.com/drive/folders/1AND9cY_Zr5OKwUMH2Q_f9Ml89IDLZYZD?usp=sharing
