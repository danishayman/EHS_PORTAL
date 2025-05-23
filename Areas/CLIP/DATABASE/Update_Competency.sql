CREATE TABLE [UserPoints] (
    Id INT IDENTITY PRIMARY KEY,
    UserId NVARCHAR(128), -- Matches the type of [AspNetUsers].[Id]
    CompetencyModuleId INT,
    PointsEarned INT,
    PointsRemaining INT,
    LastEvaluatedDate DATE,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id),
    FOREIGN KEY (CompetencyModuleId) REFERENCES CompetencyModules(Id
);


ALTER TABLE [CompetencyModules]
ADD [PointType] VARCHAR(10), -- 'CPD' or 'CEP'
    [TotalPoints] INT,       -- Total points awarded upon completion
    [AnnualPointDeduction] INT -- Points deducted annually after completion


-- Add the missing foreign key constraint to CertificateOfFitness table
ALTER TABLE [dbo].[CertificateOfFitness]
ADD CONSTRAINT [FK_CertificateOfFitness_Plant] 
FOREIGN KEY ([PlantId]) REFERENCES [dbo].[Plants]([Id]);