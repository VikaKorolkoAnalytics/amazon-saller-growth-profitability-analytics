/* ==============================
CREATE DIMENSION & MAPPING TABLES
============================== */

--Dim_state
CREATE TABLE dbo.dim_state (
state_code CHAR(2) NOT NULL PRIMARY KEY,
state_name NVARCHAR(50) NOT NULL,

CONSTRAINT uq_state_name UNIQUE (state_name)
);

--Dim_location
CREATE TABLE dbo.dim_location (
location_key INT IDENTITY(1,1) PRIMARY KEY,
state_code   CHAR(2) NOT NULL,                 
city         NVARCHAR(50) NOT NULL,

CONSTRAINT fk_dim_location_state
   FOREIGN KEY (state_code) REFERENCES dbo.dim_state (state_code),
   
CONSTRAINT uq_dim_location UNIQUE (state_code, city)
);

--Create product mapping table for ETL transformation in dim_product 
CREATE TABLE dbo.product_mapping (
sku          NVARCHAR(50) PRIMARY KEY,
product_name NVARCHAR(100),
color        NVARCHAR(20)
);

--Dim_product
CREATE TABLE dbo.dim_product (
product_key    INT IDENTITY(1,1) PRIMARY KEY,
sku            NVARCHAR(20) NOT NULL,
product_name   NVARCHAR(100) NOT NULL, 
color          NVARCHAR(20) NULL                  

CONSTRAINT uq_dim_product_sku UNIQUE (sku)
);

--Dim_campaign
CREATE TABLE dbo.dim_campaign (
campaign_key   INT IDENTITY(1,1) PRIMARY KEY,
campaign_id    NVARCHAR(50) NOT NULL,
campaign_name  NVARCHAR(255) NOT NULL,
channel        NVARCHAR(50) NOT NULL,
source_system  NVARCHAR(50) NOT NULL

CONSTRAINT uq_dim_compaign UNIQUE (campaign_id)
);

--Dim_date
CREATE TABLE dbo.dim_date (
date_key      INT PRIMARY KEY, --YYYYMMDD
full_date     DATE NOT NULL,
year_number   INT NOT NULL,
month_number  INT NOT NULL,
month_name    NVARCHAR(20) NOT NULL,
quarter       INT NOT NULL,
day_of_month  INT NOT NULL,
day_name      NVARCHAR(20) NOT NULL,
day_of_week   INT NOT NULL,     --1 = Monday, 7 = Sunday (example)
is_weekend    BIT NOT NULL,

CONSTRAINT uq_dim_date UNIQUE (full_date)
);




