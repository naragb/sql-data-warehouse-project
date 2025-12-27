/*
=====================================================================================
Project: Exploritory Data Analysis in SQL
===================================================================================
PURPOSE:

SOURCE:
Data with Baraa

*/

-- ==============================================================================
-- Database exploration 
-- ===============================================================================

-- Explore all objects in the the database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore all columns in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_customers'

-- ===================================================================================
-- Dimention Exploration 
-- ====================================================================================

-- Explore 
SELECT DISTINCT country FROM gold.dim_customers

-- Explore all categories and subcategories
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3

-- ===================================================================================
-- Date Exploration
-- ====================================================================================

-- Find the date of the first and last order
SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date, 
	DATEDIFF (year, MIN(order_date),MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- Find the youngest and the olders customer 
SELECT 
	MIN(birthdate) AS oldest_birthdate,
	DATEDIFF (year, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF (year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers

-- ================================================================================================
-- Measure Exploration
-- ==================================================================================

-- Find the total sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(price) AS total_quantity FROM gold.fact_sales

-- Find the total number of orders
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_order FROM gold.fact_sales
SELECT * FROM gold.fact_sales

-- Find the total number of products
SELECT COUNT(product_name) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) AS total_products FROM gold.dim_products
SELECT COUNT(product_key) AS total_product FROM gold.dim_products

-- Find the total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales

-- Generate the report
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS total_sales FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS total_sales FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS total_quantity FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr Orders' AS measure_name, COUNT(order_number) AS total_orders FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr Products' AS measure_name, COUNT(product_name) AS total_products FROM gold.dim_products
UNION ALL
SELECT 'Total Nr Customer' AS meause_name, COUNT(customer_key) AS total_customers FROM gold.dim_customers

-- =========================================================================================
-- Magnitude
-- =========================================================================================





