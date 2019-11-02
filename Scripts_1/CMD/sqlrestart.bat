rem This restarts the SQL services. It can be called by Task Scheduler.
rem context: YGS BI infra;  used on Prod w/o problems
rem date: 10/9/2017
rem developed by Jarrod Nilles


net stop  MSOLAP$Hoshi_Tab
net stop  SQLServerAgent
net stop  MSSQLLaunchpad
net stop  MSSQLServer

:stop
rem cause a ~10 second sleep before checking the service state
ping 127.0.0.1 -n 10 -w 1000 > nul

sc query MSSQLServer| find /I "STATE" | find "STOPPED"
if errorlevel 1 goto :stop
goto :start


:start
rem net start | find /i "MSSQLServer| ">nul && goto :start

net start MSSQLServer
net start SQLServerAgent
net start MSOLAP$Hoshi_Tab
net start  MSSQLLaunchpad

rem powershell -command "Restart-Service MSSQLSERVER -Force"

rem start /B /WAIT CMD /C "sc stop myservice"
rem start /B /WAIT CMD /C "sc start myservice"
