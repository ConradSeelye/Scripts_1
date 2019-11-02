/*
EffectiveDateByReport

Purpose: tracking the effective date of the various reports. Read by SSRS and any other end-user reporting tool. 
By: Conrad
Date: 10/2/2015

Notes:
* keep this sql as the definition; to add/remove reports from the list


/*
CREATE TABLE EffectiveDateByReport(
ReportName NVARCHAR(100),
EffectiveDateTime DATETIME
)

SELECT * FROM EffectiveDateByReport

UPDATE EffectiveDateByReport
SET EffectiveDateTime = GETDATE()
WHERE ReportName = 'School Year Skills Paperwork Tracking'

SELECT EffectiveDateTime 
FROM EffectiveDateByReport
WHERE ReportName = 'School Year Skills Paperwork Tracking'

*/

INSERT INTO EffectiveDateByReport 
VALUES ('School Year Skills Paperwork Tracking', NULL)





