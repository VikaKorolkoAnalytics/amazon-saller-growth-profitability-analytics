/* ================
CREATE FACT TABLES
=================*/

--Fact amazon sales
CREATE TABLE dbo.fact_amazon_sales (
date_key       INT NOT NULL,
product_key    INT NOT NULL,
location_key   INT NOT NULL,
order_id       NVARCHAR(50),
quantity       INT,
line_revenue   DECIMAL(10,2),
selling_fees   DECIMAL(10,2),
fba_fees       DECIMAL(10,2),
cost_per_unit  DECIMAL(10,2),
source_system  NVARCHAR(50),

CONSTRAINT fk_fact_date FOREIGN KEY (date_key)
           REFERENCES dbo.dim_date (date_key),

CONSTRAINT fk_fact_product FOREIGN KEY (product_key)
           REFERENCES dbo.dim_product (product_key),

CONSTRAINT fk_fact_location FOREIGN KEY (location_key)
           REFERENCES dbo.dim_location (location_key)
);

--Fact amazon returns
CREATE TABLE dbo.fact_amazon_returns (
date_key          INT NOT NULL,
product_key       INT NOT NULL,
location_key      INT NOT NULL,
order_id          NVARCHAR(50) NOT NULL,
returned_quantity INT NOT NULL,
refund_amount     DECIMAL(10,2) NOT NULL,
refund_fees       DECIMAL(10,2),
cost_per_unit     DECIMAL(10,2),
source_system     NVARCHAR(50),

CONSTRAINT fk_returns_date FOREIGN KEY (date_key)
           REFERENCES dbo.dim_date (date_key),

CONSTRAINT fk_returns_product FOREIGN KEY (product_key)
           REFERENCES dbo.dim_product (product_key),

CONSTRAINT fk_returns_location FOREIGN KEY (location_key)
           REFERENCES dbo.dim_location (location_key),

CONSTRAINT uq_fact_returns UNIQUE (order_id, product_key, location_key, date_key)
);

--Fact amazon Ads
CREATE TABLE dbo.fact_amazon_ads (
date_key INT NOT NULL,
campaign_key INT NOT NULL,
impressions INT,
clicks INT,
spend DECIMAL(10,2),
source_system NVARCHAR(50),

CONSTRAINT fk_ads_date FOREIGN KEY (date_key)
    REFERENCES dbo.dim_date (date_key),

CONSTRAINT fk_ads_campaign FOREIGN KEY (campaign_key)
    REFERENCES dbo.dim_campaign (campaign_key),

CONSTRAINT uq_fact_amazon_ads UNIQUE (campaign_key, date_key)
);

--Fact meta Ads
CREATE TABLE dbo.fact_meta_ads (
date_key INT NOT NULL,
campaign_key INT NOT NULL,
impressions INT,
clicks INT,
spend DECIMAL(10,2),
source_system NVARCHAR(50),

CONSTRAINT fk_meta_date FOREIGN KEY (date_key)
    REFERENCES dbo.dim_date (date_key),

CONSTRAINT fk_meta_campaign FOREIGN KEY (campaign_key)
    REFERENCES dbo.dim_campaign (campaign_key),

CONSTRAINT uq_fact_meta_ads UNIQUE (campaign_key, date_key)
);