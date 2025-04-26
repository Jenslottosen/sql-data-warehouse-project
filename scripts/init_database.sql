/*-------------------------------------------------------------
Create database & schemas
-------------------------------------------------------------*/
USE master;
GO

IF DB_ID('DataWarehouse') IS NULL
    CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');
GO
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');

/*-------------------------------------------------------------
Verify
-------------------------------------------------------------*/
SELECT DB_NAME() AS current_db;
GO

SELECT s.name AS schema_name,
       t.name AS table_name
FROM   sys.tables t
JOIN   sys.schemas s ON s.schema_id = t.schema_id
WHERE  s.name = 'bronze'
ORDER BY t.name;
GO
