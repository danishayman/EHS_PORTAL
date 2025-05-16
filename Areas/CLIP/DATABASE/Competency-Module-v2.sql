DROP TABLE UserPoints;
-- Remove existing columns
ALTER TABLE CompetencyModules
DROP COLUMN ValidityMonths, PointType, TotalPoints;

-- Add new column
ALTER TABLE CompetencyModules
ADD CompetencyType NVARCHAR(100);

ALTER TABLE AspNetUsers
ADD CEP_Points INT,
    CPD_Points INT;