
--------------------------------------- Review Analysis--------------------------------------------

------------Joining order_items, orders, sellers and products table to preview data----------------
----------------------Making VIEW for future use for Review Analysis ------------------------------
DROP VIEW IF EXISTS V_review_analysis
GO
CREATE VIEW V_review_analysis AS
    SELECT 
        o.order_id,
        seller_id,
        prod.product_id,
        review_id,
        prod.product_category_name,
        r.review_score,
        r.review_creation_date,
        r.review_answer_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
FROM reviews r
LEFT JOIN orders o
    ON r.order_id = o.order_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN products prod
    ON oi.product_id = prod.product_id

--Avg Review Score of entire e-commerce market, Number of products rated all the different values--
SELECT
    ROUND(AVG(CAST(review_score AS FLOAT)), 2) AS avg_review_score
FROM V_review_analysis;

--Distribution of Rating v/s No of Orders--
SELECT  
    COUNT(DISTINCT(order_id)) AS no_of_orders,
    review_score AS ratings,
    CASE
        WHEN review_score IN (4,5) THEN 'Positive Review'
        WHEN review_score = 3 THEN 'Neutral'
        WHEN review_score IN (1,2) THEN 'Negative Review'
        ELSE 'N/A'
    END AS customer_satisfaction
FROM V_review_analysis
GROUP BY review_score
ORDER BY ratings;

--Category Wise Rating Distribution--
SELECT 
    COALESCE(product_category_name, 'other_items'),
    ROUND(AVG(CAST(review_score AS FLOAT)), 2) AS avg_category_rating
FROM V_review_analysis
GROUP BY product_category_name
ORDER BY avg_category_rating DESC;

--Seller Wise Rating Distribution--
SELECT
    seller_id,
    ROUND(AVG(CAST(review_score AS FLOAT)), 2) AS avg_category_rating
FROM V_review_analysis
GROUP BY seller_id
ORDER BY avg_category_rating DESC;

--Delivery Time v/s Reviews--
SELECT
    CASE
        WHEN delivery_days <= 7 THEN 'Fast (<=7 Days)'
        WHEN delivery_days <= 14 THEN 'Medium (8-14 Days)'
        ELSE 'Slow (>14 Days)'
    END AS delivery_speed,
    ROUND(AVG(CAST(review_score AS FLOAT)), 2) AS avg_review_score,
    COUNT(*) AS total_orders
FROM V_review_analysis v
LEFT JOIN V_delivery_analytics d
    ON v.order_id = d.order_id
GROUP BY
    CASE
        WHEN delivery_days <= 7 THEN 'Fast (<=7 Days)'
        WHEN delivery_days <= 14 THEN 'Medium (8-14 Days)'
        ELSE 'Slow (>14 Days)'
    END
ORDER BY avg_review_score DESC;