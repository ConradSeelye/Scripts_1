
# Purpose: periodically ping / test connection of a server, and log the results in YGSMonitor database.
# Status: this works for inserting data from William3 into ASDB ygsmonitor
# Date as of: 12/2/2016
# ToDo:
#	* create as a template
#	* ping list of servers
#	* source the list of servers from somewhere easily managed



Clear-Host
 
# $SQLServer = "ygsdwprod4.cloudapp.net, 37232"
# $SQLServer = "YGSDevDW.cloudapp.net, 37232" # this works
$SQLServer = "ygsmonitor.database.windows.net"

# $SQLDBName = "ActiveLive"
$SQLDBName = "ygsmonitor"
# $SQLQuery = "SELECT TOP 10 Activity_ID, ActivityName FROM [dbo].[ACTIVITIES]"

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
# $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True"

$MyUserID = "ygsadmin"
$Pwd = "4YouthDev909"
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $MyUserID; Password = $Pwd;"
# User ID = $uid; Password = $pwd;
 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand

# foreach ($Server in $ServerName) {

	if (test-Connection -ComputerName "ygsdwprod4" -Count 2 -Quiet ) { 
		# write-Host # "$Server is alive and Pinging " -ForegroundColor Green
		$SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ('YGSDWProd4 ping','','')"
		$SqlCmd.CommandText = $SqlQuery
		$SqlCmd.Connection = $SqlConnection

		$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
		$SqlAdapter.SelectCommand = $SqlCmd
		 
		$DataSet = New-Object System.Data.DataSet
		$SqlAdapter.Fill($DataSet)
			
		} else
		
		{ 
		$SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ('YGSDWProd4 no ping','','')"
		$SqlCmd.CommandText = $SqlQuery
		$SqlCmd.Connection = $SqlConnection

		$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
		$SqlAdapter.SelectCommand = $SqlCmd
		 
		$DataSet = New-Object System.Data.DataSet
		$SqlAdapter.Fill($DataSet)

		}	
#	 }
 
$SqlConnection.Close()
 
clear
 
$DataSet.Tables[0]
