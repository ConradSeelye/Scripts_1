
Select-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"

# Get-AzureVM

<# Start VMs
Start-AzureVM -Name "William" -ServiceName "William-576dfki7"
Start-AzureVM -Name "William2" -ServiceName "william2"
Start-AzureVM -Name "YGSDWProd4" -ServiceName "YGSDWProd4"
#>

<# Stop VMs
Stop-AzureVM -Name "ygsdwprod4" -ServiceName "ygsdwprod4" -force
Stop-AzureVM -Name "William3" -ServiceName "william3" -force


#>



<# Az file download
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
$Dest = "C:\_temp\_test2"
$Ctr = "bi360"
$Blob = "test.txt"

Get-AzureStorageBlob -Container $Ctr -Blob $Blob -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination $Dest 

#>

<# Az file upload

$Ctr = "bi360"
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
$Path = "\\sqlcluster05\g$\MSSQL10_50.SQLTEST\MSSQL\DATA\BI360DW_20160713.bak"
Get-ChildItem –Path $Path | Set-AzureStorageBlobContent -Container $Ctr -Context $Ctx -Force

#>

<# Manage subscriptions
Get-AzureSubscription
Set-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"

Select-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"
Get-AzureVM

Select-AzureSubscription -SubscriptionName "Pay-As-You-Go"
Get-AzureVM
#>









