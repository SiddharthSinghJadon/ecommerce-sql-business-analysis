-------------------------- DATABASE SELECTION---------------------------

USE ecommerce_analysis

-------------------------- BASIC INFO ABOUT TABLES----------------------

SELECT COUNT(*) AS customers FROM customers;
SELECT COUNT(*) AS orders FROM orders;
SELECT COUNT(*) AS order_items FROM order_items;
SELECT COUNT(*) AS payments FROM payments;
SELECT COUNT(*) AS reviews FROM reviews;
SELECT COUNT(*) AS products FROM products;
SELECT COUNT(*) AS sellers FROM sellers;

SELECT TOP 5 * FROM customers;
SELECT TOP 5 * FROM sellers;
SELECT TOP 5 * FROM products;
SELECT TOP 5 * FROM order_items;
SELECT TOP 5 * FROM orders;
SELECT TOP 5 * FROM payments;
SELECT TOP 5 * FROM reviews;

-------------------------- BUSINESS KPI DASHBOARD------------------------

--Total Revenue--
SELECT SUM(payment_value) AS total_revenue
FROM payments;

--Total Orders--
SELECT COUNT(*) AS total_no_of_orders
FROM orders;

--Unique Customers--
SELECT COUNT(DISTINCT customer_unique_id) AS no_of_unique_customers
FROM customers;

--Total Sellers--
SELECT COUNT(seller_id) AS total_sellers
FROM sellers;

--Avg Order Value--
SELECT AVG(payment_value) AS avg_order_value
FROM payments;

--Avg Review Score--
SELECT ROUND(AVG(CAST(review_score AS FLOAT)), 3) AS avg_review_score
FROM reviews;

-------------------------- Revenue Analysis------------------------------

-- Basic KPI About Revenue Generation --
SELECT
    SUM(payment_value) AS total_revenue,
    AVG(payment_value) AS avg_order_value,
    MAX(payment_value) AS highest_order,
    MIN(payment_value) AS lowest_order
FROM payments;

--Making VIEW for future use & using LEFT JOIN to Merge Data for Revenue Analysis --
DROP VIEW IF EXISTS V_orders_enriched;
GO
CREATE VIEW V_orders_enriched AS 
    SELECT  
        o.order_id,
        o.customer_id,
        FORMAT(o.order_purchase_timestamp,'yyyy-MM') AS order_month,
        o.order_delivered_customer_date AS delivery_date,
        o.order_status,
        p.payment_value
    FROM payments AS p
    LEFT JOIN orders AS o
        ON p.order_id = o.order_id
;

-- Monthly Revenue Generated --
SELECT
    order_month,
    SUM(payment_value) AS monthly_revenue
FROM V_orders_enriched
GROUP BY order_month
ORDER BY order_month
;

-- Monthly Growth % --
WITH monthly_summary AS
(
    SELECT
        order_month,
        SUM(payment_value) AS monthly_revenue
    FROM V_orders_enriched
    GROUP BY order_month
),
monthly_growth AS
(
    SELECT
        order_month,
        monthly_revenue,
        LAG(monthly_revenue,1) OVER(ORDER BY order_month) AS previous_month_revenue
    FROM monthly_summary
)

SELECT
    order_month,
    monthly_revenue,
    previous_month_revenue,
    ROUND((monthly_revenue - previous_month_revenue)* 100.0 / previous_month_revenue, 3) AS percentage_change_in_revenue
FROM monthly_growth;

--Top Months in Revenue Generation--
SELECT TOP 5
    order_month,
    SUM(payment_value) AS monthly_revenue
FROM V_orders_enriched
GROUP BY order_month
ORDER BY monthly_revenue DESC 
;

--Worst Months in Revenue Generation--
SELECT TOP 5
    order_month,
    SUM(payment_value) AS monthly_revenue
FROM V_orders_enriched
GROUP BY order_month
ORDER BY monthly_revenue 
;


-------------------------- Customer Analysis-----------------------------

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
    ON o.order_id = p.order_id
;

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
ORDER BY total_revenue DESC
;


-------------------------- Delivery Analysis------------------------------

--Making VIEW for future use & using LEFT JOIN to Merge Data for Delivery Analysis --
DROP VIEW IF EXISTS V_delivery_analytics;
GO

CREATE VIEW V_delivery_analytics AS
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    c.customer_state,
    p.payment_value,
    DATEDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days
    FROM orders o
    LEFT JOIN customers c
        ON o.customer_id = c.customer_id
    LEFT JOIN payments p
        ON o.order_id = p.order_id
    WHERE o.order_delivered_customer_date IS NOT NULL;

--Average Delivery Time--
SELECT
    ROUND(AVG(CAST(delivery_days AS FLOAT)),2) AS avg_delivery_days
FROM V_delivery_analytics;

--Fastest Delivery States--
SELECT TOP 10
    customer_state,
    ROUND(AVG(CAST(delivery_days AS FLOAT)),2) AS avg_delivery_days
FROM V_delivery_analytics
GROUP BY customer_state
ORDER BY avg_delivery_days ASC;

--Slowest Delivery States--
SELECT TOP 10
    customer_state,
    ROUND(AVG(CAST(delivery_days AS FLOAT)),2) AS avg_delivery_days
FROM V_delivery_analytics
GROUP BY customer_state
ORDER BY avg_delivery_days DESC;

--Late Deliveries--
SELECT
    COUNT(*) AS late_orders
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;

--Percentage Late Orders--
SELECT
    ROUND(100.0 * SUM(
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
            ELSE 0
        END
        ) / COUNT(*), 2) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-----------------------------------------------------------------------------
