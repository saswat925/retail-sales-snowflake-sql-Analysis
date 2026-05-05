
# 🛒 Retail Sales Analysis | End-to-End Data Engineering on Snowflake

![Snowflake](https://img.shields.io/badge/Platform-Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-orange?style=for-the-badge&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Dataset](https://img.shields.io/badge/Records-271,207-blue?style=for-the-badge)

---

## 📌 Project Summary

| Item | Detail |
|------|--------|
| **Domain** | Retail / Beverage Distribution |
| **Platform** | Snowflake Cloud Data Warehouse |
| **Raw Records** | 307,645 transactions |
| **Clean Records** | 271,207 transactions |
| **Total Retail Sales** | $2,158,561 |
| **Total Warehouse Sales** | $7,703,030 |
| **Date Range** | 2017 – 2020 (January & December) |
| **Approach** | Ingestion → Deduplication → Null Handling → Analytics |
| **Queries** | 15+ analytical SQL queries |

---

## 🏗️ Architecture — Medallion-Style Pipeline

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                        END-TO-END DATA PIPELINE                                │
│                                                                                │
│  ┌──────────┐    ┌───────────────┐    ┌──────────────┐    ┌───────────────┐   │
│  │  BRONZE  │───▶│    SILVER     │───▶│     GOLD     │───▶│   INSIGHTS    │   │
│  │ (Raw)    │    │ (Cleaned)     │    │ (Enriched)   │    │ (Analytics)   │   │
│  └──────────┘    └───────────────┘    └──────────────┘    └───────────────┘   │
│                                                                                │
│  • 307,645 rows   • DISTINCT dedup   • Retail ratios     • Supplier perf.    │
│  • Raw schema     • Null → 0/Unknown • YoY growth        • Product rankings  │
│  • 9 item types   • 271,207 clean    • Category metrics  • Recommendations   │
│                                                                                │
└────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📂 Project Structure

```
retail-sales-data-engineering/
│
├── 📄 README.md                   ← Project documentation 
├── 📄 retail_sales.sql            ← All SQL queries (15+ analyses)
│
├── 🔹 Bronze Layer                ← Raw data (RETAIL_SALES - 307,645 rows)
├── 🔹 Silver Layer                ← Cleaned (RETAILS_SALES_CLEAN - 271,207 rows)
├── 🔹 Gold Layer                  ← Derived ratios & growth metrics
└── 🔹 Analytics Layer             ← Supplier, product & trend insights
```

---

## 📊 Data Schema

| # | Column | Data Type | Description |
|---|--------|-----------|-------------|
| 1 | `YEAR` | NUMBER(4,0) | Transaction year (2017–2020) |
| 2 | `MONTH` | VARCHAR | Month name (January / December) |
| 3 | `SUPPLIER` | VARCHAR | Supplier / distributor name |
| 4 | `ITEM_CODE` | VARCHAR | Unique product identifier |
| 5 | `ITEM_DESCRIPTION` | VARCHAR | Product name with size |
| 6 | `ITEM_TYPE` | VARCHAR | Category (Liquor/Wine/Beer/etc.) |
| 7 | `RETAIL_SALES` | NUMBER(38,2) | Retail sales amount ($) |
| 8 | `RETAIL_TRANSFERS` | NUMBER(38,2) | Retail transfer amount ($) |
| 9 | `WAREHOUSE_SALES` | NUMBER(38,2) | Warehouse sales amount ($) |

---

## 🔧 Pipeline Execution Steps

### 🟤 Step 1 — Bronze Layer (Raw Ingestion)
```sql
SELECT * FROM WAREHOUSE.PUBLIC.RETAIL_SALES;
-- 307,645 raw transaction records
```

### ⚪ Step 2 — Silver Layer (Data Quality & Cleaning)

| Check | Method | Result |
|-------|--------|--------|
| Duplicate Removal | `SELECT DISTINCT` | 307,645 → 271,207 (-36,438 dupes) |
| Null Retail Sales | Replaced with 0 | ✅ Fixed |
| Null Supplier | Replaced with 'Unknown' | ✅ Fixed |
| Column Audit | Full null check | ✅ All clean |

### 🟡 Step 3 — Gold Layer (Derived Metrics)
```sql
-- Retail-to-Warehouse ratio analysis
-- Year-over-year growth calculations
-- Supplier product diversity metrics
```

### 🟢 Step 4 — Analytics Layer
- Supplier performance, product rankings, category analysis, YoY trends

---

## 📈 Key Performance Indicators (KPIs)

| KPI | Value | Interpretation |
|-----|-------|----------------|
| 📦 Total Transactions | **271,207** | Clean records |
| 🛒 Retail Sales | **$2,158,561** | Direct retail revenue |
| 🏭 Warehouse Sales | **$7,703,030** | B2B/wholesale revenue |
| 💵 Avg Sale/Transaction | **$7.96** | Per-transaction retail |
| 🏢 Unique Suppliers | **397** | Supplier diversity |
| 📋 Unique Products | **34,822** | Product catalog size |
| 📁 Item Categories | **9** | Category diversity |

---

##  Deep-Dive Insights

### 1️⃣ Item Type Distribution — Liquor Dominates Retail

| Item Type | Retail Sales | Share | Warehouse Sales | Retail/Warehouse |
|-----------|-------------|-------|-----------------|------------------|
|  Liquor | $801,327 | 37.1% | $94K | **849%** |
|  Wine | $745,620 | 34.5% | $1.1M | 67% |
|  Beer | $574,149 | 26.6% | $6.5M | **8.8%** |
|  Non-Alcohol | $34,076 | 1.6% | — | — |
|  Kegs | $0 | 0% | — | Warehouse only |

> 💡 **Insight:** **Liquor sells 8.5x more at retail than warehouse** — massive retail margin. **Beer is the opposite** — $6.5M warehouse but only $574K retail — **huge untapped retail opportunity**.

---

### 2️⃣ Top 5 Products — Vodka & Beer Dominate

| Rank | Product | Retail Sales |
|------|---------|-------------|
| 🥇 | Tito's Handmade Vodka 1.75L | **$27,581** |
| 🥈 | Corona Extra Loose NR 12oz | $25,064 |
| 🥉 | Heineken Loose NR 12oz | $17,761 |
| 4 | Miller Lite 30PK Can 12oz | $14,440 |
| 5 | Bud Light 30PK Can | $12,299 |

>  **Insight:** **Tito's Vodka** is the clear #1 product — 10% ahead of Corona Extra.

---

### 3️⃣ Top Suppliers — Diversity vs Revenue

| Supplier | Products | Total Sales | Avg/Product |
|----------|----------|-------------|-------------|
| E & J Gallo Winery | 617 | $166,134 | $15.59 |
| Diageo North America | 481 | $145,262 | $19.91 |
| Constellation Brands | 375 | $131,628 | $19.96 |
| Anheuser Busch Inc | 427 | $109,951 | $19.85 |
| Jim Beam Brands Co | 346 | $96,102 | $16.59 |

> 💡 **Hidden Champion:** **Crown Imports** has **$67.77 avg/product** (4x industry avg) with only 67 products — premium portfolio strategy.

---

### 4️⃣ Year-over-Year Performance — COVID Impact

| Year | Retail Sales | Warehouse Sales | YoY Change |
|------|-------------|-----------------|------------|
| 2017 | $685,940 | $2,309,183 | — |
| 2018 | $153,596 | $519,526 | ⬇️ -78% |
| 2019 | **$958,745** | **$3,493,207** | ⬆️ +524% |
| 2020 | $360,281 | $1,381,114 | ⬇️ -62% |

> ⚠️ **2019 = Peak year** ($959K retail). **2020 dropped 62%** — likely COVID-19 impact. 2018 anomalously low — possible data gap.

---

### 5️⃣ Monthly Split — Data Skew Alert

| Month | Sales | Transactions | Share |
|-------|-------|-------------|-------|
| January | $1,932,350 | 233,483 | **89.5%** |
| December | $226,211 | 37,724 | 10.5% |

> ⚠️ **ALERT:** Data only contains January & December — **significant gap**. January accounts for 89.5% of all recorded sales.

---

## 📋 Complete Analysis Catalog

| Section | # | Analysis | Layer |
|---------|---|----------|-------|
| Data Exploration | 1.1 | Preview raw data | Bronze |
| | 1.2 | Duplicate detection | Silver |
| | 1.3 | Create clean table | Silver |
| | 1.4 | Verify cleaning | Silver |
| Data Quality | 2.1 | Null value check | Silver |
| | 2.2 | Distinct months | Silver |
| | 2.3 | Data types inspection | Silver |
| Business Overview | 3.1 | Total sales/transfers/warehouse | Analytics |
| | 3.2 | Month-wise sales trend | Analytics |
| Supplier Performance | 4.1 | Top 3 suppliers by sales | Analytics |
| Product Analysis | 5.1 | Top products by sales | Analytics |
| | 5.2 | Item type analysis | Analytics |
| Year-Wise Growth | 6.1 | Year-wise comparison | Analytics |
| Supplier Deep Dive | 7.1 | Product diversity vs sales | Analytics |
| Null Handling | 8.1–8.5 | Null audit & fixes | Silver |

---

## 🛠️ SQL Techniques & Methods

| Technique | Use Case |
|-----------|----------|
| `SELECT DISTINCT` | Mass deduplication (36K rows removed) |
| `COALESCE(col, 0)` | Null → default value replacement |
| `SUM() / AVG() / COUNT(DISTINCT)` | Aggregation & KPIs |
| `ROUND(retail/warehouse * 100, 2)` | Ratio calculation |
| `GROUP BY YEAR` | Year-over-year analysis |
| `ORDER BY ... LIMIT N` | Top-N product/supplier ranking |

---

##  Key Findings & Recommendations

| # | Finding | Recommendation | Priority |
|---|---------|----------------|----------|
| 1 | Beer: $6.5M warehouse but only $574K retail | Massive untapped retail potential — increase shelf space & promotions | 🔴 High |
| 2 | 2020 revenue dropped 62% | Separate COVID impact from structural decline; recovery plan needed | 🔴 High |
| 3 | Only Jan & Dec data available | Obtain full 12-month data for accurate trend analysis | 🟡 Medium |
| 4 | Liquor = 849% retail/warehouse ratio | Highest retail margin — optimize Liquor shelf positioning | 🟡 Medium |
| 5 | Crown Imports: $67.77 avg/product | Premium supplier strategy — explore partnership expansion | 🟢 Low |
| 6 | Wine close to Liquor in retail | Wine has 15x warehouse volume — retail growth opportunity | 🟢 Low |

---

##  Tech Stack

| Layer | Technology |
|-------|------------|
| **Cloud Platform** | Snowflake |
| **Compute** | COMPUTE_WH (Virtual Warehouse) |
| **Database** | WAREHOUSE |
| **Schema** | PUBLIC |
| **Language** | SQL |
| **Role** | ACCOUNTADMIN |
| **IDE** | Snowsight (Snowflake Web UI) |

---

##  How to Run

```sql
-- Step 1: Set context
USE DATABASE WAREHOUSE;
USE SCHEMA PUBLIC;

-- Step 2: Verify raw data
SELECT * FROM RETAIL_SALES LIMIT 10;

-- Step 3: Verify clean data
SELECT * FROM RETAILS_SALES_CLEAN LIMIT 10;

-- Step 4: Run retail_sales.sql queries sequentially
