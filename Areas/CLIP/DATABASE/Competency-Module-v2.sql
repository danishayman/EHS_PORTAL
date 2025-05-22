DROP TABLE UserPoints;
-- Remove existing columns
ALTER TABLE CompetencyModules
DROP COLUMN ValidityMonths, PointType, TotalPoints;

-- Add new column
ALTER TABLE CompetencyModules
ADD CompetencyType NVARCHAR(100);

ALTER TABLE AspNetUsers
ADD Atom_CEP INT,
    DOE_CPD INT;


ALTER TABLE UserCompetencies
ADD Building NVARCHAR(100);
