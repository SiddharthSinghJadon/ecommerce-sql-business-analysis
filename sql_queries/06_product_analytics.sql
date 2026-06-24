
--------------------------------------- Product Analysis-------------------------------------------

--------------------Joining order_items and products table to preview data-------------------------
-----------------------Making VIEW for future use for Product Analysis ----------------------------

DROP VIEW IF EXISTS V_product_analysis
GO

CREATE VIEW V_product_analysis AS
    SELECT
        oi.order_id,
        oi.product_id,
        prod.product_category_name,
        oi.price,
        oi.freight_value,
        prod.product_weight_g,
        prod.product_length_cm,
        prod.product_width_cm,
        product_height_cm
    FROM order_items oi
    LEFT JOIN products prod
        ON oi.product_id = prod.product_id;

--AVG, MAX AND MIN Prod Price--
SELECT
    MAX(price) AS max_product_price,
    ROUND(MIN(price), 2) AS min_product_price,
    ROUND(AVG(price), 2) AS avg_product_price
FROM V_product_analysis

--Most Selling Product Categories--
SELECT TOP 10
    product_category_name,
    COUNT(*) AS orders_per_category
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY orders_per_category DESC;

--Most Selling Products--
SELECT TOP 10
    product_id,
    COUNT(*) AS orders_per_product
FROM V_product_analysis
GROUP BY product_id
ORDER BY orders_per_product DESC;

--Least Selling Product Categories--
SELECT TOP 10
    product_category_name,
    COUNT(*) AS orders_per_category
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY orders_per_category;

--Least Selling Products--
SELECT TOP 10
    product_id,
    COUNT(*) AS orders_per_product
FROM V_product_analysis
GROUP BY product_id
ORDER BY orders_per_product; 

/*There are 18117 Products which were sold only Once therefore analysing least selling products doesn't make sense*/

--Frequency Distribution of Number of Products--
SELECT
    COUNT(orders_per_product) AS product_count,
    orders_per_product
FROM 
(
SELECT
    COUNT(*) AS orders_per_product
FROM V_product_analysis
GROUP BY product_id
)tt
GROUP BY orders_per_product
ORDER BY orders_per_product;

--Product Categories Generating Most Revenue--
SELECT TOP 10
    product_category_name,
    ROUND(SUM(price), 2) AS revenue_per_category
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY revenue_per_category DESC;

--Product Categories Generating Least Revenue--
SELECT TOP 10
    product_category_name,
    ROUND(SUM(price), 2) AS revenue_per_category
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY revenue_per_category;

--Product Categories With Highest Avg Prices Per Product--
SELECT TOP 10
    COALESCE(product_category_name, 'other Category') AS product_category,
    ROUND(AVG(price), 2) AS avg_product_price_per_category
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY avg_product_price_per_category DESC;

--Product Categories With Lowest Avg Prices Per Product--
SELECT TOP 10
    COALESCE(product_category_name, 'other Category') AS product_category,
    ROUND(AVG(price), 2) AS avg_product_price_per_category
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY avg_product_price_per_category;

--Highest Avg Freight Cost Category--
SELECT TOP 10
    product_category_name,
    ROUND(AVG(freight_value), 2) AS avg_freight_cost
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY avg_freight_cost DESC;

--Lowest Avg Freight Cost Category--
SELECT TOP 10
    product_category_name,
    ROUND(AVG(freight_value), 2) AS avg_freight_cost
FROM V_product_analysis
GROUP BY product_category_name
ORDER BY avg_freight_cost;

--% Freight Cost Compared to Product Price--
SELECT 
    product_category_name,
    AVG(100 * freight_value / price) AS avg_percentage_freight_cost
FROM V_product_analysis
WHERE product_category_name IS NOT NULL
GROUP BY product_category_name
ORDER BY avg_percentage_freight_cost;

--Freight Cost Compared To Weight And Dimesions--
SELECT
    CASE
        WHEN product_weight_g > 10000 THEN 'Heavy'
        WHEN product_weight_g > 1000 THEN 'Medium'
        ELSE 'Light' 
    END AS weight_category,
    ROUND(AVG(freight_value), 2) AS avg_freight_cost
FROM V_product_analysis
WHERE product_weight_g != 0
GROUP BY CASE
        WHEN product_weight_g > 10000 THEN 'Heavy'
        WHEN product_weight_g > 1000 THEN 'Medium'
        ELSE 'Light' 
    END;