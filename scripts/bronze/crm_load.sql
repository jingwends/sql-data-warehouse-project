/*
This is a simple SQL script to load CRM data into the bronze layer of a data warehouse without using a stored procedure.
Simple, but fast and efficient way to load data into the bronze layer of a data warehouse.

===========================================================
*/

TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info --faster insert than regualr insert
FROM 'file_path'
WITH (
	FIRSTROW =2, 
--Load the data from the second row as first row is header and we already have that

	FIELDTERMINATOR = ',', -- Indicate the delimiter is "," 
	TABLOCK 
	--Lock entire table -Improve perforance by reducing the overhead of locking small objects
);


TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info 
FROM 'file_path'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details 
FROM 'file_path'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);