SELECT step_name, h.run_duration, run_date, run_status, server
FROM msdb.dbo.sysjobs j
INNER JOIN msdb.dbo.sysjobhistory h
ON j.job_id = h.job_id
WHERE step_name IN ('Restore Active', 'Restore ActiveLive Package') AND run_status = 1 AND run_duration > 2
ORDER BY run_date DESC