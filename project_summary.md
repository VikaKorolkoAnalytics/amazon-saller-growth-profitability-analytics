# 🧾 Project Summary
## 🏗️ End-to-End BI Solution
Built an end-to-end BI solution using Power Query, SQL Server, and Power BI.
![Solution Architecture](./1_architecture/solution_archtecture.png)

---
## 🗄️ SQL & Data Modeling
- Designed a Hybrid Star Schema in SQL Server.
- Implemented incremental monthly data loading with SQL validation checks.
### SQL Scripts
- [SQL Staging Layer](./5_sql_scripts/1_staging/)
- [Create Dimension & Mapping Tables](./5_sql_scripts/2_data_modeling/2_create_dim_mapping_tables.sql)
- [Load Dimension & Mapping Tables](./5_sql_scripts/2_data_modeling/3_load_data_dim_mapping_tables.sql)
- [Create Fact Tables](./5_sql_scripts/2_data_modeling/4_create_fact_tables.sql)
- [Load Fact Tables](./5_sql_scripts/2_data_modeling/5_load_data_fact_tables.sql)
- [Post-Load Data Validation](./5_sql_scripts/2_data_modeling/6_post-load_validation_dim_mapping_fact_tables.sql)
- [Incremental Load Process](./5_sql_scripts/3_incremental_load/7_single_script_for_incremental_updates.sql)

![Hybrid Star Schema](./5_sql_scripts/8_hybrid_star_schema_er_diagram.png)

---
## 🧠 Power BI Semantic Model
Built a Power BI semantic model supporting Sales, Returns, Marketing, Product, P&L, Business Trends, and Strategic Planning analytics.
![Power BI Semantic Model](./6_power_bi/1_semantic_model/semantic_model.png)

---
##  📐 DAX Development
Developed 80+ DAX measures covering financial, marketing, product, and Time Intelligence analytics.
- [Base Measures](./6_power_bi/2_dax/01_base.md)
- [Finance Measures](./6_power_bi/2_dax/02_finance.md)
- [Returns Measures](./6_power_bi/2_dax/03_returns.md)
- [Product Measures](./6_power_bi/2_dax/04_product.md)
- [Combined Marketing Measures](./6_power_bi/2_dax/05_combined_marketing.md)
- [Amazon Ads Measures](./6_power_bi/2_dax/06_amazon_ads.md)
- [Meta Ads Measures](./6_power_bi/2_dax/07_meta_ads.md)
- [Time Intelligence Measures](./6_power_bi/2_dax/08_time_intelligence.md)
- [P&L Measures](./6_power_bi/2_dax/09_pnl.md)
- [Insights](./6_power_bi/2_dax/10_insights.md)
- [Calculated Tables](./6_power_bi/2_dax/11_calculated_tables.md)
- [Calculated Columns](./6_power_bi/2_dax/12_calculated_columns.md)

---
## 📁 Power BI Report File
[Amazon Seller Growth Profitability Analytics.pbix](./6_power_bi/4_pbix/amazon_seller_growth_profitability_analytics.pbix)

--- 
## ⚡ Performance Validation
Validated report performance using Power BI Performance Analyzer and DAX Studio.
- [Power BI Performance Analyzer](./7_performance_validation/1_power_bi_performance_analyzer/)
- [DAX Studio Server Timings Analysis](./7_performance_validation/2_dax_%20studio_server_timings/)
- [Performance Summary](./7_performance_validation/performance_summary.md)

---
## 📊 Dashboard Pages
### Executive Overview
![Overview](./8_power_bi_service/report_pages/1_overview.gif)
Provides a high-level summary of business performance, including revenue, profitability, returns, marketing spend, and key business KPIs.

### Sales Performance
![Sales](./8_power_bi_service/report_pages/2_sales.gif)
Analyzes sales trends, order activity, revenue distribution, and geographical performance across states and cities.

### Returns Analysis
![Returns](./8_power_bi_service/report_pages/3_returns.gif)
Monitors return activity, refund amounts, return rates, and their impact on overall business profitability.

### Product Performance
![Product](./8_power_bi_service/report_pages/4_product.gif)
Evaluates product profitability, revenue contribution, margin performance, and top-performing versus underperforming product colors.

### Marketing Performance
![Marketing](./8_power_bi_service/report_pages/5_marketing.gif)
Measures advertising performance across Amazon Ads and Meta Ads using CTR, CPC, TACoS, impressions, clicks, and spend metrics.

### Profit & Loss (P&L)
![P&L](./8_power_bi_service/report_pages/6_p_l.gif)
Provides a financial view of the business, including:
- Gross Revenue
- Net Sales
- Gross Profit
- Operating Expenses
- Operating Profit (EBIT)
- Gross Margin
- Operating Margin

### Business Trends
![Business Trends](./8_power_bi_service/report_pages/7_business_trends.gif)
Analyzes business performance using Time Intelligence calculations, including:
- MTD (Month-to-Date)
- YTD (Year-to-Date)
- MoM (Month-over-Month)
- QoQ (Quarter-over-Quarter)
- YoY (Year-over-Year)

---
## 📈 Business Outcomes
- Generated strategic business insights and growth recommendations.
- Built a Planning & Growth Strategy page to translate analytics into business actions.
### Planning & Growth Strategy
![Planning & Strategy](./8_power_bi_service/report_pages/8_planning_strategy.png)
Presents SWOT analysis, key business insights, growth opportunities, and strategic recommendations derived from the analytical findings.
