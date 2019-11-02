<# Manage subscriptions
Select-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"
Get-AzureVM

Select-AzureSubscription -SubscriptionName "Pay-As-You-Go"
Get-AzureVM
#>

<# Start VMs
Get-AzureVM
Start-AzureVM -Name "BIDevSQLb" -ServiceName "bipdevsqlb"
Start-AzureVM -Name "BIDevSQLe" -ServiceName "ygsbi" 
Start-AzureVM -Name "ygsdwtest" -ServiceName "ygsdwtest" 
Start-AzureVM -Name "ygsdwdev" -ServiceName "ygsdwdev" 
Start-AzureVM -Name "ygsdwdev3" -ServiceName "ygsdwdev3"
Start-AzureVM -Name "ygsdwdev4" -ServiceName "ygsdwdev4" 
Start-AzureVM -Name "YGSDWProd4" -ServiceName "YGSDWProd4"
Start-AzureVM -Name "William" -ServiceName "William-576dfki7"
#>

<# Stop VMs
Select-AzureSubscription -SubscriptionName "Pay-As-You-Go"
Get-AzureVM
Stop-AzureVM -Name "BIDevSQLb" -ServiceName "bipdevsqlb" -force
Stop-AzureVM -Name "BIDevSQLe" -ServiceName "ygsbi" -force
Stop-AzureVM -Name "ygsdwdev" -ServiceName "ygsdwdev" -force
Stop-AzureVM -Name "ygsdwdev4" -ServiceName "ygsdwdev4" -force
Stop-AzureVM -Name "ygsdwtest" -ServiceName "ygsdwtest" -force
Stop-AzureVM -Name "ygsdwprod4" -ServiceName "ygsdwprod4" -force
Stop-AzureVM -Name "William" -ServiceName "William-576dfki7" -force
Stop-AzureVM -Name "YGSDWTest4" -ServiceName "YGSDWTest4" -force
#>


<# Az file download

$Ctr = "issuetrak"
$Dest = "\\stuart\f$\IssueTrak\IssueTrakBackups"
$Blob = "IssueTrak_20160427.bak"
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
# Get-AzureStorageBlob -Container active -Blob *20151210* -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination E:\activelive
Get-AzureStorageBlob -Container $Ctr -Blob $Blob -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination $Dest

#>

<# Az file upload

Clear-Host
$Ctr = "issuetrak"
$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
Get-ChildItem –Path "\\stuart\f$\IssueTrak\IssueTrakBackups\IssueTrak_20160427.bak" | Set-AzureStorageBlobContent -Container $Ctr -Context $Ctx -Force

#>











