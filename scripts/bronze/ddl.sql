/* =========================================================
   BRONZE LAYER TABLE INITIALIZATION SCRIPT
   =========================================================

   PURPOSE:
   This script creates raw ingestion tables for the Bronze
   layer of the data platform. The Bronze layer stores data
   exactly as received from source systems with no business
   transformations applied.

   DESIGN PRINCIPLES:
   - Raw data storage (no transformations or cleansing)
   - Schema mirrors source systems as closely as possible
   - Append-only ingestion structure
   - Supports traceability and replayability
   - Each table represents a direct source system entity

   SAFETY:
   - Existing tables are dropped before recreation
   - Uses OBJECT_ID checks to prevent script failure on rerun
   - Intended for controlled development or refresh environments

   SOURCE SYSTEMS COVERED:
   - CRM (customer, product, sales data)
   - ERP (location, customer enrichment, product catalog)

   TABLES INCLUDED:
   - crm_cust_info        → Customer master data
   - crm_prd_info         → Product master data
   - crm_sales_details    → Sales transaction data
   - erp_loc_a101         → Customer location reference data
   - erp_cust_az12        → Customer demographic/identity data
   - erp_px_cat_g1v2      → Product category hierarchy data

   NOTE:
   All transformations, joins, and business logic should be
   applied in the Silver layer, not here.

========================================================= */



IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO
