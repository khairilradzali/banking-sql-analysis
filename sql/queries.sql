#SECTION A — BEGINNER

SELECT * 
FROM customers 
WHERE income > 15000
ORDER BY income DESC
LIMIT 5;

SELECT COUNT(*) as total_customers
FROM customers;

SELECT *
FROM transactions
ORDER BY amount DESC
LIMIT 10;

SELECT gender, COUNT(*) as TOTAL
FROM customers
GROUP BY gender;

SELECT state, COUNT(*) AS total_count
FROM customers
GROUP BY state
ORDER BY state DESC
LIMIT 5;

SELECT merchant_id, COUNT(*) AS total_transactions
FROM transactions
GROUP BY merchant_id
ORDER BY total_transactions DESC
LIMIT 10;

SELECT merchant_id, SUM(amount) as total_spending
FROM transactions
GROUP BY merchant_id
ORDER BY total_spending DESC
LIMIT 10;

SELECT is_fraud, COUNT(*) as total
FROM transactions
GROUP BY is_fraud;

SELECT transaction_type, COUNT(*) as total
FROM transactions
GROUP BY transaction_type;

#SECTION B — INTERMEDIATE
SELECT t.transaction_id, c.name, t.amount
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY t.amount DESC
LIMIT 10;

SELECT c.name, SUM(amount) as total_spending
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.name
ORDER BY total_spending DESC
LIMIT 5;

SELECT m.merchant_id, SUM(t.amount) as total_revenue
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
GROUP BY m.merchant_id
ORDER BY total_revenue DESC
LIMIT 5;

SELECT m.category, SUM(amount) as total_spending
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
GROUP BY m.category
ORDER BY total_spending DESC;

SELECT m.category, COUNT(*) as total_fraud
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
WHERE is_fraud = TRUE
GROUP BY m.category
ORDER BY total_fraud DESC;

SELECT c.name, COUNT(*) as count_of_transactions
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.name
HAVING COUNT(*) > 100;

SELECT DATE_TRUNC('month', timestamp) as MONTH, SUM(amount) as total_amount
FROM transactions
GROUP BY month
ORDER BY month;

SELECT c.card_type, COUNT(transaction_id) as total_usage
FROM cards c
JOIN transactions t
ON c.card_id = t.card_id
GROUP BY c.card_type
ORDER BY total_usage DESC;

SELECT city, SUM(amount) as total_spending
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY city
ORDER BY total_spending DESC
LIMIT 10;

SELECT category, AVG(amount) as avg_transaction
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
GROUP BY category
ORDER BY avg_transaction DESC;

SELECT name, COUNT(card_id) as count_card
FROM customers cu
JOIN cards ca
ON  cu.customer_id = ca.customer_id
GROUP BY name
ORDER BY count_card DESC
LIMIT 10;

SELECT name, credit_limit, sum(amount) as total_spending
FROM customers cu
JOIN cards ca
ON cu.customer_id = ca.customer_id
JOIN transactions t
ON ca.card_id = t.card_id
WHERE credit_limit > 10000
GROUP BY name, credit_limit
HAVING SUM (t.amount) > 5000
ORDER BY total_spending DESC
LIMIT 10;

SELECT merchant_name, SUM(amount) AS total_revenue
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
WHERE is_fraud = TRUE
GROUP BY merchant_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT transaction_id, amount,
CASE
	WHEN amount < 50 THEN 'Small'
	WHEN amount BETWEEN 50 AND 500 THEN 'Medium'
	ELSE 'Large'
END AS transaction_size
FROM transactions