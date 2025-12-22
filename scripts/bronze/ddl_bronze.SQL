/*
====================================================================
Stored Procedure: Load Bronze Layer(Source -> Bronze)
=====================================================================

Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files. 
	It performs the following actions:
		- Truncates the bronze tables before loading data.
		- Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters: 
	None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example: 
	EXEC bronze.load_bronze

Source: 
	Data with Baraa

*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '============================';
		PRINT 'Loading Bronze Layer';
		PRINT '============================';

		PRINT '____________________________';
		PRINT 'Loading CRM Tables';
		PRINT '____________________________';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table:crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\user\OneDrive - University of Toronto\Desktop\SQL\project\datasets\cust_info.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table:crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\user\OneDrive - University of Toronto\Desktop\SQL\project\datasets\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table:crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\user\OneDrive - University of Toronto\Desktop\SQL\project\datasets\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '____________________________';
		PRINT 'Loading CRM Tables';
		PRINT '____________________________';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\user\OneDrive - University of Toronto\Desktop\SQL\project\datasets\cust_az12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\user\OneDrive - University of Toronto\Desktop\SQL\project\datasets\loc_a101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

	
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\user\OneDrive - University of Toronto\Desktop\SQL\project\datasets\px_cat_g1v2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	

	END TRY
	BEGIN CATCH 
		PRINT '================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===============================================';
	END CATCH
END
