-- SQL script to update ExpStatus from 'Valid' to 'Active'
-- Run this on the database to update any existing records

-- Update PlantMonitoring table
UPDATE PlantMonitorings
SET ExpStatus = 'Active' 
WHERE ExpStatus = 'Valid';

-- Print count of updated records
PRINT 'Updated ' + CAST(@@ROWCOUNT AS VARCHAR) + ' records in PlantMonitorings table.'; 