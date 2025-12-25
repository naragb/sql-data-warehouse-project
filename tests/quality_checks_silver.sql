/*
============================================================================
Quality Checks
============================================================================
Purpose:
   This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.

Source:
Data with Baraa

===========================================================================
*/

-- =======================================================================
-- Checking 'silver.crm_cust_info'
-- =======================================================================

-- Check for NULLs of Duplicates in Primary Key 
-- Expectation: No result
SELECT 
   cst_id, 
   COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted spaces
-- Expectation: No results
SELECT 
   cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standartization & consistency
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

-- ========================================================================
-- Checking 'silver.crm_prd_info'
-- ========================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT
   prd_id, 
   COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT prd_nm
FROM silver.crm.prd.info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative Values in Cost
-- Expectation: No Result
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standartization & Consistency
SELECT Distinct prd_line
FROM silever.crm_prd_info;

-- Check for Invalid Date Orders(Start Date > End Date)
-- Expectation: No Results
SELECT *
FROM silver.crm_prd_info;

-- ==========================================================================
-- Checking 'silver.crm_sales_details'
-- ==========================================================================
-- Check for Invalid Dates
-- Expectation: No Invalid Dates
SELECT 
   NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE
    sls_due_dt <= 0
 OR LEN(sls_due_dt) != 8
 OR sls_due_dt > 20500101
 OR sls_due_dt < 19000101;

-- Check for Invalid Date Orders(Order Date > Shipping/Due Dates) 
-- Expectation: No Results 
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Check Data Cosistency: Sales = Quantity * Price
-- Expectation: No Result
SELECT Distinct
   sls_sales, 
   sls_quantity,
   sls_price
FROM silver.crm_sales_details
WHERE 
      sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

-- =====================================================================
-- Checking 'silver.erp_cust_az12'
--======================================================================
-- Identity out-of-range dates
-- Expectation: Birthdates between 1924-01-01 and today
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
   OR bdate > GETDATE();

-- Data Standartization & consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12;

-- ===========================================================================
-- Checking 'silver.erp_loc_ac101'
-- ==========================================================================
-- Data Standartization & consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ========================================================================
-- Checking 'silver.erp_ps_cat_g1v2'
-- =========================================================================
-- Check for Unwanted Spaces
-- Expectation: No results
SELECT *
FROM silver.erp_px_cat
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance !=TRIM(maintenance); 

-- Data Standardization & Consistency
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;










