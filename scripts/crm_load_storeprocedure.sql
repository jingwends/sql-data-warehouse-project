CREATE OR ALTER PROCEDURE bronze.load_bronze_crm AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	--Use two variable's difference to get the load time for each table
	BEGIN TRY 
		PRINT '=================================';
		PRINT 'Loading CRM Tables';
		PRINT '=================================';
		PRINT '';

		SET @start_time = GETDATE();
		SET @batch_start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info --faster insert than regualr insert
		FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
		WITH (
			FIRSTROW =2, 
		--Load the data from the second row as first row is header and we already have that

			FIELDTERMINATOR = ',', -- Indicate the delimiter is "," 
			TABLOCK 
			--Lock entire table -Improve perforance by reducing the overhead of locking small objects
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '=================================';
		PRINT '';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '=================================';
		PRINT '';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
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