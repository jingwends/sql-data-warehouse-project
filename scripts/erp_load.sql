TRUNCATE TABLE bronze.erp_cust_az12;
BULK INSERT bronze.erp_cust_az12 
FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

TRUNCATE TABLE bronze.erp_loc_a101;
BULK INSERT bronze.erp_loc_a101 
FROM "C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2 FROM 
"C:\Users\lxtsh\OneDrive\Documents\Jingwen\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);