-- Script to create ActivityTraining table
CREATE TABLE [dbo].[ActivityTraining] (
    [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [UserId] NVARCHAR(128) NOT NULL,
    [ActivityName] NVARCHAR(MAX) NOT NULL,
    [ActivityDate] DATETIME NOT NULL,
    [Document] NVARCHAR(MAX) NULL,
    [CEPPointsGained] FLOAT NULL,
    [CPDPointsGained] FLOAT NULL,
    CONSTRAINT [FK_ActivityTraining_AspNetUsers] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])
); 