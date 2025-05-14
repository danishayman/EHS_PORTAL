-- SQL script to fix the "Plant_Id" column issue
-- Run this script against your database to correct column names

USE [CLIP]
GO

-- Check if Plant_Id column exists in PlantMonitoring table and rename it if needed
IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Plant_Id' AND Object_ID = Object_ID('dbo.PlantMonitoring'))
BEGIN
    EXEC sp_rename 'dbo.PlantMonitoring.Plant_Id', 'PlantID', 'COLUMN'
    PRINT 'Renamed Plant_Id to PlantID in PlantMonitoring table'
END

-- Check if Plant_Id column exists in AreaPlant table and rename it if needed
IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Plant_Id' AND Object_ID = Object_ID('dbo.AreaPlants'))
BEGIN
    EXEC sp_rename 'dbo.AreaPlants.Plant_Id', 'PlantId', 'COLUMN'
    PRINT 'Renamed Plant_Id to PlantId in AreaPlants table'
END

-- Check if Plant_Id column exists in CertificateOfFitness table and rename it if needed
IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Plant_Id' AND Object_ID = Object_ID('dbo.CertificateOfFitness'))
BEGIN
    EXEC sp_rename 'dbo.CertificateOfFitness.Plant_Id', 'PlantId', 'COLUMN'
    PRINT 'Renamed Plant_Id to PlantId in CertificateOfFitness table'
END

-- Check if Plant_Id column exists in UserPlant table and rename it if needed
IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'Plant_Id' AND Object_ID = Object_ID('dbo.UserPlants'))
BEGIN
    EXEC sp_rename 'dbo.UserPlants.Plant_Id', 'PlantId', 'COLUMN'
    PRINT 'Renamed Plant_Id to PlantId in UserPlants table'
END

-- Remove any incorrect foreign key constraints referencing Plant_Id
DECLARE @constraintName NVARCHAR(256)
DECLARE @tableName NVARCHAR(256)
DECLARE @dropConstraintSQL NVARCHAR(512)

-- Find all foreign key constraints related to Plant_Id
DECLARE FK_Cursor CURSOR FOR
SELECT f.name AS FKName, OBJECT_NAME(f.parent_object_id) AS TableName
FROM sys.foreign_keys AS f
INNER JOIN sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id
INNER JOIN sys.columns AS c ON fc.parent_column_id = c.column_id AND fc.parent_object_id = c.object_id
WHERE c.name = 'Plant_Id'

OPEN FK_Cursor
FETCH NEXT FROM FK_Cursor INTO @constraintName, @tableName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @dropConstraintSQL = 'ALTER TABLE [dbo].[' + @tableName + '] DROP CONSTRAINT [' + @constraintName + ']'
    EXEC sp_executesql @dropConstraintSQL
    PRINT 'Dropped foreign key constraint: ' + @constraintName
    
    FETCH NEXT FROM FK_Cursor INTO @constraintName, @tableName
END

CLOSE FK_Cursor
DEALLOCATE FK_Cursor

-- Add foreign key constraints where needed (only if they don't already exist)
-- PlantMonitoring table
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_PlantMonitoring_Plants_PlantID' AND parent_object_id = OBJECT_ID('dbo.PlantMonitoring'))
BEGIN
    IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'PlantID' AND Object_ID = Object_ID('dbo.PlantMonitoring'))
    BEGIN
        ALTER TABLE [dbo].[PlantMonitoring]
        ADD CONSTRAINT [FK_PlantMonitoring_Plants_PlantID] 
        FOREIGN KEY ([PlantID]) REFERENCES [dbo].[Plants]([Id])
        PRINT 'Added FK_PlantMonitoring_Plants_PlantID constraint'
    END
END

-- AreaPlant table
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_AreaPlants_Plants_PlantId' AND parent_object_id = OBJECT_ID('dbo.AreaPlants'))
BEGIN
    IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'PlantId' AND Object_ID = Object_ID('dbo.AreaPlants'))
    BEGIN
        ALTER TABLE [dbo].[AreaPlants]
        ADD CONSTRAINT [FK_AreaPlants_Plants_PlantId] 
        FOREIGN KEY ([PlantId]) REFERENCES [dbo].[Plants]([Id])
        PRINT 'Added FK_AreaPlants_Plants_PlantId constraint'
    END
END

-- CertificateOfFitness table
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_CertificateOfFitness_Plants_PlantId' AND parent_object_id = OBJECT_ID('dbo.CertificateOfFitness'))
BEGIN
    IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'PlantId' AND Object_ID = Object_ID('dbo.CertificateOfFitness'))
    BEGIN
        ALTER TABLE [dbo].[CertificateOfFitness]
        ADD CONSTRAINT [FK_CertificateOfFitness_Plants_PlantId] 
        FOREIGN KEY ([PlantId]) REFERENCES [dbo].[Plants]([Id])
        PRINT 'Added FK_CertificateOfFitness_Plants_PlantId constraint'
    END
END

-- UserPlant table
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_UserPlants_Plants_PlantId' AND parent_object_id = OBJECT_ID('dbo.UserPlants'))
BEGIN
    IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = 'PlantId' AND Object_ID = Object_ID('dbo.UserPlants'))
    BEGIN
        ALTER TABLE [dbo].[UserPlants]
        ADD CONSTRAINT [FK_UserPlants_Plants_PlantId] 
        FOREIGN KEY ([PlantId]) REFERENCES [dbo].[Plants]([Id])
        PRINT 'Added FK_UserPlants_Plants_PlantId constraint'
    END
END

PRINT 'Database schema update completed' 