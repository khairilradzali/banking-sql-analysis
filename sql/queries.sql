-- =====================================
-- Banking SQL Analysis: queries.sql
-- =====================================

-- Table names: customers, merchants, cards, transactions

-- ===========================
-- Beginner Queries (1-20)
-- ===========================

-- 1) Select first 10 transactions
SELECT * FROM transactions
ORDER BY timestamp DESC
LIMIT 10;

-- 2) Customers older than 30
SELECT * FROM customers
WHERE age > 30
ORDER BY age DESC;

-- 3) Transactions above 500
SELECT * FROM transactions
WHERE amount > 500
ORDER BY amount DESC
LIMIT 50;

-- 4) Online transactions only
SELECT * FROM transactions
WHERE transaction_type = 'Online';

-- 5) Transactions in 2025
SELECT * FROM transactions
WHERE date(timestamp) BETWEEN '2025-01-01' AND '2025-12-31';

-- 6) Count total transactions
SELECT COUNT(*) AS total_transactions FROM transactions;

-- 7) Count distinct customers
SELECT COUNT(DISTINCT customer_id) AS num_customers FROM transactions;

-- 8) Sum total transaction amount
SELECT SUM(amount) AS total_amount FROM transactions;

-- 9) Average transaction amount
SELECT AVG(amount) AS avg_amount FROM transactions;

-- 10) Max transaction
SELECT MAX(amount) AS max_amount FROM transactions;

-- 11) Min transaction
SELECT MIN(amount) AS min_amount FROM transactions;

-- 12) Total spending per customer
SELECT customer_id, SUM(amount) AS total_spend
FROM transactions
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 20;

-- 13) Total spending per merchant
SELECT m.merchant_name, m.category, SUM(t.amount) AS total_revenue
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
GROUP BY m.merchant_name, m.category
ORDER BY total_revenue DESC
LIMIT 20;

-- 14) Total spending per category
SELECT m.category, SUM(t.amount) AS total
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
GROUP BY m.category
ORDER BY total DESC;

-- 15) Number of transactions per day
SELECT date(timestamp) AS day, COUNT(*) AS txn_count
FROM transactions
GROUP BY day
ORDER BY day;

-- 16) Average amount per category
SELECT m.category, AVG(t.amount) AS avg_amount
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
GROUP BY m.category
ORDER BY avg_amount DESC;

-- 17) Transaction with customer age
SELECT t.*, c.age
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
LIMIT 50;

-- 18) Transaction with merchant category
SELECT t.*, m.category
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
LIMIT 50;

-- 19) Top 10 highest-spending customers
SELECT c.customer_id, c.name, SUM(t.amount) AS total_spend
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spend DESC
LIMIT 10;

-- 20) Customer city with total spend
SELECT c.city, SUM(t.amount) AS total_spend
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_spend DESC
LIMIT 20;

-- ===========================
-- Intermediate Queries (21-30)
-- ===========================

-- 21) Rank customers by total spend
SELECT customer_id, total_spend,
       RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM (
  SELECT customer_id, SUM(amount) AS total_spend
  FROM transactions
  GROUP BY customer_id
) s
ORDER BY spend_rank
LIMIT 50;

-- 22) Daily spending and running total
SELECT day, total, 
       SUM(total) OVER (ORDER BY day) AS running_total
FROM (
  SELECT date(timestamp) AS day, SUM(amount) AS total
  FROM transactions
  GROUP BY day
) d
ORDER BY day;

-- 23) 7-day moving average of daily spend
SELECT day, total,
       AVG(total) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7
FROM (
  SELECT date(timestamp) AS day, SUM(amount) AS total
  FROM transactions
  GROUP BY day
) dt
ORDER BY day;

-- 24) Categorize transaction sizes
SELECT transaction_id, amount,
  CASE
    WHEN amount <= 100 THEN 'Small'
    WHEN amount <= 500 THEN 'Medium'
    ELSE 'Large'
  END AS size_bucket
FROM transactions
LIMIT 100;

-- 25) Unusually large transactions (> 2x customer avg)
WITH cust_avg AS (
  SELECT customer_id, AVG(amount) AS avg_amt
  FROM transactions
  GROUP BY customer_id
)
SELECT t.*
FROM transactions t
JOIN cust_avg c ON t.customer_id = c.customer_id
WHERE t.amount > 2 * c.avg_amt
ORDER BY t.amount DESC
LIMIT 200;

-- 26) Customers with more than 20 transactions
SELECT customer_id, COUNT(*) AS txn_count
FROM transactions
GROUP BY customer_id
HAVING COUNT(*) > 20
ORDER BY txn_count DESC;

-- 27) Merchants with above-average revenue
WITH merchant_totals AS (
  SELECT merchant_id, SUM(amount) AS total_rev
  FROM transactions
  GROUP BY merchant_id
)
SELECT m.merchant_name, mt.total_rev
FROM merchant_totals mt
JOIN merchants m ON mt.merchant_id = m.merchant_id
WHERE mt.total_rev > (SELECT AVG(total_rev) FROM merchant_totals)
ORDER BY mt.total_rev DESC;

-- 28) Top 5 categories by total volume
SELECT m.category, SUM(t.amount) AS total
FROM transactions t
JOIN merchants m ON t.merchant_id = m.merchant_id
GROUP BY m.category
ORDER BY total DESC
LIMIT 5;

-- 29) Transactions grouped by weekday
SELECT strftime('%w', timestamp) AS weekday, COUNT(*) AS cnt
FROM transactions
GROUP BY weekday
ORDER BY weekday;

-- 30) Peak transaction hour
SELECT strftime('%H', timestamp) AS hour, COUNT(*) AS cnt
FROM transactions
GROUP BY hour
ORDER BY cnt DESC
LIMIT 10;
