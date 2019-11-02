<#
Upload BI360 from SQLCluster03 to Az Storage.
Date: 8/9/2017
Author: Conrad
Notes:
This is part of the BI360 daily update for BI 2.0. 

Notes:
* added keys for 3 main storage accounts

ToDo:
* add error handling
* add logging 
* add alerting of problems

#>

Clear-Host

$localFolder = "C:\_MyTemp2"
# Get wildcard file name based on today's date
# $dateFormat = get-date -format yyyyMMdd
# $filenameWildcard = "BI360" + $dateformat + "*.bak"
$filenameWildcard = "*"
$Ctr = "conradtemp"

# ygsdw (Pay-As-You-Go)
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="

# ygsdatabasebackups (Seattle YMCA Main Subscription)
# $Ctx = New-AzureStorageContext –StorageAccountName "ygsdatabasebackups" -StorageAccountKey "GfgHf8AuUuRWy7DSWCPq6rHre0Y/7ercbPCLhA63lp1v92CKd2X5U0uHvZ6iWeHfFHemYfQVLN+W69c4Cq4yAQ=="

# ygsgp (Seattle YMCA Main Subscription)
# $Ctx = New-AzureStorageContext –StorageAccountName "ygsgp" -StorageAccountKey "9mEa4cHmHYeU0qWtIszsiDjGOi5QTWg54NYt0JK1YW2wQJnjdzb9hGefhbNQJRT05Kg93Qw71Un5ueUkeh0ELA=="


# $Path = "\\sqlcluster03\o$\Program Files\Microsoft SQL Server\MSSQL10_50.BUDGET\MSSQL\Backup\DailyBI360BU\BI36020160421.bak"
$Path = $localFolder + "\" + $filenameWildcard
Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Ctr -Context $Ctx -Force

# delete all files in the target folder (optional)
# get-childitem $localFolder | remove-item -force -Recurse



