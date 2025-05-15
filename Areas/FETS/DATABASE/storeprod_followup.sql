USE [FETS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Send_ServiceReminder_Emails] AS 
BEGIN 
SET NOCOUNT ON;

-- Check if there are any reminders due today
IF NOT EXISTS (SELECT 1 FROM [FETS].[dbo].[ServiceReminders] WHERE ReminderDate = CAST(GETDATE() AS DATE))
BEGIN
    -- No reminders for today, exit procedure
    RETURN;
END

-- Get email recipients for service reminders
DECLARE @emailList varchar(max) = '';
SELECT @emailList = @emailList + EmailAddress + '; ' 
FROM [FETS].[dbo].[EmailRecipients] 
WHERE IsActive = 1 
AND (NotificationType = 'Service' OR NotificationType = 'All');

-- Remove trailing separator
IF LEN(@emailList) > 0
  SET @emailList = LEFT(@emailList, LEN(@emailList) - 2);s

-- Get current date for the email
DECLARE @currentDate varchar(20) = CONVERT(varchar, GETDATE(), 106);

-- Process each reminder due today
DECLARE @reminderID int
DECLARE @FEID int
DECLARE @reminderSubject nvarchar(100)
DECLARE @reminderNotes nvarchar(max)
DECLARE @serialNumber nvarchar(50)
DECLARE @areaCode nvarchar(50)
DECLARE @plantName nvarchar(100)
DECLARE @levelName nvarchar(50)
DECLARE @location nvarchar(255)
DECLARE @typeName nvarchar(50)
DECLARE @dateExpired date
DECLARE @dateSentService datetime
DECLARE @htmlContent nvarchar(max)

-- Create cursor for reminders due today
DECLARE reminder_cursor CURSOR FOR 
SELECT 
    sr.ReminderID,
    sr.FEID,
    sr.ReminderSubject,
    sr.ReminderNotes,
    fe.SerialNumber,
    fe.AreaCode,
    p.PlantName,
    l.LevelName,
    fe.Location,
    fet.TypeName,
    fe.DateExpired,
    fe.DateSentService
FROM [FETS].[dbo].[ServiceReminders] sr
JOIN [FETS].[dbo].[FireExtinguishers] fe ON sr.FEID = fe.FEID
JOIN [FETS].[dbo].[Plants] p ON fe.PlantID = p.PlantID
JOIN [FETS].[dbo].[Levels] l ON fe.LevelID = l.LevelID
JOIN [FETS].[dbo].[FireExtinguisherTypes] fet ON fe.TypeID = fet.TypeID
WHERE sr.ReminderDate = CAST(GETDATE() AS DATE)
AND sr.IsActive = 1;

OPEN reminder_cursor;
FETCH NEXT FROM reminder_cursor INTO 
    @reminderID, @FEID, @reminderSubject, @reminderNotes, 
    @serialNumber, @areaCode, @plantName, @levelName, 
    @location, @typeName, @dateExpired, @dateSentService;

-- Loop through all reminders due today
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Create email content with fire extinguisher details
    SET @htmlContent = '<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fire Extinguisher Service Reminder</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #d9534f;
            color: white;
            padding: 15px;
            text-align: center;
            border-radius: 5px 5px 0 0;
        }
        .content {
            background-color: #f9f9f9;
            padding: 20px;
            border-left: 1px solid #dddddd;
            border-right: 1px solid #dddddd;
        }
        .footer {
            background-color: #eeeeee;
            padding: 15px;
            text-align: center;
            font-size: 12px;
            color: #777777;
            border-radius: 0 0 5px 5px;
            border: 1px solid #dddddd;
        }
        .info-box {
            background-color: #f5f5f5;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 15px 0;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        .info-table th, .info-table td {
            padding: 8px 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .info-table th {
            background-color: #f0f0f0;
            font-weight: bold;
        }
        .highlight-box {
            background-color: #fcf8e3;
            color: #8a6d3b;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
            border: 1px solid #faebcc;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Fire Extinguisher Service Follow-up Reminder</h1>
            <p>' + @currentDate + '</p>
        </div>
        
        <div class="content">
            
            <p>Dear Safety Team,</p>
            
            <p>This is a <strong>follow-up reminder</strong> regarding a fire extinguisher that had been serviced. Please check on the status of this unit and take appropriate action.</p>
            
            <div class="highlight-box">
                <h3>⚠️ ' + @reminderSubject + '</h3>
                <p>' + ISNULL(@reminderNotes, 'No additional notes.') + '</p>
            </div>
            
            <h3>Fire Extinguisher Details:</h3>
            <div class="info-box">
                <table class="info-table">
                    <tr>
                        <th>Serial Number</th>
                        <td>' + @serialNumber + '</td>
                        <th>Area Code</th>
                        <td>' + ISNULL(@areaCode, 'N/A') + '</td>
                    </tr>
                    <tr>
                        <th>Plant</th>
                        <td>' + @plantName + '</td>
                        <th>Level</th>
                        <td>' + @levelName + '</td>
                    </tr>
                    <tr>
                        <th>Location</th>
                        <td colspan="3">' + @location + '</td>
                    </tr>
                    <tr>
                        <th>Type</th>
                        <td>' + @typeName + '</td>
                        <th>Previous Expiry Date</th>
                        <td>' + CONVERT(varchar, @dateExpired, 103) + '</td>
                    </tr>
                    <tr>
                        <th>Sent to Service On</th>
                        <td colspan="3">' + CONVERT(varchar, @dateSentService, 113) + '</td>
                    </tr>
                </table>
            </div>
            
            <h3>Recommended Actions:</h3>
            <ul>
                <li>Contact the vendor to settle any pending bills.</li>
                <li>Verify if a replacement unit had been returned to the vendor.</li>
                <li>Update the FETS system when service is completed.</li>
                <li>Ensure the new expiry date is correctly entered once the unit is returned</li>
            </ul>
            
            <p>Timely follow-up helps maintain adequate fire safety coverage in all areas and ensures compliance with safety regulations.</p>
            
            <p>Thank you for your prompt attention to this matter.</p>
            
            <p>Best regards,<br>Environment, Health and Safety Department (EHS)</p>
            
        </div>
        
        <div class="footer">
            <p>This is an automated message from the Fire Extinguisher Tracking System (FETS).</p>
            <p>' + CAST(YEAR(GETDATE()) AS varchar(4)) + ' INARI AMERTRON BHD. - Environment, Health and Safety Department (EHS)</p>
        </div>
    </div>
</body>
</html>';

    -- Insert into email table with error handling
    BEGIN TRY
        INSERT INTO [AUTOREPORT].[dbo].TAUTO_EMAIL (
            EMAIL_DESC, 
            TOLIST, 
            CCLIST, 
            EMAIL_TITLE, 
            EMAIL_CONTENT, 
            CREATE_BY, 
            CREATE_DATE, 
            UPDATE_FLAG
        ) 
        VALUES (
            'Fire Extinguisher Service Reminder - ' + @serialNumber, 
            @emailList, 
            '', 
            'Fire Extinguisher Service Follow-up: ' + @serialNumber + ' - ' + @reminderSubject, 
            @htmlContent, 
            'INARI PORTAL', 
            GETDATE(), 
            'N'
        );
        
        -- Update the reminder record after email is sent
        UPDATE [FETS].[dbo].[ServiceReminders]
        SET 
            LastSent = GETDATE(),
            EmailSentCount = ISNULL(EmailSentCount, 0) + 1
        WHERE ReminderID = @reminderID;
        
    END TRY
    BEGIN CATCH
        -- Log error to a table
        INSERT INTO [FETS].[dbo].[ErrorLog] (
            ErrorMessage,
            ErrorLine,
            ErrorProcedure,
            ErrorDateTime
        )
        VALUES (
            ERROR_MESSAGE(),
            ERROR_LINE(),
            ERROR_PROCEDURE(),
            GETDATE()
        );
    END CATCH

    FETCH NEXT FROM reminder_cursor INTO 
        @reminderID, @FEID, @reminderSubject, @reminderNotes, 
        @serialNumber, @areaCode, @plantName, @levelName, 
        @location, @typeName, @dateExpired, @dateSentService;
END

-- Clean up cursor
CLOSE reminder_cursor;
DEALLOCATE reminder_cursor;

END