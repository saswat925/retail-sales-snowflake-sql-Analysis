-- ============================================================
-- RETAIL SALES ANALYSIS
-- ============================================================
-- Source Table : WAREHOUSE.PUBLIC.RETAIL_SALES (307,645 rows)
-- Cleaned Table: WAREHOUSE.PUBLIC.RETAILS_SALES_CLEAN (271,207 rows)
-- Date Range   : 2017 - 2020 (January & December only)
-- Categories   : Liquor, Wine, Beer, Non-Alcohol, Kegs, etc.
-- ============================================================

CREATE DATABASE WAREHOUSE;
USE DATABASE WAREHOUSE;
USE SCHEMA PUBLIC;

-- ============================================================
-- SECTION 1: DATA EXPLORATION & CLEANING
-- ============================================================


-- 1.1 Preview Raw Data
-- Quick look at the first 10 rows to understand data structure.
SELECT *
FROM retail_sales
LIMIT 10;

-- 1.2 Duplicate Check
-- Identifies exact duplicate rows across all columns.
-- Found ~36K duplicates (307,645 raw → 271,207 clean).
SELECT
    *,
    COUNT(*) AS duplicate_count
FROM retail_sales
GROUP BY ALL
HAVING COUNT(*) > 1;
-- 1.3 Create Clean Table (Remove Duplicates)
-- Uses SELECT DISTINCT to eliminate all duplicate rows.
CREATE OR REPLACE TABLE RETAILS_SALES_CLEAN AS SELECT DISTINCT * FROM RETAIL_SALES;

--null handling
select count(*) as null_cont from retails_sales_clean
where retail_sales is null
---null replace with 0
update retails_sales_clean
set retail_sales = 0
where retail_sales is null

select * from retails_sales_clean

---to check data type of all columns from retail_sales_clean
desc table retails_sales_clean

--null check 
select coalesce(supplier, 'Unknown') from retails_sales_clean;

--check nulls across all columns
select
    count(*) as total_rows,
    count(*) - count(year) as year_nulls,
    count(*) - count(month) as month_nulls,
    count(*) - count(supplier) as supplier_nulls,
    count(*) - count(item_code) as item_code_nulls,
    count(*) - count(item_description) as item_description_nulls,
    count(*) - count(item_type) as item_type_nulls,
    count(*) - count(retail_sales) as retail_sales_nulls,
    count(*) - count(retail_transfers) as retail_transfers_nulls,
    count(*) - count(warehouse_sales) as warehouse_sales_nulls
from retails_sales_clean;


--permant null replace
update retails_sales_clean
set supplier = 'Unknown'
where supplier is null;



















-- 1.4 Verify Cleaning Results
-- Raw: 307,645 rows → Cleaned: 271,207 rows (36,438 duplicates removed)
SELECT * FROM RETAILS_SALES_CLEAN;
SELECT DISTINCT COUNT(ITEM_CODE) FROM RETAILS_SALES_CLEAN;
SELECT COUNT(*) FROM RETAIL_SALES;          -- 307,645
SELECT COUNT(*) FROM RETAILS_SALES_CLEAN;   -- 271,207

SELECT * FROM RETAILS_SALES_CLEAN;

-- ============================================================
-- SECTION 2: DATA QUALITY CHECKS
-- ============================================================


-- 2.1 Null Value Check (Key Columns)
-- Counts non-null values for critical columns to detect missing data.
SELECT COUNT(*) total_rows,
       COUNT(YEAR) year_count,
       COUNT(MONTH) month_count,
       COUNT(SUPPLIER) supplier_count,
       COUNT(RETAIL_SALES) sales_count FROM RETAILS_SALES_CLEAN;

-- 2.2 Distinct Months
-- Check which months exist in the data (only January & December).
SELECT DISTINCT MONTH FROM RETAILS_SALES_CLEAN;

-- 2.3 Data Types Inspection
-- Verify column types for all fields in the cleaned table.
DESC TABLE RETAILS_SALES_CLEAN;


-- ============================================================
-- SECTION 3: BUSINESS OVERVIEW
-- ============================================================


-- 3.1 Total Business Overview
-- Aggregates total retail sales, retail transfers, and warehouse sales.
-- Retail: $2.16M | Transfers: $2.13M | Warehouse: $7.70M
SELECT SUM(RETAIL_SALES) AS total_retail_sales,
       SUM(RETAIL_TRANSFERS) AS total_retail_transfers,
       SUM(WAREHOUSE_SALES) AS total_warehouse_sales FROM RETAILS_SALES_CLEAN;
-- 3.2 Month-Wise Sales Trend
-- Compares sales between January and December.
-- January ($1.93M) dominates over December ($226K) — ~8.5x higher.
SELECT MONTH, SUM(RETAIL_SALES) AS sales FROM RETAILS_SALES_CLEAN
GROUP BY MONTH
ORDER BY MONTH DESC;
-- ============================================================
-- SECTION 4: SUPPLIER PERFORMANCE
-- ============================================================


-- 4.1 Top 3 Suppliers by Sales
-- E&J Gallo Winery leads ($166K), followed by Diageo ($145K) & Constellation ($132K).
SELECT SUPPLIER, SUM(COALESCE(RETAIL_SALES, 0)) AS sales FROM RETAILS_SALES_CLEAN
GROUP BY SUPPLIER
ORDER BY sales DESC
LIMIT 3;
-- ============================================================
-- SECTION 5: PRODUCT ANALYSIS
-- ============================================================


-- 5.1 Top Products by Sales
-- Tito's Handmade Vodka 1.75L is the #1 product ($27.6K).
-- Followed by Corona Extra ($25K) and Heineken ($17.8K).
SELECT ITEM_DESCRIPTION, SUM(COALESCE(RETAIL_SALES, 0)) AS sales FROM RETAILS_SALES_CLEAN
GROUP BY ITEM_DESCRIPTION
ORDER BY sales DESC;
-- 5.2 Item Type Analysis
-- Liquor (37%) leads, followed by Wine (35%) and Beer (27%).
-- Kegs and Dunnage show $0 retail sales (warehouse-only items).
SELECT ITEM_TYPE, SUM(RETAIL_SALES) AS sales FROM RETAILS_SALES_CLEAN
GROUP BY ITEM_TYPE
ORDER BY sales DESC;
-- ============================================================
-- SECTION 6: YEAR-WISE GROWTH
-- ============================================================


-- 6.1 Year-Wise Sales Comparison
-- 2019 is the peak year ($959K), 2018 is lowest ($154K).
-- 2020 shows decline ($360K) — possibly COVID-19 impact.
SELECT YEAR, SUM(RETAIL_SALES) AS sales FROM RETAILS_SALES_CLEAN
GROUP BY YEAR
ORDER BY sales DESC;
-- ============================================================
-- SECTION 7: SUPPLIER DEEP DIVE
-- ============================================================


-- 7.1 Supplier Product Diversity vs Sales
-- Shows each supplier's product range and total sales.
-- E&J Gallo has 617 products but low avg sale ($15.59).
-- Crown Imports has only 67 products but highest avg ($67.77).
SELECT SUPPLIER, COUNT(DISTINCT ITEM_DESCRIPTION) AS product_count, SUM(RETAIL_SALES) AS sales FROM RETAILS_SALES_CLEAN
GROUP BY SUPPLIER
ORDER BY sales DESC;
--null count














       