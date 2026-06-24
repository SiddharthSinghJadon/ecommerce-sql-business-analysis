-------------------------------------- BASIC INFO ABOUT TABLES--------------------------------------------
SELECT COUNT(*) AS customers FROM customers;
SELECT COUNT(*) AS orders FROM orders;
SELECT COUNT(*) AS order_items FROM order_items;
SELECT COUNT(*) AS payments FROM payments;
SELECT COUNT(*) AS reviews FROM reviews;
SELECT COUNT(*) AS products FROM products;
SELECT COUNT(*) AS sellers FROM sellers;


----------------------------------------- DATA QUALITY CHECK ---------------------------------------------
SELECT TOP 5 * FROM customers;
SELECT TOP 5 * FROM sellers;
SELECT TOP 5 * FROM products;
SELECT TOP 5 * FROM order_items;
SELECT TOP 5 * FROM orders;
SELECT TOP 5 * FROM payments;
SELECT TOP 5 * FROM reviews;