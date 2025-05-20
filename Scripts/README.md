# EHS Portal Monitoring Data Import

This directory contains SQL scripts to import monitoring data into the EHS Portal database based on the monitoring types table provided.

## Available Scripts

1. `InsertMonitoringData.sql` - Inserts the monitoring types with their IDs, names, categories, and frequencies
2. `InsertPlantMonitoringData.sql` - Creates PlantMonitoring records for each plant and monitoring type
3. `ImportMonitoringFromImage.sql` - Combined script that does both operations in one go
4. `InsertPlantMonitoringExistingData.sql` - Inserts exact copies of existing PlantMonitoring records with all data (areas, expiry dates, process statuses, etc.)

## Monitoring Types

The scripts will insert the following monitoring types:

| MonitoringID | MonitoringName                             | MonitoringCategory | MonitoringFreq (months) |
|--------------|--------------------------------------------|--------------------|-------------------------|
| 2            | Air Monitoring                             | Environment        | 12                      |
| 3            | PUMPHOUSE                                  | Environment        | 12                      |
| 4            | GENSET                                     | Environment        | 12                      |
| 5            | Storm Water Monitoring                     | Environment        | 6                       |
| 6            | Drinking Water                             | Environment        | 12                      |
| 7            | Boundary Noise Monitoring                  | Environment        | 12                      |
| 8            | Noise Risk Assessment(NRA)                 | Health & Safety    | 60                      |
| 9            | Chemical Health Risk Assessment (CHRA)     | Health & Safety    | 60                      |
| 10           | Local Exhaust Ventilation Monitoring (LEV) | Health & Safety    | 12                      |
| 11           | Fire Certificate                           | Health & Safety    | 12                      |
| 12           | ERT Certificate                            | Health & Safety    | 24                      |
| 13           | KPDNKK Permit                              | Health & Safety    | 12                      |
| 14           | Poison Permit                              | Health & Safety    | 12                      |
| 15           | Psychotropic Permit                        | Health & Safety    | 12                      |

## Usage Instructions

### Prerequisites

- Ensure the EHS Portal database exists and is accessible
- Ensure you have the necessary permissions to modify the database
- Ensure the Plants table already contains the required plant records (Plant IDs 1, 2, 3, 4, 5, 6)

### Running the Import Script

#### Option 1: Fresh Database

To import the basic monitoring structure in one go:

1. Open SQL Server Management Studio
2. Connect to your database server
3. Open the `ImportMonitoringFromImage.sql` script
4. Execute the script

The script will:
1. Insert all monitoring types from the provided table
2. Create PlantMonitoring records for each monitoring type
3. Set initial expiry dates based on monitoring frequency:
   - 12 months for yearly monitoring
   - 6 months for half-yearly monitoring
   - 24 months for 2-year monitoring
   - 60 months for 5-year monitoring
4. Display a summary of the imported data

#### Option 2: Import Complete Records

If you need to import the exact records with all data (including Areas, ExpDates, Process Statuses, etc.):

1. Open SQL Server Management Studio
2. Connect to your database server
3. Open the `InsertPlantMonitoringExistingData.sql` script
4. Execute the script

This script will create 80 records with their exact data, including:
- Specific IDs from 6-85
- All area information
- Expiry dates
- Quote details
- EPR details
- Work details
- Process status and Expiry status

### Verification

After running the script, you can verify the import by:

1. Checking the Monitoring table:
```sql
SELECT * FROM Monitoring ORDER BY MonitoringCategory, MonitoringName;
```

2. Checking the PlantMonitoring records:
```sql
SELECT pm.Id, p.PlantName, m.MonitoringName, pm.Area, pm.ExpDate
FROM PlantMonitoring pm
JOIN Plants p ON pm.PlantID = p.Id
JOIN Monitoring m ON pm.MonitoringID = m.MonitoringID
ORDER BY p.PlantName, m.MonitoringName;
```

3. Checking monitoring counts by category:
```sql
SELECT 
    m.MonitoringCategory,
    COUNT(pm.Id) AS RecordCount
FROM 
    PlantMonitoring pm
    INNER JOIN Monitoring m ON pm.MonitoringID = m.MonitoringID
GROUP BY 
    m.MonitoringCategory
ORDER BY 
    m.MonitoringCategory;
```

## Troubleshooting

If you encounter errors:

1. Make sure the Plants table already has records for plants 1, 2, 3, 4, 5, and 6
2. Check if the Monitoring and PlantMonitoring tables already exist
3. If the script fails at a specific point, you can run the individual scripts separately
4. If you need to clean existing data, uncomment the DELETE and DBCC CHECKIDENT lines at the beginning of the script 