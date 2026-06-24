
-------------------------------------- Revenue Analysis-------------------------------------------

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
        ON p.order_id = o.order_id;

-- Monthly Revenue Generated --
SELECT
    order_month,
    SUM(payment_value) AS monthly_revenue
FROM V_orders_enriched
GROUP BY order_month
ORDER BY order_month;

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
ORDER BY monthly_revenue DESC ;

--Worst Months in Revenue Generation--
SELECT TOP 5
    order_month,
    SUM(payment_value) AS monthly_revenue
FROM V_orders_enriched
GROUP BY order_month
ORDER BY monthly_revenue ;