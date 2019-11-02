/*


sources and reference:
https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-performance-counters-transact-sql
WMI Performance Counter Types
https://msdn.microsoft.com/library/aa394569.aspx




*/

--USE YMCA
--GO

DECLARE @cntr_value bigint

SELECT @cntr_value = cntr_value
    FROM sys.dm_os_performance_counters
    WHERE counter_name = 'transactions/sec'
        -- AND object_name = 'SQLServer:Databases'
		AND object_name = 'MSSQL$GONZO:Databases'                                                                                                         
        AND instance_name = 'ymca'

WAITFOR DELAY '00:00:01'

SELECT

 cntr_value - @cntr_value as TPSCount
 -- INTO Monitor.dbo.TPS
    FROM sys.dm_os_performance_counters
    WHERE counter_name = 'transactions/sec'
        -- AND object_name = 'SQLServer:Databases'
		AND object_name = 'MSSQL$GONZO:Databases'                                                                                                         
        AND instance_name = 'ymca'


--SELECT TOP 100 * 
--FROM sys.dm_os_performance_counters
--WHERE object_name = 'SQLServer:Databases'

--SELECT object_name
--FROM sys.dm_os_performance_counters
--GROUP BY object_name


