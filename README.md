# retail-sales-snowflake-sql-Analysis
# 🛒 Retail Sales Analysis (Snowflake SQL Project)

## 📌 Dataset Overview

* **Raw Data:** 307,645 rows
* **Cleaned Data:** 271,207 rows (36,438 duplicates removed)
* **Time Period:** 2017–2020 *(only January & December available)*
* **Dimensions:** 397 suppliers, 34,822 products, 9 item types

---

## 📊 1. Revenue Summary

| Metric                 | Value      |
| ---------------------- | ---------- |
| Total Retail Sales     | $2,158,561 |
| Total Retail Transfers | $2,133,190 |
| Total Warehouse Sales  | $7,703,030 |
| Avg per Transaction    | $7.96      |

👉 Warehouse sales are **3.6× higher** than retail sales, showing bulk distribution dominates the business.

---

## 🏷️ 2. Category Breakdown

* 🍾 **Liquor:** 37% of retail sales ($801K) — strongest category
* 🍷 **Wine:** 35% ($746K) — strong but warehouse-heavy
* 🍺 **Beer:** 27% ($574K retail vs $6.5M warehouse) → major retail gap
* 📦 **Kegs & Dunnage:** No retail sales (warehouse-only items)

⚠️ Beer shows the **largest distribution imbalance (11× warehouse vs retail)**

---

## 🏆 3. Top Products

* 🥇 Tito’s Handmade Vodka (1.75L) — $27.6K
* 🥈 Corona Extra — $25K
* Heineken
* Miller Lite
* Bud Light

👉 Top products are dominated by **mainstream alcoholic brands**

---

## 🏭 4. Top Suppliers

* 🥇 **E&J Gallo Winery:** $166K (617 products)
* ⚡ **Crown Imports:** highest efficiency (~$67.77 per product)
* 📦 **Legends Ltd:** 3,043 products but only $3.04 per product (very low efficiency)

👉 Insight: **High SKU count does not guarantee high performance**

---

## 📈 5. Year-over-Year Trend

| Year | Sales | Change       |
| ---- | ----- | ------------ |
| 2017 | $685K | —            |
| 2018 | $154K | -78%         |
| 2019 | $959K | +524% (Peak) |
| 2020 | $360K | -62%         |

⚠️ 2019 was the strongest year
⚠️ 2020 drop likely impacted by COVID-19
⚠️ 2018 may indicate data inconsistency

---

## 📅 6. Monthly Insight

* January: $1.93M (89.5% of total data)
* December: $226K

⚠️ Only two months available → no true seasonality analysis possible

---

## 🔄 7. Retail vs Warehouse Channel

* 🍾 Liquor: Retail is 8.5× warehouse → strong retail product
* 🍺 Beer: Warehouse is 11× retail → weak retail penetration
* 🍷 Wine: Warehouse is 1.5× retail → balanced performance

---

## 💡 8. Key Insights

* Warehouse channel dominates overall sales
* Liquor performs best in retail channel
* Beer is heavily underrepresented in retail
* Supplier efficiency varies drastically
* Dataset has major time limitations

---

## 🚨 9. Business Recommendations

### 🔴 Data Improvement

* Expand dataset beyond January & December for full-year insights

### 🟡 Beer Strategy

* Push beer products from warehouse → retail shelves

### 🟢 Focus Liquor Category

* Highest-performing retail segment

### 🔵 Supplier Optimization

* Prioritize high-efficiency suppliers (e.g., Crown Imports model)

### 🟠 Product Optimization

* Reduce thousands of low-performing SKUs (<$5 average)

### ⚫ Data Quality Check

* Investigate 2018 & 2020 anomalies

---

## 🛠️ Tools Used

* ❄️ Snowflake SQL
* 📊 Aggregations & Group Analysis
* 📈 Time Series & Channel Comparison

---

## 📌 Conclusion

This analysis shows a **warehouse-dominated distribution system**, where Liquor drives retail success, while Beer and low-performing SKUs create inefficiencies. Strong opportunities exist in **channel optimization and supplier rationalization**.

---

⭐ Built for GitHub portfolio showcasing SQL analytics & business insights.
