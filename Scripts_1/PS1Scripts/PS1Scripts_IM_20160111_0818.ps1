<# Manage subscriptions
Select-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"
Get-AzureVM

Select-AzureSubscription -SubscriptionName "Pay-As-You-Go"
Get-AzureVM

Select-AzureSubscription -SubscriptionName "ConradIM"
Get-AzureVM
#>

<# Start VMs
Get-AzureVM

#>

<# Stop VMs

#>

<# Az file download

#>

<# Az file upload
$Ctr = "20160116girlscoutcookies"
$Ctx = New-AzureStorageContext –StorageAccountName "cbsphotos" -StorageAccountKey "G9gwVeDLOs45CrT8QWhPZwixbT7iWqNfR3IqJQeD264ySlWFIyBSk86xzsmMqhSvGP2Xbur9wIMBuBlxBbXEpQ=="
Get-ChildItem –Path "C:\Users\cseelye\Pictures\20160116 Girl Scout Cookies\*" | Set-AzureStorageBlobContent -Container $Ctr -Context $Ctx -Force


#>











