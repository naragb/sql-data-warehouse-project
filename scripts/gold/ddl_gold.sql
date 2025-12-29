/*
===========================================================================================================
DDL Script: Create Gold View
===========================================================================================================
PURPOSE:
  This script creates views for the Gold layer in the data warehouse.
  The Gold layer represents the final dimention and fact tables (Star Schema).

  Each view performs transformations and combines data from the Silver layer 
  to produce a clean, enriched, and business-ready dataset.

USAGE:
  - These views can be queries directly 

SOURCE:
  Data with Baraa
=============================================================================================================
*/

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
  DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
  ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
  ci.cst_id                 AS customer_id,
  ci.cst_key                AS customer_number,
  ci.cst_firstname          AS first_name, 
  ci.cst_lastname           AS last_name,
  la.cntry                  AS country, 
  ci.cst_marital_status     AS marital_status,
  CASE
      WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
      ELSE COALESCE(ca.gen, 'n/a')
  END                        AS gender,
  ca.bdate                   AS birthdate,
  ci.cst_create_date         AS create_date
FROM silver.crm_cust_info   ci
LEFT JOIN silver.erp_cust_az12 ca
  ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
  ON ci.cst_key = la.cid;
GO
