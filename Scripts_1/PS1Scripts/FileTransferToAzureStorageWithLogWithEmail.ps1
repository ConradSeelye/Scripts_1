<#
Copy Camp Brain from \\BillyIdle to local, and then to Azure Storage
as of 5/23/2017
by Conrad
ToDo:
* Fix the email problem. See the commented-out section below. 
* Obfuscate the account key perhaps 
* In the email $Body add KB article to reference.
* Get and report file size from Azure Storage.
* Add Test-Path to the local storage path. 
* Database connection: obfuscate $Pwd
#>


Clear-Host
$Now = Get-Date
Write-Host $Now

$Ctr = "campbraincurrent"
# $Ctr = "campbraincurrenttest" # temp
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
# $SourceFile = "\\billyidle\CampBrain\Summer\YMCA Seattle Camp 2017.mdb"
# test -- 
$SourceFile = "\\billyidle\CampBrain\Summer\_test\YMCA Seattle Camp 2017.mdb" # temp
$Drive = "C:\CampBrain\"
# $Drive = "C:\CampBrain_b\" # temp

$dateFormat = get-date -format yyyyMMdd
# $FileName = "YMCA Seattle Camp 2016.mdb" + "_" + $dateFormat

$FileName = $dateFormat + "_" + "YMCA Seattle Camp 2017.mdb"
# $FileName = $dateFormat + "_" + "YMCA Seattle Camp 2017_test.mdb" # temp xxx
Write-Host "Copying " + $FileName + " from " + $SourceFile + " to D:\" + $FileName

$Destination = $Drive + $FileName
# $Destination = "C:\CampBrain\20170522_YMCA Seattle Camp 2017_test.mdb" # xx
write-host $Destination

# Prepare email
$To = @("Conrad <cseelye@seattleymca.org>", "Conrad2 <conrads1966@gmail.com>", "Shelley <shill@seattleymca.org>", "Tara <tchamberlain@seattleymca.org>")
# $To = @("Conrad <cseelye@seattleymca.org>", "Conrad2 <conrads1966@gmail.com>")
$Subject = "William3: CampBrain to Az upload"
# $Body = "Shelley and Tara: just testing. I'll try not to flood your inbox. `n `n"
$Body = "`n"
$From = "hoshiyama.ygs@outlook.com"
$UserName = "hoshiyama.ygs@outlook.com"

$PasswordFolder = "c:\_temp3"
$PasswordFile = "password.txt"
$PasswordPath = $PasswordFolder + "\" + $PasswordFile

# First time create password file
# This isn't necessary if we can't send email from within a scheduled task. 
If (Test-Path $PasswordFolder)
   {Write-Host "$PasswordFolder exists"}
Else
   {Write-Host "$PasswordFolder does not exist.  Creating it now."
    New-Item -ItemType directory $PasswordFolder} 

If (!(Test-Path $PasswordPath))
{
    Read-Host -AsSecureString | convertfrom-securestring | out-file $PasswordPath
}
$pass = cat $PasswordPath | ConvertTo-SecureString
$MyCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName, $pass


# Remove all contents $Drive
Write-Host "Deleting contents of $Drive."
Get-Childitem $Drive | remove-item -force

<#
Try {
    $Destination_TestPath = Test-Path $Destination
    Write-Host "local path ok"
    }
Catch [Microsoft.WindowsAzure.Commands.Storage.Common.ResourceNotFoundException]
    {Write-Host "local path not ok"}
#>


$Now = Get-Date
Write-Host $Now

# Copy to local
Write-Host "Copying to local William3."
If (Test-Path $SourceFile)
{
    Copy-Item $SourceFile -Destination $Destination
    $Body = $Body + "Copied $SourceFile to William3:\$Destination at $Now. `n `n"
} 
Else {
	Write-Host "No such path " $SourceFile
    $Body = "$SourceFile did not copy to William3. `n `n"
}

Write-Host "Done copying to local."

# upload to Azure Storage
# Get-ChildItem –Path $Drive | Set-AzureStorageBlobContent -Container $Ctr -Context $Ctx -Force

Get-ChildItem –Path $Destination | Set-AzureStorageBlobContent -Container $Ctr -Context $Ctx -Force


# Test existence in AzStorage
# Get-AzureStorageBlob -Container $Ctr -Context $Ctx -Blob "20170522_YMCA Seattle Camp 2017.mdb"
# $Blob = "20170522_YMCA Seattle Camp 2017.mdb"
Write-Host "Checking test-path in Azure Storage."
Try {
    $blob_testpath = Get-AzureStorageBlob -Container $Ctr -Blob $FileName -Context $Ctx -ErrorAction Stop
    Write-Host "file exists in Azure Storage"
    $Body = $Body + "$FileName now exists in Azure Storage."
    }
Catch [Microsoft.WindowsAzure.Commands.Storage.Common.ResourceNotFoundException]
    { Write-Host "blob not found"
    $Body = "$SourceFile is not in Azure Storage."
    }

### Log action to YGSMonitor
Write-Host "Logging to YGSMonitor"
$SQLServer = "ygsmonitor.database.windows.net"
$SQLDBName = "ygsmonitor"
$Name = "CampBrain"
$MeasureName = "Upload to William3 and Azure Storage"
$MeasureValue = "Uploaded at $Now"
# $SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ('CampBrain Upload to AzStorage','','')"
# test this, 5/25/2017
$SQLQuery = "INSERT INTO MonitoringLog (Name, MeasureName, MeasureValue) VALUES ($Name,$MeasureName,$MeasureValue)"

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection

# First time create password file
# Assume the folder path is there because of the first password snippet. 
If (!(Test-Path $SQLPasswordPath))
    {Read-Host -AsSecureString | convertfrom-securestring | out-file $SQLPasswordPath}
$SQLPass = cat $SQLPasswordPath | ConvertTo-SecureString
$MySQLCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName, $SQLPass

# Change this to use $MySQLCred
$MySQLUserID = "ygsadmin"
$MySQLPwd = "4YouthDev909"
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $MySQLUserID; Password = $MySQLPwd;"
# User ID = $uid; Password = $pwd;
 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
 
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$SqlConnection.Close()
$DataSet.Tables[0]


# Write-Host "Sending email."
# Send email
# Problem: When this script is run via Task Scheduler, this cmdlet does not execute and it causes Task Scheduler to think the script is still running. 
# When this script is run manually, it sends the email and completes with no problem. 
<# send-mailmessage -from $From `
    -to $To `
    -subject $Subject `
    -body $Body `
    -smtpServer smtp.live.com `
    -useSSL `
    -Port 587 `
    -Credential $MyCred
#> 


