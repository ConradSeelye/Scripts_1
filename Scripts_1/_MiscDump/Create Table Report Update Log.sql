/*
EffectiveDateByReport

Purpose: Tracking the updates of the various reports. Read by SSRS and any other end-user reporting tool. 
By: Conrad
Date: 10/2/2015

Notes:
* keep this sql as the definition; to add/remove reports from the list


/*
CREATE TABLE ReportingUpdateLog(
ReportName NVARCHAR(100),
Status NVARCHAR(30),
StartTime DATETIME,
EndTime DATETIME
)

SELECT * FROM ReportingUpdateLog

SELECT EffectiveDateTime 
FROM EffectiveDateByReport
WHERE ReportName = 'School Year Skills Paperwork Tracking'

*/

INSERT INTO ReportingUpdateLog (ReportName)
VALUES ('School Year Skills Paperwork Tracking')

UPDATE ReportingUpdateLog
SET Status = 'updating', 
StartTime = GETDATE(), 
EndTime = NULL

UPDATE ReportingUpdateLog
SET Status = 'updating', 
EndTime = GETDATE()

SELECT * FROM ReportingUpdateLog




