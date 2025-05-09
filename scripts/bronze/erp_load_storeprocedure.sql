/* 
====================================================
Stored procedure to load ERP data into bronze layer.
This script loads data from the source ERP system (CSV files) into the bronze layer of the data warehouse.
====================================================
It performs the following operations:
1. Truncates the existing data in the bronze layer tables.
2. Use 'BULk INSERT' loading new data from CSV files into the bronze layer tables.
3. Measures and prints the load time for each table.
4. Handles errors during the loading process.
5. Prints the total load time for all tables.
6. Prints error messages if any errors occur during the loading process.
====================================================
====================================================
Parameters: None. 
The procedure does not take any parameters.
====================================================
Usage Example:
EXEC bronze.load_bronze_erp;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze_erp AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	PRINT '=================================';
	PRINT 'Loading ERP Tables';
	PRINT '=================================';
	PRINT '';

	SET @start_time = GETDATE();
	SET @batch_start_time = GETDATE()
	PRINT '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	PRINT '>> Inserting Table: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12 
	FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load time is ' + CAST (DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' second.';
	PRINT '=================================';
	PRINT '';

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	PRINT '>> Inserting Table: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101 
	FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE()
	PRINT '>>Load time is ' + CAST (DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' second.';
	PRINT '=================================';
	PRINT '';

	SET @start_time = GETDATE();
	PRINT '>> Truncating bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	PRINT '>> Inserting bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2 
	FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load time is ' + CAST (DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' second.';
	PRINT '=================================';

	SET @batch_end_time = GETDATE();
		PRINT '=================================';
		PRINT 'Loading Bronze Layer is completed.'
		PRINT '--Total Load During is '+ CAST (DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds.';
		PRINT '=================================';

	END TRY
	BEGIN CATCH
		PRINT '====================================================='
		PRINT 'Error occured druing loading CRM bronze layer'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT '====================================================='
	END CATCH
END