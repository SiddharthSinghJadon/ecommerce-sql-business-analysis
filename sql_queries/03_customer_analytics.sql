
-------------------------------------- Customer Analysis-------------------------------------------

--Unique Customers--
SELECT COUNT(DISTINCT customer_unique_id) AS no_of_unique_customers
FROM customers;

--Making VIEW for future use & using LEFT JOIN to Merge Data for Customers Analysis --
DROP VIEW IF EXISTS V_customer_analytics;
GO
CREATE VIEW V_customer_analytics AS
SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    p.payment_type,
    p.payment_value
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN payments p
    ON o.order_id = p.order_id;

--Top Customers by Revenue--
SELECT TOP 10
    customer_unique_id,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM V_customer_analytics
GROUP BY customer_unique_id
ORDER BY total_revenue DESC;

--Revenue by State--
SELECT
    customer_state,
    SUM(payment_value) AS total_revenue
FROM V_customer_analytics
GROUP BY customer_state
ORDER BY total_revenue DESC;

--Customers by State--
SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM V_customer_analytics
GROUP BY customer_state
ORDER BY total_customers DESC;

--Prefered Payment Method--
SELECT
    COALESCE(payment_type, 'not_defined') AS payment_type,
    COUNT(*) AS total_transactions,
    ROUND(COALESCE(SUM(payment_value), 0), 2) AS total_revenue
FROM V_customer_analytics
GROUP BY COALESCE(payment_type, 'not_defined')
ORDER BY total_revenue DESC;

--High Value Customers Based on Expenditure Done by Them and No of Order --
SELECT
    customer_unique_id,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM V_customer_analytics
GROUP BY customer_unique_id
HAVING SUM(payment_value) > 1000
ORDER BY total_revenue DESC;