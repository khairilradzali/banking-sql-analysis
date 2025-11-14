# Banking Transactions Analysis

This report summarizes insights from the simulated credit card transactions dataset. It covers customer spending, merchant revenue, transaction trends, and potential fraud patterns.

---

## 1. Dataset Overview

- **Customers:** 44,877 entries  
- **Cards:** 35,283 entries  
- **Merchants:** 6,698 entries  
- **Transactions:** 2,643,108 entries  

Tables used: `customers`, `cards`, `merchants`, `transactions`.

---

## 2. Key Metrics

| Metric | Value |
|--------|-------|
| Total Transactions | 2,643,108 |
| Total Customers | 44,877 |
| Total Merchants | 6,698 |
| Total Cards | 35,283 |
| Average Transaction Amount | $[calculated from SQL query] |
| Max Transaction Amount | $[calculated from SQL query] |

---

## 3. Spending Insights

### Top Spending Categories
- `[Category 1]` → Highest total revenue
- `[Category 2]`
- `[Category 3]`

### Top 10 Customers by Total Spend
- `[Customer Name]` → $[Total Spend]
- `[Customer Name]` → $[Total Spend]

---

## 4. Transaction Patterns

### Daily / Weekly Trends
- Peak transaction days: `[e.g., Friday, Saturday]`
- Peak transaction hours: `[e.g., 18:00-20:00]`

### Card Types Distribution
- `[Card Type 1]` → X%
- `[Card Type 2]` → Y%

---

## 5. Fraud / Suspicious Patterns

- Transactions flagged as `is_fraud = True`  
- High-value transactions exceeding **2x average per customer**  
- Customers with unusually high transaction frequency

> SQL queries used: `queries.sql` (queries 24–30 for categorization and anomaly detection)

---

## 6. Recommendations

1. Monitor high-frequency and high-value transactions for potential fraud.  
2. Target top spending categories for promotions or loyalty programs.  
3. Analyze low-income customer spending patterns for credit offerings.  

---

## 7. Next Steps

- Visualize trends with dashboards (Python / Tableau / Power BI)  
- Extend dataset with more merchants or transaction types  
- Automate fraud detection alerts using SQL or Python
