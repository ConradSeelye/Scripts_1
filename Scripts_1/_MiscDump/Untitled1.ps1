<#
Copy files between Azure Storage accounts
source: http://www.itprotoday.com/microsoft-azure/copy-content-one-azure-storage-account-another
date: 11/2/2017
notes: also between subs

#>


#Server side storage copy
$SourceStorageAccount = "ygsarchivesource1test"
$SourceStorageKey = "RsMCOQn8ajVF3quLu8PWJSGmcukoZe484/oaWNYAPGhw3uoyszwOTaAR3xhnQItJwi2rQOGY+K3Y/wk7l2je8g=="
$DestStorageAccount = "ygsarchivetest"
$DestStorageKey = "e4p9wQR2NQUKmLd2ffLwprJ6f/mk7xZ/Kv+BlnEFINDc+GChsdYpsq/0hWoZjausKASo6nmEf8BTS3+RkNSXtQ=="
$SourceStorageContainer = 'container1'
$DestStorageContainer = 'testcontainer1'
$SourceStorageContext = New-AzureStorageContext –StorageAccountName $SourceStorageAccount -StorageAccountKey $SourceStorageKey
$DestStorageContext = New-AzureStorageContext –StorageAccountName $DestStorageAccount -StorageAccountKey $DestStorageKey

$Blobs = Get-AzureStorageBlob -Context $SourceStorageContext -Container $SourceStorageContainer
$BlobCpyAry = @() #Create array of objects

#Do the copy of everything
foreach ($Blob in $Blobs)
{
   Write-Output "Moving $Blob.Name"
   $BlobCopy = Start-CopyAzureStorageBlob -Context $SourceStorageContext -SrcContainer $SourceStorageContainer -SrcBlob $Blob.Name `
      -DestContext $DestStorageContext -DestContainer $DestStorageContainer -DestBlob $Blob.Name
   $BlobCpyAry += $BlobCopy
}

#Check Status
foreach ($BlobCopy in $BlobCpyAry)
{
   #Could ignore all rest and just run $BlobCopy | Get-AzureStorageBlobCopyState but I prefer output with % copied
   $CopyState = $BlobCopy | Get-AzureStorageBlobCopyState
   $Message = $CopyState.Source.AbsolutePath + " " + $CopyState.Status + " {0:N2}%" -f (($CopyState.BytesCopied/$CopyState.TotalBytes)*100) 
   Write-Output $Message
}