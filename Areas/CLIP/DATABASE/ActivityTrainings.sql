-- Script to create ActivityTrainings table
CREATE TABLE [dbo].[ActivityTrainings] (
    [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [UserId] NVARCHAR(128) NOT NULL,
    [ActivityName] NVARCHAR(MAX) NOT NULL,
    [ActivityDate] DATETIME NOT NULL,
    [Document] NVARCHAR(MAX) NULL,
    [CEPPointsGained] INT NULL DEFAULT 0,
    [CPDPointsGained] INT NULL DEFAULT 0,
    CONSTRAINT [FK_ActivityTrainings_AspNetUsers] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])
    
); 