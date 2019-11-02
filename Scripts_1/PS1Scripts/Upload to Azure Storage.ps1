<#
Adhoc Azure Storage file upload
as of 8/17/2016
context: YGS Main sub and Pay As You Go sub

#>
# break

throw "Stop!  Don't run the whole script.  Just run selections. "

# template 1
$Context = New-AzureStorageContext –StorageAccountName "ygsdw" `
    -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
$Path = "C:\_MyTemp2\test - Copy.txt"
$Container = "test"

Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Container -Context $Context -Force


# Pay As You Go subscription
# ygsdw account
$Context = New-AzureStorageContext –StorageAccountName "ygsdw" `
    -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
$Path = "E:\Active_temp\Servlet.SeattleYMCA_db_20171023.bak"
$Container = "active"

Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Container -Context $Context -Force

# Seattle YMCA Main Subscription, ygsdatabasebackups
$Context = New-AzureStorageContext –StorageAccountName "ygsdatabasebackups" `
    -StorageAccountKey "GfgHf8AuUuRWy7DSWCPq6rHre0Y/7ercbPCLhA63lp1v92CKd2X5U0uHvZ6iWeHfFHemYfQVLN+W69c4Cq4yAQ=="
$Path = "C:\_MyTemp2\test - Copy.txt"
$Container = "test"

Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Container -Context $Context -Force


# Seattle YMCA Main Subscription, YGSGP
$Context = New-AzureStorageContext –StorageAccountName "ygsgp" `
    -StorageAccountKey "9mEa4cHmHYeU0qWtIszsiDjGOi5QTWg54NYt0JK1YW2wQJnjdzb9hGefhbNQJRT05Kg93Qw71Un5ueUkeh0ELA=="
$Path = "C:\_MyTemp2\test - Copy.txt"
$Container = "test"

Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Container -Context $Context -Force


# Seattle YMCA Main Subscription, ygssoftware
$Context = New-AzureStorageContext –StorageAccountName "ygssoftware" `
    -StorageAccountKey "wMXwFpHkQAJWFY9CcvGig2sAUiaeqBcO798Xb4KC/xpEkH2w8lO6yp6ARGaQeayhYW4lVOeZw55o2bWoJS00tA=="
$Path = "C:\Users\cseelye\Downloads\WinAutomationSetup.exe"
$Container = "ygssoftware"

Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Container -Context $Context -Force




