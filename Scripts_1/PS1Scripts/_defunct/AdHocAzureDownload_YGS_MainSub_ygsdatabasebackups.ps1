<#
Adhoc Azure Storage file download
as of 6/16/2016
context: YGS Main sub

#>


# Main Sub, ygsdatabasebackups
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdatabasebackups" -StorageAccountKey "GfgHf8AuUuRWy7DSWCPq6rHre0Y/7ercbPCLhA63lp1v92CKd2X5U0uHvZ6iWeHfFHemYfQVLN+W69c4Cq4yAQ=="
$Dest = "\\defender\g$\MountedDrives\GPSQL-Bkup"
$Ctr = "bi360"
$Blob = "BI36020170723.bak"

Get-AzureStorageBlob -Container $Ctr -Blob $Blob -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination $Dest 


# Main Sub, YGSGP, 
$Ctx = New-AzureStorageContext –StorageAccountName "ygsgp" `
    -StorageAccountKey "9mEa4cHmHYeU0qWtIszsiDjGOi5QTWg54NYt0JK1YW2wQJnjdzb9hGefhbNQJRT05Kg93Qw71Un5ueUkeh0ELA=="
$Dest = "F:\SQL\SQL_Data\GP"
$Ctr = "ymcafull"
$Blob = "DEFENDER_YMCA_FULL_20170628_230000.bak"

Get-AzureStorageBlob -Container $Ctr -Blob $Blob -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination $Dest 


# PAYG Sub, ygsdw
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
$Dest = "C:\Users\cseelye\Downloads"
$Ctr = "active"
$Blob = "*20161103*.bak"

Get-AzureStorageBlob -Container $Ctr -Blob $Blob -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination $Dest 
