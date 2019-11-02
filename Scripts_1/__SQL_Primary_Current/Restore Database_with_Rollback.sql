/*
summary: basic restore with rollback
date: 12/18/2015

*/


ALTER DATABASE [ActiveLive] SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE
GO 

USE [master]
RESTORE DATABASE [ActiveLive] 
-- FROM  DISK = N'E:\ActiveLive\Servlet.SeattleYMCA_db_20151214.bak' 
FROM  DISK = N'I:\FTP\Active\Servlet.SeattleYMCA_db_20160101013756.BAK'
WITH  FILE = 1,  
MOVE N'RECNETSTARTUP_dat' TO N'G:\ActiveSQLData\SEATTLEYMCA.mdf',  
MOVE N'RECNETSTARTUP_log' TO N'H:\ActiveSQLLogs\SEATTLEYMCA_log.ldf',  
NOUNLOAD,  REPLACE,  STATS = 1

GO

ALTER DATABASE [ActiveLive] SET MULTI_USER WITH ROLLBACK IMMEDIATE
GO