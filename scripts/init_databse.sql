/* Create Databse and Schemas
Scipt Purpose: 
  This script creates a new databse named "DataWarehouse" after checking if it already exists. If the databse eexists, it is dropeed and recreated. Additionally, the script sets up three shcemas within the database: "bronze", "silver", and "gold". 

Warning: 
  Running this script will drop the entire "DataWarehouse" database if it exists. All data in the databse will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script. 

*/
USE master;
GO

--Drop and recreate the 'DataWarehouse' databse
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SIGNLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;

USE DataWarehouse; 

-- Cretae Schema
CREATE SCHEMA bronze;
GO
CREATE SCHEMA sliver;
GO
CREATE SCHEMA gold;
GO