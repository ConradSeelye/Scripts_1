<#
Start a service if it's stopped.
Date: 9/29/2017
Context: at YGS BI project. The sql tabular service was found to be stopped, which broke ETL. 
We think this has happened before, and in any case it's a valuable layer of monitoring and alerting.

#>

# Prod version:

Clear-Host
$MyServiceName = "MSSQLSERVER"

$MyService = Get-Service | Where-Object {$_.name -like "MSSQLSERVER"} # | Format-Table status
$MyStatus = $MyService.Status

# If ($MyStatus -eq "Stopped")  {$MyService.Start()}
# If ($MyStatus -eq "Paused") {$MyService.Continue()}


If ($MyStatus -eq "Stopped") {
    Write-Host "sql is stopped"
    Write-Host "..."}


Write-Host "end"













############ Dev Notes
# Clear-Host

# source: https://technet.microsoft.com/en-us/library/ee176858.aspx
<#
Get-Service | Where-Object {$_.status -eq "stopped"}
Get-Service | Where-Object {$_.status -ne "stopped"}
Get-Service | Where-Object {$_.status -eq "running"}
Get-Service | Where-Object {$_.name -eq "MSSQLSERVER"}
#>


# source: https://msdn.microsoft.com/en-us/library/microsoft.powershell.core.activities.whereobject_properties(v=vs.85).aspx
# ok
# Get-Service | Where-Object {$_.name -like "MSOLAP*TAB*"} 

# $MyService = Get-Service | Where-Object {$_.name -like "MSOLAP*TAB*"} # | Format-Table status
<#
$MyService = Get-Service | Where-Object {$_.name -like "MSSQLSERVER"} # | Format-Table status
$MyService
$MyStatus = $MyService.Status
$MyStatus
#>

# toggle the service status
# if ($MyService.Status -eq "Running") {$MyService.Stop()} elseif ($MyService.Status -eq "Stopped") {$MyService.Start()}

# start if it's stopped
# https://gallery.technet.microsoft.com/scriptcenter/Start-Stopped-Service-70a75199
# if ($MyService.Status -eq "Stopped") {$MyService.Start()} 

# add looping for a server list
<# 
https://social.technet.microsoft.com/Forums/scriptcenter/en-US/dd25e0ce-dd70-412c-90e8-c6046d989098/powershell-getservice-computername?forum=ITCG
$serverlist = "server1", "server2", "server3"
foreach ($server in $serverlist) {
get-service ServiceName* -ComputerName $server
}
#>











