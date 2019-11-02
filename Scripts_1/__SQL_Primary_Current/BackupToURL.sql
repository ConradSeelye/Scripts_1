/*
Backup and Restore to Windows Azure Blob Storage Service
source: https://msdn.microsoft.com/en-US/library/jj720558(v=sql.120).aspx
date: 1/26/2016
note:
* this worked on local AO003131LT and BIDevSQLe in Azure
*/


break!

-- Create custom cred
CREATE CREDENTIAL YGS_ygsdw_cred
WITH IDENTITY= 'ygsdw' 
, SECRET = '2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ==' 

CREATE CREDENTIAL DailyBackupHoshi_ygsdwdevbu
WITH IDENTITY= 'ygsdwdevbu' 
, SECRET = '5qjFpeVsxKw45BEmf+1EazYGY4UySZJLZt8WdPnyxbsjQWFfNs1pCmkDUyBZeHYM4WChoJanWk3/oWyAICpdwg==' 

SELECT * FROM sys.credentials
-- DROP CREDENTIAL DailyBackupHoshiygsdwdevbu

-- Backup to Storage
-- ok 7/13/2017
BACKUP DATABASE test
TO URL = 'https://ygsdw.blob.core.windows.net/test/test_20170713.bak' 
WITH CREDENTIAL = 'YGS_ygsdw_cred';
GO 

-- Backup to Storage
-- ok
BACKUP DATABASE Hoshi
TO URL = 'https://ygsdwdevbu.blob.core.windows.net/ygsdwdev/hoshi_20160126_1107.bak' 
/* URL includes the endpoint for the BLOB service, followed by the container name, and the name of the backup file*/ 
WITH CREDENTIAL = 'DailyBackupHoshi_ygsdwdevbu';
/* name of the credential you created in the previous step */ 
GO 

-- Restore from Storage.
-- Cred must be on target sql
-- ok on e
RESTORE DATABASE Hoshi
FROM URL = 'https://ygsdw.blob.core.windows.net/hoshidev/hoshi_20160125_1608.bak' 
WITH MOVE 'Hoshi' TO 'E:\Hoshi\DW.mdf',
MOVE 'Hoshi_log' TO 'E:\Hoshi\DW_log.mdf',
CREDENTIAL = 'DailyBackupHoshi',
STATS = 1 -- – use this to see monitor the progress
GO


