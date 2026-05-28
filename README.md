# Olist Store Analytics

> End-to-end exploratory data analysis of the Olist Brazilian e-commerce dataset — covering orders, customers, products, sellers, payments, and delivery performance across 2016–2018.

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Data-Microsoft%20Excel-217346?logo=microsoft-excel&logoColor=white)
![Power BI](https://img.shields.io/badge/Dashboard-Power%20BI-F2C811?logo=powerbi&logoColor=black)
![PowerPoint](https://img.shields.io/badge/Presentation-PowerPoint-B7472A?logo=microsoft-powerpoint&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Tech Stack](#tech-stack)
3. [Folder Structure](#folder-structure)
4. [Data Sources](#data-sources)
5. [How to Run / Reproduce](#how-to-run--reproduce)
6. [Key Findings](#key-findings)
7. [Dashboard Preview](#dashboard-preview)
8. [Future Improvements](#future-improvements)
9. [License](#license)

---

## Project Overview

This project performs a comprehensive analysis of Olist, Brazil's largest department store marketplace, using transactional data spanning 2016 to 2018. The analysis is structured around eight KPIs derived using MySQL, visualized in Power BI across five interactive dashboard pages (Orders, Products, Customers, Shipping & Delivery, Sellers), and summarized in a PowerPoint presentation.

The goal is to uncover actionable insights around payment behaviour, delivery efficiency, customer geography, product pricing, and seller performance — supporting data-driven decisions for e-commerce operations.

---

## Tech Stack

| Layer | Tool / Format |
|---|---|
| Data Storage | Microsoft Excel (`.xlsx`) |
| Data Querying | MySQL (`.sql`) |
| Visualization | Microsoft Power BI (`.pbix`) |
| Presentation | Microsoft PowerPoint (`.pptx`) |
| Version Control | Git + GitHub |

---

## Folder Structure

```
olist-store-analytics/
├── data/
│   ├── raw/
│   │   └── olist_dataset.xlsx          # Original multi-sheet source dataset
│   └── processed/
│       └── kpi_summary.xlsx            # Aggregated KPI outputs (if exported)
├── sql/
│   └── project_olist.sql               # All 8 KPI queries + table creation scripts
├── dashboards/
│   └── olist_store_dashboard.pbix      # Power BI dashboard file (5 pages + story)
├── visualizations/
│   ├── dashboard_kpi_overview.png
│   ├── dashboard_orders.png
│   ├── dashboard_products.png
│   ├── dashboard_customers.png
│   ├── dashboard_shipping_delivery.png
│   └── dashboard_sellers.png
├── presentation/
│   └── olist_store_analysis.pptx       # Final stakeholder presentation
├── docs/
│   └── project_notes.md                # Methodology, assumptions, data dictionary
├── .gitignore
└── README.md
```

---

## Data Sources

**File:** `olist_dataset.xlsx`  
**Source:** Olist Brazilian E-Commerce Public Dataset  
**Period:** 2016 – 2018  
**Format:** Multi-sheet Excel workbook

| Sheet / Table | Key Fields | Description |
|---|---|---|
| `olist_orders` | `order_id`, `customer_id`, `order_purchase_timestamp`, `order_delivered_customer_date`, `order_status` | Master order records |
| `olist_order_payments` | `order_id`, `payment_type`, `payment_value` | Payment method and value per order |
| `olist_order_reviews` | `order_id`, `review_score` | Customer satisfaction scores (1–5) |
| `olist_order_items` | `order_id`, `product_id`, `seller_id`, `price`, `freight_value`, `shipping_limit_date` | Line-item detail per order |
| `olist_products` | `product_id`, `product_category_name`, `product_length_cm`, `product_width_cm`, `product_height_cm` | Product catalogue and dimensions |
| `olist_customer` | `customer_id`, `customer_city`, `customer_zip_code_prefix` | Customer location data |
| `olist_sellers` | `seller_id`, `seller_city`, `seller_zip_code_prefix` | Seller location data |

**Scale:** ~99,440 orders · ~99,440 customers · ~32,340 products · 3,095 sellers

---

## How to Run / Reproduce

### Prerequisites

- MySQL Server 8.0+ or MySQL Workbench
- Microsoft Excel 2016+
- Microsoft Power BI Desktop (free)
- Git

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/<your-username>/olist-store-analytics.git
cd olist-store-analytics
```

**2. Set up the MySQL database**
```bash
# Open MySQL Workbench or connect via terminal
mysql -u root -p
```
Then run the SQL script:
```sql
SOURCE sql/project_olist.sql;
```
This will create the `project_olist` database, import tables (assumed pre-loaded from the Excel file), and generate all 8 KPI tables.

**3. Load data into MySQL from Excel**

Import each sheet from `data/raw/olist_dataset.xlsx` into the `project_olist` schema using MySQL Workbench's Table Data Import Wizard, or use a tool such as `mysql-excel-bridge`. Match sheet names to table names listed above.

**4. Run KPI queries**

All queries are sequentially documented in `sql/project_olist.sql`. Execute them section by section (KPI 1 through KPI 8) in MySQL Workbench.

**5. Open the Power BI dashboard**

Open `dashboards/olist_store_dashboard.pbix` in Power BI Desktop. If prompted, update the data source connection to point to your local MySQL instance:
- Go to **Home → Transform Data → Data Source Settings**
- Update server to `localhost` and database to `project_olist`

**6. View the presentation**

Open `presentation/olist_store_analysis.pptx` in Microsoft PowerPoint or upload to Google Slides for sharing.

---

## Key Findings

- **Weekday purchases dominate revenue.** Weekday transactions account for approximately 78% of total payment value ($16.93M) versus 22% on weekends ($4.74M), suggesting the customer base is primarily working professionals shopping during business hours.

- **Credit card is the primary payment method.** Over 73.9% of orders were placed using credit cards (75.99K orders, totalling $16.58M), indicating a strong preference for digital credit-based transactions.

- **Delivery performance is strong but speed impacts satisfaction.** The average delivery time is 12.14 days, and a clear inverse relationship exists between shipping duration and review scores — orders with review score 5 averaged just 10.7 shipping days, while those rated 1 averaged 21.3 days.

- **South America is the core market, with São Paulo as the revenue hub.** Approximately 89.83% of customers are in South America. São Paulo alone contributes ~$3.04M in payment value, with an average price of $107.53 and average payment value of $135.83 per order.

- **Product volume directly predicts freight cost.** A correlation of 0.87 between product volume (L×W×H) and freight value confirms that logistics pricing is volume-driven, with heavier categories like furniture incurring the highest freight costs.

---

## Dashboard Preview

| Page | Description |
|---|---|
| KPI Dashboard | High-level summary: 98.67K orders, 98.67K customers, 32.95K products, 3,095 sellers |
| Order Analysis | Orders by continent, status, review score, and payment type |
| Product Analysis | Average price and freight by category; payment value by type |
| Customer Insights | Payment type distribution, geographic distribution, YoY new customer growth |
| Shipping & Delivery | Delivery success rate (97%), average shipping days, geographic order map |
| Sellers | Average price by product category, seller rating (4.09/5), seller continent distribution |

Screenshots are available in the `/visualizations` folder.

---

## Future Improvements

- **Predictive delivery modelling:** Build a regression model using product dimensions, seller city, and customer city to predict freight cost and estimated delivery time before order placement.
- **Customer segmentation (RFM Analysis):** Apply Recency-Frequency-Monetary segmentation to classify customers into tiers and identify high-value segments for targeted retention campaigns.
- **Real-time Power BI integration:** Connect Power BI to a live MySQL instance via DirectQuery to enable real-time monitoring of order and payment KPIs.

---

## License

This project is licensed under the [MIT License](LICENSE).  
Dataset originally published by Olist on Kaggle under a CC BY-NC-SA 4.0 licence.
