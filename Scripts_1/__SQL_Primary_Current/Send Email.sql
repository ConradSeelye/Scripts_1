EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Hoshi',
	@recipients = '8055919118@vtext.com; cseelye@seattleymca.org',
    @subject = 'test 4',
	@body = ''