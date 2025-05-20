-- Script to insert monitoring data from the image
-- This script inserts all monitoring types shown in the provided table

-- First, ensure we're using the correct database
USE [EHS_PORTAL]
GO

-- Insert statements for the Monitoring table with explicit MonitoringIDs
-- Format: MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq (in months)

-- Clean existing data if needed
-- DELETE FROM Monitoring;

-- Reset identity if needed
-- DBCC CHECKIDENT ('Monitoring', RESEED, 1);

BEGIN TRANSACTION;

-- Insert monitoring data according to the table
SET IDENTITY_INSERT Monitoring ON;

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (2, 'Air Monitoring', 'Environment', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (3, 'PUMPHOUSE', 'Environment', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (4, 'GENSET', 'Environment', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (5, 'Storm Water Monitoring', 'Environment', 6);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (6, 'Drinking Water', 'Environment', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (7, 'Boundary Noise Monitoring', 'Environment', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (8, 'Noise Risk Assessment(NRA)', 'Health & Safety', 60);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (9, 'Chemical Health Risk Assessment (CHRA)', 'Health & Safety', 60);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (10, 'Local Exhaust Ventilation Monitoring (LEV)', 'Health & Safety', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (11, 'Fire Certificate', 'Health & Safety', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (12, 'ERT Certificate', 'Health & Safety', 24);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (13, 'KPDNKK Permit', 'Health & Safety', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (14, 'Poison Permit', 'Health & Safety', 12);

INSERT INTO Monitoring (MonitoringID, MonitoringName, MonitoringCategory, MonitoringFreq)
VALUES (15, 'Psychotropic Permit', 'Health & Safety', 12);

SET IDENTITY_INSERT Monitoring OFF;

COMMIT TRANSACTION; 