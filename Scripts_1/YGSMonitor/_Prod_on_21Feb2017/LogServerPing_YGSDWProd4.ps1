
# Purpose: periodically ping / test connection of a server, and log the results in YGSMonitor database.
# Status: this works for inserting data from William3 into ASDB ygsmonitor
# Date as of: 12/2/2016
# ToDo:
#	* create as a template
#	* ping list of servers
#	* source the list of servers from somewhere easily managed
# To apply to a new server, edit these: $target, insert into (x2)


Clear-Host
 
$SQLServer = "ygsdwprod4b.cloudapp.net, 37232"
# $SQLServer = "ygsdwprod4" # this will also work
# $SQLServer = "ygsmonitor.database.windows.net" # not used tempoarily

$target = "YGSDWProd4"

# $SQLDBName = "ActiveLive"
$SQLDBName = "ygsmonitor"

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection

# $MyUserID = "ygsadmin"
# $Pwd = "4YouthDev909"
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True"
# $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $MyUserID; Password = $Pwd;"
 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand

# foreach ($Server in $ServerName) {

    if (test-Connection -ComputerName $target -Count 2 -Quiet ) { 
		# write-Host # "$Server is alive and Pinging " -ForegroundColor Green
		$SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ('YGSDWProd4b','ping','true')"
		$SqlCmd.CommandText = $SqlQuery
		$SqlCmd.Connection = $SqlConnection

		$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
		$SqlAdapter.SelectCommand = $SqlCmd
		 
		$DataSet = New-Object System.Data.DataSet
		$SqlAdapter.Fill($DataSet)
			
		} else
		
		{ 
		$SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ('YGSDWProd4b','ping','false')"
		$SqlCmd.CommandText = $SqlQuery
		$SqlCmd.Connection = $SqlConnection

		$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
		$SqlAdapter.SelectCommand = $SqlCmd
		 
		$DataSet = New-Object System.Data.DataSet
		$SqlAdapter.Fill($DataSet)

		}	
#	 }
 
Start-Sleep -s 1

$SQLQuery = "spYGSMonitor"
$SqlCmd.CommandText = $SqlQuery
# $SqlCmd.Connection = $SqlConnection

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd

$dataset = new-object system.data.dataset
$sqladapter.fill($dataset) 

$SqlConnection.Close()
 
clear
 
$DataSet.Tables[0]
