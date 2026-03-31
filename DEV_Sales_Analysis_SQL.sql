# QUERIES
-- 1. How much total revenue has the company generated?

SELECT sum(sales_amount) AS total_revenue
FROM transactions;

-- 2. How has revenue grown over the years?

SELECT d.year, SUM(t.sales_amount) AS yearly_revenue
FROM transactions t
JOIN date d
ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year;

-- 3. Which months generate the most revenue?

SELECT d.year, d.month_name, SUM(t.sales_amount) AS monthly_revenue
FROM transactions t
JOIN date d
ON t.order_date = d.date
GROUP BY d.year, d.month_name
ORDER BY monthly_revenue DESC;

-- 4. Who are the most valueable customers?

SELECT c.custmer_name, SUM(t.sales_amount) AS total_revenue
FROM transactions t 
JOIN customers c
ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Which customer segment contributes the most revenue?

SELECT c.customer_type, SUM(t.sales_amount) AS revenue
FROM transactions t
JOIN customers c
ON t.customer_code = c.customer_code
GROUP BY c. customer_type;

-- 6. Which products generate the highest sales?

SELECT product_code, SUM(sales_amount) AS revenue 
FROM transactions
GROUP BY product_code
ORDER BY revenue DESC
LIMIT 10;

-- 7. Which product have the lowest sales?

SELECT product_code, SUM(sales_amount) AS revenue
FROM transactions
GROUP BY product_code
ORDER BY revenue ASC
LIMIT 10;

-- 8. What percentage of revenue comes from each customer?

SELECT c.custmer_name, SUM(t.sales_amount) AS revenue,
ROUND(
SUM(t.sales_amount) * 100 /
(SELECT SUM(sales_amount) FROM transactions),2
) AS revenue_percentage
FROM transactions t 
JOIN customers c
ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY revenue DESC;

-- 9. How fast is the company growing month to month?
SELECT d.year, d.month_name, 
SUM(t.sales_amount) AS revenue,
LAG(SUM(t.sales_amount)) OVER(ORDER BY d.year, d.month_name) AS prev_month,
ROUND(
(SUM(t.sales_amount) - 
LAG(SUM(t.sales_amount)) OVER(ORDER BY d.year, d.month_name))
/
LAG(SUM(t.sales_amount)) OVER(ORDER BY d.year, d.month_name)
*100,2
) AS growth_rate
FROM transactions t
JOIN date d
ON t.order_date = d.date
GROUP BY d.year, d.month_name;

-- 10.What is the average transaction value?

SELECT AVG(sales_amount) AS avg_order_value
FROM transactions;

-- 11.Which months historically perform best?

SELECT d.date_yy_mmm, SUM(t.sales_amount) AS revenue 
 FROM transactions t
 JOIN date d
 ON t.order_date = d.date
 GROUP BY d.date_yy_mmm
 ORDER BY revenue DESC
 LIMIT 10;
 
 -- 12.Which customers purchase frequently?
 
 SELECT customer_code, COUNT(*) AS purchase_count
 FROM transactions
 GROUP BY customer_code
 ORDER BY purchase_count DESC
 LIMIT 10;
 
 -- 13.Revenue Distribution by Market
 
SELECT m.markets_name, SUM(t.sales_amount) AS revenue
FROM transactions t
JOIN markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY revenue DESC;

-- 14.Customer Lifetime Value (CLV)

SELECT 
    c.custmer_name,
    COUNT(t.sales_amount) AS total_orders,
    SUM(t.sales_amount) AS lifetime_value,
    AVG(t.sales_amount) AS avg_order_value
FROM transactions t
JOIN customers c
ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY lifetime_value DESC;

