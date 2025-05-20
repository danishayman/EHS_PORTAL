-- Script to insert existing PlantMonitoring data
-- This script inserts the exact records from the PlantMonitoring table

-- First, ensure we're using the correct database
USE [EHS_PORTAL]
GO

-- Clean existing data if needed (uncomment if you want to delete existing data)
-- DELETE FROM PlantMonitoring;
-- DBCC CHECKIDENT ('PlantMonitoring', RESEED, 5); -- Start with ID 6

-- Set up a transaction to ensure data consistency
BEGIN TRANSACTION;

-- Enable identity insert to use exact IDs
SET IDENTITY_INSERT PlantMonitoring ON;

-- Insert all plant monitoring records with their exact values
INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, QuoteDate, QuoteSubmitDate, QuoteCompleteDate, QuoteUserAssign, EprDate, EprSubmitDate, EprCompleteDate, EprUserAssign, WorkDate, WorkSubmitDate, WorkCompleteDate, WorkUserAssign, Remarks, RenewDate, QuoteDoc, ePRDoc, WorkDoc, ProcStatus, ExpStatus)
VALUES (6, 3, 2, 'Scrubber 6', '2026-05-20', '2025-05-08', '2025-05-07', '2025-05-09', 'dev', NULL, '2025-05-09', '2025-05-17', 'dev', NULL, NULL, '2025-05-20', 'dev', NULL, NULL, '~/uploads/Monitoring/Quote_6_20250516100954_mlem.jpeg', NULL, NULL, 'Completed', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, QuoteDate, QuoteSubmitDate, QuoteCompleteDate, QuoteUserAssign, EprDate, EprSubmitDate, EprCompleteDate, EprUserAssign, WorkDate, WorkSubmitDate, WorkCompleteDate, WorkUserAssign, Remarks, RenewDate, QuoteDoc, ePRDoc, WorkDoc, ProcStatus, ExpStatus)
VALUES (7, 3, 2, 'Chimney 9', '2025-12-31', '2025-05-17', '2025-05-18 17:20:00', '2025-05-25 20:20:00', 'dev', '2025-05-26 17:45:00', '2025-05-27 17:45:00', '2025-05-28 17:45:00', 'dev', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ePR Raised', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (8, 3, 2, 'Chimney 10', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (9, 2, 2, 'Chimney 2', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (10, 2, 2, 'Chimney 3', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (11, 2, 2, 'Chimney 4', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (12, 2, 2, 'Chimney 6', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, QuoteDate, QuoteSubmitDate, QuoteCompleteDate, QuoteUserAssign, QuoteDoc, ProcStatus, ExpStatus)
VALUES (13, 4, 2, 'Chimney 1', '2025-12-31', '2025-05-09', '2025-05-08', '2025-05-10', 'dev', '~/uploads/Monitoring/Quote_13_20250507151748_mlem.jpeg', 'Quotation Requested', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, QuoteDate, QuoteSubmitDate, QuoteCompleteDate, QuoteUserAssign, ProcStatus, ExpStatus)
VALUES (14, 4, 2, 'Chimney 2', '2025-12-31', '2025-05-08', '2025-05-08', '2025-05-08', 'dev', 'Quotation Requested', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (15, 5, 2, 'Chimney 1', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (16, 5, 2, 'Chimney 2', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (17, 5, 2, 'Chimney 3', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (18, 5, 2, 'Chimney 4', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (19, 1, 3, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (20, 3, 3, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (21, 2, 3, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (22, 4, 3, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (23, 5, 3, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (24, 6, 4, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (25, 2, 4, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (26, 4, 4, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (27, 5, 4, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (28, 6, 5, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (29, 2, 5, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (30, 4, 5, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (31, 5, 5, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (32, 4, 6, 'Belimbing Sky View Bandar Cassia', '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (33, 6, 6, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (34, 2, 6, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (35, 4, 6, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (36, 5, 6, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (37, 1, 7, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (38, 3, 7, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (39, 6, 7, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (40, 2, 7, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (41, 4, 7, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, Area, ExpDate, ProcStatus, ExpStatus)
VALUES (42, 5, 7, NULL, '2025-12-31', 'Not Started', 'Active');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (43, 1, 8, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (44, 3, 8, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (45, 6, 8, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (46, 2, 8, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (47, 4, 8, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (48, 5, 8, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (49, 1, 9, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (50, 2, 9, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (51, 4, 9, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (52, 3, 9, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (53, 5, 9, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (54, 6, 9, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (55, 1, 10, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (56, 2, 10, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (57, 4, 10, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (58, 3, 10, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (59, 5, 10, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (60, 6, 10, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (61, 1, 11, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (62, 2, 11, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (63, 4, 11, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (64, 3, 11, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (65, 5, 11, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (66, 6, 11, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (67, 1, 12, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (68, 2, 12, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (69, 4, 12, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (70, 3, 12, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (71, 5, 12, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (72, 6, 12, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (73, 1, 13, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (74, 2, 13, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (75, 4, 13, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (76, 3, 13, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (77, 5, 13, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (78, 6, 13, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (79, 1, 14, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (80, 2, 14, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (81, 4, 14, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (82, 3, 14, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (83, 5, 14, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (84, 6, 14, 'Not Started', 'No Expiry');

INSERT INTO PlantMonitoring (Id, PlantID, MonitoringID, ProcStatus, ExpStatus)
VALUES (85, 2, 15, 'Not Started', 'No Expiry');

-- Disable identity insert when done
SET IDENTITY_INSERT PlantMonitoring OFF;

-- Commit the transaction
COMMIT TRANSACTION;

PRINT 'Plant Monitoring data import complete: 80 records inserted successfully.'; 