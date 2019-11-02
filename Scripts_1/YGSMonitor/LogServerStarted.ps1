
# this works for inserting data from William3 into ASDB ygsmonitor, 8/12/2016

Clear-Host
 
# $SQLServer = "ygsdwprod4.cloudapp.net, 37232"
# $SQLServer = "YGSDevDW.cloudapp.net, 37232" # this works
$SQLServer = "ygsmonitor.database.windows.net"

# $SQLDBName = "ActiveLive"
$SQLDBName = "ygsmonitor"
# $SQLQuery = "SELECT TOP 10 Activity_ID, ActivityName FROM [dbo].[ACTIVITIES]"

$SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ('BIDevSQLb Started','','')"

 
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
# $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True"

$MyUserID = "ygsadmin"
$Pwd = "4YouthDev909"
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $MyUserID; Password = $Pwd;"
# User ID = $uid; Password = $pwd;
 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
 
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
 
$SqlConnection.Close()
 
clear
 
$DataSet.Tables[0]
