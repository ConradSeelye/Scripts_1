<#
name: View available regions for Azure services using PowerShell
source: http://windowsitpro.com/azure/view-available-regions-azure-services-using-powershell
date: 7/25/2017

ToDo:
* adapt this to other Azure services
* get list of other services


#>


$resources = Get-AzureRmResourceProvider -ProviderNamespace Microsoft.Compute
$resources.ResourceTypes.Where{($_.ResourceTypeName -eq 'virtualMachines')}.Locations 



# Option 1:
# 1. Get the ResourceTypes 
$resources = Get-AzureRmResourceProvider -ProviderNamespace Microsoft.DataLakeStore
$resources

# 1.5 Get list of regions for the ProviderNameSpace
$resources = Get-AzureRmResourceProvider -ProviderNamespace Microsoft.DataLakeStore
$resources.ResourceTypes.Where{($_.ResourceTypeName -eq 'accounts')}.Locations 


# Option 2:
# 1. Get regions for the ProviderNameSpace and ResourceTypeName
$ProviderNameSpace = 'Microsoft.DataLakeStore'
$ResourceTypeName = 'accounts'

$resources = Get-AzureRmResourceProvider -ProviderNamespace $ProviderNamespace
$resources.ResourceTypes.Where{($_.ResourceTypeName -eq $ResourceTypeName)}.Locations 


# Gets the available data center locations for the current Azure subscription. 
clear-host
$MyRegions = Get-AzureLocation 
$MyRegions.DisplayName


# List regions
get-azurelocation | Format-Table





# edit
break here

<#
get-help get-azurermresource -Full

get-azurermresource 

Clear-Host
Get-AzureRmResourceProvider

# gives too much
$resources = Get-AzureRmResourceProvider -ProviderNamespace Microsoft.DataLakeStore
$resources
#>



