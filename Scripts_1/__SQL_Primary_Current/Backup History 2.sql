
/*
When was Database Last Backed Up 

source: https://blog.sqlauthority.com/2017/01/22/database-last-backed-sql-server-interview-question-week-107/
date: 5/15/2017


*/

-- Get Backup History for required database
SELECT TOP 100
s.database_name,
CASE s.[type] WHEN 'D' THEN 'Full'
WHEN 'I' THEN 'Differential'
WHEN 'L' THEN 'Transaction Log'
END AS BackupType,
m.physical_device_name,
CAST(CAST(s.backup_size / 1000000 AS INT) AS VARCHAR(14)) + ' ' + 'MB' AS bkSize,
CAST(DATEDIFF(second, s.backup_start_date,
s.backup_finish_date) AS VARCHAR(4)) + ' ' + 'Seconds' TimeTaken,
s.backup_start_date,
s.server_name,
s.recovery_model
FROM msdb.dbo.backupset s
INNER JOIN msdb.dbo.backupmediafamily m ON s.media_set_id = m.media_set_id
ORDER BY backup_start_date DESC, backup_finish_date
GO