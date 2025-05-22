-- Script to copy all tables from dbo schema to ESH.FETS schema
-- Make sure ESH.FETS schema exists before running this script

-- Copy ActivityLogs table
SELECT *
INTO ESH.FETS.ActivityLogs
FROM FETS.dbo.ActivityLogs;

-- Copy EmailRecipients table
SELECT *
INTO ESH.FETS.EmailRecipients
FROM FETS.dbo.EmailRecipients;

-- Copy FireExtinguishers table
SELECT *
INTO ESH.FETS.FireExtinguishers
FROM FETS.dbo.FireExtinguishers;

-- Copy FireExtinguisherTypes table
SELECT *
INTO ESH.FETS.FireExtinguisherTypes
FROM FETS.dbo.FireExtinguisherTypes;

-- Copy Levels table
SELECT *
INTO ESH.FETS.Levels
FROM FETS.dbo.Levels;

-- Copy MapImages table
SELECT *
INTO ESH.FETS.MapImages
FROM FETS.dbo.MapImages;

-- Copy Plants table
SELECT *
INTO ESH.FETS.Plants
FROM FETS.dbo.Plants;

-- Copy ServiceReminders table
SELECT *
INTO ESH.FETS.ServiceReminders
FROM FETS.dbo.ServiceReminders;

-- Copy Status table
SELECT *
INTO ESH.FETS.Status
FROM FETS.dbo.Status;

-- Copy Users table
SELECT *
INTO ESH.FETS.Users
FROM FETS.dbo.Users;



-- Script to copy all tables from CLIP.dbo schema to ESH.CLIP schema
-- Make sure ESH.CLIP schema exists before running this script

-- Copy MigrationHistory table
SELECT * INTO ESH.CLIP.__MigrationHistory FROM CLIP.dbo.__MigrationHistory;

-- Copy ActivityTrainings table
SELECT * INTO ESH.CLIP.ActivityTrainings FROM CLIP.dbo.ActivityTrainings;

-- Copy AspNetRoles table
SELECT * INTO ESH.CLIP.AspNetRoles FROM CLIP.dbo.AspNetRoles;

-- Copy AspNetUserClaims table
SELECT * INTO ESH.CLIP.AspNetUserClaims FROM CLIP.dbo.AspNetUserClaims;

-- Copy AspNetUserLogins table
SELECT * INTO ESH.CLIP.AspNetUserLogins FROM CLIP.dbo.AspNetUserLogins;

-- Copy AspNetUserRoles table
SELECT * INTO ESH.CLIP.AspNetUserRoles FROM CLIP.dbo.AspNetUserRoles;

-- Copy AspNetUsers table
SELECT * INTO ESH.CLIP.AspNetUsers FROM CLIP.dbo.AspNetUsers;

-- Copy CertificateOfFitness table
SELECT * INTO ESH.CLIP.CertificateOfFitness FROM CLIP.dbo.CertificateOfFitness;

-- Copy CompetencyModules table
SELECT * INTO ESH.CLIP.CompetencyModules FROM CLIP.dbo.CompetencyModules;

-- Copy Monitoring table
SELECT * INTO ESH.CLIP.Monitoring FROM CLIP.dbo.Monitoring;

-- Copy PlantMonitoring table
SELECT * INTO ESH.CLIP.PlantMonitoring FROM CLIP.dbo.PlantMonitoring;

-- Copy Plants table
SELECT * INTO ESH.CLIP.Plants FROM CLIP.dbo.Plants;

-- Copy UserCompetencies table
SELECT * INTO ESH.CLIP.UserCompetencies FROM CLIP.dbo.UserCompetencies;

-- Copy UserPlants table
SELECT * INTO ESH.CLIP.UserPlants FROM CLIP.dbo.UserPlants;