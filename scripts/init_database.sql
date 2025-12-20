/*
================================
Create Database and Schemas
================================

PURPOSE:
This script creates a new database named 'Datawarehouse' 
after checking if it already exists. If the database exists,
it is dropped and recreated. Additionally, the script sets up
three schemas within the database: 'bronze', 'silver', and 'gold'.

WARNING: 
Running this script will drop the entire 'DataWatehouse' database if it exists.
All data in the database will be permanently deleted. Proceed with caution and 
ensure you have proper backups before running this script.

SOURCE:
Data with Baraa

*/


USE master;
GO

--Drop and recreate the 'DataWarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN 
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO
  

-- Create Database 'Datawarehouse'
CREATE DATABASE DATAWAREHOUSE;

USE DATAWAREHOUSE;

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;



