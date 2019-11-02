/*

source: https://serverfault.com/questions/31554/how-to-check-progress-of-dbcc-shrinkfile
date: 10/5/2017


*/


select  T.text, R.Status, R.Command, DatabaseName = db_name(R.database_id)
        , R.cpu_time, R.total_elapsed_time, R.percent_complete
from    sys.dm_exec_requests R
        cross apply sys.dm_exec_sql_text(R.sql_handle) T




SELECT 
    d.name,
    percent_complete, 
    session_id,
    start_time, 
    status, 
    command, 
    estimated_completion_time, 
    cpu_time, 
    total_elapsed_time
FROM 
    sys.dm_exec_requests E left join
    sys.databases D on e.database_id = d.database_id
WHERE
    command in ('DbccFilesCompact','DbccSpaceReclaim')



select 
[status],
start_time,
convert(varchar,(total_elapsed_time/(1000))/60) + 'M ' + convert(varchar,(total_elapsed_time/(1000))%60) + 'S' AS [Elapsed],
convert(varchar,(estimated_completion_time/(1000))/60) + 'M ' + convert(varchar,(estimated_completion_time/(1000))%60) + 'S' as [ETA],
command,
[sql_handle],
database_id,
connection_id,
blocking_session_id,
percent_complete
from  sys.dm_exec_requests
where estimated_completion_time > 1
order by total_elapsed_time desc


-------------------------------
--Track DBCC shrink status
-------------------------------
select
a.session_id
, command
, b.text
, percent_complete
, done_in_minutes = a.estimated_completion_time / 1000 / 60
, min_in_progress = DATEDIFF(MI, a.start_time, DATEADD(ms, a.estimated_completion_time, GETDATE() ))
, a.start_time
, estimated_completion_time = DATEADD(ms, a.estimated_completion_time, GETDATE() )
from sys.dm_exec_requests a
CROSS APPLY sys.dm_exec_sql_text(a.sql_handle) b
where command like '%dbcc%'