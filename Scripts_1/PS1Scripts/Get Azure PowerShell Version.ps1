
<#
Azure PowerShell cmdlets version updates
https://social.technet.microsoft.com/wiki/contents/articles/31127.azure-powershell-cmdlets-version-updates.aspx
Date: 6/27/2017
Notes:
This worked on 6/27/2017
    output:
        Version           : 0.9.8.1
        Name              : Azure
        Author            : Microsoft Corporation
        PowerShellVersion : 3.0


#>


(Get-Module -ListAvailable | Where-Object{ $_.Name -eq 'Azure' }) `
| Select Version, Name, Author, PowerShellVersion  | Format-List;


