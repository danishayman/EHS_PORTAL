-- Update date columns to datetime in PlantMonitorings table
ALTER TABLE PlantMonitorings
    ALTER COLUMN ExpDate datetime NULL,
    ALTER COLUMN QuoteDate datetime NULL,
    ALTER COLUMN QuoteSubmitDate datetime NULL,
    ALTER COLUMN QuoteCompleteDate datetime NULL,
    ALTER COLUMN EprDate datetime NULL,
    ALTER COLUMN EprSubmitDate datetime NULL,
    ALTER COLUMN EprCompleteDate datetime NULL,
    ALTER COLUMN WorkDate datetime NULL,
    ALTER COLUMN WorkSubmitDate datetime NULL,
    ALTER COLUMN WorkCompleteDate datetime NULL;

-- Print confirmation
PRINT 'Successfully updated date columns to datetime in PlantMonitorings table.'; 