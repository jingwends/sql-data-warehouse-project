TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info --faster insert than regualr insert
FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
WITH (
	FIRSTROW =2, 
--Load the data from the second row as first row is header and we already have that

	FIELDTERMINATOR = ',', -- Indicate the delimiter is "," 
	TABLOCK 
	--Lock entire table -Improve perforance by reducing the overhead of locking small objects
);


TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info 
FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details 
FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);