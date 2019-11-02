<#
Adhoc Azure Storage file download
as of 6/16/2016
context: YGS Main sub

#>


$Ctx = New-AzureStorageContext –StorageAccountName "ygsdw" -StorageAccountKey "2lhy78sA3Z8Lht5peK8wqSdiAu4WkPNQ/RDBMg55ZcPgORrmus156YhpYUfqfEW25a8trp3j8REMKVOns54NWQ=="
$Dest = "C:\Users\cseelye\Downloads"
$Ctr = "active"
$Blob = "*20161103*.bak"

Get-AzureStorageBlob -Container $Ctr -Blob $Blob -Context $Ctx | Get-AzureStorageBlobContent -Context $Ctx -Destination $Dest 
