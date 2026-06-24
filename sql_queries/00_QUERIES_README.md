# SQL Queries Documentation

## Overview

This folder contains all SQL scripts used in the **Brazilian E-Commerce Business Analysis Project**. The project was developed using Microsoft SQL Server and focuses on extracting business insights from customer, revenue, delivery, product, seller, and review data.

The scripts are organized according to the analytics workflow, starting from database setup and validation, followed by individual business analysis modules.

---

## File Structure

### 01_database_setup.sql

Creates the database and tables required for the project.

Contents:

* Database creation
* Table creation
* Dataset import notes
* Initial setup steps

---

### 02_data_validation.sql

Performs data quality and integrity checks before analysis.

Contents:

* Row count validation
* Null value checks
* Data consistency verification
* Relationship validation

---

### 03_customer_analytics.sql

Analyzes customer distribution and purchasing behavior.

Key analyses:

* Customer distribution by state
* Revenue contribution by state
* Customer concentration patterns
* Top customer segments

---

### 04_revenue_analytics.sql

Evaluates overall business performance and revenue trends.

Key analyses:

* Total revenue
* Revenue by month
* Revenue growth trends
* Payment method analysis

---

### 05_delivery_analytics.sql

Examines logistics performance and delivery efficiency.

Key analyses:

* Average delivery time
* Late delivery percentage
* State-wise delivery performance
* Seller handoff analysis
* Shipping time analysis

---

### 06_product_analytics.sql

Analyzes product performance and category trends.

Key analyses:

* Best-selling product categories
* Product revenue contribution
* Product frequency distribution
* Product pricing analysis
* Freight cost analysis
* Weight vs freight relationships

---

### 07_seller_analytics.sql

Evaluates seller performance and revenue concentration.

Key analyses:

* Revenue by seller
* Seller revenue concentration
* Top seller contribution
* Seller distribution by state
* Average order value per seller

---

### 08_review_analytics.sql

Measures customer satisfaction and factors influencing reviews.

Key analyses:

* Review score distribution
* Review trends
* Delivery time vs review score
* Late delivery impact on customer satisfaction

---

### 09_e_commerce_analytics_combined.sql

Combined version containing all project queries in a single script.

Purpose:

* End-to-end project execution
* Project archival
* Easier review of complete workflow

---

## Tools Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* GitHub

---

## Dataset

Brazilian E-Commerce Public Dataset (Olist)

Dataset includes:

* Customers
* Orders
* Products
* Sellers
* Payments
* Reviews
* Order Items

---

## Project Goal

The objective of this project is to demonstrate practical SQL skills by solving real-world business problems and generating actionable insights across multiple business functions, including sales, logistics, customer behavior, product performance, seller performance, and customer satisfaction.

